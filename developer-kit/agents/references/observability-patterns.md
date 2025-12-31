# Observability Engineer - Implementation Patterns

## Pino Logging Configuration

```typescript
import pino from "pino";

const logger = pino({
  level: process.env.LOG_LEVEL || "info",
  formatters: {
    level: (label) => ({ level: label }),
  },
  base: {
    service: "order-service",
    version: process.env.APP_VERSION,
  },
});

// Create child logger with request context
export function createRequestLogger(req: Request) {
  return logger.child({
    requestId: req.id,
    userId: req.user?.id,
    traceId: req.headers["x-trace-id"],
  });
}

// Good: Structured with context
reqLogger.info(
  {
    event: "order.processed",
    orderId: order.id,
    amount: order.total,
    duration: processingTime,
  },
  "Order processed successfully",
);
```

## Winston Logging Configuration

```typescript
import winston from "winston";

const logger = winston.createLogger({
  level: process.env.LOG_LEVEL || "info",
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.errors({ stack: true }),
    winston.format.json(),
  ),
  defaultMeta: { service: "order-service" },
  transports: [
    new winston.transports.Console(),
    new winston.transports.File({ filename: "error.log", level: "error" }),
  ],
});
```

## Prometheus Metrics

```typescript
import { Counter, Histogram, Registry } from "prom-client";

const register = new Registry();

// Request counter (RED: Rate, Errors)
const httpRequestsTotal = new Counter({
  name: "http_requests_total",
  help: "Total number of HTTP requests",
  labelNames: ["method", "status", "endpoint"],
  registers: [register],
});

// Request duration histogram (RED: Duration)
const httpRequestDuration = new Histogram({
  name: "http_request_duration_seconds",
  help: "HTTP request duration in seconds",
  labelNames: ["method", "endpoint"],
  buckets: [0.01, 0.05, 0.1, 0.5, 1, 2, 5],
  registers: [register],
});

// Middleware to track metrics
app.use((req, res, next) => {
  const start = Date.now();
  res.on("finish", () => {
    const duration = (Date.now() - start) / 1000;
    httpRequestsTotal.inc({
      method: req.method,
      status: res.statusCode,
      endpoint: req.route?.path || req.path,
    });
    httpRequestDuration.observe(
      { method: req.method, endpoint: req.route?.path || req.path },
      duration,
    );
  });
  next();
});

// Expose metrics endpoint
app.get("/metrics", async (req, res) => {
  res.set("Content-Type", register.contentType);
  res.send(await register.metrics());
});
```

## OpenTelemetry Tracing

```typescript
import { NodeSDK } from "@opentelemetry/sdk-node";
import { getNodeAutoInstrumentations } from "@opentelemetry/auto-instrumentations-node";
import { OTLPTraceExporter } from "@opentelemetry/exporter-trace-otlp-http";
import { Resource } from "@opentelemetry/resources";
import {
  ATTR_SERVICE_NAME,
  ATTR_SERVICE_VERSION,
} from "@opentelemetry/semantic-conventions";

const sdk = new NodeSDK({
  resource: new Resource({
    [ATTR_SERVICE_NAME]: "order-service",
    [ATTR_SERVICE_VERSION]: "1.0.0",
  }),
  traceExporter: new OTLPTraceExporter({
    url: "http://jaeger:4318/v1/traces",
  }),
  instrumentations: [getNodeAutoInstrumentations()],
});

sdk.start();
```

## Manual Span Creation

```typescript
import { trace, SpanStatusCode } from "@opentelemetry/api";

const tracer = trace.getTracer("order-service");

async function processOrder(order: Order) {
  return tracer.startActiveSpan("processOrder", async (span) => {
    try {
      span.setAttribute("order.id", order.id);
      span.setAttribute("order.amount", order.total);

      await tracer.startActiveSpan("processPayment", async (paymentSpan) => {
        const result = await paymentService.charge(order);
        paymentSpan.setAttribute("payment.id", result.id);
        paymentSpan.end();
      });

      span.setStatus({ code: SpanStatusCode.OK });
      return result;
    } catch (error) {
      span.setStatus({ code: SpanStatusCode.ERROR, message: error.message });
      span.recordException(error);
      throw error;
    } finally {
      span.end();
    }
  });
}
```

## SLO-Based Alerting Rules

```yaml
# prometheus.rules.yml
groups:
  - name: slo-alerts
    rules:
      # Error budget burn rate alert (fast burn)
      - alert: HighErrorBudgetBurn
        expr: |
          (
            sum(rate(http_requests_total{status=~"5.."}[5m]))
            / sum(rate(http_requests_total[5m]))
          ) > (1 - 0.999) * 14.4
        for: 5m
        labels:
          severity: page
        annotations:
          summary: "High error budget burn rate"
          description: "Error rate burning through SLO budget 14.4x faster"
          runbook_url: "https://runbooks.example.com/high-error-rate"

      # Latency SLO alert
      - alert: HighLatencyBudgetBurn
        expr: |
          (
            sum(rate(http_request_duration_seconds_bucket{le="0.5"}[5m]))
            / sum(rate(http_request_duration_seconds_count[5m]))
          ) < 0.95
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: "High latency budget burn rate"
          description: "Less than 95% of requests under 500ms SLO"
```

## Multi-Window Burn Rate Alerting

```yaml
groups:
  - name: multi-window-alerts
    rules:
      # Fast burn (2% budget in 1 hour)
      - alert: ErrorBudgetFastBurn
        expr: |
          (
            sum(rate(http_requests_total{status=~"5.."}[5m]))
            / sum(rate(http_requests_total[5m]))
          ) > 0.02
          and
          (
            sum(rate(http_requests_total{status=~"5.."}[1h]))
            / sum(rate(http_requests_total[1h]))
          ) > 0.02
        for: 2m
        labels:
          severity: page

      # Slow burn (5% budget in 6 hours)
      - alert: ErrorBudgetSlowBurn
        expr: |
          (
            sum(rate(http_requests_total{status=~"5.."}[30m]))
            / sum(rate(http_requests_total[30m]))
          ) > 0.01
        for: 15m
        labels:
          severity: ticket
```

## Grafana Dashboard JSON

```json
{
  "dashboard": {
    "title": "Service Overview",
    "uid": "service-overview",
    "tags": ["production", "slo"],
    "refresh": "30s",
    "panels": [
      {
        "id": 1,
        "type": "stat",
        "title": "Request Rate",
        "gridPos": { "x": 0, "y": 0, "w": 6, "h": 4 },
        "targets": [
          {
            "expr": "sum(rate(http_requests_total[5m]))",
            "legendFormat": "req/s"
          }
        ]
      },
      {
        "id": 2,
        "type": "gauge",
        "title": "Error Rate",
        "gridPos": { "x": 6, "y": 0, "w": 6, "h": 4 },
        "targets": [
          {
            "expr": "sum(rate(http_requests_total{status=~\"5..\"}[5m])) / sum(rate(http_requests_total[5m])) * 100"
          }
        ],
        "fieldConfig": {
          "defaults": {
            "thresholds": {
              "steps": [
                { "value": 0, "color": "green" },
                { "value": 1, "color": "yellow" },
                { "value": 5, "color": "red" }
              ]
            }
          }
        }
      },
      {
        "id": 3,
        "type": "timeseries",
        "title": "Request Latency",
        "gridPos": { "x": 0, "y": 4, "w": 12, "h": 8 },
        "targets": [
          {
            "expr": "histogram_quantile(0.50, sum(rate(http_request_duration_seconds_bucket[5m])) by (le))",
            "legendFormat": "p50"
          },
          {
            "expr": "histogram_quantile(0.95, sum(rate(http_request_duration_seconds_bucket[5m])) by (le))",
            "legendFormat": "p95"
          }
        ]
      }
    ]
  }
}
```

## Sentry Error Tracking

```typescript
import * as Sentry from "@sentry/node";
import { ProfilingIntegration } from "@sentry/profiling-node";

Sentry.init({
  dsn: process.env.SENTRY_DSN,
  environment: process.env.NODE_ENV,
  release: process.env.APP_VERSION,
  integrations: [new ProfilingIntegration()],
  tracesSampleRate: 0.1,
  profilesSampleRate: 0.1,
});

// Capture exceptions with context
try {
  await processOrder(order);
} catch (error) {
  Sentry.captureException(error, {
    tags: { orderId: order.id, userId: user.id },
    extra: { orderDetails: order },
  });
  throw error;
}

// Add breadcrumbs for debugging
Sentry.addBreadcrumb({
  category: "order",
  message: "Order validation started",
  level: "info",
  data: { orderId: order.id },
});
```

## SLI/SLO Definitions

### Common SLIs

| SLI Type     | Metric               | Formula                                |
| ------------ | -------------------- | -------------------------------------- |
| Availability | Success rate         | `successful_requests / total_requests` |
| Latency      | Request duration p95 | `requests < threshold / total`         |
| Throughput   | Requests per second  | `rate(requests_total[1m])`             |
| Error Rate   | Failed request %     | `errors / total_requests`              |

### SLO Example

```yaml
slos:
  - name: api-availability
    sli:
      events:
        good: http_requests_total{status!~"5.."}
        total: http_requests_total
    objective: 99.9%
    window: 30d

  - name: api-latency
    sli:
      events:
        good: http_request_duration_seconds_bucket{le="0.5"}
        total: http_request_duration_seconds_count
    objective: 95%
    window: 30d
```

## Log Levels Guide

| Level | When to Use                       | Action Required |
| ----- | --------------------------------- | --------------- |
| FATAL | System unusable                   | Page on-call    |
| ERROR | Action required, service degraded | Create ticket   |
| WARN  | Investigate soon                  | Monitor         |
| INFO  | Key milestones, audit trail       | None            |
| DEBUG | Development troubleshooting       | None            |

## Alert Design Principles

### DO

1. Alert on symptoms, not causes
2. Include runbook links
3. Use severity levels (page/ticket/log)
4. Use multiple time windows

### DON'T

1. Alert on every error
2. Page for self-healing issues
3. Duplicate alerts
4. Alert without context
