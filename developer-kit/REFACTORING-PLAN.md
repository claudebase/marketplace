# Developer-Kit Plugin: Comprehensive Refactoring Plan

**Version**: 1.0.0
**Created**: 2025-12-31
**Based on**: GAP-ANALYSIS-REPORT.md
**Target Version**: 5.0.0

---

## Executive Summary

This plan addresses the critical token efficiency issues identified in the gap analysis. The refactoring will reduce startup token consumption by **~68%** (from ~185,000 to ~60,000 tokens), freeing ~125,000 tokens for productive work.

### Goals

| Goal                     | Metric             | Target              |
| ------------------------ | ------------------ | ------------------- |
| Reduce skill token usage | SKILL.md lines     | <100 lines each     |
| Reduce agent token usage | Agent file lines   | <500 lines each     |
| Reduce command size      | Command file lines | <100 lines each     |
| Improve load times       | Startup tokens     | <60,000 total       |
| Maintain functionality   | Test coverage      | 100% feature parity |

### Timeline Overview

| Phase   | Focus                   | Duration   | Priority |
| ------- | ----------------------- | ---------- | -------- |
| Phase 0 | Preparation & Templates | Day 1      | Critical |
| Phase 1 | Critical Skills (10)    | Days 2-4   | Critical |
| Phase 2 | Warning Skills (6)      | Days 5-6   | High     |
| Phase 3 | Critical Agents (4)     | Days 7-8   | High     |
| Phase 4 | Warning Agents (5)      | Days 9-10  | Medium   |
| Phase 5 | Commands & Cleanup      | Days 11-12 | Medium   |
| Phase 6 | Testing & Validation    | Days 13-14 | Critical |

---

## Phase 0: Preparation & Templates

### 0.1 Create Shared Resources Directory

```bash
mkdir -p lib/shared-references
```

Create the following shared reference files:

#### 0.1.1 `lib/shared-references/mcp-resources.md`

Consolidate all MCP library tables from agents into one shared file:

```markdown
# MCP Resource Library Reference

## Context7 Library IDs

### Python Ecosystem

| Resource    | Library ID                         | Snippets | Use Case      |
| ----------- | ---------------------------------- | -------- | ------------- |
| Python 3.14 | `/websites/devdocs_io_python_3_14` | 21,524   | Core language |
| FastAPI     | `/websites/fastapi_tiangolo`       | 31,710   | Async APIs    |
| Django 6.0  | `/websites/djangoproject_en_6_0`   | 10,667   | Full-stack    |
| Flask       | `/pallets/flask`                   | 500      | Lightweight   |

...

### JavaScript/TypeScript Ecosystem

...

### Database & ORM

...

### DevOps & Infrastructure

...
```

#### 0.1.2 `lib/shared-references/tool-integration-patterns.md`

```markdown
# Common Tool Integration Patterns

## Context7 Workflow

1. Resolve library ID: `mcp__context7__resolve-library-id("library-name")`
2. Query documentation: `mcp__context7__query-docs(libraryId, "specific query")`

## GitHub Search Pattern

...

## Tavily Research Pattern

...
```

### 0.2 Create Skill Template

Create `templates/SKILL-TEMPLATE.md`:

```markdown
---
name: skill-name
description: "Concise description (max 200 chars). Activates for: 'trigger1', 'trigger2', 'trigger3'."
allowed-tools:
  - Read
  - Grep
  - Glob
  - Write
  - Edit
  - Bash
  - Task
---

# Skill Name

Brief 2-3 sentence overview of what this skill does and its core principle.

## When to Use

- Trigger scenario 1
- Trigger scenario 2
- Trigger scenario 3

## When NOT to Use

- Alternative scenario 1 → use `other-skill`
- Alternative scenario 2 → use `another-skill`

## Quick Start

Brief workflow overview (3-5 steps max).

## References

- [Detailed Guide](references/guide.md) - Full behavioral flow and phases
- [Patterns](references/patterns.md) - Implementation patterns
- [Examples](references/examples.md) - Real-world examples
```

**Target**: 50-80 lines maximum

### 0.3 Create Agent Template

Create `templates/AGENT-TEMPLATE.md`:

```markdown
---
name: agent-name
description: Brief description of agent purpose and triggers.
tools: Read, Grep, Glob, Write, Edit, Bash, Task
model: sonnet
permissionMode: default
skills: skill1, skill2
---

# Agent Name

## Purpose

2-3 sentences describing the agent's role and expertise.

## Triggers

- Trigger scenario 1
- Trigger scenario 2
- Trigger scenario 3

## Behavioral Guidelines

### Core Principles

- Principle 1
- Principle 2
- Principle 3

### Workflow

1. Step 1
2. Step 2
3. Step 3

## Tool Usage

For MCP resource library IDs, see [MCP Resources](../lib/shared-references/mcp-resources.md).

### Primary Tools

- **Context7**: Documentation lookup
- **GitHub**: Pattern research
- **Sequential Thinking**: Complex reasoning

## Quality Standards

- Standard 1
- Standard 2
- Standard 3
```

**Target**: 200-400 lines maximum

### 0.4 Create Command Template

Create `templates/COMMAND-TEMPLATE.md`:

````markdown
---
name: command-name
description: "Brief description of what command does"
argument-hint: "[target] [--options]"
delegates-to: skill-name
---

# Command Name

Brief description.

## Usage

```bash
/developer-kit:command-name [arguments]
```
````

## Arguments

| Argument | Description               | Default |
| -------- | ------------------------- | ------- |
| target   | Target path or identifier | `.`     |
| --option | Option description        | value   |

## Examples

```bash
# Example 1
/developer-kit:command-name src/

# Example 2
/developer-kit:command-name --option value
```

## See Also

- Related skill: `skill-name`
- Related command: `/developer-kit:other-command`

````

**Target**: 50-80 lines maximum

---

## Phase 1: Critical Skills Refactoring

### Priority Order (by token impact)

| Rank | Skill | Current Lines | Target Lines | Reduction |
|------|-------|---------------|--------------|-----------|
| 1 | containers | 1,055 | 80 | 92% |
| 2 | observability | 1,010 | 80 | 92% |
| 3 | database | 965 | 80 | 92% |
| 4 | migration | 892 | 80 | 91% |
| 5 | implement | 811 | 80 | 90% |
| 6 | devops | 766 | 80 | 90% |
| 7 | research | 738 | 80 | 89% |
| 8 | test | 680 | 80 | 88% |
| 9 | security | 653 | 80 | 88% |
| 10 | performance | 536 | 80 | 85% |

### 1.1 Refactor `containers` Skill (1,055 → 80 lines)

#### Step 1: Create Reference Files

Create `skills/containers/references/guide.md`:
```markdown
# Containers Skill - Detailed Guide

## Behavioral Flow
[Move ASCII diagram here]

## Phase 1: ANALYZE
[Move detailed instructions here]

## Phase 2: RESEARCH
[Move MCP examples here]

## Phase 3: DESIGN
[Move design decisions here]

## Phase 4: IMPLEMENT
[Move implementation patterns here]

## Phase 5: VALIDATE
[Move validation steps here]
````

#### Step 2: Update Existing Reference Files

Ensure these exist in `skills/containers/references/`:

- `dockerfile-patterns.md` - Dockerfile best practices
- `compose-patterns.md` - Docker Compose patterns
- `kubernetes-patterns.md` - K8s manifest patterns
- `helm-patterns.md` - Helm chart patterns

#### Step 3: Rewrite SKILL.md

Replace `skills/containers/SKILL.md` with:

```markdown
---
name: containers
description: "Create Dockerfiles, compose configs, and Kubernetes manifests. Activates for: 'Dockerfile', 'docker compose', 'containerize', 'K8s', 'Helm chart', 'pod config'."
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
  - Task
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  - mcp__github__search_code
  - mcp__github__get_file_contents
  - mcp__tavily__tavily-search
  - mcp__sequential-thinking__sequentialthinking
---

# Containers Skill

Create optimized Dockerfiles, development-friendly compose configurations, and production-ready Kubernetes manifests with best practices.

**Core Principle**: "Build once, run anywhere. Optimize for security, size, and speed."

## When to Use

- Dockerfile creation ("create Dockerfile", "containerize app")
- Docker Compose ("docker-compose", "multi-container setup")
- Kubernetes ("k8s deployment", "Kubernetes manifest")
- Helm/Kustomize ("create Helm chart", "kustomize overlays")

## When NOT to Use

- CI/CD pipelines → use `devops` skill
- Container security scanning → use `security` skill
- Monitoring setup → use `observability` skill

## Quick Workflow

1. **Analyze** - Read code, identify runtime requirements
2. **Research** - Lookup official docs via Context7
3. **Design** - Plan architecture with Sequential Thinking
4. **Implement** - Write Dockerfile/compose/K8s manifests
5. **Validate** - Build and test locally

## References

- [Detailed Guide](references/guide.md) - Full behavioral flow
- [Dockerfile Patterns](references/dockerfile-patterns.md)
- [Compose Patterns](references/compose-patterns.md)
- [Kubernetes Patterns](references/kubernetes-patterns.md)
- [Helm Patterns](references/helm-patterns.md)
```

#### Step 4: Verify

```bash
wc -l skills/containers/SKILL.md  # Should be ~60-80 lines
```

### 1.2 Refactor `observability` Skill (1,010 → 80 lines)

Follow the same pattern as containers:

#### Step 1: Create `skills/observability/references/guide.md`

Move these sections:

- Behavioral Flow diagram
- Phase 1-5 detailed instructions
- MCP tool examples
- Output templates

#### Step 2: Rewrite SKILL.md

```markdown
---
name: observability
description: "Configure logging, monitoring, alerting, and metrics. Activates for: 'add logging', 'setup monitoring', 'create alerts', 'metrics', 'distributed tracing', 'dashboard'."
allowed-tools:
  - Read
  - Grep
  - Glob
  - Write
  - Edit
  - Bash
  - Task
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  - mcp__github__search_code
  - mcp__tavily__tavily-search
  - mcp__sequential-thinking__sequentialthinking
---

# Observability Skill

Enable system visibility through structured logging, monitoring, alerting, and distributed tracing.

**Core Principle**: "Measure everything, alert on symptoms, debug with traces."

## When to Use

- Logging setup ("add logging", "structured logging", "Pino/Winston")
- Monitoring ("Prometheus metrics", "Datadog setup", "health checks")
- Alerting ("create alerts", "SLO alerts", "PagerDuty")
- Tracing ("distributed tracing", "OpenTelemetry")

## When NOT to Use

- Simple console.log debugging → use `debug` skill
- Security logging → use `security` skill
- Performance optimization → use `performance` skill

## Quick Workflow

1. **Assess** - Identify existing observability gaps
2. **Research** - Lookup tool docs via Context7
3. **Design** - Define SLIs/SLOs with Sequential Thinking
4. **Implement** - Configure logging, metrics, tracing
5. **Validate** - Verify data collection and alerting

## References

- [Detailed Guide](references/guide.md) - Full behavioral flow
- [Logging Patterns](references/logging-patterns.md)
- [Monitoring Setup](references/monitoring-setup.md)
- [Alerting Strategies](references/alerting-strategies.md)
- [Dashboard Templates](references/dashboard-templates.md)
```

### 1.3-1.10 Refactor Remaining Critical Skills

Apply the same pattern to:

| Skill       | Key Content to Move                               |
| ----------- | ------------------------------------------------- |
| database    | Schema patterns, query optimization, ORM examples |
| migration   | Zero-downtime patterns, rollback strategies       |
| implement   | Framework-specific patterns, code templates       |
| devops      | Build/test/git patterns, CI/CD templates          |
| research    | Search strategies, source evaluation              |
| test        | Framework detection, coverage patterns            |
| security    | OWASP checklist, threat modeling                  |
| performance | Profiling guides, optimization patterns           |

---

## Phase 2: Warning Skills Refactoring

### Skills to Refactor (500-700 lines → 80 lines)

| Skill         | Current Lines | Target Lines |
| ------------- | ------------- | ------------ |
| quality       | 601           | 80           |
| orchestration | 599           | 80           |
| document      | 582           | 80           |
| improve       | 564           | 80           |
| explain       | 553           | 80           |
| debug         | 551           | 80           |

### Refactoring Pattern

For each skill:

1. **Identify content to move**:
   - Behavioral flow diagrams
   - Phase-by-phase instructions
   - MCP tool examples
   - Code examples
   - Pattern guides

2. **Create/update reference files**:
   - `references/guide.md` - Main behavioral guide
   - `references/patterns.md` - Implementation patterns
   - `references/examples.md` - Real-world examples

3. **Rewrite SKILL.md** using template

4. **Verify line count**: `wc -l skills/[name]/SKILL.md`

---

## Phase 3: Critical Agents Refactoring

### Priority Order

| Rank | Agent                  | Current Lines | Target Lines | Reduction |
| ---- | ---------------------- | ------------- | ------------ | --------- |
| 1    | python-expert          | 2,457         | 400          | 84%       |
| 2    | observability-engineer | 1,093         | 400          | 63%       |
| 3    | technical-writer       | 1,025         | 400          | 61%       |
| 4    | learning-guide         | 978           | 400          | 59%       |

### 3.1 Refactor `python-expert` Agent (2,457 → 400 lines)

This agent requires the most significant refactoring.

#### Step 1: Extract MCP Resource Tables

The python-expert agent contains ~70 library ID tables. Move ALL to `lib/shared-references/mcp-resources.md`.

**Content to extract**:

- Core Python Resources table
- Web Frameworks table
- Data Validation & Serialization table
- Database & ORM table
- Testing table
- CLI & Tools table
- Data Science table
- Type Checking table
- Security table
- Infrastructure table

#### Step 2: Create Agent-Specific Reference

Create `agents/references/python-patterns.md`:

```markdown
# Python Expert - Implementation Patterns

## FastAPI Patterns

[Move FastAPI-specific patterns here]

## Django Patterns

[Move Django-specific patterns here]

## Testing Patterns

[Move testing patterns here]

## Security Patterns

[Move security patterns here]
```

#### Step 3: Rewrite Agent File

Replace `agents/python-expert.md`:

````markdown
---
name: python-expert
description: Production-ready Python code with SOLID principles. Activates for: Python development, code review, optimization.
tools: Read, Grep, Glob, Write, Edit, Bash, mcp__sequential-thinking__sequentialthinking, mcp__context7__resolve-library-id, mcp__context7__query-docs, mcp__github__search_code, mcp__tavily__tavily-search
model: sonnet
permissionMode: default
skills: implement, analyze, improve
---

# Python Expert

## Purpose

Deliver production-ready, secure, high-performance Python code following SOLID principles and modern best practices.

## Triggers

- Python development requiring production-quality architecture
- Code review and optimization for performance/security
- Testing strategy and comprehensive coverage
- Framework setup (FastAPI, Django, Flask)

## Core Principles

1. **Production from Day One** - Every line secure, tested, maintainable
2. **Explicit over Implicit** - Follow Zen of Python
3. **Type Safety** - Full type annotations, runtime validation
4. **Security First** - Input validation, dependency scanning

## Workflow

1. **Understand** - Read existing code, identify patterns
2. **Research** - Lookup documentation via Context7
3. **Plan** - Design with Sequential Thinking for complex problems
4. **Implement** - Write clean, typed, tested code
5. **Review** - Self-review for quality, security, performance

## Tool Usage

### Documentation Lookup

```yaml
# Python standard library
mcp__context7__resolve-library-id("python")
# Returns: /websites/devdocs_io_python_3_14

# Framework docs
mcp__context7__resolve-library-id("fastapi")
mcp__context7__resolve-library-id("django")
```
````

For complete library ID reference, see [MCP Resources](../lib/shared-references/mcp-resources.md).

## Quality Standards

- Type annotations on all public APIs
- Docstrings following Google style
- Tests with >80% coverage
- No hardcoded secrets
- Dependency version pinning

## References

- [MCP Resources](../lib/shared-references/mcp-resources.md) - Library IDs
- [Python Patterns](references/python-patterns.md) - Framework patterns

````

#### Step 4: Verify

```bash
wc -l agents/python-expert.md  # Should be ~300-400 lines
````

### 3.2-3.4 Refactor Remaining Critical Agents

Apply same pattern to:

- `observability-engineer` - Move tool tables, keep behavioral instructions
- `technical-writer` - Move templates, keep writing guidelines
- `learning-guide` - Move example libraries, keep teaching methodology

---

## Phase 4: Warning Agents Refactoring

### Agents to Refactor (700-1000 lines → 400 lines)

| Agent                | Current Lines | Target Lines |
| -------------------- | ------------- | ------------ |
| security-expert      | 940           | 400          |
| requirements-analyst | 917           | 400          |
| database-admin       | 872           | 400          |
| socratic-mentor      | 765           | 400          |
| architect            | 710           | 400          |

### Refactoring Pattern

For each agent:

1. **Extract MCP tables** → `lib/shared-references/mcp-resources.md`
2. **Extract domain patterns** → `agents/references/[agent]-patterns.md`
3. **Rewrite agent file** using template
4. **Verify line count**

---

## Phase 5: Commands Cleanup

### Commands to Refactor

| Command     | Current Lines | Target Lines | Issue                   |
| ----------- | ------------- | ------------ | ----------------------- |
| cleanup.md  | 989           | 80           | Duplicates devops skill |
| build.md    | 758           | 80           | Duplicates devops skill |
| estimate.md | 453           | 100          | Too verbose             |

### 5.1 Refactor `cleanup.md` (989 → 80 lines)

#### Current Problem

The cleanup command contains the full cleanup workflow, which duplicates content in the devops skill.

#### Solution

Commands should be thin wrappers that delegate to skills.

**New `commands/development/cleanup.md`**:

````markdown
---
name: cleanup
description: "Code cleanup and dead code removal"
argument-hint: "[target] [--type code|imports|files|all] [--safe|--aggressive]"
delegates-to: devops
operation: cleanup
---

# Cleanup Command

Remove unused code, imports, and files from your codebase.

## Usage

```bash
/developer-kit:cleanup [target] [options]
```
````

## Arguments

| Argument     | Description              | Default |
| ------------ | ------------------------ | ------- |
| target       | Directory to clean       | `.`     |
| --type       | Cleanup type             | `all`   |
| --safe       | Conservative mode        | true    |
| --aggressive | Remove more aggressively | false   |

## Examples

```bash
# Safe cleanup of entire project
/developer-kit:cleanup

# Aggressive cleanup of src directory
/developer-kit:cleanup src/ --aggressive

# Only remove unused imports
/developer-kit:cleanup --type imports
```

## Delegated To

This command delegates to the `devops` skill with operation `cleanup`.

See: [devops skill](../../skills/devops/SKILL.md)

````

### 5.2 Refactor `build.md` (758 → 80 lines)

Apply same pattern - thin wrapper delegating to devops skill.

### 5.3 Refactor `estimate.md` (453 → 100 lines)

Keep essential estimation guidance, move detailed examples to references.

---

## Phase 6: Testing & Validation

### 6.1 Token Usage Verification

After each phase, run context check:

```bash
# Start Claude Code session
claude

# Run context command
/context
````

**Expected results after full refactoring**:

| Component | Before | After | Target |
| --------- | ------ | ----- | ------ |
| Skills    | ~100k  | ~5k   | <10k   |
| Agents    | ~25k   | ~6k   | <10k   |
| Commands  | ~10k   | ~3k   | <5k    |
| **Total** | ~135k  | ~14k  | <25k   |

### 6.2 Functionality Testing

For each refactored skill/agent/command:

1. **Activation Test**: Verify skill activates on trigger phrases
2. **Reference Loading**: Verify references load when needed
3. **Tool Access**: Verify allowed-tools work correctly
4. **Output Quality**: Verify output matches pre-refactoring quality

### 6.3 Regression Testing Checklist

```markdown
## Skill Regression Tests

### containers

- [ ] Creates valid Dockerfile for Node.js app
- [ ] Creates valid docker-compose.yml
- [ ] Creates valid Kubernetes deployment
- [ ] Creates valid Helm chart

### observability

- [ ] Configures structured logging
- [ ] Sets up Prometheus metrics
- [ ] Creates Grafana dashboard
- [ ] Configures alerting rules

### database

- [ ] Designs normalized schema
- [ ] Optimizes slow queries
- [ ] Creates migration scripts
- [ ] Configures connection pooling

[... continue for all skills ...]

## Agent Regression Tests

### python-expert

- [ ] Creates production-ready FastAPI endpoint
- [ ] Reviews code with security focus
- [ ] Writes comprehensive tests
- [ ] Optimizes performance issues

[... continue for all agents ...]

## Command Regression Tests

### /developer-kit:cleanup

- [ ] Removes unused imports
- [ ] Removes dead code
- [ ] Respects --safe flag
- [ ] Respects --aggressive flag

[... continue for all commands ...]
```

### 6.4 Version Bump

After successful validation:

1. Update `plugin.json`:

```json
{
  "version": "5.0.0"
}
```

2. Update CHANGELOG.md:

```markdown
## [5.0.0] - 2025-XX-XX

### Changed

- BREAKING: Restructured all skills for progressive disclosure
- BREAKING: Restructured all agents for token efficiency
- Reduced startup token usage by 68%

### Added

- lib/shared-references/ for consolidated MCP resources
- references/guide.md for each skill

### Fixed

- Skills now load on-demand per Claude Code spec
```

---

## Appendix A: Complete Skill Refactoring Checklist

### For Each Skill

- [ ] Read current SKILL.md completely
- [ ] Identify content to move (phases, diagrams, examples)
- [ ] Create `references/guide.md` if not exists
- [ ] Move behavioral flow diagram to guide.md
- [ ] Move phase instructions to guide.md
- [ ] Move MCP examples to guide.md
- [ ] Update existing reference files if needed
- [ ] Rewrite SKILL.md using template
- [ ] Verify line count <100
- [ ] Test skill activation
- [ ] Test reference loading
- [ ] Commit changes

### Skill Status Tracker

| Skill               | guide.md | SKILL.md | Tested | Committed |
| ------------------- | -------- | -------- | ------ | --------- |
| containers          | [ ]      | [ ]      | [ ]    | [ ]       |
| observability       | [ ]      | [ ]      | [ ]    | [ ]       |
| database            | [ ]      | [ ]      | [ ]    | [ ]       |
| migration           | [ ]      | [ ]      | [ ]    | [ ]       |
| implement           | [ ]      | [ ]      | [ ]    | [ ]       |
| devops              | [ ]      | [ ]      | [ ]    | [ ]       |
| research            | [ ]      | [ ]      | [ ]    | [ ]       |
| test                | [ ]      | [ ]      | [ ]    | [ ]       |
| security            | [ ]      | [ ]      | [ ]    | [ ]       |
| performance         | [ ]      | [ ]      | [ ]    | [ ]       |
| quality             | [ ]      | [ ]      | [ ]    | [ ]       |
| orchestration       | [ ]      | [ ]      | [ ]    | [ ]       |
| document            | [ ]      | [ ]      | [ ]    | [ ]       |
| improve             | [ ]      | [ ]      | [ ]    | [ ]       |
| explain             | [ ]      | [ ]      | [ ]    | [ ]       |
| debug               | [ ]      | [ ]      | [ ]    | [ ]       |
| design              | [ ]      | [ ]      | [ ]    | [ ]       |
| analyze             | [ ]      | [ ]      | [ ]    | [ ]       |
| a11y                | [ ]      | [ ]      | [ ]    | [ ]       |
| brainstorm          | [ ]      | [ ]      | [ ]    | [ ]       |
| frontend            | [ ]      | [ ]      | [ ]    | [ ]       |
| verify              | [ ]      | [ ]      | [ ]    | [ ]       |
| confidence-check    | [ ]      | [ ]      | [ ]    | [ ]       |
| sequential-thinking | [x]      | [x]      | [ ]    | [ ]       |

---

## Appendix B: Complete Agent Refactoring Checklist

### For Each Agent

- [ ] Read current agent file completely
- [ ] Extract MCP tables to shared-references
- [ ] Create agent-specific patterns file if needed
- [ ] Rewrite agent using template
- [ ] Verify line count <500
- [ ] Test agent invocation
- [ ] Test tool access
- [ ] Commit changes

### Agent Status Tracker

| Agent                  | MCP Extracted | Patterns | Rewritten | Tested | Committed |
| ---------------------- | ------------- | -------- | --------- | ------ | --------- |
| python-expert          | [ ]           | [ ]      | [ ]       | [ ]    | [ ]       |
| observability-engineer | [ ]           | [ ]      | [ ]       | [ ]    | [ ]       |
| technical-writer       | [ ]           | [ ]      | [ ]       | [ ]    | [ ]       |
| learning-guide         | [ ]           | [ ]      | [ ]       | [ ]    | [ ]       |
| security-expert        | [ ]           | [ ]      | [ ]       | [ ]    | [ ]       |
| requirements-analyst   | [ ]           | [ ]      | [ ]       | [ ]    | [ ]       |
| database-admin         | [ ]           | [ ]      | [ ]       | [ ]    | [ ]       |
| socratic-mentor        | [ ]           | [ ]      | [ ]       | [ ]    | [ ]       |
| architect              | [ ]           | [ ]      | [ ]       | [ ]    | [ ]       |
| code-reviewer          | [ ]           | [ ]      | [ ]       | [ ]    | [ ]       |
| code-explorer          | [ ]           | [ ]      | [ ]       | [ ]    | [ ]       |
| repo-index             | [ ]           | [ ]      | [ ]       | [ ]    | [ ]       |
| pm-agent               | [ ]           | [ ]      | [ ]       | [ ]    | [ ]       |
| business-panel-experts | [ ]           | [ ]      | [ ]       | [ ]    | [ ]       |

---

## Appendix C: Command Refactoring Checklist

### Commands to Refactor

| Command     | Current | Target | Status |
| ----------- | ------- | ------ | ------ |
| cleanup.md  | 989     | 80     | [ ]    |
| build.md    | 758     | 80     | [ ]    |
| estimate.md | 453     | 100    | [ ]    |

### Commands Already Compliant

All other commands are under 300 lines and follow delegation pattern.

---

## Appendix D: Risk Mitigation

### Risk 1: Breaking Changes

**Mitigation**:

- Create git branch `refactor/token-optimization`
- Commit after each skill/agent
- Test before merging

### Risk 2: Lost Functionality

**Mitigation**:

- Content is MOVED, not deleted
- All phases/patterns preserved in references
- Reference files remain accessible

### Risk 3: Reference Loading Issues

**Mitigation**:

- Test reference loading for each skill
- Verify links in SKILL.md are correct
- Check relative paths

### Risk 4: Skill Activation Changes

**Mitigation**:

- Keep description field unchanged or improved
- Test activation with trigger phrases
- Verify tool access unchanged

---

## Appendix E: File Structure After Refactoring

```
developer-kit/
├── .claude-plugin/
│   └── plugin.json              # v5.0.0
├── lib/
│   └── shared-references/
│       ├── mcp-resources.md     # Consolidated MCP library tables
│       └── tool-patterns.md     # Common tool integration patterns
├── agents/
│   ├── references/
│   │   ├── python-patterns.md
│   │   ├── security-patterns.md
│   │   └── ...
│   ├── python-expert.md         # ~400 lines
│   ├── security-expert.md       # ~400 lines
│   └── ...
├── skills/
│   ├── containers/
│   │   ├── SKILL.md             # ~80 lines
│   │   └── references/
│   │       ├── guide.md         # Behavioral flow + phases
│   │       ├── dockerfile-patterns.md
│   │       ├── compose-patterns.md
│   │       ├── kubernetes-patterns.md
│   │       └── helm-patterns.md
│   ├── observability/
│   │   ├── SKILL.md             # ~80 lines
│   │   └── references/
│   │       ├── guide.md
│   │       └── ...
│   └── ...
├── commands/
│   ├── development/
│   │   ├── cleanup.md           # ~80 lines
│   │   ├── build.md             # ~80 lines
│   │   └── ...
│   └── ...
└── templates/
    ├── SKILL-TEMPLATE.md
    ├── AGENT-TEMPLATE.md
    └── COMMAND-TEMPLATE.md
```

---

## Appendix F: Exemplary Skill Reference

The `sequential-thinking` skill (93 lines) serves as the model for all refactored skills:

**Key characteristics**:

- Concise frontmatter with clear description
- Brief overview (2-3 sentences)
- "When to Use" section (bullet list)
- "When NOT to Use" section (brief)
- Quick workflow overview
- Links to reference files for details
- Tips section (optional)

**Total lines**: 93 (target: <100)

---

## Success Criteria

The refactoring is complete when:

1. **All SKILL.md files** are under 100 lines
2. **All agent files** are under 500 lines
3. **All command files** are under 100 lines
4. **Token usage** at startup is under 25,000 (excluding MCP tools)
5. **All tests pass** per regression checklist
6. **Version bumped** to 5.0.0
7. **CHANGELOG updated** with breaking changes noted

---

_Refactoring plan created based on GAP-ANALYSIS-REPORT.md_
