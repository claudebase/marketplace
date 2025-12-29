# Migration Patterns Reference

## Migration Best Practices

### 1. Always Make Migrations Reversible

```javascript
// Knex.js example
exports.up = function(knex) {
  return knex.schema.createTable('users', (table) => {
    table.uuid('id').primary().defaultTo(knex.raw('gen_random_uuid()'));
    table.string('email').unique().notNullable();
    table.timestamps(true, true);
  });
};

exports.down = function(knex) {
  return knex.schema.dropTable('users');
};
```

### 2. One Change Per Migration

```sql
-- Good: Single focused change
-- 001_create_users_table.sql
CREATE TABLE users (
  id UUID PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL
);

-- 002_add_users_name.sql
ALTER TABLE users ADD COLUMN name VARCHAR(100);

-- Bad: Multiple unrelated changes
-- 001_setup.sql
CREATE TABLE users (...);
CREATE TABLE orders (...);
ALTER TABLE products ADD COLUMN stock INT;
```

### 3. Use Descriptive Names

```
# Good naming convention
20240115_143022_create_users_table.sql
20240115_150000_add_email_index_to_users.sql
20240116_091500_add_orders_table.sql

# Include action and target
create_users_table
add_email_to_users
drop_legacy_sessions
rename_status_to_state_in_orders
```

## Safe Schema Changes

### Adding Columns

```sql
-- Safe: Adding nullable column
ALTER TABLE users ADD COLUMN phone VARCHAR(20);

-- Safe: Adding column with default (PostgreSQL 11+, instant)
ALTER TABLE users ADD COLUMN status VARCHAR(20) DEFAULT 'active';

-- Risky: Adding NOT NULL without default (table rewrite on older PG)
-- Do this instead:
ALTER TABLE users ADD COLUMN status VARCHAR(20);
UPDATE users SET status = 'active' WHERE status IS NULL;
ALTER TABLE users ALTER COLUMN status SET NOT NULL;
ALTER TABLE users ALTER COLUMN status SET DEFAULT 'active';
```

### Removing Columns

```sql
-- Step 1: Stop writing to column (application change)
-- Step 2: Deploy code that doesn't read column
-- Step 3: Drop column
ALTER TABLE users DROP COLUMN legacy_field;
```

### Renaming Columns

```sql
-- Safe approach with zero downtime:

-- Step 1: Add new column
ALTER TABLE orders ADD COLUMN status VARCHAR(20);

-- Step 2: Backfill data
UPDATE orders SET status = state;

-- Step 3: Add trigger to sync during transition
CREATE OR REPLACE FUNCTION sync_order_status()
RETURNS TRIGGER AS $$
BEGIN
  NEW.status = NEW.state;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER sync_status
  BEFORE INSERT OR UPDATE ON orders
  FOR EACH ROW EXECUTE FUNCTION sync_order_status();

-- Step 4: Deploy code to use new column
-- Step 5: Drop trigger and old column
DROP TRIGGER sync_status ON orders;
ALTER TABLE orders DROP COLUMN state;
```

### Adding Indexes

```sql
-- Bad: Blocks writes on large tables
CREATE INDEX idx_orders_user ON orders(user_id);

-- Good: Non-blocking (PostgreSQL)
CREATE INDEX CONCURRENTLY idx_orders_user ON orders(user_id);

-- Note: CONCURRENTLY cannot run in a transaction
-- Handle in migration tool or run manually
```

### Changing Column Types

```sql
-- Safe: Compatible type changes
ALTER TABLE products ALTER COLUMN price TYPE DECIMAL(12,2);  -- Widening precision

-- Risky: Incompatible changes (requires rewrite)
-- Use multi-step approach:
ALTER TABLE users ADD COLUMN age_new INTEGER;
UPDATE users SET age_new = age::INTEGER;
ALTER TABLE users DROP COLUMN age;
ALTER TABLE users RENAME COLUMN age_new TO age;
```

## Migration Tools

### Knex.js (Node.js)

```javascript
// knexfile.js
module.exports = {
  development: {
    client: 'postgresql',
    connection: process.env.DATABASE_URL,
    migrations: {
      directory: './migrations',
      tableName: 'knex_migrations'
    },
    seeds: {
      directory: './seeds'
    }
  }
};

// Run migrations
// npx knex migrate:latest
// npx knex migrate:rollback
// npx knex migrate:make create_users_table
```

### Alembic (Python/SQLAlchemy)

```python
# alembic/versions/001_create_users.py
from alembic import op
import sqlalchemy as sa

revision = '001'
down_revision = None

def upgrade():
    op.create_table(
        'users',
        sa.Column('id', sa.UUID(), primary_key=True),
        sa.Column('email', sa.String(255), unique=True, nullable=False),
        sa.Column('created_at', sa.DateTime(), server_default=sa.func.now())
    )

def downgrade():
    op.drop_table('users')

# Commands:
# alembic upgrade head
# alembic downgrade -1
# alembic revision -m "create_users"
```

### Prisma (Node.js)

```prisma
// prisma/schema.prisma
model User {
  id        String   @id @default(uuid())
  email     String   @unique
  orders    Order[]
  createdAt DateTime @default(now())
}

// Commands:
// npx prisma migrate dev --name init
// npx prisma migrate deploy
// npx prisma migrate reset
```

## Data Migrations

### Batch Updates for Large Tables

```sql
-- Bad: Single massive update (locks table, fills WAL)
UPDATE orders SET status = 'completed' WHERE legacy_status = 1;

-- Good: Batched updates
DO $$
DECLARE
  batch_size INT := 10000;
  affected INT;
BEGIN
  LOOP
    UPDATE orders
    SET status = 'completed'
    WHERE id IN (
      SELECT id FROM orders
      WHERE legacy_status = 1 AND status IS NULL
      LIMIT batch_size
      FOR UPDATE SKIP LOCKED
    );

    GET DIAGNOSTICS affected = ROW_COUNT;
    EXIT WHEN affected = 0;

    COMMIT;
    PERFORM pg_sleep(0.1);  -- Brief pause
  END LOOP;
END $$;
```

### Background Migrations (Rails-style)

```ruby
# Safe pattern for large data migrations
class BackfillOrderStatus < ApplicationRecord
  def self.process_batch
    Order.where(status: nil)
         .where.not(legacy_status: nil)
         .limit(1000)
         .find_each do |order|
      order.update!(status: map_status(order.legacy_status))
    end
  end

  def self.map_status(legacy)
    { 1 => 'pending', 2 => 'completed', 3 => 'cancelled' }[legacy]
  end
end
```

## Testing Migrations

```javascript
// Jest test for migration
describe('CreateUsersTable migration', () => {
  beforeAll(async () => {
    await knex.migrate.latest();
  });

  afterAll(async () => {
    await knex.migrate.rollback();
    await knex.destroy();
  });

  it('creates users table with correct columns', async () => {
    const hasTable = await knex.schema.hasTable('users');
    expect(hasTable).toBe(true);

    const columns = await knex('users').columnInfo();
    expect(columns).toHaveProperty('id');
    expect(columns).toHaveProperty('email');
    expect(columns.email.nullable).toBe(false);
  });

  it('rolls back cleanly', async () => {
    await knex.migrate.rollback();
    const hasTable = await knex.schema.hasTable('users');
    expect(hasTable).toBe(false);
  });
});
```
