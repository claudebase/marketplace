---
name: performance
description: "MUST USE for performance concerns. Triggers: 'slow', 'performance', 'bottleneck', 'optimize speed', 'latency', 'response time', 'profiling', 'benchmark'. Provides measurement-driven analysis - profile first, then identify bottlenecks. DO NOT guess at performance issues - this skill ensures data-driven optimization. READ-ONLY. Use improve skill for fixes."
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  - mcp__github__search_code
  - mcp__github__get_file_contents
  - mcp__tavily__tavily-search
  - mcp__playwright__browser_navigate
  - mcp__playwright__browser_snapshot
  - mcp__sequential-thinking__sequentialthinking
composable: true
mode: read-only
---

# Performance Skill

Identify performance bottlenecks through measurement-driven analysis. Provide data-backed optimization recommendations.

**Core Principle**: "Measure first, optimize second. Never assume where performance problems lie."

**Note**: This skill ANALYZES performance (read-only). For implementing optimizations, use the `improve` skill.

## When to Use

- Speed issues ("why is this slow", "find bottlenecks")
- Performance profiling ("profile performance", "optimize speed")
- Web vitals ("Core Web Vitals", "LCP", "CLS", "INP")
- Response times ("improve response time", "API is slow")
- Resource usage ("memory leak", "high CPU")

## When NOT to Use

- Implementing optimizations → use `improve` skill
- General code analysis → use `analyze` skill
- Database query optimization → use `database` skill

## Analysis Areas

| Area     | Metrics                   | Tools                   |
| -------- | ------------------------- | ----------------------- |
| Frontend | LCP, CLS, INP             | Lighthouse, Playwright  |
| Backend  | Response time, throughput | Profilers, logs         |
| Database | Query time, connections   | EXPLAIN, slow query log |
| Memory   | Heap size, GC frequency   | Memory profilers        |

## Quick Workflow

```
MEASURE → PROFILE → ANALYZE → RECOMMEND
  Bash      Read     Sequential   Report
  Playwright Grep    Thinking
```

1. **Measure** - Establish baseline metrics
2. **Profile** - Identify hotspots and bottlenecks
3. **Analyze** - Understand root causes
4. **Recommend** - Suggest optimizations with expected impact

## Tool Integration

For library IDs and patterns, see:

- [MCP Resources](../../lib/shared-references/mcp-resources.md)
- [Tool Patterns](../../lib/shared-references/tool-integration-patterns.md)

## References

- [Profiling Guide](references/profiling-guide.md) - Profiling techniques
- [Optimization Patterns](references/optimization-patterns.md) - Common fixes
- [Database Performance](references/database-performance.md) - Query optimization
- [Caching Strategies](references/caching-strategies.md) - Cache patterns

## Boundaries

**Will**: Profile code, measure metrics, identify bottlenecks, recommend optimizations

**Will Not**: Implement optimizations, modify code, fix performance issues
