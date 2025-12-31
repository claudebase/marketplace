---
name: test
description: "Test execution and analysis: run tests, measure coverage, identify gaps, suggest missing tests. Activates for: 'run tests', 'test coverage', 'what tests are missing', 'test this', 'check tests', 'run test suite'."
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

Execute tests, analyze coverage, and identify testing gaps using testing framework documentation.

**Core Principle**: "Run tests frequently, analyze failures thoroughly, improve coverage continuously."

## When to Use

- Test execution ("run tests", "test this", "run test suite")
- Coverage analysis ("test coverage", "coverage report")
- Test status ("check tests", "are tests passing")
- Gap identification ("what tests are missing", "coverage gaps")
- E2E testing ("test the UI", "browser test")

## When NOT to Use

- Test strategy design → use `quality` skill
- Writing tests for new features → use `implement` skill
- Test performance → use `performance` skill

## Quick Workflow

```
DETECT → EXECUTE → ANALYZE → REPORT
 Glob      Bash     Read      Summary
 Read      (test)   Grep
```

1. **Detect** - Find test framework, configuration, test files
2. **Execute** - Run tests with appropriate command
3. **Analyze** - Examine failures, coverage gaps
4. **Report** - Summarize results, recommend improvements

## Framework Detection

| Framework | Config Files                 | Command       |
| --------- | ---------------------------- | ------------- |
| Jest      | jest.config.\*, package.json | npm test      |
| Vitest    | vitest.config.\*             | npx vitest    |
| Pytest    | pytest.ini, pyproject.toml   | pytest        |
| Go        | \*\_test.go                  | go test ./... |

## Tool Integration

For library IDs and patterns, see:

- [MCP Resources](../../lib/shared-references/mcp-resources.md)
- [Tool Patterns](../../lib/shared-references/tool-integration-patterns.md)

### Key Resources

| Resource   | Library ID           | Use Case          |
| ---------- | -------------------- | ----------------- |
| Jest       | `/jestjs/jest`       | JS testing        |
| Vitest     | `/vitest-dev/vitest` | Modern JS testing |
| Pytest     | `/pytest-dev/pytest` | Python testing    |
| Playwright | MCP: playwright      | E2E testing       |

## References

- [Coverage Analysis](references/coverage-analysis.md) - Coverage patterns
- [E2E Patterns](references/e2e-patterns.md) - Browser testing
- [Framework Detection](references/framework-detection.md) - Auto-detection

## Boundaries

**Will**: Run tests, analyze coverage, detect frameworks, identify gaps, suggest improvements

**Will Not**: Design test strategies, implement new tests, optimize test performance
