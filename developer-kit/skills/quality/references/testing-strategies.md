# Testing Strategies Guide

## Testing Pyramid

```
        /\
       /  \      E2E Tests (few, slow, expensive)
      /    \     - Critical user journeys
     /------\    - Integration with external systems
    /        \
   / Integration \ Integration Tests (some, medium speed)
  /    Tests     \ - API contracts
 /----------------\ - Database operations
/                  \
/    Unit Tests     \ Unit Tests (many, fast, cheap)
/--------------------\ - Individual functions
                       - Business logic
                       - Edge cases
```

## Test Types

### Unit Tests
**Purpose**: Test individual components in isolation

```javascript
// Good unit test characteristics
describe('calculateDiscount', () => {
  it('applies 10% discount for orders over $100', () => {
    expect(calculateDiscount(150)).toBe(15);
  });

  it('returns 0 for orders under $100', () => {
    expect(calculateDiscount(50)).toBe(0);
  });

  it('handles edge case at exactly $100', () => {
    expect(calculateDiscount(100)).toBe(0); // or 10, clarify requirement
  });
});
```

### Integration Tests
**Purpose**: Test component interactions

```javascript
describe('User API', () => {
  beforeAll(async () => {
    await db.connect();
  });

  afterAll(async () => {
    await db.disconnect();
  });

  it('creates user and stores in database', async () => {
    const response = await request(app)
      .post('/api/users')
      .send({ email: 'test@example.com', name: 'Test' });

    expect(response.status).toBe(201);

    const user = await db.users.findByEmail('test@example.com');
    expect(user).toBeDefined();
  });
});
```

### End-to-End Tests
**Purpose**: Test complete user flows

```javascript
describe('Checkout Flow', () => {
  it('completes purchase successfully', async () => {
    await page.goto('/products');
    await page.click('[data-testid="add-to-cart"]');
    await page.click('[data-testid="checkout"]');
    await page.fill('#email', 'test@example.com');
    await page.fill('#card-number', '4242424242424242');
    await page.click('[data-testid="pay"]');

    await expect(page.locator('.success-message')).toBeVisible();
  });
});
```

## Test Design Patterns

### Arrange-Act-Assert (AAA)
```javascript
it('updates user email', async () => {
  // Arrange
  const user = await createTestUser({ email: 'old@example.com' });

  // Act
  await userService.updateEmail(user.id, 'new@example.com');

  // Assert
  const updated = await userService.findById(user.id);
  expect(updated.email).toBe('new@example.com');
});
```

### Given-When-Then (BDD)
```javascript
describe('Shopping Cart', () => {
  describe('given an empty cart', () => {
    describe('when adding a product', () => {
      it('then cart contains one item', () => {
        // Implementation
      });
    });
  });
});
```

### Test Data Builders
```javascript
class UserBuilder {
  constructor() {
    this.user = {
      email: 'default@example.com',
      name: 'Default User',
      role: 'user',
    };
  }

  withEmail(email) {
    this.user.email = email;
    return this;
  }

  asAdmin() {
    this.user.role = 'admin';
    return this;
  }

  build() {
    return { ...this.user };
  }
}

// Usage
const adminUser = new UserBuilder().asAdmin().withEmail('admin@test.com').build();
```

## Edge Case Testing

### Boundary Values
```javascript
describe('Pagination', () => {
  it('handles page 0 (invalid)', () => {});
  it('handles page 1 (minimum valid)', () => {});
  it('handles last page', () => {});
  it('handles page beyond last (invalid)', () => {});
  it('handles negative page number', () => {});
});
```

### Null and Empty Values
```javascript
describe('User name validation', () => {
  it('rejects null', () => {});
  it('rejects undefined', () => {});
  it('rejects empty string', () => {});
  it('rejects whitespace only', () => {});
  it('handles minimum length (1 char)', () => {});
  it('handles maximum length', () => {});
});
```

### Error Scenarios
```javascript
describe('External API calls', () => {
  it('handles network timeout', () => {});
  it('handles 500 server error', () => {});
  it('handles malformed response', () => {});
  it('handles rate limiting (429)', () => {});
  it('retries on transient failures', () => {});
});
```

## Test Coverage Strategy

### Coverage Types
- **Line Coverage**: % of lines executed
- **Branch Coverage**: % of branches taken
- **Function Coverage**: % of functions called
- **Path Coverage**: % of execution paths

### Coverage Targets by Area
| Area | Line | Branch | Rationale |
|------|------|--------|-----------|
| Core business logic | 90%+ | 85%+ | Critical, must work |
| API endpoints | 80%+ | 75%+ | User-facing |
| Utilities | 70%+ | 60%+ | Supporting code |
| UI components | 60%+ | 50%+ | Visual, harder to test |

### Focus Areas for Testing
1. **Money/transactions**: 100% critical path coverage
2. **Authentication**: All paths including edge cases
3. **Data validation**: Boundary values and invalid inputs
4. **Error handling**: Recovery and graceful degradation

## Mocking Strategies

### When to Mock
- External services (APIs, databases)
- Time-dependent code
- Random number generators
- File system operations

### Mock Examples
```javascript
// Mock external API
jest.mock('./externalApi', () => ({
  fetchUser: jest.fn().mockResolvedValue({ id: 1, name: 'Test' }),
}));

// Mock time
jest.useFakeTimers();
jest.setSystemTime(new Date('2024-01-15'));

// Mock database
const mockDb = {
  users: {
    findById: jest.fn().mockResolvedValue({ id: 1 }),
  },
};
```

## CI/CD Integration

### Test Pipeline Stages
```yaml
test:
  stage: test
  script:
    - npm run lint
    - npm run type-check
    - npm run test:unit
    - npm run test:integration
  coverage: '/Coverage: \d+%/'

e2e:
  stage: e2e
  script:
    - npm run test:e2e
  only:
    - main
    - merge_requests
```

### Parallel Test Execution
```bash
# Jest
jest --maxWorkers=4

# Playwright
npx playwright test --workers=4
```
