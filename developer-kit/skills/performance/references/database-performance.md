# Database Performance Reference

## Query Analysis

### EXPLAIN ANALYZE (PostgreSQL)

```sql
EXPLAIN (ANALYZE, BUFFERS, FORMAT TEXT)
SELECT u.*, COUNT(o.id) as order_count
FROM users u
LEFT JOIN orders o ON o.user_id = u.id
WHERE u.created_at > '2024-01-01'
GROUP BY u.id;
```

**Key metrics to watch:**
- **Seq Scan** - Full table scan (often bad)
- **Index Scan** - Using index (good)
- **Nested Loop** - O(n*m) complexity
- **Hash Join** - O(n+m) complexity (usually better)
- **Buffers: shared hit** - Data from cache
- **Buffers: shared read** - Data from disk

### Query Plan Analysis

```
Aggregate  (cost=1234.56..1234.78 rows=100 width=40) (actual time=12.345..12.456 rows=100 loops=1)
  ->  Hash Join  (cost=100.00..1000.00 rows=5000 width=32) (actual time=1.234..10.567 rows=5000 loops=1)
        Hash Cond: (o.user_id = u.id)
        ->  Seq Scan on orders o  (cost=0.00..500.00 rows=10000 width=16) (actual time=0.012..5.678 rows=10000 loops=1)
        ->  Hash  (cost=80.00..80.00 rows=1000 width=16) (actual time=0.789..0.789 rows=1000 loops=1)
              ->  Index Scan using idx_users_created on users u  (cost=0.00..80.00 rows=1000 width=16)
                    Filter: (created_at > '2024-01-01')
```

## Indexing Strategies

### Single Column Index

```sql
-- For exact matches and range queries
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_orders_created ON orders(created_at);

-- Query benefits
SELECT * FROM users WHERE email = 'user@example.com';
SELECT * FROM orders WHERE created_at > '2024-01-01';
```

### Composite Index

```sql
-- Column order matters! Left-to-right usage
CREATE INDEX idx_orders_user_status ON orders(user_id, status);

-- Uses index (both columns)
SELECT * FROM orders WHERE user_id = 123 AND status = 'pending';

-- Uses index (first column)
SELECT * FROM orders WHERE user_id = 123;

-- Does NOT use index efficiently
SELECT * FROM orders WHERE status = 'pending';
```

### Covering Index (Include)

```sql
-- Include columns in index to avoid table lookup
CREATE INDEX idx_orders_user_covering
ON orders(user_id)
INCLUDE (status, total, created_at);

-- Index-only scan possible
SELECT status, total, created_at
FROM orders
WHERE user_id = 123;
```

### Partial Index

```sql
-- Index only relevant rows
CREATE INDEX idx_orders_pending
ON orders(created_at)
WHERE status = 'pending';

-- Smaller index, faster queries for pending orders
SELECT * FROM orders WHERE status = 'pending' AND created_at > '2024-01-01';
```

### Expression Index

```sql
-- Index on computed expression
CREATE INDEX idx_users_email_lower ON users(LOWER(email));

-- Query must match expression exactly
SELECT * FROM users WHERE LOWER(email) = 'user@example.com';
```

## Query Optimization Patterns

### Pagination

```sql
-- BAD: OFFSET for large datasets
SELECT * FROM products ORDER BY id LIMIT 20 OFFSET 10000;
-- Scans 10,020 rows to return 20

-- GOOD: Keyset pagination
SELECT * FROM products
WHERE id > 10000
ORDER BY id
LIMIT 20;
-- Scans only 20 rows using index
```

### Avoid SELECT *

```sql
-- BAD: Fetches all columns
SELECT * FROM users WHERE id = 123;

-- GOOD: Only needed columns
SELECT id, email, name FROM users WHERE id = 123;
```

### Batch Operations

```sql
-- BAD: Individual inserts
INSERT INTO logs (message) VALUES ('log1');
INSERT INTO logs (message) VALUES ('log2');
-- 1000 round trips for 1000 rows

-- GOOD: Batch insert
INSERT INTO logs (message) VALUES
  ('log1'),
  ('log2'),
  -- ...
  ('log1000');
-- 1 round trip for 1000 rows
```

### EXISTS vs IN

```sql
-- IN subquery - builds full result set
SELECT * FROM users
WHERE id IN (SELECT user_id FROM orders WHERE total > 100);

-- EXISTS - stops at first match (often faster)
SELECT * FROM users u
WHERE EXISTS (
  SELECT 1 FROM orders o
  WHERE o.user_id = u.id AND o.total > 100
);
```

### Avoiding N+1 Queries

```javascript
// BAD: N+1 queries
const users = await db.query('SELECT * FROM users');
for (const user of users) {
  user.orders = await db.query('SELECT * FROM orders WHERE user_id = ?', [user.id]);
}

// GOOD: Single query with JOIN
const usersWithOrders = await db.query(`
  SELECT u.*, json_agg(o.*) as orders
  FROM users u
  LEFT JOIN orders o ON o.user_id = u.id
  GROUP BY u.id
`);

// Or use ORM eager loading
const users = await User.findAll({
  include: [{ model: Order }]
});
```

## Connection Pooling

### PostgreSQL with pg-pool

```javascript
const { Pool } = require('pg');

const pool = new Pool({
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  max: 20,                  // Max connections
  idleTimeoutMillis: 30000, // Close idle after 30s
  connectionTimeoutMillis: 2000 // Connection timeout
});

// Use pool for queries
const result = await pool.query('SELECT * FROM users WHERE id = $1', [userId]);
```

### Pool Sizing

```
Optimal connections = (core_count * 2) + effective_spindle_count

For SSD: core_count * 2 + 1
For HDD: core_count * 2 + disk_count
```

## Read Replicas

```javascript
const masterPool = new Pool({ host: 'master.db.example.com' });
const replicaPool = new Pool({ host: 'replica.db.example.com' });

class Database {
  async query(sql, params, { readOnly = false } = {}) {
    const pool = readOnly ? replicaPool : masterPool;
    return pool.query(sql, params);
  }
}

// Usage
await db.query('INSERT INTO users ...', params); // Goes to master
await db.query('SELECT * FROM users', [], { readOnly: true }); // Goes to replica
```

## Database-Specific Optimizations

### PostgreSQL

```sql
-- Analyze tables for query planner
ANALYZE users;

-- Vacuum to reclaim space
VACUUM ANALYZE users;

-- Monitor slow queries
ALTER SYSTEM SET log_min_duration_statement = 1000; -- Log queries > 1s

-- Check index usage
SELECT
  schemaname, tablename, indexname, idx_scan, idx_tup_read
FROM pg_stat_user_indexes
ORDER BY idx_scan ASC;

-- Find missing indexes
SELECT
  relname, seq_scan, idx_scan,
  CASE WHEN seq_scan > 0 THEN idx_scan::float / seq_scan ELSE 0 END AS ratio
FROM pg_stat_user_tables
WHERE seq_scan > 1000
ORDER BY ratio ASC;
```

### MySQL

```sql
-- Enable slow query log
SET GLOBAL slow_query_log = 'ON';
SET GLOBAL long_query_time = 1;

-- Optimize table
OPTIMIZE TABLE users;

-- Force index usage
SELECT * FROM orders FORCE INDEX (idx_user_id) WHERE user_id = 123;

-- Check query cache (MySQL 5.7)
SHOW STATUS LIKE 'Qcache%';
```

### MongoDB

```javascript
// Create index
db.users.createIndex({ email: 1 }, { unique: true });

// Compound index
db.orders.createIndex({ userId: 1, createdAt: -1 });

// Explain query
db.users.find({ email: 'test@example.com' }).explain('executionStats');

// Index usage stats
db.users.aggregate([{ $indexStats: {} }]);
```

## Monitoring Queries

### Slow Query Detection

```sql
-- PostgreSQL: Find slow queries
SELECT
  query,
  calls,
  mean_time,
  total_time,
  rows
FROM pg_stat_statements
ORDER BY mean_time DESC
LIMIT 10;

-- Active long-running queries
SELECT
  pid,
  now() - query_start AS duration,
  query,
  state
FROM pg_stat_activity
WHERE state != 'idle'
  AND now() - query_start > interval '5 seconds'
ORDER BY duration DESC;
```

### Connection Monitoring

```sql
-- PostgreSQL: Connection stats
SELECT
  datname,
  numbackends as connections,
  xact_commit,
  xact_rollback,
  blks_read,
  blks_hit,
  ROUND(blks_hit * 100.0 / NULLIF(blks_hit + blks_read, 0), 2) as cache_hit_ratio
FROM pg_stat_database
WHERE datname = current_database();
```

## Performance Checklist

| Area | Check | Status |
|------|-------|--------|
| Indexes | Indexes on WHERE, JOIN, ORDER BY columns | [ ] |
| Queries | No SELECT *, use specific columns | [ ] |
| Pagination | Keyset pagination for large datasets | [ ] |
| Batching | Batch inserts/updates | [ ] |
| N+1 | No N+1 queries, use JOINs or eager loading | [ ] |
| Pooling | Connection pool configured | [ ] |
| Replicas | Read replicas for read-heavy workloads | [ ] |
| Monitoring | Slow query logging enabled | [ ] |
| Maintenance | Regular VACUUM/ANALYZE | [ ] |
