# Coverage Analysis Guide

Comprehensive guide to measuring and analyzing test coverage.

## Coverage Metrics

### Types of Coverage

| Metric | Description | Importance |
|--------|-------------|------------|
| **Line Coverage** | Lines executed during tests | Basic metric |
| **Statement Coverage** | Statements executed | Similar to line |
| **Branch Coverage** | Decision paths taken | Critical for logic |
| **Function Coverage** | Functions called | API completeness |
| **Condition Coverage** | Boolean sub-expressions | Deep logic testing |

### Industry Standards

| Project Type | Minimum | Good | Excellent |
|-------------|---------|------|-----------|
| Critical Systems | 90% | 95% | 100% |
| Business Apps | 70% | 80% | 90% |
| Utilities/Tools | 60% | 75% | 85% |
| Prototypes | 30% | 50% | 70% |

## Coverage Tools by Language

### JavaScript/TypeScript

#### Jest (Built-in)
```bash
# Run with coverage
jest --coverage

# Coverage thresholds in jest.config.js
module.exports = {
  coverageThreshold: {
    global: {
      branches: 80,
      functions: 80,
      lines: 80,
      statements: 80
    }
  }
}
```

#### c8 (Node.js native coverage)
```bash
# Install
npm install -D c8

# Run
c8 npm test
c8 --reporter=html npm test
```

#### nyc (Istanbul CLI)
```bash
# Install
npm install -D nyc

# Run
nyc npm test
nyc --reporter=lcov npm test
```

### Python

#### pytest-cov
```bash
# Install
pip install pytest-cov

# Run
pytest --cov=src
pytest --cov=src --cov-report=html
pytest --cov=src --cov-fail-under=80
```

#### coverage.py
```bash
# Install
pip install coverage

# Run
coverage run -m pytest
coverage report
coverage html
```

### Go

#### go test -cover
```bash
# Basic coverage
go test -cover ./...

# Coverage profile
go test -coverprofile=coverage.out ./...

# View in browser
go tool cover -html=coverage.out

# Coverage by function
go tool cover -func=coverage.out
```

### Rust

#### cargo-tarpaulin
```bash
# Install
cargo install cargo-tarpaulin

# Run
cargo tarpaulin
cargo tarpaulin --out Html
```

## Analyzing Coverage Reports

### Understanding Uncovered Code

```
Uncovered code typically falls into:

1. ERROR HANDLING
   - Try/catch blocks
   - Error callbacks
   - Edge case validation

2. CONDITIONAL BRANCHES
   - Else branches
   - Switch default cases
   - Short-circuit evaluations

3. ASYNC CODE
   - Promise rejection handlers
   - Timeout scenarios
   - Race conditions

4. DEFENSIVE CODE
   - Null checks
   - Type guards
   - Bounds checking
```

### Prioritizing Coverage Improvements

```
HIGH PRIORITY (must test):
- Authentication/authorization logic
- Payment/financial calculations
- Data validation
- Security-sensitive code

MEDIUM PRIORITY (should test):
- Business logic
- API endpoints
- Database operations
- State management

LOWER PRIORITY (nice to test):
- UI rendering
- Logging
- Configuration loading
- Utility functions
```

## Coverage Report Formats

### LCOV (Universal)
```
SF:src/auth.ts
DA:1,10
DA:2,10
DA:5,0
DA:6,0
LF:4
LH:2
end_of_record
```

### Cobertura XML
```xml
<coverage line-rate="0.85" branch-rate="0.72">
  <packages>
    <package name="src">
      <classes>
        <class filename="auth.ts" line-rate="0.80">
          <lines>
            <line number="1" hits="10"/>
            <line number="5" hits="0"/>
          </lines>
        </class>
      </classes>
    </package>
  </packages>
</coverage>
```

### JSON Summary
```json
{
  "total": {
    "lines": { "total": 100, "covered": 85, "pct": 85 },
    "branches": { "total": 50, "covered": 36, "pct": 72 },
    "functions": { "total": 20, "covered": 18, "pct": 90 }
  }
}
```

## Coverage Integration

### CI/CD Integration

```yaml
# GitHub Actions example
- name: Run tests with coverage
  run: npm test -- --coverage

- name: Upload coverage to Codecov
  uses: codecov/codecov-action@v3
  with:
    files: ./coverage/lcov.info
    fail_ci_if_error: true
```

### Coverage Badges

```markdown
[![codecov](https://codecov.io/gh/user/repo/branch/main/graph/badge.svg)](https://codecov.io/gh/user/repo)
```

## Anti-Patterns to Avoid

1. **Coverage Gaming** - Writing tests that execute code but don't assert
2. **100% Obsession** - Diminishing returns past 80-90%
3. **Ignoring Branch Coverage** - Line coverage alone is misleading
4. **Testing Implementation** - Tests that break on refactor
5. **Snapshot Abuse** - Snapshots without understanding
