---
name: observability
description: "Logging, monitoring, and alerting setup. Activates for: logging, monitoring, alerts, metrics, tracing, Prometheus, Grafana."
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

System visibility through logging, monitoring, alerting, metrics, and tracing.

## Quick Reference

**Activates for**: logging, monitoring, alerts, metrics, tracing, Prometheus, Grafana
**Mode**: read-write
**Output**: Configured observability stack with dashboards

## Workflow

```
ASSESS → RESEARCH → DESIGN → IMPLEMENT → VALIDATE
```

## Three Pillars

- **Logs**: What happened (Pino, Winston)
- **Metrics**: Aggregate measurements (Prometheus)
- **Traces**: Request flow (OpenTelemetry)

## When to Use

- Logging setup, monitoring, alerting, tracing, dashboards

## When NOT to Use

- Console.log debugging → use `debug` skill
- Performance optimization → use `performance` skill
- Security logging → use `security` skill

## References

- [Full Guide](references/guide.md) - Complete workflow and phases
- [Logging Patterns](references/logging-patterns.md) - Structured logging
- [Monitoring Setup](references/monitoring-setup.md) - Tool configuration
- [Alerting Strategies](references/alerting-strategies.md) - SLO-based alerts

## Boundaries

**Will**: Configure logging, set up metrics, create alerts, add tracing
**Will Not**: Choose vendors, configure billing, set up on-call rotations
