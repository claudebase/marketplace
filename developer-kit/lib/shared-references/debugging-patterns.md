# Debugging Patterns

Centralized patterns for debugging operations. Used by `debug` skill.

## Tiered Approach

| Tier | When                          | Approach                 | Duration |
| ---- | ----------------------------- | ------------------------ | -------- |
| 1    | Clear error, simple fix       | Quick research & fix     | <5 min   |
| 2    | Multi-file, unclear cause     | Systematic investigation | 5-20 min |
| 3    | Recurring, 3+ failed attempts | Deep root cause analysis | 20+ min  |

### Tier Selection Guide

**Use Tier 1 when:**

- Error message is clear and specific
- Single file involved
- Common error pattern
- First attempt at fixing

**Use Tier 2 when:**

- Multiple files involved
- Error source unclear
- Previous fix attempt failed
- Integration or async issues

**Use Tier 3 when:**

- 3+ failed fix attempts
- Recurring bug (fixed before, came back)
- Complex cross-system issue
- Performance-related bug

## The Iron Law

```
NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST
```

Only for Tier 2+ debugging. Tier 1 can use quick research & fix.

## Quick Workflow

```
OBSERVE → RESEARCH → HYPOTHESIZE → FIX → VERIFY
  Read    Context7   Sequential   Edit    Bash
  Grep    GitHub     Thinking     Write   (test)
  Bash    Tavily
```

## Error Research Patterns

### JavaScript/TypeScript Errors

| Error Pattern                                    | Research Query                                |
| ------------------------------------------------ | --------------------------------------------- |
| `TypeError: Cannot read property X of undefined` | "undefined property access JavaScript causes" |
| `Module not found`                               | "[package] module not found node"             |
| `ReferenceError: X is not defined`               | "ReferenceError not defined scope JavaScript" |
| `Maximum call stack size exceeded`               | "infinite recursion JavaScript debug"         |
| `Promise rejection`                              | "unhandled promise rejection Node.js"         |

### React Errors

| Error Pattern                          | Research Query                             |
| -------------------------------------- | ------------------------------------------ |
| `Invalid hook call`                    | "React invalid hook call rules of hooks"   |
| `Maximum update depth exceeded`        | "React infinite re-render loop causes"     |
| `Cannot update unmounted component`    | "React memory leak useEffect cleanup"      |
| `Objects are not valid as React child` | "React render object instead of component" |

### Build/Compilation Errors

| Error Pattern                        | Research Query                             |
| ------------------------------------ | ------------------------------------------ |
| `Cannot find module`                 | "[bundler] module resolution path"         |
| `Unexpected token`                   | "[parser] syntax error unexpected token"   |
| `Type X is not assignable to type Y` | "TypeScript type error [X] [Y]"            |
| `Out of memory`                      | "[tool] heap out of memory increase limit" |

### Python Errors

| Error Pattern                                 | Research Query                         |
| --------------------------------------------- | -------------------------------------- |
| `ImportError: No module named X`              | "Python import error module not found" |
| `TypeError: X takes Y positional arguments`   | "Python function argument count"       |
| `AttributeError: 'NoneType' has no attribute` | "Python NoneType attribute error"      |
| `IndentationError`                            | "Python indentation mixed tabs spaces" |

## Hypothesis Testing Protocol

For Tier 2+ debugging:

1. **Form Hypothesis** - Based on evidence, what do you think is wrong?
2. **Identify Test** - What would prove or disprove this hypothesis?
3. **Execute Test** - Run the specific test
4. **Evaluate Result** - Did it confirm or refute?
5. **Revise or Confirm** - Update hypothesis or proceed with fix

```yaml
Example:
  Hypothesis: "The cache is returning stale data"
  Test: "Add logging to cache.get() and cache.set()"
  Execute: "Trigger the bug and check logs"
  Result: "Cache shows stale entry, TTL not updating"
  Confirm: "Root cause is TTL calculation bug"
```

## Defense-in-Depth Validation

After fix applied, verify at multiple layers:

1. **Compile/Type Check** - Does it build without errors?
2. **Specific Test** - Does a test for this exact bug pass?
3. **Related Tests** - Do tests in the same area pass?
4. **Full Suite** - Does the entire test suite pass?
5. **Manual Verification** - Does manual testing confirm the fix?

```bash
# Example validation sequence
npm run typecheck    # Layer 1
npm test -- path/to/specific.test.ts  # Layer 2
npm test -- --testPathPattern="related/"  # Layer 3
npm test  # Layer 4
# Manual: reproduce original issue, verify fixed
```

## Common Debug Commands

### Finding Recent Changes

```bash
# What changed recently?
git log --oneline -10
git diff HEAD~3

# Who changed this file?
git blame path/to/file.ts

# When did this line appear?
git log -p -S "suspicious code" -- path/to/file.ts
```

### Finding Error Sources

```bash
# Find all error throws
grep -rn "throw new Error" src/

# Find console.error calls
grep -rn "console.error" src/

# Find try-catch blocks
grep -rn "try {" src/
```

### Debugging Node.js

```bash
# Run with debugging
node --inspect-brk script.js

# Increase heap for memory issues
NODE_OPTIONS="--max-old-space-size=4096" npm run build

# Trace deprecation warnings
node --trace-deprecation script.js
```

## Context7 Debug Resources

| Resource   | Library ID              | Use Case            |
| ---------- | ----------------------- | ------------------- |
| Node.js    | `/websites/nodejs_api`  | Runtime debugging   |
| React      | `/reactjs/react.dev`    | Component debugging |
| Jest       | `/jestjs/jest`          | Test debugging      |
| TypeScript | `/microsoft/typescript` | Type errors         |

## Related

- [MCP Resources](./mcp-resources.md) - Context7 library IDs
- [Tool Integration](./tool-integration-patterns.md) - MCP patterns
- [Testing Patterns](./testing-patterns.md) - Test debugging
