# SOLID Principles and Code Metrics

## SOLID Principles

### S - Single Responsibility Principle

**Definition**: A class/module should have only one reason to change.

**Violation Signs**:
- Class has multiple unrelated methods
- Changes to one feature affect unrelated code
- Class name includes "And" or "Manager"

**Example**:
```javascript
// BAD - Multiple responsibilities
class UserManager {
  createUser(data) { /* database logic */ }
  validateEmail(email) { /* validation logic */ }
  sendWelcomeEmail(user) { /* email logic */ }
  generateReport(users) { /* reporting logic */ }
}

// GOOD - Single responsibility each
class UserRepository { createUser(data) { } }
class EmailValidator { validate(email) { } }
class EmailService { sendWelcome(user) { } }
class UserReportGenerator { generate(users) { } }
```

### O - Open/Closed Principle

**Definition**: Open for extension, closed for modification.

**Violation Signs**:
- Adding features requires modifying existing code
- Switch statements that need updating for new cases
- "If type === X" scattered throughout

**Example**:
```javascript
// BAD - Requires modification for new payment types
function processPayment(type, amount) {
  if (type === 'credit') { /* ... */ }
  else if (type === 'debit') { /* ... */ }
  else if (type === 'crypto') { /* ... */ }  // Had to modify!
}

// GOOD - Extended without modification
interface PaymentProcessor {
  process(amount: number): void;
}

class CreditCardProcessor implements PaymentProcessor { }
class DebitProcessor implements PaymentProcessor { }
class CryptoProcessor implements PaymentProcessor { }  // Just add new class
```

### L - Liskov Substitution Principle

**Definition**: Subtypes must be substitutable for their base types.

**Violation Signs**:
- Subclass throws exceptions parent doesn't
- Subclass weakens postconditions
- Need to check type before calling method

**Example**:
```javascript
// BAD - Square violates Rectangle contract
class Rectangle {
  setWidth(w) { this.width = w; }
  setHeight(h) { this.height = h; }
}

class Square extends Rectangle {
  setWidth(w) { this.width = w; this.height = w; }  // Unexpected!
  setHeight(h) { this.height = h; this.width = h; }  // Unexpected!
}

// GOOD - Separate abstractions
interface Shape {
  getArea(): number;
}

class Rectangle implements Shape { }
class Square implements Shape { }
```

### I - Interface Segregation Principle

**Definition**: Clients shouldn't depend on interfaces they don't use.

**Violation Signs**:
- Classes implement methods they don't need
- "Not implemented" exceptions
- Fat interfaces with many methods

**Example**:
```javascript
// BAD - Fat interface
interface Worker {
  work(): void;
  eat(): void;
  sleep(): void;
}

class Robot implements Worker {
  work() { /* OK */ }
  eat() { throw new Error("Robots don't eat"); }  // Forced to implement
  sleep() { throw new Error("Robots don't sleep"); }
}

// GOOD - Segregated interfaces
interface Workable { work(): void; }
interface Eatable { eat(): void; }
interface Sleepable { sleep(): void; }

class Robot implements Workable { work() { } }
class Human implements Workable, Eatable, Sleepable { }
```

### D - Dependency Inversion Principle

**Definition**: Depend on abstractions, not concretions.

**Violation Signs**:
- High-level modules import low-level modules directly
- Concrete class names in business logic
- Hard to test due to concrete dependencies

**Example**:
```javascript
// BAD - Depends on concrete implementation
class OrderService {
  private database = new MySQLDatabase();  // Concrete!

  saveOrder(order) {
    this.database.save(order);
  }
}

// GOOD - Depends on abstraction
interface Database {
  save(data: any): void;
}

class OrderService {
  constructor(private database: Database) { }  // Injected abstraction

  saveOrder(order) {
    this.database.save(order);
  }
}
```

## Code Quality Metrics

### Cyclomatic Complexity

**Definition**: Number of independent paths through code.

**Calculation**: Count decision points + 1
- Each `if`, `else`, `case`, `while`, `for`, `&&`, `||`, `?:` adds 1

**Thresholds**:
| Score | Risk | Action |
|-------|------|--------|
| 1-10 | Low | Acceptable |
| 11-20 | Moderate | Consider refactoring |
| 21-50 | High | Must refactor |
| 50+ | Very High | Untestable, rewrite |

### Maintainability Index

**Definition**: Composite metric (0-100) measuring maintainability.

**Components**:
- Halstead Volume (code complexity)
- Cyclomatic Complexity
- Lines of Code
- Comment Ratio

**Thresholds**:
| Score | Rating | Meaning |
|-------|--------|---------|
| 85-100 | High | Easy to maintain |
| 65-84 | Medium | Moderately maintainable |
| 0-64 | Low | Difficult to maintain |

### Code Duplication

**Definition**: Percentage of duplicated code blocks.

**Thresholds**:
| Duplication | Action |
|-------------|--------|
| 0-5% | Acceptable |
| 5-10% | Consider consolidating |
| 10-20% | Needs attention |
| 20%+ | Urgent refactoring |

### Test Coverage

**Thresholds**:
| Coverage | Rating |
|----------|--------|
| 80%+ | Good |
| 60-80% | Acceptable |
| 40-60% | Needs improvement |
| <40% | Critical gap |

## Technical Debt Assessment

### Debt Categories

| Category | Examples | Impact |
|----------|----------|--------|
| Code Debt | Duplications, complexity | Maintenance cost |
| Design Debt | SOLID violations | Extensibility issues |
| Test Debt | Low coverage | Risk of regressions |
| Doc Debt | Missing docs | Onboarding time |

### Debt Quantification

```markdown
## Technical Debt Report

### Current State
- Cyclomatic Complexity: Average 15 (target: <10)
- Duplication: 12% (target: <5%)
- Test Coverage: 55% (target: >80%)
- Maintainability Index: 62 (target: >75)

### Estimated Effort to Fix
- Critical issues: 20 hours
- Important issues: 40 hours
- Minor issues: 15 hours

### Recommended Priority
1. Security-related debt (immediate)
2. High-complexity functions (this sprint)
3. Test coverage gaps (next sprint)
4. Code duplication (ongoing)
```

## Before/After Metrics Template

```markdown
## Refactoring Impact: [Component Name]

### Metrics Comparison
| Metric | Before | After | Change |
|--------|--------|-------|--------|
| Cyclomatic Complexity | 25 | 8 | -68% |
| Lines of Code | 450 | 280 | -38% |
| Test Coverage | 45% | 92% | +104% |
| Maintainability Index | 55 | 82 | +49% |
| Duplication | 15% | 2% | -87% |

### SOLID Compliance
| Principle | Before | After |
|-----------|--------|-------|
| SRP | Violated | Compliant |
| OCP | Violated | Compliant |
| LSP | N/A | N/A |
| ISP | Partial | Compliant |
| DIP | Violated | Compliant |

### Business Impact
- Bug rate: Expected 40% reduction
- Development velocity: Expected 25% increase
- Onboarding time: Expected 30% reduction
```
