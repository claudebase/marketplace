# Test Skill - Detailed Guide

Execute tests, analyze coverage, and identify testing gaps using testing framework documentation.

**Core Principle**: "Run tests frequently, analyze failures thoroughly, improve coverage continuously."

---

## Behavioral Flow

```
┌──────────────┬──────────────┬──────────────┬──────────────┐
│    DETECT    │   EXECUTE    │   ANALYZE    │    REPORT    │
├──────────────┼──────────────┼──────────────┼──────────────┤
│ Find test    │ Run tests    │ Examine      │ Summarize    │
│ framework    │ with         │ failures     │ results      │
│ and config   │ appropriate  │ and coverage │ recommend    │
│              │ command      │ gaps         │ improvements │
│ Glob for     │ Execute      │ Parse        │ Format       │
│ test files   │ test suite   │ output       │ report       │
└──────────────┴──────────────┴──────────────┴──────────────┘
     Glob           Bash          Read          Summary
     Read                         Grep
```

---

## Framework Detection

### JavaScript/TypeScript

| Framework  | Config Files                    | Command             |
| ---------- | ------------------------------- | ------------------- |
| Jest       | jest.config.js/ts, package.json | npm test            |
| Vitest     | vitest.config.js/ts             | npx vitest          |
| Mocha      | .mocharc.js/json                | npx mocha           |
| Playwright | playwright.config.ts            | npx playwright test |

### Python

| Framework | Config Files               | Command            |
| --------- | -------------------------- | ------------------ |
| Pytest    | pytest.ini, pyproject.toml | pytest             |
| Unittest  | (none)                     | python -m unittest |
| Nose2     | nose2.cfg                  | nose2              |

### Go

| Framework | Config Files | Command       |
| --------- | ------------ | ------------- |
| testing   | \*\_test.go  | go test ./... |

### Rust

| Framework | Config Files | Command    |
| --------- | ------------ | ---------- |
| cargo     | Cargo.toml   | cargo test |

---

## Test Commands

### Running Tests

```bash
# JavaScript/TypeScript
npm test                    # Run default test script
npx jest                    # Run Jest directly
npx vitest run              # Run Vitest
npx playwright test         # Run Playwright

# Python
pytest                      # Run all tests
pytest tests/test_api.py    # Run specific file
pytest -k "test_login"      # Run tests matching pattern

# Go
go test ./...               # All packages
go test -v ./pkg/...        # Verbose output

# Rust
cargo test                  # All tests
cargo test -- --nocapture   # Show output
```

### Coverage Commands

```bash
# JavaScript
npx jest --coverage
npx vitest run --coverage

# Python
pytest --cov=src --cov-report=term-missing
pytest --cov=src --cov-report=html

# Go
go test -cover ./...
go test -coverprofile=coverage.out ./...
go tool cover -html=coverage.out

# Rust
cargo tarpaulin
```

---

## MCP Tool Integration

### Context7 (Test Documentation)

| Resource   | Library ID           | Use Case          |
| ---------- | -------------------- | ----------------- |
| Jest       | `/jestjs/jest`       | JS testing        |
| Vitest     | `/vitest-dev/vitest` | Modern JS testing |
| Pytest     | `/pytest-dev/pytest` | Python testing    |
| Playwright | MCP: playwright      | E2E testing       |

**Queries:**

```
mcp__context7__query-docs("Jest mock functions")
mcp__context7__query-docs("Pytest fixtures")
mcp__context7__query-docs("Vitest coverage configuration")
```

### Playwright MCP (E2E Testing)

```
mcp__playwright__browser_navigate - Navigate to page
mcp__playwright__browser_snapshot - Capture state
mcp__playwright__browser_click - Interact with elements
```

---

## Coverage Analysis

### Understanding Coverage Metrics

| Metric    | Description                       | Target |
| --------- | --------------------------------- | ------ |
| Line      | Percentage of lines executed      | >80%   |
| Branch    | Percentage of branches taken      | >70%   |
| Function  | Percentage of functions called    | >90%   |
| Statement | Percentage of statements executed | >80%   |

### Identifying Gaps

```bash
# Jest coverage with uncovered lines
npx jest --coverage --coverageReporters=text

# Pytest with missing lines
pytest --cov=src --cov-report=term-missing

# Output shows:
# Name                 Stmts   Miss  Cover   Missing
# src/api/users.py       50     10    80%   45-50, 72-76
```

### Coverage Thresholds

```javascript
// jest.config.js
module.exports = {
  coverageThreshold: {
    global: {
      branches: 70,
      functions: 80,
      lines: 80,
      statements: 80,
    },
  },
};
```

---

## Test Failure Analysis

### Common Failure Patterns

| Pattern           | Likely Cause                 | Fix                         |
| ----------------- | ---------------------------- | --------------------------- |
| Timeout           | Async not awaited            | Add await, increase timeout |
| Assertion failure | Logic error or outdated test | Update test or fix code     |
| Module not found  | Missing dependency           | npm install / fix path      |
| Network error     | External API in unit test    | Mock the API                |

### Debugging Failures

```bash
# Run single test with verbose output
npx jest --verbose path/to/test.ts
pytest -v tests/test_file.py::test_function

# Run with debugger
node --inspect-brk ./node_modules/.bin/jest --runInBand
pytest --pdb

# Show only failures
npx jest --onlyFailures
pytest --lf  # last failed
```

---

## E2E Testing with Playwright

### Basic Flow

```typescript
// Run navigation test
mcp__playwright__browser_navigate("http://localhost:3000/login");
mcp__playwright__browser_snapshot(); // Verify page loaded

// Interact with form
mcp__playwright__browser_click({ element: "Email input", ref: "email-input" });
mcp__playwright__browser_type({ ref: "email-input", text: "test@example.com" });

// Submit and verify
mcp__playwright__browser_click({ element: "Submit button", ref: "submit" });
mcp__playwright__browser_snapshot(); // Verify result
```

---

## Output Format

```markdown
## Test Execution Report

### Summary

- **Total Tests**: 156
- **Passed**: 152
- **Failed**: 3
- **Skipped**: 1
- **Duration**: 45.2s

### Coverage

| Metric    | Current | Target | Status |
| --------- | ------- | ------ | ------ |
| Lines     | 82%     | 80%    | ✅     |
| Branches  | 68%     | 70%    | ⚠️     |
| Functions | 91%     | 90%    | ✅     |

### Failures

#### 1. test_user_login (tests/test_auth.py:45)

- **Error**: AssertionError: Expected 200, got 401
- **Cause**: Auth token not refreshed in test setup
- **Fix**: Add token refresh to fixture

#### 2. UserProfile.test.tsx:23

- **Error**: Timeout waiting for element
- **Cause**: Async loading not awaited
- **Fix**: Add waitFor around assertion

### Coverage Gaps

- `src/api/payments.py`: Lines 89-105 (error handling)
- `src/components/Modal.tsx`: Branch at line 34 (edge case)

### Recommendations

1. Add tests for payment error scenarios (P1)
2. Fix flaky auth test (P0)
3. Add branch coverage for Modal component (P2)
```

---

## Handoffs

| Scenario                | Hand off to         |
| ----------------------- | ------------------- |
| Test strategy design    | `quality` skill     |
| Write new tests         | `implement` skill   |
| Test performance issues | `performance` skill |
| Fix failing tests       | `debug` skill       |

---

## Related Reference Files

- [coverage-analysis.md](coverage-analysis.md) - Coverage patterns
- [e2e-patterns.md](e2e-patterns.md) - Browser testing
- [framework-detection.md](framework-detection.md) - Auto-detection
