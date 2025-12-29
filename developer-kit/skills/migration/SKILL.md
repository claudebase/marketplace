---
name: migration
description: "Plan and execute zero-downtime migrations for databases, APIs, and services. Activates for: 'migrate database', 'data migration', 'upgrade API', 'deprecate endpoint', 'backward compatible', 'breaking change', 'version upgrade', 'zero-downtime migration'."
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

# Migration Skill

## Purpose

Enable safe, reversible migrations of databases, APIs, and services with zero downtime, proper versioning, and rollback strategies.

## Activation Triggers

Activate when the user mentions:
- "Migrate the database"
- "Upgrade to the new version"
- "Deprecate this API endpoint"
- "Add backward compatibility"
- "Plan a breaking change"
- "Version the API"
- "Roll out a new schema"
- "Feature flag this change"
- "Migrate from X to Y"
- "Blue-green deployment"
- "Canary release"

## Do NOT Activate When

- Simple database column addition (use `database`)
- New feature development without migration (use `implement`)
- Infrastructure provisioning (use `devops`)
- Routine deployments without data changes

## Behavioral Flow

### 1. Assess Migration Scope
- Identify what is being migrated (data, schema, API, service)
- Determine dependencies and downstream consumers
- Evaluate data volume and transformation complexity
- Identify rollback requirements

### 2. Design Migration Strategy
Select approach based on requirements:
- **Expand/Contract**: Add new, migrate, remove old
- **Blue/Green**: Parallel environments with cutover
- **Canary**: Gradual rollout with monitoring
- **Feature Flags**: Runtime toggles for new behavior

### 3. Implement Migration Steps
- Create migration scripts with rollback
- Implement dual-write/dual-read if needed
- Add monitoring and metrics
- Document cutover procedure

### 4. Execute with Validation
- Run in staging first
- Monitor key metrics during migration
- Validate data integrity
- Keep rollback ready

### 5. Complete and Cleanup
- Remove old code/schema after stabilization
- Update documentation
- Archive migration artifacts
- Post-mortem if issues occurred

## Migration Patterns

### Expand-Contract Pattern

```
Phase 1: EXPAND
├── Add new column/table/endpoint
├── Deploy code that writes to both old and new
└── Backfill existing data to new format

Phase 2: MIGRATE
├── Deploy code that reads from new
├── Verify all consumers updated
└── Monitor for issues

Phase 3: CONTRACT
├── Remove writes to old format
├── Drop old column/table/endpoint
└── Clean up migration code
```

### API Versioning Strategies

| Strategy | URL Example | Use Case |
|----------|-------------|----------|
| URL Path | `/api/v2/users` | Major versions, clear separation |
| Header | `Accept: application/vnd.api+json;version=2` | Minor versions, same URL |
| Query Param | `/api/users?version=2` | Testing, gradual rollout |

### Database Migration Phases

```sql
-- Phase 1: Add new column (nullable)
ALTER TABLE users ADD COLUMN phone_normalized VARCHAR(20);

-- Phase 2: Backfill (batched)
UPDATE users SET phone_normalized = normalize_phone(phone)
WHERE phone_normalized IS NULL;

-- Phase 3: Add constraint
ALTER TABLE users ALTER COLUMN phone_normalized SET NOT NULL;

-- Phase 4: Create index
CREATE INDEX CONCURRENTLY idx_users_phone ON users(phone_normalized);

-- Phase 5: Drop old column (after verification)
ALTER TABLE users DROP COLUMN phone;
ALTER TABLE users RENAME COLUMN phone_normalized TO phone;
```

## Zero-Downtime Checklist

### Before Migration
- [ ] Migration tested in staging
- [ ] Rollback procedure documented
- [ ] Monitoring dashboards ready
- [ ] On-call team notified
- [ ] Backup completed

### During Migration
- [ ] Error rate monitored
- [ ] Latency monitored
- [ ] Data integrity checks running
- [ ] Rollback trigger conditions defined

### After Migration
- [ ] All metrics normal
- [ ] No customer complaints
- [ ] Old resources cleaned up
- [ ] Documentation updated
- [ ] Post-mortem completed (if issues)

## MCP Integration

- **sequential-thinking**: Plan complex multi-phase migrations

## References

- [database-migration-patterns.md](references/database-migration-patterns.md) - Schema change strategies
- [api-versioning.md](references/api-versioning.md) - API evolution patterns
- [zero-downtime.md](references/zero-downtime.md) - Deployment strategies

## Boundaries

### Will Do
- Design migration strategies and phases
- Create database migration scripts
- Implement API versioning
- Plan rollback procedures
- Set up feature flags for migrations
- Document migration runbooks
- Advise on zero-downtime approaches

### Will NOT Do
- Execute production migrations without explicit approval
- Make irreversible changes without confirmation
- Migrate without understanding rollback strategy
- Skip staging environment validation
- Perform migrations during high-traffic periods
