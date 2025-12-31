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

**Core Principle**: "Data is the foundation. Design for access patterns, optimize for performance, migrate safely."

**Key Enhancement**: Research database documentation, ORM patterns, and optimization techniques before designing schemas or writing queries.

**Key Distinction**: This skill handles DATABASE operations (schema, queries, migrations). For API design that uses databases, use the `design` skill. For zero-downtime migrations, use the `migration` skill.

## Activation Triggers

- Schema design ("design database schema", "model this data", "normalize schema")
- Query optimization ("optimize query", "fix slow query", "explain analyze")
- Migrations ("create migration", "safe migration strategy")
- ORM setup ("set up Prisma", "configure Drizzle", "TypeORM models")
- Database selection ("choose database", "PostgreSQL vs MySQL", "SQL vs NoSQL")
- Connection management ("connection pooling", "database configuration")
- Caching ("Redis cache", "cache strategy", "invalidation")

## Do NOT Activate When

- Simple CRUD operations → use general implementation
- UI forms for data entry → use `implement` skill
- API endpoint design without data modeling → use `design` skill
- Data visualization → use `implement` skill
- Database security audit → use `security` skill
- Zero-downtime migrations → use `migration` skill

**Boundary Clarification:**
This skill focuses on database design and operations. For complex zero-downtime migrations with rollback strategies, use the `migration` skill. For security audits of database configurations, use the `security` skill.

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
│ access       │ ORM          │ indexing     │ ORM          │ constraints  │
│ patterns     │ patterns     │ strategy     │ models       │              │
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

# Lookup MySQL documentation
mcp__context7__resolve-library-id → "/websites/dev_mysql_doc_refman_9_4_en"
mcp__context7__query-docs("query optimization indexes explain")

# Lookup Prisma ORM documentation
mcp__context7__resolve-library-id → "/prisma/docs"
mcp__context7__query-docs("relations many-to-many implicit transactions")

# Lookup Drizzle ORM documentation
mcp__context7__resolve-library-id → "/drizzle-team/drizzle-orm-docs"
mcp__context7__query-docs("schema relations query builder migrations")

# Lookup MongoDB documentation
mcp__context7__resolve-library-id → "/mongodb/docs"
mcp__context7__query-docs("aggregation pipeline indexes")

# Lookup Redis documentation
mcp__context7__resolve-library-id → "/websites/redis_io"
mcp__context7__query-docs("data structures caching pub/sub")

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
- Model complex relationships (many-to-many, polymorphic)
- Plan caching strategy
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
mcp__context7__resolve-library-id - Resolve database/ORM library IDs
mcp__context7__query-docs - Get official documentation
```

**Available Resources:**

| Resource    | Library ID                              | Snippets | Use Case                          |
| ----------- | --------------------------------------- | -------- | --------------------------------- |
| PostgreSQL  | `/websites/postgresql`                  | 61,065   | SQL, functions, optimization      |
| MySQL       | `/websites/dev_mysql_doc_refman_9_4_en` | 19,896   | Query optimization, indexes       |
| MongoDB     | `/mongodb/docs`                         | 22,287   | Aggregation, indexes, schemas     |
| Redis       | `/websites/redis_io`                    | 29,026   | Caching, data structures, pub/sub |
| Prisma      | `/prisma/docs`                          | 4,691    | Schema, relations, transactions   |
| Drizzle ORM | `/drizzle-team/drizzle-orm-docs`        | 2,553    | Query builder, migrations         |
| TypeORM     | `/typeorm/typeorm`                      | 1,134    | Entities, relations, migrations   |
| Mikro-ORM   | `/mikro-orm/mikro-orm`                  | 1,034    | Data mapper, unit of work         |
| Sequelize   | `/sequelize/website`                    | 8,403    | Models, associations, migrations  |
| Mongoose    | `/websites/mongoosejs`                  | 11,893   | Schemas, validation, middleware   |
| Knex.js     | `/knex/knex`                            | 441      | Query builder, migrations         |
| Node-Redis  | `/redis/node-redis`                     | 151      | Redis client for Node.js          |

**Query patterns:**

```
# PostgreSQL optimization
mcp__context7__resolve-library-id → "/websites/postgresql"
mcp__context7__query-docs("explain analyze query plan optimization indexes")

# Prisma relations
mcp__context7__resolve-library-id → "/prisma/docs"
mcp__context7__query-docs("many-to-many relations implicit explicit junction")

# Drizzle migrations
mcp__context7__resolve-library-id → "/drizzle-team/drizzle-orm-docs"
mcp__context7__query-docs("drizzle-kit migrations push generate")

# MongoDB aggregation
mcp__context7__resolve-library-id → "/mongodb/docs"
mcp__context7__query-docs("aggregation pipeline $lookup $unwind $group")

# Redis caching patterns
mcp__context7__resolve-library-id → "/websites/redis_io"
mcp__context7__query-docs("cache aside pattern TTL expiration")

# Mongoose schemas
mcp__context7__resolve-library-id → "/websites/mongoosejs"
mcp__context7__query-docs("schema validation virtuals middleware")
```

### GitHub MCP (Pattern Research)

**Find real-world database patterns:**

```
mcp__github__search_code - Find schema/migration patterns in repos
mcp__github__get_file_contents - Get specific database files
```

**Search patterns:**

```
# Find PostgreSQL migration patterns
"CREATE TABLE" "CONSTRAINT" "REFERENCES" filename:migration stars:>500

# Find Prisma schema patterns
"model User" "@@index" "@@unique" filename:schema.prisma stars:>500

# Find Drizzle schema patterns
"pgTable" "serial" "references" filename:schema.ts stars:>100

# Find TypeORM entity patterns
"@Entity" "@Column" "@ManyToOne" filename:.ts stars:>500

# Find Mongoose schema patterns
"new Schema" "mongoose.model" filename:.ts stars:>500

# Find connection pooling examples
"PgPool" "max:" "idleTimeoutMillis" filename:.ts

# Find Redis caching patterns
"redis" "get" "set" "expire" filename:.ts stars:>500
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

- "PostgreSQL 16 new features for performance 2024"
- "Database indexing strategies best practices"
- "Prisma vs Drizzle vs TypeORM comparison 2024"
- "PostgreSQL connection pooling with PgBouncer"
- "Database schema migration zero downtime"
- "MongoDB aggregation pipeline optimization"
- "Redis caching strategies patterns"
- "SQL vs NoSQL when to use comparison"

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
- Caching strategy design

## Database Selection Guide

| Requirement           | Recommended           | Avoid                           |
| --------------------- | --------------------- | ------------------------------- |
| Complex relationships | PostgreSQL, MySQL     | MongoDB for heavy joins         |
| Document storage      | MongoDB, CouchDB      | Relational for flexible schemas |
| Time-series data      | TimescaleDB, InfluxDB | General RDBMS                   |
| Key-value cache       | Redis, Memcached      | Relational                      |
| Graph relationships   | Neo4j, Neptune        | Relational                      |
| Full-text search      | Elasticsearch, PG FTS | Basic RDBMS                     |
| ACID transactions     | PostgreSQL, MySQL     | Eventually consistent stores    |
| High write throughput | Cassandra, ScyllaDB   | Single-node RDBMS               |
| Embedded database     | SQLite, DuckDB        | Client-server databases         |

## ORM Comparison

| ORM       | Type          | Best For                    | Trade-offs                     |
| --------- | ------------- | --------------------------- | ------------------------------ |
| Prisma    | Query Builder | Type safety, DX, migrations | Performance overhead, learning |
| Drizzle   | Query Builder | Performance, SQL-like API   | Newer ecosystem                |
| TypeORM   | Active Record | Decorators, migrations      | Complex queries, bundle size   |
| Mikro-ORM | Data Mapper   | Unit of work, identity map  | Learning curve                 |
| Sequelize | Active Record | Mature, migrations, hooks   | TypeScript support, verbosity  |
| Knex.js   | Query Builder | Raw SQL control, migrations | No ORM features                |

## Key Patterns

### Prisma Schema Design

```prisma
// schema.prisma
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

model User {
  id        String   @id @default(cuid())
  email     String   @unique
  name      String?
  posts     Post[]
  profile   Profile?
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt

  @@index([email])
  @@map("users")
}

model Post {
  id         String     @id @default(cuid())
  title      String
  content    String?
  published  Boolean    @default(false)
  author     User       @relation(fields: [authorId], references: [id], onDelete: Cascade)
  authorId   String
  categories Category[]
  createdAt  DateTime   @default(now())
  updatedAt  DateTime   @updatedAt

  @@index([authorId])
  @@index([published, createdAt])
  @@map("posts")
}

model Category {
  id    String @id @default(cuid())
  name  String @unique
  posts Post[]

  @@map("categories")
}

model Profile {
  id     String @id @default(cuid())
  bio    String?
  user   User   @relation(fields: [userId], references: [id], onDelete: Cascade)
  userId String @unique

  @@map("profiles")
}
```

### Drizzle Schema Design

```typescript
// schema.ts
import {
  pgTable,
  serial,
  text,
  varchar,
  boolean,
  timestamp,
  integer,
  index,
  uniqueIndex,
} from "drizzle-orm/pg-core";
import { relations } from "drizzle-orm";

export const users = pgTable(
  "users",
  {
    id: serial("id").primaryKey(),
    email: varchar("email", { length: 255 }).unique().notNull(),
    name: text("name"),
    createdAt: timestamp("created_at").defaultNow().notNull(),
    updatedAt: timestamp("updated_at").defaultNow().notNull(),
  },
  (table) => ({
    emailIdx: uniqueIndex("email_idx").on(table.email),
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
    updatedAt: timestamp("updated_at").defaultNow().notNull(),
  },
  (table) => ({
    authorIdx: index("author_idx").on(table.authorId),
    publishedIdx: index("published_idx").on(table.published, table.createdAt),
  }),
);

export const usersRelations = relations(users, ({ many, one }) => ({
  posts: many(posts),
  profile: one(profiles),
}));

export const postsRelations = relations(posts, ({ one, many }) => ({
  author: one(users, {
    fields: [posts.authorId],
    references: [users.id],
  }),
  categories: many(postsToCategories),
}));
```

### TypeORM Entity Design

```typescript
// entities/User.ts
import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  OneToMany,
  OneToOne,
  CreateDateColumn,
  UpdateDateColumn,
  Index,
} from "typeorm";
import { Post } from "./Post";
import { Profile } from "./Profile";

@Entity("users")
export class User {
  @PrimaryGeneratedColumn("uuid")
  id: string;

  @Index()
  @Column({ unique: true })
  email: string;

  @Column({ nullable: true })
  name: string;

  @OneToMany(() => Post, (post) => post.author)
  posts: Post[];

  @OneToOne(() => Profile, (profile) => profile.user, { cascade: true })
  profile: Profile;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}

// entities/Post.ts
@Entity("posts")
@Index(["published", "createdAt"])
export class Post {
  @PrimaryGeneratedColumn("uuid")
  id: string;

  @Column()
  title: string;

  @Column({ type: "text", nullable: true })
  content: string;

  @Column({ default: false })
  published: boolean;

  @ManyToOne(() => User, (user) => user.posts, { onDelete: "CASCADE" })
  @JoinColumn({ name: "author_id" })
  author: User;

  @Column()
  authorId: string;

  @ManyToMany(() => Category, (category) => category.posts)
  @JoinTable({ name: "posts_categories" })
  categories: Category[];

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}
```

### Mongoose Schema Design

```typescript
// models/User.ts
import mongoose, { Schema, Document } from "mongoose";

export interface IUser extends Document {
  email: string;
  name?: string;
  profile?: {
    bio?: string;
    avatar?: string;
  };
  createdAt: Date;
  updatedAt: Date;
}

const userSchema = new Schema<IUser>(
  {
    email: {
      type: String,
      required: true,
      unique: true,
      lowercase: true,
      trim: true,
      index: true,
    },
    name: {
      type: String,
      trim: true,
    },
    profile: {
      bio: String,
      avatar: String,
    },
  },
  {
    timestamps: true,
    toJSON: { virtuals: true },
    toObject: { virtuals: true },
  },
);

// Virtual for posts
userSchema.virtual("posts", {
  ref: "Post",
  localField: "_id",
  foreignField: "author",
});

// Pre-save middleware
userSchema.pre("save", function (next) {
  // Custom logic before save
  next();
});

export const User = mongoose.model<IUser>("User", userSchema);

// models/Post.ts
const postSchema = new Schema(
  {
    title: { type: String, required: true },
    content: { type: String },
    published: { type: Boolean, default: false },
    author: {
      type: Schema.Types.ObjectId,
      ref: "User",
      required: true,
      index: true,
    },
    categories: [{ type: Schema.Types.ObjectId, ref: "Category" }],
  },
  {
    timestamps: true,
  },
);

// Compound index for common query patterns
postSchema.index({ published: 1, createdAt: -1 });

export const Post = mongoose.model("Post", postSchema);
```

### PostgreSQL Schema Design

```sql
-- migrations/001_create_users.sql
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  email VARCHAR(255) UNIQUE NOT NULL,
  name VARCHAR(255),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  deleted_at TIMESTAMPTZ  -- Soft delete
);

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_active ON users(email) WHERE deleted_at IS NULL;

-- Version field for optimistic locking
ALTER TABLE users ADD COLUMN version INTEGER DEFAULT 1;

-- migrations/002_create_posts.sql
CREATE TABLE posts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  title VARCHAR(255) NOT NULL,
  content TEXT,
  published BOOLEAN DEFAULT FALSE,
  author_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_posts_author ON posts(author_id);
CREATE INDEX idx_posts_published_date ON posts(published, created_at DESC);

-- migrations/003_create_categories.sql
CREATE TABLE categories (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(255) UNIQUE NOT NULL
);

-- Junction table for many-to-many
CREATE TABLE posts_categories (
  post_id UUID REFERENCES posts(id) ON DELETE CASCADE,
  category_id UUID REFERENCES categories(id) ON DELETE CASCADE,
  PRIMARY KEY (post_id, category_id)
);

CREATE INDEX idx_posts_categories_post ON posts_categories(post_id);
CREATE INDEX idx_posts_categories_category ON posts_categories(category_id);
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

-- GIN index for JSONB columns
CREATE INDEX idx_metadata ON products USING GIN (metadata);

-- Full-text search index
CREATE INDEX idx_posts_search ON posts USING GIN (to_tsvector('english', title || ' ' || content));
```

### Query Optimization

```sql
-- Use EXPLAIN ANALYZE before optimizing
EXPLAIN (ANALYZE, BUFFERS, FORMAT TEXT) SELECT * FROM orders WHERE user_id = 123;

-- Avoid SELECT * in production
SELECT id, status, total FROM orders WHERE user_id = 123;

-- Use pagination for large result sets
SELECT * FROM orders
WHERE user_id = 123
ORDER BY created_at DESC
LIMIT 20 OFFSET 0;

-- Cursor-based pagination (more efficient for large offsets)
SELECT * FROM orders
WHERE user_id = 123 AND created_at < $last_seen_date
ORDER BY created_at DESC
LIMIT 20;

-- Use EXISTS instead of IN for subqueries
SELECT * FROM users u
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.user_id = u.id);

-- Use CTE for complex queries
WITH active_users AS (
  SELECT id, email FROM users WHERE last_login > NOW() - INTERVAL '30 days'
)
SELECT u.email, COUNT(o.id) as order_count
FROM active_users u
LEFT JOIN orders o ON o.user_id = u.id
GROUP BY u.id, u.email;
```

### Connection Pooling

```typescript
// Node.js with pg-pool
import { Pool } from "pg";

const pool = new Pool({
  host: process.env.DB_HOST,
  port: 5432,
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  max: 20, // Maximum connections
  idleTimeoutMillis: 30000, // Close idle connections after 30s
  connectionTimeoutMillis: 2000, // Timeout for new connections
  allowExitOnIdle: true, // Allow process to exit when pool is idle
});

// Graceful shutdown
process.on("SIGTERM", async () => {
  await pool.end();
  process.exit(0);
});

// With Prisma
// Use connection pooling via DATABASE_URL
// postgresql://user:pass@host:5432/db?connection_limit=20&pool_timeout=30
```

### Redis Caching Patterns

```typescript
// Cache-aside pattern
import Redis from "ioredis";

const redis = new Redis(process.env.REDIS_URL);

async function getUser(userId: string): Promise<User> {
  const cacheKey = `user:${userId}`;

  // Try cache first
  const cached = await redis.get(cacheKey);
  if (cached) {
    return JSON.parse(cached);
  }

  // Fetch from database
  const user = await db.user.findUnique({ where: { id: userId } });

  // Store in cache with TTL
  if (user) {
    await redis.setex(cacheKey, 3600, JSON.stringify(user)); // 1 hour TTL
  }

  return user;
}

// Cache invalidation
async function updateUser(userId: string, data: UserUpdate): Promise<User> {
  const user = await db.user.update({
    where: { id: userId },
    data,
  });

  // Invalidate cache
  await redis.del(`user:${userId}`);

  return user;
}

// Write-through cache
async function createUser(data: UserCreate): Promise<User> {
  const user = await db.user.create({ data });

  // Update cache immediately
  await redis.setex(`user:${user.id}`, 3600, JSON.stringify(user));

  return user;
}
```

### MongoDB Aggregation Pipeline

```typescript
// Complex aggregation example
const result = await Post.aggregate([
  // Match published posts
  { $match: { published: true } },

  // Lookup author details
  {
    $lookup: {
      from: "users",
      localField: "author",
      foreignField: "_id",
      as: "authorDetails",
    },
  },
  { $unwind: "$authorDetails" },

  // Group by author
  {
    $group: {
      _id: "$authorDetails._id",
      author: { $first: "$authorDetails" },
      postCount: { $sum: 1 },
      totalViews: { $sum: "$views" },
      latestPost: { $max: "$createdAt" },
    },
  },

  // Sort by post count
  { $sort: { postCount: -1 } },

  // Limit results
  { $limit: 10 },

  // Project final shape
  {
    $project: {
      _id: 0,
      authorId: "$_id",
      authorName: "$author.name",
      authorEmail: "$author.email",
      postCount: 1,
      totalViews: 1,
      latestPost: 1,
    },
  },
]);
```

## Output Format

```markdown
## Database Design Report

### Schema Summary

| Entity   | Fields                  | Relationships           |
| -------- | ----------------------- | ----------------------- |
| User     | id, email, name, ...    | has many Posts          |
| Post     | id, title, content, ... | belongs to User         |
| Category | id, name                | many-to-many with Posts |

### Research Applied

- PostgreSQL: [Indexing strategies from Context7]
- Prisma patterns: [Relations, transactions]
- Best practices: [Tavily research findings]

### Indexes Created

| Table | Index               | Type      | Purpose                 |
| ----- | ------------------- | --------- | ----------------------- |
| users | idx_users_email     | B-tree    | Email lookups           |
| posts | idx_posts_author    | B-tree    | Author filtering        |
| posts | idx_posts_published | Composite | Published posts by date |

### Migration Files

| File                      | Purpose                  |
| ------------------------- | ------------------------ |
| 001_create_users.sql      | Users table with indexes |
| 002_create_posts.sql      | Posts with foreign keys  |
| 003_create_categories.sql | Categories and junction  |

### Performance Considerations

- Estimated table sizes after 1 year: [projections]
- Query performance targets: [metrics]
- Caching strategy: [Redis patterns]

### Next Steps

- [ ] Run migrations in staging
- [ ] Seed test data
- [ ] Benchmark query performance
- [ ] Set up connection pooling
```

## Reference Files

For detailed patterns and examples, see:

- `references/schema-design.md` - Normalization and modeling patterns
- `references/query-optimization.md` - Performance tuning techniques
- `references/migration-patterns.md` - Safe migration strategies
- `references/connection-management.md` - Pooling and configuration
- `references/caching-patterns.md` - Redis caching strategies
- `references/orm-patterns.md` - ORM-specific best practices

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
- Set up ORM models (Prisma, Drizzle, TypeORM, Sequelize, Mongoose)
- Implement caching strategies with Redis
- Research best practices via MCP tools
- Recommend database selection
- Design aggregation pipelines for MongoDB

**Will Not:**

- Database administration tasks (backup, restore, replication setup)
- Database server installation
- Production data manipulation without explicit request
- Security/access control configuration (use `security` skill)
- Capacity planning without metrics
- Infrastructure provisioning (use `devops` skill)
- Complex zero-downtime migrations (use `migration` skill)
