---
name: database
description: "Design schemas, optimize queries, manage migrations, and configure database connections. Activates for: 'design database schema', 'optimize query', 'create migration', 'SQL help', 'database design', 'fix slow query', 'ORM setup', 'PostgreSQL', 'MySQL', 'MongoDB', 'Redis'."
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
  - Task
  - mcp__sequential-thinking__sequentialthinking
---

# Database Skill

## Purpose

Provide expert guidance on database design, query optimization, migration management, connection handling, and data modeling across SQL and NoSQL databases.

## Activation Triggers

Activate when the user mentions:
- "Design a database schema"
- "Create a migration"
- "Optimize this query"
- "Set up database connection pooling"
- "Choose between SQL and NoSQL"
- "Add an index"
- "Model this data"
- "Write a complex query"
- "Set up ORM"
- "Database performance issues"
- "Normalize this schema"

## Do NOT Activate When

- Simple CRUD operations (use general implementation)
- UI forms for data entry (use `implement`)
- API endpoint design without data modeling (use `design`)
- Data visualization (use `implement`)

## Behavioral Flow

### 1. Understand Data Requirements
- Identify entities and relationships
- Determine access patterns (read-heavy, write-heavy, mixed)
- Estimate data volume and growth
- Identify consistency requirements

### 2. Design Schema
- Apply appropriate normalization level
- Define primary and foreign keys
- Plan indexes for query patterns
- Consider denormalization for performance

### 3. Implement
- Create migration files
- Define ORM models
- Set up connection configuration
- Configure connection pooling

### 4. Optimize
- Analyze query execution plans
- Add/modify indexes
- Implement query caching
- Consider read replicas

### 5. Validate
- Test with realistic data volumes
- Verify constraint enforcement
- Check migration reversibility
- Performance benchmark

## Database Selection Guide

| Requirement | Recommended | Avoid |
|-------------|-------------|-------|
| Complex relationships | PostgreSQL, MySQL | MongoDB |
| Document storage | MongoDB, CouchDB | Relational for flexible schemas |
| Time-series data | TimescaleDB, InfluxDB | General RDBMS |
| Key-value cache | Redis, Memcached | Relational |
| Graph relationships | Neo4j, Neptune | Relational |
| Full-text search | Elasticsearch, PostgreSQL FTS | Basic RDBMS |
| ACID transactions | PostgreSQL, MySQL | Eventually consistent stores |
| High write throughput | Cassandra, ScyllaDB | Single-node RDBMS |

## Key Patterns

### Schema Design Best Practices
- Use UUID for distributed systems, BIGSERIAL for single-node
- Include `created_at`, `updated_at` timestamps
- Soft delete with `deleted_at` when audit trail needed
- Version fields for optimistic locking

### Indexing Strategy
```sql
-- Index columns used in WHERE, JOIN, ORDER BY
CREATE INDEX idx_users_email ON users(email);

-- Composite index for multi-column queries
CREATE INDEX idx_orders_user_date ON orders(user_id, created_at DESC);

-- Partial index for filtered queries
CREATE INDEX idx_active_users ON users(email) WHERE deleted_at IS NULL;

-- Covering index to avoid table lookups
CREATE INDEX idx_orders_summary ON orders(user_id) INCLUDE (total, status);
```

### Query Optimization
```sql
-- Use EXPLAIN ANALYZE before optimizing
EXPLAIN ANALYZE SELECT * FROM orders WHERE user_id = 123;

-- Avoid SELECT * in production
SELECT id, status, total FROM orders WHERE user_id = 123;

-- Use pagination for large result sets
SELECT * FROM orders
WHERE user_id = 123
ORDER BY created_at DESC
LIMIT 20 OFFSET 0;

-- Use EXISTS instead of IN for subqueries
SELECT * FROM users u
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.user_id = u.id);
```

### Connection Pooling
```javascript
// Node.js with pg-pool
const { Pool } = require('pg');

const pool = new Pool({
  host: process.env.DB_HOST,
  port: 5432,
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  max: 20,                    // Maximum connections
  idleTimeoutMillis: 30000,   // Close idle connections after 30s
  connectionTimeoutMillis: 2000,
});
```

## MCP Integration

- **sequential-thinking**: Design complex data models and relationships

## References

- [schema-design.md](references/schema-design.md) - Normalization and modeling patterns
- [query-optimization.md](references/query-optimization.md) - Performance tuning techniques
- [migration-patterns.md](references/migration-patterns.md) - Safe migration strategies
- [connection-management.md](references/connection-management.md) - Pooling and configuration

## Boundaries

### Will Do
- Design database schemas and data models
- Write and optimize SQL queries
- Create migration files
- Configure connection pooling
- Add indexes and constraints
- Set up ORM models
- Recommend database selection

### Will NOT Do
- Database administration tasks (backup, restore, replication setup)
- Database server installation
- Production data manipulation without explicit request
- Security/access control configuration
- Capacity planning without metrics
