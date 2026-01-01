---
name: test
description: "Test execution and coverage analysis. Activates for: run tests, test coverage, test suite, run specs, check tests, coverage report."
composable: true
mode: read-write
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - Write
  - Edit
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  - mcp__github__search_code
  - mcp__github__get_file_contents
  - mcp__tavily__tavily-search
  - mcp__playwright__browser_navigate
  - mcp__playwright__browser_snapshot
  - mcp__playwright__browser_click
  - mcp__sequential-thinking__sequentialthinking
---

# Test Skill

Execute tests, analyze coverage, and identify testing gaps.

## Quick Reference

**Activates for**: run tests, test coverage, test suite, run specs, check tests
**Mode**: read-write
**Output**: Test results, coverage reports, gap analysis

## Workflow

```
DETECT → EXECUTE → ANALYZE → REPORT
```

## When to Use

- Test execution ("run tests", "test this", "run test suite")
- Coverage analysis ("test coverage", "coverage report")
- Test status ("check tests", "are tests passing")
- Gap identification ("what tests are missing")

## When NOT to Use

- Test strategy design → use `quality` skill
- Writing tests for new features → use `implement` skill
- Test performance → use `performance` skill

## References

- [Full Guide](references/guide.md) - Complete workflow and framework detection
- [Coverage Analysis](references/coverage-analysis.md) - Coverage patterns
- [E2E Patterns](references/e2e-patterns.md) - Browser testing
- [Framework Detection](references/framework-detection.md) - Auto-detection

## Boundaries

**Will**: Run tests, analyze coverage, detect frameworks, identify gaps
**Will Not**: Design test strategies, implement new tests, optimize test performance
