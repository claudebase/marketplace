# Query Optimization Reference

## EXPLAIN ANALYZE

### Reading Execution Plans

```sql
EXPLAIN (ANALYZE, BUFFERS, FORMAT TEXT)
SELECT * FROM orders WHERE user_id = 123;

-- Output interpretation:
-- Seq Scan: Full table scan (often bad for large tables)
-- Index Scan: Using index (good)
-- Index Only Scan: Getting data from index alone (best)
-- Bitmap Index Scan: Building bitmap from index, then scanning
-- Nested Loop: Joining by looping (good for small datasets)
-- Hash Join: Building hash table for join (good for medium datasets)
-- Merge Join: Sorted merge (good for large sorted datasets)
```

### Common Issues

```sql
-- Bad: Seq Scan on large table
EXPLAIN ANALYZE SELECT * FROM orders WHERE status = 'pending';
-- Fix: Add index
CREATE INDEX idx_orders_status ON orders(status);

-- Bad: Function on indexed column prevents index use
EXPLAIN ANALYZE SELECT * FROM users WHERE LOWER(email) = 'user@example.com';
-- Fix: Expression index
CREATE INDEX idx_users_email_lower ON users(LOWER(email));

-- Bad: Type mismatch
EXPLAIN ANALYZE SELECT * FROM orders WHERE id = '123';  -- id is INT
-- Fix: Use correct type
SELECT * FROM orders WHERE id = 123;
```

## Index Optimization

### When to Create Indexes

```sql
-- Columns in WHERE clauses
CREATE INDEX idx_orders_status ON orders(status);

-- Columns in JOIN conditions
CREATE INDEX idx_order_items_order_id ON order_items(order_id);

-- Columns in ORDER BY
CREATE INDEX idx_orders_created_at ON orders(created_at DESC);

-- Composite indexes for multi-column queries
-- Column order matters! Most selective first, or match query order
CREATE INDEX idx_orders_user_status ON orders(user_id, status);

-- Partial indexes for filtered queries
CREATE INDEX idx_pending_orders ON orders(created_at)
WHERE status = 'pending';
```

### Index Types

```sql
-- B-tree (default): Equality and range queries
CREATE INDEX idx_btree ON table(column);

-- Hash: Equality only, faster than B-tree for equality
CREATE INDEX idx_hash ON table USING HASH (column);

-- GIN: Arrays, JSONB, full-text search
CREATE INDEX idx_gin ON products USING GIN (tags);
CREATE INDEX idx_gin_jsonb ON products USING GIN (attributes jsonb_path_ops);

-- GiST: Geometric, range types, full-text
CREATE INDEX idx_gist ON locations USING GIST (coordinates);

-- BRIN: Very large tables with natural ordering
CREATE INDEX idx_brin ON logs USING BRIN (created_at);
```

## Query Patterns

### Pagination

```sql
-- Offset pagination (simple but slow for large offsets)
SELECT * FROM orders
ORDER BY created_at DESC
LIMIT 20 OFFSET 1000;  -- Scans 1020 rows

-- Keyset pagination (fast, consistent)
SELECT * FROM orders
WHERE created_at < '2024-01-15T10:30:00Z'
ORDER BY created_at DESC
LIMIT 20;

-- With tie-breaker for non-unique sort column
SELECT * FROM orders
WHERE (created_at, id) < ('2024-01-15T10:30:00Z', 'abc-123')
ORDER BY created_at DESC, id DESC
LIMIT 20;
```

### Avoiding N+1 Queries

```sql
-- Bad: N+1 queries
-- SELECT * FROM orders WHERE user_id = 1;
-- Then for each order: SELECT * FROM order_items WHERE order_id = ?;

-- Good: Single query with JOIN
SELECT o.*, oi.*
FROM orders o
LEFT JOIN order_items oi ON o.id = oi.order_id
WHERE o.user_id = 1;

-- Or with lateral join for complex subqueries
SELECT o.*, items.*
FROM orders o
LEFT JOIN LATERAL (
  SELECT array_agg(oi.*) as items
  FROM order_items oi
  WHERE oi.order_id = o.id
) items ON true
WHERE o.user_id = 1;
```

### Batch Operations

```sql
-- Bad: Individual inserts
INSERT INTO products (name, price) VALUES ('A', 10);
INSERT INTO products (name, price) VALUES ('B', 20);
INSERT INTO products (name, price) VALUES ('C', 30);

-- Good: Batch insert
INSERT INTO products (name, price) VALUES
  ('A', 10),
  ('B', 20),
  ('C', 30);

-- Good: COPY for bulk loading
COPY products (name, price) FROM '/path/to/data.csv' WITH CSV HEADER;

-- Upsert (INSERT or UPDATE)
INSERT INTO products (sku, name, price)
VALUES ('SKU001', 'Product', 29.99)
ON CONFLICT (sku)
DO UPDATE SET price = EXCLUDED.price, updated_at = NOW();
```

### Efficient Aggregations

```sql
-- Use specific aggregates
SELECT COUNT(*) FROM orders;           -- Counts all rows
SELECT COUNT(1) FROM orders;           -- Same as COUNT(*)
SELECT COUNT(user_id) FROM orders;     -- Counts non-null user_id

-- Approximate counts for large tables
SELECT reltuples::bigint AS estimate
FROM pg_class WHERE relname = 'orders';

-- Or with HyperLogLog extension
SELECT hll_cardinality(hll_add_agg(hll_hash_integer(user_id)))
FROM orders;
```

### Window Functions

```sql
-- Running total
SELECT
  id,
  amount,
  SUM(amount) OVER (ORDER BY created_at) AS running_total
FROM transactions;

-- Rank within partition
SELECT
  user_id,
  order_id,
  total,
  RANK() OVER (PARTITION BY user_id ORDER BY total DESC) AS rank
FROM orders;

-- Previous/next values
SELECT
  id,
  amount,
  LAG(amount) OVER (ORDER BY created_at) AS prev_amount,
  LEAD(amount) OVER (ORDER BY created_at) AS next_amount
FROM transactions;
```

## Performance Settings

```sql
-- Check current settings
SHOW work_mem;
SHOW shared_buffers;
SHOW effective_cache_size;

-- Tune for specific query (session only)
SET work_mem = '256MB';  -- For complex sorts/hashes

-- Analyze query without executing
EXPLAIN (ANALYZE false) SELECT ...;

-- Force index usage (debugging only)
SET enable_seqscan = off;
```
