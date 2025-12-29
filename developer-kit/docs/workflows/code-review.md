# Code Review Workflow

Comprehensive code review process using automated analysis and expert review.

## Overview

```
code-review → Quality Check → Security Scan → Performance → Coverage → Report
```

## Triggering Code Review

### Review Local Changes

```bash
code-review
```

### Review Specific PR

```bash
code-review 123
```

## Review Process

The `code-reviewer` agent orchestrates multiple analysis passes:

### 1. Code Quality Check

**What It Checks:**
- Readability and clarity
- Naming conventions
- Code organization
- DRY principle adherence
- SOLID principles
- Error handling

**Example Findings:**
```markdown
## Quality Issues

### Medium: Function too long
**Location**: src/services/user.ts:45-120
**Issue**: Function exceeds 50 lines
**Suggestion**: Extract helper functions

### Low: Inconsistent naming
**Location**: src/utils/helpers.ts:12
**Issue**: `getUserData` vs `fetchUserInfo`
**Suggestion**: Use consistent verb patterns
```

### 2. Security Analysis (security skill)

**What It Checks:**
- OWASP Top 10 vulnerabilities
- Input validation
- Authentication/Authorization
- Sensitive data handling
- Injection risks

**Example Findings:**
```markdown
## Security Issues

### Critical: SQL Injection Risk
**Location**: src/api/search.ts:34
**Issue**: User input in query string
**Fix**: Use parameterized queries

### High: Missing Input Validation
**Location**: src/api/users.ts:56
**Issue**: No validation on email field
**Fix**: Add email format validation
```

### 3. Performance Check (performance skill)

**What It Checks:**
- N+1 query patterns
- Memory leaks
- Algorithmic complexity
- Unnecessary re-renders
- Resource usage

**Example Findings:**
```markdown
## Performance Issues

### Medium: N+1 Query Pattern
**Location**: src/services/orders.ts:78
**Issue**: Fetching user for each order in loop
**Fix**: Use eager loading or batch query

### Low: Unnecessary Re-render
**Location**: src/components/List.tsx:45
**Issue**: Missing useMemo for expensive computation
**Fix**: Memoize the filtered list
```

### 4. Test Coverage (quality skill)

**What It Checks:**
- Test presence for new code
- Edge cases covered
- Integration tests
- Test quality

**Example Findings:**
```markdown
## Coverage Issues

### High: Missing Tests
**Location**: src/services/notification.ts
**Issue**: No unit tests for new service
**Required**: Add tests for send, queue, retry

### Medium: Edge Case Missing
**Location**: src/utils/validate.ts
**Issue**: No test for empty input
**Required**: Add edge case tests
```

## Review Output Format

```
┌─────────────────────────────────────────────────────────────┐
│  Code Review Summary                                         │
├─────────────────────────────────────────────────────────────┤
│  Quality                                                     │
│  ├── Critical: 0                                            │
│  ├── High: 1                                                │
│  ├── Medium: 3                                              │
│  └── Low: 5                                                 │
│                                                              │
│  Security: 1 Critical, 1 High                               │
│  Performance: 2 Medium                                       │
│  Test Coverage: 78% → 82% (+4%)                             │
├─────────────────────────────────────────────────────────────┤
│  Recommendation: CHANGES REQUESTED                           │
│  Block: Fix critical security issue before merge            │
└─────────────────────────────────────────────────────────────┘
```

## Confidence Filtering

The code-reviewer agent uses confidence ≥80% filtering:
- Only reports issues with high confidence
- Reduces false positives
- Focuses on actionable findings

## Self-Review Mode

Before requesting team review:

```bash
code-review --self
```

This runs the same checks but formatted for self-improvement rather than external review.

## Integrating with PR Preparation

```bash
# Full flow
check --fix        # Fix auto-fixable issues
code-review        # Review changes
prep-pr            # Prepare PR with review findings
```

## Review Checklist

### Before Submitting PR
- [ ] All tests pass (`check`)
- [ ] No critical/high issues from review
- [ ] Security issues addressed
- [ ] Performance issues addressed
- [ ] Documentation updated
- [ ] Changelog entry added (if needed)

### For Reviewers
- [ ] Code is clear and readable
- [ ] Tests cover new functionality
- [ ] No obvious security issues
- [ ] Performance is acceptable
- [ ] Matches requirements

## Tips

1. **Review early** - Don't wait until PR is ready
2. **Fix critical first** - Block on security/correctness
3. **Suggestions are optional** - Low severity can be deferred
4. **Trust the tools** - Automated checks catch common issues
5. **Focus on logic** - Let tools handle style
