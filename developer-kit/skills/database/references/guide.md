# Database Skill - Detailed Guide

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

## Phase 1: UNDERSTAND

Analyze data requirements:

1. **Read existing code** - Identify entities, current data models, ORM usage
2. **Determine access patterns** - Read-heavy, write-heavy, mixed workloads
3. **Estimate data volume** - Current size and growth projections
4. **Identify consistency requirements** - ACID needs, eventual consistency?

## Phase 2: RESEARCH

Gather documentation and patterns:

```yaml
# PostgreSQL documentation
mcp__context7__resolve-library-id → "/websites/postgresql"
mcp__context7__query-docs("window functions aggregation")

# Prisma ORM patterns
mcp__context7__resolve-library-id → "/prisma/docs"
mcp__context7__query-docs("relations one-to-many connect")

# Find real-world schema patterns
mcp__github__search_code("model @relation @@index filename:schema.prisma")

# Research optimization techniques
mcp__tavily__tavily-search("PostgreSQL query optimization best practices 2024")
```

## Phase 3: DESIGN

Plan schema with structured reasoning:

```yaml
mcp__sequential-thinking__sequentialthinking:
  - Identify all entities and their attributes
  - Define relationships (1:1, 1:N, M:N)
  - Apply normalization (3NF minimum)
  - Plan indexes for access patterns
  - Consider denormalization for read-heavy paths
```

**Design Decisions:**

| Aspect   | Options                    | Consider                            |
| -------- | -------------------------- | ----------------------------------- |
| Database | PostgreSQL, MySQL, MongoDB | Access patterns, ACID needs         |
| ORM      | Prisma, Drizzle, TypeORM   | Type safety, query builder          |
| Indexing | B-tree, GIN, GiST          | Query patterns, data types          |
| Caching  | Redis, in-memory           | Read frequency, staleness tolerance |

## Phase 4: IMPLEMENT

Create database artifacts:

1. **Migrations** - Schema changes with rollback support
2. **ORM Models** - Type-safe data access
3. **Indexes** - Performance optimization
4. **Connection Pool** - Resource management

## Phase 5: VALIDATE

```bash
# Run migrations
npx prisma migrate dev

# Verify schema
npx prisma db pull

# Test queries with EXPLAIN
psql -c "EXPLAIN ANALYZE SELECT ..."
```

## MCP Resources

For library IDs and patterns, see:

- [MCP Resources](../../../lib/shared-references/mcp-resources.md)
- [Tool Patterns](../../../lib/shared-references/tool-integration-patterns.md)

### Key Resources

| Resource   | Library ID                       | Use Case          |
| ---------- | -------------------------------- | ----------------- |
| PostgreSQL | `/websites/postgresql`           | SQL database      |
| Prisma     | `/prisma/docs`                   | Type-safe ORM     |
| Drizzle    | `/drizzle-team/drizzle-orm-docs` | SQL-like ORM      |
| MongoDB    | `/mongodb/docs`                  | Document database |
| Redis      | `/websites/redis_io`             | Caching           |

## Normalization Guide

| Form | Rule                       | Example Fix            |
| ---- | -------------------------- | ---------------------- |
| 1NF  | No repeating groups        | Split arrays into rows |
| 2NF  | No partial dependencies    | Move to separate table |
| 3NF  | No transitive dependencies | Extract lookup tables  |

## Index Strategy

| Query Pattern    | Index Type |
| ---------------- | ---------- |
| Exact match      | B-tree     |
| Range/sorting    | B-tree     |
| Full-text search | GIN        |
| JSON queries     | GIN        |
| Geospatial       | GiST       |

## Handoffs

| Scenario                  | Hand off to         |
| ------------------------- | ------------------- |
| Zero-downtime migrations  | `migration` skill   |
| Database security audit   | `security` skill    |
| API design using database | `design` skill      |
| Performance profiling     | `performance` skill |
