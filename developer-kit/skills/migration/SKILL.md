---
name: migration
description: "Plan and execute zero-downtime migrations for databases, APIs, and services. Activates for: 'migrate database', 'data migration', 'upgrade API', 'deprecate endpoint', 'backward compatible', 'breaking change', 'version upgrade', 'zero-downtime migration'."
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
  # Migration Documentation
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  # Pattern Research
  - mcp__github__search_code
  - mcp__github__get_file_contents
  # Best Practices Research
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  # Complex Migration Planning
  - mcp__sequential-thinking__sequentialthinking
---

# Migration Skill

Enable safe, reversible migrations of databases, APIs, and services with zero downtime, proper versioning, and rollback strategies using official documentation and industry best practices.

## Activation Triggers

- Database migrations ("migrate database", "schema migration", "data migration")
- API versioning ("upgrade API", "deprecate endpoint", "version API")
- Breaking changes ("plan breaking change", "backward compatible")
- Deployment strategies ("blue-green deployment", "canary release")
- Feature flags ("feature flag migration", "gradual rollout")
- Service migrations ("migrate from X to Y", "service upgrade")

## Do NOT Activate When

- Simple database column addition → use `database` skill
- New feature development without migration → use `implement` skill
- Infrastructure provisioning → use `devops` skill
- Routine deployments without data changes
- Database schema design from scratch → use `database` skill

## Behavioral Flow

```
┌──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
│    ASSESS    │   RESEARCH   │    DESIGN    │  IMPLEMENT   │   VALIDATE   │
├──────────────┼──────────────┼──────────────┼──────────────┼──────────────┤
│ Identify     │ Lookup       │ Choose       │ Create       │ Test in      │
│ migration    │ official     │ strategy     │ migration    │ staging      │
│ scope        │ docs         │              │ scripts      │              │
│              │              │              │              │              │
│ Map          │ Find         │ Plan         │ Implement    │ Verify       │
│ dependencies │ patterns     │ phases       │ rollback     │ data         │
│              │              │              │              │ integrity    │
│              │              │              │              │              │
│ Evaluate     │ Research     │ Design       │ Add          │ Monitor      │
│ rollback     │ best         │ rollback     │ monitoring   │ metrics      │
│ requirements │ practices    │              │              │              │
└──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘
     Read           Context7      Sequential      Write          Bash
     Grep           GitHub        Thinking        Edit           (test)
                    Tavily
```

### Phase 1: ASSESS

Understand migration scope before planning:

1. **Identify what is being migrated** - Data, schema, API, service
2. **Map dependencies** - Downstream consumers, related services
3. **Evaluate data volume** - Size, transformation complexity
4. **Identify rollback requirements** - Recovery time objective (RTO)

**Tools**: Read, Grep, Glob

### Phase 2: RESEARCH

Gather official documentation and community patterns:

```
# Lookup Prisma migration documentation
mcp__context7__resolve-library-id → "/prisma/docs"
mcp__context7__query-docs("prisma migrate deploy production")

# Lookup Flyway patterns
mcp__context7__resolve-library-id → "/flyway/flyway"
mcp__context7__query-docs("versioned migration rollback")

# Find real-world migration patterns
mcp__github__search_code("exports.up exports.down filename:migration")

# Research zero-downtime strategies
mcp__tavily__tavily-search("zero-downtime database migration expand contract 2024")
```

**Tools**: Context7, GitHub MCP, Tavily

### Phase 3: DESIGN

Plan migration strategy with structured reasoning:

```
mcp__sequential-thinking__sequentialthinking
- Choose migration strategy (expand/contract, blue/green, canary)
- Plan migration phases with dependencies
- Design rollback procedure for each phase
- Define success criteria and monitoring
- Estimate data transformation time
```

**Strategy Selection:**

- **Expand/Contract**: Schema changes with backward compatibility
- **Blue/Green**: Full environment cutover with instant rollback
- **Canary**: Gradual traffic shift with monitoring
- **Feature Flags**: Runtime toggles for new behavior

**Tools**: Sequential Thinking

### Phase 4: IMPLEMENT

Create migration artifacts:

1. **Migration scripts** - Forward and rollback migrations
2. **Dual-write code** - If expand/contract pattern
3. **Feature flags** - For gradual rollout
4. **Monitoring** - Metrics and alerts for migration health
5. **Runbook** - Step-by-step execution guide

**Tools**: Write, Edit, Bash

### Phase 5: VALIDATE

Test and verify migration:

```bash
# Test migrations in development
npm run migrate:dev

# Dry-run in staging
npm run migrate:dry-run

# Verify rollback works
npm run migrate:rollback && npm run migrate:up

# Data integrity check
npm run test:db:integrity

# Performance benchmark
npm run benchmark:queries
```

**Tools**: Bash

## MCP Integration

### Context7 (Official Documentation)

**Primary source for migration tool documentation:**

```
mcp__context7__resolve-library-id - Resolve Prisma, Flyway, Liquibase IDs
mcp__context7__query-docs - Get official migration documentation
```

**Available Resources:**

| Resource  | Library ID                  | Snippets |
| --------- | --------------------------- | -------- |
| Prisma    | `/prisma/docs`              | 4,691    |
| Liquibase | `/liquibase/liquibase-docs` | 2,111    |
| Flyway    | `/flyway/flyway`            | 1,376    |
| Knex.js   | `/knex/knex`                | 441      |

**Use cases:**

- "Prisma migrate deploy vs dev differences"
- "Flyway versioned vs repeatable migrations"
- "Liquibase rollback one changeset"
- "Knex migration batch rollback"
- "Prisma shadow database configuration"

### GitHub MCP (Pattern Research)

**Find real-world migration patterns:**

```
mcp__github__search_code - Find migration scripts in repos
mcp__github__get_file_contents - Get specific migration files
```

**Search patterns:**

```
# Find Knex/Node migrations
"exports.up" "exports.down" filename:migration

# Find Prisma schema migrations
"model" "@@map" "@@ignore" filename:schema.prisma

# Find Liquibase changesets
"changeset" "rollback" filename:.xml

# Find Flyway migrations
"CREATE TABLE" "ALTER TABLE" filename:V__

# Find expand-contract patterns
"dual_write" OR "dual-write" filename:.ts
```

**Use cases:**

- Find how large projects structure migrations
- Research expand-contract implementation patterns
- Get rollback strategy examples
- Study API versioning in production codebases

### Tavily (Best Practices Research)

**Research migration best practices:**

```
mcp__tavily__tavily-search - Research zero-downtime strategies
mcp__tavily__tavily-extract - Extract from migration articles
```

**Use cases:**

- "Zero-downtime database migration strategies 2024"
- "Expand contract pattern implementation guide"
- "API versioning backward compatibility best practices"
- "Feature flag migration rollout strategies"
- "Blue-green deployment database considerations"

### Sequential Thinking (Migration Planning)

**Structured reasoning for complex migrations:**

```
mcp__sequential-thinking__sequentialthinking - Multi-phase migration planning
```

**Use for:**

- Multi-phase migration sequencing
- Dependency analysis between migration steps
- Risk assessment and mitigation planning
- Rollback scenario modeling
- Data transformation strategy design

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

| Strategy    | URL Example                                  | Use Case                         |
| ----------- | -------------------------------------------- | -------------------------------- |
| URL Path    | `/api/v2/users`                              | Major versions, clear separation |
| Header      | `Accept: application/vnd.api+json;version=2` | Minor versions, same URL         |
| Query Param | `/api/users?version=2`                       | Testing, gradual rollout         |

### Database Migration Phases

```sql
-- Phase 1: Add new column (nullable)
ALTER TABLE users ADD COLUMN phone_normalized VARCHAR(20);

-- Phase 2: Backfill (batched)
UPDATE users SET phone_normalized = normalize_phone(phone)
WHERE phone_normalized IS NULL
LIMIT 1000;

-- Phase 3: Add constraint
ALTER TABLE users ALTER COLUMN phone_normalized SET NOT NULL;

-- Phase 4: Create index (non-blocking)
CREATE INDEX CONCURRENTLY idx_users_phone ON users(phone_normalized);

-- Phase 5: Drop old column (after verification)
ALTER TABLE users DROP COLUMN phone;
ALTER TABLE users RENAME COLUMN phone_normalized TO phone;
```

## Zero-Downtime Checklist

### Before Migration

- [ ] Migration tested in staging
- [ ] Rollback procedure documented and tested
- [ ] Monitoring dashboards ready
- [ ] On-call team notified
- [ ] Database backup completed
- [ ] Consumer services notified

### During Migration

- [ ] Error rate monitored
- [ ] Latency monitored
- [ ] Data integrity checks running
- [ ] Rollback trigger conditions defined
- [ ] Communication channel open

### After Migration

- [ ] All metrics normal for 24h
- [ ] No customer complaints
- [ ] Old resources cleaned up
- [ ] Documentation updated
- [ ] Post-mortem completed (if issues)

## Reference Files

For detailed patterns and examples, see:

- `references/database-migration-patterns.md` - Schema change strategies
- `references/api-versioning.md` - API evolution patterns
- `references/zero-downtime.md` - Deployment strategies

## Handoffs

| Scenario                    | Hand off to           |
| --------------------------- | --------------------- |
| Need database schema design | `database` skill      |
| Need infrastructure changes | `devops` skill        |
| Need API implementation     | `implement` skill     |
| Need monitoring setup       | `observability` skill |
| Need security review        | `security` skill      |

## Boundaries

**Will:**

- Design migration strategies and phases
- Create database migration scripts
- Implement API versioning patterns
- Plan rollback procedures
- Set up feature flags for migrations
- Document migration runbooks
- Advise on zero-downtime approaches
- Research best practices via MCP tools

**Will Not:**

- Execute production migrations without explicit approval
- Make irreversible changes without confirmation
- Migrate without understanding rollback strategy
- Skip staging environment validation
- Perform migrations during high-traffic periods
- Provision infrastructure (use `devops` skill)
