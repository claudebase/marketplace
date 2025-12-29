# Dashboard Templates Reference

## RED Method Dashboard (Request, Error, Duration)

### Grafana Dashboard JSON

```json
{
  "title": "API Service - RED Dashboard",
  "tags": ["api", "red-method"],
  "timezone": "browser",
  "panels": [
    {
      "title": "Request Rate",
      "type": "timeseries",
      "gridPos": { "x": 0, "y": 0, "w": 8, "h": 8 },
      "targets": [
        {
          "expr": "sum(rate(http_requests_total[5m])) by (method)",
          "legendFormat": "{{method}}"
        }
      ],
      "fieldConfig": {
        "defaults": {
          "unit": "reqps"
        }
      }
    },
    {
      "title": "Error Rate",
      "type": "timeseries",
      "gridPos": { "x": 8, "y": 0, "w": 8, "h": 8 },
      "targets": [
        {
          "expr": "sum(rate(http_requests_total{status_code=~\"5..\"}[5m])) / sum(rate(http_requests_total[5m])) * 100",
          "legendFormat": "Error %"
        }
      ],
      "fieldConfig": {
        "defaults": {
          "unit": "percent",
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
      "title": "Response Time (P50, P95, P99)",
      "type": "timeseries",
      "gridPos": { "x": 16, "y": 0, "w": 8, "h": 8 },
      "targets": [
        {
          "expr": "histogram_quantile(0.50, sum(rate(http_request_duration_seconds_bucket[5m])) by (le))",
          "legendFormat": "P50"
        },
        {
          "expr": "histogram_quantile(0.95, sum(rate(http_request_duration_seconds_bucket[5m])) by (le))",
          "legendFormat": "P95"
        },
        {
          "expr": "histogram_quantile(0.99, sum(rate(http_request_duration_seconds_bucket[5m])) by (le))",
          "legendFormat": "P99"
        }
      ],
      "fieldConfig": {
        "defaults": {
          "unit": "s"
        }
      }
    }
  ]
}
```

## USE Method Dashboard (Utilization, Saturation, Errors)

```json
{
  "title": "Infrastructure - USE Dashboard",
  "panels": [
    {
      "title": "CPU Utilization",
      "type": "gauge",
      "targets": [
        {
          "expr": "100 - (avg(irate(node_cpu_seconds_total{mode=\"idle\"}[5m])) * 100)"
        }
      ],
      "fieldConfig": {
        "defaults": {
          "unit": "percent",
          "max": 100,
          "thresholds": {
            "steps": [
              { "value": 0, "color": "green" },
              { "value": 70, "color": "yellow" },
              { "value": 90, "color": "red" }
            ]
          }
        }
      }
    },
    {
      "title": "Memory Utilization",
      "type": "gauge",
      "targets": [
        {
          "expr": "(1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)) * 100"
        }
      ]
    },
    {
      "title": "Disk I/O Saturation",
      "type": "timeseries",
      "targets": [
        {
          "expr": "rate(node_disk_io_time_seconds_total[5m])",
          "legendFormat": "{{device}}"
        }
      ]
    },
    {
      "title": "Network Errors",
      "type": "timeseries",
      "targets": [
        {
          "expr": "rate(node_network_receive_errs_total[5m])",
          "legendFormat": "RX Errors {{device}}"
        },
        {
          "expr": "rate(node_network_transmit_errs_total[5m])",
          "legendFormat": "TX Errors {{device}}"
        }
      ]
    }
  ]
}
```

## Service Overview Dashboard

```json
{
  "title": "Service Overview",
  "panels": [
    {
      "title": "SLO Status",
      "type": "stat",
      "gridPos": { "x": 0, "y": 0, "w": 6, "h": 4 },
      "targets": [
        {
          "expr": "sum(rate(http_requests_total{status_code!~\"5..\"}[30d])) / sum(rate(http_requests_total[30d])) * 100"
        }
      ],
      "fieldConfig": {
        "defaults": {
          "unit": "percent",
          "thresholds": {
            "steps": [
              { "value": 0, "color": "red" },
              { "value": 99, "color": "yellow" },
              { "value": 99.9, "color": "green" }
            ]
          }
        }
      }
    },
    {
      "title": "Error Budget Remaining",
      "type": "gauge",
      "gridPos": { "x": 6, "y": 0, "w": 6, "h": 4 },
      "targets": [
        {
          "expr": "1 - ((1 - (sum(rate(http_requests_total{status_code!~\"5..\"}[30d])) / sum(rate(http_requests_total[30d])))) / 0.001)"
        }
      ],
      "fieldConfig": {
        "defaults": {
          "unit": "percentunit",
          "max": 1,
          "thresholds": {
            "steps": [
              { "value": 0, "color": "red" },
              { "value": 0.25, "color": "yellow" },
              { "value": 0.5, "color": "green" }
            ]
          }
        }
      }
    },
    {
      "title": "Active Alerts",
      "type": "alertlist",
      "gridPos": { "x": 12, "y": 0, "w": 12, "h": 8 },
      "options": {
        "showOptions": "current",
        "sortOrder": 1,
        "stateFilter": {
          "firing": true,
          "pending": true
        }
      }
    }
  ]
}
```

## Database Dashboard

```json
{
  "title": "PostgreSQL Dashboard",
  "panels": [
    {
      "title": "Active Connections",
      "targets": [
        {
          "expr": "pg_stat_activity_count{state=\"active\"}"
        }
      ]
    },
    {
      "title": "Queries per Second",
      "targets": [
        {
          "expr": "rate(pg_stat_database_tup_fetched[5m])",
          "legendFormat": "SELECT"
        },
        {
          "expr": "rate(pg_stat_database_tup_inserted[5m])",
          "legendFormat": "INSERT"
        },
        {
          "expr": "rate(pg_stat_database_tup_updated[5m])",
          "legendFormat": "UPDATE"
        },
        {
          "expr": "rate(pg_stat_database_tup_deleted[5m])",
          "legendFormat": "DELETE"
        }
      ]
    },
    {
      "title": "Cache Hit Ratio",
      "targets": [
        {
          "expr": "pg_stat_database_blks_hit / (pg_stat_database_blks_hit + pg_stat_database_blks_read) * 100"
        }
      ],
      "fieldConfig": {
        "defaults": {
          "unit": "percent",
          "thresholds": {
            "steps": [
              { "value": 0, "color": "red" },
              { "value": 90, "color": "yellow" },
              { "value": 99, "color": "green" }
            ]
          }
        }
      }
    },
    {
      "title": "Replication Lag",
      "targets": [
        {
          "expr": "pg_replication_lag"
        }
      ],
      "fieldConfig": {
        "defaults": {
          "unit": "s"
        }
      }
    }
  ]
}
```

## Datadog Dashboard Definition

```python
# datadog_dashboard.py
from datadog_api_client import ApiClient, Configuration
from datadog_api_client.v1.api.dashboards_api import DashboardsApi
from datadog_api_client.v1.model.dashboard import Dashboard

dashboard = Dashboard(
    title="API Service Overview",
    layout_type="ordered",
    widgets=[
        {
            "definition": {
                "title": "Request Rate",
                "type": "timeseries",
                "requests": [
                    {
                        "q": "sum:http.requests{service:api}.as_rate()",
                        "display_type": "line"
                    }
                ]
            }
        },
        {
            "definition": {
                "title": "Error Rate",
                "type": "query_value",
                "requests": [
                    {
                        "q": "sum:http.requests{service:api,status:5xx}.as_rate() / sum:http.requests{service:api}.as_rate() * 100"
                    }
                ],
                "precision": 2
            }
        },
        {
            "definition": {
                "title": "P95 Latency",
                "type": "timeseries",
                "requests": [
                    {
                        "q": "p95:http.request.duration{service:api}",
                        "display_type": "line"
                    }
                ]
            }
        }
    ]
)
```
