---
name: performance
description: "Performance analysis and optimization through measurement-driven profiling. Use for bottleneck identification, performance profiling, or speed analysis. Activates for: why is this slow, find bottlenecks, profile performance, optimize speed, analyze performance, improve response time. READ-ONLY."
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - mcp__sequential-thinking__sequentialthinking
---

# Performance Skill

## Purpose

Identify performance bottlenecks through measurement-driven analysis. Provide data-backed optimization recommendations with clear metrics.

**Core Principle**: "Measure first, optimize second. Never assume where performance problems lie."

**Key Distinction**: This skill ANALYZES performance. For implementing optimizations, use the `improve` skill.

## When to Use

**Activate When:**
- User asks "why is this slow"
- User wants to find bottlenecks
- User needs performance profiling
- User asks about response times or load times
- User wants Core Web Vitals analysis

**Do NOT Activate When:**
- User wants to implement optimizations → use `improve` skill
- User wants general code analysis → use `analyze` skill
- User wants security assessment → use `security` skill

**Boundary Clarification:**
This skill performs measurement-driven performance analysis. For implementing the optimizations identified, use the `improve` skill. The `analyze` skill provides general code analysis and will recommend this skill for performance-specific concerns.

## Performance Mindset

> "Premature optimization is the root of all evil. But measured optimization is engineering."

- Profile before optimizing
- Focus on critical paths
- Validate with metrics
- Consider trade-offs

## Focus Areas

### 1. Frontend Performance
- Core Web Vitals (LCP, FID, CLS)
- Bundle size optimization
- Asset delivery and caching
- Render blocking resources
- Image optimization

### 2. Backend Performance
- API response times
- Database query optimization
- N+1 query detection
- Caching strategies
- Connection pooling

### 3. Resource Optimization
- Memory usage patterns
- CPU utilization
- Network efficiency
- I/O bottlenecks

### 4. Critical Path Analysis
- User journey bottlenecks
- Time-to-interactive
- First meaningful paint
- Server response time

## Methodology

1. **Profile**: Gather performance metrics with real data
2. **Identify**: Find actual bottlenecks (not assumed ones)
3. **Analyze**: Understand root causes
4. **Recommend**: Provide specific, measurable optimizations
5. **Validate**: Define success metrics

## Profiling Commands

```bash
# Node.js profiling
node --prof app.js
node --prof-process isolate-*.log

# Python profiling
python -m cProfile -o output.prof script.py
python -m py_spy top -- python script.py

# Frontend (Lighthouse)
lighthouse https://example.com --output=json

# General timing
time command
hyperfine 'command1' 'command2'
```

## MCP Integration

**Use Sequential Thinking for systematic performance analysis:**
```
mcp__sequential-thinking__sequentialthinking - Use for structured bottleneck investigation
```
Sequential Thinking helps trace performance issues through complex systems methodically.

## Output Format

```
## Performance Analysis Report

### Summary
- Critical bottlenecks: X
- Quick wins identified: Y
- Estimated improvement: Z%

### Bottleneck #1: Database Queries
- **Location**: src/api/orders.ts:getOrders()
- **Current**: 2.3s average response time
- **Root Cause**: N+1 query pattern (50 queries per request)
- **Impact**: 80% of request time
- **Recommendation**: Implement eager loading
- **Expected Improvement**: ~90% reduction (2.3s → 0.2s)

### Metrics Baseline
| Metric | Current | Target |
|--------|---------|--------|
| API p95 | 2.3s | <0.5s |
| Memory | 512MB | <256MB |
| DB queries/req | 50 | <5 |

### Quick Wins
1. Add index on `orders.user_id` (est. 40% query improvement)
2. Enable gzip compression (est. 60% payload reduction)
3. Add Redis caching for user sessions
```

## Reference Files

For detailed profiling guides and patterns, see:
- `references/profiling-guide.md` - Profiling tools and techniques
- `references/optimization-patterns.md` - Common optimization patterns
- `references/caching-strategies.md` - Redis, in-memory, and HTTP caching patterns
- `references/database-performance.md` - Query optimization, indexing, and connection pooling
