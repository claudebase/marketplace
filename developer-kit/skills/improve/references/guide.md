# Improve Skill - Detailed Guide

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

## Phase 1: ANALYZE

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

## Phase 2: RESEARCH

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

# Find refactoring examples in production codebases
mcp__github__search_code("refactor extract method filename:.ts stars:>500")

# Research current best practices
mcp__tavily__tavily-search("TypeScript refactoring best practices 2024")
```

## Phase 3: PLAN

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

## Phase 4: APPLY

Make incremental changes following safe refactoring:

- One refactoring at a time
- Preserve external behavior
- Keep changes reversible
- Follow established patterns

## Phase 5: VERIFY

Confirm improvements and no regressions:

- Run tests after each change
- Verify functionality unchanged
- Measure improvement metrics
- Document what was done

## MCP Integration

### Context7 (Refactoring Documentation)

**Available Resources:**

| Resource               | Library ID                                   | Snippets |
| ---------------------- | -------------------------------------------- | -------- |
| Refactoring.Guru       | `/websites/refactoring_guru`                 | 12,314   |
| Design Patterns        | `/websites/refactoring_guru-design-patterns` | 1,696    |
| Code Smells            | `/websites/refactoring_guru_smells`          | 86       |
| Clean Code TypeScript  | `/labs42io/clean-code-typescript`            | 62       |
| Clean Code JavaScript  | `/ryanmcdermott/clean-code-javascript`       | 78       |
| ESLint                 | `/eslint/eslint`                             | 4,069    |
| Node.js Best Practices | `/goldbergyoni/nodebestpractices`            | 734      |

### GitHub MCP (Pattern Research)

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
```

### Tavily (Best Practices Research)

**Use cases:**

- "TypeScript refactoring best practices 2024"
- "React component composition patterns"
- "Node.js async refactoring techniques"
- "Reducing cyclomatic complexity strategies"

## Improvement Domains

### 1. Code Quality - Code Smells and Fixes

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
  // Calculate totals (15 lines)
  // Send notification (10 lines)
}

// After: Extracted methods with single responsibility
function processOrder(order: Order) {
  validateOrder(order);
  const totals = calculateTotals(order);
  sendNotification(order, totals);
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
      }
    }
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
| Extract Class                         | Large class, mixed concerns | Medium |
| Move Method                           | Feature envy                | Medium |
| Replace Conditional with Polymorphism | Complex switch/if           | High   |
| Replace Inheritance with Delegation   | Rigid hierarchy             | High   |

## Output Format

```markdown
## Improvement Report: [Target]

### Summary

- **Files modified**: X
- **Refactorings applied**: Y
- **Tests passing**: Z/Z

### Changes Applied

#### [Improvement 1]: Extract Method

- **File**: `src/services/order.ts:45`
- **What**: Extracted validation logic into `validateOrder()`
- **Why**: Original method was 80 lines with 3 responsibilities
- **Pattern**: Single Responsibility Principle

### Metrics

| Metric                | Before   | After    | Change |
| --------------------- | -------- | -------- | ------ |
| Avg Function Length   | 45 lines | 12 lines | -73%   |
| Cyclomatic Complexity | 15       | 4        | -73%   |
| Duplicate Code        | 3 blocks | 0 blocks | -100%  |

### Verification

- [x] All tests passing
- [x] No regressions detected
- [x] Behavior unchanged
```
