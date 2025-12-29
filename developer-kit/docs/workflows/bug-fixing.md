# Bug Fixing Workflow

Systematic approach to debugging and fixing issues using tiered methodology.

## Overview

```
Triage → Debug (Tier 1/2/3) → Fix → Verify → Document
```

## Step 1: Triage (analyze skill)

### Understand the Problem

```
The login is broken after the last deploy
```

The `analyze` skill:
- Reviews recent changes (git diff)
- Analyzes error logs
- Identifies affected components
- Assesses severity

### Triage Output
```markdown
## Bug Triage: Login Failure

**Severity**: Critical
**Affected**: Authentication flow
**Recent Changes**: 3 commits in auth/ directory
**Symptoms**: 401 errors on valid credentials
```

## Step 2: Debug (debug skill)

The `debug` skill uses a tiered approach:

### Tier 1: Quick Investigation (5-10 minutes)

For obvious issues:
```
Debug this login error
```

Actions:
- Check error messages
- Review recent commits
- Look for obvious issues
- Check configuration

**Escalate if**: No obvious cause found

### Tier 2: Systematic Analysis (15-30 minutes)

For non-obvious issues:
```
Do a systematic debug of this login failure
```

Actions:
- Add logging/debugging statements
- Trace execution path
- Check inputs/outputs at each step
- Isolate the failing component

**Escalate if**: Root cause still unclear

### Tier 3: Root Cause Analysis (30+ minutes)

For complex issues:
```
Do a deep root cause analysis of this authentication bug
```

Actions:
- Use sequential-thinking for structured analysis
- Hypothesis testing with evidence
- Cross-component investigation
- Historical analysis

## Step 3: Fix (improve skill)

### Apply the Fix

```
Fix this authentication bug
```

The `improve` skill:
- Applies minimal necessary changes
- Preserves existing behavior
- Adds regression test
- Verifies no side effects

### Fix Guidelines
- **Minimal changes** - Only fix what's broken
- **Add regression test** - Prevent recurrence
- **Document the fix** - Explain why, not just what

## Step 4: Verify (verify skill)

### Verify the Fix

```bash
check
```

Then:
```
Verify this bug is fixed
```

Checks:
- Bug is actually fixed
- Regression test added
- No new issues introduced
- All tests passing

## Step 5: Document (pm-agent)

PM Agent auto-documents:
- Root cause in `docs/mistakes/`
- Prevention checklist
- Pattern extraction if recurring

### Mistake Document Format
```markdown
# Bug: Authentication Failure After Deploy

## What Happened
401 errors on valid credentials after v2.1.0 deploy

## Root Cause
JWT secret was not updated in production environment

## Why Missed
- Environment variable check not in deployment checklist
- No integration test for token validation

## Prevention Checklist
- [ ] Verify all env vars before deploy
- [ ] Add integration test for auth flow
- [ ] Add deployment validation step

## Lesson Learned
Always validate environment configuration as part of deployment
```

## Debug Cheat Sheet

### Common Issues

| Symptom | First Check |
|---------|-------------|
| 500 errors | Server logs, stack trace |
| 401/403 | Auth tokens, permissions |
| Slow response | Database queries, N+1 |
| UI not updating | State management, re-renders |
| Data missing | API responses, network tab |

### Debug Commands

```bash
# Git history
git log --oneline -10
git diff HEAD~3

# Find changes to specific file
git log -p -- src/auth/login.ts

# Search for pattern
grep -r "authentication" src/
```

## Example Debug Session

```
User: "Users can't log in after yesterday's deploy"

# Tier 1: Quick check
> What's the error message users are seeing?
> Check recent commits to auth

# Found: 401 errors, JWT validation failing

# Tier 2: Systematic
> Add logging to JWT validation
> Trace the token from login to validation

# Found: Token signature mismatch

# Root cause
> JWT secret differs between login server and validation

# Fix
> Sync JWT secret across services
> Add integration test for token flow

check
> Verify the login is working now

# Document
> PM Agent creates docs/mistakes/jwt-secret-mismatch.md
```

## Tips

1. **Start simple** - Tier 1 catches 60% of bugs
2. **Add logging first** - Don't guess, observe
3. **One change at a time** - Isolate variables
4. **Always add regression test** - Prevent recurrence
5. **Document learnings** - Help future debugging
