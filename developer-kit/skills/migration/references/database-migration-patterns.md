# Database Migration Patterns Reference

## Safe Schema Changes

### Column Operations

```sql
-- SAFE: Add nullable column
ALTER TABLE users ADD COLUMN middle_name VARCHAR(100);

-- SAFE: Add column with default (PG 11+, instant)
ALTER TABLE users ADD COLUMN status VARCHAR(20) DEFAULT 'active';

-- UNSAFE: Add NOT NULL without default
-- Instead, use three-step process:
ALTER TABLE users ADD COLUMN status VARCHAR(20);
UPDATE users SET status = 'active' WHERE status IS NULL;
ALTER TABLE users ALTER COLUMN status SET NOT NULL;

-- SAFE: Drop column (but be careful of dependencies)
ALTER TABLE users DROP COLUMN deprecated_field;

-- SAFE: Rename column (PostgreSQL)
ALTER TABLE users RENAME COLUMN old_name TO new_name;
```

### Table Operations

```sql
-- SAFE: Create new table
CREATE TABLE new_feature (...);

-- SAFE: Drop unused table
DROP TABLE IF EXISTS legacy_table;

-- RISKY: Rename table (breaks queries)
-- Use view instead:
ALTER TABLE old_name RENAME TO new_name;
CREATE VIEW old_name AS SELECT * FROM new_name;  -- Compatibility
```

### Index Operations

```sql
-- SAFE: Create index concurrently (no locks)
CREATE INDEX CONCURRENTLY idx_users_email ON users(email);

-- SAFE: Drop index concurrently
DROP INDEX CONCURRENTLY idx_old_index;

-- NOTE: CONCURRENTLY cannot run in a transaction
-- May need to run outside migration framework
```

## Large Table Migrations

### Batched Updates

```python
# Python example for batched migration
import time
from contextlib import contextmanager

def migrate_in_batches(
    session,
    query,
    update_fn,
    batch_size=1000,
    delay_seconds=0.1
):
    """Process records in batches to avoid long locks."""
    total_processed = 0

    while True:
        # Get batch with FOR UPDATE SKIP LOCKED
        batch = session.execute(
            query.limit(batch_size).with_for_update(skip_locked=True)
        ).fetchall()

        if not batch:
            break

        for record in batch:
            update_fn(record)

        session.commit()
        total_processed += len(batch)

        print(f"Processed {total_processed} records")
        time.sleep(delay_seconds)

    return total_processed

# Usage
migrate_in_batches(
    session,
    query=session.query(User).filter(User.email_normalized.is_(None)),
    update_fn=lambda u: setattr(u, 'email_normalized', u.email.lower()),
    batch_size=5000
)
```

### Background Migration Job

```ruby
# Rails-style background migration
class BackfillUserEmailNormalized < ApplicationJob
  BATCH_SIZE = 1000

  def perform(start_id = 0)
    records = User.where('id > ?', start_id)
                  .where(email_normalized: nil)
                  .limit(BATCH_SIZE)

    return if records.empty?

    records.each do |user|
      user.update_column(:email_normalized, user.email.downcase)
    end

    # Schedule next batch
    last_id = records.last.id
    self.class.perform_later(last_id)
  end
end
```

## Dual-Write Pattern

```javascript
// During migration: write to both old and new schema
class UserRepository {
  async create(userData) {
    const user = await db.transaction(async (trx) => {
      // Write to new schema
      const newUser = await trx('users_v2').insert({
        id: userData.id,
        email: userData.email,
        full_name: `${userData.first_name} ${userData.last_name}`
      }).returning('*');

      // Also write to old schema for backward compatibility
      await trx('users').insert({
        id: userData.id,
        email: userData.email,
        first_name: userData.first_name,
        last_name: userData.last_name
      });

      return newUser[0];
    });

    return user;
  }

  async findById(id) {
    // Read from new schema (or old during transition)
    const useNewSchema = await featureFlag.isEnabled('use_users_v2');

    if (useNewSchema) {
      return db('users_v2').where({ id }).first();
    }
    return db('users').where({ id }).first();
  }
}
```

## Data Validation

### Integrity Checks

```sql
-- Verify no orphaned records
SELECT COUNT(*) FROM orders o
LEFT JOIN users u ON o.user_id = u.id
WHERE u.id IS NULL;

-- Verify data transformation
SELECT COUNT(*) FROM users
WHERE email_normalized != LOWER(email);

-- Verify no data loss
SELECT
  (SELECT COUNT(*) FROM users_old) as old_count,
  (SELECT COUNT(*) FROM users_new) as new_count;

-- Verify referential integrity
SELECT COUNT(*) FROM order_items oi
WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.id = oi.order_id);
```

### Automated Validation Script

```python
def validate_migration():
    checks = []

    # Check row counts match
    old_count = db.execute("SELECT COUNT(*) FROM users_old").scalar()
    new_count = db.execute("SELECT COUNT(*) FROM users_new").scalar()
    checks.append(("Row count match", old_count == new_count))

    # Check no nulls in required fields
    null_emails = db.execute(
        "SELECT COUNT(*) FROM users_new WHERE email IS NULL"
    ).scalar()
    checks.append(("No null emails", null_emails == 0))

    # Check data transformation correct
    mismatches = db.execute("""
        SELECT COUNT(*) FROM users_old o
        JOIN users_new n ON o.id = n.id
        WHERE n.full_name != (o.first_name || ' ' || o.last_name)
    """).scalar()
    checks.append(("Name transformation correct", mismatches == 0))

    # Report results
    for name, passed in checks:
        status = "✓" if passed else "✗"
        print(f"{status} {name}")

    return all(passed for _, passed in checks)
```

## Rollback Strategies

### Schema Rollback

```sql
-- Always create reversible migrations
-- up.sql
ALTER TABLE users ADD COLUMN phone_verified BOOLEAN DEFAULT FALSE;

-- down.sql
ALTER TABLE users DROP COLUMN phone_verified;
```

### Data Rollback with Backup Table

```sql
-- Before migration: create backup
CREATE TABLE users_backup AS SELECT * FROM users;

-- If rollback needed:
TRUNCATE users;
INSERT INTO users SELECT * FROM users_backup;

-- After successful migration:
DROP TABLE users_backup;
```

### Point-in-Time Recovery

```sql
-- PostgreSQL: Use pg_dump before migration
-- pg_dump -Fc mydb > backup_before_migration.dump

-- Restore if needed:
-- pg_restore -d mydb backup_before_migration.dump
```
