# Caching Strategies Reference

## Caching Layers

```
┌──────────────────────────────────────────────────────────────┐
│                        Client                                 │
│  ┌──────────────────────────────────────────────────────┐    │
│  │              Browser Cache (HTTP Cache)               │    │
│  └──────────────────────────────────────────────────────┘    │
└──────────────────────────────────────────────────────────────┘
                              │
┌──────────────────────────────────────────────────────────────┐
│                          CDN                                  │
│  ┌──────────────────────────────────────────────────────┐    │
│  │              Edge Cache (CloudFlare, etc.)            │    │
│  └──────────────────────────────────────────────────────┘    │
└──────────────────────────────────────────────────────────────┘
                              │
┌──────────────────────────────────────────────────────────────┐
│                      Application                              │
│  ┌────────────────┐  ┌────────────────┐  ┌────────────────┐  │
│  │  In-Memory     │  │  Distributed   │  │    Database    │  │
│  │  (local cache) │  │  (Redis)       │  │    (query)     │  │
│  └────────────────┘  └────────────────┘  └────────────────┘  │
└──────────────────────────────────────────────────────────────┘
```

## Cache-Aside Pattern

Application manages cache explicitly.

```javascript
class UserService {
  constructor(cache, database) {
    this.cache = cache;
    this.database = database;
    this.TTL = 3600; // 1 hour
  }

  async getUser(userId) {
    const cacheKey = `user:${userId}`;

    // 1. Try cache first
    let user = await this.cache.get(cacheKey);
    if (user) {
      return JSON.parse(user);
    }

    // 2. Cache miss - fetch from database
    user = await this.database.users.findById(userId);
    if (!user) {
      return null;
    }

    // 3. Populate cache
    await this.cache.setex(cacheKey, this.TTL, JSON.stringify(user));

    return user;
  }

  async updateUser(userId, data) {
    // 1. Update database
    const user = await this.database.users.update(userId, data);

    // 2. Invalidate cache
    await this.cache.del(`user:${userId}`);

    return user;
  }
}
```

## Write-Through Pattern

Cache is updated synchronously with database.

```javascript
class WriteThoughCache {
  async set(key, value, ttl) {
    // Write to database first
    await this.database.set(key, value);

    // Then update cache
    await this.cache.setex(key, ttl, JSON.stringify(value));
  }

  async get(key) {
    // Always try cache first
    const cached = await this.cache.get(key);
    if (cached) {
      return JSON.parse(cached);
    }

    // Fallback to database
    const value = await this.database.get(key);
    if (value) {
      await this.cache.setex(key, this.TTL, JSON.stringify(value));
    }
    return value;
  }
}
```

## Write-Behind (Write-Back) Pattern

Asynchronous database writes for better performance.

```javascript
class WriteBehindCache {
  constructor() {
    this.writeQueue = [];
    this.flushInterval = 5000; // 5 seconds

    setInterval(() => this.flush(), this.flushInterval);
  }

  async set(key, value) {
    // Update cache immediately
    await this.cache.setex(key, this.TTL, JSON.stringify(value));

    // Queue database write
    this.writeQueue.push({ key, value, timestamp: Date.now() });
  }

  async flush() {
    const batch = this.writeQueue.splice(0, 100);
    if (batch.length === 0) return;

    try {
      await this.database.batchWrite(batch);
    } catch (error) {
      // Re-queue failed writes
      this.writeQueue.unshift(...batch);
      console.error('Write-behind flush failed:', error);
    }
  }
}
```

## Redis Caching

### Basic Operations

```javascript
const Redis = require('ioredis');
const redis = new Redis(process.env.REDIS_URL);

// String operations
await redis.set('key', 'value');
await redis.setex('key', 3600, 'value'); // With TTL
const value = await redis.get('key');

// Hash operations (for objects)
await redis.hset('user:123', 'name', 'John', 'email', 'john@example.com');
const user = await redis.hgetall('user:123');

// List operations
await redis.lpush('queue', 'item1', 'item2');
const item = await redis.rpop('queue');

// Set operations
await redis.sadd('tags:article:1', 'tech', 'news');
const tags = await redis.smembers('tags:article:1');

// Sorted set (for leaderboards, rankings)
await redis.zadd('leaderboard', 100, 'player1', 200, 'player2');
const top10 = await redis.zrevrange('leaderboard', 0, 9, 'WITHSCORES');
```

### Caching Patterns

```javascript
// Cache with automatic refresh
class RefreshAheadCache {
  constructor(redis, refreshThreshold = 0.8) {
    this.redis = redis;
    this.refreshThreshold = refreshThreshold;
  }

  async get(key, ttl, fetchFn) {
    const data = await this.redis.get(key);
    const remainingTtl = await this.redis.ttl(key);

    if (data) {
      // Refresh if TTL below threshold
      if (remainingTtl < ttl * (1 - this.refreshThreshold)) {
        this.refresh(key, ttl, fetchFn); // Don't await
      }
      return JSON.parse(data);
    }

    // Cache miss
    const value = await fetchFn();
    await this.redis.setex(key, ttl, JSON.stringify(value));
    return value;
  }

  async refresh(key, ttl, fetchFn) {
    try {
      const value = await fetchFn();
      await this.redis.setex(key, ttl, JSON.stringify(value));
    } catch (error) {
      console.error('Refresh failed:', error);
    }
  }
}
```

### Cache Stampede Prevention

```javascript
// Using Redis distributed lock
async function getWithLock(key, ttl, fetchFn) {
  const cached = await redis.get(key);
  if (cached) return JSON.parse(cached);

  const lockKey = `lock:${key}`;
  const lockAcquired = await redis.set(lockKey, '1', 'NX', 'EX', 30);

  if (lockAcquired) {
    try {
      const value = await fetchFn();
      await redis.setex(key, ttl, JSON.stringify(value));
      return value;
    } finally {
      await redis.del(lockKey);
    }
  } else {
    // Wait and retry
    await new Promise(resolve => setTimeout(resolve, 100));
    return getWithLock(key, ttl, fetchFn);
  }
}
```

## In-Memory Caching

### Node.js with node-cache

```javascript
const NodeCache = require('node-cache');

const cache = new NodeCache({
  stdTTL: 600,        // 10 minutes default
  checkperiod: 120,   // Check for expired every 2 min
  maxKeys: 1000       // Max entries
});

// Usage
cache.set('key', value);
const data = cache.get('key');
cache.del('key');

// With TTL
cache.set('key', value, 3600); // 1 hour
```

### LRU Cache

```javascript
const LRU = require('lru-cache');

const cache = new LRU({
  max: 500,              // Max items
  maxAge: 1000 * 60 * 5, // 5 minutes
  updateAgeOnGet: true   // Reset TTL on access
});

cache.set('key', value);
const data = cache.get('key');
cache.has('key');
cache.delete('key');
```

## HTTP Caching Headers

### Cache-Control

```javascript
// Express middleware for static assets
app.use('/assets', express.static('public', {
  maxAge: '1y',
  immutable: true
}));

// API response caching
app.get('/api/data', (req, res) => {
  res.set('Cache-Control', 'public, max-age=300'); // 5 minutes
  res.json(data);
});

// Private cache (user-specific)
app.get('/api/profile', (req, res) => {
  res.set('Cache-Control', 'private, max-age=60');
  res.json(profile);
});

// No caching
app.get('/api/sensitive', (req, res) => {
  res.set('Cache-Control', 'no-store');
  res.json(sensitiveData);
});
```

### ETag for Conditional Requests

```javascript
const crypto = require('crypto');

app.get('/api/resource/:id', async (req, res) => {
  const resource = await getResource(req.params.id);
  const etag = crypto
    .createHash('md5')
    .update(JSON.stringify(resource))
    .digest('hex');

  // Check If-None-Match header
  if (req.headers['if-none-match'] === etag) {
    return res.status(304).end();
  }

  res.set('ETag', etag);
  res.set('Cache-Control', 'private, max-age=0, must-revalidate');
  res.json(resource);
});
```

## Cache Invalidation Strategies

### Time-Based (TTL)

```javascript
// Simple TTL
await redis.setex(key, 3600, value);

// Sliding expiration
await redis.expire(key, 3600); // Reset on access
```

### Event-Based

```javascript
// Pub/Sub for cache invalidation
const publisher = new Redis();
const subscriber = new Redis();

// Publisher (on data change)
async function invalidateCache(entity, id) {
  await publisher.publish('cache:invalidate', JSON.stringify({ entity, id }));
}

// Subscriber (all app instances)
subscriber.subscribe('cache:invalidate');
subscriber.on('message', async (channel, message) => {
  const { entity, id } = JSON.parse(message);
  await localCache.del(`${entity}:${id}`);
});
```

### Tag-Based

```javascript
class TaggedCache {
  async set(key, value, tags, ttl) {
    await this.redis.setex(key, ttl, JSON.stringify(value));

    // Associate key with tags
    for (const tag of tags) {
      await this.redis.sadd(`tag:${tag}`, key);
    }
  }

  async invalidateByTag(tag) {
    const keys = await this.redis.smembers(`tag:${tag}`);
    if (keys.length > 0) {
      await this.redis.del(...keys);
      await this.redis.del(`tag:${tag}`);
    }
  }
}

// Usage
await cache.set('product:123', product, ['products', 'category:electronics'], 3600);
await cache.invalidateByTag('category:electronics'); // Invalidates all electronics products
```

## Cache Metrics

```javascript
class MetricsCache {
  constructor(cache) {
    this.cache = cache;
    this.hits = 0;
    this.misses = 0;
  }

  async get(key) {
    const value = await this.cache.get(key);
    if (value) {
      this.hits++;
    } else {
      this.misses++;
    }
    return value;
  }

  getHitRate() {
    const total = this.hits + this.misses;
    return total > 0 ? this.hits / total : 0;
  }

  getStats() {
    return {
      hits: this.hits,
      misses: this.misses,
      hitRate: this.getHitRate(),
      total: this.hits + this.misses
    };
  }
}
```

## Best Practices

| Practice | Description |
|----------|-------------|
| Use consistent key naming | `entity:id:field` format |
| Set appropriate TTLs | Balance freshness vs performance |
| Handle cache failures gracefully | Fall back to source |
| Monitor hit rates | Target 80%+ for hot data |
| Avoid caching large objects | Keep entries < 1MB |
| Use compression for large values | gzip/snappy |
| Implement circuit breakers | Prevent cascade failures |
| Pre-warm critical caches | On deployment/startup |
