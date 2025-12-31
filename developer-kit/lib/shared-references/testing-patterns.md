# Testing Patterns

Centralized patterns for testing operations. Used by `test` skill and `quality` skill.

## Test Strategy Levels

| Level       | Purpose                | Tools                   | Speed  |
| ----------- | ---------------------- | ----------------------- | ------ |
| Unit        | Individual functions   | Jest, Vitest, pytest    | Fast   |
| Integration | Component interactions | Testing Library, pytest | Medium |
| E2E         | Full user flows        | Playwright, Cypress     | Slow   |
| Visual      | UI appearance          | Playwright, Chromatic   | Medium |

## Coverage Guidelines

| Metric             | Target | Priority |
| ------------------ | ------ | -------- |
| Line coverage      | ≥80%   | High     |
| Branch coverage    | ≥75%   | High     |
| Function coverage  | ≥90%   | Medium   |
| Statement coverage | ≥80%   | Medium   |

### Coverage Interpretation

```yaml
High coverage (>90%):
  - Good: Well-tested codebase
  - Risk: May include trivial tests for coverage

Medium coverage (70-90%):
  - Good: Focus on critical paths
  - Action: Identify untested edge cases

Low coverage (<70%):
  - Risk: Significant gaps
  - Action: Prioritize critical functionality
```

## Test Quality Checklist

```yaml
Independence:
  - Tests don't depend on execution order
  - No shared mutable state between tests
  - Each test sets up its own data

Determinism:
  - Same result every run
  - No flaky tests (random failures)
  - Time-independent assertions

Speed:
  - Unit tests < 100ms each
  - Integration tests < 1s each
  - Total suite < 5 minutes

Readability:
  - Clear test names describing behavior
  - Arrange-Act-Assert structure
  - Minimal setup code (use fixtures)
```

## Framework-Specific Patterns

### Jest/Vitest (JavaScript/TypeScript)

```typescript
// Recommended test structure
describe("ComponentName", () => {
  // Setup shared across tests
  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe("methodName", () => {
    it("should do X when Y", () => {
      // Arrange
      const input = createInput();

      // Act
      const result = methodName(input);

      // Assert
      expect(result).toBe(expected);
    });

    it("should throw when invalid input", () => {
      expect(() => methodName(null)).toThrow("Error message");
    });
  });
});
```

### React Testing Library

```typescript
import { render, screen, fireEvent, waitFor } from '@testing-library/react';

describe('Button', () => {
  it('calls onClick when clicked', () => {
    const handleClick = jest.fn();
    render(<Button onClick={handleClick}>Click me</Button>);

    fireEvent.click(screen.getByRole('button'));

    expect(handleClick).toHaveBeenCalledTimes(1);
  });

  it('shows loading state', async () => {
    render(<Button loading>Submit</Button>);

    expect(screen.getByRole('button')).toBeDisabled();
    expect(screen.getByRole('progressbar')).toBeInTheDocument();
  });
});
```

### Pytest (Python)

```python
import pytest
from myapp import calculator

class TestCalculator:
    @pytest.fixture
    def calc(self):
        """Fixture to create calculator instance."""
        return calculator.Calculator()

    def test_add_positive_numbers(self, calc):
        """Should add two positive numbers correctly."""
        result = calc.add(2, 3)
        assert result == 5

    def test_divide_by_zero_raises_error(self, calc):
        """Should raise ValueError when dividing by zero."""
        with pytest.raises(ValueError, match="Cannot divide by zero"):
            calc.divide(10, 0)

    @pytest.mark.parametrize("a,b,expected", [
        (2, 3, 5),
        (-1, 1, 0),
        (0, 0, 0),
    ])
    def test_add_various_inputs(self, calc, a, b, expected):
        """Should handle various input combinations."""
        assert calc.add(a, b) == expected
```

### Playwright E2E

```typescript
import { test, expect } from "@playwright/test";

test.describe("User Flow", () => {
  test("should complete checkout process", async ({ page }) => {
    // Navigate
    await page.goto("/products");

    // Add to cart
    await page.click('[data-testid="add-to-cart"]');
    await expect(page.locator(".cart-count")).toHaveText("1");

    // Checkout
    await page.click('[data-testid="checkout"]');
    await page.fill("#email", "test@example.com");
    await page.click('button[type="submit"]');

    // Verify
    await expect(page).toHaveURL("/confirmation");
    await expect(page.locator(".success-message")).toBeVisible();
  });
});
```

### Go Testing

```go
func TestAdd(t *testing.T) {
    tests := []struct {
        name     string
        a, b     int
        expected int
    }{
        {"positive numbers", 2, 3, 5},
        {"negative numbers", -1, -1, -2},
        {"zero", 0, 0, 0},
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            result := Add(tt.a, tt.b)
            if result != tt.expected {
                t.Errorf("Add(%d, %d) = %d; want %d", tt.a, tt.b, result, tt.expected)
            }
        })
    }
}
```

## Test Detection Commands

```bash
# JavaScript/TypeScript
npm test                  # Jest/Vitest
npx vitest --coverage     # Vitest with coverage
npx jest --coverage       # Jest with coverage

# Python
pytest                    # Run all tests
pytest --cov=src          # With coverage
pytest -k "test_name"     # Run specific test

# Go
go test ./...             # Run all tests
go test -cover ./...      # With coverage
go test -v ./...          # Verbose output
```

## Gap Identification

### Finding Untested Code

```yaml
Coverage Tools:
  JavaScript: istanbul, c8, vitest --coverage
  Python: pytest-cov, coverage.py
  Go: go test -cover

Analysis Steps: 1. Generate coverage report
  2. Identify files with < 70% coverage
  3. Find uncovered branches in critical code
  4. Check edge cases and error paths
```

### Common Test Gaps

```yaml
Error Paths:
  - What happens when API fails?
  - How are validation errors handled?
  - What about timeout scenarios?

Edge Cases:
  - Empty inputs
  - Maximum length inputs
  - Special characters
  - Concurrent operations

State Transitions:
  - Initial → Loading → Success
  - Initial → Loading → Error
  - Retry scenarios
```

## Context7 Testing Resources

| Resource        | Library ID                               | Use Case          |
| --------------- | ---------------------------------------- | ----------------- |
| Jest            | `/jestjs/jest`                           | JS unit testing   |
| Vitest          | `/vitest-dev/vitest`                     | Modern JS testing |
| Pytest          | `/pytest-dev/pytest`                     | Python testing    |
| Playwright      | `/microsoft/playwright`                  | E2E testing       |
| Testing Library | `/testing-library/react-testing-library` | React testing     |

## Related

- [MCP Resources](./mcp-resources.md) - Context7 library IDs
- [Tool Integration](./tool-integration-patterns.md) - MCP patterns
- [Debugging Patterns](./debugging-patterns.md) - Test debugging
