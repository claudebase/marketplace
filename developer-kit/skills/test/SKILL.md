---
name: test
description: "Test execution and analysis: run tests, measure coverage, identify gaps, suggest missing tests. Activates for: 'run tests', 'test coverage', 'what tests are missing', 'test this', 'check tests', 'run test suite'."
allowed-tools:
  # Core Analysis
  - Read
  - Grep
  - Glob
  - Bash
  # Test Writing
  - Write
  - Edit
  # Testing Documentation
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  # Test Pattern Research
  - mcp__github__search_code
  - mcp__github__get_file_contents
  # Best Practices Research
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  # E2E Testing
  - mcp__playwright__browser_navigate
  - mcp__playwright__browser_snapshot
  - mcp__playwright__browser_click
  - mcp__playwright__browser_type
  # Structured Analysis
  - mcp__sequential-thinking__sequentialthinking
---

# Test Skill

Execute tests, analyze coverage, and identify testing gaps using official testing framework documentation and industry best practices.

**Core Principle**: "Run tests frequently, analyze failures thoroughly, improve coverage continuously."

**Key Enhancement**: Research testing patterns and framework-specific features before execution.

**Key Distinction**: This skill EXECUTES tests and analyzes results. For designing test strategies, use the `quality` skill. For writing tests, use the `implement` skill.

## Activation Triggers

- Test execution ("run tests", "test this", "run test suite")
- Coverage analysis ("test coverage", "coverage report")
- Test status ("check tests", "are tests passing")
- Gap identification ("what tests are missing", "coverage gaps")
- E2E testing ("test the UI", "browser test", "end-to-end")

## Do NOT Activate When

- User wants test strategy design → use `quality` skill
- User wants to write new tests → use `implement` skill
- User wants to debug test failures → use `debug` skill
- User wants code analysis → use `analyze` skill

**Boundary Clarification:**
This skill executes tests and analyzes results. For designing comprehensive test strategies, use the `quality` skill. For implementing new tests, use the `implement` skill with guidance from `quality`.

## Behavioral Flow

```
┌──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
│    DETECT    │   RESEARCH   │   EXECUTE    │   ANALYZE    │    REPORT    │
├──────────────┼──────────────┼──────────────┼──────────────┼──────────────┤
│ Identify     │ Lookup       │ Run test     │ Parse        │ Present      │
│ test         │ framework    │ commands     │ results      │ findings     │
│ framework    │ docs         │              │              │              │
│              │              │              │              │              │
│ Find         │ Find         │ Execute      │ Identify     │ Suggest      │
│ configuration│ common       │ with         │ failures     │ improvements │
│              │ patterns     │ coverage     │ and gaps     │              │
│              │              │              │              │              │
│ Check        │ Research     │ Capture      │ Compare      │ Provide      │
│ existing     │ best         │ output       │ against      │ next         │
│ tests        │ practices    │              │ targets      │ steps        │
└──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘
     Glob           Context7      Bash           Sequential      Output
     Read           GitHub                       Thinking        Report
                    Tavily
```

### Phase 1: DETECT

Identify the test framework and configuration:

1. **Detect framework** - Jest, Vitest, pytest, Go test, etc.
2. **Find configuration** - Config files, scripts, coverage settings
3. **Check existing tests** - Test files, patterns, organization
4. **Identify test commands** - Package.json scripts, Makefile targets

```bash
# JavaScript/TypeScript detection
ls package.json jest.config.* vitest.config.* 2>/dev/null

# Python detection
ls pytest.ini pyproject.toml conftest.py setup.cfg 2>/dev/null

# Check package.json scripts
grep -A5 '"scripts"' package.json | grep test

# Find test files
find . -name "*.test.*" -o -name "*.spec.*" -o -name "test_*.py" | head -20
```

**Tools**: Glob, Read, Bash

### Phase 2: RESEARCH

Gather framework-specific documentation and patterns:

```
# Lookup Jest configuration and patterns
mcp__context7__resolve-library-id → "/jestjs/jest"
mcp__context7__query-docs("coverage configuration threshold reporters")

# Lookup Vitest features
mcp__context7__resolve-library-id → "/vitest-dev/vitest"
mcp__context7__query-docs("coverage v8 istanbul configuration")

# Lookup pytest fixtures and markers
mcp__context7__resolve-library-id → "/websites/pytest_en_stable"
mcp__context7__query-docs("fixtures markers parametrize coverage")

# Lookup Playwright test patterns
mcp__context7__resolve-library-id → "/microsoft/playwright"
mcp__context7__query-docs("test assertions locators expect")

# Find test patterns in codebases
mcp__github__search_code("describe it expect beforeEach filename:.test.ts stars:>500")

# Research testing best practices
mcp__tavily__tavily-search("Jest coverage configuration best practices 2024")
```

**Tools**: Context7, GitHub MCP, Tavily

### Phase 3: EXECUTE

Run tests with appropriate commands:

```bash
# Jest
npm test
npx jest --coverage --coverageReporters=text-summary
npx jest --testPathPattern="src/api" --verbose

# Vitest
npm test
npx vitest run --coverage
npx vitest run --reporter=verbose

# pytest
pytest
pytest --cov=src --cov-report=term-missing
pytest -v -x --tb=short

# Go
go test ./...
go test -cover -coverprofile=coverage.out ./...

# Playwright
npx playwright test
npx playwright test --reporter=list
```

**Tools**: Bash

### Phase 4: ANALYZE

Parse results and identify issues:

```
mcp__sequential-thinking__sequentialthinking
- How many tests passed vs failed?
- What's the coverage percentage?
- Which areas have low coverage?
- What patterns emerge in failures?
- What edge cases are missing?
```

**Analysis Focus:**

- **Pass/Fail Summary** - Overall test health
- **Coverage Metrics** - Lines, branches, functions
- **Failure Patterns** - Common causes, flaky tests
- **Gap Identification** - Uncovered code paths
- **Performance** - Slow tests, timeouts

**Tools**: Sequential Thinking, Read

### Phase 5: REPORT

Present findings with actionable recommendations:

- Test execution summary
- Coverage analysis
- Failure details
- Improvement suggestions
- Next steps

**Tools**: Output report

## MCP Integration

### Context7 (Testing Documentation)

**Primary source for testing framework documentation:**

```
mcp__context7__resolve-library-id - Resolve framework IDs
mcp__context7__query-docs - Get official documentation
```

**Available Resources:**

| Resource        | Library ID                          | Snippets |
| --------------- | ----------------------------------- | -------- |
| Jest            | `/jestjs/jest`                      | 1,717    |
| Vitest          | `/vitest-dev/vitest`                | 2,776    |
| Playwright      | `/microsoft/playwright`             | 3,711    |
| Playwright Docs | `/websites/playwright_dev`          | 6,155    |
| Testing Library | `/websites/testing-library`         | 953      |
| pytest          | `/websites/pytest_en_stable`        | 2,982    |
| Cypress         | `/cypress-io/cypress-documentation` | 2,053    |
| Jest DOM        | `/testing-library/jest-dom`         | 86       |
| ts-jest         | `/kulshekhar/ts-jest`               | 628      |

**Use cases:**

- "Jest coverage configuration options"
- "Vitest mocking modules vi.mock"
- "Playwright locator strategies"
- "Testing Library queries getByRole"
- "pytest fixtures and parametrize"
- "Cypress intercept network requests"

### GitHub MCP (Test Pattern Research)

**Find test patterns in production codebases:**

```
mcp__github__search_code - Find test patterns
mcp__github__get_file_contents - Get specific test files
```

**Search patterns:**

```
# Find Jest test patterns
"describe" "it" "expect" "beforeEach" filename:.test.ts stars:>500

# Find mocking patterns
"jest.mock" "vi.mock" "mockImplementation" filename:.test.ts

# Find React component tests
"render" "screen" "userEvent" filename:.test.tsx stars:>500

# Find API test patterns
"supertest" "request" "expect" filename:.test.ts

# Find E2E test patterns
"test" "page" "expect" "locator" filename:.spec.ts
```

**Use cases:**

- Find how popular projects structure tests
- Get mocking examples for common scenarios
- Study test organization patterns
- Compare testing approaches

### Tavily (Best Practices Research)

**Research current testing methodologies:**

```
mcp__tavily__tavily-search - Research testing strategies
mcp__tavily__tavily-extract - Extract from testing guides
```

**Use cases:**

- "Jest vs Vitest comparison 2024"
- "React Testing Library best practices"
- "pytest fixtures advanced patterns"
- "Playwright page object model"
- "Test coverage meaningful metrics"
- "Flaky test prevention strategies"

### Playwright MCP (E2E Testing)

**Execute end-to-end tests in real browser:**

```
mcp__playwright__browser_navigate - Load pages
mcp__playwright__browser_snapshot - Capture state
mcp__playwright__browser_click - Click elements
mcp__playwright__browser_type - Enter text
```

**Use for:**

- Manual E2E test execution
- Visual verification
- Interactive testing
- Debugging E2E failures

### Sequential Thinking (Structured Analysis)

**Systematic test result analysis:**

```
mcp__sequential-thinking__sequentialthinking - Analyze test results
```

**Use for:**

- Interpreting complex test failures
- Identifying coverage gap patterns
- Prioritizing test improvements
- Root cause analysis for flaky tests

## Test Framework Detection

### Automatic Detection

| Framework  | Detection Files                         | Default Command                |
| ---------- | --------------------------------------- | ------------------------------ |
| Jest       | jest.config.\*, package.json (jest)     | `npm test` or `npx jest`       |
| Vitest     | vitest.config.\*                        | `npm test` or `npx vitest run` |
| Mocha      | .mocharc.\*, mocha.opts                 | `npm test` or `npx mocha`      |
| pytest     | pytest.ini, pyproject.toml, conftest.py | `pytest`                       |
| unittest   | test\_\*.py files                       | `python -m unittest`           |
| Go         | \*\_test.go files                       | `go test ./...`                |
| Rust       | Cargo.toml, tests/                      | `cargo test`                   |
| RSpec      | spec/, .rspec                           | `bundle exec rspec`            |
| PHPUnit    | phpunit.xml                             | `./vendor/bin/phpunit`         |
| Playwright | playwright.config.\*                    | `npx playwright test`          |

### Framework-Specific Commands

**Jest:**

```bash
# Run all tests
npx jest

# With coverage
npx jest --coverage

# Specific file/pattern
npx jest --testPathPattern="auth"

# Watch mode
npx jest --watch

# Verbose output
npx jest --verbose

# Update snapshots
npx jest --updateSnapshot
```

**Vitest:**

```bash
# Run all tests
npx vitest run

# With coverage
npx vitest run --coverage

# Watch mode
npx vitest

# Specific file
npx vitest run src/utils.test.ts

# UI mode
npx vitest --ui
```

**pytest:**

```bash
# Run all tests
pytest

# With coverage
pytest --cov=src --cov-report=term-missing

# Verbose
pytest -v

# Stop on first failure
pytest -x

# Specific test
pytest tests/test_auth.py::test_login

# Show locals on failure
pytest --tb=long
```

**Playwright:**

```bash
# Run all tests
npx playwright test

# Headed mode (see browser)
npx playwright test --headed

# Specific browser
npx playwright test --project=chromium

# Debug mode
npx playwright test --debug

# Generate report
npx playwright show-report
```

## Coverage Analysis

### Coverage Metrics

| Metric             | Description                  | Target |
| ------------------ | ---------------------------- | ------ |
| Line Coverage      | % of code lines executed     | > 80%  |
| Branch Coverage    | % of decision branches taken | > 75%  |
| Function Coverage  | % of functions called        | > 90%  |
| Statement Coverage | % of statements executed     | > 80%  |

### Coverage Commands

**Jest:**

```bash
npx jest --coverage --coverageReporters=text-summary
npx jest --coverage --coverageThreshold='{"global":{"lines":80}}'
```

**Vitest:**

```bash
npx vitest run --coverage
npx vitest run --coverage.provider=v8
```

**pytest:**

```bash
pytest --cov=src --cov-report=term-missing
pytest --cov=src --cov-fail-under=80
```

**Go:**

```bash
go test -cover ./...
go test -coverprofile=coverage.out ./...
go tool cover -html=coverage.out
```

### Coverage Report Format

```markdown
## Coverage Report

### Summary

| Metric     | Value | Target | Status |
| ---------- | ----- | ------ | ------ |
| Lines      | 85%   | 80%    | ✅     |
| Branches   | 72%   | 75%    | ⚠️     |
| Functions  | 90%   | 90%    | ✅     |
| Statements | 84%   | 80%    | ✅     |

### Uncovered Areas

| File                | Lines   | Reason                      |
| ------------------- | ------- | --------------------------- |
| src/auth/oauth.ts   | 45-67   | Error handling paths        |
| src/api/users.ts    | 120-135 | Edge cases for empty arrays |
| src/utils/format.ts | 89-95   | Rare date formats           |

### Recommendations

1. Add tests for OAuth error scenarios
2. Test empty array handling in users API
3. Cover edge cases in date formatting
```

## Test Result Analysis

### Interpreting Failures

```markdown
## Test Failure Analysis

### Failed: AuthService.login should reject invalid credentials

**Error**: `expect(received).toBe(expected)`

- Expected: `"Invalid password"`
- Received: `"Authentication failed"`

**Location**: `src/auth/__tests__/auth.test.ts:45`

**Root Cause**: Error message changed in auth service without updating test

**Fix**: Update expected error message or use toContain matcher

### Failed: UserAPI.getUsers handles empty response

**Error**: `TypeError: Cannot read property 'map' of undefined`

**Location**: `src/api/__tests__/users.test.ts:78`

**Root Cause**: API returns undefined instead of empty array

**Fix**: Add null check in API response handling
```

### Flaky Test Detection

```markdown
## Flaky Tests Detected

| Test                  | File              | Failure Rate | Cause                      |
| --------------------- | ----------------- | ------------ | -------------------------- |
| should load dashboard | dashboard.test.ts | 15%          | Race condition in async    |
| renders user list     | users.test.tsx    | 8%           | Timing-dependent assertion |

### Recommendations

1. Add `await waitFor()` for async assertions
2. Mock timers for time-dependent tests
3. Increase timeout for network tests
4. Use `findBy` instead of `getBy` for async elements
```

## E2E Testing with Playwright

### E2E Test Workflow

```
1. Navigate to application URL
2. Take snapshot to verify initial state
3. Perform user interactions
4. Assert expected outcomes
5. Capture evidence (screenshots, traces)
```

### Manual E2E Execution

```
# Navigate to page
mcp__playwright__browser_navigate("http://localhost:3000/login")

# Capture initial state
mcp__playwright__browser_snapshot()

# Fill login form
mcp__playwright__browser_type(ref="email-input", text="user@example.com")
mcp__playwright__browser_type(ref="password-input", text="password123")

# Click submit
mcp__playwright__browser_click(ref="submit-button")

# Verify result
mcp__playwright__browser_snapshot()
```

### E2E Best Practices

| Practice         | Description                               |
| ---------------- | ----------------------------------------- |
| Use data-testid  | Stable selectors that survive refactoring |
| Isolate tests    | Each test should be independent           |
| Seed test data   | Start with known state                    |
| Handle flakiness | Add appropriate waits                     |
| Capture evidence | Screenshots and traces on failure         |

## Output Format

```markdown
## Test Execution Report

### Summary

| Metric    | Value |
| --------- | ----- |
| Tests Run | 156   |
| Passed    | 152   |
| Failed    | 3     |
| Skipped   | 1     |
| Duration  | 45.2s |

### Coverage

| Type      | Coverage | Target | Status |
| --------- | -------- | ------ | ------ |
| Lines     | 85%      | 80%    | ✅     |
| Branches  | 72%      | 75%    | ⚠️     |
| Functions | 90%      | 90%    | ✅     |

### Failed Tests

#### 1. AuthService.login rejects invalid credentials

- **File**: `src/auth/__tests__/auth.test.ts:45`
- **Error**: Expected error message mismatch
- **Suggested Fix**: Update assertion to match new error format

#### 2. UserAPI.getUsers handles pagination

- **File**: `src/api/__tests__/users.test.ts:89`
- **Error**: Timeout waiting for response
- **Suggested Fix**: Increase timeout or mock API response

### Research Applied

- Jest coverage: Official Jest documentation
- Async testing: Testing Library best practices
- Flaky test prevention: [Tavily source]

### Recommendations

1. **Immediate**: Fix 3 failing tests
2. **Short-term**: Improve branch coverage to 75%
3. **Long-term**: Add integration tests for payment flow

### Next Steps

- [ ] Fix `AuthService.login` assertion
- [ ] Debug `UserAPI.getUsers` timeout
- [ ] Add tests for uncovered error paths
```

## Reference Files

For detailed patterns, see:

- `references/framework-detection.md` - Framework identification
- `references/coverage-analysis.md` - Coverage interpretation
- `references/e2e-patterns.md` - E2E testing patterns
- `references/flaky-tests.md` - Handling flaky tests

## Handoffs

| Scenario                     | Hand off to         |
| ---------------------------- | ------------------- |
| Need to write new tests      | `implement` skill   |
| Need test strategy design    | `quality` skill     |
| Test failures need debugging | `debug` skill       |
| E2E tests need UI changes    | `frontend` skill    |
| Need performance testing     | `performance` skill |

## Boundaries

**Will:**

- Run test suites and report results
- Analyze coverage and identify gaps
- Parse test output from any framework
- Research framework-specific patterns via MCP
- Execute E2E tests via Playwright MCP
- Suggest missing test cases
- Identify flaky tests

**Will Not:**

- Write tests without explicit request (use `implement` skill)
- Design test strategies (use `quality` skill)
- Debug complex test failures (use `debug` skill)
- Modify existing tests without approval
- Skip tests to improve pass rate
- Ignore test failures
