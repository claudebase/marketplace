# Skill-Centric Architecture Implementation Plan

**Version**: 1.0.0
**Date**: 2025-12-31
**Based On**: SKILL-CENTRIC-ARCHITECTURE-REDESIGN.md
**Target Version**: Developer Kit v4.0.0 → v5.0.0

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Prerequisites](#prerequisites)
3. [Phase 0: Preparation](#phase-0-preparation-day-1)
4. [Phase 1: Critical Skills](#phase-1-critical-skills-days-2-4)
5. [Phase 2: Warning Skills](#phase-2-warning-skills-days-5-6)
6. [Phase 3: Critical Agents](#phase-3-critical-agents-days-7-8)
7. [Phase 4: Warning Agents](#phase-4-warning-agents-days-9-10)
8. [Phase 5: Commands](#phase-5-commands-days-11-12)
9. [Phase 6: Testing & Validation](#phase-6-testing--validation-days-13-14)
10. [Rollback Procedures](#rollback-procedures)
11. [Progress Tracking](#progress-tracking)

---

## Executive Summary

This implementation plan provides step-by-step instructions to migrate the Developer Kit plugin to a skill-centric architecture. The migration will:

- Reduce token usage by **89%** (from ~135,000 to ~15,500 tokens)
- Establish skills as the primary business logic layer
- Transform agents and commands into thin orchestration wrappers

### Timeline Overview

| Phase     | Focus           | Duration    | Components                |
| --------- | --------------- | ----------- | ------------------------- |
| 0         | Preparation     | 1 day       | Infrastructure, templates |
| 1         | Critical Skills | 3 days      | 10 skills (>700 lines)    |
| 2         | Warning Skills  | 2 days      | 6 skills (500-700 lines)  |
| 3         | Critical Agents | 2 days      | 4 agents (>1000 lines)    |
| 4         | Warning Agents  | 2 days      | 5 agents (700-1000 lines) |
| 5         | Commands        | 2 days      | 3 commands (>450 lines)   |
| 6         | Testing         | 2 days      | Validation, fixes         |
| **Total** |                 | **14 days** |                           |

---

## Prerequisites

### Required Tools

```bash
# Verify tools are installed
git --version        # Git for version control
wc --version         # Word count for line counting
diff --version       # For comparing files
```

### Repository Setup

```bash
# 1. Ensure you're on a clean working tree
cd /Users/mosheanconina/Projects/claudebase/marketplace/developer-kit
git status

# 2. Create migration branch
git checkout -b refactor/skill-centric-v5

# 3. Verify current state
./scripts/test-components.sh
```

### Backup Current State

```bash
# Create backup of current implementation
mkdir -p .backup/v4.0.0
cp -r skills/ .backup/v4.0.0/skills/
cp -r agents/ .backup/v4.0.0/agents/
cp -r commands/ .backup/v4.0.0/commands/
echo "Backup created at $(date)" > .backup/v4.0.0/BACKUP_INFO.txt
```

---

## Phase 0: Preparation (Day 1)

### Step 0.1: Verify Shared References Directory

**Objective**: Ensure shared reference infrastructure exists.

```bash
# Check if lib/shared-references exists
ls -la lib/shared-references/

# Expected files:
# - mcp-resources.md
# - tool-integration-patterns.md
```

**If missing**, create:

````bash
mkdir -p lib/shared-references

# Create mcp-resources.md if it doesn't exist
cat > lib/shared-references/mcp-resources.md << 'EOF'
# MCP Resource Library Reference

Consolidated library IDs for Context7 and other MCP tools.

## Context7 Library IDs

### Python Ecosystem

| Resource | Library ID | Snippets | Use Case |
|----------|------------|----------|----------|
| Python 3.14 | `/websites/devdocs_io_python_3_14` | 21,524 | Core language |
| FastAPI | `/websites/fastapi_tiangolo` | 31,710 | Async APIs |
| Django 6.0 | `/websites/djangoproject_en_6_0` | 10,667 | Full-stack |
| Flask | `/pallets/flask` | 500 | Lightweight APIs |
| Pydantic | `/pydantic/pydantic` | 2,500 | Data validation |
| SQLAlchemy | `/sqlalchemy/sqlalchemy` | 5,000 | ORM |
| pytest | `/pytest-dev/pytest` | 3,000 | Testing |

### JavaScript/TypeScript Ecosystem

| Resource | Library ID | Snippets | Use Case |
|----------|------------|----------|----------|
| React | `/facebook/react` | 5,000 | UI components |
| Next.js | `/vercel/next.js` | 15,000 | Full-stack React |
| Node.js | `/nodejs/node` | 10,000 | Server runtime |
| TypeScript | `/microsoft/typescript` | 8,000 | Type system |
| Express | `/expressjs/express` | 2,000 | HTTP server |

### Database & ORM

| Resource | Library ID | Snippets | Use Case |
|----------|------------|----------|----------|
| PostgreSQL | `/postgres/postgres` | 5,000 | Relational DB |
| MongoDB | `/mongodb/mongo` | 3,000 | Document DB |
| Prisma | `/prisma/prisma` | 4,000 | TypeScript ORM |
| Drizzle | `/drizzle-team/drizzle-orm` | 2,000 | TypeScript ORM |

### DevOps & Infrastructure

| Resource | Library ID | Snippets | Use Case |
|----------|------------|----------|----------|
| Docker | `/docker/docs` | 5,000 | Containerization |
| Kubernetes | `/kubernetes/website` | 8,000 | Orchestration |
| Terraform | `/hashicorp/terraform` | 4,000 | IaC |
| GitHub Actions | `/github/docs` | 3,000 | CI/CD |

## Usage Pattern

```yaml
# Step 1: Resolve library ID
mcp__context7__resolve-library-id("fastapi")

# Step 2: Query documentation
mcp__context7__query-docs("/websites/fastapi_tiangolo", "dependency injection")
````

## Notes

- Always use `resolve-library-id` first to get the correct library ID
- Library IDs may change; verify periodically
- Snippet counts indicate documentation depth
  EOF

````

**Verification**:

```bash
# Verify file exists and has content
wc -l lib/shared-references/mcp-resources.md
# Expected: ~70-100 lines
````

---

### Step 0.2: Create Tool Integration Patterns

**Objective**: Create shared tool integration patterns reference.

````bash
cat > lib/shared-references/tool-integration-patterns.md << 'EOF'
# Common Tool Integration Patterns

Reusable patterns for MCP tool integration across skills and agents.

## Context7 Workflow

### Basic Documentation Lookup

```yaml
# 1. Resolve library ID
mcp__context7__resolve-library-id("library-name")
# Returns: /org/library-id

# 2. Query documentation
mcp__context7__query-docs("/org/library-id", "specific topic")
````

### Framework-Specific Queries

```yaml
# React patterns
mcp__context7__query-docs("/facebook/react", "hooks useState useEffect")

# FastAPI patterns
mcp__context7__query-docs("/websites/fastapi_tiangolo", "dependency injection")

# Next.js patterns
mcp__context7__query-docs("/vercel/next.js", "app router server components")
```

## GitHub MCP Patterns

### Code Search

```yaml
# Search for patterns in public repos
mcp__github__search_code("pattern filename:extension")

# Examples:
mcp__github__search_code("openapi: 3 paths: filename:openapi.yaml")
mcp__github__search_code("type Query type Mutation filename:schema.graphql")
mcp__github__search_code("apiVersion: apps/v1 kind: Deployment")
```

### Repository Operations

```yaml
# Get file contents
mcp__github__get_file_contents(owner, repo, path)

# Search repositories
mcp__github__search_repositories("topic:react stars:>1000")
```

## Tavily Research Patterns

### Web Search

```yaml
# General search
mcp__tavily__tavily-search("query", search_depth="basic")

# Deep research
mcp__tavily__tavily-search("query", search_depth="advanced")

# News search
mcp__tavily__tavily-search("query", topic="news", days=7)
```

### Content Extraction

```yaml
# Extract from URLs
mcp__tavily__tavily-extract(["url1", "url2"])
```

## Sequential Thinking Patterns

### When to Use

- Complex problem decomposition
- Multi-step analysis
- Trade-off evaluation
- Architecture decisions

### Basic Pattern

```yaml
mcp__sequential-thinking__sequentialthinking(
thought="Current analysis step",
thoughtNumber=1,
totalThoughts=5,
nextThoughtNeeded=true
)
```

## Playwright Patterns

### Browser Navigation

```yaml
# Navigate to URL
mcp__playwright__browser_navigate("https://example.com")

# Take snapshot for analysis
mcp__playwright__browser_snapshot()

# Click element
mcp__playwright__browser_click(element="button", ref="ref123")
```

## Best Practices

1. **Always resolve before query** - Use resolve-library-id before query-docs
2. **Be specific** - Narrow queries get better results
3. **Check freshness** - Library IDs may change over time
4. **Combine tools** - Use multiple tools for comprehensive research
5. **Reference this file** - Don't duplicate patterns in skills/agents
   EOF

````

**Verification**:

```bash
wc -l lib/shared-references/tool-integration-patterns.md
# Expected: ~100-120 lines
````

---

### Step 0.3: Create Skill Template

**Objective**: Create the canonical skill template for migration.

```bash
mkdir -p templates/skill-template/references

# Create main SKILL.md template
cat > templates/skill-template/SKILL.md << 'EOF'
---
name: skill-name
description: "Concise purpose (max 200 chars). Activates for: 'trigger1', 'trigger2', 'trigger3'."
allowed-tools:
  - Read
  - Grep
  - Glob
  - Write
  - Edit
  - Bash
  - Task
composable: true
mode: read-write
---

# Skill Name

Brief overview in 2-3 sentences explaining what this skill does and its core principle.

**Core Principle**: "One sentence guiding principle for this skill."

## When to Use

- Trigger scenario 1 ("trigger phrase 1", "alternate phrase")
- Trigger scenario 2 ("trigger phrase 2")
- Trigger scenario 3 ("trigger phrase 3")

## When NOT to Use

- Alternative scenario 1 → use `other-skill` skill
- Alternative scenario 2 → use `another-skill` skill
- Out of scope → explain briefly

## Quick Workflow

```

PHASE1 → PHASE2 → PHASE3 → PHASE4
Tool1 Tool2 Tool3 Tool4

```

1. **Phase 1** - Brief description of first phase
2. **Phase 2** - Brief description of second phase
3. **Phase 3** - Brief description of third phase
4. **Phase 4** - Brief description of fourth phase

## Tool Integration

For library IDs and MCP patterns, see:
- [MCP Resources](../../lib/shared-references/mcp-resources.md)
- [Tool Patterns](../../lib/shared-references/tool-integration-patterns.md)

## References

- [Detailed Guide](references/guide.md) - Full behavioral flow and methodology
- [Patterns](references/patterns.md) - Implementation patterns
- [Examples](references/examples.md) - Real-world examples

## Boundaries

**Will**: Action 1, Action 2, Action 3

**Will NOT**: Action 4, Action 5 (use `other-skill` instead)
EOF

# Create guide.md template
cat > templates/skill-template/references/guide.md << 'EOF'
# Skill Name - Detailed Guide

Complete behavioral flow and methodology for the skill.

## Behavioral Flow

```

┌─────────────────────────────────────────────────────────────┐
│ User Request │
└─────────────────────────────────────────────────────────────┘
│
▼
┌─────────────────────────────────────────────────────────────┐
│ Phase 1: UNDERSTAND │
│ - Read existing code │
│ - Identify patterns │
└─────────────────────────────────────────────────────────────┘
│
▼
┌─────────────────────────────────────────────────────────────┐
│ Phase 2: RESEARCH │
│ - Query Context7 documentation │
│ - Search GitHub for patterns │
└─────────────────────────────────────────────────────────────┘
│
▼
┌─────────────────────────────────────────────────────────────┐
│ Phase 3: PLAN/ANALYZE │
│ - Use Sequential Thinking if complex │
│ - Break down into steps │
└─────────────────────────────────────────────────────────────┘
│
▼
┌─────────────────────────────────────────────────────────────┐
│ Phase 4: EXECUTE/REPORT │
│ - Implement or report findings │
│ - Verify results │
└─────────────────────────────────────────────────────────────┘

````

## Phase 1: UNDERSTAND

### Objectives
- Objective 1
- Objective 2

### Steps
1. Step 1 with details
2. Step 2 with details
3. Step 3 with details

### Tools Used
- `Read` - For reading files
- `Grep` - For searching patterns
- `Glob` - For finding files

## Phase 2: RESEARCH

### Objectives
- Objective 1
- Objective 2

### MCP Tool Usage

```yaml
# Context7 for documentation
mcp__context7__resolve-library-id("relevant-library")
mcp__context7__query-docs("/library/id", "specific query")

# GitHub for patterns
mcp__github__search_code("pattern filename:extension")
````

### Steps

1. Step 1
2. Step 2
3. Step 3

## Phase 3: PLAN/ANALYZE

### Objectives

- Objective 1
- Objective 2

### Sequential Thinking (for complex problems)

```yaml
mcp__sequential-thinking__sequentialthinking(
thought="Analyzing the problem...",
thoughtNumber=1,
totalThoughts=5,
nextThoughtNeeded=true
)
```

### Steps

1. Step 1
2. Step 2
3. Step 3

## Phase 4: EXECUTE/REPORT

### Objectives

- Objective 1
- Objective 2

### Steps

1. Step 1
2. Step 2
3. Step 3

### Output Format

```markdown
## [Skill Name] Report

### Summary

- Key finding 1
- Key finding 2

### Details

[Detailed findings]

### Recommendations

1. Recommendation 1
2. Recommendation 2
```

## Edge Cases

### Case 1: [Description]

Handle by: [approach]

### Case 2: [Description]

Handle by: [approach]

## Related Skills

- `related-skill-1` - When to use instead
- `related-skill-2` - How they work together
  EOF

# Create patterns.md template

cat > templates/skill-template/references/patterns.md << 'EOF'

# Skill Name - Implementation Patterns

Common patterns and examples for this skill.

## Pattern 1: [Name]

### When to Use

- Scenario 1
- Scenario 2

### Implementation

```typescript
// Example code
function example() {
  // Implementation
}
```

### Variations

- Variation A: [description]
- Variation B: [description]

## Pattern 2: [Name]

### When to Use

- Scenario 1
- Scenario 2

### Implementation

```python
# Example code
def example():
    pass
```

## Anti-Patterns

### Anti-Pattern 1: [Name]

**Problem**: Description of the issue
**Better Approach**: How to do it correctly

### Anti-Pattern 2: [Name]

**Problem**: Description of the issue
**Better Approach**: How to do it correctly

## Quick Reference

| Pattern   | Use Case | Complexity |
| --------- | -------- | ---------- |
| Pattern 1 | Use case | Low        |
| Pattern 2 | Use case | Medium     |

EOF

````

**Verification**:

```bash
# Verify template structure
ls -la templates/skill-template/
ls -la templates/skill-template/references/
wc -l templates/skill-template/SKILL.md
# Expected: ~70-80 lines
````

---

### Step 0.4: Create Agent Template

**Objective**: Create the canonical agent template for migration.

````bash
cat > templates/agent-template.md << 'EOF'
---
name: agent-name
description: "Concise description of agent purpose and expertise. Activates for: trigger1, trigger2."
tools: Read, Grep, Glob, Write, Edit, Bash, Task, mcp__sequential-thinking__sequentialthinking, mcp__context7__resolve-library-id, mcp__context7__query-docs
model: sonnet
permissionMode: default
skills: skill1, skill2, skill3
expertise: "Brief statement of domain expertise and decision-making approach."
---

# Agent Name

## Purpose

2-3 sentences describing the agent's role, expertise, and primary value proposition.

**Core Principle**: "One sentence guiding principle for this agent's decisions."

## Triggers

- **Trigger Category 1**: "trigger phrase", "alternate phrase"
- **Trigger Category 2**: "trigger phrase", "alternate phrase"
- **Trigger Category 3**: "trigger phrase", "alternate phrase"

## Operating Procedure

### Phase 1: UNDERSTAND
1. Read existing code and context
2. Identify patterns and constraints
3. Gather requirements

### Phase 2: RESEARCH
1. Query documentation via Context7
2. Search for patterns via GitHub MCP
3. Research best practices via Tavily

### Phase 3: ANALYZE/DESIGN
1. Use Sequential Thinking for complex decisions
2. Evaluate trade-offs
3. Make decisive recommendations

### Phase 4: DELIVER
1. Provide actionable output
2. Include implementation details
3. Document decisions and rationale

## Tool Usage

For MCP library IDs and integration patterns, see:
- [MCP Resources](../lib/shared-references/mcp-resources.md)
- [Tool Patterns](../lib/shared-references/tool-integration-patterns.md)

### Primary Tools
- **Context7**: Documentation lookup for frameworks and libraries
- **GitHub MCP**: Pattern research and code examples
- **Sequential Thinking**: Complex reasoning and trade-off analysis

## Output Format

```markdown
## [Agent Name] Output

### Context Analysis
- Existing patterns found
- Constraints identified

### Recommendation
[Clear, decisive recommendation]

### Implementation Details
[Specific details for implementation]

### Rationale
[Why this approach was chosen]
````

## Boundaries

**Will**:

- Action 1
- Action 2
- Action 3

**Will NOT**:

- Action 4 (use `other-agent` instead)
- Action 5 (outside scope)
- Action 6 (hand off to implementation)

## Related

- `related-skill` skill - When to use the skill directly
- `related-agent` agent - When to delegate
  EOF

````

**Verification**:

```bash
wc -l templates/agent-template.md
# Expected: ~100-120 lines
````

---

### Step 0.5: Create Command Template

**Objective**: Create the canonical command template for migration.

````bash
cat > templates/command-template.md << 'EOF'
---
name: dk:command-name
description: "Brief description of what this command does"
argument-hint: "[target] [--option <value>] [--flag]"
delegates-to: skill-name
operation: operation-mode
---

# command-name - Command Title

Brief one-line description of the command's purpose.

## Usage

```bash
/developer-kit:command-name [target] [options]
````

## Arguments

| Argument   | Description              | Default | Required |
| ---------- | ------------------------ | ------- | -------- |
| `target`   | Target file or directory | `.`     | No       |
| `--option` | Option description       | `value` | No       |
| `--flag`   | Flag description         | `false` | No       |

## Examples

```bash
# Basic usage
/developer-kit:command-name

# With target
/developer-kit:command-name src/

# With options
/developer-kit:command-name --option value

# Full example
/developer-kit:command-name src/ --option value --flag
```

## Delegation

This command delegates to the `skill-name` skill with operation `operation-mode`.

## See Also

- `skill-name` skill - Core implementation
- `/developer-kit:related-command` - Related workflow
  EOF

````

**Verification**:

```bash
wc -l templates/command-template.md
# Expected: ~50-60 lines
````

---

### Step 0.6: Create Progress Tracking File

**Objective**: Create a file to track migration progress.

```bash
cat > docs/MIGRATION-PROGRESS.md << 'EOF'
# Migration Progress Tracker

## Overview

| Phase | Status | Progress | Started | Completed |
|-------|--------|----------|---------|-----------|
| Phase 0: Preparation | Not Started | 0% | | |
| Phase 1: Critical Skills | Not Started | 0% | | |
| Phase 2: Warning Skills | Not Started | 0% | | |
| Phase 3: Critical Agents | Not Started | 0% | | |
| Phase 4: Warning Agents | Not Started | 0% | | |
| Phase 5: Commands | Not Started | 0% | | |
| Phase 6: Testing | Not Started | 0% | | |

## Phase 0: Preparation

- [ ] Step 0.1: Verify shared references directory
- [ ] Step 0.2: Create tool integration patterns
- [ ] Step 0.3: Create skill template
- [ ] Step 0.4: Create agent template
- [ ] Step 0.5: Create command template
- [ ] Step 0.6: Create progress tracking file
- [ ] Step 0.7: Commit preparation phase

## Phase 1: Critical Skills (10 skills)

### containers (1,055 → 80 lines)
- [ ] Create references/guide.md
- [ ] Move behavioral flow to guide.md
- [ ] Move phase instructions to guide.md
- [ ] Update existing reference files
- [ ] Rewrite SKILL.md
- [ ] Verify line count (<100)
- [ ] Test activation

### observability (1,010 → 80 lines)
- [ ] Create references/guide.md
- [ ] Move behavioral flow to guide.md
- [ ] Move phase instructions to guide.md
- [ ] Update existing reference files
- [ ] Rewrite SKILL.md
- [ ] Verify line count (<100)
- [ ] Test activation

### database (965 → 80 lines)
- [ ] Create references/guide.md
- [ ] Move behavioral flow to guide.md
- [ ] Move phase instructions to guide.md
- [ ] Update existing reference files
- [ ] Rewrite SKILL.md
- [ ] Verify line count (<100)
- [ ] Test activation

### migration (892 → 80 lines)
- [ ] Create references/guide.md
- [ ] Move behavioral flow to guide.md
- [ ] Move phase instructions to guide.md
- [ ] Update existing reference files
- [ ] Rewrite SKILL.md
- [ ] Verify line count (<100)
- [ ] Test activation

### implement (811 → 80 lines)
- [ ] Create references/guide.md
- [ ] Move behavioral flow to guide.md
- [ ] Move phase instructions to guide.md
- [ ] Update existing reference files
- [ ] Rewrite SKILL.md
- [ ] Verify line count (<100)
- [ ] Test activation

### devops (766 → 80 lines)
- [ ] Create references/guide.md
- [ ] Move behavioral flow to guide.md
- [ ] Move phase instructions to guide.md
- [ ] Update existing reference files
- [ ] Rewrite SKILL.md
- [ ] Verify line count (<100)
- [ ] Test activation

### research (738 → 80 lines)
- [ ] Create references/guide.md
- [ ] Move behavioral flow to guide.md
- [ ] Move phase instructions to guide.md
- [ ] Update existing reference files
- [ ] Rewrite SKILL.md
- [ ] Verify line count (<100)
- [ ] Test activation

### test (680 → 80 lines)
- [ ] Create references/guide.md
- [ ] Move behavioral flow to guide.md
- [ ] Move phase instructions to guide.md
- [ ] Update existing reference files
- [ ] Rewrite SKILL.md
- [ ] Verify line count (<100)
- [ ] Test activation

### security (653 → 80 lines)
- [ ] Create references/guide.md
- [ ] Move behavioral flow to guide.md
- [ ] Move phase instructions to guide.md
- [ ] Update existing reference files
- [ ] Rewrite SKILL.md
- [ ] Verify line count (<100)
- [ ] Test activation

### performance (536 → 80 lines)
- [ ] Create references/guide.md
- [ ] Move behavioral flow to guide.md
- [ ] Move phase instructions to guide.md
- [ ] Update existing reference files
- [ ] Rewrite SKILL.md
- [ ] Verify line count (<100)
- [ ] Test activation

## Phase 2: Warning Skills (6 skills)

### quality (601 → 80 lines)
- [ ] Create/update references/guide.md
- [ ] Rewrite SKILL.md
- [ ] Verify line count (<100)
- [ ] Test activation

### orchestration (599 → 80 lines)
- [ ] Create/update references/guide.md
- [ ] Rewrite SKILL.md
- [ ] Verify line count (<100)
- [ ] Test activation

### document (582 → 80 lines)
- [ ] Create/update references/guide.md
- [ ] Rewrite SKILL.md
- [ ] Verify line count (<100)
- [ ] Test activation

### improve (564 → 80 lines)
- [ ] Create/update references/guide.md
- [ ] Rewrite SKILL.md
- [ ] Verify line count (<100)
- [ ] Test activation

### explain (553 → 80 lines)
- [ ] Create/update references/guide.md
- [ ] Rewrite SKILL.md
- [ ] Verify line count (<100)
- [ ] Test activation

### debug (551 → 80 lines)
- [ ] Create/update references/guide.md
- [ ] Rewrite SKILL.md
- [ ] Verify line count (<100)
- [ ] Test activation

## Phase 3: Critical Agents (4 agents)

### python-expert (2,457 → 300 lines)
- [ ] Extract MCP tables to shared references
- [ ] Extract framework patterns to references
- [ ] Update skills field
- [ ] Rewrite agent file
- [ ] Verify line count (<300)
- [ ] Test invocation

### observability-engineer (1,093 → 300 lines)
- [ ] Extract MCP tables to shared references
- [ ] Extract stack configs to references
- [ ] Update skills field
- [ ] Rewrite agent file
- [ ] Verify line count (<300)
- [ ] Test invocation

### technical-writer (1,025 → 300 lines)
- [ ] Extract MCP tables to shared references
- [ ] Extract templates to references
- [ ] Update skills field
- [ ] Rewrite agent file
- [ ] Verify line count (<300)
- [ ] Test invocation

### learning-guide (978 → 300 lines)
- [ ] Extract MCP tables to shared references
- [ ] Extract example libraries to references
- [ ] Update skills field
- [ ] Rewrite agent file
- [ ] Verify line count (<300)
- [ ] Test invocation

## Phase 4: Warning Agents (5 agents)

### security-expert (940 → 300 lines)
- [ ] Extract MCP tables
- [ ] Rewrite agent file
- [ ] Verify line count (<300)
- [ ] Test invocation

### requirements-analyst (917 → 300 lines)
- [ ] Extract MCP tables
- [ ] Rewrite agent file
- [ ] Verify line count (<300)
- [ ] Test invocation

### database-admin (872 → 300 lines)
- [ ] Extract MCP tables
- [ ] Rewrite agent file
- [ ] Verify line count (<300)
- [ ] Test invocation

### socratic-mentor (765 → 300 lines)
- [ ] Extract MCP tables
- [ ] Rewrite agent file
- [ ] Verify line count (<300)
- [ ] Test invocation

### architect (710 → 300 lines)
- [ ] Extract MCP tables
- [ ] Rewrite agent file
- [ ] Verify line count (<300)
- [ ] Test invocation

## Phase 5: Commands (3 commands)

### cleanup.md (989 → 80 lines)
- [ ] Identify content to remove
- [ ] Rewrite as thin wrapper
- [ ] Verify delegation to devops
- [ ] Verify line count (<80)
- [ ] Test command

### build.md (758 → 80 lines)
- [ ] Identify content to remove
- [ ] Rewrite as thin wrapper
- [ ] Verify delegation to devops
- [ ] Verify line count (<80)
- [ ] Test command

### estimate.md (453 → 100 lines)
- [ ] Identify content to remove
- [ ] Rewrite as thin wrapper
- [ ] Verify delegation
- [ ] Verify line count (<100)
- [ ] Test command

## Phase 6: Testing & Validation

- [ ] Run full test suite
- [ ] Verify all skills activate correctly
- [ ] Verify all agents invoke correctly
- [ ] Verify all commands work
- [ ] Check token usage
- [ ] Update version to 5.0.0
- [ ] Update CHANGELOG.md
- [ ] Final commit and PR

## Notes

_Add any notes, issues, or blockers here during migration._
EOF
```

**Verification**:

```bash
wc -l docs/MIGRATION-PROGRESS.md
# Expected: ~250+ lines
```

---

### Step 0.7: Commit Preparation Phase

**Objective**: Commit all preparation work.

```bash
# Stage all preparation files
git add lib/shared-references/
git add templates/
git add docs/MIGRATION-PROGRESS.md

# Commit
git commit -m "chore: prepare infrastructure for skill-centric migration

- Add lib/shared-references/mcp-resources.md
- Add lib/shared-references/tool-integration-patterns.md
- Add templates/skill-template/ with SKILL.md and references
- Add templates/agent-template.md
- Add templates/command-template.md
- Add docs/MIGRATION-PROGRESS.md for tracking

Part of: Skill-Centric Architecture Migration v5.0.0"
```

**Update Progress**:

- Mark all Phase 0 items as complete in MIGRATION-PROGRESS.md

---

## Phase 1: Critical Skills (Days 2-4)

### Skill Migration Pattern

For each skill, follow this exact pattern:

```bash
# Variables (set for each skill)
SKILL_NAME="containers"
CURRENT_LINES=$(wc -l < skills/$SKILL_NAME/SKILL.md)

echo "Migrating $SKILL_NAME (currently $CURRENT_LINES lines)"
```

---

### Step 1.1: Migrate `containers` Skill (1,055 → 80 lines)

#### 1.1.1 Read Current Skill

```bash
# Read and understand current content
cat skills/containers/SKILL.md
```

#### 1.1.2 Create Guide Reference

```bash
# Ensure references directory exists
mkdir -p skills/containers/references

# Create guide.md with behavioral flow
cat > skills/containers/references/guide.md << 'EOF'
# Containers Skill - Detailed Guide

Complete behavioral flow and methodology for container creation.

## Behavioral Flow

```

┌─────────────────────────────────────────────────────────────┐
│ User Request │
│ "Create Dockerfile", "containerize", "k8s deployment" │
└─────────────────────────────────────────────────────────────┘
│
▼
┌─────────────────────────────────────────────────────────────┐
│ Phase 1: ANALYZE │
│ - Read application code │
│ - Identify runtime requirements │
│ - Detect package manager and dependencies │
└─────────────────────────────────────────────────────────────┘
│
▼
┌─────────────────────────────────────────────────────────────┐
│ Phase 2: RESEARCH │
│ - Query Context7 for official documentation │
│ - Search GitHub for production patterns │
│ - Lookup security best practices │
└─────────────────────────────────────────────────────────────┘
│
▼
┌─────────────────────────────────────────────────────────────┐
│ Phase 3: DESIGN │
│ - Plan multi-stage build │
│ - Design layer optimization │
│ - Configure security settings │
└─────────────────────────────────────────────────────────────┘
│
▼
┌─────────────────────────────────────────────────────────────┐
│ Phase 4: IMPLEMENT │
│ - Write Dockerfile/compose/manifest │
│ - Apply security hardening │
│ - Add health checks │
└─────────────────────────────────────────────────────────────┘
│
▼
┌─────────────────────────────────────────────────────────────┐
│ Phase 5: VALIDATE │
│ - Build and test locally │
│ - Verify security compliance │
│ - Check resource limits │
└─────────────────────────────────────────────────────────────┘

````

## Phase 1: ANALYZE

### Objectives
- Understand application structure
- Identify runtime requirements
- Detect dependencies

### Steps

1. **Read Application Code**
   ```yaml
   # Use Read tool to examine entry points
   Read: package.json, requirements.txt, go.mod, Cargo.toml
````

2. **Identify Runtime**
   - Node.js: Check package.json for "engines"
   - Python: Check runtime.txt or Dockerfile base
   - Go: Check go.mod for version
   - Rust: Check Cargo.toml for edition

3. **Detect Dependencies**
   - Production vs development dependencies
   - Native modules requiring build tools
   - External services required

### Output

- Runtime version requirements
- Dependency manifest
- Build requirements

## Phase 2: RESEARCH

### MCP Tool Usage

```yaml
# Dockerfile best practices
mcp__context7__resolve-library-id("docker")
mcp__context7__query-docs("/docker/docs", "multi-stage build best practices")

# Kubernetes patterns
mcp__context7__resolve-library-id("kubernetes")
mcp__context7__query-docs("/kubernetes/website", "deployment resource limits")

# Production Dockerfiles
mcp__github__search_code("FROM node:20-alpine AS builder multi-stage filename:Dockerfile")
```

### Security Research

```yaml
# Security scanning
mcp__tavily__tavily-search("Docker security best practices 2025 non-root user")

# CVE awareness
mcp__tavily__tavily-search("Alpine Linux security vulnerabilities container")
```

## Phase 3: DESIGN

### Multi-Stage Build Pattern

```dockerfile
# Stage 1: Build
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

# Stage 2: Production
FROM node:20-alpine AS production
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY . .
USER node
CMD ["node", "server.js"]
```

### Layer Optimization

1. Order instructions by change frequency
2. Combine RUN commands
3. Use .dockerignore
4. Leverage build cache

### Security Configuration

- Run as non-root user
- Drop capabilities
- Read-only filesystem where possible
- No secrets in image

## Phase 4: IMPLEMENT

### Dockerfile Structure

```dockerfile
# syntax=docker/dockerfile:1
ARG NODE_VERSION=20

# Build stage
FROM node:${NODE_VERSION}-alpine AS builder
# ... build steps

# Production stage
FROM node:${NODE_VERSION}-alpine AS production
# Security hardening
RUN addgroup -g 1001 -S nodejs \
    && adduser -S nodejs -u 1001

WORKDIR /app

# Copy from builder
COPY --from=builder --chown=nodejs:nodejs /app ./

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s \
  CMD wget --no-verbose --tries=1 --spider http://localhost:3000/health || exit 1

USER nodejs
EXPOSE 3000
CMD ["node", "server.js"]
```

### Docker Compose Structure

```yaml
version: "3.8"
services:
  app:
    build:
      context: .
      target: production
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
    healthcheck:
      test: ["CMD", "wget", "--spider", "http://localhost:3000/health"]
      interval: 30s
      timeout: 3s
      retries: 3
    deploy:
      resources:
        limits:
          cpus: "0.5"
          memory: 512M
```

## Phase 5: VALIDATE

### Build Validation

```bash
# Build image
docker build -t app:test .

# Check image size
docker images app:test

# Scan for vulnerabilities
docker scout cves app:test
```

### Security Validation

```bash
# Verify non-root user
docker run --rm app:test whoami

# Check capabilities
docker run --rm app:test cat /proc/1/status | grep Cap

# Test health check
docker run -d --name test app:test
docker inspect --format='{{.State.Health.Status}}' test
```

## Related Patterns

- See `references/dockerfile-patterns.md` for Dockerfile patterns
- See `references/compose-patterns.md` for Docker Compose patterns
- See `references/kubernetes-patterns.md` for K8s manifests
- See `references/helm-patterns.md` for Helm charts
  EOF

````

#### 1.1.3 Rewrite SKILL.md

```bash
# Backup original
cp skills/containers/SKILL.md skills/containers/SKILL.md.backup

# Write new minimal SKILL.md
cat > skills/containers/SKILL.md << 'EOF'
---
name: containers
description: "Create Dockerfiles, compose configs, and Kubernetes manifests. Activates for: 'Dockerfile', 'docker compose', 'containerize', 'K8s', 'Kubernetes', 'Helm chart', 'pod config'."
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
  - mcp__github__get_file_contents
  - mcp__tavily__tavily-search
  - mcp__sequential-thinking__sequentialthinking
composable: true
mode: read-write
---

# Containers Skill

Create optimized Dockerfiles, development-friendly compose configurations, and production-ready Kubernetes manifests with security best practices.

**Core Principle**: "Build once, run anywhere. Optimize for security, size, and speed."

## When to Use

- Dockerfile creation ("create Dockerfile", "containerize app", "Docker image")
- Docker Compose ("docker-compose", "multi-container setup", "local development")
- Kubernetes ("k8s deployment", "Kubernetes manifest", "pod configuration")
- Helm/Kustomize ("create Helm chart", "kustomize overlays")

## When NOT to Use

- CI/CD pipelines → use `devops` skill
- Container security scanning → use `security` skill
- Monitoring container metrics → use `observability` skill

## Quick Workflow

````

ANALYZE → RESEARCH → DESIGN → IMPLEMENT → VALIDATE
Read Context7 Sequential Write Bash
Grep GitHub Thinking Edit

```

1. **Analyze** - Read code, identify runtime and dependencies
2. **Research** - Query Context7 for docs, GitHub for patterns
3. **Design** - Plan multi-stage build with security settings
4. **Implement** - Write Dockerfile/compose/K8s manifests
5. **Validate** - Build, scan, and test locally

## Tool Integration

For library IDs and patterns, see:
- [MCP Resources](../../lib/shared-references/mcp-resources.md)
- [Tool Patterns](../../lib/shared-references/tool-integration-patterns.md)

## References

- [Detailed Guide](references/guide.md) - Full behavioral flow
- [Dockerfile Patterns](references/dockerfile-patterns.md)
- [Compose Patterns](references/compose-patterns.md)
- [Kubernetes Patterns](references/kubernetes-patterns.md)
- [Helm Patterns](references/helm-patterns.md)

## Boundaries

**Will**: Create Dockerfiles, compose files, K8s manifests, Helm charts, security hardening

**Will NOT**: CI/CD setup (use `devops`), security scanning (use `security`), monitoring (use `observability`)
EOF
```

#### 1.1.4 Verify Migration

```bash
# Check line count
wc -l skills/containers/SKILL.md
# Expected: ~70-80 lines

# Verify references exist
ls -la skills/containers/references/

# Remove backup if successful
rm skills/containers/SKILL.md.backup
```

#### 1.1.5 Commit

```bash
git add skills/containers/
git commit -m "refactor(containers): migrate to skill-centric architecture

- Reduce SKILL.md from 1,055 to ~75 lines
- Move behavioral flow to references/guide.md
- Keep existing pattern references
- Add links to shared MCP resources

Part of: Skill-Centric Architecture Migration v5.0.0"
```

---

### Step 1.2-1.10: Migrate Remaining Critical Skills

**Repeat the pattern from Step 1.1 for each skill:**

| Step | Skill         | Current Lines | Content to Move                         |
| ---- | ------------- | ------------- | --------------------------------------- |
| 1.2  | observability | 1,010         | Stack configs, dashboard templates      |
| 1.3  | database      | 965           | ORM patterns, schema examples           |
| 1.4  | migration     | 892           | Zero-downtime strategies                |
| 1.5  | implement     | 811           | Framework patterns                      |
| 1.6  | devops        | 766           | CI/CD templates, git patterns           |
| 1.7  | research      | 738           | Search strategies, source evaluation    |
| 1.8  | test          | 680           | Framework detection, coverage patterns  |
| 1.9  | security      | 653           | OWASP checklist, threat modeling        |
| 1.10 | performance   | 536           | Profiling guides, optimization patterns |

**For each skill**:

1. Read current SKILL.md
2. Identify content sections to move
3. Create/update references/guide.md
4. Rewrite SKILL.md using template
5. Verify line count (<100)
6. Commit changes

**Commit after each skill** to maintain granular history.

---

### Phase 1 Completion Checklist

```bash
# Verify all critical skills are under 100 lines
for skill in containers observability database migration implement devops research test security performance; do
  lines=$(wc -l < skills/$skill/SKILL.md)
  if [ $lines -gt 100 ]; then
    echo "FAIL: $skill has $lines lines (target: <100)"
  else
    echo "PASS: $skill has $lines lines"
  fi
done
```

---

## Phase 2: Warning Skills (Days 5-6)

### Skills to Migrate

| Skill         | Current Lines | Target |
| ------------- | ------------- | ------ |
| quality       | 601           | 80     |
| orchestration | 599           | 80     |
| document      | 582           | 80     |
| improve       | 564           | 80     |
| explain       | 553           | 80     |
| debug         | 551           | 80     |

### Migration Pattern

Same as Phase 1:

1. Create references/guide.md
2. Move behavioral flow and phases
3. Rewrite SKILL.md using template
4. Verify line count
5. Commit

---

## Phase 3: Critical Agents (Days 7-8)

### Agent Migration Pattern

For each agent:

```bash
AGENT_NAME="python-expert"
CURRENT_LINES=$(wc -l < agents/$AGENT_NAME.md)
echo "Migrating $AGENT_NAME (currently $CURRENT_LINES lines)"
```

---

### Step 3.1: Migrate `python-expert` Agent (2,457 → 300 lines)

#### 3.1.1 Extract MCP Tables

```bash
# Read current agent to identify MCP tables
cat agents/python-expert.md | grep -A 50 "Library ID"

# These tables should already be in lib/shared-references/mcp-resources.md
# If not, add them there
```

#### 3.1.2 Create Agent-Specific Patterns Reference (if needed)

````bash
mkdir -p agents/references

cat > agents/references/python-patterns.md << 'EOF'
# Python Expert - Implementation Patterns

Python-specific patterns and best practices.

## FastAPI Patterns

### Dependency Injection

```python
from fastapi import Depends, FastAPI
from typing import Annotated

app = FastAPI()

async def get_db():
    db = DatabaseSession()
    try:
        yield db
    finally:
        db.close()

@app.get("/items/")
async def read_items(db: Annotated[Session, Depends(get_db)]):
    return db.query(Item).all()
````

### Pydantic Models

```python
from pydantic import BaseModel, Field, EmailStr

class UserCreate(BaseModel):
    email: EmailStr
    password: str = Field(..., min_length=8)

    model_config = {"extra": "forbid"}
```

## Django Patterns

### Model Design

```python
from django.db import models

class TimestampedModel(models.Model):
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True
```

## Testing Patterns

### Pytest Fixtures

```python
import pytest
from httpx import AsyncClient

@pytest.fixture
async def client():
    async with AsyncClient(app=app, base_url="http://test") as ac:
        yield ac

@pytest.mark.asyncio
async def test_read_main(client):
    response = await client.get("/")
    assert response.status_code == 200
```

## Type Annotation Patterns

```python
from typing import TypeVar, Generic, Protocol

T = TypeVar("T")

class Repository(Protocol[T]):
    def get(self, id: int) -> T | None: ...
    def save(self, item: T) -> T: ...
```

EOF

````

#### 3.1.3 Rewrite Agent File

```bash
# Backup
cp agents/python-expert.md agents/python-expert.md.backup

# Write new agent file
cat > agents/python-expert.md << 'EOF'
---
name: python-expert
description: "Production-ready Python code with SOLID principles and modern best practices. Activates for: Python development, code review, optimization, FastAPI, Django, testing."
tools: Read, Grep, Glob, Write, Edit, Bash, mcp__sequential-thinking__sequentialthinking, mcp__context7__resolve-library-id, mcp__context7__query-docs, mcp__github__search_code, mcp__github__search_repositories, mcp__github__get_file_contents, mcp__tavily__tavily-search, mcp__tavily__tavily-extract, mcp__playwright__browser_navigate, mcp__playwright__browser_snapshot
model: sonnet
permissionMode: default
skills: implement, analyze, improve, test, security
expertise: "Python architecture, type safety, testing strategies, and performance optimization. Makes decisive technology choices."
---

# Python Expert

## Purpose

Deliver production-ready, secure, high-performance Python code following SOLID principles and modern best practices. Specializes in FastAPI, Django, testing, and type-safe architectures.

**Core Principle**: "Production from day one - every line secure, tested, and maintainable."

## Triggers

- **Implementation**: "Python code", "FastAPI endpoint", "Django view", "create service"
- **Review**: "review Python", "check code quality", "optimize Python"
- **Testing**: "write tests", "pytest", "test coverage"
- **Architecture**: "Python architecture", "project structure", "design patterns"

## Operating Procedure

### Phase 1: UNDERSTAND
1. Read existing code and identify patterns
2. Check project structure and conventions
3. Review requirements and constraints

### Phase 2: RESEARCH
1. Query Context7 for framework documentation
2. Search GitHub for production patterns
3. Verify best practices via Tavily

### Phase 3: DESIGN
1. Use Sequential Thinking for complex decisions
2. Design type-safe interfaces
3. Plan test coverage

### Phase 4: IMPLEMENT
1. Write clean, typed code
2. Add comprehensive tests
3. Document public APIs

### Phase 5: REVIEW
1. Self-review for quality
2. Check security implications
3. Verify performance characteristics

## Tool Usage

For library IDs, see [MCP Resources](../lib/shared-references/mcp-resources.md).

### Key Resources

| Resource | Use Case |
|----------|----------|
| Python 3.14 | Core language features |
| FastAPI | Async API development |
| Django | Full-stack web apps |
| Pydantic | Data validation |
| pytest | Testing framework |
| SQLAlchemy | Database ORM |

### Documentation Lookup

```yaml
# Python standard library
mcp__context7__query-docs("/websites/devdocs_io_python_3_14", "asyncio patterns")

# FastAPI
mcp__context7__query-docs("/websites/fastapi_tiangolo", "dependency injection")

# Django
mcp__context7__query-docs("/websites/djangoproject_en_6_0", "model design")
````

## Quality Standards

- Full type annotations on public APIs
- Docstrings following Google style
- Tests with >80% coverage
- No hardcoded secrets
- Dependency version pinning
- Structured logging

## Output Format

```markdown
## Implementation

### Summary

[Brief description of what was implemented]

### Files Changed

- `path/to/file.py` - Description

### Testing

- Unit tests: [count] tests added
- Coverage: [percentage]%

### Security Considerations

[Any security notes]
```

## Boundaries

**Will**:

- Implement Python code following best practices
- Write comprehensive tests
- Optimize performance
- Review code quality
- Design architectures

**Will NOT**:

- Frontend development (use `frontend` skill)
- Infrastructure setup (use `devops` skill)
- Database schema design (use `database` skill)

## References

- [MCP Resources](../lib/shared-references/mcp-resources.md) - Library IDs
- [Tool Patterns](../lib/shared-references/tool-integration-patterns.md) - MCP usage
- [Python Patterns](references/python-patterns.md) - Implementation patterns

## Related

- `implement` skill - General implementation
- `test` skill - Testing focus
- `security` skill - Security review
  EOF

````

#### 3.1.4 Verify and Commit

```bash
# Check line count
wc -l agents/python-expert.md
# Expected: ~180-220 lines

# Remove backup
rm agents/python-expert.md.backup

# Commit
git add agents/python-expert.md agents/references/python-patterns.md
git commit -m "refactor(python-expert): migrate to skill-centric architecture

- Reduce from 2,457 to ~200 lines
- Extract MCP tables to shared references
- Add references/python-patterns.md
- Update skills field for delegation

Part of: Skill-Centric Architecture Migration v5.0.0"
````

---

### Step 3.2-3.4: Migrate Remaining Critical Agents

**Repeat pattern for:**

| Agent                  | Current | Target | Key Extractions                    |
| ---------------------- | ------- | ------ | ---------------------------------- |
| observability-engineer | 1,093   | 300    | Stack configs, dashboard templates |
| technical-writer       | 1,025   | 300    | Document templates                 |
| learning-guide         | 978     | 300    | Example libraries                  |

---

## Phase 4: Warning Agents (Days 9-10)

### Agents to Migrate

| Agent                | Current | Target |
| -------------------- | ------- | ------ |
| security-expert      | 940     | 300    |
| requirements-analyst | 917     | 300    |
| database-admin       | 872     | 300    |
| socratic-mentor      | 765     | 300    |
| architect            | 710     | 300    |

**Same migration pattern as Phase 3.**

---

## Phase 5: Commands (Days 11-12)

### Step 5.1: Migrate `cleanup` Command (989 → 80 lines)

#### 5.1.1 Read Current Command

```bash
cat commands/development/cleanup.md | head -100
```

#### 5.1.2 Rewrite as Thin Wrapper

````bash
# Backup
cp commands/development/cleanup.md commands/development/cleanup.md.backup

# Write new command
cat > commands/development/cleanup.md << 'EOF'
---
name: dk:cleanup
description: "Code cleanup and dead code removal"
argument-hint: "[target] [--type code|imports|files|all] [--safe|--aggressive]"
delegates-to: devops
operation: cleanup
---

# cleanup - Code Cleanup

Remove unused code, imports, and files from your codebase.

## Usage

```bash
/developer-kit:cleanup [target] [options]
````

## Arguments

| Argument       | Description                             | Default | Required |
| -------------- | --------------------------------------- | ------- | -------- |
| `target`       | Directory to clean                      | `.`     | No       |
| `--type`       | Cleanup type: code, imports, files, all | `all`   | No       |
| `--safe`       | Conservative mode (default)             | `true`  | No       |
| `--aggressive` | Remove more aggressively                | `false` | No       |
| `--dry-run`    | Preview changes without applying        | `false` | No       |

## Examples

```bash
# Safe cleanup of entire project
/developer-kit:cleanup

# Preview cleanup without changes
/developer-kit:cleanup --dry-run

# Aggressive cleanup of src directory
/developer-kit:cleanup src/ --aggressive

# Only remove unused imports
/developer-kit:cleanup --type imports

# Only remove dead code
/developer-kit:cleanup --type code
```

## Cleanup Types

| Type      | What It Removes           |
| --------- | ------------------------- |
| `imports` | Unused import statements  |
| `code`    | Unreachable/dead code     |
| `files`   | Empty files, backup files |
| `all`     | All of the above          |

## Safety Levels

- **Safe (default)**: Only removes obviously unused code
- **Aggressive**: Removes more, may require review

## Delegation

This command delegates to the `devops` skill with operation `cleanup`.

## See Also

- `devops` skill - Core cleanup implementation
- `/developer-kit:check` - Validate after cleanup
  EOF

````

#### 5.1.3 Verify and Commit

```bash
# Check line count
wc -l commands/development/cleanup.md
# Expected: ~70-80 lines

# Remove backup
rm commands/development/cleanup.md.backup

# Commit
git add commands/development/cleanup.md
git commit -m "refactor(cleanup): migrate to thin wrapper command

- Reduce from 989 to ~75 lines
- Delegate to devops skill
- Keep essential usage documentation

Part of: Skill-Centric Architecture Migration v5.0.0"
````

---

### Step 5.2-5.3: Migrate Remaining Commands

**Repeat for:**

| Command     | Current | Target |
| ----------- | ------- | ------ |
| build.md    | 758     | 80     |
| estimate.md | 453     | 100    |

---

## Phase 6: Testing & Validation (Days 13-14)

### Step 6.1: Run Full Test Suite

```bash
# Run all validation scripts
./scripts/test-components.sh
```

**Expected output**: All tests pass

### Step 6.2: Verify Line Counts

```bash
echo "=== SKILL LINE COUNTS ==="
for skill in skills/*/SKILL.md; do
  lines=$(wc -l < "$skill")
  name=$(dirname "$skill" | xargs basename)
  status="PASS"
  if [ $lines -gt 100 ]; then status="FAIL"; fi
  printf "%-20s %4d lines [%s]\n" "$name" "$lines" "$status"
done

echo ""
echo "=== AGENT LINE COUNTS ==="
for agent in agents/*.md; do
  lines=$(wc -l < "$agent")
  name=$(basename "$agent" .md)
  status="PASS"
  if [ $lines -gt 300 ]; then status="FAIL"; fi
  printf "%-25s %4d lines [%s]\n" "$name" "$lines" "$status"
done

echo ""
echo "=== COMMAND LINE COUNTS ==="
for cmd in commands/**/*.md; do
  lines=$(wc -l < "$cmd")
  name=$(basename "$cmd" .md)
  status="PASS"
  if [ $lines -gt 100 ]; then status="FAIL"; fi
  printf "%-20s %4d lines [%s]\n" "$name" "$lines" "$status"
done
```

### Step 6.3: Test Skill Activation

Test each critical skill activates correctly:

```bash
# Test triggers (manual verification in Claude Code)
# 1. "analyze the security of this code" → should activate security skill
# 2. "create a Dockerfile" → should activate containers skill
# 3. "implement a login form" → should activate implement skill
```

### Step 6.4: Test Agent Invocation

Test each critical agent invokes correctly:

```bash
# Test invocations (manual verification in Claude Code)
# 1. "use the architect agent to design a system"
# 2. "delegate to code-reviewer to review this PR"
# 3. "have python-expert implement this"
```

### Step 6.5: Test Commands

```bash
# Test commands work (manual verification in Claude Code)
# 1. /developer-kit:cleanup --dry-run
# 2. /developer-kit:build
# 3. /developer-kit:check
```

### Step 6.6: Update Version

```bash
# Update plugin.json
cat > .claude-plugin/plugin.json << 'EOF'
{
  "name": "developer-kit",
  "description": "Comprehensive development assistant plugin with 24 skills, 14 agents, and 21 commands for software development workflows.",
  "version": "5.0.0",
  "author": {
    "name": "Moshe Anconina",
    "url": ""
  },
  "repository": "https://github.com/claudebase/marketplace",
  "license": "MIT",
  "keywords": [
    "development",
    "sdlc",
    "devops",
    "testing",
    "security",
    "observability",
    "database"
  ],
  "commands": "./commands/",
  "agents": "./agents/",
  "skills": "./skills/",
  "hooks": "./hooks/hooks.json",
  "mcpServers": "./.mcp.json",
  "lspServers": "./.lsp.json"
}
EOF
```

### Step 6.7: Update CHANGELOG

```bash
cat >> CHANGELOG.md << 'EOF'

## [5.0.0] - 2025-XX-XX

### Changed
- **BREAKING**: Restructured all 24 skills for progressive disclosure
- **BREAKING**: Restructured all 14 agents for token efficiency
- **BREAKING**: Restructured 3 commands as thin wrappers
- Reduced startup token usage by ~89%

### Added
- `lib/shared-references/mcp-resources.md` - Consolidated MCP library IDs
- `lib/shared-references/tool-integration-patterns.md` - Common MCP patterns
- `templates/skill-template/` - Canonical skill structure
- `templates/agent-template.md` - Canonical agent structure
- `templates/command-template.md` - Canonical command structure
- `docs/SKILL-CENTRIC-ARCHITECTURE-REDESIGN.md` - Architecture documentation
- `docs/IMPLEMENTATION-PLAN.md` - Migration guide

### Fixed
- Skills now follow progressive disclosure pattern
- Agents reference shared resources instead of duplicating
- Commands delegate to skills instead of embedding logic

### Migration Notes
- All existing command names remain unchanged
- All skill triggers remain unchanged
- All agent invocations remain unchanged
- Reference file paths have changed (affects hard-coded paths only)
EOF
```

### Step 6.8: Final Commit

```bash
git add .
git commit -m "chore(release): v5.0.0 - Skill-Centric Architecture

Complete migration to skill-centric architecture:
- All 24 skills restructured (<100 lines each)
- All 14 agents restructured (<300 lines each)
- 3 commands restructured (<100 lines each)
- ~89% reduction in startup token usage
- Added shared reference infrastructure
- Added canonical templates

BREAKING CHANGE: Internal reference file paths changed.
All public interfaces (commands, triggers, invocations) unchanged."
```

### Step 6.9: Create Pull Request

```bash
# Push branch
git push -u origin refactor/skill-centric-v5

# Create PR
gh pr create --title "feat: Skill-Centric Architecture v5.0.0" --body "## Summary

Complete migration to skill-centric plugin architecture.

### Changes
- Restructured all 24 skills for progressive disclosure
- Restructured all 14 agents for token efficiency
- Restructured 3 commands as thin wrappers
- Added shared reference infrastructure
- ~89% reduction in startup token usage

### Testing
- [ ] All skills activate correctly
- [ ] All agents invoke correctly
- [ ] All commands work
- [ ] Line count targets met
- [ ] Test suite passes

### Breaking Changes
Internal reference file paths changed. All public interfaces unchanged.

---
Generated with Claude Code"
```

---

## Rollback Procedures

### Rollback Entire Migration

```bash
# If migration fails, restore from backup
cd /Users/mosheanconina/Projects/claudebase/marketplace/developer-kit

# Restore skills
rm -rf skills/
cp -r .backup/v4.0.0/skills/ skills/

# Restore agents
rm -rf agents/
cp -r .backup/v4.0.0/agents/ agents/

# Restore commands
rm -rf commands/
cp -r .backup/v4.0.0/commands/ commands/

# Reset version
# Edit .claude-plugin/plugin.json back to 4.0.0

# Commit rollback
git add .
git commit -m "revert: rollback skill-centric migration"
```

### Rollback Single Component

```bash
# Restore single skill from backup
SKILL_NAME="containers"
cp .backup/v4.0.0/skills/$SKILL_NAME/SKILL.md skills/$SKILL_NAME/SKILL.md

# Restore single agent from backup
AGENT_NAME="python-expert"
cp .backup/v4.0.0/agents/$AGENT_NAME.md agents/$AGENT_NAME.md
```

### Rollback from Git

```bash
# Find commit before migration
git log --oneline | head -20

# Restore specific file
git checkout <commit-hash> -- skills/containers/SKILL.md
```

---

## Progress Tracking

### Daily Standup Questions

1. What was completed yesterday?
2. What is planned for today?
3. Are there any blockers?

### Tracking Commands

```bash
# Count completed skills (under 100 lines)
echo "Skills completed:"
for skill in skills/*/SKILL.md; do
  lines=$(wc -l < "$skill")
  if [ $lines -le 100 ]; then
    echo "  $(basename $(dirname $skill))"
  fi
done | wc -l

# Count completed agents (under 300 lines)
echo "Agents completed:"
for agent in agents/*.md; do
  lines=$(wc -l < "$agent")
  if [ $lines -le 300 ]; then
    echo "  $(basename $agent .md)"
  fi
done | wc -l
```

### Update Progress File

After each component migration, update `docs/MIGRATION-PROGRESS.md`:

```bash
# Example: Mark containers skill as complete
# Edit docs/MIGRATION-PROGRESS.md
# Change [ ] to [x] for completed items
```

---

## Appendix: Quick Reference

### Target Line Counts

| Component | Max Lines |
| --------- | --------- |
| SKILL.md  | 100       |
| Agent     | 300       |
| Command   | 80-100    |

### File Structure After Migration

```
developer-kit/
├── lib/shared-references/
│   ├── mcp-resources.md
│   └── tool-integration-patterns.md
├── templates/
│   ├── skill-template/
│   ├── agent-template.md
│   └── command-template.md
├── skills/
│   └── [skill-name]/
│       ├── SKILL.md (50-100 lines)
│       └── references/
│           ├── guide.md
│           └── patterns.md
├── agents/
│   ├── [agent-name].md (200-300 lines)
│   └── references/
├── commands/
│   └── [category]/
│       └── [command].md (20-80 lines)
└── docs/
    ├── SKILL-CENTRIC-ARCHITECTURE-REDESIGN.md
    ├── IMPLEMENTATION-PLAN.md
    └── MIGRATION-PROGRESS.md
```

### Git Commit Convention

```
type(scope): description

# Types: feat, fix, refactor, chore, docs
# Scope: skill name, agent name, or general

# Examples:
refactor(containers): migrate to skill-centric architecture
refactor(python-expert): extract MCP tables to shared references
chore(release): v5.0.0 - Skill-Centric Architecture
```

---

_Implementation Plan generated for Developer Kit Plugin v5.0.0 migration_
