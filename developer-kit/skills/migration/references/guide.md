# Migration Skill - Detailed Guide

Enable safe, reversible migrations of databases, APIs, and services with zero downtime, proper versioning, and rollback strategies.

**Core Principle**: "Migrate safely, verify continuously, rollback gracefully."

---

## Behavioral Flow

```
┌──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
│    ASSESS    │   RESEARCH   │     PLAN     │  IMPLEMENT   │   VERIFY     │
├──────────────┼──────────────┼──────────────┼──────────────┼──────────────┤
│ Identify     │ Query docs   │ Design       │ Apply        │ Test data    │
│ current      │ for migration│ expand-      │ migrations   │ integrity    │
│ state        │ patterns     │ contract     │ in phases    │ and API      │
│              │              │ strategy     │              │ compatibility│
│ Map          │ Find         │ Create       │ Execute      │ Validate     │
│ dependencies │ examples     │ rollback     │ step by      │ rollback     │
│ and risks    │              │ plan         │ step         │ works        │
└──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘
     Read           Context7      Sequential      Write         Bash
     Grep           GitHub        Thinking        Edit
                    Tavily
```

---

## The Expand-Contract Pattern

The safest approach for breaking changes:

```
Phase 1: EXPAND
├── Add new schema/API alongside old
├── Both versions work simultaneously
└── Backward compatible - no breaking changes

Phase 2: MIGRATE
├── Transition consumers to new version
├── Migrate data if needed
└── Monitor for issues

Phase 3: CONTRACT
├── Remove old schema/API after verification
├── Clean up deprecated code
└── Update documentation
```

---

## Migration Types

### Database Migrations

**Schema changes with zero downtime:**

```sql
-- Phase 1: EXPAND - Add new column
ALTER TABLE users ADD COLUMN email_verified BOOLEAN DEFAULT false;

-- Phase 2: MIGRATE - Backfill data
UPDATE users SET email_verified = true WHERE verified_at IS NOT NULL;

-- Phase 3: CONTRACT - Remove old column (after verification)
ALTER TABLE users DROP COLUMN verified_at;
```

**Using ORMs:**

```python
# Prisma
prisma migrate dev --name add_email_verified

# Alembic
alembic revision --autogenerate -m "add email verified"
alembic upgrade head
```

### API Versioning

**Deprecation with sunset period:**

```typescript
// Old endpoint - mark deprecated
app.get("/api/v1/users", deprecationMiddleware, getUsers);

// New endpoint
app.get("/api/v2/users", getUsersV2);

// Deprecation middleware
function deprecationMiddleware(req, res, next) {
  res.set("Deprecation", "true");
  res.set("Sunset", "Sat, 01 Jan 2025 00:00:00 GMT");
  next();
}
```

### Data Migrations

**Large-scale data transformations:**

```python
# Batch processing for large datasets
BATCH_SIZE = 1000

def migrate_data():
    offset = 0
    while True:
        batch = db.query(OldModel).offset(offset).limit(BATCH_SIZE).all()
        if not batch:
            break

        for item in batch:
            new_item = transform(item)
            db.add(new_item)

        db.commit()
        offset += BATCH_SIZE
```

---

## MCP Tool Integration

### Context7 (Migration Docs)

| Resource | Library ID                   | Use Case            |
| -------- | ---------------------------- | ------------------- |
| Prisma   | `/prisma/docs`               | Database migrations |
| Alembic  | `/sqlalchemy/alembic`        | Python migrations   |
| OpenAPI  | `/oai/openapi-specification` | API versioning      |

### GitHub MCP

**Find migration examples:**

```
mcp__github__search_code("expand contract migration")
mcp__github__search_code("zero downtime deployment")
```

---

## Rollback Strategies

### Database Rollback

```sql
-- Always have a reverse migration ready
-- Forward
ALTER TABLE users ADD COLUMN new_field TEXT;

-- Rollback
ALTER TABLE users DROP COLUMN new_field;
```

### Feature Flags

```typescript
// Use feature flags for gradual rollout
if (featureFlags.isEnabled("new-api")) {
  return newImplementation();
} else {
  return oldImplementation();
}
```

---

## Verification Checklist

Before completing migration:

- [ ] Data integrity verified (counts match, no corruption)
- [ ] All consumers migrated to new version
- [ ] Performance acceptable (no degradation)
- [ ] Rollback tested and documented
- [ ] Monitoring in place for new version
- [ ] Old version ready for removal

---

## Handoffs

| Scenario              | Hand off to         |
| --------------------- | ------------------- |
| Simple schema changes | `database` skill    |
| New feature needed    | `implement` skill   |
| Performance issues    | `performance` skill |

---

## Related Reference Files

- [zero-downtime.md](zero-downtime.md) - Safe migration patterns
- [database-migration-patterns.md](database-migration-patterns.md) - Schema changes
- [api-versioning.md](api-versioning.md) - Deprecation strategies
