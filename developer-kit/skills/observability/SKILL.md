---
name: observability
description: "Sets up logging, monitoring, alerting, metrics collection, and distributed tracing using tools like Prometheus, Grafana, and OpenTelemetry. Use when the user needs to add observability to their system, track metrics, or set up alerts. Triggers on requests like 'add logging', 'set up monitoring', 'create alerts for', 'track metrics', 'add tracing', 'set up Prometheus', 'create a Grafana dashboard', 'instrument this code', or 'I need to monitor'. NOT for debugging specific issues (use debug) or performance profiling (use performance)."
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
