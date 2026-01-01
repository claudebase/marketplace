---
name: prep-pr
description: "**Use before creating PRs**. Validate, review, and generate PR description. Delegates to: orchestration. Activates for: prepare PR, create pull request, PR description."
argument-hint: "[--base <branch>] [--draft] [--skip-review] [--create]"
delegates-to: orchestration
operation: pr-preparation
---

# prep-pr - Pull Request Preparation

Prepare current changes for a pull request with full validation and review.

## Usage

```
prep-pr [options]
```

## Options

| Option            | Default | Description                       |
| ----------------- | ------- | --------------------------------- |
| `--base <branch>` | main    | Target branch for PR              |
| `--draft`         | false   | Create as draft PR                |
| `--skip-review`   | false   | Skip code review step             |
| `--create`        | false   | Actually create the PR via gh CLI |

## What This Does

### 1. Pre-flight Checks

```bash
# Verify clean state
git status
git diff --cached  # Check staged changes

# Verify branch is ahead of base
git log origin/<base>..HEAD
```

### 2. Validation (check)

Runs the full validation pipeline:

```
[1/5] Formatting      ✓ PASS
[2/5] Linting         ✓ PASS (2 warnings)
[3/5] Type Check      ✓ PASS
[4/5] Tests           ✓ PASS (47/47, 98% coverage)
[5/5] Security        ✓ PASS
```

### 3. Code Review (unless --skip-review)

Invokes `code-reviewer` agent for:

- Code quality assessment
- Security review (via security skill)
- Performance analysis (via performance skill)
- Test coverage check (via quality skill)

### 4. Change Analysis

Analyzes git diff to generate:

- Files changed summary
- Key modifications by category
- Breaking changes detection
- Migration requirements

### 5. PR Description Generation

Creates comprehensive PR description:

```markdown
## Summary

Brief description of changes based on commits and diff analysis.

## Changes

- **Added**: New features and files
- **Changed**: Modified functionality
- **Fixed**: Bug fixes
- **Removed**: Deleted code/features

## Testing

- Unit tests: 47/47 passing
- Coverage: 98%
- E2E tests: Verified

## Screenshots

[If UI changes detected]

## Checklist

- [x] Tests pass
- [x] Documentation updated
- [x] No breaking changes
- [ ] Ready for review
```

## Examples

```bash
# Prepare PR for main branch
prep-pr

# Prepare PR for release branch
prep-pr --base release/v2.0

# Quick prep without code review
prep-pr --skip-review

# Create draft PR directly
prep-pr --draft --create

# Full flow: validate, review, and create PR
prep-pr --create
```

## Output

```
Preparing PR for feature/user-notifications...

[1/5] Pre-flight checks...
      ✓ Working tree clean
      ✓ Branch ahead of main by 5 commits
      ✓ No merge conflicts

[2/5] Running validation (check)...
      ✓ Formatting    PASS
      ✓ Linting       PASS
      ✓ Type Check    PASS
      ✓ Tests         PASS (47/47)
      ✓ Security      PASS

[3/5] Code review...
      Quality:     Good (no critical issues)
      Security:    Clean (0 vulnerabilities)
      Performance: OK (1 suggestion)
      Coverage:    94% (+2% from base)

[4/5] Analyzing changes...
      Files:    12 changed (+450, -120)
      Commits:  5 commits
      Authors:  1 contributor

[5/5] Generating PR description...
      ✓ Description ready

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PR Ready
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Title: Add user notification system
Base:  main ← feature/user-notifications
Files: 12 changed (+450, -120)

Use --create to create the PR, or copy the description below.

## Summary
Added comprehensive user notification system with support for
email, push, and in-app notifications...

[Full PR description follows]
```

## With --create Flag

If `--create` is specified and `gh` CLI is available:

```bash
gh pr create \
  --title "Add user notification system" \
  --body "$(cat pr-description.md)" \
  --base main \
  --head feature/user-notifications
```

Output:

```
Creating PR via GitHub CLI...
✓ PR created: https://github.com/org/repo/pull/123
```

## Review Output Format

```
┌─────────────────────────────────────────────────────────────┐
│  Code Review Summary                                         │
├─────────────────────────────────────────────────────────────┤
│  Quality                                                     │
│  ├── Critical: 0                                            │
│  ├── High: 0                                                │
│  ├── Medium: 2 (suggestions)                                │
│  └── Low: 3 (style)                                         │
│                                                              │
│  Security: CLEAN                                             │
│  Performance: 1 suggestion (N+1 query potential)            │
│  Test Coverage: 94% (target: 80%)                           │
├─────────────────────────────────────────────────────────────┤
│  Recommendation: APPROVE                                     │
└─────────────────────────────────────────────────────────────┘
```

## Workflow Integration

```
start            # Initialize feature
    ↓
brainstorm/design    # Plan
    ↓
implement            # Build
    ↓
check            # Validate
    ↓
prep-pr          ←── You are here
    ↓
ship             # Release (after PR merged)
```

## Boundaries

**Will:**

- Run full validation pipeline
- Perform automated code review
- Generate comprehensive PR description
- Create PR via gh CLI (with --create)
- Detect breaking changes and migrations

**Will Not:**

- Push changes without confirmation
- Force push or rebase automatically
- Merge the PR (review required)
- Skip validation (use --skip-review for review only)
