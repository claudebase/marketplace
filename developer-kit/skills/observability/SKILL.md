---
name: observability
description: "Configure logging, monitoring, alerting, and metrics for production systems. This skill should be used when the user asks to 'add logging', 'setup monitoring', 'create alerts', or 'add metrics'. Also use when user mentions distributed tracing, APM setup, dashboard building, or observability stack."
composable: true
mode: read-write
allowed-tools:
  - Read
  - Grep
  - Glob
  - Write
  - Edit
  - Bash
  - Task
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  - mcp__github__search_code
  - mcp__github__get_file_contents
  - mcp__tavily__tavily-search
  - mcp__sequential-thinking__sequentialthinking
---

# Observability Skill

Enable comprehensive system visibility through structured logging, proactive monitoring, intelligent alerting, metrics collection, and distributed tracing.

**Core Principle**: "Measure everything, alert on symptoms, debug with traces."

## When to Use

- Logging setup ("add logging", "structured logging", "Pino/Winston")
- Monitoring ("set up monitoring", "Prometheus metrics", "Datadog")
- Alerting ("create alerts", "SLO alerts", "error rate alerts")
- Tracing ("distributed tracing", "OpenTelemetry")
- Dashboards ("build dashboard", "Grafana setup")

## When NOT to Use

- Simple console.log debugging → use `debug` skill
- Performance optimization → use `performance` skill
- Security logging requirements → use `security` skill

## Quick Workflow

```
ASSESS → RESEARCH → DESIGN → IMPLEMENT → VALIDATE
 Read     Context7   Sequential   Write      Bash
 Grep     GitHub     Thinking     Edit       (test)
          Tavily
```

1. **Assess** - Identify existing logging, metrics, gaps
2. **Research** - Query Context7 for tool docs, search patterns
3. **Design** - Define SLIs/SLOs, plan metrics strategy
4. **Implement** - Configure logging, add metrics, create alerts
5. **Validate** - Verify data collection, test alerting

## Three Pillars

| Pillar  | Purpose                | Tools                   |
| ------- | ---------------------- | ----------------------- |
| Logs    | What happened          | Pino, Winston           |
| Metrics | Aggregate measurements | Prometheus, prom-client |
| Traces  | Request flow           | OpenTelemetry           |

## Tool Integration

For library IDs and patterns, see:

- [MCP Resources](../../lib/shared-references/mcp-resources.md)
- [Tool Patterns](../../lib/shared-references/tool-integration-patterns.md)

### Key Resources

| Resource      | Library ID                     | Use Case   |
| ------------- | ------------------------------ | ---------- |
| OpenTelemetry | `/websites/opentelemetry_io`   | Tracing    |
| Prometheus    | `/websites/prometheus_io-docs` | Metrics    |
| Grafana       | `/websites/grafana`            | Dashboards |
| Pino          | `/pinojs/pino`                 | Logging    |

## References

- [Detailed Guide](references/guide.md) - Full workflow and phases
- [Logging Patterns](references/logging-patterns.md) - Structured logging examples
- [Monitoring Setup](references/monitoring-setup.md) - Tool configuration
- [Alerting Strategies](references/alerting-strategies.md) - SLO-based alerting
- [Dashboard Templates](references/dashboard-templates.md) - Grafana examples

## Boundaries

**Will**: Configure logging, set up metrics, create alerts, add tracing, build dashboards

**Will Not**: Choose vendors, configure billing, set up on-call rotations
