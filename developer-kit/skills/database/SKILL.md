---
name: database
description: "Schema design and query optimization. Activates for: database, schema, SQL, migration, PostgreSQL, MySQL, MongoDB, ORM."
composable: true
mode: read-write
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

Expert database design, query optimization, and migration management.

## Quick Reference

**Activates for**: database, schema, SQL, migration, PostgreSQL, MySQL, MongoDB, ORM
**Mode**: read-write
**Output**: Optimized schemas, queries, and migrations

## Workflow

```
UNDERSTAND → RESEARCH → DESIGN → IMPLEMENT → VALIDATE
```

## When to Use

- Schema design ("design database schema", "model this data")
- Query optimization ("optimize query", "fix slow query")
- Migrations ("create migration", "safe migration strategy")
- ORM setup ("set up Prisma", "configure Drizzle")

## When NOT to Use

- Zero-downtime migrations → use `migration` skill
- Database security audit → use `security` skill
- API endpoint design → use `design` skill

## References

- [Full Guide](references/guide.md) - Complete workflow and phases
- [Schema Design](references/schema-design.md) - Normalization, modeling
- [Query Optimization](references/query-optimization.md) - EXPLAIN, indexes
- [Migration Patterns](references/migration-patterns.md) - Safe migrations

## Boundaries

**Will**: Design schemas, optimize queries, create migrations, configure ORMs
**Will Not**: Handle zero-downtime migrations, perform security audits, design APIs
