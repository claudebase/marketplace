# Observability Skill - Detailed Guide

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

## Phase 1: ASSESS

Understand current observability state:

1. **Read existing code** - Identify logging framework, current instrumentation
2. **Check monitoring config** - Prometheus, Datadog, or other agents
3. **Review alerting rules** - Existing alerts and notification channels
4. **Assess tracing setup** - OpenTelemetry, Jaeger, or vendor-specific
5. **Identify gaps** - Missing metrics, blind spots, alert fatigue

```bash
# Find existing logging
Glob - "**/logger.ts", "**/logging.ts"
Grep - "pino|winston|bunyan" in src/**

# Check monitoring config
Glob - "**/prometheus.yml", "**/datadog.yaml"

# Find alerting rules
Glob - "**/*.rules.yml", "**/alerts.yml"
```

## Phase 2: RESEARCH

Gather documentation and patterns:

```yaml
# OpenTelemetry documentation
mcp__context7__resolve-library-id → "/websites/opentelemetry_io"
mcp__context7__query-docs("trace context propagation instrumentation")

# Prometheus documentation
mcp__context7__resolve-library-id → "/websites/prometheus_io-docs"
mcp__context7__query-docs("alerting rules PromQL histogram")

# Find alerting patterns
mcp__github__search_code("alert: expr: filename:prometheus.rules.yml stars:>100")

# Research SRE best practices
mcp__tavily__tavily-search("Google SRE SLO alerting best practices 2024")
```

## Phase 3: DESIGN

Plan observability strategy:

```yaml
mcp__sequential-thinking__sequentialthinking:
  - Define SLIs (latency, error rate, availability)
  - Set SLO targets (99.9%, p95 < 200ms)
  - Plan metric collection (RED, USE methods)
  - Design alerting strategy (symptoms, not causes)
  - Choose tracing approach (sampling, propagation)
```

**Design Decisions:**

| Component | Choice        | Rationale                           |
| --------- | ------------- | ----------------------------------- |
| Logging   | Pino/Winston  | Structured JSON, high performance   |
| Metrics   | Prometheus    | Open standard, powerful queries     |
| Tracing   | OpenTelemetry | Vendor-neutral, comprehensive       |
| Alerting  | SLO-based     | User-focused, reduces alert fatigue |

## Phase 4: IMPLEMENT

Add observability instrumentation:

1. **Configure logging** - Pino/Winston with structured format
2. **Add metrics** - Prometheus counters, histograms, gauges
3. **Set up tracing** - OpenTelemetry SDK and exporters
4. **Create alerts** - SLO-based alerting rules
5. **Build dashboards** - Grafana or vendor dashboards

## Phase 5: VALIDATE

```bash
# Test log output format
npm run start | pino-pretty

# Verify metrics endpoint
curl localhost:9090/metrics

# Validate alert rules
promtool check rules prometheus.rules.yml
```

## Three Pillars of Observability

### Logs (What happened)

- Structured JSON format
- Correlation IDs for request tracing
- Appropriate log levels

### Metrics (Aggregate measurements)

- RED Method for services (Rate, Errors, Duration)
- USE Method for resources (Utilization, Saturation, Errors)

### Traces (Request flow)

- OpenTelemetry instrumentation
- Context propagation across services
- Sampling strategies for production

## MCP Resources

For library IDs and patterns, see:

- [MCP Resources](../../../lib/shared-references/mcp-resources.md)
- [Tool Patterns](../../../lib/shared-references/tool-integration-patterns.md)

### Key Resources

| Resource      | Library ID                     | Use Case          |
| ------------- | ------------------------------ | ----------------- |
| OpenTelemetry | `/websites/opentelemetry_io`   | Tracing, metrics  |
| Prometheus    | `/websites/prometheus_io-docs` | Metrics, alerting |
| Grafana       | `/websites/grafana`            | Dashboards        |
| Pino          | `/pinojs/pino`                 | Node.js logging   |
| Sentry        | `/websites/sentry_io`          | Error tracking    |

## SLI/SLO Definitions

| SLI Type     | Metric           | Formula                        |
| ------------ | ---------------- | ------------------------------ |
| Availability | Success rate     | `successful / total`           |
| Latency      | Request duration | `requests < threshold / total` |
| Error Rate   | Failed requests  | `errors / total`               |

## Handoffs

| Scenario               | Hand off to         |
| ---------------------- | ------------------- |
| Performance profiling  | `performance` skill |
| Security logging audit | `security` skill    |
| Infrastructure setup   | `devops` skill      |
| Bug investigation      | `debug` skill       |
