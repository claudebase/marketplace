# Changelog

All notable changes to the Developer Kit plugin will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

---

## [5.4.0] - 2026-01-01

### Changed

- **Skill Token Optimization**: Refactored all 24 SKILL.md files to minimal format (~70% token reduction)
  - Reduced total skill content from ~144,000 bytes to 43,418 bytes
  - Estimated token savings: ~25,000 tokens at startup
  - Average skill size reduced from ~92 lines to 62 lines
  - Moved detailed content to `references/guide.md` files (loaded on-demand)

### Added

- **Reference Guides**: Created 13 new `references/guide.md` files for skills missing detailed documentation
  - a11y, brainstorm, confidence-check, devops, implement, migration, performance
  - research, security, sequential-thinking, test, verify
  - Also added assessment-criteria.md and examples.md for confidence-check skill

- **Optimization Plan**: Added `SKILL-TOKEN-OPTIMIZATION-PLAN.md` documenting the refactoring approach

---

## [5.3.0] - 2026-01-01

### Changed

- **Command Names**: Removed `dk:` prefix from all 21 commands for cleaner invocation
  - Commands now invoked directly: `analyze`, `check`, `ship` instead of `dk:analyze`, etc.
  - Reverts v5.1.0 namespace change based on simplicity preference

- **Documentation**: Updated all docs to reflect skill-centric architecture (v5.2.0 design)
  - `ARCHITECTURE.md` - Added skill-centric hierarchy diagram and component size targets
  - `FRONTMATTER-SPEC.md` - Added emphatic trigger pattern documentation
  - `GETTING-STARTED.md` - Added architecture context and component layer explanations
  - `COMMANDS.md` - Updated with interface layer framing
  - `SKILLS.md` - Added primary business logic layer context
  - `AGENTS.md` - Added orchestration layer context and skill composition explanation

- **Agent Formatting**: Reformatted all 14 agents with consistent markdown structure

### Removed

- Deleted obsolete planning documents:
  - `docs/IMPLEMENTATION-PLAN.md`
  - `docs/MIGRATION-PROGRESS.md`
  - `docs/SKILL-CENTRIC-ARCHITECTURE-REDESIGN.md`
  - `docs/SKILL-DESCRIPTION-UPGRADE-PLAN.md`

---

## [5.2.0] - 2026-01-01

### Changed

- **Skill Descriptions**: Improved skill triggering reliability with stronger, more explicit trigger descriptions
- **Code Quality**: Removed unused imports from Python hook and script files (ruff auto-fix)

### Fixed

- **Agent References**: Moved agent reference patterns to `lib/shared-references/` directory for proper organization
- **Migration Validation**: Phase 6 complete - all validation checks passing

### Added

- **Expertise Fields**: Added `expertise:` frontmatter field to all 14 agents
- **Composable Fields**: Added `composable:` and `mode:` fields to all 24 skills for standardization
- **Skill Evaluation Hook**: New hook for standardized skill trigger pattern evaluation

---

## [5.1.0] - 2025-12-31

### Changed

- **Command Namespace**: Re-added `dk:` prefix to all 21 commands for namespace clarity
  - Commands now appear as `/dk:analyze`, `/dk:build`, `/dk:check`, etc.
  - Distinguishes developer-kit commands from other plugins in autocomplete
  - Reverts v4.0.0 change based on user feedback

- **Additional Agent Migrations**: Migrated 4 agents to <300 lines
  - `code-reviewer`: 696 → 204 lines (70% reduction)
  - `code-explorer`: 617 → 212 lines (66% reduction)
  - `pm-agent`: 536 → 220 lines (59% reduction)
  - `repo-index`: 527 → 199 lines (62% reduction)

- **Command Condensing**: Reduced `analyze.md` from 277 → 148 lines

### Added

- **Agent Reference Files**: Created 6 shared reference files in `agents/references/`
  - `code-review-workflow.md` - PR workflow, focus modes, false positive prevention
  - `code-review-checklists.md` - React, Vue, Express, Go, Python framework checklists
  - `exploration-patterns.md` - Feature trace, architecture, dependency patterns
  - `framework-exploration.md` - Framework-specific exploration guide
  - `pm-session-workflow.md` - PDCA cycle, session lifecycle
  - `repo-indexing.md` - Index templates, strategies

### Fixed

- **Reference Files**: Moved command reference patterns out of `commands/` directory
  - `build-patterns.md`, `cleanup-patterns.md`, `estimate-patterns.md` no longer appear as slash commands
  - Relocated to `lib/shared-references/` (internal use only)

- **Skill Frontmatter**: Added missing `allowed-tools` to `confidence-check` and `sequential-thinking` skills

---

## [5.0.0] - 2025-12-31

### Breaking Changes

- **BREAKING**: Restructured all skills for progressive disclosure pattern
  - SKILL.md files reduced to <100 lines (compact startup)
  - Detailed content moved to `references/` directories
  - References loaded on-demand when skill activates

- **BREAKING**: Restructured all agents for token efficiency
  - Agent files reduced to <300 lines
  - MCP resource tables consolidated to shared references
  - Agent-specific patterns moved to `agents/references/`

### Token Optimization Summary

| Component                   | Before       | After        | Reduction |
| --------------------------- | ------------ | ------------ | --------- |
| Skills (Critical)           | ~8,000 lines | ~1,400 lines | **82%**   |
| Agents (Critical + Warning) | ~8,500 lines | ~2,000 lines | **76%**   |
| Commands (Bloated)          | ~2,200 lines | ~340 lines   | **85%**   |

### Changed

#### Skills Refactored (16 skills)

- `containers` (1,055 → 83 lines)
- `observability` (1,010 → 91 lines)
- `database` (965 → 85 lines)
- `migration` (892 → 88 lines)
- `implement` (811 → 85 lines)
- `devops` (766 → 98 lines)
- `research` (738 → 88 lines)
- `test` (680 → 90 lines)
- `security` (653 → 86 lines)
- `performance` (536 → 81 lines)
- `improve` (564 → 91 lines)
- `explain` (553 → 90 lines)
- `debug` (551 → 91 lines)
- `design` (486 → 86 lines)
- `analyze` (472 → 91 lines)
- `frontend` (445 → 87 lines)

#### Agents Refactored (9 agents)

- `python-expert` (2,457 → 222 lines)
- `observability-engineer` (1,093 → 277 lines)
- `technical-writer` (1,025 → 249 lines)
- `learning-guide` (978 → 254 lines)
- `security-expert` (940 → 210 lines)
- `requirements-analyst` (917 → 200 lines)
- `database-admin` (872 → 192 lines)
- `socratic-mentor` (765 → 188 lines)
- `architect` (710 → 200 lines)

#### Commands Refactored (3 commands)

- `cleanup` (989 → 113 lines)
- `build` (758 → 113 lines)
- `estimate` (453 → 112 lines)

### Added

#### Shared Reference Infrastructure

- `lib/shared-references/mcp-resources.md` - Consolidated MCP library tables
- `lib/shared-references/tool-integration-patterns.md` - Common tool patterns

#### Agent Reference Files

- `agents/references/python-patterns.md` - FastAPI, Django, testing patterns
- `agents/references/security-patterns.md` - OWASP fixes, auth patterns
- `agents/references/requirements-patterns.md` - PRD templates, user stories
- `agents/references/database-patterns.md` - Schema, migration patterns
- `agents/references/socratic-patterns.md` - Question techniques
- `agents/references/architect-patterns.md` - C4, ADR templates
- `agents/references/learning-patterns.md` - Tutorial patterns
- `agents/references/technical-writing-patterns.md` - Doc templates
- `agents/references/observability-patterns.md` - Logging, metrics

#### Command Reference Files

- `commands/references/cleanup-patterns.md` - Language examples, tools
- `commands/references/build-patterns.md` - Build systems, CI configs
- `commands/references/estimate-patterns.md` - Estimation methods

### Migration Notes

- All functionality preserved - content moved to references, not deleted
- Reference files loaded automatically when skills/agents activate
- Existing workflows and integrations unchanged

---

## [4.0.0] - 2025-12-29

### Breaking Changes

- **BREAKING**: Removed `/dk:` prefix from all commands
  - Commands are now invoked directly by name
  - Example: `/dk:analyze` is now `analyze`
  - Example: `/dk:start` is now `start`

### Migration Guide

To update your scripts and documentation:

| Old Format        | New Format    |
| ----------------- | ------------- |
| `/dk:analyze`     | `analyze`     |
| `/dk:start`       | `start`       |
| `/dk:check`       | `check`       |
| `/dk:prep-pr`     | `prep-pr`     |
| `/dk:ship`        | `ship`        |
| `/dk:git`         | `git`         |
| `/dk:code-review` | `code-review` |

All 21 commands follow this pattern - simply remove the `/dk:` prefix.

### Changed

- Updated all documentation to reflect new command syntax
- Updated hooks.json SessionStart message
- Updated all template files

> **Note**: Historical changelog entries below retain the original `/dk:` syntax for accuracy.

---

## [3.5.0] - 2025-12-29

### Added

#### New Skills (2)

- **`test`** - Comprehensive test execution and analysis skill
  - Framework detection (Jest, Vitest, Pytest, Go, Rust, RSpec, PHPUnit)
  - Coverage analysis and reporting
  - Test gap identification and suggestions
  - E2E testing via Playwright MCP integration
  - References: framework-detection.md, coverage-analysis.md, e2e-patterns.md

- **`a11y`** - Accessibility audit and WCAG 2.1 AA compliance skill
  - WCAG 2.1 Level AA checklist validation
  - Color contrast analysis
  - Keyboard navigation testing
  - Screen reader compatibility guidance
  - References: wcag-checklist.md, testing-tools.md, common-fixes.md

#### MCP Server Integrations (2)

- **GitHub MCP** - Direct GitHub API integration
  - Issue creation and management
  - Pull request operations
  - Commit history access
  - Code search across repositories
  - Requires `GITHUB_TOKEN` environment variable

- **Memory MCP** - Cross-session knowledge persistence
  - Store and retrieve patterns, decisions, and learnings
  - Enables PM Agent knowledge accumulation
  - Persistent context across Claude Code sessions

#### Hook Scripts

- **`run-affected-tests.sh`** - Optional PostToolUse hook for running affected tests
  - Detects test files for modified source files
  - Supports JS/TS, Python, Go, Rust, Ruby
  - Returns JSON status per Claude Code spec

### Changed

- **`devops` skill** - Added GitHub MCP tools for repository operations
- **`research` skill** - Added GitHub MCP tools for issue/PR research
- **`pm-agent`** - Enhanced with Memory MCP for knowledge persistence
  - New memory storage strategy documentation
  - Cross-session pattern retention

### Component Counts

- Skills: 22 → 24 (+2: test, a11y)
- MCP Servers: 5 → 7 (+2: github, memory)
- Reference Files: 69 → 76 (+7)

---

## [3.4.0] - 2025-12-29

### Added

#### New Commands (4)

- **`/dk:start`** - Feature development initialization with branch setup, session context, and task tracking
- **`/dk:prep-pr`** - Pull request preparation with validation, code review, and PR description generation
- **`/dk:ship`** - Release shipping with version bump, changelog generation, and git operations
- **`/dk:analyze`** - Unified analysis command with mode selection (broad, security, perf, quality, review, explore)

#### Session Management

- **SessionStart hook** - Automatic context restoration from `docs/session/current-context.md`
- **Stop hook** - Automatic session state persistence to `docs/session/last-session.md`
- **`restore-session-context.sh`** - Hook script for context restoration
- **`save-session-state.sh`** - Hook script for state persistence

#### Workflow Documentation

- **`docs/workflows/README.md`** - Workflow overview and quick reference
- **`docs/workflows/feature-development.md`** - Complete feature lifecycle guide
- **`docs/workflows/bug-fixing.md`** - Tiered debugging workflow
- **`docs/workflows/code-review.md`** - Comprehensive review process
- **`docs/workflows/release.md`** - Version and deployment guide
- **`docs/workflows/session-management.md`** - PM Agent PDCA workflow

### Changed

- **hooks.json** - Added SessionStart context restoration and Stop state persistence
- **SessionStart message** - Now shows all component counts and quick-start hint

### Developer Experience

- Quick-start workflow: `/dk:start` → develop → `/dk:prep-pr` → `/dk:ship`
- Automatic session context across Claude Code sessions
- Comprehensive workflow documentation for common development processes

---

## [3.3.1] - 2025-12-29

### Added

- **`/dk:check` command** - Unified validation command for lint, type-check, test, and security scan
- **`skills/README.md`** - Logical grouping reference for all 22 skills with categories

### Changed

- **Hook scripts** - Now return proper JSON responses per Claude Code spec
  - `format-file.sh` - Returns JSON with formatting status
  - `security_reminder_hook.py` - Returns JSON with security warnings
- **Skill descriptions** - Clarified boundaries between overlapping skills:
  - `security` - Explicitly notes READ-ONLY and points to security-expert agent
  - `document` - Differentiates from explain skill and technical-writer agent
  - `explain` - Explicitly notes READ-ONLY and educational focus
- **`security-expert` agent** - Description clarifies it CAN modify code (unlike security skill)

### Fixed

- SessionStart message now shows command count (17)

---

## [3.3.0] - 2025-12-28

### Added

#### Content Optimization

- **security-common.md** - Shared security reference consolidating OWASP Top 10, authentication patterns, and secure coding examples
- **Templates** - Added skill, agent, and command templates in `templates/` directory

#### CI/CD Enhancements

- **validate-skill-descriptions.sh** - Validates skills have name, description, and trigger phrases
- **validate-agent-fields.sh** - Validates agents have required frontmatter fields
- **validate-references.sh** - Validates all skill reference file links exist
- Added Python syntax validation to CI workflow

### Changed

- **Simplified commands** - `estimate` and `code-review` commands now reference skills/agents for methodology (reduced duplication ~50%)
- **Security skill** - Updated to reference security-common.md, reduced content duplication with security-expert agent
- **Security-expert agent** - Simplified OWASP table, references security-common.md for patterns

### Removed

- **UserPromptSubmit hook** - Removed no-op hook (just ran `true`)
- **color field** - Removed non-standard `color: red` field from code-reviewer agent

### Fixed

- **security_reminder_hook.py** - Fixed misleading comment about exit codes (referenced PreToolUse but runs on PostToolUse)
- **FRONTMATTER-SPEC.md** - Documented plugin extension fields (skills, color, delegates-to, operation)

---

## [3.2.0] - 2025-12-28

### Changed

#### Skill Consolidation (27 → 22 skills)

- **BREAKING**: Consolidated debugging skills into unified `debug` skill
  - `troubleshoot` → `debug` (Tier 1: quick fixes)
  - `systematic-debugging` → `debug` (Tier 2: systematic investigation)
  - `root-cause` → `debug` (Tier 3: deep RCA)
- **BREAKING**: Consolidated verification skills into unified `verify` skill
  - `verification` → `verify` (--complete mode)
  - `self-review` → `verify` (--review mode)
- Simplified code review chain from 3 layers to 2
  - Removed `code-review` skill (methodology merged into `code-reviewer` agent)
- Clarified analysis skill boundaries (analyze, security, performance, quality)
  - Added explicit "Boundary Clarification" sections
  - Clear handoff patterns between specialized skills

### Removed

- Placeholder hooks (`completion_validator.py`, `subagent_validator.py`)
- Archive directory (`.archive/`)
- Hook events: `Stop`, `SubagentStop` (were no-op implementations)
- Skills: `troubleshoot`, `systematic-debugging`, `root-cause`, `verification`, `self-review`, `code-review`

### Added

- CI workflow for plugin validation (`.github/workflows/validate-plugin.yml`)
- Frontmatter validation script (`scripts/check-frontmatter.sh`)
- Frontmatter specification (`docs/FRONTMATTER-SPEC.md`)
- Tiered debugging methodology in `debug` skill with references
- Mode-based verification in `verify` skill with references

### Fixed

- Non-standard frontmatter fields documented and cleaned
- Cross-references updated throughout codebase
- Skill boundary overlaps clarified with explicit handoffs
- Hook events reduced from 6 to 4 (removed no-ops)

### Migration Guide

If you have scripts or prompts referencing old skill names:

| Old                    | New                     |
| ---------------------- | ----------------------- |
| `troubleshoot`         | `debug`                 |
| `systematic-debugging` | `debug`                 |
| `root-cause`           | `debug`                 |
| `verification`         | `verify`                |
| `self-review`          | `verify`                |
| `code-review` (skill)  | `code-reviewer` (agent) |

---

## [3.1.0] - 2025-12-28

### Added

#### Documentation

- **CONTRIBUTING.md** - Comprehensive guide for extending the plugin
- **skills/TRIGGER-REFERENCE.md** - Quick reference for skill activation phrases

#### Hook Events (3 new)

- **Stop** - `completion_validator.py` validates task completion
- **SubagentStop** - `subagent_validator.py` validates subagent completion
- **UserPromptSubmit** - Ready for context injection

#### Research Skill Enhancement

- **Documentation Mode** (`--docs`) - Specialized for library/framework docs
- Merged `docs-seeker` functionality into `research` skill
- Added `docs-sources.md` and `docs-workflows.md` references

### Changed

#### Command Delegation Pattern (8 commands converted)

Commands now delegate to skills for DRY implementation:

- `/dk:code-review` → code-review skill
- `/dk:estimate` → orchestration skill
- `/dk:changelog` → document skill
- `/dk:index` → research skill
- `/dk:recommend` → research skill
- `/dk:feature-dev` → orchestration skill
- `/dk:migrate` → migration skill
- `/dk:reflect` → document skill

#### Skill Descriptions

- Updated all 26 skills with explicit "Activates for:" trigger phrases
- Consistent format across all skills for better activation accuracy

#### Hook System

- Hook events utilized: 3/8 → 6/8 (75%)
- Updated SessionStart message to v3.1.0

### Removed

- **docs-seeker** skill - Merged into research skill with `--docs` mode

### Metrics

| Metric                        | Before     | After       |
| ----------------------------- | ---------- | ----------- |
| Skills                        | 27         | 26          |
| Commands using delegation     | 3/16 (19%) | 11/16 (69%) |
| Hook events utilized          | 3/8 (38%)  | 6/8 (75%)   |
| Skills with explicit triggers | ~50%       | 100%        |

---

## [3.0.0] - 2025-12-28

### Changed

#### Major Consolidation

- **Unified Architect** - Consolidated 5 architect agents into 1 with domain modes
  - Archived: code-architect, backend-architect, frontend-architect, system-architect, devops-architect
- **Systematic Debugging** - Merged 4 debugging skills into unified methodology
  - Archived: defense-in-depth, root-cause-tracing, verification-before-completion
- **Flat Skill Structure** - All skills at root level for better discoverability

### Documentation

- Updated for v3.0.0 release

---

## [2.0.0] - 2025-12-25

### Added

#### New Skills (4)

- **observability** - Logging, monitoring, alerting, and dashboard patterns
  - References: logging-patterns, monitoring-setup, alerting-strategies, dashboard-templates
- **database** - Schema design, query optimization, and migration management
  - References: schema-design, query-optimization, migration-patterns, connection-management
- **migration** - Zero-downtime migrations and API versioning strategies
  - References: database-migration-patterns, api-versioning, zero-downtime
- **containers** - Docker, Kubernetes, and Helm patterns
  - References: dockerfile-patterns, compose-patterns, kubernetes-patterns, helm-patterns

#### New Agents (3)

- **database-admin** - Database schema, query optimization, and migration specialist
- **observability-engineer** - Logging, metrics, alerting, and dashboard specialist
- **security-expert** - Security audits, authentication, and OWASP compliance

#### New Commands (3)

- `/dk:release` - Semantic versioning and release automation
- `/dk:changelog` - Generate changelogs from git commits
- `/dk:migrate` - Database migration management

#### Templates (10 new files)

- **GitHub Actions**: node-ci.yml, python-ci.yml, docker-build.yml, release.yml
- **Docker**: node.Dockerfile, python.Dockerfile, docker-compose.dev.yml
- **Kubernetes**: deployment.yaml (full stack with HPA, PDB, Ingress)
- **ADR**: template.md, example-database-selection.md

#### Reference Material Expansion

- **devops**: container-patterns.md, github-actions.md, gitlab-ci.md
- **security-engineer**: security-headers.md, secrets-management.md
- **performance-engineer**: caching-strategies.md, database-performance.md
- **quality-engineer**: api-testing.md
- **design**: event-sourcing.md

#### Infrastructure

- **Hooks System** - Automated workflows via hooks.json
  - PostToolUse: Auto-format code after Write/Edit
  - PreToolUse: Block dangerous Bash commands
  - SessionStart: Display welcome message
- **LSP Configuration** - Language server setup in .lsp.json
  - TypeScript, Python, JSON, YAML, Markdown servers
- **Environment Variables** - .env.example template
- **Git Ignore** - Comprehensive .gitignore
- **Validation Scripts** - validate-components.sh, test-components.sh

### Changed

- Reorganized commands into logical subdirectories:
  - `commands/dk/session/` - agent.md, reflect.md
  - `commands/dk/development/` - build.md, cleanup.md, git.md, task.md
  - `commands/dk/documentation/` - index.md, recommend.md
  - `commands/dk/planning/` - business-panel.md, estimate.md, spec-panel.md, workflow.md
  - `commands/dk/release/` - release.md, changelog.md, migrate.md
- Updated plugin.json version to 2.0.0
- Expanded README.md with comprehensive documentation

### Security

- **Fixed**: Removed hardcoded Tavily API key from .mcp.json
- **Added**: Environment variable support (`${TAVILY_API_KEY}`)
- **Added**: PreToolUse hook to block dangerous commands (rm -rf /, etc.)

### Documentation

- Updated README.md with all v2.0.0 features
- Created refactoring checklist and baseline documentation
- Added 60+ reference files across all skills

## [1.8.0] - 2025-12-24

### Initial Release

- 18 Skills for development workflows
- 12 Agents for domain expertise
- 12 Commands via `/dk:` namespace
- 5 MCP Server integrations
- Core plugin infrastructure

---

## Summary

| Version | Skills | Agents | Commands | Templates | Reference Files |
| ------- | ------ | ------ | -------- | --------- | --------------- |
| 2.0.0   | 22     | 15     | 15       | 10        | 60+             |
| 1.8.0   | 18     | 12     | 12       | 0         | 54              |

[2.0.0]: https://github.com/claudebase/marketplace/compare/v1.8.0...v2.0.0
[1.8.0]: https://github.com/claudebase/marketplace/releases/tag/v1.8.0
