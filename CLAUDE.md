# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **Claude Code Plugin Marketplace** containing the **Developer Kit** plugin (v4.0.0). The plugin extends Claude Code with 24 skills, 14 agents, and 21 commands for software development workflows.

## Common Commands

```bash
# Full validation suite (89 tests expected)
./developer-kit/scripts/test-components.sh

# Quick component validation
./developer-kit/scripts/validate-components.sh

# Individual validators
./developer-kit/scripts/validate-skill-descriptions.sh
./developer-kit/scripts/validate-agent-fields.sh
./developer-kit/scripts/validate-references.sh
./developer-kit/scripts/check-frontmatter.sh

# Test a hook script
echo '{}' | python3 developer-kit/hooks/security_reminder_hook.py
```

## Architecture

### Component Hierarchy

```
Commands (User Interface) → <command-name>
    ↓ delegates to
Skills (Core Capabilities) → skills/<name>/SKILL.md
    ↓ uses
MCP Tools (Extended Functionality) → .mcp.json

Agents reference Skills via `skills:` frontmatter
Hooks execute on events (Pre/Post tool use, session events)
```

### Directory Structure

- `developer-kit/skills/` - 24 skills with flat structure (CRITICAL: no nesting)
- `developer-kit/agents/` - 14 agents (flat .md files)
- `developer-kit/commands/` - 21 commands organized by category
- `developer-kit/hooks/` - Event-driven automation (hooks.json + Python scripts)
- `developer-kit/templates/` - CI/CD, Docker, K8s, ADR templates

### Frontmatter Specification

**Skills** (`skills/<name>/SKILL.md`):
```yaml
---
name: skill-name
description: "Purpose. Activates for: 'trigger1', 'trigger2', 'trigger3'..."
allowed-tools:
  - Read
  - Grep
  - Glob
---
```

**Agents** (`agents/<name>.md`):
```yaml
---
name: agent-name
description: "Purpose and when to invoke"
tools: Read, Grep, Glob    # Comma-separated
model: sonnet              # sonnet | opus | haiku
skills: skill1, skill2     # Plugin extension (optional)
---
```

**Commands** (`commands/<category>/<name>.md`):
```yaml
---
description: "What this command does"
delegates-to: skill-name   # Plugin extension (optional)
operation: specific-mode   # Plugin extension (optional)
---
```

### Critical Constraints

1. **Skills must be flat** - `skills/<name>/SKILL.md` only, no subdirectories containing SKILL.md (breaks Claude Code discovery)
2. **Agents must be flat** - `agents/<name>.md` only, no subdirectories
3. **Include trigger phrases** - Skill descriptions must include "Activates for:" with trigger phrases
4. **No hardcoded secrets** - Use `${VAR}` syntax in .mcp.json

### Plugin Extension Fields

These fields are plugin-specific, not part of Claude Code spec:
- `skills:` in agents - documents skill associations
- `delegates-to:` in commands - delegation pattern documentation
- `operation:` in commands - operation mode for delegated skill
- `allowed-tools:` in skills - tool restrictions (may be enforced)

## Version Management

When releasing a new version:
1. Update `.claude-plugin/plugin.json` version
2. Update `hooks/hooks.json` SessionStart message to match version
3. Update `CHANGELOG.md`
4. Update test expectations in `scripts/test-components.sh`

Current expected counts: 24 skills, 14 agents, 21 commands, 100+ tests passing.
