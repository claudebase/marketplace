# Test Patterns

## Test Types

### Unit Tests
- Test individual functions/components in isolation
- Mock dependencies
- Fast execution
- High coverage target (80%+)

```javascript
describe('calculateTotal', () => {
  it('should sum items correctly', () => {
    expect(calculateTotal([10, 20, 30])).toBe(60);
  });
});
```

### Integration Tests
- Test component interactions
- Fewer mocks, more real dependencies
- Medium execution time
- Focus on critical paths

```javascript
describe('UserService', () => {
  it('should create user in database', async () => {
    const user = await userService.create({ email: 'test@example.com' });
    expect(user.id).toBeDefined();
  });
});
```

### E2E Tests
- Test complete user flows
- Real browser/environment
- Slower execution
- Cover critical user journeys

```javascript
test('user can complete checkout', async ({ page }) => {
  await page.goto('/products');
  await page.click('[data-testid="add-to-cart"]');
  await page.click('[data-testid="checkout"]');
  await expect(page).toHaveURL('/confirmation');
});
```

## Test Commands

### Run All Tests
```bash
npm test
# or
yarn test
```

### Run with Coverage
```bash
npm test -- --coverage
```

### Run Specific Tests
```bash
npm test -- --grep "user"
npm test -- path/to/test.spec.ts
```

### Watch Mode
```bash
npm test -- --watch
```

## Coverage Targets

| Metric | Target | Critical |
|--------|--------|----------|
| Statements | 80% | 60% |
| Branches | 75% | 50% |
| Functions | 80% | 60% |
| Lines | 80% | 60% |

## Test Best Practices

### Naming Conventions
```javascript
// Descriptive test names
it('should return empty array when no items match filter', () => {});

// Given-When-Then pattern
it('given logged in user, when clicking logout, then redirects to login page', () => {});
```

### Test Organization
```
tests/
├── unit/
│   └── services/
├── integration/
│   └── api/
└── e2e/
    └── flows/
```

### Avoiding Flaky Tests
- Don't rely on timing
- Use proper waits/assertions
- Isolate test data
- Clean up after tests
