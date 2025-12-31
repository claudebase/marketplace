---
name: dk:ship
description: "Ship a release: validate, version bump, changelog, tag, and optionally deploy"
argument-hint: "<version|major|minor|patch> [--dry-run] [--no-tag] [--no-push] [--deploy <env>]"
delegates-to: orchestration
operation: release-ship
---

# ship - Release Shipping

Ship a new version with full release workflow automation.

## Usage

```
ship <version> [options]
```

## Arguments

| Argument  | Description                                                       |
| --------- | ----------------------------------------------------------------- |
| `version` | Semantic version (e.g., 1.2.0) or bump type (major, minor, patch) |

## Options

| Option              | Default | Description                                |
| ------------------- | ------- | ------------------------------------------ |
| `--dry-run`         | false   | Preview changes without executing          |
| `--no-tag`          | false   | Skip git tag creation                      |
| `--no-push`         | false   | Skip pushing to remote                     |
| `--deploy <env>`    | none    | Deploy after release (staging, production) |
| `--prerelease <id>` | none    | Create prerelease (alpha, beta, rc)        |

## What This Does

### 1. Pre-flight Checks

```bash
# Ensure clean working tree
git status --porcelain

# Ensure on correct branch (main/master or release/*)
git branch --show-current

# Ensure up to date with remote
git fetch origin
git status -uno

# Run full validation
check --strict
```

### 2. Version Calculation

```
Current: 1.2.3

ship patch  → 1.2.4
ship minor  → 1.3.0
ship major  → 2.0.0
ship 1.5.0  → 1.5.0 (explicit)

With --prerelease:
ship minor --prerelease beta  → 1.3.0-beta.1
```

### 3. Version Bump

Updates version in detected files:

| File                         | Project Type       |
| ---------------------------- | ------------------ |
| `package.json`               | Node.js            |
| `package-lock.json`          | Node.js            |
| `pyproject.toml`             | Python             |
| `setup.py`                   | Python             |
| `Cargo.toml`                 | Rust               |
| `go.mod`                     | Go                 |
| `version.txt`                | Generic            |
| `.claude-plugin/plugin.json` | Claude Code Plugin |

### 4. Changelog Generation

Invokes `changelog` to generate:

```markdown
## [1.3.0] - 2025-01-15

### Added

- User notification system (#123)
- Email template customization (#125)

### Changed

- Improved notification delivery speed (#124)

### Fixed

- Fixed notification duplication bug (#126)
```

### 5. Git Operations

```bash
# Stage all changes
git add -A

# Commit with release message
git commit -m "chore(release): v1.3.0"

# Create annotated tag
git tag -a v1.3.0 -m "Release v1.3.0"

# Push commit and tag
git push origin HEAD --tags
```

### 6. Optional Deployment

If `--deploy` specified:

```bash
# Deploy to specified environment
./deploy.sh <env>  # or detected deployment method
```

## Examples

```bash
# Ship patch release
ship patch

# Ship minor release
ship minor

# Ship major release (breaking changes)
ship major

# Ship specific version
ship 2.0.0

# Preview without making changes
ship minor --dry-run

# Ship without pushing (for review)
ship patch --no-push

# Ship and deploy to staging
ship minor --deploy staging

# Create beta prerelease
ship minor --prerelease beta
```

## Output

```
Shipping release...

[1/6] Pre-flight checks...
      ✓ Working tree clean
      ✓ On branch: main
      ✓ Up to date with origin/main
      ✓ All validations pass

[2/6] Calculating version...
      Current: 1.2.3
      Bump:    minor
      New:     1.3.0

[3/6] Updating version files...
      ✓ package.json: 1.2.3 → 1.3.0
      ✓ package-lock.json: 1.2.3 → 1.3.0

[4/6] Generating changelog...
      ✓ CHANGELOG.md updated
      ✓ 4 changes documented

[5/6] Git operations...
      ✓ Changes staged
      ✓ Committed: chore(release): v1.3.0
      ✓ Tag created: v1.3.0
      ✓ Pushed to origin

[6/6] Post-release...
      ✓ Release complete

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Release v1.3.0 shipped successfully!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Changelog:
- Added: User notification system
- Added: Email template customization
- Changed: Improved notification delivery
- Fixed: Notification duplication bug

GitHub Release: https://github.com/org/repo/releases/tag/v1.3.0
```

## Dry Run Output

With `--dry-run`:

```
[DRY RUN] Would perform the following:

Version Bump:
  package.json: 1.2.3 → 1.3.0
  package-lock.json: 1.2.3 → 1.3.0

Changelog:
  Would add section for v1.3.0 with 4 changes

Git Operations:
  git add -A
  git commit -m "chore(release): v1.3.0"
  git tag -a v1.3.0 -m "Release v1.3.0"
  git push origin main --tags

No changes made. Remove --dry-run to execute.
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
prep-pr          # Prepare PR
    ↓
[PR Review & Merge]
    ↓
ship             ←── You are here
```

## Semantic Versioning Guide

| Change Type                        | Version Bump | Example       |
| ---------------------------------- | ------------ | ------------- |
| Bug fixes, patches                 | `patch`      | 1.2.3 → 1.2.4 |
| New features (backward compatible) | `minor`      | 1.2.3 → 1.3.0 |
| Breaking changes                   | `major`      | 1.2.3 → 2.0.0 |

### Breaking Changes Include:

- Removing public API methods
- Changing method signatures
- Removing configuration options
- Database schema changes requiring migration
- Incompatible protocol changes

## Boundaries

**Will:**

- Run full validation before release
- Bump version in all detected files
- Generate changelog from commits
- Create git commit and tag
- Push to remote (unless --no-push)
- Deploy to specified environment

**Will Not:**

- Release with failing tests
- Force push or rewrite history
- Skip validation steps
- Deploy to production without explicit flag
- Release from non-main branches without confirmation
