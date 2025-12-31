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
  # Best Practices Research
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  # Complex Architecture Design
  - mcp__sequential-thinking__sequentialthinking
---

# Observability Skill

Enable comprehensive system visibility through structured logging, proactive monitoring, intelligent alerting, metrics collection, and distributed tracing with official documentation and SRE best practices.

## Activation Triggers

- Logging setup ("add logging", "structured logging", "configure Pino/Winston")
- Monitoring ("set up monitoring", "Prometheus metrics", "Datadog setup")
- Alerting ("create alerts", "alerting rules", "PagerDuty integration")
- Tracing ("distributed tracing", "OpenTelemetry", "trace requests")
- Dashboards ("build dashboard", "Grafana setup", "visualize metrics")
- APM ("APM setup", "application performance monitoring")

## Do NOT Activate When

- Simple `console.log` debugging → use `debug` skill
- One-off log statements for development
- Test-only logging
- Performance optimization without metrics → use `performance` skill
- Security logging requirements → use `security` skill

## Behavioral Flow

```
┌──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
│    ASSESS    │   RESEARCH   │    DESIGN    │  IMPLEMENT   │   VALIDATE   │
├──────────────┼──────────────┼──────────────┼──────────────┼──────────────┤
│ Identify     │ Lookup       │ Define       │ Configure    │ Verify data  │
│ existing     │ official     │ SLIs/SLOs    │ logging      │ collection   │
│ observability│ docs         │              │              │              │
│              │              │              │              │              │
│ Check        │ Find         │ Plan         │ Add          │ Test         │
│ current      │ patterns     │ metrics      │ metrics &    │ alerting     │
│ tooling      │              │ strategy     │ tracing      │              │
│              │              │              │              │              │
│ Assess       │ Research     │ Design       │ Create       │ Verify       │
│ gaps         │ best         │ alerting     │ dashboards   │ dashboards   │
│              │ practices    │              │              │              │
└──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘
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

**Tools**: Read, Grep, Glob

### Phase 2: RESEARCH

Gather official documentation and community patterns:

```
# Lookup OpenTelemetry documentation
mcp__context7__resolve-library-id → "/websites/opentelemetry_io"
mcp__context7__query-docs("trace context propagation HTTP headers")

# Lookup Prometheus documentation
mcp__context7__resolve-library-id → "/websites/prometheus_io-docs"
mcp__context7__query-docs("histogram vs summary metrics")

# Find real-world alerting patterns
mcp__github__search_code("alert: expr: filename:prometheus.rules.yml")

# Research SRE best practices
mcp__tavily__tavily-search("Google SRE SLO best practices 2024")
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
```

**Design Decisions:**

- **Logging**: Structured JSON with correlation IDs
- **Metrics**: RED (Rate, Errors, Duration) for services
- **Tracing**: OpenTelemetry for vendor-neutral instrumentation
- **Alerting**: SLO-based with escalation policies

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
```

**Tools**: Bash

## MCP Integration

### Context7 (Official Documentation)

**Primary source for observability tool documentation:**

```
mcp__context7__resolve-library-id - Resolve OpenTelemetry, Prometheus, Grafana IDs
mcp__context7__query-docs - Get official documentation
```

**Available Resources:**

| Resource      | Library ID                     | Snippets |
| ------------- | ------------------------------ | -------- |
| OpenTelemetry | `/websites/opentelemetry_io`   | 8,911    |
| Grafana       | `/websites/grafana`            | 66,435   |
| Datadog       | `/datadog/documentation`       | 26,050   |
| Prometheus    | `/websites/prometheus_io-docs` | 1,795    |
| Pino          | `/pinojs/pino`                 | 170      |

**Use cases:**

- "OpenTelemetry trace context propagation"
- "Prometheus histogram bucket configuration"
- "Grafana dashboard JSON model"
- "Datadog APM tracing setup Node.js"
- "Pino child logger with context"

### GitHub MCP (Pattern Research)

**Find real-world observability configurations:**

```
mcp__github__search_code - Find alerting rules, dashboards, configs
mcp__github__get_file_contents - Get specific configuration files
```

**Search patterns:**

```
# Find Prometheus alerting rules
"alert:" "expr:" "for:" filename:prometheus.rules.yml

# Find Grafana dashboard definitions
"dashboard" "panels" "targets" filename:.json

# Find OpenTelemetry configurations
"TracerProvider" "SpanProcessor" filename:.ts

# Find Pino logging setups
"pino" "level:" "transport" filename:.ts
```

**Use cases:**

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

**Use cases:**

- "Google SRE SLO best practices"
- "OpenTelemetry vs vendor-specific APM comparison"
- "Prometheus alerting patterns avoid alert fatigue"
- "Distributed tracing sampling strategies"
- "RED vs USE method when to use"

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

```javascript
// Good: Structured with context
logger.info("Order processed", {
  orderId: order.id,
  userId: user.id,
  amount: order.total,
  duration: processingTime,
  correlationId: req.correlationId,
});

// Bad: Unstructured string
console.log(`Order ${orderId} processed for user ${userId}`);
```

### Metrics (Aggregate measurements)

```
# RED Method (Request-driven)
http_requests_total{method, status, endpoint}
http_request_duration_seconds{method, endpoint}
http_request_errors_total{method, endpoint, error_type}

# USE Method (Resource-driven)
resource_utilization_ratio{resource}
resource_saturation_ratio{resource}
resource_errors_total{resource}
```

### Traces (Request flow)

```javascript
// OpenTelemetry instrumentation
const tracer = opentelemetry.trace.getTracer("order-service");

async function processOrder(order) {
  return tracer.startActiveSpan("processOrder", async (span) => {
    span.setAttribute("order.id", order.id);
    span.setAttribute("order.amount", order.total);
    // ... processing
    span.end();
  });
}
```

## Log Levels Guide

| Level | When to Use                          | Example                    |
| ----- | ------------------------------------ | -------------------------- |
| ERROR | Action required, service degraded    | Database connection failed |
| WARN  | Investigate soon, service functional | Rate limit approaching     |
| INFO  | Key milestones, audit trail          | User logged in             |
| DEBUG | Development troubleshooting          | Variable values            |

## Alert Design Principles

1. **Alert on symptoms, not causes** - Page when users are affected
2. **Include runbook links** - Every alert has remediation steps
3. **Avoid alert fatigue** - Only page for actionable issues
4. **Use severity levels** - Critical (page), Warning (ticket), Info (log)

## Reference Files

For detailed patterns and examples, see:

- `references/logging-patterns.md` - Structured logging examples
- `references/monitoring-setup.md` - Tool configuration guides
- `references/alerting-strategies.md` - SLO-based alerting
- `references/dashboard-templates.md` - Grafana/Datadog dashboards

## Handoffs

| Scenario                     | Hand off to         |
| ---------------------------- | ------------------- |
| Need performance profiling   | `performance` skill |
| Need security logging audit  | `security` skill    |
| Need infrastructure setup    | `devops` skill      |
| Need database query analysis | `database` skill    |
| Need bug investigation       | `debug` skill       |

## Boundaries

**Will:**

- Configure logging frameworks and formatters
- Set up monitoring agents and collectors
- Create alerting rules and notification channels
- Add metrics instrumentation
- Configure distributed tracing with OpenTelemetry
- Create monitoring dashboards
- Document runbooks and procedures
- Research best practices via MCP tools

**Will Not:**

- Choose vendors without project context
- Configure billing or pricing tiers
- Set up on-call rotation schedules
- Create incident management processes
- Make architecture decisions unrelated to observability
- Provision infrastructure (use `devops` skill)
