# Evidence Patterns Reference

Common verification patterns organized by claim type. Use these patterns to ensure proper evidence gathering.

## Test Verification Patterns

### All Tests Pass
```bash
# Execute
npm test
# OR
pytest -v
# OR
go test -v ./...

# Evidence needed
- Total test count
- Pass count = Total count
- Exit code: 0
- No failures or errors in output
```

### Coverage Verification
```bash
# Execute
npm test -- --coverage
# OR
pytest --cov=src --cov-report=term
# OR
go test -cover ./...

# Evidence needed
- Coverage percentage
- Comparison to baseline (increased/decreased)
- Uncovered files/lines if significant
```

### Specific Test Passes
```bash
# Execute
npm test -- --grep "specific test name"
# OR
pytest -k "test_specific_function"
# OR
go test -run TestSpecificFunction

# Evidence needed
- Test ran (not skipped)
- Test passed
- Correct test was executed (verify name match)
```

## Build Verification Patterns

### Build Succeeds
```bash
# Execute
npm run build
# OR
cargo build --release
# OR
go build ./...

# Evidence needed
- Exit code: 0
- No errors in output
- Build artifacts created (if applicable)
```

### Type Check Passes
```bash
# Execute
tsc --noEmit
# OR
mypy src/
# OR
pyright

# Evidence needed
- Exit code: 0
- No type errors reported
- All files checked
```

### Lint Check Passes
```bash
# Execute
npm run lint
# OR
ruff check .
# OR
golangci-lint run

# Evidence needed
- Exit code: 0
- No errors (warnings may be acceptable)
- All relevant files checked
```

## Git Verification Patterns

### Changes Exist
```bash
# Execute
git status
git diff --stat

# Evidence needed
- Files actually modified
- Expected files in diff
- No unexpected changes
```

### Changes Are Correct
```bash
# Execute
git diff HEAD
# OR
git diff --cached  # for staged changes

# Evidence needed
- Line changes match expectations
- No debug code included
- No unintended changes
```

### Clean Working Directory
```bash
# Execute
git status

# Evidence needed
- "nothing to commit, working tree clean"
- No untracked files that should be committed
```

## Requirement Verification Patterns

### Requirement Checklist
```markdown
# Create explicit checklist from requirements

## Requirements
- [x] Requirement 1 - Verified by: [test/manual/code]
- [x] Requirement 2 - Verified by: [test/manual/code]
- [ ] Requirement 3 - NOT MET: [reason]

# Evidence needed
- Each requirement explicitly checked
- Verification method documented
- Any gaps explicitly noted
```

### Acceptance Criteria
```markdown
# Map to acceptance criteria

Given: [context]
When: [action]
Then: [expected result]

Verification:
- Command: [what was run]
- Observed: [what actually happened]
- Match: [YES/NO]
```

## Bug Fix Verification Patterns

### Bug Is Fixed
```bash
# 1. Document original symptom
Original error: [exact error message]

# 2. Reproduce original issue (should still fail before fix)
# Execute the reproducing steps

# 3. Apply fix

# 4. Verify symptom is gone
# Execute same steps

# Evidence needed
- Original symptom documented
- Same steps now succeed
- No new errors introduced
```

### Regression Test Works
```bash
# 1. Write regression test
# 2. Run test (should FAIL without fix)
npm test -- --grep "regression test"
# Expected: FAIL

# 3. Apply fix
# 4. Run test (should PASS)
npm test -- --grep "regression test"
# Expected: PASS

# 5. Revert fix temporarily
# 6. Run test (must FAIL again)
# Expected: FAIL

# 7. Restore fix

# Evidence needed
- Test fails without fix (RED)
- Test passes with fix (GREEN)
- Test fails again when fix reverted (confirms test catches bug)
```

## Agent Delegation Verification

### Agent Task Completed
```bash
# After agent reports completion:

# 1. Check VCS for actual changes
git status
git diff --stat

# 2. Review changes content
git diff HEAD

# 3. Verify changes match expectations
# - Expected files modified
# - Changes are correct
# - No unexpected side effects

# Evidence needed
- Git shows actual changes
- Changes match requested work
- Independent verification (don't trust agent report alone)
```

## Performance Verification Patterns

### Performance Improved
```bash
# 1. Baseline measurement (before)
time npm run benchmark
# Result: Xms

# 2. Apply optimization

# 3. Post-optimization measurement
time npm run benchmark
# Result: Yms

# Evidence needed
- Before measurement
- After measurement
- Improvement percentage: (X-Y)/X * 100
```

## Security Verification Patterns

### No Secrets Committed
```bash
# Execute
git diff --cached | grep -E "(password|secret|api_key|token)" || echo "No secrets found"

# Evidence needed
- Grep returns no matches
- Or matches are false positives (e.g., variable names)
```

### Dependency Audit Passes
```bash
# Execute
npm audit
# OR
pip-audit
# OR
cargo audit

# Evidence needed
- No high/critical vulnerabilities
- Or known vulnerabilities with justification
```

## Quick Reference Table

| Claim | Command | Evidence |
|-------|---------|----------|
| Tests pass | `npm test` | 0 failures, exit 0 |
| Build works | `npm run build` | exit 0, no errors |
| Types check | `tsc --noEmit` | exit 0, no errors |
| Lint clean | `npm run lint` | exit 0, no errors |
| Bug fixed | reproduce steps | symptom gone |
| Changes exist | `git diff --stat` | files modified |
| Requirements met | checklist | all items checked |
| Agent completed | `git diff` | changes present |
