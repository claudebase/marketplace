# Release Workflow

Complete guide for shipping releases with proper versioning, changelogs, and deployment.

## Overview

```
check → changelog → ship → Deploy → Monitor
```

## Pre-Release Checklist

Before running `ship`:

- [ ] All PRs merged to main
- [ ] `check` passes
- [ ] Changelog reviewed
- [ ] Version number decided
- [ ] Release notes drafted
- [ ] Deployment plan ready

## Step 1: Validate

```bash
check --strict
```

Ensures:
- All tests pass
- No linting errors
- No type errors
- No security vulnerabilities

## Step 2: Generate Changelog

```bash
changelog
```

Generates changelog from commits:

```markdown
## [Unreleased]

### Added
- User notification system (#123)
- Email template customization (#125)

### Changed
- Improved notification delivery speed (#124)

### Fixed
- Fixed notification duplication bug (#126)
```

## Step 3: Ship Release

### Patch Release (Bug fixes)
```bash
ship patch
# 1.2.3 → 1.2.4
```

### Minor Release (New features)
```bash
ship minor
# 1.2.3 → 1.3.0
```

### Major Release (Breaking changes)
```bash
ship major
# 1.2.3 → 2.0.0
```

### Specific Version
```bash
ship 2.0.0
```

### Preview Changes
```bash
ship minor --dry-run
```

## Version Bump Guide

| Change Type | Version | Example |
|-------------|---------|---------|
| Bug fix, patch | `patch` | 1.2.3 → 1.2.4 |
| New feature (backward compatible) | `minor` | 1.2.3 → 1.3.0 |
| Breaking change | `major` | 1.2.3 → 2.0.0 |

### What Counts as Breaking?
- Removing public API methods
- Changing method signatures
- Removing configuration options
- Database schema changes requiring migration
- Incompatible protocol changes

## Ship Process Details

`ship` performs these steps:

### 1. Pre-flight Checks
```bash
git status --porcelain      # Clean working tree
git branch --show-current   # On main branch
git fetch origin            # Up to date
check --strict          # All validations pass
```

### 2. Version Bump
Updates version in:
- package.json
- package-lock.json
- pyproject.toml
- Cargo.toml
- plugin.json
- Any other version files

### 3. Changelog Update
Moves [Unreleased] to version section with date

### 4. Git Operations
```bash
git add -A
git commit -m "chore(release): v1.3.0"
git tag -a v1.3.0 -m "Release v1.3.0"
git push origin main --tags
```

## Deployment Options

### Ship and Deploy to Staging
```bash
ship minor --deploy staging
```

### Ship and Deploy to Production
```bash
ship minor --deploy production
```

### Ship Without Push (for review)
```bash
ship minor --no-push
```

## Prerelease Versions

### Beta Release
```bash
ship minor --prerelease beta
# 1.2.3 → 1.3.0-beta.1
```

### Alpha Release
```bash
ship minor --prerelease alpha
# 1.2.3 → 1.3.0-alpha.1
```

### Release Candidate
```bash
ship minor --prerelease rc
# 1.2.3 → 1.3.0-rc.1
```

## Post-Release

### Monitor
Using `observability` skill:
- Check error rates
- Monitor performance metrics
- Verify logging/tracing
- Watch alerting dashboards

### Rollback if Needed
```bash
# Revert to previous version
git revert HEAD
git push origin main

# Or deploy previous tag
./deploy.sh v1.2.3
```

## Release Checklist

### Before Release
- [ ] All features complete and tested
- [ ] `check --strict` passes
- [ ] Changelog is accurate
- [ ] Breaking changes documented
- [ ] Migration guide (if major)

### During Release
- [ ] Version bumped correctly
- [ ] Changelog updated
- [ ] Git tag created
- [ ] Pushed to remote

### After Release
- [ ] Deployment successful
- [ ] Smoke tests pass
- [ ] Monitoring shows healthy
- [ ] Release notes published
- [ ] Team notified

## Example Release Session

```bash
# Ensure clean state
git checkout main
git pull origin main

# Validate
check --strict

# Preview release
ship minor --dry-run

# Ship it
ship minor

# Deploy to staging first
ship minor --deploy staging

# After verification, deploy to production
./deploy.sh production
```

## Tips

1. **Always dry-run first** - Preview changes before committing
2. **Ship from main** - Never release from feature branches
3. **Monitor after deploy** - Watch for issues
4. **Have rollback ready** - Know how to revert quickly
5. **Communicate releases** - Keep team informed
