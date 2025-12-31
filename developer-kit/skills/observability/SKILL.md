---
name: observability
description: "Configure logging, monitoring, alerting, and metrics for production systems. Activates for: 'add logging', 'setup monitoring', 'create alerts', 'add metrics', 'distributed tracing', 'build dashboard', 'APM setup', 'telemetry', 'observability stack'."
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
  # Observability Documentation
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  # Pattern Research
  - mcp__github__search_code
  - mcp__github__get_file_contents
  - mcp__github__search_repositories
  # Best Practices Research
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  # Complex Architecture Design
  - mcp__sequential-thinking__sequentialthinking
---

# Observability Skill

Enable comprehensive system visibility through structured logging, proactive monitoring, intelligent alerting, metrics collection, and distributed tracing with official documentation and SRE best practices.

**Core Principle**: "Measure everything, alert on symptoms, debug with traces."

**Key Enhancement**: Research observability tool documentation, SRE patterns, and instrumentation strategies via MCP tools before implementing monitoring solutions.

## Activation Triggers

### Logging Setup

- "add logging", "structured logging", "configure Pino/Winston"
- "log formatting", "correlation IDs", "log aggregation"

### Monitoring

- "set up monitoring", "Prometheus metrics", "Datadog setup"
- "custom metrics", "health checks", "metric collection"

### Alerting

- "create alerts", "alerting rules", "PagerDuty integration"
- "SLO alerts", "error rate alerts", "latency alerts"

### Tracing

- "distributed tracing", "OpenTelemetry", "trace requests"
- "span instrumentation", "trace propagation"

### Dashboards

- "build dashboard", "Grafana setup", "visualize metrics"
- "monitoring dashboard", "SLO dashboard"

### APM

- "APM setup", "application performance monitoring"
- "Sentry setup", "New Relic configuration"

## Do NOT Activate When

- Simple `console.log` debugging -> use `debug` skill
- One-off log statements for development
- Test-only logging
- Performance optimization without metrics -> use `performance` skill
- Security logging requirements -> use `security` skill

**Boundary Clarification:**
This skill implements production observability infrastructure. For debugging specific issues, use `debug` skill. For security-focused logging, use `security` skill.

## Behavioral Flow

```
+--------------+--------------+--------------+--------------+--------------+
|    ASSESS    |   RESEARCH   |    DESIGN    |  IMPLEMENT   |   VALIDATE   |
+--------------+--------------+--------------+--------------+--------------+
| Identify     | Lookup       | Define       | Configure    | Verify data  |
| existing     | official     | SLIs/SLOs    | logging      | collection   |
| observability| docs         |              |              |              |
|              |              |              |              |              |
| Check        | Find         | Plan         | Add          | Test         |
| current      | patterns     | metrics      | metrics &    | alerting     |
| tooling      |              | strategy     | tracing      |              |
|              |              |              |              |              |
| Assess       | Research     | Design       | Create       | Verify       |
| gaps         | best         | alerting     | dashboards   | dashboards   |
|              | practices    |              |              |              |
+--------------+--------------+--------------+--------------+--------------+
     Read           Context7      Sequential      Write          Bash
     Grep           GitHub        Thinking        Edit           (test)
                    Tavily
```

### Phase 1: ASSESS

Understand current observability state:

1. **Read existing code** - Identify logging framework, current instrumentation
2. **Check monitoring config** - Prometheus, Datadog, or other agents
3. **Review alerting rules** - Existing alerts and notification channels
4. **Assess tracing setup** - OpenTelemetry, Jaeger, or vendor-specific
5. **Identify gaps** - Missing metrics, blind spots, alert fatigue

```bash
# Find existing logging
Glob - "**/logger.ts", "**/logging.ts", "**/*logger*"
Grep - "pino|winston|bunyan|console.log" in src/**

# Check monitoring config
Glob - "**/prometheus.yml", "**/datadog.yaml", "**/metrics.*"

# Find alerting rules
Glob - "**/*.rules.yml", "**/alerts.yml"

# Check tracing setup
Grep - "opentelemetry|jaeger|zipkin|tracer" in src/**
```

**Tools**: Read, Grep, Glob

### Phase 2: RESEARCH

Gather official documentation and community patterns:

```
# Lookup OpenTelemetry documentation
mcp__context7__resolve-library-id -> "/websites/opentelemetry_io"
mcp__context7__query-docs("trace context propagation instrumentation SDK Node.js")

# Lookup Prometheus documentation
mcp__context7__resolve-library-id -> "/websites/prometheus_io-docs"
mcp__context7__query-docs("alerting rules recording rules PromQL histogram")

# Lookup Grafana dashboard patterns
mcp__context7__resolve-library-id -> "/websites/grafana"
mcp__context7__query-docs("dashboard JSON provisioning panels queries")

# Find real-world alerting patterns
mcp__github__search_code("alert: expr: filename:prometheus.rules.yml stars:>100")

# Research SRE best practices
mcp__tavily__tavily-search("Google SRE SLO alerting best practices 2024")
```

**Tools**: Context7, GitHub MCP, Tavily

### Phase 3: DESIGN

Plan observability strategy with structured reasoning:

```
mcp__sequential-thinking__sequentialthinking
- Define SLIs (latency, error rate, availability)
- Set SLO targets (99.9%, p95 < 200ms)
- Plan metric collection (RED, USE methods)
- Design alerting strategy (symptoms, not causes)
- Choose tracing approach (sampling, propagation)
- Plan dashboard hierarchy (overview -> detail)
```

**Design Decisions:**

| Component | Choice        | Rationale                           |
| --------- | ------------- | ----------------------------------- |
| Logging   | Pino/Winston  | Structured JSON, high performance   |
| Metrics   | Prometheus    | Open standard, powerful queries     |
| Tracing   | OpenTelemetry | Vendor-neutral, comprehensive       |
| Alerting  | SLO-based     | User-focused, reduces alert fatigue |
| Dashboard | Grafana       | Flexible, supports all data sources |

**Tools**: Sequential Thinking

### Phase 4: IMPLEMENT

Add observability instrumentation:

1. **Configure logging** - Pino/Winston with structured format
2. **Add metrics** - Prometheus counters, histograms, gauges
3. **Set up tracing** - OpenTelemetry SDK and exporters
4. **Create alerts** - SLO-based alerting rules
5. **Build dashboards** - Grafana or vendor dashboards

**Tools**: Write, Edit, Bash

### Phase 5: VALIDATE

Verify observability is working:

```bash
# Test log output format
npm run start | pino-pretty

# Verify metrics endpoint
curl localhost:9090/metrics

# Check trace propagation
curl -H "traceparent: 00-..." localhost:3000/api/test

# Validate alert rules
promtool check rules prometheus.rules.yml

# Test dashboard
curl -X GET http://localhost:3000/api/dashboards/uid/my-dashboard
```

**Tools**: Bash

## MCP Integration

### Context7 (Observability Documentation)

**Primary source for observability tool documentation:**

```
mcp__context7__resolve-library-id - Resolve tool library IDs
mcp__context7__query-docs - Get official documentation
```

**Available Resources:**

| Resource          | Library ID                       | Snippets | Use Case                          |
| ----------------- | -------------------------------- | -------- | --------------------------------- |
| OpenTelemetry     | `/websites/opentelemetry_io`     | 8,911    | Tracing, metrics, logs            |
| Grafana           | `/websites/grafana`              | 66,435   | Dashboards, alerting              |
| Prometheus        | `/websites/prometheus_io-docs`   | 1,795    | Metrics, alerting rules, PromQL   |
| Datadog           | `/datadog/documentation`         | 26,050   | APM, logs, metrics                |
| Sentry            | `/websites/sentry_io`            | 48,602   | Error tracking, performance       |
| Sentry JS         | `/getsentry/sentry-javascript`   | 1,611    | JavaScript/Node.js error tracking |
| Pino              | `/pinojs/pino`                   | 170      | Fast JSON logging                 |
| Winston           | `/winstonjs/winston`             | 101      | Flexible logging                  |
| Jaeger            | `/jaegertracing/jaeger`          | 247      | Distributed tracing               |
| Zipkin            | `/openzipkin/zipkin`             | 150      | Distributed tracing               |
| Elasticsearch     | `/websites/elastic_co_reference` | 56,996   | Log aggregation, search           |
| New Relic Node.js | `/newrelic/node-newrelic`        | 270      | APM for Node.js                   |
| prom-client       | `/siimon/prom-client`            | 50       | Prometheus metrics for Node.js    |

**Query Patterns:**

| Topic          | Query Pattern                                     |
| -------------- | ------------------------------------------------- |
| Tracing setup  | `"trace context propagation instrumentation SDK"` |
| Metrics        | `"histogram counter gauge PromQL"`                |
| Alerting       | `"alerting rules recording rules threshold"`      |
| Dashboards     | `"dashboard JSON provisioning panels"`            |
| Logging        | `"structured logging JSON format child logger"`   |
| Error tracking | `"error capture breadcrumbs performance"`         |

### GitHub MCP (Pattern Research)

**Find real-world observability configurations:**

```
mcp__github__search_code - Find alerting rules, dashboards, configs
mcp__github__get_file_contents - Get specific configuration files
mcp__github__search_repositories - Find observability examples
```

**Search Patterns:**

```
# Find Prometheus alerting rules
"alert:" "expr:" "for:" filename:prometheus.rules.yml stars:>100

# Find Grafana dashboard definitions
"dashboard" "panels" "targets" filename:.json path:grafana

# Find OpenTelemetry configurations
"TracerProvider" "SpanProcessor" filename:.ts stars:>50

# Find Pino logging setups
"pino" "level:" "transport" filename:.ts

# Find Winston logging setups
"winston" "createLogger" "transports" filename:.ts

# Find SLO definitions
"slo" "error_budget" "availability" filename:.yaml

# Find Prometheus recording rules
"record:" "expr:" filename:rules.yml
```

**Use Cases:**

- Find how production systems configure alerts
- Research Grafana dashboard patterns
- Get OpenTelemetry instrumentation examples
- Study logging configuration patterns

### Tavily (Best Practices Research)

**Research SRE and observability best practices:**

```
mcp__tavily__tavily-search - Research SRE patterns, tool comparisons
mcp__tavily__tavily-extract - Extract from articles/docs
```

**Search Queries:**

- "Google SRE SLO alerting best practices 2024"
- "OpenTelemetry vs vendor-specific APM comparison"
- "Prometheus alerting patterns avoid alert fatigue"
- "Distributed tracing sampling strategies production"
- "RED vs USE method when to use metrics"
- "Structured logging best practices correlation ID"
- "Grafana dashboard design patterns"

### Sequential Thinking (Architecture Design)

**Structured reasoning for complex observability design:**

```
mcp__sequential-thinking__sequentialthinking - Multi-step design reasoning
```

**Use for:**

- SLI/SLO definition and target setting
- Multi-service tracing architecture
- Alert escalation policy design
- Metrics cardinality planning
- Dashboard hierarchy design

## Three Pillars of Observability

### Logs (What happened)

**Structured Logging with Pino:**

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
const reqLogger = logger.child({
  requestId: req.id,
  userId: req.user?.id,
  traceId: req.headers["x-trace-id"],
});

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

**Structured Logging with Winston:**

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

logger.info("Order processed", {
  orderId: order.id,
  userId: user.id,
  amount: order.total,
});
```

### Metrics (Aggregate measurements)

**RED Method (Request-driven) for Services:**

```yaml
# Prometheus metrics for services
http_requests_total{method, status, endpoint}        # Rate
http_request_duration_seconds{method, endpoint}      # Duration
http_request_errors_total{method, endpoint, error}   # Errors
```

**USE Method (Resource-driven) for Infrastructure:**

```yaml
# Prometheus metrics for resources
resource_utilization_ratio{resource}    # Utilization (0-1)
resource_saturation_ratio{resource}     # Saturation (queue depth)
resource_errors_total{resource}         # Errors
```

**Prometheus Metrics with prom-client:**

```typescript
import { Counter, Histogram, Registry } from "prom-client";

const register = new Registry();

// Request counter
const httpRequestsTotal = new Counter({
  name: "http_requests_total",
  help: "Total number of HTTP requests",
  labelNames: ["method", "status", "endpoint"],
  registers: [register],
});

// Request duration histogram
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

### Traces (Request flow)

**OpenTelemetry Instrumentation:**

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

**Manual Span Creation:**

```typescript
import { trace, SpanStatusCode } from "@opentelemetry/api";

const tracer = trace.getTracer("order-service");

async function processOrder(order: Order) {
  return tracer.startActiveSpan("processOrder", async (span) => {
    try {
      span.setAttribute("order.id", order.id);
      span.setAttribute("order.amount", order.total);
      span.setAttribute("order.items_count", order.items.length);

      // Nested span for payment processing
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

**Context Propagation:**

```typescript
import { context, propagation } from "@opentelemetry/api";

// Inject trace context for outgoing requests
const headers: Record<string, string> = {};
propagation.inject(context.active(), headers);

// Make HTTP request with trace headers
await fetch("http://inventory-service/reserve", {
  headers: {
    ...headers,
    "Content-Type": "application/json",
  },
  body: JSON.stringify(order),
});
```

## Alerting Patterns

### SLO-Based Alerting

```yaml
# prometheus.rules.yml
groups:
  - name: slo-alerts
    rules:
      # Error budget burn rate alert
      - alert: HighErrorBudgetBurn
        expr: |
          (
            sum(rate(http_requests_total{status=~"5.."}[5m]))
            /
            sum(rate(http_requests_total[5m]))
          ) > (1 - 0.999) * 14.4
        for: 5m
        labels:
          severity: page
        annotations:
          summary: "High error budget burn rate"
          description: "Error rate is burning through SLO budget 14.4x faster than sustainable"
          runbook_url: "https://runbooks.example.com/high-error-rate"

      # Latency SLO alert
      - alert: HighLatencyBudgetBurn
        expr: |
          (
            sum(rate(http_request_duration_seconds_bucket{le="0.5"}[5m]))
            /
            sum(rate(http_request_duration_seconds_count[5m]))
          ) < 0.95
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: "High latency budget burn rate"
          description: "Less than 95% of requests completing under 500ms SLO"
```

### Multi-Window Alerting

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
          and
          (
            sum(rate(http_requests_total{status=~"5.."}[6h]))
            / sum(rate(http_requests_total[6h]))
          ) > 0.01
        for: 15m
        labels:
          severity: ticket
```

### Service Health Alerts

```yaml
groups:
  - name: service-health
    rules:
      - alert: ServiceDown
        expr: up == 0
        for: 1m
        labels:
          severity: page
        annotations:
          summary: "Service {{ $labels.instance }} is down"
          runbook_url: "https://runbooks.example.com/service-down"

      - alert: HighMemoryUsage
        expr: |
          (node_memory_MemTotal_bytes - node_memory_MemAvailable_bytes)
          / node_memory_MemTotal_bytes > 0.9
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: "High memory usage on {{ $labels.instance }}"

      - alert: HighCPUUsage
        expr: |
          100 - (avg by(instance) (rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100) > 80
        for: 10m
        labels:
          severity: warning
        annotations:
          summary: "High CPU usage on {{ $labels.instance }}"
```

## Dashboard Patterns

### Grafana Dashboard JSON Structure

```json
{
  "dashboard": {
    "title": "Service Overview",
    "uid": "service-overview",
    "tags": ["production", "slo"],
    "timezone": "browser",
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
            "expr": "sum(rate(http_requests_total{status=~\"5..\"}[5m])) / sum(rate(http_requests_total[5m])) * 100",
            "legendFormat": "error %"
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
          },
          {
            "expr": "histogram_quantile(0.99, sum(rate(http_request_duration_seconds_bucket[5m])) by (le))",
            "legendFormat": "p99"
          }
        ]
      }
    ]
  }
}
```

### Dashboard with Grafana Foundation SDK

```typescript
import {
  DashboardBuilder,
  RowBuilder,
} from "@grafana/grafana-foundation-sdk/dashboard";
import { DataqueryBuilder } from "@grafana/grafana-foundation-sdk/prometheus";
import { PanelBuilder as TimeSeriesBuilder } from "@grafana/grafana-foundation-sdk/timeseries";
import { PanelBuilder as StatBuilder } from "@grafana/grafana-foundation-sdk/stat";

const dashboard = new DashboardBuilder("Service SLO Dashboard")
  .uid("service-slo")
  .tags(["slo", "production"])
  .refresh("30s")
  .time({ from: "now-1h", to: "now" })

  // SLO Overview Row
  .withRow(new RowBuilder("SLO Overview"))
  .withPanel(
    new StatBuilder()
      .title("Availability")
      .withTarget(
        new DataqueryBuilder()
          .expr(
            '1 - (sum(rate(http_requests_total{status=~"5.."}[24h])) / sum(rate(http_requests_total[24h])))',
          )
          .legendFormat("availability"),
      ),
  )
  .withPanel(
    new StatBuilder()
      .title("Error Budget Remaining")
      .withTarget(
        new DataqueryBuilder()
          .expr(
            '1 - ((sum(rate(http_requests_total{status=~"5.."}[30d])) / sum(rate(http_requests_total[30d]))) / 0.001)',
          )
          .legendFormat("budget"),
      ),
  )

  // Latency Row
  .withRow(new RowBuilder("Latency"))
  .withPanel(
    new TimeSeriesBuilder()
      .title("Request Latency Percentiles")
      .withTarget(
        new DataqueryBuilder()
          .expr(
            "histogram_quantile(0.95, sum(rate(http_request_duration_seconds_bucket[5m])) by (le))",
          )
          .legendFormat("p95"),
      )
      .withTarget(
        new DataqueryBuilder()
          .expr(
            "histogram_quantile(0.99, sum(rate(http_request_duration_seconds_bucket[5m])) by (le))",
          )
          .legendFormat("p99"),
      ),
  );

console.log(JSON.stringify(dashboard.build(), null, 2));
```

## Log Levels Guide

| Level | When to Use                          | Example                            | Action Required |
| ----- | ------------------------------------ | ---------------------------------- | --------------- |
| FATAL | System unusable, immediate action    | Database connection pool exhausted | Page on-call    |
| ERROR | Action required, service degraded    | Payment processing failed          | Create ticket   |
| WARN  | Investigate soon, service functional | Rate limit approaching 80%         | Monitor         |
| INFO  | Key milestones, audit trail          | User logged in, order created      | None            |
| DEBUG | Development troubleshooting          | Variable values, function entry    | None            |
| TRACE | Very detailed debugging              | Every function call                | None            |

## Alert Design Principles

### DO

1. **Alert on symptoms, not causes** - Page when users are affected
2. **Include runbook links** - Every alert has remediation steps
3. **Use severity levels** - Critical (page), Warning (ticket), Info (log)
4. **Set appropriate thresholds** - Based on historical data
5. **Use multiple time windows** - Fast burn + slow burn detection

### DON'T

1. **Alert on every error** - Creates alert fatigue
2. **Page for self-healing issues** - Use warnings instead
3. **Duplicate alerts** - One issue, one alert
4. **Alert without context** - Include relevant labels
5. **Set arbitrary thresholds** - Use data-driven decisions

## SLI/SLO Definitions

### Common SLIs

| SLI Type     | Metric                      | Formula                                |
| ------------ | --------------------------- | -------------------------------------- |
| Availability | Success rate                | `successful_requests / total_requests` |
| Latency      | Request duration percentile | `requests < threshold / total`         |
| Throughput   | Requests per second         | `rate(requests_total[1m])`             |
| Error Rate   | Failed request percentage   | `errors / total_requests`              |
| Saturation   | Resource utilization        | `current_usage / max_capacity`         |

### SLO Examples

```yaml
# SLO definitions
slos:
  - name: api-availability
    description: "API requests succeed"
    sli:
      events:
        good: http_requests_total{status!~"5.."}
        total: http_requests_total
    objective: 99.9%
    window: 30d

  - name: api-latency
    description: "API requests complete quickly"
    sli:
      events:
        good: http_request_duration_seconds_bucket{le="0.5"}
        total: http_request_duration_seconds_count
    objective: 95%
    window: 30d
```

## Error Tracking with Sentry

```typescript
import * as Sentry from "@sentry/node";
import { ProfilingIntegration } from "@sentry/profiling-node";

Sentry.init({
  dsn: process.env.SENTRY_DSN,
  environment: process.env.NODE_ENV,
  release: process.env.APP_VERSION,
  integrations: [new ProfilingIntegration()],
  tracesSampleRate: 0.1, // 10% of transactions
  profilesSampleRate: 0.1,
});

// Capture exceptions with context
try {
  await processOrder(order);
} catch (error) {
  Sentry.captureException(error, {
    tags: {
      orderId: order.id,
      userId: user.id,
    },
    extra: {
      orderDetails: order,
    },
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

## Output Format

```markdown
## Observability Implementation: [Service Name]

### Current State Assessment

| Component  | Status   | Tool             |
| ---------- | -------- | ---------------- |
| Logging    | [status] | [Pino/Winston]   |
| Metrics    | [status] | [Prometheus/etc] |
| Tracing    | [status] | [OpenTelemetry]  |
| Alerting   | [status] | [Prometheus/etc] |
| Dashboards | [status] | [Grafana/etc]    |

### Research Applied

- Tool documentation: [OpenTelemetry/Prometheus/Grafana]
- Patterns found: [GitHub examples]
- Best practices: [SRE/SLO strategies]

### Implementation

#### Logging

- Framework: [Pino/Winston]
- Format: Structured JSON
- Correlation: Request ID, Trace ID

#### Metrics

- Collection: [Prometheus/StatsD]
- Method: RED for services, USE for resources
- Endpoint: `/metrics`

#### Tracing

- SDK: OpenTelemetry
- Exporter: [Jaeger/Zipkin/OTLP]
- Sampling: [strategy]

#### Alerting

- Approach: SLO-based
- Severity levels: [defined]
- Runbooks: [linked]

### SLO Definitions

| SLI          | Target  | Window |
| ------------ | ------- | ------ |
| Availability | 99.9%   | 30d    |
| Latency p95  | < 500ms | 30d    |

### Dashboards Created

1. Service Overview - Key SLIs at a glance
2. SLO Dashboard - Error budget tracking
3. Debug Dashboard - Detailed metrics
```

## Reference Files

For detailed patterns and examples, see:

- `references/logging-patterns.md` - Structured logging examples
- `references/monitoring-setup.md` - Tool configuration guides
- `references/alerting-strategies.md` - SLO-based alerting
- `references/dashboard-templates.md` - Grafana/Datadog dashboards
- `references/tracing-patterns.md` - OpenTelemetry instrumentation

## Handoffs

| Scenario                     | Hand off to         |
| ---------------------------- | ------------------- |
| Need performance profiling   | `performance` skill |
| Need security logging audit  | `security` skill    |
| Need infrastructure setup    | `devops` skill      |
| Need database query analysis | `database` skill    |
| Need bug investigation       | `debug` skill       |
| Need container deployment    | `containers` skill  |

## Boundaries

**Will:**

- Configure logging frameworks (Pino, Winston) with structured format
- Set up monitoring agents and collectors (Prometheus, Datadog)
- Create alerting rules with SLO-based approach
- Add metrics instrumentation (RED, USE methods)
- Configure distributed tracing with OpenTelemetry
- Create monitoring dashboards (Grafana)
- Set up error tracking (Sentry)
- Document runbooks and procedures
- Research best practices via MCP tools

**Will Not:**

- Choose vendors without project context
- Configure billing or pricing tiers
- Set up on-call rotation schedules
- Create incident management processes
- Make architecture decisions unrelated to observability
- Provision infrastructure (use `devops` skill)
