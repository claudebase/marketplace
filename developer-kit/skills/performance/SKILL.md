---
name: performance
description: "Analyzes performance through measurement, profiling, and benchmarking to identify bottlenecks and optimization opportunities. Use when the user reports slowness, wants to find performance issues, or needs to optimize response times. Triggers on requests like 'why is this slow', 'find the bottleneck', 'profile this code', 'benchmark this', 'improve performance', 'check latency', 'optimize speed', 'this is taking too long', or 'performance analysis'. This skill is READ-ONLY for analysis - for implementing optimizations, use improve skill."
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

Measurement-driven performance analysis with data-backed optimization recommendations.

**Note**: This skill ANALYZES performance (read-only). For implementing optimizations, use `improve` skill.

## Quick Reference

**Activates for**: slow, performance, bottleneck, latency, profiling, benchmark
**Mode**: read-only (analyzes only, never modifies)
**Output**: Baseline metrics, bottleneck analysis, optimization recommendations

## Workflow

```
MEASURE → PROFILE → ANALYZE → RECOMMEND
```

## When to Use

- Speed issues ("why is this slow", "find bottlenecks")
- Performance profiling ("profile performance", "optimize speed")
- Web vitals ("Core Web Vitals", "LCP", "CLS", "INP")
- Resource usage ("memory leak", "high CPU")

## When NOT to Use

- Implementing optimizations → use `improve` skill
- General code analysis → use `analyze` skill
- Database query optimization → use `database` skill

## References

- [Full Guide](references/guide.md) - Complete workflow and profiling
- [Profiling Guide](references/profiling-guide.md) - Profiling techniques
- [Optimization Patterns](references/optimization-patterns.md) - Common fixes
- [Caching Strategies](references/caching-strategies.md) - Cache patterns

## Boundaries

**Will**: Profile code, measure metrics, identify bottlenecks, recommend optimizations
**Will Not**: Implement optimizations, modify code, fix performance issues
