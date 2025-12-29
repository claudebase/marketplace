# Refactoring Patterns

## Safe Refactoring Principles

### The Refactoring Safety Net

```
          Tests
           /\
          /  \
         /    \
        /      \
       /________\
  Small Steps   Version Control
```

**Always have all three before refactoring.**

## Code Smell to Refactoring Map

| Code Smell | Refactoring Pattern |
|------------|---------------------|
| Long function | Extract Function |
| Duplicated code | Extract Function/Class |
| Long parameter list | Introduce Parameter Object |
| Feature envy | Move Function |
| Data clumps | Extract Class |
| Primitive obsession | Replace Primitive with Object |
| Switch statements | Replace with Polymorphism |
| Parallel inheritance | Collapse Hierarchy |
| Lazy class | Inline Class |
| Speculative generality | Remove Dead Code |
| Temporary field | Extract Class |
| Message chains | Hide Delegate |
| Middle man | Remove Middle Man |
| Inappropriate intimacy | Move Function/Field |
| Divergent change | Extract Class |
| Shotgun surgery | Move Function/Field |

## Essential Refactoring Patterns

### Extract Function

**When**: Code block does one specific thing

```javascript
// Before
function processOrder(order) {
  // validate order
  if (!order.items || order.items.length === 0) {
    throw new Error('Order must have items');
  }
  if (!order.customer) {
    throw new Error('Order must have customer');
  }
  // calculate total
  let total = 0;
  for (const item of order.items) {
    total += item.price * item.quantity;
  }
  // apply discount
  if (order.discountCode) {
    total *= 0.9;
  }
  return total;
}

// After
function validateOrder(order) {
  if (!order.items || order.items.length === 0) {
    throw new Error('Order must have items');
  }
  if (!order.customer) {
    throw new Error('Order must have customer');
  }
}

function calculateTotal(items) {
  return items.reduce((sum, item) => sum + item.price * item.quantity, 0);
}

function applyDiscount(total, discountCode) {
  return discountCode ? total * 0.9 : total;
}

function processOrder(order) {
  validateOrder(order);
  const total = calculateTotal(order.items);
  return applyDiscount(total, order.discountCode);
}
```

### Extract Class

**When**: Class has too many responsibilities

```javascript
// Before
class User {
  constructor(name, email, street, city, zip) {
    this.name = name;
    this.email = email;
    this.street = street;
    this.city = city;
    this.zip = zip;
  }

  getFullAddress() {
    return `${this.street}, ${this.city} ${this.zip}`;
  }

  validateAddress() {
    return this.street && this.city && this.zip;
  }
}

// After
class Address {
  constructor(street, city, zip) {
    this.street = street;
    this.city = city;
    this.zip = zip;
  }

  getFullAddress() {
    return `${this.street}, ${this.city} ${this.zip}`;
  }

  isValid() {
    return this.street && this.city && this.zip;
  }
}

class User {
  constructor(name, email, address) {
    this.name = name;
    this.email = email;
    this.address = address;
  }
}
```

### Replace Conditional with Polymorphism

**When**: Same switch/if-else appears in multiple places

```javascript
// Before
function calculatePay(employee) {
  switch (employee.type) {
    case 'hourly':
      return employee.hoursWorked * employee.hourlyRate;
    case 'salaried':
      return employee.monthlySalary;
    case 'commissioned':
      return employee.basePay + employee.sales * employee.commissionRate;
  }
}

// After
class HourlyEmployee {
  calculatePay() {
    return this.hoursWorked * this.hourlyRate;
  }
}

class SalariedEmployee {
  calculatePay() {
    return this.monthlySalary;
  }
}

class CommissionedEmployee {
  calculatePay() {
    return this.basePay + this.sales * this.commissionRate;
  }
}
```

### Introduce Parameter Object

**When**: Multiple parameters travel together

```javascript
// Before
function searchProducts(minPrice, maxPrice, category, inStock, sortBy, sortOrder) {
  // ...
}

// After
interface SearchCriteria {
  priceRange: { min: number; max: number };
  category?: string;
  inStock?: boolean;
  sort?: { by: string; order: 'asc' | 'desc' };
}

function searchProducts(criteria: SearchCriteria) {
  // ...
}
```

### Replace Magic Numbers with Constants

**When**: Numbers appear without explanation

```javascript
// Before
if (user.age >= 18) { /* ... */ }
setTimeout(callback, 86400000);
if (response.status === 200) { /* ... */ }

// After
const LEGAL_AGE = 18;
const ONE_DAY_MS = 24 * 60 * 60 * 1000;
const HTTP_OK = 200;

if (user.age >= LEGAL_AGE) { /* ... */ }
setTimeout(callback, ONE_DAY_MS);
if (response.status === HTTP_OK) { /* ... */ }
```

## Refactoring Workflow

### Step-by-Step Process

```markdown
## Refactoring Steps

1. **Identify**: Find the code smell
2. **Test**: Ensure tests exist (write if needed)
3. **Plan**: Choose appropriate refactoring
4. **Execute**: Apply in small steps
5. **Verify**: Run tests after each step
6. **Commit**: Save working state frequently
```

### Micro-Commit Strategy

```bash
# After each small refactoring step
git add -A
git commit -m "refactor: extract validateOrder function"

# If something breaks, easy to revert
git revert HEAD

# At the end, squash if desired
git rebase -i HEAD~5
```

## Language-Specific Patterns

### JavaScript/TypeScript

```typescript
// Use optional chaining
// Before
const city = user && user.address && user.address.city;
// After
const city = user?.address?.city;

// Use nullish coalescing
// Before
const name = user.name !== null && user.name !== undefined ? user.name : 'Anonymous';
// After
const name = user.name ?? 'Anonymous';

// Use destructuring
// Before
const name = user.name;
const email = user.email;
// After
const { name, email } = user;
```

### React-Specific

```jsx
// Extract custom hooks
// Before
function UserProfile() {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchUser().then(setUser).finally(() => setLoading(false));
  }, []);

  // ... render
}

// After
function useUser() {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchUser().then(setUser).finally(() => setLoading(false));
  }, []);

  return { user, loading };
}

function UserProfile() {
  const { user, loading } = useUser();
  // ... render
}
```

## Anti-Patterns to Avoid

### During Refactoring

1. **Big Bang Refactoring**: Don't refactor everything at once
2. **Refactor and Add Features**: Do one or the other, not both
3. **Skipping Tests**: Always verify after each change
4. **Ignoring Version Control**: Commit frequently
5. **Over-Engineering**: Don't add complexity while simplifying
