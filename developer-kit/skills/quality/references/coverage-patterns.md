# Test Coverage Patterns

## Coverage Analysis Approach

### Step 1: Measure Current Coverage
```bash
# JavaScript/TypeScript
npx jest --coverage

# Python
pytest --cov=src --cov-report=html

# Go
go test -coverprofile=coverage.out ./...
go tool cover -html=coverage.out
```

### Step 2: Identify Critical Gaps

| Priority | Area | Current | Target | Gap |
|----------|------|---------|--------|-----|
| P0 | Auth & Security | 45% | 90% | 45% |
| P0 | Payment Processing | 60% | 95% | 35% |
| P1 | Core Business Logic | 70% | 85% | 15% |
| P2 | API Endpoints | 55% | 75% | 20% |
| P3 | Utilities | 80% | 70% | +10% |

### Step 3: Prioritize by Risk
```
Risk Score = (Impact × Likelihood) / Current Coverage

High Risk (>7): Immediate action
Medium Risk (4-7): Next sprint
Low Risk (<4): Backlog
```

## Coverage Patterns by Code Type

### Business Logic Coverage

```javascript
// Function to test
function calculateOrderTotal(items, discount, taxRate) {
  const subtotal = items.reduce((sum, item) => sum + item.price * item.qty, 0);
  const discountAmount = subtotal * discount;
  const taxableAmount = subtotal - discountAmount;
  const tax = taxableAmount * taxRate;
  return taxableAmount + tax;
}

// Required test cases for full branch coverage
describe('calculateOrderTotal', () => {
  // Happy path
  it('calculates total with items, discount, and tax');

  // Edge cases
  it('handles empty items array');
  it('handles zero discount');
  it('handles zero tax rate');
  it('handles single item');
  it('handles large quantities');
  it('handles decimal prices');

  // Boundary values
  it('handles 100% discount');
  it('handles maximum item count');

  // Error cases
  it('throws on negative prices');
  it('throws on negative quantities');
});
```

### API Endpoint Coverage

```javascript
// For each endpoint, test:
describe('POST /api/users', () => {
  // Success cases
  it('creates user with valid data (201)');
  it('returns created user object');

  // Validation errors
  it('rejects missing email (400)');
  it('rejects invalid email format (400)');
  it('rejects duplicate email (409)');

  // Authentication
  it('rejects unauthenticated request (401)');
  it('rejects unauthorized role (403)');

  // Edge cases
  it('handles unicode in name');
  it('handles maximum length fields');
  it('trims whitespace from inputs');
});
```

### Error Handling Coverage

```javascript
// Ensure all catch blocks are tested
describe('External API integration', () => {
  it('handles connection timeout');
  it('handles connection refused');
  it('handles 400 bad request');
  it('handles 401 unauthorized');
  it('handles 403 forbidden');
  it('handles 404 not found');
  it('handles 429 rate limited');
  it('handles 500 server error');
  it('handles 503 service unavailable');
  it('handles malformed JSON response');
  it('handles empty response');
  it('handles response timeout');
});
```

## Branch Coverage Patterns

### Conditional Logic
```javascript
// All branches need testing
function getDiscount(user, orderTotal) {
  if (!user) return 0;                    // Branch 1: no user
  if (user.isPremium) {                   // Branch 2: premium user
    if (orderTotal > 100) return 0.2;     // Branch 3: premium + high order
    return 0.1;                           // Branch 4: premium + low order
  }
  if (orderTotal > 200) return 0.05;      // Branch 5: regular + high order
  return 0;                               // Branch 6: regular + low order
}

// Test matrix
/*
| user      | isPremium | orderTotal | Expected | Branch |
|-----------|-----------|------------|----------|--------|
| null      | -         | -          | 0        | 1      |
| exists    | true      | 150        | 0.2      | 3      |
| exists    | true      | 50         | 0.1      | 4      |
| exists    | false     | 250        | 0.05     | 5      |
| exists    | false     | 100        | 0        | 6      |
*/
```

### Switch Statements
```javascript
function getStatusMessage(status) {
  switch (status) {
    case 'pending': return 'Waiting for approval';
    case 'approved': return 'Order approved';
    case 'shipped': return 'Order shipped';
    case 'delivered': return 'Order delivered';
    case 'cancelled': return 'Order cancelled';
    default: return 'Unknown status';
  }
}

// Test each case + default
['pending', 'approved', 'shipped', 'delivered', 'cancelled', 'invalid']
  .forEach(status => {
    it(`handles ${status} status`, () => {
      expect(getStatusMessage(status)).toBeDefined();
    });
  });
```

## Coverage Anti-Patterns

### Testing Implementation, Not Behavior
```javascript
// BAD: Tests implementation details
it('calls database query method', () => {
  userService.getUser(1);
  expect(db.query).toHaveBeenCalledWith('SELECT * FROM users WHERE id = ?', [1]);
});

// GOOD: Tests behavior
it('returns user by id', async () => {
  const user = await userService.getUser(1);
  expect(user.id).toBe(1);
  expect(user.email).toBeDefined();
});
```

### Meaningless Assertions
```javascript
// BAD: Always passes
it('creates user', async () => {
  const user = await createUser(data);
  expect(user).toBeTruthy(); // Too vague
});

// GOOD: Specific assertions
it('creates user with correct data', async () => {
  const user = await createUser({ email: 'test@example.com', name: 'Test' });
  expect(user.id).toBeDefined();
  expect(user.email).toBe('test@example.com');
  expect(user.name).toBe('Test');
  expect(user.createdAt).toBeInstanceOf(Date);
});
```

### Coverage Without Value
```javascript
// BAD: Covers lines but doesn't test logic
it('executes the function', () => {
  const result = complexCalculation(1, 2, 3);
  expect(result).toBeDefined();
});

// GOOD: Tests actual expected behavior
it('calculates correctly with specific inputs', () => {
  expect(complexCalculation(1, 2, 3)).toBe(expectedValue);
});
```

## Coverage Reporting

### Coverage Report Template
```markdown
## Test Coverage Report

### Summary
- Overall: 78%
- Critical Paths: 92%
- New Code: 85%

### By Module
| Module | Lines | Branches | Functions |
|--------|-------|----------|-----------|
| auth   | 95%   | 90%      | 100%      |
| api    | 82%   | 75%      | 88%       |
| utils  | 70%   | 65%      | 75%       |

### Uncovered Critical Paths
1. `auth/mfa.js:45-60` - MFA verification failure handling
2. `payment/refund.js:30-45` - Partial refund logic

### Action Items
- [ ] Add tests for MFA failure scenarios
- [ ] Add partial refund edge case tests
- [ ] Increase branch coverage in payment module
```

### Coverage Trend Tracking
```
Week 1: 65% ████████████████░░░░
Week 2: 70% ██████████████████░░
Week 3: 75% ████████████████████
Week 4: 78% █████████████████████
Target: 80% ████████████████████████
```
