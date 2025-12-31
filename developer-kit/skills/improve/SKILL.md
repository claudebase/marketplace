---
name: improve
description: "Apply systematic improvements to code quality, performance, and maintainability. Use for enhancing working code through refactoring or optimization. Activates for: improve this code, optimize this, refactor, make this better, enhance performance, clean up code, reduce complexity, apply best practices. For broken code use debug."
allowed-tools:
  # Core Analysis
  - Read
  - Grep
  - Glob
  - Bash
  # Code Modification
  - Edit
  - Write
  # Refactoring Documentation
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  # Pattern Research
  - mcp__github__search_code
  - mcp__github__get_file_contents
  # Best Practices Research
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  # Structured Planning
  - mcp__sequential-thinking__sequentialthinking
---

# Improve Skill

Apply systematic improvements to code quality, performance, and maintainability through evidence-based refactoring using official clean code principles, design patterns, and industry best practices.

**Core Principle**: "Enhance incrementally, verify continuously. Never break working code."

**Key Enhancement**: Research refactoring patterns and best practices before making changes.

**Key Distinction**: This skill enhances WORKING code. For fixing broken code, use `debug`. For analysis without changes, use `analyze`.

## Activation Triggers

- Code improvement ("improve this code", "make this better")
- Refactoring ("refactor this", "clean up code")
- Optimization ("optimize this", "enhance performance")
- Quality enhancement ("reduce complexity", "apply best practices")
- Maintainability ("make more readable", "simplify")

## Do NOT Activate When

- Code is broken/buggy → use `debug` skill
- User wants analysis only → use `analyze` skill
- User wants explanation → use `explain` skill
- User wants performance profiling → use `performance` skill
- User wants security fixes → use `security-expert` agent

**Boundary Clarification:**
This skill applies improvements to working code. For broken code, use the `debug` skill. For analysis without making changes, use the `analyze` skill. The `performance` skill identifies bottlenecks; this skill implements the optimizations.

## Behavioral Flow

```
┌──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
│   ANALYZE    │   RESEARCH   │     PLAN     │    APPLY     │    VERIFY    │
├──────────────┼──────────────┼──────────────┼──────────────┼──────────────┤
│ Read code    │ Lookup       │ Prioritize   │ Make         │ Run tests    │
│ to           │ refactoring  │ improvements │ incremental  │ after each   │
│ understand   │ patterns     │ by impact    │ changes      │ change       │
│              │              │              │              │              │
│ Identify     │ Find         │ Plan safe    │ Apply        │ Confirm no   │
│ improvement  │ clean code   │ refactoring  │ patterns     │ regressions  │
│ opportunities│ principles   │ steps        │ correctly    │              │
│              │              │              │              │              │
│ Assess       │ Research     │ Define       │ Document     │ Measure      │
│ current      │ best         │ verification │ changes      │ improvement  │
│ quality      │ practices    │ criteria     │              │              │
└──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘
     Read           Context7      Sequential      Edit           Bash
     Grep           GitHub        Thinking        Write          (test)
                    Tavily
```

### Phase 1: ANALYZE

Understand the current code and identify improvement opportunities:

1. **Read the code** - Understand structure, purpose, and patterns
2. **Identify code smells** - Long methods, duplication, complexity
3. **Assess quality metrics** - Complexity, coupling, cohesion
4. **Find improvement candidates** - What would benefit most from refactoring?

```bash
# Check code complexity
npx eslint . --format json 2>/dev/null | head -50

# Find long functions
grep -n "function\|=>" --include="*.ts" -A 50 src/ | grep -E "^[0-9]+-" | wc -l

# Find duplicated code patterns
grep -r "TODO\|FIXME\|HACK" --include="*.ts" src/

# Check type coverage
npx tsc --noEmit 2>&1 | head -20
```

**Tools**: Read, Grep, Glob, Bash

### Phase 2: RESEARCH

Gather refactoring patterns and best practices:

```
# Lookup Clean Code principles
mcp__context7__resolve-library-id → "/labs42io/clean-code-typescript"
mcp__context7__query-docs("function arguments single responsibility")

# Lookup refactoring patterns
mcp__context7__resolve-library-id → "/websites/refactoring_guru"
mcp__context7__query-docs("extract method replace conditional with polymorphism")

# Lookup code smells and fixes
mcp__context7__resolve-library-id → "/websites/refactoring_guru_smells"
mcp__context7__query-docs("long method feature envy")

# Lookup design patterns for restructuring
mcp__context7__resolve-library-id → "/websites/refactoring_guru-design-patterns"
mcp__context7__query-docs("strategy pattern factory pattern")

# Find refactoring examples in production codebases
mcp__github__search_code("refactor extract method filename:.ts stars:>500")

# Research current best practices
mcp__tavily__tavily-search("TypeScript refactoring best practices 2024")
```

**Tools**: Context7, GitHub MCP, Tavily

### Phase 3: PLAN

Plan improvements with structured reasoning:

```
mcp__sequential-thinking__sequentialthinking
- What are the highest-impact improvements?
- What's the safest order to apply changes?
- What tests need to pass after each change?
- What are the potential risks?
- How will we verify success?
```

**Prioritization Framework:**

| Priority      | Criteria                 | Examples                                    |
| ------------- | ------------------------ | ------------------------------------------- |
| P0 - Critical | Breaks easily, high risk | Security fixes, crash prevention            |
| P1 - High     | High impact, low risk    | Extract large functions, remove duplication |
| P2 - Medium   | Moderate impact          | Rename for clarity, simplify conditionals   |
| P3 - Low      | Nice to have             | Style consistency, minor optimizations      |

**Tools**: Sequential Thinking

### Phase 4: APPLY

Make incremental changes following safe refactoring:

- One refactoring at a time
- Preserve external behavior
- Keep changes reversible
- Follow established patterns

**Tools**: Edit, Write

### Phase 5: VERIFY

Confirm improvements and no regressions:

- Run tests after each change
- Verify functionality unchanged
- Measure improvement metrics
- Document what was done

**Tools**: Bash (tests)

## MCP Integration

### Context7 (Refactoring Documentation)

**Primary source for clean code and refactoring patterns:**

```
mcp__context7__resolve-library-id - Resolve library/pattern IDs
mcp__context7__query-docs - Get official documentation
```

**Available Resources:**

| Resource               | Library ID                                   | Snippets |
| ---------------------- | -------------------------------------------- | -------- |
| Refactoring.Guru       | `/websites/refactoring_guru`                 | 12,314   |
| Design Patterns        | `/websites/refactoring_guru-design-patterns` | 1,696    |
| Code Smells            | `/websites/refactoring_guru_smells`          | 86       |
| Clean Code TypeScript  | `/labs42io/clean-code-typescript`            | 62       |
| Clean Code JavaScript  | `/ryanmcdermott/clean-code-javascript`       | 78       |
| ESLint                 | `/eslint/eslint`                             | 4,069    |
| Biome                  | `/biomejs/biome`                             | 895      |
| SonarQube              | `/websites/sonarsource`                      | 14,888   |
| Node.js Best Practices | `/goldbergyoni/nodebestpractices`            | 734      |
| OpenRewrite            | `/websites/openrewrite`                      | 22,268   |

**Use cases:**

- "Extract Method refactoring steps"
- "Replace Conditional with Polymorphism"
- "Long Method code smell solutions"
- "Single Responsibility Principle TypeScript"
- "ESLint complexity rules configuration"
- "SonarQube code smell detection"

### GitHub MCP (Pattern Research)

**Find refactoring patterns in production codebases:**

```
mcp__github__search_code - Find refactoring patterns
mcp__github__get_file_contents - Get specific implementations
```

**Search patterns:**

```
# Find extract method examples
"private" "extract" "helper" filename:.ts stars:>500

# Find composition over inheritance
"implements" "interface" "strategy" filename:.ts stars:>500

# Find factory pattern implementations
"create" "factory" "return new" filename:.ts stars:>500

# Find clean function examples
"function" "single" "responsibility" filename:.ts

# Find error handling improvements
"try" "catch" "finally" "Error" filename:.ts stars:>1000
```

**Use cases:**

- Find how popular projects structure code
- Get refactoring examples from well-maintained repos
- Study design pattern implementations
- Compare approaches to similar problems

### Tavily (Best Practices Research)

**Research current refactoring techniques:**

```
mcp__tavily__tavily-search - Research refactoring strategies
mcp__tavily__tavily-extract - Extract from refactoring guides
```

**Use cases:**

- "TypeScript refactoring best practices 2024"
- "React component composition patterns"
- "Node.js async refactoring techniques"
- "Reducing cyclomatic complexity strategies"
- "SOLID principles practical examples"
- "Technical debt reduction strategies"

### Sequential Thinking (Structured Planning)

**Systematic improvement planning:**

```
mcp__sequential-thinking__sequentialthinking - Plan refactoring steps
```

**Use for:**

- Prioritizing improvements by impact/risk
- Planning safe refactoring sequences
- Evaluating trade-offs
- Defining verification criteria

## Improvement Domains

### 1. Code Quality

**Code Smells and Fixes:**

| Smell               | Symptom                          | Refactoring                |
| ------------------- | -------------------------------- | -------------------------- |
| Long Method         | Function > 20 lines              | Extract Method             |
| Large Class         | Class > 200 lines                | Extract Class              |
| Duplicate Code      | Same logic repeated              | Extract Function/Module    |
| Long Parameter List | > 3 parameters                   | Introduce Parameter Object |
| Feature Envy        | Method uses other class's data   | Move Method                |
| Data Clumps         | Same data groups appear together | Extract Class              |
| Primitive Obsession | Overuse of primitives            | Replace with Value Object  |
| Switch Statements   | Complex switch/case              | Replace with Polymorphism  |

**Example - Extract Method:**

```typescript
// Before: Long method with multiple responsibilities
function processOrder(order: Order) {
  // Validate order (10 lines)
  if (!order.items || order.items.length === 0) {
    throw new Error("Order must have items");
  }
  if (!order.customer) {
    throw new Error("Order must have customer");
  }
  // ... more validation

  // Calculate totals (15 lines)
  let subtotal = 0;
  for (const item of order.items) {
    subtotal += item.price * item.quantity;
  }
  const tax = subtotal * 0.1;
  const total = subtotal + tax;
  // ... more calculations

  // Send notification (10 lines)
  // ...
}

// After: Extracted methods with single responsibility
function processOrder(order: Order) {
  validateOrder(order);
  const totals = calculateTotals(order);
  sendNotification(order, totals);
}

function validateOrder(order: Order): void {
  if (!order.items?.length) {
    throw new Error("Order must have items");
  }
  if (!order.customer) {
    throw new Error("Order must have customer");
  }
}

function calculateTotals(order: Order): OrderTotals {
  const subtotal = order.items.reduce(
    (sum, item) => sum + item.price * item.quantity,
    0,
  );
  return {
    subtotal,
    tax: subtotal * TAX_RATE,
    total: subtotal * (1 + TAX_RATE),
  };
}
```

### 2. Performance Improvements

| Issue                 | Symptom           | Optimization                 |
| --------------------- | ----------------- | ---------------------------- |
| Unnecessary Renders   | Slow UI updates   | React.memo, useMemo          |
| N+1 Queries           | Multiple DB calls | Eager loading, batching      |
| Blocking Operations   | UI freezes        | Async/await, workers         |
| Large Bundles         | Slow load times   | Code splitting, lazy loading |
| Memory Leaks          | Growing memory    | Cleanup event listeners      |
| Repeated Calculations | Slow functions    | Memoization, caching         |

**Example - Memoization:**

```typescript
// Before: Recalculates on every render
function ExpensiveComponent({ data }: Props) {
  const processed = expensiveCalculation(data);
  return <div>{processed}</div>;
}

// After: Memoized calculation
function ExpensiveComponent({ data }: Props) {
  const processed = useMemo(
    () => expensiveCalculation(data),
    [data]
  );
  return <div>{processed}</div>;
}
```

### 3. Maintainability Improvements

| Issue             | Symptom           | Improvement                 |
| ----------------- | ----------------- | --------------------------- |
| Tight Coupling    | Changes ripple    | Dependency Injection        |
| Magic Numbers     | Unclear constants | Named Constants             |
| Deep Nesting      | Hard to follow    | Early Returns, Extract      |
| Poor Naming       | Confusion         | Rename Variable/Function    |
| Missing Types     | Runtime errors    | Add TypeScript types        |
| No Error Handling | Crashes           | Add try/catch, Result types |

**Example - Early Return:**

```typescript
// Before: Deep nesting
function processUser(user: User | null) {
  if (user) {
    if (user.isActive) {
      if (user.hasPermission) {
        return doSomething(user);
      } else {
        return "No permission";
      }
    } else {
      return "User inactive";
    }
  } else {
    return "No user";
  }
}

// After: Early returns (guard clauses)
function processUser(user: User | null) {
  if (!user) return "No user";
  if (!user.isActive) return "User inactive";
  if (!user.hasPermission) return "No permission";

  return doSomething(user);
}
```

### 4. Security Improvements

| Issue                 | Risk             | Improvement           |
| --------------------- | ---------------- | --------------------- |
| Hardcoded Secrets     | Exposure         | Environment Variables |
| SQL Injection         | Data breach      | Parameterized Queries |
| XSS Vulnerabilities   | Script injection | Output Encoding       |
| Insecure Dependencies | Known CVEs       | Update Dependencies   |
| Missing Validation    | Invalid data     | Input Validation      |

## Safe Refactoring Principles

### Golden Rules

1. **Working code first** - Never break working functionality
2. **Small steps** - One refactoring at a time
3. **Test after each change** - Verify continuously
4. **Preserve behavior** - Same inputs → same outputs
5. **Reversibility** - Be able to undo any change

### Change Size Guidelines

| Change Size      | Testing Required  | Risk Level |
| ---------------- | ----------------- | ---------- |
| Rename           | Run related tests | Low        |
| Extract function | Run unit tests    | Low        |
| Move code        | Run module tests  | Medium     |
| Change interface | Run all tests     | High       |
| Restructure      | Full regression   | High       |

### Refactoring Catalog

| Refactoring                           | When to Use                 | Risk   |
| ------------------------------------- | --------------------------- | ------ |
| Rename                                | Unclear naming              | Low    |
| Extract Method                        | Long functions              | Low    |
| Extract Variable                      | Complex expressions         | Low    |
| Inline Variable                       | Unnecessary indirection     | Low    |
| Extract Class                         | Large class, mixed concerns | Medium |
| Move Method                           | Feature envy                | Medium |
| Replace Temp with Query               | Repeated calculation        | Medium |
| Introduce Parameter Object            | Long parameter list         | Medium |
| Replace Conditional with Polymorphism | Complex switch/if           | High   |
| Replace Inheritance with Delegation   | Rigid hierarchy             | High   |

## Output Format

```markdown
## Improvement Report: [Target]

### Summary

- **Files modified**: X
- **Refactorings applied**: Y
- **Tests passing**: Z/Z

### Research Applied

- Clean Code: [principles referenced]
- Patterns: [patterns used]
- Best Practices: [sources consulted]

### Changes Applied

#### [Improvement 1]: Extract Method

- **File**: `src/services/order.ts:45`
- **What**: Extracted validation logic into `validateOrder()`
- **Why**: Original method was 80 lines with 3 responsibilities
- **Pattern**: Single Responsibility Principle

#### [Improvement 2]: Replace Magic Numbers

- **File**: `src/config/constants.ts`
- **What**: Replaced hardcoded values with named constants
- **Why**: Improves readability and maintainability

### Metrics

| Metric                | Before   | After    | Change |
| --------------------- | -------- | -------- | ------ |
| Avg Function Length   | 45 lines | 12 lines | -73%   |
| Cyclomatic Complexity | 15       | 4        | -73%   |
| Duplicate Code        | 3 blocks | 0 blocks | -100%  |
| Type Coverage         | 75%      | 95%      | +20%   |

### Verification

- [x] All tests passing
- [x] No regressions detected
- [x] Behavior unchanged

### Future Recommendations

1. Consider extracting `PaymentProcessor` class
2. Add integration tests for order flow
3. Replace remaining any types
```

## Reference Files

For detailed patterns, see:

- `references/refactoring-patterns.md` - Safe refactoring techniques
- `references/code-smells.md` - Code smell catalog with fixes
- `references/solid-principles.md` - SOLID principles and examples
- `references/improvement-checklist.md` - Quality/performance/security patterns

## Handoffs

| Scenario                   | Hand off to         |
| -------------------------- | ------------------- |
| Code is broken             | `debug` skill       |
| Need analysis only         | `analyze` skill     |
| Need performance profiling | `performance` skill |
| Need security audit        | `security` skill    |
| Need test strategy         | `quality` skill     |
| Need architecture redesign | `design` skill      |

## Boundaries

**Will:**

- Apply refactoring patterns to improve code quality
- Research best practices via MCP tools
- Make incremental, safe changes
- Verify no regressions after each change
- Document all improvements made
- Measure improvement with metrics
- Follow established clean code principles

**Will Not:**

- Fix broken code (use `debug` skill)
- Make changes without understanding code first
- Apply multiple refactorings at once
- Skip verification steps
- Make breaking API changes without approval
- Refactor code with failing tests
