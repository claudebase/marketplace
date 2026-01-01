---
name: migration
description: "Zero-downtime migrations with rollback plans. Activates for: migrate, migration, breaking change, data migration, schema change."
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

# Migration Skill

Safe, reversible migrations with zero downtime and rollback strategies.

## Quick Reference

**Activates for**: migrate, migration, breaking change, data migration, schema change
**Mode**: read-write
**Output**: Migration plan with rollback strategy

## Workflow

```
ASSESS → RESEARCH → PLAN → IMPLEMENT → VERIFY → COMPLETE
```

## Expand-Contract Pattern

```
Phase 1: EXPAND   → Add new alongside old (backward compatible)
Phase 2: MIGRATE  → Transition consumers/data to new
Phase 3: CONTRACT → Remove old after verification
```

## When to Use

- Database migrations ("migrate database", "schema migration")
- API versioning ("upgrade API", "deprecate endpoint")
- Service migrations ("migrate from X to Y")
- Deployment strategies ("blue-green", "canary release")

## When NOT to Use

- Simple schema changes → use `database` skill
- New feature implementation → use `implement` skill
- Performance optimization → use `performance` skill

## References

- [Full Guide](references/guide.md) - Complete workflow and phases
- [Zero-Downtime](references/zero-downtime.md) - Safe migration patterns
- [Database Migrations](references/database-migration-patterns.md) - Schema changes
- [API Versioning](references/api-versioning.md) - Deprecation strategies

## Boundaries

**Will**: Plan migrations, implement expand-contract, design rollback strategies
**Will Not**: Handle simple CRUD changes, implement new features, optimize performance
