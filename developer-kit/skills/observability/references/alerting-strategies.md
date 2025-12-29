# Alerting Strategies Reference

## SLO-Based Alerting

### Defining SLIs and SLOs

```yaml
# Service Level Indicators (SLIs)
availability:
  description: "Proportion of successful requests"
  formula: "successful_requests / total_requests"
  measurement: "Rolling 30-day window"

latency:
  description: "Proportion of requests faster than threshold"
  formula: "requests_under_threshold / total_requests"
  thresholds:
    - p50: 100ms
    - p95: 500ms
    - p99: 1000ms

# Service Level Objectives (SLOs)
objectives:
  availability: 99.9%  # 43.8 minutes downtime/month
  latency_p95: 99%     # 99% of requests under 500ms
```

### Error Budget Calculation

```javascript
// Error budget tracking
const calculateErrorBudget = (slo, actualAvailability, windowDays = 30) => {
  const allowedErrorRate = 1 - slo;
  const actualErrorRate = 1 - actualAvailability;
  const errorBudgetRemaining = (allowedErrorRate - actualErrorRate) / allowedErrorRate;

  return {
    slo,
    actualAvailability,
    allowedErrorRate,
    actualErrorRate,
    errorBudgetRemaining: Math.max(0, errorBudgetRemaining),
    errorBudgetConsumed: Math.min(1, 1 - errorBudgetRemaining),
    minutesRemaining: errorBudgetRemaining * windowDays * 24 * 60 * allowedErrorRate
  };
};

// Example: 99.9% SLO with 99.85% actual availability
// Budget consumed: 50%, 21.9 minutes remaining
```

## Prometheus Alerting Rules

```yaml
# alerts/api-alerts.yml
groups:
  - name: api-service
    rules:
      # High Error Rate
      - alert: HighErrorRate
        expr: |
          (
            sum(rate(http_requests_total{status_code=~"5.."}[5m]))
            /
            sum(rate(http_requests_total[5m]))
          ) > 0.01
        for: 5m
        labels:
          severity: critical
        annotations:
          summary: "High error rate detected"
          description: "Error rate is {{ $value | humanizePercentage }} (threshold: 1%)"
          runbook_url: "https://wiki.example.com/runbooks/high-error-rate"

      # Slow Response Time
      - alert: SlowResponseTime
        expr: |
          histogram_quantile(0.95,
            sum(rate(http_request_duration_seconds_bucket[5m])) by (le)
          ) > 0.5
        for: 10m
        labels:
          severity: warning
        annotations:
          summary: "P95 latency is high"
          description: "P95 latency is {{ $value }}s (threshold: 0.5s)"

      # Service Down
      - alert: ServiceDown
        expr: up{job="api-service"} == 0
        for: 1m
        labels:
          severity: critical
        annotations:
          summary: "Service is down"
          description: "{{ $labels.instance }} has been down for more than 1 minute"

      # Error Budget Burn Rate
      - alert: ErrorBudgetBurnRate
        expr: |
          (
            1 - (
              sum(rate(http_requests_total{status_code!~"5.."}[1h]))
              /
              sum(rate(http_requests_total[1h]))
            )
          ) > (1 - 0.999) * 14.4
        for: 5m
        labels:
          severity: critical
        annotations:
          summary: "Error budget burning too fast"
          description: "At current rate, error budget will be exhausted in less than 2 hours"
```

## Alertmanager Configuration

```yaml
# alertmanager.yml
global:
  resolve_timeout: 5m
  slack_api_url: '${SLACK_WEBHOOK_URL}'
  pagerduty_url: 'https://events.pagerduty.com/v2/enqueue'

route:
  receiver: 'default'
  group_by: ['alertname', 'severity']
  group_wait: 30s
  group_interval: 5m
  repeat_interval: 4h
  routes:
    - match:
        severity: critical
      receiver: 'pagerduty-critical'
      continue: true
    - match:
        severity: critical
      receiver: 'slack-critical'
    - match:
        severity: warning
      receiver: 'slack-warning'

receivers:
  - name: 'default'
    slack_configs:
      - channel: '#alerts-default'

  - name: 'pagerduty-critical'
    pagerduty_configs:
      - service_key: '${PAGERDUTY_SERVICE_KEY}'
        severity: critical
        description: '{{ .CommonAnnotations.summary }}'
        details:
          firing: '{{ template "pagerduty.default.instances" .Alerts.Firing }}'
          num_firing: '{{ .Alerts.Firing | len }}'

  - name: 'slack-critical'
    slack_configs:
      - channel: '#alerts-critical'
        color: 'danger'
        title: '{{ .CommonAnnotations.summary }}'
        text: '{{ .CommonAnnotations.description }}'
        actions:
          - type: button
            text: 'Runbook'
            url: '{{ .CommonAnnotations.runbook_url }}'
          - type: button
            text: 'Dashboard'
            url: 'https://grafana.example.com/d/api-service'

  - name: 'slack-warning'
    slack_configs:
      - channel: '#alerts-warning'
        color: 'warning'

inhibit_rules:
  - source_match:
      severity: 'critical'
    target_match:
      severity: 'warning'
    equal: ['alertname']
```

## Alert Severity Guidelines

| Severity | Response Time | Action | Examples |
|----------|--------------|--------|----------|
| Critical | Immediate (page) | Wake up on-call | Service down, data loss risk |
| Warning | Business hours | Create ticket | Degraded performance, disk 80% |
| Info | Next review | Log for trending | Successful deployment |

## On-Call Best Practices

### Runbook Template

```markdown
# Alert: High Error Rate

## Overview
This alert fires when the error rate exceeds 1% for 5 minutes.

## Impact
Users may experience failed requests and degraded service.

## Investigation Steps

1. Check recent deployments
   ```bash
   kubectl rollout history deployment/api-service
   ```

2. Check error logs
   ```bash
   kubectl logs -l app=api-service --since=15m | grep ERROR
   ```

3. Check downstream dependencies
   - Database: https://grafana.example.com/d/postgres
   - Redis: https://grafana.example.com/d/redis
   - External APIs: https://grafana.example.com/d/external

## Mitigation

### Rollback if recent deployment
```bash
kubectl rollout undo deployment/api-service
```

### Scale up if load-related
```bash
kubectl scale deployment/api-service --replicas=10
```

## Escalation
If unresolved after 30 minutes, escalate to:
- Primary: @backend-team-lead
- Secondary: @platform-team
```
