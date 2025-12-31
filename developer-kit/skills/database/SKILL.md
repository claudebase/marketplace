---
name: database
description: "Design schemas, optimize queries, manage migrations, and configure database connections. Activates for: 'design database schema', 'optimize query', 'create migration', 'SQL help', 'database design', 'fix slow query', 'ORM setup', 'PostgreSQL', 'MySQL', 'MongoDB', 'Redis'."
allowed-tools:
  # Core Analysis
  - Read
  - Grep
  - Glob
  # Implementation
  - Write
  - Edit
  - Bash
  - Task
  # Database Documentation
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  # Pattern Research
  - mcp__github__search_code
  - mcp__github__get_file_contents
  # Best Practices Research
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  # Complex Schema Design
  - mcp__sequential-thinking__sequentialthinking
---

# Database Skill

Provide expert guidance on database design, query optimization, migration management, connection handling, and data modeling across SQL and NoSQL databases with official documentation and community best practices.

## Activation Triggers

- Schema design ("design database schema", "model this data", "normalize schema")
- Query optimization ("optimize query", "fix slow query", "explain analyze")
- Migrations ("create migration", "safe migration strategy")
- ORM setup ("set up Prisma", "configure Drizzle", "TypeORM models")
- Database selection ("choose database", "PostgreSQL vs MySQL", "SQL vs NoSQL")
- Connection management ("connection pooling", "database configuration")

## Do NOT Activate When

- Simple CRUD operations → use general implementation
- UI forms for data entry → use `implement` skill
- API endpoint design without data modeling → use `design` skill
- Data visualization → use `implement` skill
- Database security audit → use `security` skill

## Behavioral Flow

```
┌──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
│  UNDERSTAND  │   RESEARCH   │    DESIGN    │  IMPLEMENT   │   VALIDATE   │
├──────────────┼──────────────┼──────────────┼──────────────┼──────────────┤
│ Identify     │ Lookup       │ Apply        │ Create       │ Test with    │
│ entities &   │ official     │ normalization│ migrations   │ realistic    │
│ relationships│ docs         │              │              │ data         │
│              │              │              │              │              │
│ Determine    │ Find         │ Plan         │ Write        │ Verify       │
│ access       │ patterns     │ indexing     │ ORM          │ constraints  │
│ patterns     │              │ strategy     │ models       │              │
│              │              │              │              │              │
│ Estimate     │ Research     │ Model        │ Configure    │ Performance  │
│ volume       │ best         │ schema       │ connections  │ benchmark    │
│              │ practices    │              │              │              │
└──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘
     Read           Context7      Sequential      Write          Bash
     Grep           GitHub        Thinking        Edit           (tests)
                    Tavily
```

### Phase 1: UNDERSTAND

Analyze data requirements before designing:

1. **Read existing code** - Identify entities, current data models, ORM usage
2. **Determine access patterns** - Read-heavy, write-heavy, mixed workloads
3. **Estimate data volume** - Current size and growth projections
4. **Identify consistency requirements** - ACID needs, eventual consistency acceptable?

**Tools**: Read, Grep, Glob

### Phase 2: RESEARCH

Gather official documentation and community patterns:

```
# Lookup PostgreSQL documentation
mcp__context7__resolve-library-id → "/websites/postgresql"
mcp__context7__query-docs("window functions for aggregation")

# Lookup ORM documentation
mcp__context7__resolve-library-id → "/prisma/docs"
mcp__context7__query-docs("relations many-to-many implicit")

# Find real-world schema patterns
mcp__github__search_code("CREATE TABLE users CONSTRAINT filename:migration")

# Research current best practices
mcp__tavily__tavily-search("PostgreSQL 16 indexing best practices 2024")
```

**Tools**: Context7, GitHub MCP, Tavily

### Phase 3: DESIGN

Plan schema with structured reasoning:

```
mcp__sequential-thinking__sequentialthinking
- Determine appropriate normalization level
- Design primary/foreign key relationships
- Plan index strategy for query patterns
- Consider denormalization trade-offs
- Model complex relationships
```

**Design Decisions:**

- **Normalization**: 3NF for OLTP, denormalized for analytics
- **Keys**: UUID for distributed, BIGSERIAL for single-node
- **Indexes**: Based on WHERE, JOIN, ORDER BY patterns
- **Constraints**: Foreign keys, unique, check constraints

**Tools**: Sequential Thinking

### Phase 4: IMPLEMENT

Create database artifacts:

1. **Migration files** - Safe, reversible changes
2. **ORM models** - Type-safe schema definitions
3. **Connection config** - Pooling, timeouts, retries
4. **Seed data** - Development and test fixtures

**Tools**: Write, Edit, Bash

### Phase 5: VALIDATE

Test and verify implementation:

```bash
# Test migrations
npm run db:migrate:dry-run

# Verify with EXPLAIN ANALYZE
psql -c "EXPLAIN ANALYZE SELECT ..."

# Performance benchmark
pgbench -c 10 -t 1000 -U user database

# Check constraint enforcement
npm run test:db
```

**Tools**: Bash

## MCP Integration

### Context7 (Official Documentation)

**Primary source for database and ORM best practices:**

```
mcp__context7__resolve-library-id - Resolve PostgreSQL, Prisma, Drizzle IDs
mcp__context7__query-docs - Get official documentation
```

**Available Resources:**

| Resource    | Library ID                       | Snippets |
| ----------- | -------------------------------- | -------- |
| PostgreSQL  | `/websites/postgresql`           | 61,065   |
| Prisma      | `/prisma/docs`                   | 4,691    |
| Drizzle ORM | `/drizzle-team/drizzle-orm-docs` | 2,553    |

**Use cases:**

- "PostgreSQL JSON operators and functions"
- "Prisma schema relations and cascades"
- "Drizzle query builder patterns"
- "PostgreSQL window functions for analytics"
- "Prisma transactions and nested writes"

### GitHub MCP (Pattern Research)

**Find real-world database patterns:**

```
mcp__github__search_code - Find schema/migration patterns in repos
mcp__github__get_file_contents - Get specific database files
```

**Search patterns:**

```
# Find PostgreSQL migration patterns
"CREATE TABLE" "CONSTRAINT" "REFERENCES" filename:migration

# Find Prisma schema patterns
"model User" "@@index" "@@unique" filename:schema.prisma

# Find Drizzle schema patterns
"pgTable" "serial" "references" filename:schema.ts

# Find connection pooling examples
"PgPool" "max:" "idleTimeoutMillis" filename:.ts
```

**Use cases:**

- Find how popular projects structure schemas
- Research migration patterns in production codebases
- Get real ORM model examples
- Study connection pooling configurations

### Tavily (Best Practices Research)

**Research current database best practices:**

```
mcp__tavily__tavily-search - Research optimization techniques
mcp__tavily__tavily-extract - Extract from articles/docs
```

**Use cases:**

- "PostgreSQL 16 new features for performance"
- "Database indexing strategies 2024 best practices"
- "Prisma vs Drizzle vs TypeORM comparison"
- "PostgreSQL connection pooling with PgBouncer"
- "Database schema migration zero downtime"

### Sequential Thinking (Complex Design)

**Structured reasoning for complex data modeling:**

```
mcp__sequential-thinking__sequentialthinking - Multi-step schema design
```

**Use for:**

- Multi-table relationship design
- Normalization vs denormalization decisions
- Complex migration planning
- Performance trade-off analysis
- Database selection decisions

## Database Selection Guide

| Requirement           | Recommended           | Avoid                           |
| --------------------- | --------------------- | ------------------------------- |
| Complex relationships | PostgreSQL, MySQL     | MongoDB                         |
| Document storage      | MongoDB, CouchDB      | Relational for flexible schemas |
| Time-series data      | TimescaleDB, InfluxDB | General RDBMS                   |
| Key-value cache       | Redis, Memcached      | Relational                      |
| Graph relationships   | Neo4j, Neptune        | Relational                      |
| Full-text search      | Elasticsearch, PG FTS | Basic RDBMS                     |
| ACID transactions     | PostgreSQL, MySQL     | Eventually consistent stores    |
| High write throughput | Cassandra, ScyllaDB   | Single-node RDBMS               |

## Key Patterns

### Schema Design Best Practices

```sql
-- Use UUID for distributed systems, BIGSERIAL for single-node
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email VARCHAR(255) UNIQUE NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  deleted_at TIMESTAMPTZ  -- Soft delete when audit trail needed
);

-- Version field for optimistic locking
ALTER TABLE users ADD COLUMN version INTEGER DEFAULT 1;
```

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
const { Pool } = require("pg");

const pool = new Pool({
  host: process.env.DB_HOST,
  port: 5432,
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  max: 20, // Maximum connections
  idleTimeoutMillis: 30000, // Close idle connections after 30s
  connectionTimeoutMillis: 2000,
});
```

## Reference Files

For detailed patterns and examples, see:

- `references/schema-design.md` - Normalization and modeling patterns
- `references/query-optimization.md` - Performance tuning techniques
- `references/migration-patterns.md` - Safe migration strategies
- `references/connection-management.md` - Pooling and configuration

## Handoffs

| Scenario                     | Hand off to           |
| ---------------------------- | --------------------- |
| Need API integration         | `implement` skill     |
| Need system architecture     | `design` skill        |
| Need security audit          | `security` skill      |
| Need performance profiling   | `performance` skill   |
| Need zero-downtime migration | `migration` skill     |
| Need observability setup     | `observability` skill |

## Boundaries

**Will:**

- Design database schemas and data models
- Write and optimize SQL queries
- Create migration files with rollback support
- Configure connection pooling
- Add indexes and constraints
- Set up ORM models (Prisma, Drizzle, TypeORM)
- Recommend database selection
- Research best practices via MCP tools

**Will Not:**

- Database administration tasks (backup, restore, replication setup)
- Database server installation
- Production data manipulation without explicit request
- Security/access control configuration (use `security` skill)
- Capacity planning without metrics
- Infrastructure provisioning (use `devops` skill)
