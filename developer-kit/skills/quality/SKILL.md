---
name: quality
description: "MUST USE for test strategy design. Triggers: 'test strategy', 'what tests needed', 'testing approach', 'coverage strategy', 'test plan', 'how to test', 'testing pyramid'. Provides comprehensive testing strategy with coverage recommendations. DO NOT write tests without strategy - this skill ensures proper test distribution (unit/integration/e2e). READ-ONLY."
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

Design comprehensive testing strategies with focus on edge cases, boundary conditions, and risk-based prioritization.

**Core Principle**: "Think beyond the happy path. Find the failures before users do."

**Key Distinction**: This skill DESIGNS testing strategy (read-only). To execute tests, use `test` skill. To implement tests, use `implement` skill.

## When to Use

- Test strategy ("how should I test this", "testing strategy")
- Coverage improvement ("improve test coverage", "what tests needed")
- Edge case analysis ("find edge cases", "boundary testing")
- Quality assessment ("assess quality", "coverage gaps")

## When NOT to Use

- Run tests → use `test` skill or `devops` skill
- General code analysis → use `analyze` skill
- Implement tests → use `implement` skill
- Security testing → use `security` skill

## Quick Workflow

```
ANALYZE → RESEARCH → DESIGN → PRIORITIZE → REPORT
  Read     Context7   Sequential   Sequential   Output
  Grep     GitHub     Thinking     Thinking
           Tavily
```

1. **Analyze** - Read code, map dependencies, identify critical paths
2. **Research** - Query Context7 for testing docs, search GitHub patterns
3. **Design** - Create test cases for all paths, edge cases, boundaries
4. **Prioritize** - Rank by risk and impact, identify quick wins
5. **Report** - Present strategy with implementation guidance

## Tool Integration

For library IDs and patterns, see:

- [MCP Resources](../../lib/shared-references/mcp-resources.md)
- [Tool Patterns](../../lib/shared-references/tool-integration-patterns.md)

### Key Resources

| Resource        | Library ID                  | Use Case          |
| --------------- | --------------------------- | ----------------- |
| Jest            | `/jestjs/jest`              | Unit testing      |
| Vitest          | `/vitest-dev/vitest`        | Fast unit tests   |
| Playwright      | `/microsoft/playwright`     | E2E testing       |
| Testing Library | `/websites/testing-library` | Component testing |

## References

- [Detailed Guide](references/guide.md) - Full workflow and phases
- [Testing Strategies](references/testing-strategies.md) - Methodologies
- [Coverage Patterns](references/coverage-patterns.md) - Coverage analysis
- [API Testing](references/api-testing.md) - REST API, contract testing
- [Mocking Patterns](references/mocking-patterns.md) - Mock and stub patterns

## Boundaries

**Will**: Analyze code, design test cases, identify edge cases, prioritize by risk, recommend coverage targets

**Will NOT**: Execute tests, implement test code, modify source code (use `test` or `implement` skills)
