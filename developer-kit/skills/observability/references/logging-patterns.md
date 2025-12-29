# Logging Patterns Reference

## Structured Logging

### Node.js with Winston

```javascript
import winston from 'winston';

const logger = winston.createLogger({
  level: process.env.LOG_LEVEL || 'info',
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.errors({ stack: true }),
    winston.format.json()
  ),
  defaultMeta: {
    service: 'api-service',
    version: process.env.APP_VERSION
  },
  transports: [
    new winston.transports.Console(),
    new winston.transports.File({ filename: 'logs/error.log', level: 'error' }),
    new winston.transports.File({ filename: 'logs/combined.log' })
  ]
});

// Request logging middleware
export const requestLogger = (req, res, next) => {
  const correlationId = req.headers['x-correlation-id'] || crypto.randomUUID();
  req.correlationId = correlationId;

  const start = Date.now();

  res.on('finish', () => {
    logger.info('HTTP Request', {
      correlationId,
      method: req.method,
      path: req.path,
      statusCode: res.statusCode,
      duration: Date.now() - start,
      userAgent: req.headers['user-agent'],
      userId: req.user?.id
    });
  });

  next();
};
```

### Node.js with Pino (High Performance)

```javascript
import pino from 'pino';

const logger = pino({
  level: process.env.LOG_LEVEL || 'info',
  formatters: {
    level: (label) => ({ level: label }),
  },
  base: {
    service: 'api-service',
    version: process.env.APP_VERSION,
  },
  timestamp: pino.stdTimeFunctions.isoTime,
});

// Express middleware
import pinoHttp from 'pino-http';

app.use(pinoHttp({
  logger,
  genReqId: (req) => req.headers['x-correlation-id'] || crypto.randomUUID(),
  customProps: (req) => ({
    userId: req.user?.id,
  }),
}));
```

### Python with structlog

```python
import structlog
import logging

structlog.configure(
    processors=[
        structlog.stdlib.filter_by_level,
        structlog.stdlib.add_logger_name,
        structlog.stdlib.add_log_level,
        structlog.stdlib.PositionalArgumentsFormatter(),
        structlog.processors.TimeStamper(fmt="iso"),
        structlog.processors.StackInfoRenderer(),
        structlog.processors.format_exc_info,
        structlog.processors.UnicodeDecoder(),
        structlog.processors.JSONRenderer()
    ],
    wrapper_class=structlog.stdlib.BoundLogger,
    context_class=dict,
    logger_factory=structlog.stdlib.LoggerFactory(),
    cache_logger_on_first_use=True,
)

logger = structlog.get_logger()

# Usage
logger.info("user_login", user_id=user.id, ip_address=request.remote_addr)
logger.error("payment_failed", order_id=order.id, error=str(e), exc_info=True)
```

## Correlation ID Propagation

```javascript
import { AsyncLocalStorage } from 'async_hooks';

const asyncLocalStorage = new AsyncLocalStorage();

// Middleware to propagate correlation IDs
export const correlationMiddleware = (req, res, next) => {
  const correlationId = req.headers['x-correlation-id'] ||
                        req.headers['x-request-id'] ||
                        crypto.randomUUID();

  // Attach to request
  req.correlationId = correlationId;

  // Include in response headers
  res.setHeader('x-correlation-id', correlationId);

  // Attach to async context for downstream logging
  asyncLocalStorage.run({ correlationId }, () => next());
};

// Get correlation ID anywhere in the request
export const getCorrelationId = () => {
  return asyncLocalStorage.getStore()?.correlationId;
};

// Axios interceptor for outgoing requests
axios.interceptors.request.use((config) => {
  const correlationId = getCorrelationId();
  if (correlationId) {
    config.headers['x-correlation-id'] = correlationId;
  }
  return config;
});
```

## Log Aggregation Configuration

### Filebeat to Elasticsearch

```yaml
# filebeat.yml
filebeat.inputs:
  - type: log
    enabled: true
    paths:
      - /var/log/app/*.log
    json.keys_under_root: true
    json.add_error_key: true
    json.message_key: message

output.elasticsearch:
  hosts: ["elasticsearch:9200"]
  index: "app-logs-%{+yyyy.MM.dd}"

processors:
  - add_host_metadata: ~
  - add_cloud_metadata: ~
```

### Fluentd Configuration

```
<source>
  @type tail
  path /var/log/app/*.json
  pos_file /var/log/fluentd/app.pos
  tag app.logs
  <parse>
    @type json
    time_key timestamp
    time_format %Y-%m-%dT%H:%M:%S.%NZ
  </parse>
</source>

<match app.logs>
  @type elasticsearch
  host elasticsearch
  port 9200
  index_name app-logs
  type_name _doc
</match>
```

## Error Tracking Integration

### Sentry Integration

```javascript
import * as Sentry from '@sentry/node';

Sentry.init({
  dsn: process.env.SENTRY_DSN,
  environment: process.env.NODE_ENV,
  release: process.env.APP_VERSION,
  tracesSampleRate: 0.1,
  integrations: [
    new Sentry.Integrations.Http({ tracing: true }),
    new Sentry.Integrations.Express({ app })
  ]
});

// Capture errors with context
try {
  await processOrder(order);
} catch (error) {
  Sentry.captureException(error, {
    tags: { component: 'order-processor' },
    extra: { orderId: order.id, userId: user.id }
  });
  throw error;
}
```

## Sensitive Data Redaction

```javascript
const redactPatterns = [
  { pattern: /password['"]\s*:\s*['"][^'"]+['"]/gi, replacement: 'password":"[REDACTED]"' },
  { pattern: /\b\d{16}\b/g, replacement: '[CARD_NUMBER]' },
  { pattern: /\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b/g, replacement: '[EMAIL]' },
];

const redact = (message) => {
  let redacted = message;
  for (const { pattern, replacement } of redactPatterns) {
    redacted = redacted.replace(pattern, replacement);
  }
  return redacted;
};

// Winston format for redaction
const redactionFormat = winston.format((info) => {
  info.message = redact(info.message);
  return info;
});
```
