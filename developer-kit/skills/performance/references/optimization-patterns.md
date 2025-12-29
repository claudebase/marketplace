# Performance Optimization Patterns

## Database Optimization

### N+1 Query Problem
```javascript
// BAD: N+1 queries
const users = await User.findAll();
for (const user of users) {
  user.orders = await Order.findAll({ where: { userId: user.id } });
}
// 1 query for users + N queries for orders

// GOOD: Eager loading
const users = await User.findAll({
  include: [{ model: Order }]
});
// 1 query with JOIN
```

### Query Optimization
```sql
-- Add indexes for frequently queried columns
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_orders_user_date ON orders(user_id, created_at);

-- Use covering indexes
CREATE INDEX idx_orders_summary ON orders(user_id, status, total);

-- Avoid SELECT *
SELECT id, name, email FROM users WHERE status = 'active';
```

### Connection Pooling
```javascript
// Node.js with pg
const { Pool } = require('pg');
const pool = new Pool({
  max: 20,           // Maximum connections
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000,
});
```

## Caching Strategies

### Cache Aside Pattern
```javascript
async function getUser(id) {
  // Check cache first
  let user = await cache.get(`user:${id}`);
  if (user) return user;

  // Cache miss - fetch from DB
  user = await db.users.findById(id);

  // Store in cache
  await cache.set(`user:${id}`, user, { ttl: 3600 });
  return user;
}
```

### Cache Invalidation
```javascript
// Invalidate on update
async function updateUser(id, data) {
  await db.users.update(id, data);
  await cache.delete(`user:${id}`);
  await cache.delete(`users:list`);  // Related cache
}
```

### Response Caching
```javascript
// Express middleware
const cacheMiddleware = (duration) => (req, res, next) => {
  const key = `__cache__${req.originalUrl}`;
  const cached = cache.get(key);

  if (cached) {
    return res.json(cached);
  }

  res.originalJson = res.json;
  res.json = (body) => {
    cache.set(key, body, duration);
    res.originalJson(body);
  };
  next();
};
```

## Frontend Optimization

### Bundle Splitting
```javascript
// Dynamic imports for code splitting
const Dashboard = React.lazy(() => import('./Dashboard'));

// Route-based splitting
const routes = [
  {
    path: '/dashboard',
    component: React.lazy(() => import('./pages/Dashboard')),
  },
];
```

### Image Optimization
```html
<!-- Responsive images -->
<img
  srcset="image-320.jpg 320w, image-640.jpg 640w, image-1280.jpg 1280w"
  sizes="(max-width: 320px) 280px, (max-width: 640px) 600px, 1200px"
  src="image-1280.jpg"
  alt="Description"
  loading="lazy"
/>

<!-- Modern formats -->
<picture>
  <source srcset="image.avif" type="image/avif">
  <source srcset="image.webp" type="image/webp">
  <img src="image.jpg" alt="Description">
</picture>
```

### Memoization
```javascript
// React useMemo for expensive calculations
const expensiveResult = useMemo(() => {
  return expensiveCalculation(data);
}, [data]);

// React.memo for component re-renders
const MemoizedComponent = React.memo(({ data }) => {
  return <div>{data.value}</div>;
});
```

## Algorithm Optimization

### Time Complexity Improvements
```javascript
// O(n²) → O(n) with Set
// BAD
function hasDuplicates(arr) {
  for (let i = 0; i < arr.length; i++) {
    for (let j = i + 1; j < arr.length; j++) {
      if (arr[i] === arr[j]) return true;
    }
  }
  return false;
}

// GOOD
function hasDuplicates(arr) {
  return new Set(arr).size !== arr.length;
}
```

### Lazy Evaluation
```javascript
// Eager (all at once)
const results = data.filter(x => x > 0).map(x => x * 2);

// Lazy (on demand)
function* filterAndMap(data) {
  for (const x of data) {
    if (x > 0) yield x * 2;
  }
}
```

## Network Optimization

### Compression
```javascript
// Express with compression
const compression = require('compression');
app.use(compression());
```

### HTTP/2 and Multiplexing
```nginx
# nginx config
server {
    listen 443 ssl http2;
    ssl_certificate /path/to/cert.pem;
    ssl_certificate_key /path/to/key.pem;
}
```

### Request Batching
```javascript
// DataLoader pattern
const userLoader = new DataLoader(async (ids) => {
  const users = await db.users.findByIds(ids);
  return ids.map(id => users.find(u => u.id === id));
});

// Multiple calls batched into one
const user1 = await userLoader.load(1);
const user2 = await userLoader.load(2);
```

## Memory Optimization

### Streaming
```javascript
// BAD: Load entire file into memory
const data = fs.readFileSync('large-file.json');

// GOOD: Stream processing
const stream = fs.createReadStream('large-file.json');
stream.pipe(parser).pipe(transformer).pipe(output);
```

### Object Pooling
```javascript
class ObjectPool {
  constructor(create, reset, size = 10) {
    this.pool = Array(size).fill(null).map(create);
    this.reset = reset;
  }

  acquire() {
    return this.pool.pop() || this.create();
  }

  release(obj) {
    this.reset(obj);
    this.pool.push(obj);
  }
}
```

## Quick Wins Checklist

### Immediate Impact
- [ ] Add database indexes on queried columns
- [ ] Enable gzip/brotli compression
- [ ] Add Cache-Control headers
- [ ] Lazy load images below fold
- [ ] Eliminate N+1 queries

### Medium Effort
- [ ] Implement caching layer (Redis)
- [ ] Code splitting for JavaScript
- [ ] Connection pooling for databases
- [ ] CDN for static assets

### Larger Improvements
- [ ] Async processing for heavy operations
- [ ] Database query optimization
- [ ] Architecture changes (microservices, queues)
