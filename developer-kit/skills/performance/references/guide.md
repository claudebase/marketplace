# Performance Skill - Detailed Guide

Identify performance bottlenecks through measurement-driven analysis. Provide data-backed optimization recommendations.

**Core Principle**: "Measure first, optimize second. Never assume where performance problems lie."

**Note**: This skill ANALYZES performance (read-only). For implementing optimizations, use the `improve` skill.

---

## Behavioral Flow

```
┌──────────────┬──────────────┬──────────────┬──────────────┐
│   MEASURE    │   PROFILE    │   ANALYZE    │  RECOMMEND   │
├──────────────┼──────────────┼──────────────┼──────────────┤
│ Establish    │ Identify     │ Understand   │ Suggest      │
│ baseline     │ hotspots     │ root causes  │ optimizations│
│ metrics      │ and          │ using        │ with expected│
│              │ bottlenecks  │ structured   │ impact       │
│ Run          │ Read logs    │ reasoning    │              │
│ profilers    │ Parse output │              │ Prioritize   │
│ Lighthouse   │              │              │ by impact    │
└──────────────┴──────────────┴──────────────┴──────────────┘
     Bash           Read         Sequential      Report
     Playwright     Grep         Thinking
```

---

## Analysis Areas

### Frontend Performance

**Core Web Vitals:**

| Metric | Good   | Needs Work | Poor   | What It Measures          |
| ------ | ------ | ---------- | ------ | ------------------------- |
| LCP    | <2.5s  | 2.5-4s     | >4s    | Largest Contentful Paint  |
| INP    | <200ms | 200-500ms  | >500ms | Interaction to Next Paint |
| CLS    | <0.1   | 0.1-0.25   | >0.25  | Cumulative Layout Shift   |

**Measurement commands:**

```bash
# Lighthouse CLI
npx lighthouse https://example.com --output=json --output-path=./report.json

# Web Vitals in browser
mcp__playwright__browser_navigate("https://example.com")
mcp__playwright__browser_snapshot()
```

### Backend Performance

**Key metrics:**

| Metric        | Target | Red Flag  |
| ------------- | ------ | --------- |
| Response time | <200ms | >1000ms   |
| Throughput    | Varies | Declining |
| Error rate    | <0.1%  | >1%       |
| CPU usage     | <70%   | >90%      |
| Memory usage  | Stable | Growing   |

**Profiling commands:**

```bash
# Node.js profiling
node --prof app.js
node --prof-process isolate-*.log > profile.txt

# Python profiling
python -m cProfile -o output.prof script.py
python -m pstats output.prof

# Go profiling
go test -cpuprofile=cpu.prof -bench=.
go tool pprof cpu.prof
```

### Database Performance

**Query analysis:**

```sql
-- PostgreSQL
EXPLAIN ANALYZE SELECT * FROM users WHERE email = 'test@example.com';

-- MySQL
EXPLAIN SELECT * FROM users WHERE email = 'test@example.com';

-- Check slow query log
SHOW VARIABLES LIKE 'slow_query_log%';
```

**Common issues:**

| Issue      | Symptom                | Solution                |
| ---------- | ---------------------- | ----------------------- |
| N+1 Query  | Many similar queries   | Eager loading/joins     |
| Full scan  | High row examination   | Add index               |
| Lock wait  | Slow concurrent writes | Optimize transactions   |
| Large rows | Slow fetches           | Select only needed cols |

---

## Profiling Tools by Language

### JavaScript/TypeScript

```bash
# Chrome DevTools Performance
# Built into browser

# Clinic.js
npx clinic doctor -- node server.js
npx clinic flame -- node server.js

# 0x (flame graphs)
npx 0x server.js
```

### Python

```bash
# cProfile (built-in)
python -m cProfile -s cumulative script.py

# py-spy (sampling profiler)
py-spy record -o profile.svg -- python script.py

# memory_profiler
python -m memory_profiler script.py
```

### Go

```bash
# Built-in pprof
go test -cpuprofile=cpu.prof -memprofile=mem.prof -bench=.

# Runtime profiling
import _ "net/http/pprof"
# Then access /debug/pprof/
```

---

## MCP Tool Integration

### Playwright (Web Performance)

```
mcp__playwright__browser_navigate - Load page
mcp__playwright__browser_snapshot - Capture state
```

### Context7 (Best Practices)

```
mcp__context7__query-docs("React performance optimization")
mcp__context7__query-docs("database query optimization")
```

---

## Output Format

```markdown
## Performance Analysis Report

### Summary

- **Overall Score**: 72/100 (Needs Improvement)
- **Primary Bottleneck**: Database queries (60% of response time)

### Metrics

| Metric       | Current | Target | Status |
| ------------ | ------- | ------ | ------ |
| LCP          | 3.2s    | <2.5s  | ⚠️     |
| API Response | 450ms   | <200ms | ❌     |
| Memory Usage | 512MB   | <256MB | ⚠️     |

### Findings

1. **Critical**: N+1 query in /api/users (42 queries per request)
   - Location: src/api/users.ts:45
   - Impact: 300ms per request
   - Fix: Use eager loading with include clause

2. **High**: Missing index on users.email
   - Location: Database schema
   - Impact: Full table scan on login
   - Fix: CREATE INDEX idx_users_email ON users(email)

### Recommendations

| Priority | Action                  | Expected Impact |
| -------- | ----------------------- | --------------- |
| P0       | Fix N+1 query           | -300ms response |
| P1       | Add database index      | -150ms response |
| P2       | Enable response caching | -50% load       |
```

---

## Handoffs

| Scenario                | Hand off to      |
| ----------------------- | ---------------- |
| Implement optimizations | `improve` skill  |
| Database query issues   | `database` skill |
| General code analysis   | `analyze` skill  |

---

## Related Reference Files

- [profiling-guide.md](profiling-guide.md) - Profiling techniques
- [optimization-patterns.md](optimization-patterns.md) - Common fixes
- [database-performance.md](database-performance.md) - Query optimization
- [caching-strategies.md](caching-strategies.md) - Cache patterns
