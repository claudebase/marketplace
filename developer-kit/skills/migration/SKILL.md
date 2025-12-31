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
  - mcp__github__search_repositories
  # Best Practices Research
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  # Complex Migration Planning
  - mcp__sequential-thinking__sequentialthinking
---

# Migration Skill

Enable safe, reversible migrations of databases, APIs, and services with zero downtime, proper versioning, and rollback strategies using official documentation and industry best practices.

**Core Principle**: "Migrate safely, verify continuously, rollback gracefully."

**Key Enhancement**: Research migration tool documentation, zero-downtime patterns, and expand-contract strategies via MCP tools before designing migration plans.

## Activation Triggers

### Database Migrations

- "migrate database", "schema migration", "data migration"
- "add column", "rename table", "change data type"
- "backfill data", "data transformation"

### API Versioning

- "upgrade API", "deprecate endpoint", "version API"
- "breaking change", "backward compatible"
- "API sunset", "endpoint migration"

### Deployment Strategies

- "blue-green deployment", "canary release"
- "feature flag migration", "gradual rollout"
- "zero-downtime migration"

### Service Migrations

- "migrate from X to Y", "service upgrade"
- "ORM migration", "database switch"

## Do NOT Activate When

- Simple database column addition -> use `database` skill
- New feature development without migration -> use `implement` skill
- Infrastructure provisioning -> use `devops` skill
- Routine deployments without data changes
- Database schema design from scratch -> use `database` skill

**Boundary Clarification:**
This skill plans and executes migrations with rollback strategies. For initial schema design, use `database` skill. For infrastructure changes, use `devops` skill.

## Behavioral Flow

```
+--------------+--------------+--------------+--------------+--------------+
|    ASSESS    |   RESEARCH   |    DESIGN    |  IMPLEMENT   |   VALIDATE   |
+--------------+--------------+--------------+--------------+--------------+
| Identify     | Lookup       | Choose       | Create       | Test in      |
| migration    | official     | strategy     | migration    | staging      |
| scope        | docs         |              | scripts      |              |
|              |              |              |              |              |
| Map          | Find         | Plan         | Implement    | Verify       |
| dependencies | patterns     | phases       | rollback     | data         |
|              |              |              |              | integrity    |
|              |              |              |              |              |
| Evaluate     | Research     | Design       | Add          | Monitor      |
| rollback     | best         | rollback     | monitoring   | metrics      |
| requirements | practices    |              |              |              |
+--------------+--------------+--------------+--------------+--------------+
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
5. **Assess current ORM/migration tool** - Prisma, Drizzle, TypeORM, Knex, Django, etc.

```bash
# Find existing migrations
Glob - "**/migrations/**", "**/db/migrate/**"

# Identify ORM in use
Grep - "prisma|drizzle|typeorm|sequelize|knex" in package.json

# Check migration history
Read - Migration files to understand patterns
```

**Tools**: Read, Grep, Glob

### Phase 2: RESEARCH

Gather official documentation and community patterns:

```
# Lookup Prisma migration documentation
mcp__context7__resolve-library-id -> "/prisma/docs"
mcp__context7__query-docs("prisma migrate deploy production shadow database")

# Lookup Drizzle Kit patterns
mcp__context7__resolve-library-id -> "/drizzle-team/drizzle-orm-docs"
mcp__context7__query-docs("drizzle-kit generate push migrate")

# Lookup TypeORM migrations
mcp__context7__resolve-library-id -> "/typeorm/typeorm"
mcp__context7__query-docs("migration generate run revert")

# Lookup Knex.js migrations
mcp__context7__resolve-library-id -> "/knex/knex"
mcp__context7__query-docs("migrate latest rollback batch")

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
- Plan dual-write period if needed
```

**Strategy Selection:**

| Strategy        | Use Case                         | Rollback Speed | Complexity |
| --------------- | -------------------------------- | -------------- | ---------- |
| Expand/Contract | Schema changes, column renames   | Instant        | Medium     |
| Blue/Green      | Full environment cutover         | Instant        | High       |
| Canary          | Gradual traffic shift            | Fast           | Medium     |
| Feature Flags   | Runtime toggles for new behavior | Instant        | Low        |
| Shadow Tables   | Large data transformations       | Fast           | High       |

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

### Context7 (Migration Tool Documentation)

**Primary source for ORM and migration tool documentation:**

```
mcp__context7__resolve-library-id - Resolve Prisma, Drizzle, TypeORM, etc.
mcp__context7__query-docs - Get official migration documentation
```

**Available Resources:**

| Resource    | Library ID                              | Snippets | Use Case                             |
| ----------- | --------------------------------------- | -------- | ------------------------------------ |
| Prisma      | `/prisma/docs`                          | 4,691    | Prisma Migrate, deploy, baseline     |
| Drizzle ORM | `/drizzle-team/drizzle-orm-docs`        | 2,553    | Drizzle Kit generate, push           |
| TypeORM     | `/typeorm/typeorm`                      | 1,134    | TypeORM migrations CLI               |
| Mikro-ORM   | `/mikro-orm/mikro-orm`                  | 1,034    | Mikro-ORM migrations                 |
| Sequelize   | `/sequelize/website`                    | 8,403    | Sequelize migrations, queryInterface |
| Knex.js     | `/knex/knex`                            | 441      | Knex migrate:latest, rollback        |
| Liquibase   | `/liquibase/liquibase-docs`             | 2,111    | Liquibase changesets, rollback       |
| Flyway      | `/flyway/flyway`                        | 1,376    | Flyway versioned migrations          |
| Django      | `/websites/djangoproject_en_5_2`        | 3,585    | Django makemigrations, migrate       |
| Alembic     | `/sqlalchemy/alembic`                   | 363      | SQLAlchemy migrations                |
| PostgreSQL  | `/websites/postgresql`                  | 61,065   | ALTER TABLE, CREATE INDEX            |
| MySQL       | `/websites/dev_mysql_doc_refman_9_4_en` | 19,896   | MySQL DDL statements                 |
| MongoDB     | `/mongodb/docs`                         | 22,287   | MongoDB schema validation            |
| Mongoose    | `/websites/mongoosejs`                  | 11,893   | Mongoose schema versioning           |

**Query Patterns by Tool:**

| Tool      | Query Pattern                                         |
| --------- | ----------------------------------------------------- |
| Prisma    | `"prisma migrate deploy production shadow database"`  |
| Drizzle   | `"drizzle-kit generate push migrate schema"`          |
| TypeORM   | `"migration:generate migration:run migration:revert"` |
| Knex      | `"migrate:latest migrate:rollback batch"`             |
| Django    | `"makemigrations migrate squashmigrations"`           |
| Liquibase | `"changeset rollback tag preconditions"`              |
| Flyway    | `"versioned repeatable baseline repair"`              |

### GitHub MCP (Pattern Research)

**Find real-world migration patterns:**

```
mcp__github__search_code - Find migration scripts in repos
mcp__github__get_file_contents - Get specific migration files
mcp__github__search_repositories - Find migration examples
```

**Search Patterns:**

```
# Find Knex/Node migrations
"exports.up" "exports.down" filename:migration stars:>100

# Find Prisma schema migrations
"model" "@@map" "@@ignore" filename:schema.prisma

# Find TypeORM migrations
"MigrationInterface" "QueryRunner" filename:.ts

# Find Sequelize migrations
"queryInterface" "createTable" filename:migration

# Find Drizzle migrations
"sqliteTable" "pgTable" "mysqlTable" filename:.ts

# Find Liquibase changesets
"changeset" "rollback" filename:.xml

# Find Flyway migrations
"CREATE TABLE" "ALTER TABLE" filename:V__

# Find expand-contract patterns
"dual_write" OR "dual-write" filename:.ts stars:>50

# Find Django migrations
"migrations.RunPython" "migrations.AlterField" filename:.py
```

**Use Cases:**

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

**Search Queries:**

- "Zero-downtime database migration strategies 2024"
- "Expand contract pattern implementation guide"
- "API versioning backward compatibility best practices"
- "Feature flag migration rollout strategies"
- "Blue-green deployment database considerations"
- "PostgreSQL online schema migration techniques"
- "Large table migration without locking"

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

## ORM-Specific Migration Patterns

### Prisma Migrate

```bash
# Development: create and apply migration
npx prisma migrate dev --name add_user_email

# Production: apply pending migrations
npx prisma migrate deploy

# Reset database (development only)
npx prisma migrate reset

# Create migration without applying
npx prisma migrate dev --create-only

# Baseline existing database
npx prisma migrate resolve --applied "init"
```

**Key Concepts:**

- `migrate dev` - Development workflow with shadow database
- `migrate deploy` - Production deployment (no shadow DB)
- `migrate reset` - Reset and reapply all migrations
- Shadow database for drift detection

### Drizzle Kit

```bash
# Generate migration from schema changes
npx drizzle-kit generate

# Apply migrations to database
npx drizzle-kit migrate

# Push schema directly (prototyping)
npx drizzle-kit push

# Pull schema from existing database
npx drizzle-kit pull

# Check schema status
npx drizzle-kit check
```

**Key Concepts:**

- `generate` - Create SQL migration files
- `push` - Direct schema sync (no migration files)
- `migrate` - Apply generated migrations
- Migrations stored in `drizzle/` directory

### TypeORM

```bash
# Generate migration from entity changes
npx typeorm migration:generate -d ./data-source.ts AddUserEmail

# Create empty migration
npx typeorm migration:create ./migrations/AddUserEmail

# Run pending migrations
npx typeorm migration:run -d ./data-source.ts

# Revert last migration
npx typeorm migration:revert -d ./data-source.ts

# Show migration status
npx typeorm migration:show -d ./data-source.ts
```

**Migration Template:**

```typescript
import { MigrationInterface, QueryRunner } from "typeorm";

export class AddUserEmail1234567890123 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
      ALTER TABLE "user" ADD "email" varchar(255)
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
      ALTER TABLE "user" DROP COLUMN "email"
    `);
  }
}
```

### Knex.js

```bash
# Create new migration
npx knex migrate:make add_user_email

# Run all pending migrations
npx knex migrate:latest

# Rollback last batch
npx knex migrate:rollback

# Rollback all migrations
npx knex migrate:rollback --all

# Run next pending migration
npx knex migrate:up

# Undo specific migration
npx knex migrate:down 001_add_user_email.js
```

**Migration Template:**

```javascript
exports.up = function (knex) {
  return knex.schema.alterTable("users", (table) => {
    table.string("email", 255);
  });
};

exports.down = function (knex) {
  return knex.schema.alterTable("users", (table) => {
    table.dropColumn("email");
  });
};
```

### Django Migrations

```bash
# Create migrations from model changes
python manage.py makemigrations

# Apply pending migrations
python manage.py migrate

# Show migration plan
python manage.py migrate --plan

# Fake a migration (mark as applied)
python manage.py migrate --fake app_name 0001

# Squash migrations
python manage.py squashmigrations app_name 0001 0004
```

**Data Migration Example:**

```python
from django.db import migrations

def populate_email(apps, schema_editor):
    User = apps.get_model('myapp', 'User')
    for user in User.objects.filter(email__isnull=True):
        user.email = f"{user.username}@example.com"
        user.save()

def reverse_populate(apps, schema_editor):
    pass  # No reverse needed

class Migration(migrations.Migration):
    dependencies = [
        ('myapp', '0001_initial'),
    ]

    operations = [
        migrations.RunPython(populate_email, reverse_populate),
    ]
```

### Sequelize

```bash
# Create migration
npx sequelize migration:create --name add-user-email

# Run pending migrations
npx sequelize db:migrate

# Undo last migration
npx sequelize db:migrate:undo

# Undo all migrations
npx sequelize db:migrate:undo:all
```

**Migration Template:**

```javascript
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.addColumn("Users", "email", {
      type: Sequelize.STRING(255),
      allowNull: true,
    });
  },

  async down(queryInterface, Sequelize) {
    await queryInterface.removeColumn("Users", "email");
  },
};
```

## Migration Patterns

### Expand-Contract Pattern (Parallel Change)

The safest approach for zero-downtime schema changes:

```
Phase 1: EXPAND
+------------------+     +------------------+
| users            |     | users            |
+------------------+     +------------------+
| id               | --> | id               |
| name             |     | name             |
| phone (old)      |     | phone (old)      |
+------------------+     | phone_new (new)  |  <- Add new column
                         +------------------+

Phase 2: MIGRATE
- Deploy code that writes to BOTH columns
- Backfill existing data: phone_new = normalize(phone)
- Update reads to prefer phone_new

Phase 3: CONTRACT
+------------------+     +------------------+
| users            |     | users            |
+------------------+     +------------------+
| id               | --> | id               |
| name             |     | name             |
| phone (old)      |     | phone (renamed)  |  <- Drop old, rename new
| phone_new (new)  |     +------------------+
+------------------+
```

**Implementation Steps:**

```sql
-- Phase 1: Add new column (nullable)
ALTER TABLE users ADD COLUMN phone_normalized VARCHAR(20);

-- Phase 2: Backfill (batched for large tables)
UPDATE users SET phone_normalized = normalize_phone(phone)
WHERE phone_normalized IS NULL
LIMIT 10000;

-- Phase 3: Add constraint after backfill complete
ALTER TABLE users ALTER COLUMN phone_normalized SET NOT NULL;

-- Phase 4: Create index (non-blocking in PostgreSQL)
CREATE INDEX CONCURRENTLY idx_users_phone ON users(phone_normalized);

-- Phase 5: Drop old column (after verification period)
ALTER TABLE users DROP COLUMN phone;
ALTER TABLE users RENAME COLUMN phone_normalized TO phone;
```

### Large Table Migration (Batched)

For tables with millions of rows:

```javascript
// Batched backfill migration
const BATCH_SIZE = 10000;

async function backfillInBatches(knex) {
  let processed = 0;
  let hasMore = true;

  while (hasMore) {
    const result = await knex.raw(`
      UPDATE users
      SET phone_normalized = normalize_phone(phone)
      WHERE phone_normalized IS NULL
      LIMIT ${BATCH_SIZE}
    `);

    processed += result.affectedRows;
    hasMore = result.affectedRows === BATCH_SIZE;

    console.log(`Processed ${processed} rows`);

    // Small delay to reduce database load
    await new Promise((r) => setTimeout(r, 100));
  }
}
```

### Shadow Table Pattern

For complex transformations:

```sql
-- 1. Create shadow table with new schema
CREATE TABLE users_v2 (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  email VARCHAR(255) NOT NULL,
  phone VARCHAR(20)
);

-- 2. Set up trigger for ongoing writes
CREATE TRIGGER sync_users_to_v2
AFTER INSERT OR UPDATE ON users
FOR EACH ROW EXECUTE FUNCTION sync_to_users_v2();

-- 3. Backfill existing data
INSERT INTO users_v2 (id, name, email, phone)
SELECT id, name, COALESCE(email, 'unknown@example.com'), phone
FROM users;

-- 4. Swap tables atomically
BEGIN;
ALTER TABLE users RENAME TO users_old;
ALTER TABLE users_v2 RENAME TO users;
COMMIT;

-- 5. Drop old table after verification
DROP TABLE users_old;
```

### API Versioning Strategies

| Strategy    | URL Example                                  | Use Case                         |
| ----------- | -------------------------------------------- | -------------------------------- |
| URL Path    | `/api/v2/users`                              | Major versions, clear separation |
| Header      | `Accept: application/vnd.api+json;version=2` | Minor versions, same URL         |
| Query Param | `/api/users?version=2`                       | Testing, gradual rollout         |

**Deprecation Header Pattern:**

```typescript
// Express middleware for API deprecation
app.use("/api/v1/*", (req, res, next) => {
  res.set("Deprecation", "true");
  res.set("Sunset", "Sat, 31 Dec 2024 23:59:59 GMT");
  res.set("Link", '</api/v2>; rel="successor-version"');
  next();
});
```

### Feature Flag Migration

```typescript
// Gradual rollout with feature flags
import { getFeatureFlag } from "./feature-flags";

async function getUser(id: string) {
  const useNewSchema = await getFeatureFlag("new-user-schema", {
    userId: id,
    percentage: 10, // Start with 10% of users
  });

  if (useNewSchema) {
    return getUserFromNewSchema(id);
  }
  return getUserFromOldSchema(id);
}
```

## Zero-Downtime Checklist

### Before Migration

- [ ] Migration tested in staging with production-like data
- [ ] Rollback procedure documented and tested
- [ ] Monitoring dashboards ready (error rates, latency, data integrity)
- [ ] On-call team notified with runbook
- [ ] Database backup completed and verified
- [ ] Consumer services notified of potential impact
- [ ] Traffic analysis done (avoid peak hours)
- [ ] Lock timeouts configured for DDL operations

### During Migration

- [ ] Error rate monitored against baseline
- [ ] Latency percentiles monitored (p50, p95, p99)
- [ ] Data integrity checks running continuously
- [ ] Rollback trigger conditions clearly defined
- [ ] Communication channel open with stakeholders
- [ ] Progress logged with timestamps
- [ ] Resource utilization monitored (CPU, memory, connections)

### After Migration

- [ ] All metrics normal for 24-48 hours
- [ ] No customer complaints or bug reports
- [ ] Old resources cleaned up (columns, tables, endpoints)
- [ ] Documentation updated (schema diagrams, API docs)
- [ ] Post-mortem completed (even if successful)
- [ ] Runbook updated with lessons learned
- [ ] Feature flags removed (if used for rollout)

## Database-Specific Considerations

### PostgreSQL

```sql
-- Non-blocking index creation
CREATE INDEX CONCURRENTLY idx_users_email ON users(email);

-- Non-blocking column addition (nullable)
ALTER TABLE users ADD COLUMN email VARCHAR(255);

-- AVOID: Adding NOT NULL without default blocks table
-- BAD: ALTER TABLE users ADD COLUMN email VARCHAR(255) NOT NULL;

-- GOOD: Add nullable, backfill, then add constraint
ALTER TABLE users ADD COLUMN email VARCHAR(255);
-- ... backfill ...
ALTER TABLE users ALTER COLUMN email SET NOT NULL;

-- Set lock timeout to avoid long waits
SET lock_timeout = '5s';
```

### MySQL

```sql
-- Online DDL (MySQL 5.6+)
ALTER TABLE users ADD COLUMN email VARCHAR(255), ALGORITHM=INPLACE, LOCK=NONE;

-- pt-online-schema-change for older versions or complex changes
pt-online-schema-change --alter "ADD COLUMN email VARCHAR(255)" D=mydb,t=users

-- Check for long-running queries before DDL
SELECT * FROM information_schema.processlist
WHERE time > 30 AND command != 'Sleep';
```

### MongoDB

```javascript
// Schema validation for gradual enforcement
db.runCommand({
  collMod: "users",
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["email"],
      properties: {
        email: {
          bsonType: "string",
          description: "must be a string and is required",
        },
      },
    },
  },
  validationLevel: "moderate", // Only validate updates
  validationAction: "warn", // Log but don't reject
});

// Background index creation
db.users.createIndex({ email: 1 }, { background: true });
```

## Output Format

```markdown
## Migration Plan: [Description]

### Overview

| Aspect           | Details                             |
| ---------------- | ----------------------------------- |
| Type             | [Schema/Data/API/Service]           |
| Strategy         | [Expand-Contract/Blue-Green/Canary] |
| Estimated Impact | [None/Low/Medium/High]              |
| Rollback Time    | [Instant/Minutes/Hours]             |

### Research Applied

- Tool documentation: [Prisma/Drizzle/TypeORM/etc.]
- Pattern reference: [GitHub examples found]
- Best practices: [Zero-downtime strategies]

### Migration Phases

#### Phase 1: Expand

- [ ] Add new column/table/endpoint
- [ ] Deploy dual-write code
- [ ] Backfill existing data

#### Phase 2: Migrate

- [ ] Update consumers to read new format
- [ ] Verify all systems functioning
- [ ] Monitor for 24-48 hours

#### Phase 3: Contract

- [ ] Remove old column/table/endpoint
- [ ] Clean up dual-write code
- [ ] Update documentation

### Rollback Plan

1. [Step-by-step rollback procedure]
2. [Data recovery if needed]
3. [Communication plan]

### Success Criteria

- [ ] All data migrated with integrity verified
- [ ] No increase in error rates
- [ ] Latency within acceptable bounds
- [ ] All consumers functioning correctly
```

## Reference Files

For detailed patterns and examples, see:

- `references/database-migration-patterns.md` - Schema change strategies
- `references/api-versioning.md` - API evolution patterns
- `references/zero-downtime.md` - Deployment strategies
- `references/orm-migrations.md` - ORM-specific guides

## Handoffs

| Scenario                    | Hand off to           |
| --------------------------- | --------------------- |
| Need database schema design | `database` skill      |
| Need infrastructure changes | `devops` skill        |
| Need API implementation     | `implement` skill     |
| Need monitoring setup       | `observability` skill |
| Need security review        | `security` skill      |
| Need container deployment   | `containers` skill    |

## Boundaries

**Will:**

- Design migration strategies and phases
- Create database migration scripts for all major ORMs
- Implement API versioning patterns
- Plan rollback procedures with clear steps
- Set up feature flags for migrations
- Document migration runbooks
- Advise on zero-downtime approaches
- Research best practices via MCP tools
- Handle expand-contract pattern implementation
- Plan batched migrations for large tables

**Will Not:**

- Execute production migrations without explicit approval
- Make irreversible changes without confirmation
- Migrate without understanding rollback strategy
- Skip staging environment validation
- Perform migrations during high-traffic periods
- Provision infrastructure (use `devops` skill)
- Design new schemas from scratch (use `database` skill)
