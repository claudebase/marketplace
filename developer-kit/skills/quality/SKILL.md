---
name: quality
description: "Designs comprehensive test strategies with coverage recommendations, edge case identification, and testing pyramid guidance. Use when the user needs to plan what tests to write, identify edge cases, or create a testing strategy. Triggers on requests like 'what tests should I write', 'design a test strategy', 'what edge cases', 'create a test plan', 'how should I test this', 'what coverage do I need', or 'plan my testing approach'. This skill PLANS test strategy - for running tests, use test skill; for writing tests, use implement."
composable: true
mode: read-only
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
  - mcp__sequential-thinking__sequentialthinking
---

# Quality Skill

Design comprehensive testing strategies with edge cases and risk-based prioritization.

**Note**: This skill DESIGNS strategy (read-only). To execute tests use `test`, to implement use `implement`.

## Quick Reference

**Activates for**: test strategy, what tests needed, test plan, testing pyramid, coverage
**Mode**: read-only (designs only, never implements)
**Output**: Testing strategy with prioritized test cases

## Workflow

```
ANALYZE → RESEARCH → DESIGN → PRIORITIZE → REPORT
```

## When to Use

- Test strategy ("how should I test this", "testing strategy")
- Coverage improvement ("improve test coverage", "what tests needed")
- Edge case analysis ("find edge cases", "boundary testing")
- Quality assessment ("assess quality", "coverage gaps")

## When NOT to Use

- Run tests → use `test` skill
- General code analysis → use `analyze` skill
- Implement tests → use `implement` skill
- Security testing → use `security` skill

## References

- [Full Guide](references/guide.md) - Complete workflow and phases
- [Testing Strategies](references/testing-strategies.md) - Methodologies
- [Coverage Patterns](references/coverage-patterns.md) - Coverage analysis
- [Mocking Patterns](references/mocking-patterns.md) - Mock and stub patterns

## Boundaries

**Will**: Analyze code, design test cases, identify edge cases, prioritize by risk
**Will NOT**: Execute tests, implement test code, modify source code
