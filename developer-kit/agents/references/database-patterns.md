# Database Admin - Implementation Patterns

## Prisma Schema Example

```prisma
model User {
  id        String   @id @default(cuid())
  email     String   @unique
  name      String?
  posts     Post[]
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt

  @@index([email])
  @@map("users")
}

model Post {
  id        String   @id @default(cuid())
  title     String
  content   String?
  published Boolean  @default(false)
  author    User     @relation(fields: [authorId], references: [id], onDelete: Cascade)
  authorId  String
  createdAt DateTime @default(now())

  @@index([authorId])
  @@index([published, createdAt])
  @@map("posts")
}
```

## Drizzle Schema Example

```typescript
import {
  pgTable,
  serial,
  text,
  varchar,
  boolean,
  timestamp,
  index,
} from "drizzle-orm/pg-core";

export const users = pgTable(
  "users",
  {
    id: serial("id").primaryKey(),
    email: varchar("email", { length: 255 }).unique().notNull(),
    name: text("name"),
    createdAt: timestamp("created_at").defaultNow().notNull(),
  },
  (table) => ({
    emailIdx: index("email_idx").on(table.email),
  }),
);

export const posts = pgTable(
  "posts",
  {
    id: serial("id").primaryKey(),
    title: varchar("title", { length: 255 }).notNull(),
    content: text("content"),
    published: boolean("published").default(false).notNull(),
    authorId: integer("author_id")
      .references(() => users.id, { onDelete: "cascade" })
      .notNull(),
    createdAt: timestamp("created_at").defaultNow().notNull(),
  },
  (table) => ({
    authorIdx: index("author_idx").on(table.authorId),
    publishedIdx: index("published_idx").on(table.published, table.createdAt),
  }),
);
```

## PostgreSQL Migration Example

```sql
-- migrations/001_create_users.sql
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  email VARCHAR(255) UNIQUE NOT NULL,
  name VARCHAR(255),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_users_email ON users(email);

-- migrations/002_create_posts.sql
CREATE TABLE posts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  title VARCHAR(255) NOT NULL,
  content TEXT,
  published BOOLEAN DEFAULT FALSE,
  author_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_posts_author ON posts(author_id);
CREATE INDEX idx_posts_published_date ON posts(published, created_at DESC);
```

## Query Optimization

```sql
-- Run EXPLAIN ANALYZE
EXPLAIN (ANALYZE, BUFFERS, FORMAT TEXT)
SELECT * FROM orders
WHERE user_id = 123
ORDER BY created_at DESC
LIMIT 20;

-- Common Optimizations

-- Add index for WHERE clause
CREATE INDEX idx_orders_user ON orders(user_id);

-- Add composite index for ORDER BY
CREATE INDEX idx_orders_user_date ON orders(user_id, created_at DESC);

-- Use covering index to avoid table lookups
CREATE INDEX idx_orders_summary ON orders(user_id) INCLUDE (status, total);

-- Partial index for common queries
CREATE INDEX idx_active_orders ON orders(user_id)
WHERE status = 'active';

-- Concurrent index creation (no locks)
CREATE INDEX CONCURRENTLY idx_users_status ON users(status);
```

## Safe Migration Patterns

```sql
-- Safe column addition (no downtime)
ALTER TABLE users ADD COLUMN phone VARCHAR(20);

-- Adding NOT NULL safely
-- Step 1: Add column with default
ALTER TABLE users ADD COLUMN status VARCHAR(20) DEFAULT 'active';

-- Step 2: Backfill existing rows
UPDATE users SET status = 'active' WHERE status IS NULL;

-- Step 3: Add constraint
ALTER TABLE users ALTER COLUMN status SET NOT NULL;

-- Concurrent index creation (PostgreSQL)
CREATE INDEX CONCURRENTLY idx_users_status ON users(status);
```

## Redis Caching Pattern

```typescript
import Redis from "ioredis";

const redis = new Redis(process.env.REDIS_URL);

// Cache-aside pattern
async function getUser(id: string): Promise<User | null> {
  const cacheKey = `user:${id}`;

  // Check cache
  const cached = await redis.get(cacheKey);
  if (cached) return JSON.parse(cached);

  // Fetch from database
  const user = await db.user.findUnique({ where: { id } });

  // Store in cache with 1 hour TTL
  if (user) {
    await redis.setex(cacheKey, 3600, JSON.stringify(user));
  }

  return user;
}

// Invalidate on update
async function updateUser(id: string, data: UserUpdate): Promise<User> {
  const user = await db.user.update({ where: { id }, data });
  await redis.del(`user:${id}`);
  return user;
}
```

## Connection Pooling

```typescript
// pg-pool configuration
const pool = new Pool({
  max: 20, // Max connections
  idleTimeoutMillis: 30000, // Close idle after 30s
  connectionTimeoutMillis: 2000, // Connection timeout
  allowExitOnIdle: true,
});

// Pool Size Formula:
// connections = (core_count * 2) + effective_spindle_count
// For SSD: connections ≈ core_count * 2 + 1

// Prisma (via DATABASE_URL)
// postgresql://user:pass@host:5432/db?connection_limit=20&pool_timeout=30

// Drizzle with pg-pool
const pool = new Pool({ max: 20 });
const db = drizzle(pool);
```

## Database Selection Guide

| Requirement           | Recommended           | Avoid                         |
| --------------------- | --------------------- | ----------------------------- |
| Complex relationships | PostgreSQL, MySQL     | MongoDB for heavy joins       |
| Flexible schema       | MongoDB               | Relational for strict schemas |
| ACID transactions     | PostgreSQL, MySQL     | Eventually consistent stores  |
| Full-text search      | Elasticsearch, PG FTS | Basic RDBMS                   |
| Caching               | Redis                 | Relational                    |
| Time-series           | TimescaleDB, InfluxDB | General RDBMS                 |
| Graph data            | Neo4j                 | Relational                    |
| High write throughput | Cassandra             | Single-node RDBMS             |

## ORM Comparison

| ORM       | Type          | Best For               | Trade-offs           |
| --------- | ------------- | ---------------------- | -------------------- |
| Prisma    | Query Builder | Type safety, DX        | Performance overhead |
| Drizzle   | Query Builder | Performance, SQL       | Newer ecosystem      |
| TypeORM   | Active Record | Decorators, migrations | Bundle size          |
| Sequelize | Active Record | Mature, hooks          | TypeScript support   |
| Mongoose  | ODM           | MongoDB, validation    | MongoDB only         |
| Knex.js   | Query Builder | Raw SQL control        | No ORM features      |

## Index Types Reference

| Index Type | PostgreSQL | Use Case                        |
| ---------- | ---------- | ------------------------------- |
| B-tree     | Default    | Equality, range queries         |
| GIN        | Yes        | Full-text search, JSONB, arrays |
| GiST       | Yes        | Geometric data, range types     |
| BRIN       | Yes        | Large sorted tables             |
| Hash       | Yes        | Equality only (rare)            |

## Caching Patterns

```yaml
Cache-Aside (Lazy Loading):
  - Read: Check cache → miss → fetch DB → store cache
  - Write: Update DB → invalidate cache
  - Best for: Read-heavy data

Write-Through:
  - Write: Update cache and DB together
  - Best for: Data read immediately after write

Write-Behind:
  - Write: Update cache, async update DB
  - Best for: Write-heavy, eventual consistency OK
```
