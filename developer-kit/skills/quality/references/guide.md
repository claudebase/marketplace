# Quality Skill - Detailed Guide

Complete behavioral flow and methodology for test strategy design.

## Behavioral Flow

```
┌──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
│   ANALYZE    │   RESEARCH   │    DESIGN    │  PRIORITIZE  │    REPORT    │
├──────────────┼──────────────┼──────────────┼──────────────┼──────────────┤
│ Understand   │ Lookup       │ Create test  │ Rank by      │ Present      │
│ code and     │ testing      │ cases for    │ risk and     │ test         │
│ critical     │ docs         │ all paths    │ impact       │ strategy     │
│ paths        │              │              │              │              │
│              │              │              │              │              │
│ Identify     │ Find         │ Cover edge   │ Identify     │ Provide      │
│ testable     │ testing      │ cases and    │ quick wins   │ implementation│
│ units        │ patterns     │ boundaries   │              │ guidance     │
│              │              │              │              │              │
│ Map          │ Research     │ Plan         │ Calculate    │ Define       │
│ dependencies │ best         │ integration  │ coverage     │ success      │
│              │ practices    │ points       │ targets      │ metrics      │
└──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘
     Read           Context7      Sequential      Sequential      Output
     Grep           GitHub        Thinking        Thinking        Report
                    Tavily
```

## Phase 1: ANALYZE

Understand the code and its critical paths.

### Objectives

- Understand functions, classes, and their responsibilities
- Map external services, databases, APIs
- Identify user journeys, data flows, business logic
- Find existing tests and current coverage

### Steps

1. **Read the code** - Understand functions, classes, and their responsibilities
2. **Map dependencies** - External services, databases, APIs
3. **Identify critical paths** - User journeys, data flows, business logic
4. **Find existing tests** - Current coverage, test patterns used

### Commands

```bash
# Find existing tests
find . -name "*.test.*" -o -name "*.spec.*" | head -20

# Check test configuration
cat jest.config.* vitest.config.* playwright.config.* 2>/dev/null

# Analyze current coverage
npx jest --coverage --coverageReporters=text-summary 2>/dev/null
```

**Tools**: Read, Grep, Glob, Bash

## Phase 2: RESEARCH

Gather official documentation and testing patterns.

### MCP Tool Usage

```yaml
# Lookup Jest testing patterns
mcp__context7__resolve-library-id → "/jestjs/jest"
mcp__context7__query-docs("mocking async functions best practices")

# Lookup Vitest configuration
mcp__context7__resolve-library-id → "/vitest-dev/vitest"
mcp__context7__query-docs("coverage configuration v8 istanbul")

# Lookup Playwright test patterns
mcp__context7__resolve-library-id → "/microsoft/playwright"
mcp__context7__query-docs("page object model testing patterns")

# Find testing patterns in codebases
mcp__github__search_code("describe it expect mock filename:.test.ts stars:>500")

# Research current best practices
mcp__tavily__tavily-search("React testing best practices 2024 testing-library")
```

**Tools**: Context7, GitHub MCP, Tavily

## Phase 3: DESIGN

Create comprehensive test cases using Sequential Thinking:

```yaml
mcp__sequential-thinking__sequentialthinking:
  - What are the happy path scenarios?
  - What edge cases exist (null, empty, max, min)?
  - What error conditions should be handled?
  - What integration points need testing?
  - What race conditions or timing issues exist?
```

### Test Case Categories

- **Unit Tests** - Individual functions and methods
- **Integration Tests** - Component interactions, API calls
- **E2E Tests** - Full user journeys
- **Edge Cases** - Boundary values, error states
- **Security Tests** - Input validation, authorization

## Phase 4: PRIORITIZE

Rank tests by risk and impact using Sequential Thinking.

### Prioritization Framework

| Priority      | Criteria                               | Examples                  |
| ------------- | -------------------------------------- | ------------------------- |
| P0 - Critical | Business-critical, high failure impact | Payment, auth, data loss  |
| P1 - High     | Frequently used, user-facing           | Core features, navigation |
| P2 - Medium   | Important but lower risk               | Settings, preferences     |
| P3 - Low      | Nice to have, edge cases               | Rare scenarios            |

## Phase 5: REPORT

Present the test strategy with implementation guidance:

- Coverage analysis and gaps
- Prioritized test cases
- Implementation recommendations
- Success metrics

## MCP Resources

| Resource        | Library ID                          | Snippets |
| --------------- | ----------------------------------- | -------- |
| Jest            | `/jestjs/jest`                      | 1,717    |
| Vitest          | `/vitest-dev/vitest`                | 2,776    |
| Playwright      | `/microsoft/playwright`             | 3,711    |
| Testing Library | `/websites/testing-library`         | 953      |
| Cypress         | `/cypress-io/cypress-documentation` | 2,053    |

## Edge Case Categories

| Category   | Examples                                      |
| ---------- | --------------------------------------------- |
| Empty/Null | `null`, `undefined`, `""`, `[]`, `{}`         |
| Boundaries | 0, -1, MAX_INT, empty string, max length      |
| Special    | Unicode, emojis, SQL injection strings        |
| Timing     | Concurrent access, race conditions, timeouts  |
| State      | Invalid transitions, stale data, cache expiry |

## Quality Metrics

| Metric              | Description               | Target  |
| ------------------- | ------------------------- | ------- |
| Line Coverage       | Lines executed by tests   | > 80%   |
| Branch Coverage     | Decision branches tested  | > 75%   |
| Function Coverage   | Functions called by tests | > 90%   |
| Mutation Score      | Bugs caught by tests      | > 60%   |
| Test Execution Time | Time to run all tests     | < 5 min |

## Test Pyramid

```
        /\
       /  \      E2E Tests (few, slow, expensive)
      /----\
     /      \    Integration Tests (some, medium)
    /--------\
   /          \  Unit Tests (many, fast, cheap)
  --------------
```

## Related Skills

- `test` skill - For executing tests
- `implement` skill - For implementing test code
- `security` skill - For security testing
- `performance` skill - For performance testing
