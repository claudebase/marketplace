# Self-Review Checklist

## Pre-Commit Validation

### 1. Code Quality
- [ ] Code follows project style guidelines
- [ ] No commented-out code left behind
- [ ] No console.log/print statements for debugging
- [ ] No TODO comments for critical functionality
- [ ] Meaningful variable and function names
- [ ] No magic numbers (use named constants)

### 2. Testing
- [ ] All tests pass locally
- [ ] New functionality has tests
- [ ] Edge cases are tested
- [ ] Coverage hasn't decreased
- [ ] No skipped or disabled tests

### 3. Security
- [ ] No hardcoded credentials or secrets
- [ ] Input validation in place
- [ ] No SQL/command injection risks
- [ ] Proper authentication checks
- [ ] Sensitive data not logged

### 4. Performance
- [ ] No obvious N+1 queries
- [ ] No blocking operations in async code
- [ ] Large datasets paginated
- [ ] Resources properly closed/released

### 5. Documentation
- [ ] Public APIs documented
- [ ] Complex logic has comments
- [ ] README updated if needed
- [ ] Breaking changes noted

## The Four Questions

### Question 1: Tests/Validation Executed?

**Check**:
```bash
# Run tests
npm test
pytest
go test ./...

# Type checking
tsc --noEmit
mypy .

# Linting
npm run lint
ruff check .
```

**Document**:
- Command run: `[command]`
- Result: `[passed/failed]`
- Coverage: `[percentage]`

### Question 2: Edge Cases Covered?

**Common Edge Cases**:
- Null/undefined inputs
- Empty arrays/strings
- Boundary values (0, -1, MAX_INT)
- Unicode and special characters
- Concurrent access
- Network failures
- Maximum load

**Document**:
- Covered: `[list edge cases tested]`
- Not covered: `[list intentionally skipped with reason]`
- Known limitations: `[any known issues]`

### Question 3: Requirements Matched?

**Verify Against Acceptance Criteria**:
- [ ] Criterion 1: Met/Not Met
- [ ] Criterion 2: Met/Not Met
- [ ] Criterion 3: Met/Not Met

**Document**:
- All requirements: `[met/partially met/not met]`
- Deviations: `[any deviations with justification]`
- Scope changes: `[any scope adjustments]`

### Question 4: Follow-up Needed?

**Identify**:
- Technical debt created
- Performance improvements deferred
- Features for later
- Monitoring to add
- Documentation to update

**Document**:
- Follow-up items: `[list]`
- Priority: `[P0/P1/P2]`
- Owner: `[who should handle]`

## Quick Validation Commands

### Git Status Check
```bash
# See what's changed
git status
git diff --stat

# Review changes
git diff HEAD
git diff --cached  # staged changes
```

### Lint and Format
```bash
# JavaScript/TypeScript
npm run lint
npm run format:check

# Python
ruff check .
black --check .

# Go
go fmt ./...
go vet ./...
```

### Test Execution
```bash
# Run all tests
npm test
pytest -v
go test -v ./...

# Run with coverage
npm test -- --coverage
pytest --cov=src
go test -cover ./...
```

### Type Checking
```bash
# TypeScript
tsc --noEmit

# Python
mypy src/
pyright
```

## Review Report Template

```markdown
## Self-Review Report

**Feature/Change**: [Brief description]
**Branch**: [branch-name]
**Date**: [date]

### Changes Summary
- Files changed: [number]
- Lines added: [number]
- Lines removed: [number]

### Checklist Results

✅ **Tests Executed**
- Command: `npm test`
- Result: 45 passed, 0 failed
- Coverage: 78% (+2%)

⚠️ **Edge Cases**
- Covered: null input, empty array, max length
- Not covered: concurrent access (deferred to next sprint)
- Known limitation: Files >10MB not supported

✅ **Requirements**
- [x] User can submit form
- [x] Validation errors displayed
- [x] Success message shown

📋 **Follow-up Items**
1. Add rate limiting (P1)
2. Update API documentation (P2)
3. Add monitoring for new endpoint (P1)

### Residual Risks
| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| High load on new endpoint | Medium | Medium | Add caching later |

### Recommendation
✅ Ready to commit
⚠️ Ready with noted caveats
❌ Needs more work: [reason]
```

## Red Flags to Watch For

### Immediate Blockers
- [ ] Test failures
- [ ] Type errors
- [ ] Lint errors
- [ ] Security vulnerabilities detected
- [ ] Breaking changes without migration

### Warning Signs
- [ ] Coverage decreased significantly
- [ ] Large file changes without tests
- [ ] New dependencies added
- [ ] Configuration changes
- [ ] Database schema changes

### Discussion Needed
- [ ] Architecture decisions made
- [ ] New patterns introduced
- [ ] Performance trade-offs
- [ ] Security implications
