---
name: release
description: "Automate semantic versioning, changelog generation, and release tagging"
argument-hint: "<major|minor|patch> [--dry-run] [--no-tag] [--no-changelog]"
allowed-tools: Read, Write, Edit, Bash, Grep, Glob
---

# release - Release Automation

Automate the release process with semantic versioning, changelog generation, and git tagging.

## Usage

```bash
release patch              # Bump patch version (1.0.0 → 1.0.1)
release minor              # Bump minor version (1.0.0 → 1.1.0)
release major              # Bump major version (1.0.0 → 2.0.0)
release patch --dry-run    # Preview without making changes
release minor --no-tag     # Skip git tag creation
release patch --no-changelog  # Skip changelog update
```

## Workflow

### 1. Pre-Release Checks

Before releasing, verify:
- [ ] All tests pass
- [ ] No uncommitted changes
- [ ] On correct branch (main/master or release branch)
- [ ] No pending PRs that should be included

```bash
# Run these checks
git status
npm test  # or equivalent
git log --oneline -5
```

### 2. Version Bump

Determine version increment based on changes:

| Change Type | Version Bump | Example |
|-------------|--------------|---------|
| Bug fixes, patches | `patch` | 1.0.0 → 1.0.1 |
| New features, backward compatible | `minor` | 1.0.0 → 1.1.0 |
| Breaking changes | `major` | 1.0.0 → 2.0.0 |

Update version in:
- `package.json` (Node.js)
- `pyproject.toml` / `setup.py` (Python)
- `Cargo.toml` (Rust)
- `go.mod` (Go - use git tags)
- Plugin manifest files

### 3. Generate Changelog

Use `changelog` or generate manually:

```markdown
## [1.1.0] - 2025-01-15

### Added
- New feature X
- Support for Y

### Changed
- Improved performance of Z

### Fixed
- Bug in component A
```

### 4. Create Release Commit

```bash
git add -A
git commit -m "chore(release): v1.1.0

- Feature: Added X
- Fix: Resolved Y
- Docs: Updated Z"
```

### 5. Create Git Tag

```bash
git tag -a v1.1.0 -m "Release v1.1.0"
git push origin main --tags
```

## Semantic Versioning Rules

### MAJOR (Breaking Changes)
- Removing public API
- Changing function signatures
- Removing configuration options
- Database schema changes requiring migration

### MINOR (New Features)
- Adding new endpoints/functions
- New optional parameters
- New configuration options
- Backward-compatible enhancements

### PATCH (Bug Fixes)
- Security patches
- Bug fixes
- Documentation updates
- Dependency updates (non-breaking)

## Pre-release Versions

```
1.0.0-alpha.1    # Alpha release
1.0.0-beta.1     # Beta release
1.0.0-rc.1       # Release candidate
```

## Release Checklist

### Before Release
- [ ] All tests passing
- [ ] Documentation updated
- [ ] CHANGELOG.md updated
- [ ] Version numbers updated
- [ ] Breaking changes documented
- [ ] Migration guide (if needed)

### Release Steps
- [ ] Create release commit
- [ ] Create git tag
- [ ] Push to remote
- [ ] Create GitHub release (optional)
- [ ] Publish to package registry (optional)

### After Release
- [ ] Verify deployment
- [ ] Monitor for issues
- [ ] Announce release (if applicable)

## Automation Scripts

### Node.js

```bash
# Using npm version
npm version patch -m "chore(release): v%s"
git push origin main --tags
npm publish
```

### Python

```bash
# Using bump2version
bump2version patch
git push origin main --tags
python -m build
twine upload dist/*
```

## Related Commands

- `changelog` - Generate changelog from commits
- `git` - Git operations
- `build` - Build before release
