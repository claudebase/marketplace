---
name: migration
description: "Plan and execute zero-downtime migrations for databases, APIs, and services. This skill should be used when the user asks to 'migrate database', 'upgrade API', 'deprecate endpoint', or 'data migration'. Also use when user mentions breaking changes, backward compatibility, or zero-downtime requirements."
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

# Migration Skill

Enable safe, reversible migrations of databases, APIs, and services with zero downtime, proper versioning, and rollback strategies.

**Core Principle**: "Migrate safely, verify continuously, rollback gracefully."

## When to Use

- Database migrations ("migrate database", "schema migration", "add column")
- API versioning ("upgrade API", "deprecate endpoint", "breaking change")
- Service migrations ("migrate from X to Y", "ORM migration")
- Deployment strategies ("blue-green", "canary release", "gradual rollout")

## When NOT to Use

- Simple schema changes → use `database` skill
- New feature implementation → use `implement` skill
- Performance optimization → use `performance` skill

## Quick Workflow

```
ASSESS → RESEARCH → PLAN → IMPLEMENT → VERIFY → COMPLETE
 Read     Context7   Sequential   Write      Bash      Bash
 Grep     GitHub     Thinking     Edit       (test)    (cleanup)
          Tavily
```

1. **Assess** - Identify current state, dependencies, risks
2. **Research** - Query docs for migration patterns, search examples
3. **Plan** - Design expand-contract strategy, rollback plan
4. **Implement** - Apply migrations in phases
5. **Verify** - Test data integrity, API compatibility
6. **Complete** - Cleanup old code, finalize migration

## Expand-Contract Pattern

```
Phase 1: EXPAND   → Add new alongside old (backward compatible)
Phase 2: MIGRATE  → Transition consumers/data to new
Phase 3: CONTRACT → Remove old after verification
```

## Tool Integration

For library IDs and patterns, see:

- [MCP Resources](../../lib/shared-references/mcp-resources.md)
- [Tool Patterns](../../lib/shared-references/tool-integration-patterns.md)

### Key Resources

| Resource | Library ID                   | Use Case            |
| -------- | ---------------------------- | ------------------- |
| Prisma   | `/prisma/docs`               | Database migrations |
| Alembic  | `/sqlalchemy/alembic`        | Python migrations   |
| OpenAPI  | `/oai/openapi-specification` | API versioning      |

## References

- [Zero-Downtime](references/zero-downtime.md) - Safe migration patterns
- [Database Migrations](references/database-migration-patterns.md) - Schema changes
- [API Versioning](references/api-versioning.md) - Deprecation strategies

## Boundaries

**Will**: Plan migrations, implement expand-contract, design rollback strategies

**Will Not**: Handle simple CRUD changes, implement new features, optimize performance
