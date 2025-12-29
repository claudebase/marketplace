---
name: test
description: "Test execution and analysis: run tests, measure coverage, identify gaps, suggest missing tests. Activates for: 'run tests', 'test coverage', 'what tests are missing', 'test this', 'check tests', 'run test suite'."
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - Write
  - mcp__playwright__browser_navigate
  - mcp__playwright__browser_snapshot
  - mcp__playwright__browser_click
---

# Test Skill

Comprehensive test execution and analysis for all major test frameworks.

## Activation Triggers

- Test execution requests ("run tests", "test this")
- Coverage analysis needs ("test coverage", "coverage report")
- Missing test identification ("what tests are missing")
- Test quality assessment ("are my tests good enough")
- E2E testing needs ("test the UI", "browser test")

## Behavioral Flow

```
1. DETECT    → Identify test framework and configuration
2. EXECUTE   → Run appropriate test command
3. ANALYZE   → Parse results and coverage
4. REPORT    → Summarize findings with recommendations
5. SUGGEST   → Identify missing tests and edge cases
```

## Test Framework Detection

| Framework | Detection | Command |
|-----------|-----------|---------|
| Jest | package.json, jest.config.* | `npm test` or `npx jest` |
| Vitest | vitest.config.* | `npm test` or `npx vitest` |
| Mocha | .mocharc.*, mocha.opts | `npm test` or `npx mocha` |
| Pytest | pytest.ini, conftest.py, pyproject.toml | `pytest` |
| unittest | test_*.py files | `python -m unittest` |
| Go | *_test.go files | `go test ./...` |
| Rust | Cargo.toml, tests/ | `cargo test` |
| RSpec | spec/ directory, .rspec | `bundle exec rspec` |
| PHPUnit | phpunit.xml | `./vendor/bin/phpunit` |

## Coverage Analysis

### Supported Coverage Tools

| Language | Tool | Command |
|----------|------|---------|
| JavaScript/TypeScript | c8, nyc, jest --coverage | `npm test -- --coverage` |
| Python | coverage.py, pytest-cov | `pytest --cov` |
| Go | go test -cover | `go test -cover ./...` |
| Rust | cargo-tarpaulin | `cargo tarpaulin` |

### Coverage Report Format

```yaml
Coverage Report:
  Statements: 85%
  Branches: 72%
  Functions: 90%
  Lines: 84%

Uncovered Areas:
  - src/auth/oauth.ts:45-67 (error handling)
  - src/api/users.ts:120-135 (edge cases)

Recommendations:
  - Add tests for error paths in oauth.ts
  - Test edge cases for empty user arrays
```

## E2E Testing (Playwright Integration)

For frontend and full-stack projects, integrate with Playwright MCP:

```
mcp__playwright__browser_navigate - Load application pages
mcp__playwright__browser_snapshot - Capture page state
mcp__playwright__browser_click    - Interact with elements
mcp__playwright__browser_type     - Enter text in forms
```

### E2E Test Workflow

1. Navigate to page under test
2. Take snapshot to verify initial state
3. Perform user actions (click, type)
4. Verify expected outcomes
5. Report pass/fail with evidence

## Test Gap Analysis

### Identifying Missing Tests

1. **Code Coverage Gaps** - Uncovered lines and branches
2. **Edge Cases** - Boundary conditions, null/empty inputs
3. **Error Paths** - Exception handling, failure scenarios
4. **Integration Points** - API calls, database operations
5. **Security Cases** - Auth, validation, injection prevention

### Suggesting New Tests

```markdown
## Suggested Tests for src/api/users.ts

### Unit Tests
- [ ] getUserById with valid ID returns user
- [ ] getUserById with invalid ID throws NotFoundError
- [ ] getUserById with null ID throws ValidationError
- [ ] createUser with valid data creates user
- [ ] createUser with duplicate email throws ConflictError

### Integration Tests
- [ ] createUser persists to database
- [ ] getUserById retrieves from cache first

### Edge Cases
- [ ] Handle empty user list in getAllUsers
- [ ] Handle very long email addresses
- [ ] Handle unicode characters in names
```

## References

- [Framework Detection](./references/framework-detection.md)
- [Coverage Analysis](./references/coverage-analysis.md)
- [E2E Testing Patterns](./references/e2e-patterns.md)

## Boundaries

**Will:**
- Run test suites and report results
- Analyze coverage and identify gaps
- Suggest missing test cases
- Execute E2E tests via Playwright MCP
- Parse and summarize test output

**Will Not:**
- Write tests without explicit request (use implement skill)
- Modify existing tests without approval
- Skip tests to improve pass rate
- Ignore test failures

## Handoffs

| Scenario | Hand off to |
|----------|-------------|
| Need to write new tests | `implement` skill |
| Test failures need debugging | `debug` skill |
| Coverage needs improvement | `quality` skill |
| E2E tests need UI changes | `frontend` skill |
