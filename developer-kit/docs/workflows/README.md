# Developer Kit Workflows

Step-by-step guides for common development processes using Developer Kit commands, skills, and agents.

## Quick Reference

| Workflow | Entry Point | Description |
|----------|-------------|-------------|
| [Feature Development](./feature-development.md) | `start` | Complete feature lifecycle |
| [Bug Fixing](./bug-fixing.md) | `debug` skill | Tiered debugging approach |
| [Code Review](./code-review.md) | `code-review` | Comprehensive review process |
| [Release](./release.md) | `ship` | Version and deployment |
| [Session Management](./session-management.md) | `reflect` | Context and knowledge |

## Workflow Quick Commands

```bash
# Start new feature
start my-feature

# Validate before PR
check --fix

# Prepare PR
prep-pr

# Ship release
ship minor
```

## Workflow Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    DEVELOPMENT LIFECYCLE                     │
└─────────────────────────────────────────────────────────────┘

  start                     Start feature branch
      │
      ▼
  brainstorm ─────────────────► Gather requirements
      │
      ▼
  design ─────────────────────► Plan architecture
      │
      ▼
  implement ──────────────────► Build feature
      │
      ▼
  check ──────────────────► Validate (lint, test, security)
      │
      ▼
  prep-pr ────────────────► Review and prepare PR
      │
      ▼
  [PR Review & Merge]
      │
      ▼
  ship ───────────────────► Release version
```

## When to Use Each Workflow

### Feature Development
Use when:
- Starting a new feature or enhancement
- Building new functionality from scratch
- Need structured approach from requirements to deployment

### Bug Fixing
Use when:
- Something is broken and needs fixing
- Investigating unexpected behavior
- Performance issues need diagnosis

### Code Review
Use when:
- Preparing changes for team review
- Reviewing someone else's PR
- Need comprehensive quality assessment

### Release
Use when:
- Ready to ship a new version
- Need to bump version numbers
- Creating release tags and changelogs

### Session Management
Use when:
- Resuming work after a break
- Want to capture learnings
- Need to track progress over time

## Integration with Skills

Each workflow leverages multiple Developer Kit skills:

| Workflow | Primary Skills |
|----------|----------------|
| Feature Development | brainstorm, design, implement, verify |
| Bug Fixing | debug, analyze, improve |
| Code Review | security, performance, quality |
| Release | devops, document |
| Session Management | pm-agent skills |

## Best Practices

1. **Always start with `start`** - Sets up proper branch, context, and tracking
2. **Run `check` before PRs** - Catches issues early
3. **Use `prep-pr --create`** - Automates PR creation with comprehensive description
4. **Let PM Agent track progress** - Automatic session management captures learnings
5. **Ship with confidence** - `ship` validates before releasing
