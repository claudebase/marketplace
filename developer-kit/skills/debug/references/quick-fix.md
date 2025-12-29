# Debugging Methodology

## Systematic Debugging Process

### The Scientific Method for Debugging

```
Observe → Hypothesize → Test → Conclude → Fix → Verify
```

## Step 1: Observation

### Gather All Available Information

```markdown
## Information Checklist

### Error Details
- [ ] Exact error message
- [ ] Full stack trace
- [ ] Error codes

### Context
- [ ] When did it start?
- [ ] What changed recently?
- [ ] Does it always happen or intermittently?
- [ ] What triggers it?

### Environment
- [ ] Which environment? (dev/staging/prod)
- [ ] What versions? (language, framework, dependencies)
- [ ] What platform? (OS, browser, device)

### Reproduction
- [ ] Steps to reproduce
- [ ] Minimum reproduction case
- [ ] Does it affect all users or specific ones?
```

### Log Analysis Commands

```bash
# Find recent errors in logs
grep -i "error\|exception\|fail" /var/log/app.log | tail -50

# Search for specific error pattern
grep -rn "NullPointerException" ./logs/

# Check timestamps around the issue
awk '/2024-01-15 14:3[0-5]/' application.log

# Find related log entries
grep -B5 -A5 "error_id_12345" application.log
```

## Step 2: Hypothesis Formation

### Common Bug Categories

| Category | Typical Causes | First Checks |
|----------|---------------|--------------|
| Null/Undefined | Missing data, race conditions | Input validation, async handling |
| Type Errors | Wrong types, implicit conversions | Type checking, interface compliance |
| Logic Errors | Wrong conditions, off-by-one | Edge cases, boundary conditions |
| State Issues | Stale state, mutation bugs | State flow, immutability |
| Async Issues | Race conditions, timing | Promise handling, await placement |
| Integration | API changes, contract violations | API responses, schema validation |

### Hypothesis Template

```markdown
## Hypothesis: [Brief description]

**Likelihood**: High/Medium/Low

**Evidence For**:
- [What supports this hypothesis]

**Evidence Against**:
- [What contradicts this hypothesis]

**How to Test**:
- [Specific steps to confirm or refute]
```

### Prioritization Matrix

```
Likelihood
    High │ Test First  │ Test Second │
         │             │             │
  Medium │ Test Second │ Test Third  │
         │             │             │
     Low │ Test Third  │ Test Last   │
         └─────────────┴─────────────┘
           Easy to Test  Hard to Test
```

## Step 3: Testing Hypotheses

### Isolation Techniques

```markdown
## Isolation Strategies

### Binary Search
1. Find the last known good state
2. Find the first known bad state
3. Test the middle point
4. Repeat until you find the exact change

### Component Isolation
1. Test each component independently
2. Mock dependencies
3. Identify which component fails

### Input Isolation
1. Simplify input to minimum reproduction
2. Test edge cases
3. Test boundary conditions
```

### Diagnostic Commands

```bash
# Git bisect for finding breaking commit
git bisect start
git bisect bad HEAD
git bisect good v1.2.0
# Then test and mark each commit

# Check for dependency issues
npm ls --depth=0
npm outdated

# Memory issues
node --expose-gc --inspect app.js

# Network debugging
curl -v https://api.example.com/endpoint
```

## Step 4: Root Cause Identification

### The 5 Whys Technique

```
Problem: API returns 500 error

Why 1: Database query failed
Why 2: Connection timeout
Why 3: Connection pool exhausted
Why 4: Connections not being released
Why 5: Missing try/finally in async handler
         ↓
Root Cause: Resource leak in error handling
```

### Root Cause Categories

```markdown
## Root Cause Classification

### Code Defects
- Logic errors
- Missing error handling
- Race conditions
- Resource leaks

### Configuration Issues
- Wrong environment variables
- Misconfigured services
- Version mismatches

### Data Issues
- Corrupt data
- Missing data
- Invalid data format

### External Factors
- Third-party API changes
- Infrastructure issues
- Resource exhaustion
```

## Step 5: Fix Application

### Fix Types

| Fix Type | When to Use | Risk Level |
|----------|-------------|------------|
| Hotfix | Critical production issue | High - minimal testing |
| Patch | Specific bug fix | Medium - focused testing |
| Refactor | Underlying design issue | Low - comprehensive testing |

### Safe Fix Patterns

```markdown
## Before Making Changes

1. Create a branch
2. Write a failing test that reproduces the bug
3. Make the minimal fix
4. Verify the test passes
5. Check for regressions
6. Document the change
```

## Step 6: Verification

### Verification Checklist

```markdown
## Fix Verification

### Immediate
- [ ] Original error no longer occurs
- [ ] Test case passes
- [ ] No new errors introduced

### Related
- [ ] Related functionality still works
- [ ] Edge cases handled
- [ ] Similar code paths checked

### Regression
- [ ] Full test suite passes
- [ ] No performance degradation
- [ ] No side effects observed
```

## Common Debugging Patterns

### The Rubber Duck Method
Explain the problem out loud, step by step. Often you'll find the issue while explaining.

### Print/Log Debugging
```javascript
// Strategic logging
console.log('[DEBUG] Function entry:', { args });
console.log('[DEBUG] After processing:', { result });
console.log('[DEBUG] Function exit:', { returnValue });
```

### Divide and Conquer
```
1. Comment out half the code
2. Does the bug still occur?
3. Yes → Bug is in remaining half
4. No → Bug is in commented half
5. Repeat until isolated
```

### Time Travel Debugging
```bash
# Check recent changes
git log --oneline -20
git diff HEAD~5..HEAD -- src/

# Find when a specific line was changed
git log -p -S "problematic code" -- file.js
```
