# Fix Verification Techniques

## Verification Principles

### The Fix Verification Triangle

```
        Correctness
           /\
          /  \
         /    \
        /      \
       /________\
  Safety      Completeness
```

- **Correctness**: Does the fix solve the actual problem?
- **Safety**: Does the fix avoid introducing new problems?
- **Completeness**: Does the fix handle all related cases?

## Pre-Fix Verification

### Before Applying Any Fix

```markdown
## Pre-Fix Checklist

### Understanding
- [ ] Root cause is identified (not just symptoms)
- [ ] Reproduction steps are documented
- [ ] Expected behavior is clear

### Preparation
- [ ] Current state is saved (git stash or branch)
- [ ] Test environment is ready
- [ ] Rollback plan exists

### Scope Assessment
- [ ] All affected code paths identified
- [ ] Dependencies on this code understood
- [ ] Side effects considered
```

### Risk Assessment Matrix

| Change Type | Files Affected | Test Coverage | Risk Level |
|-------------|---------------|---------------|------------|
| One-liner | 1 | High | Low |
| Function fix | 1-2 | High | Low |
| Multi-file | 3-5 | Medium | Medium |
| Cross-module | 5+ | Low | High |
| Architecture | Many | Any | Critical |

## During-Fix Verification

### Incremental Verification

```markdown
## Step-by-Step Verification

### After Each Change
1. Save the file
2. Run the specific test case
3. Check for syntax errors
4. Verify the change behaves as expected

### Red-Green-Refactor for Fixes
1. RED: Write/run test that fails (reproduces bug)
2. GREEN: Apply fix, test passes
3. REFACTOR: Clean up if needed, tests still pass
```

### Change Isolation

```bash
# Keep changes minimal and focused
git diff --stat  # Should show minimal files changed

# Verify only intended changes
git diff  # Review every line

# Stage incrementally
git add -p  # Review each hunk
```

## Post-Fix Verification

### Immediate Verification

```markdown
## Immediate Checks

### Primary Verification
- [ ] Original error no longer occurs
- [ ] Reproduction steps no longer trigger bug
- [ ] Test case written for this bug passes

### Smoke Test
- [ ] Application starts without errors
- [ ] Basic functionality works
- [ ] No console errors/warnings
```

### Test Commands

```bash
# Run specific test for the fix
npm test -- --grep "bug description"

# Run related tests
npm test -- --grep "affected module"

# Run full test suite
npm test

# Check for TypeScript errors
npx tsc --noEmit

# Lint check
npm run lint
```

### Regression Verification

```markdown
## Regression Checks

### Related Functionality
- [ ] Similar features still work
- [ ] Connected components unaffected
- [ ] Data flow intact

### Edge Cases
- [ ] Empty/null inputs handled
- [ ] Maximum values handled
- [ ] Error conditions handled

### Performance
- [ ] No performance degradation
- [ ] No memory leaks introduced
- [ ] No increased latency
```

## Verification by Bug Type

### Null/Undefined Errors

```markdown
## Verification Steps

1. [ ] Original null case handled
2. [ ] All paths to this code have valid data
3. [ ] TypeScript/PropTypes catch this at compile time
4. [ ] Defensive checks added where appropriate
```

### Race Conditions

```markdown
## Verification Steps

1. [ ] Test with various timing scenarios
2. [ ] Test with slow network simulation
3. [ ] Test with multiple concurrent requests
4. [ ] Proper async/await or Promise handling
```

### Data Issues

```markdown
## Verification Steps

1. [ ] Test with original problematic data
2. [ ] Test with edge case data
3. [ ] Test with large data sets
4. [ ] Validation prevents bad data
```

## Verification Documentation

### Fix Documentation Template

```markdown
## Fix Report: [Issue ID/Title]

### Problem
[What was happening]

### Root Cause
[Why it was happening]

### Fix Applied
[What was changed]

### Verification Performed
- [ ] Unit test added/updated
- [ ] Manual testing completed
- [ ] Regression testing passed
- [ ] Edge cases verified

### Files Changed
- `path/to/file.js` - [brief description of change]

### Rollback Plan
[How to revert if issues arise]

### Prevention
[How to prevent similar issues]
```

## Rollback Procedures

### When to Rollback

```markdown
## Rollback Triggers

### Immediate Rollback
- New critical errors appear
- Core functionality broken
- Data corruption detected

### Consider Rollback
- Significant performance degradation
- Multiple minor issues appear
- User complaints increase
```

### Rollback Commands

```bash
# Revert last commit
git revert HEAD

# Reset to previous state (careful!)
git reset --hard HEAD~1

# Cherry-pick specific fix back
git cherry-pick <commit-hash>

# Deploy previous version
git checkout v1.2.3
npm run deploy
```

## Continuous Verification

### Monitoring After Fix

```markdown
## Post-Deployment Monitoring

### First Hour
- [ ] Error rates normal
- [ ] Response times normal
- [ ] No new error types

### First Day
- [ ] Usage patterns normal
- [ ] No user complaints
- [ ] Logs clean

### First Week
- [ ] Issue confirmed resolved
- [ ] No regression reports
- [ ] Metrics stable
```
