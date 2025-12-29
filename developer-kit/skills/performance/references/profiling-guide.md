# Performance Profiling Guide

## Profiling Strategy

### When to Profile
1. Before any optimization attempt
2. After optimization to validate
3. During load testing
4. When investigating production issues
5. As part of CI/CD pipeline

### What to Measure
- **Time**: Execution time, latency
- **Memory**: Heap usage, allocations
- **CPU**: Utilization, hot spots
- **I/O**: Disk, network operations
- **Throughput**: Requests per second

## JavaScript/Node.js Profiling

### Built-in Profiler
```bash
# Start with profiler
node --prof app.js

# Process the log
node --prof-process isolate-*.log > processed.txt
```

### Chrome DevTools
```javascript
// In code
console.time('operation');
// ... code to measure
console.timeEnd('operation');

// Memory snapshot
console.memory
```

### Performance Hooks
```javascript
const { performance, PerformanceObserver } = require('perf_hooks');

const obs = new PerformanceObserver((items) => {
  console.log(items.getEntries());
});
obs.observe({ entryTypes: ['measure'] });

performance.mark('start');
// ... operation
performance.mark('end');
performance.measure('operation', 'start', 'end');
```

### Clinic.js
```bash
# Doctor - overall health
npx clinic doctor -- node app.js

# Flame - CPU profiling
npx clinic flame -- node app.js

# Bubbleprof - async profiling
npx clinic bubbleprof -- node app.js
```

## Python Profiling

### cProfile
```bash
# Command line
python -m cProfile -o output.prof script.py

# Analyze
python -m pstats output.prof
```

```python
# In code
import cProfile
import pstats

profiler = cProfile.Profile()
profiler.enable()
# ... code to profile
profiler.disable()
stats = pstats.Stats(profiler)
stats.sort_stats('cumulative')
stats.print_stats(10)
```

### py-spy (Sampling Profiler)
```bash
# Top-like view
py-spy top --pid 12345

# Record flamegraph
py-spy record -o profile.svg --pid 12345

# Profile a script
py-spy record -o profile.svg -- python script.py
```

### Memory Profiling
```bash
pip install memory_profiler

# Profile script
python -m memory_profiler script.py
```

```python
from memory_profiler import profile

@profile
def my_function():
    # ... code
```

## Database Query Profiling

### PostgreSQL
```sql
-- Enable query logging
SET log_statement = 'all';
SET log_duration = on;

-- Explain analyze
EXPLAIN ANALYZE SELECT * FROM users WHERE email = 'test@example.com';

-- Show slow queries
SELECT query, calls, mean_time, total_time
FROM pg_stat_statements
ORDER BY total_time DESC
LIMIT 10;
```

### MySQL
```sql
-- Enable slow query log
SET GLOBAL slow_query_log = 'ON';
SET GLOBAL long_query_time = 1;

-- Explain
EXPLAIN SELECT * FROM users WHERE email = 'test@example.com';

-- Show process list
SHOW FULL PROCESSLIST;
```

### MongoDB
```javascript
// Enable profiling
db.setProfilingLevel(2);

// Query slow operations
db.system.profile.find({millis: {$gt: 100}}).sort({ts: -1}).limit(10);

// Explain
db.collection.find({field: value}).explain("executionStats");
```

## Frontend Profiling

### Lighthouse CLI
```bash
# Basic audit
lighthouse https://example.com --output=html

# Specific categories
lighthouse https://example.com --only-categories=performance

# JSON output for CI
lighthouse https://example.com --output=json --output-path=./report.json
```

### Core Web Vitals
```javascript
// Web Vitals library
import {getCLS, getFID, getLCP} from 'web-vitals';

getCLS(console.log);
getFID(console.log);
getLCP(console.log);
```

### Chrome DevTools Performance Tab
1. Open DevTools → Performance
2. Click Record
3. Perform actions
4. Stop recording
5. Analyze flame chart

## Benchmarking Tools

### hyperfine (Command-line benchmarking)
```bash
# Compare two commands
hyperfine 'node script1.js' 'node script2.js'

# With warmup
hyperfine --warmup 3 'command'

# Export results
hyperfine --export-json results.json 'command'
```

### wrk (HTTP benchmarking)
```bash
# Basic benchmark
wrk -t12 -c400 -d30s http://localhost:3000/api

# With Lua script
wrk -t12 -c400 -d30s -s script.lua http://localhost:3000
```

### k6 (Load testing)
```javascript
// script.js
import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  vus: 100,
  duration: '30s',
};

export default function() {
  const res = http.get('http://localhost:3000/api');
  check(res, { 'status was 200': (r) => r.status === 200 });
  sleep(1);
}
```

```bash
k6 run script.js
```

## Interpreting Results

### Time Metrics
- **p50** (median): 50% of requests faster
- **p95**: 95% of requests faster
- **p99**: 99% of requests faster (tail latency)
- **max**: Worst case

### Red Flags
- p99 >> p50 (high variance)
- Growing memory over time (leak)
- CPU spikes without load
- Increasing response times under constant load

### Quick Analysis Checklist
- [ ] What's the hottest function?
- [ ] Where is most time spent?
- [ ] Any N+1 query patterns?
- [ ] Memory growing over time?
- [ ] Any blocking operations?
