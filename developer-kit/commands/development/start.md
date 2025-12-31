---
name: dk:start
description: "Start new feature development: create branch, setup todos, initialize session tracking"
argument-hint: "<feature-name> [--no-branch] [--from <branch>] [--type feature|bugfix|hotfix]"
delegates-to: orchestration
operation: feature-start
---

# start - Feature Development Starter

Initialize a new feature development workflow with proper setup.

## Usage

```
start <feature-name> [options]
```

## Arguments

| Argument       | Required | Description                                |
| -------------- | -------- | ------------------------------------------ |
| `feature-name` | Yes      | Name for the feature (used in branch name) |

## Options

| Option            | Default | Description                                    |
| ----------------- | ------- | ---------------------------------------------- |
| `--no-branch`     | false   | Skip git branch creation                       |
| `--from <branch>` | main    | Base branch to create from                     |
| `--type <type>`   | feature | Branch type: feature, bugfix, hotfix, refactor |

## What This Does

### 1. Git Branch Setup

```bash
git checkout <base-branch>
git pull origin <base-branch>
git checkout -b <type>/<feature-name>
# e.g., feature/user-notifications
```

### 2. Session Context Initialization

Creates or updates `docs/session/current-context.md`:

```markdown
# Current Context: <feature-name>

## Goal

[To be defined - use brainstorm skill to clarify]

## Status

- [x] Branch created: <type>/<feature-name>
- [ ] Requirements gathered
- [ ] Design completed
- [ ] Implementation started
- [ ] Tests written
- [ ] Documentation updated
- [ ] PR ready

## Started

Date: YYYY-MM-DD HH:MM
Base: <base-branch>
```

### 3. TodoWrite Initialization

Sets up initial task list:

```
1. [ ] Gather requirements (brainstorm skill)
2. [ ] Design solution (design skill)
3. [ ] Implement feature (implement skill)
4. [ ] Write tests (quality + test skills)
5. [ ] Update documentation (document skill)
6. [ ] Verify completion (verify skill)
7. [ ] Prepare PR (prep-pr)
```

### 4. PM Agent Activation

Enables session tracking via pm-agent for:

- Progress documentation in `docs/session/`
- Mistake capture in `docs/mistakes/`
- Pattern extraction to `docs/patterns/`

## Examples

```bash
# Start a new feature
start user-notifications

# Start a bugfix from specific branch
start login-fix --type bugfix --from release/v2.0

# Start without creating a branch (already on correct branch)
start api-refactor --no-branch

# Start a hotfix
start security-patch --type hotfix
```

## Output

```
Starting feature: user-notifications

[1/4] Git setup...
      ✓ Switched to main
      ✓ Pulled latest changes
      ✓ Created branch: feature/user-notifications

[2/4] Session context...
      ✓ Created docs/session/current-context.md

[3/4] Task list...
      ✓ Initialized 7 tasks in TodoWrite

[4/4] Session tracking...
      ✓ PM Agent ready for documentation

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Feature Ready: user-notifications
Branch: feature/user-notifications
Session: docs/session/current-context.md
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Next steps:
1. Run brainstorm to gather requirements
2. Use estimate to assess complexity
3. Run design skill for architecture planning
```

## Workflow Integration

```
start <name>     ←── You are here
    ↓
brainstorm           # Gather requirements
    ↓
design               # Plan architecture
    ↓
implement            # Build feature
    ↓
check            # Validate
    ↓
prep-pr          # Prepare PR
    ↓
ship             # Release
```

## Session Files Created

```
docs/
├── session/
│   ├── current-context.md    # Current feature context
│   └── last-session.md       # Previous session summary
├── temp/                     # PDCA working files
├── patterns/                 # Successful patterns
└── mistakes/                 # Lessons learned
```

## Boundaries

**Will:**

- Create feature branch from specified base
- Initialize session tracking files
- Set up TodoWrite with standard workflow
- Provide clear next steps

**Will Not:**

- Start implementation without requirements
- Skip branch creation in shared repos (use --no-branch explicitly)
- Override existing session context without confirmation
