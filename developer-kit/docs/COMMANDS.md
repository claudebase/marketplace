# Commands Guide

Commands are the **interface layer** in Developer Kit's skill-centric architecture. They are thin wrappers (20-80 lines) that route user intent and delegate to skills.

The Developer Kit includes 21 commands organized by category.

---

## How Commands Work

Commands are invoked directly and delegate to skills:

```
analyze --mode security     # Delegates to: security skill
check --strict              # Delegates to: devops skill
ship minor                  # Delegates to: orchestration skill
```

Commands:

- Parse arguments and flags
- Delegate to skills or agents
- Provide structured workflow entry points

---

## Command Categories

| Category                                 | Commands | Purpose                         |
| ---------------------------------------- | -------- | ------------------------------- |
| [Development](#development-commands)     | 8        | Build, test, review workflows   |
| [Planning](#planning-commands)           | 4        | Estimation, workflows, analysis |
| [Release](#release-commands)             | 5        | Versioning, deployment          |
| [Documentation](#documentation-commands) | 2        | Indexing, recommendations       |
| [Session](#session-commands)             | 2        | Orchestration, reflection       |

---

## Development Commands

### start

**Purpose**: Initialize feature development with branch, context, and tracking.

**Usage**:

```
start <branch-name>
```

**What It Does**:

1. Creates new git branch
2. Sets up session context file
3. Initializes todo list
4. Prepares development environment

**Example**:

```
start feature/user-authentication
```

**Output**:

```
✓ Created branch: feature/user-authentication
✓ Session context initialized
✓ Todo list ready

Ready to develop! Use 'check' to validate, 'prep-pr' when done.
```

---

### analyze

**Purpose**: Unified code analysis with mode selection.

**Usage**:

```
analyze [--mode <type>] [--target <path>] [--output json|text] [--severity <level>]
```

**Modes**:

| Mode              | Focus                     | Skill/Agent         |
| ----------------- | ------------------------- | ------------------- |
| `broad` (default) | Full analysis             | analyze skill       |
| `security`        | OWASP, vulnerabilities    | security skill      |
| `perf`            | Bottlenecks, optimization | performance skill   |
| `quality`         | Test coverage, strategy   | quality skill       |
| `review`          | PR/change review          | code-reviewer agent |
| `explore`         | Deep feature tracing      | code-explorer agent |

**Options**:

- `--target <path>`: Specific file or directory (default: `.`)
- `--output <format>`: text, json, markdown
- `--severity <level>`: info, warning, error, critical
- `--deep`: Enable deep analysis

**Examples**:

```bash
# Full codebase analysis
analyze

# Security audit of auth module
analyze --mode security --target src/auth/

# Performance check with JSON output
analyze --mode perf --output json

# Deep exploration of a feature
analyze --mode explore --target src/notifications/ --deep
```

---

### check

**Purpose**: Comprehensive project validation (lint, type-check, test, security).

**Usage**:

```
check [--strict] [--fix] [--skip <checks>]
```

**Options**:

- `--strict`: Fail on warnings
- `--fix`: Auto-fix where possible
- `--skip <checks>`: Skip specific checks (lint, types, test, security)

**Validation Steps**:

1. Lint check
2. Type checking
3. Test execution
4. Security scan

**Example**:

```
check --strict
```

**Output**:

```
Running validation...

[1/4] Lint check...
      ✓ No lint errors

[2/4] Type check...
      ✓ No type errors

[3/4] Running tests...
      ✓ 42 tests passed

[4/4] Security scan...
      ✓ No vulnerabilities found

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
All checks passed!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

### build

**Purpose**: Build, compile, and package projects.

**Usage**:

```
build [--target <env>] [--watch]
```

**Options**:

- `--target <env>`: Build target (dev, staging, production)
- `--watch`: Watch mode for development

**Detected Build Systems**:

- npm/yarn/pnpm (Node.js)
- pip/poetry/uv (Python)
- cargo (Rust)
- go build (Go)
- make (C/C++)

**Example**:

```
build --target production
```

---

### git

**Purpose**: Git operations with smart commit messages.

**Usage**:

```
git <operation> [options]
```

**Operations**:

- `status`: Show working tree status
- `diff`: Show changes
- `commit`: Commit with generated message
- `push`: Push to remote
- `pull`: Pull from remote

**Example**:

```
git commit
```

Generates conventional commit message based on changes.

---

### cleanup

**Purpose**: Code cleanup and dead code removal.

**Usage**:

```
cleanup [--target <path>] [--dry-run]
```

**What It Cleans**:

- Unused imports
- Dead code
- Commented-out code
- Unused variables
- Empty files

**Example**:

```
cleanup --dry-run  # Preview changes
cleanup            # Apply cleanup
```

---

### code-review

**Purpose**: Comprehensive code review for PRs or local changes.

**Usage**:

```
code-review [PR-number|--local] [--strict]
```

**Options**:

- `PR-number`: Review specific PR
- `--local`: Review local changes (default)
- `--strict`: 90% confidence threshold

**Example**:

```
code-review 123        # Review PR #123
code-review --strict   # Strict local review
```

**Delegates to**: code-reviewer agent

---

### feature-dev

**Purpose**: Guided feature development with 7-phase workflow.

**Usage**:

```
feature-dev [feature-description]
```

**Phases**:

1. Requirements gathering
2. Design and planning
3. Implementation
4. Testing
5. Documentation
6. Review
7. Integration

**Example**:

```
feature-dev "Add user notification preferences"
```

---

## Planning Commands

### workflow

**Purpose**: Generate implementation workflows from PRDs and specifications.

**Usage**:

```
workflow <prd-file|description> [--strategy <type>] [--depth <level>] [--parallel]
```

**Options**:

- `--strategy`: systematic, agile, enterprise
- `--depth`: shallow, normal, deep
- `--parallel`: Enable parallel task generation

**Example**:

```
workflow docs/PRD.md --strategy systematic --depth deep
```

**Output**: Structured task breakdown with dependencies

---

### estimate

**Purpose**: Effort estimation for tasks, features, or projects.

**Usage**:

```
estimate <task-description> [--detail <level>]
```

**Options**:

- `--detail`: low, medium, high

**Output**:

- Complexity assessment
- Risk factors
- Task breakdown
- Effort ranges (optimistic/likely/pessimistic)

**Example**:

```
estimate "implement OAuth2 authentication"
```

---

### business-panel

**Purpose**: Multi-expert business analysis.

**Usage**:

```
business-panel <topic|document> [--mode <type>]
```

**Modes**:

- `discussion`: Multiple perspectives
- `debate`: Contrasting viewpoints
- `socratic`: Guided inquiry

**Example**:

```
business-panel "market entry strategy for AI tools" --mode discussion
```

**Delegates to**: business-panel-experts agent

---

### spec-panel

**Purpose**: Specification review and validation.

**Usage**:

```
spec-panel <spec-file> [--focus <area>]
```

**Review Areas**:

- Completeness
- Consistency
- Feasibility
- Edge cases
- Security implications

**Example**:

```
spec-panel docs/api-spec.md --focus security
```

---

## Release Commands

### ship

**Purpose**: Ship a release with full automation.

**Usage**:

```
ship <version|major|minor|patch> [options]
```

**Options**:

- `--dry-run`: Preview without executing
- `--no-tag`: Skip git tag
- `--no-push`: Skip pushing to remote
- `--deploy <env>`: Deploy after release
- `--prerelease <id>`: Create prerelease (alpha, beta, rc)

**What It Does**:

1. Pre-flight checks (clean tree, correct branch, up to date)
2. Version calculation
3. Version bump in detected files
4. Changelog generation
5. Git commit and tag
6. Push to remote
7. Optional deployment

**Examples**:

```bash
ship patch              # 1.2.3 → 1.2.4
ship minor              # 1.2.3 → 1.3.0
ship major              # 1.2.3 → 2.0.0
ship 2.0.0              # Explicit version
ship minor --dry-run    # Preview
ship minor --deploy staging
```

**Output**:

```
Shipping release...

[1/6] Pre-flight checks...
      ✓ Working tree clean
      ✓ On branch: main
      ✓ Up to date with origin/main

[2/6] Calculating version...
      Current: 1.2.3 → New: 1.3.0

[3/6] Updating version files...
      ✓ package.json updated

[4/6] Generating changelog...
      ✓ CHANGELOG.md updated

[5/6] Git operations...
      ✓ Committed: chore(release): v1.3.0
      ✓ Tag created: v1.3.0
      ✓ Pushed to origin

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Release v1.3.0 shipped!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

### release

**Purpose**: Semantic versioning and release automation.

**Usage**:

```
release [--type <type>] [--prerelease <id>]
```

**Types**: major, minor, patch

Similar to `ship` but more focused on versioning logic.

---

### changelog

**Purpose**: Generate changelog from git history.

**Usage**:

```
changelog [--from <tag>] [--to <ref>] [--format <type>]
```

**Options**:

- `--from`: Starting tag/commit
- `--to`: Ending ref (default: HEAD)
- `--format`: markdown, json, text

**Conventional Commits**:

- `feat:` → Added
- `fix:` → Fixed
- `docs:` → Documentation
- `refactor:` → Changed
- `BREAKING CHANGE:` → Breaking Changes

**Example**:

```
changelog --from v1.0.0 --to HEAD
```

---

### prep-pr

**Purpose**: Prepare changes for pull request.

**Usage**:

```
prep-pr [--base <branch>] [--draft]
```

**What It Does**:

1. Validate changes (run `check`)
2. Review changes (run `code-review`)
3. Generate PR description
4. Suggest reviewers

**Output**:

```markdown
## Summary

- Added user authentication endpoints
- Implemented JWT token handling
- Added tests for auth flow

## Test Plan

- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing of login flow

## Checklist

- [x] Code follows project conventions
- [x] Tests added/updated
- [x] Documentation updated
```

---

### migrate

**Purpose**: Database migration management.

**Usage**:

```
migrate <operation> [options]
```

**Operations**:

- `create <name>`: Create new migration
- `up`: Run pending migrations
- `down`: Rollback last migration
- `status`: Show migration status
- `plan`: Plan migration strategy

**Example**:

```
migrate create add-user-preferences
migrate up
migrate status
```

---

## Documentation Commands

### index

**Purpose**: Generate project documentation index.

**Usage**:

```
index [--output <file>] [--depth <level>]
```

**What It Generates**:

- Project structure overview
- Component catalog
- Entry points
- Dependencies

**Example**:

```
index --output docs/INDEX.md
```

---

### recommend

**Purpose**: Get contextual recommendations.

**Usage**:

```
recommend [topic] [--context <path>]
```

**Topics**:

- Libraries and tools
- Patterns and approaches
- Best practices
- Architecture decisions

**Example**:

```
recommend "state management for React"
```

---

## Session Commands

### agent

**Purpose**: Session controller for task orchestration.

**Usage**:

```
agent [task-description]
```

**Capabilities**:

- Multi-phase workflow execution
- Task coordination
- Progress tracking
- Context management

**Example**:

```
agent "implement complete user authentication system"
```

---

### reflect

**Purpose**: Session reflection and review.

**Usage**:

```
reflect [--save <file>]
```

**What It Captures**:

- Session progress
- Decisions made
- Lessons learned
- Next steps

**Example**:

```
reflect --save docs/session/2024-01-15.md
```

---

## Command Patterns

### Workflow Integration

```
start feature-branch     # 1. Initialize
# ... develop ...
check                    # 2. Validate
code-review              # 3. Review
prep-pr                  # 4. Prepare PR
# ... merge PR ...
ship patch               # 5. Release
```

### Analysis Workflow

```
analyze                  # Broad analysis
analyze --mode security  # Security focus
analyze --mode perf      # Performance focus
```

### Release Workflow

```
check --strict           # Validate
changelog                # Generate changelog
ship minor --dry-run     # Preview
ship minor               # Release
```

---

## Adding New Commands

1. Create `commands/<category>/my-command.md`:

```yaml
---
description: "What this command does"
argument-hint: "[--flag <value>] [args]"
delegates-to: skill-name
operation: specific-mode
---
# my-command - Command Title

## Usage
\`\`\`
my-command [options]
\`\`\`
## Options
...
## Examples
...
```

2. Required frontmatter:
   - `description`: What the command does

3. Optional frontmatter:
   - `argument-hint`: Shows in help
   - `delegates-to`: Skill delegation
   - `operation`: Operation mode

4. Validate:

```bash
./scripts/check-frontmatter.sh
```

---

## Quick Reference

| Command       | Purpose         | Common Usage                |
| ------------- | --------------- | --------------------------- |
| `start`       | Begin feature   | `start feature-branch`      |
| `analyze`     | Code analysis   | `analyze --mode security`   |
| `check`       | Validation      | `check --strict`            |
| `build`       | Build project   | `build --target production` |
| `git`         | Git operations  | `git commit`                |
| `cleanup`     | Clean code      | `cleanup --dry-run`         |
| `code-review` | Review changes  | `code-review`               |
| `feature-dev` | Guided dev      | `feature-dev "description"` |
| `workflow`    | Generate tasks  | `workflow spec.md`          |
| `estimate`    | Effort estimate | `estimate "feature"`        |
| `ship`        | Release         | `ship minor`                |
| `changelog`   | Generate log    | `changelog`                 |
| `prep-pr`     | Prepare PR      | `prep-pr`                   |
| `migrate`     | DB migrations   | `migrate up`                |
| `index`       | Generate index  | `index`                     |
| `recommend`   | Get advice      | `recommend "topic"`         |
| `agent`       | Orchestration   | `agent "task"`              |
| `reflect`     | Session review  | `reflect`                   |
