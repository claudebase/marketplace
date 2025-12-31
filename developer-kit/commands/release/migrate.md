---
name: dk:migrate
description: Plan and execute database or system migrations
delegates-to: migration
argument-hint: "<create|up|down|status|plan> [name] [--dry-run] [--rollback-plan]"
allowed-tools: Read, Write, Edit, Bash, Grep, Glob
---

Execute the **migration** skill for database and system migrations.

## Delegation

This command delegates to the `migration` skill which provides:

- Zero-downtime migration strategies
- Expand-contract pattern guidance
- Rollback plan generation
- Multi-database tooling support

## Operations

| Operation | Description                               |
| --------- | ----------------------------------------- |
| `create`  | Generate new migration file               |
| `up`      | Run pending migrations                    |
| `down`    | Rollback last migration                   |
| `status`  | Show migration status                     |
| `plan`    | Generate migration plan without executing |

## Parameters

| Parameter         | Description                      |
| ----------------- | -------------------------------- |
| `name`            | Migration name (for create)      |
| `--dry-run`       | Show what would happen           |
| `--rollback-plan` | Include rollback procedures      |
| `--steps N`       | Number of migrations to rollback |

## Migration Types

### Database Migrations

```bash
migrate create add_users_table
migrate up
migrate down --steps 2
migrate status
```

### API Migrations

```bash
migrate plan "deprecate v1 endpoints" --rollback-plan
```

### Infrastructure Migrations

```bash
migrate plan "move to kubernetes" --dry-run
```

## Safe Operations Guide

| Operation               | Safety  | Notes                |
| ----------------------- | ------- | -------------------- |
| Add nullable column     | Safe    | Always safe          |
| Add column with default | Safe    | PG 11+               |
| Add index               | Caution | Use CONCURRENTLY     |
| Drop column             | Caution | Ensure no references |
| Rename column           | Risky   | Use expand-contract  |
| Change column type      | Risky   | Use expand-contract  |

## Expand-Contract Pattern

For risky changes, use three migrations:

1. **EXPAND**: Add new column/table
2. **MIGRATE**: Copy/transform data
3. **CONTRACT**: Remove old column/table (after code updated)

## Pre-Migration Checklist

- [ ] Backup database (production)
- [ ] Test migration in staging
- [ ] Verify rollback works
- [ ] Check for long-running transactions
- [ ] Schedule during low-traffic period

## Examples

```bash
migrate create add_email_to_users
migrate up
migrate down
migrate status
migrate plan "split users table" --rollback-plan
```

## Related

- `migration` skill - Migration strategies
- `database` skill - Database design
- `release` - Release workflow
