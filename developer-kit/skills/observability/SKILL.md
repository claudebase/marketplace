---
name: observability
description: "Configure logging, monitoring, alerting, and metrics for production systems. Activates for: 'add logging', 'setup monitoring', 'create alerts', 'add metrics', 'distributed tracing', 'build dashboard', 'APM setup', 'telemetry', 'observability stack'."
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
  - Task
  - mcp__sequential-thinking__sequentialthinking
---

# Observability Skill

## Purpose

Enable comprehensive system visibility through structured logging, proactive monitoring, intelligent alerting, metrics collection, and distributed tracing.

## Activation Triggers

Activate when the user mentions:
- "Add logging to this service"
- "Set up monitoring for production"
- "Create alerts for errors"
- "Add metrics collection"
- "Configure distributed tracing"
- "Create a dashboard"
- "Set up observability"
- "Add telemetry"
- "Configure APM"
- "Set up error tracking"
- "Add health checks"

## Do NOT Activate When

- Simple `console.log` debugging (use `debug`)
- One-off log statements for development
- Test-only logging
- Performance optimization without metrics (use `performance`)

## Behavioral Flow

### 1. Assess Current State
- Identify existing logging framework
- Check for monitoring configuration
- Review current alerting rules
- Assess metrics collection status
- Evaluate tracing setup

### 2. Design Observability Strategy
Select appropriate tools based on stack:
- **Logging**: Winston, Pino, Bunyan (Node.js); Loguru, structlog (Python)
- **Monitoring**: Prometheus, Datadog, New Relic, Grafana
- **Alerting**: PagerDuty, OpsGenie, Prometheus Alertmanager
- **Tracing**: Jaeger, Zipkin, OpenTelemetry
- **APM**: Datadog APM, New Relic, Elastic APM

### 3. Implement Instrumentation
Follow the Three Pillars of Observability:

**Logs** (What happened):
- Structured JSON format
- Correlation IDs for request tracing
- Appropriate log levels
- Contextual metadata

**Metrics** (Aggregate measurements):
- RED method: Rate, Errors, Duration
- USE method: Utilization, Saturation, Errors
- Business metrics alignment

**Traces** (Request flow):
- Distributed context propagation
- Span creation and annotation
- Service dependency mapping

### 4. Configure Alerting
- Define SLIs (Service Level Indicators)
- Set SLOs (Service Level Objectives)
- Create actionable alerts
- Establish notification channels
- Document runbooks

### 5. Validate and Document
- Verify log aggregation
- Test alert triggering
- Validate dashboard accuracy
- Create runbooks
- Document on-call procedures

## Key Patterns

### Structured Logging
```javascript
// Good: Structured with context
logger.info('Order processed', {
  orderId: order.id,
  userId: user.id,
  amount: order.total,
  duration: processingTime,
  correlationId: req.correlationId
});

// Bad: Unstructured string
console.log(`Order ${orderId} processed for user ${userId}`);
```

### Log Levels Guide

| Level | When to Use | Example |
|-------|-------------|---------|
| ERROR | Action required, service degraded | Database connection failed |
| WARN | Investigate soon, service functional | Rate limit approaching |
| INFO | Key milestones, audit trail | User logged in |
| DEBUG | Development troubleshooting | Variable values |

### Metrics Naming Convention
```
<namespace>_<subsystem>_<name>_<unit>

Examples:
http_server_requests_total
http_server_request_duration_seconds
database_connections_active
queue_messages_processed_total
```

### Alert Design Principles
1. **Alert on symptoms, not causes** - Page when users are affected
2. **Include runbook links** - Every alert has remediation steps
3. **Avoid alert fatigue** - Only page for actionable issues
4. **Use severity levels** - Critical (page), Warning (ticket), Info (log)

## MCP Integration

- **sequential-thinking**: Design complex observability architectures

## References

- [logging-patterns.md](references/logging-patterns.md) - Structured logging examples
- [monitoring-setup.md](references/monitoring-setup.md) - Tool configuration guides
- [alerting-strategies.md](references/alerting-strategies.md) - SLO-based alerting
- [dashboard-templates.md](references/dashboard-templates.md) - Grafana/Datadog dashboards

## Boundaries

### Will Do
- Configure logging frameworks and formatters
- Set up monitoring agents and collectors
- Create alerting rules and notification channels
- Add metrics instrumentation
- Configure distributed tracing
- Create monitoring dashboards
- Document runbooks and procedures

### Will NOT Do
- Choose vendors without project context
- Configure billing or pricing tiers
- Set up on-call rotation schedules
- Create incident management processes
- Make architecture decisions unrelated to observability
