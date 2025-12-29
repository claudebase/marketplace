# Connection Management Reference

## Connection Pooling

### Why Connection Pooling?

- Database connections are expensive to establish
- Each connection uses server memory (~10MB for PostgreSQL)
- Too many connections can exhaust database resources
- Pool reuses connections across requests

### Node.js with pg-pool

```javascript
import { Pool } from 'pg';

const pool = new Pool({
  host: process.env.DB_HOST,
  port: parseInt(process.env.DB_PORT) || 5432,
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,

  // Pool configuration
  max: 20,                        // Maximum connections in pool
  min: 5,                         // Minimum connections to maintain
  idleTimeoutMillis: 30000,       // Close idle connections after 30s
  connectionTimeoutMillis: 5000,  // Fail if can't connect in 5s
  maxUses: 7500,                  // Close connection after N uses

  // SSL configuration
  ssl: process.env.NODE_ENV === 'production' ? {
    rejectUnauthorized: true,
    ca: process.env.DB_CA_CERT
  } : false
});

// Graceful shutdown
process.on('SIGTERM', async () => {
  await pool.end();
  process.exit(0);
});

// Query helper with automatic connection release
export const query = async (text, params) => {
  const start = Date.now();
  const result = await pool.query(text, params);

  console.log('Query executed', {
    text,
    duration: Date.now() - start,
    rows: result.rowCount
  });

  return result;
};

// Transaction helper
export const transaction = async (callback) => {
  const client = await pool.connect();
  try {
    await client.query('BEGIN');
    const result = await callback(client);
    await client.query('COMMIT');
    return result;
  } catch (error) {
    await client.query('ROLLBACK');
    throw error;
  } finally {
    client.release();
  }
};
```

### Python with SQLAlchemy

```python
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, scoped_session

engine = create_engine(
    os.environ['DATABASE_URL'],
    pool_size=20,           # Maximum connections
    max_overflow=10,        # Allow 10 extra connections under load
    pool_timeout=30,        # Wait 30s for available connection
    pool_recycle=3600,      # Recycle connections after 1 hour
    pool_pre_ping=True,     # Test connections before use
    echo=False              # Set True for SQL logging
)

# Thread-safe session factory
Session = scoped_session(sessionmaker(bind=engine))

# Context manager for sessions
from contextlib import contextmanager

@contextmanager
def get_session():
    session = Session()
    try:
        yield session
        session.commit()
    except Exception:
        session.rollback()
        raise
    finally:
        session.close()

# Usage
with get_session() as session:
    users = session.query(User).filter(User.active == True).all()
```

### Prisma Connection Pool

```typescript
// prisma/schema.prisma
datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

// Connection string with pool settings
// postgresql://user:pass@host:5432/db?connection_limit=20&pool_timeout=30

// Singleton pattern for Prisma client
import { PrismaClient } from '@prisma/client';

const globalForPrisma = global as unknown as { prisma: PrismaClient };

export const prisma = globalForPrisma.prisma || new PrismaClient({
  log: ['query', 'error', 'warn'],
});

if (process.env.NODE_ENV !== 'production') {
  globalForPrisma.prisma = prisma;
}
```

## Connection Pool Sizing

### Formula

```
connections = (core_count * 2) + effective_spindle_count
```

For most web applications:
- **Small app (1-2 servers)**: 10-20 connections per server
- **Medium app (5-10 servers)**: 5-10 connections per server
- **Large app (50+ servers)**: Use PgBouncer, 2-5 per server

### PostgreSQL max_connections

```sql
-- Check current settings
SHOW max_connections;  -- Default: 100

-- Calculate safe pool size
-- Reserve 10-20% for admin/monitoring
-- Max pool per app = (max_connections - reserved) / num_app_instances
```

## Connection Poolers

### PgBouncer Configuration

```ini
; /etc/pgbouncer/pgbouncer.ini

[databases]
myapp = host=127.0.0.1 port=5432 dbname=myapp

[pgbouncer]
listen_addr = 0.0.0.0
listen_port = 6432
auth_type = md5
auth_file = /etc/pgbouncer/userlist.txt

; Pool settings
pool_mode = transaction          ; session, transaction, or statement
default_pool_size = 20
min_pool_size = 5
reserve_pool_size = 5
reserve_pool_timeout = 3
max_client_conn = 1000
max_db_connections = 100

; Timeouts
server_connect_timeout = 15
server_idle_timeout = 600
server_lifetime = 3600
client_idle_timeout = 0
query_timeout = 0
```

### Docker Compose with PgBouncer

```yaml
version: '3.8'

services:
  postgres:
    image: postgres:15
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: myapp
      POSTGRES_PASSWORD: ${DB_PASSWORD}
    volumes:
      - postgres_data:/var/lib/postgresql/data

  pgbouncer:
    image: edoburu/pgbouncer
    environment:
      DATABASE_URL: postgres://myapp:${DB_PASSWORD}@postgres:5432/myapp
      POOL_MODE: transaction
      DEFAULT_POOL_SIZE: 20
      MAX_CLIENT_CONN: 1000
    ports:
      - "6432:5432"
    depends_on:
      - postgres

  api:
    build: .
    environment:
      DATABASE_URL: postgres://myapp:${DB_PASSWORD}@pgbouncer:5432/myapp
    depends_on:
      - pgbouncer
```

## Health Checks and Monitoring

```javascript
// Health check endpoint
app.get('/health/db', async (req, res) => {
  try {
    const start = Date.now();
    await pool.query('SELECT 1');
    const latency = Date.now() - start;

    // Pool stats
    const stats = {
      total: pool.totalCount,
      idle: pool.idleCount,
      waiting: pool.waitingCount,
      latency
    };

    if (stats.waiting > 10) {
      return res.status(503).json({
        status: 'degraded',
        message: 'High connection wait queue',
        ...stats
      });
    }

    res.json({ status: 'healthy', ...stats });
  } catch (error) {
    res.status(503).json({
      status: 'unhealthy',
      error: error.message
    });
  }
});

// Prometheus metrics
const poolMetrics = new promClient.Gauge({
  name: 'db_pool_connections',
  help: 'Database connection pool stats',
  labelNames: ['state']
});

setInterval(() => {
  poolMetrics.set({ state: 'total' }, pool.totalCount);
  poolMetrics.set({ state: 'idle' }, pool.idleCount);
  poolMetrics.set({ state: 'waiting' }, pool.waitingCount);
}, 5000);
```

## Retry and Reconnection

```javascript
import retry from 'async-retry';

const queryWithRetry = async (text, params, options = {}) => {
  return retry(
    async (bail, attempt) => {
      try {
        return await pool.query(text, params);
      } catch (error) {
        // Don't retry on syntax errors or constraint violations
        if (error.code === '42601' || error.code === '23505') {
          bail(error);
          return;
        }
        // Retry on connection errors
        if (error.code === 'ECONNREFUSED' || error.code === '57P01') {
          console.log(`Query retry attempt ${attempt}`);
          throw error;
        }
        throw error;
      }
    },
    {
      retries: 3,
      factor: 2,
      minTimeout: 1000,
      maxTimeout: 5000,
      ...options
    }
  );
};
```
