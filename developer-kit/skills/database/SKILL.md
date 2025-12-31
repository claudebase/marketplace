---
name: database
description: "Design schemas, optimize queries, manage migrations, and configure database connections. This skill should be used when the user asks to 'design database schema', 'optimize query', 'create migration', or 'fix slow query'. Also use when user mentions PostgreSQL, MySQL, MongoDB, Redis, ORM setup, or SQL help."
allowed-tools:
  - Read
  - Grep
  - Glob
  - Write
  - Edit
  - Bash
  - Task
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  - mcp__github__search_code
  - mcp__github__get_file_contents
  - mcp__tavily__tavily-search
  - mcp__sequential-thinking__sequentialthinking
---

# Database Skill

Expert guidance on database design, query optimization, migration management, and data modeling across SQL and NoSQL databases.

**Core Principle**: "Data is the foundation. Design for access patterns, optimize for performance, migrate safely."

## When to Use

- Schema design ("design database schema", "model this data")
- Query optimization ("optimize query", "fix slow query", "EXPLAIN")
- Migrations ("create migration", "safe migration strategy")
- ORM setup ("set up Prisma", "configure Drizzle", "TypeORM")
- Database selection ("PostgreSQL vs MySQL", "SQL vs NoSQL")
- Caching ("Redis cache", "cache strategy")

## When NOT to Use

- Zero-downtime migrations → use `migration` skill
- Database security audit → use `security` skill
- API endpoint design → use `design` skill

## Quick Workflow

```
UNDERSTAND → RESEARCH → DESIGN → IMPLEMENT → VALIDATE
   Read        Context7   Sequential   Write      Bash
   Grep        GitHub     Thinking     Edit       (tests)
               Tavily
```

1. **Understand** - Identify entities, access patterns, volume
2. **Research** - Query Context7 for DB docs, search ORM patterns
3. **Design** - Apply normalization, plan indexes
4. **Implement** - Create migrations, write ORM models
5. **Validate** - Test with realistic data, benchmark queries

## Tool Integration

For library IDs and patterns, see:

- [MCP Resources](../../lib/shared-references/mcp-resources.md)
- [Tool Patterns](../../lib/shared-references/tool-integration-patterns.md)

### Key Resources

| Resource   | Library ID                       | Use Case          |
| ---------- | -------------------------------- | ----------------- |
| PostgreSQL | `/websites/postgresql`           | SQL database      |
| Prisma     | `/prisma/docs`                   | Type-safe ORM     |
| Drizzle    | `/drizzle-team/drizzle-orm-docs` | SQL-like ORM      |
| MongoDB    | `/mongodb/docs`                  | Document database |
| Redis      | `/websites/redis_io`             | Caching           |

## References

- [Detailed Guide](references/guide.md) - Full workflow and phases
- [Schema Design](references/schema-design.md) - Normalization, modeling
- [Query Optimization](references/query-optimization.md) - EXPLAIN, indexes
- [Migration Patterns](references/migration-patterns.md) - Safe migrations
- [Connection Management](references/connection-management.md) - Pooling

## Boundaries

**Will**: Design schemas, optimize queries, create migrations, configure ORMs, plan indexes

**Will Not**: Handle zero-downtime migrations, perform security audits, design APIs
