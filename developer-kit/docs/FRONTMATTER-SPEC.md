# Frontmatter Specification

This document defines the standard frontmatter fields for all Developer Kit plugin components.

## Skills

Skills are context-aware capabilities that auto-activate based on trigger phrases.

### Required Fields

```yaml
---
name: skill-name           # kebab-case, unique identifier
description: "Purpose. Activates for: 'trigger1', 'trigger2', 'trigger3'..."
---
```

### Optional Fields

```yaml
---
allowed-tools:             # Restrict tool access (plugin-specific extension)
  - Read
  - Grep
  - Glob
  - Bash
---
```

### Field Guidelines

| Field | Required | Format | Notes |
|-------|----------|--------|-------|
| `name` | Yes | kebab-case | Must be unique across all skills |
| `description` | Yes | String | Include "Activates for:" with trigger phrases |
| `allowed-tools` | No | YAML list | Restricts available tools for this skill |

### Deprecated Fields (Do Not Use)

| Field | Reason | Migration |
|-------|--------|-----------|
| `when_to_use` | Redundant | Merge content into `description` |
| `version` | Not useful | Use plugin version instead |
| `languages` | Not useful | Remove entirely |

### Example

```yaml
---
name: debug
description: "Unified debugging skill with tiered methodology. Activates for: 'fix this bug', 'debug this', 'why is this failing', 'troubleshoot', 'find the root cause'."
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - Edit
  - Write
---
```

## Agents

Agents are specialized personas that run in separate context with specific tools.

### Required Fields

```yaml
---
name: agent-name
description: "Purpose and when to invoke"
tools: Read, Grep, Glob    # Comma-separated tool list
model: sonnet              # sonnet | opus | haiku
---
```

### Optional Fields

```yaml
---
permissionMode: default    # Permission handling mode
color: red                 # Display color for UI
skills: skill1, skill2     # Plugin extension: associated skills
---
```

### Field Guidelines

| Field | Required | Format | Notes |
|-------|----------|--------|-------|
| `name` | Yes | kebab-case | Must be unique across all agents |
| `description` | Yes | String | Clear purpose and invocation triggers |
| `tools` | Yes | Comma-separated | Available tools for this agent |
| `model` | Yes | Enum | `sonnet`, `opus`, or `haiku` |
| `permissionMode` | No | String | Permission handling behavior |
| `color` | No | String | UI display color |
| `skills` | No | Comma-separated | Plugin extension for skill associations |

### Example

```yaml
---
name: code-reviewer
description: "Comprehensive code reviewer for PRs and local changes. Uses confidence-based filtering."
tools: Glob, Grep, Read, Bash, WebFetch, TodoWrite, WebSearch
model: sonnet
color: red
---
```

## Commands

Commands are direct actions invoked by name.

### Required Fields

```yaml
---
name: command-name
description: "What this command does"
---
```

### Optional Fields

```yaml
---
delegates-to: skill-name   # Skill this command invokes
operation: mode            # Operation mode for delegated skill
argument-hint: "[args]"    # Argument syntax hint for help
allowed-tools: Read, Grep  # Tool restrictions
---
```

### Field Guidelines

| Field | Required | Format | Notes |
|-------|----------|--------|-------|
| `name` | Yes | kebab-case | Command name (unique identifier) |
| `description` | Yes | String | Brief description of command purpose |
| `delegates-to` | No | skill-name | If command delegates to a skill |
| `operation` | No | String | Operation mode for delegated skill |
| `argument-hint` | No | String | Shows in help: `<command> [hint]` |
| `allowed-tools` | No | Comma-separated | Tool restrictions |

### Example

```yaml
---
name: code-review
description: Comprehensive code review for PRs or local changes
argument-hint: "<pr-url|pr-number|path> [--strict] [--focus security|bugs|style]"
allowed-tools: Bash(gh:*), Read, Grep, Glob, Task
---
```

## Validation

### Quick Validation

```bash
# Check for required fields in skills
for skill in skills/*/SKILL.md; do
  if ! head -10 "$skill" | grep -q "^name:"; then
    echo "Missing name: $skill"
  fi
  if ! head -10 "$skill" | grep -q "^description:"; then
    echo "Missing description: $skill"
  fi
done

# Check for deprecated fields
grep -rn "^when_to_use:\|^version:\|^languages:" skills/*/SKILL.md
```

### Automated Validation

See `scripts/check-frontmatter.sh` for comprehensive validation.

## Plugin Extensions

The following fields are plugin-specific extensions not part of the Claude Code specification.
See [Plugin Extensions (Detailed)](#plugin-extensions-detailed) below for full documentation.

| Field | Component | Purpose | Spec Status |
|-------|-----------|---------|-------------|
| `allowed-tools` | Skills | Restrict available tools | In spec (enforcement unclear) |
| `skills` | Agents | Associate skills with agent | Not in spec |
| `delegates-to` | Commands | Delegation pattern | Not in spec |
| `operation` | Commands | Operation mode | Not in spec |
| `color` | Agents | UI display color | Not in spec |

These extensions provide additional functionality but may be ignored by Claude Code core.

---

## Plugin Extensions (Detailed)

The following fields are **plugin-specific extensions** not part of the official Claude Code specification. They may be ignored by the Claude Code runtime but serve as documentation and design patterns within this plugin.

### Agent Extensions

#### `skills` Field

**Purpose**: Documents which skills an agent conceptually uses or relates to.

**Spec Status**: Not in Claude Code specification. Likely ignored by runtime.

**Usage**:
```yaml
---
name: architect
description: "Unified architecture agent..."
tools: Read, Grep, Glob, Write, Bash, Task
model: sonnet
skills: design, analyze, security, devops, implement
---
```

**When to Use**: When an agent's behavior overlaps with specific skills, document the relationship here for maintainers.

**Agents Using This**:
- `architect.md` - `skills: design, analyze, security, devops, implement`
- `security-expert.md` - `skills: security, analyze, improve`

#### `color` Field

**Purpose**: Intended for UI display color (unconfirmed if functional).

**Spec Status**: Not in Claude Code specification. Behavior unknown.

**Usage**:
```yaml
---
name: code-reviewer
color: red
---
```

**Recommendation**: Consider removing unless functionality is confirmed.

**Agents Using This**:
- `code-reviewer.md` - `color: red`

### Command Extensions

#### `delegates-to` Field

**Purpose**: Documents that a command delegates its core functionality to a skill.

**Spec Status**: Not in Claude Code specification. Metadata only.

**Usage**:
```yaml
---
name: estimate
description: Estimate implementation effort
delegates-to: orchestration
operation: estimate
---
```

**Design Pattern**: Commands using `delegates-to` should be thin wrappers. The actual methodology lives in the referenced skill.

**Commands Using This**:
- `estimate.md` - `delegates-to: orchestration`
- `changelog.md` - `delegates-to: document`
- `migrate.md` - `delegates-to: migration`
- `feature-dev.md` - `delegates-to: orchestration`

#### `operation` Field

**Purpose**: Specifies which operation mode the delegated skill should use.

**Spec Status**: Not in Claude Code specification. Metadata only.

**Usage**:
```yaml
---
delegates-to: orchestration
operation: estimate
---
```

**Commands Using This**:
- `estimate.md` - `operation: estimate`
- `feature-dev.md` - `operation: feature`

### Extension Philosophy

These extensions follow the principle of **documentation as code**:

1. **Self-Documenting**: Frontmatter captures design intent
2. **Discoverable**: `grep` can find all delegating commands
3. **Maintainable**: Relationships are explicit, not implicit
4. **Forward-Compatible**: If Claude Code adds these features, we're ready

### Finding Extensions

```bash
# Find all agents with skills field
grep -l "^skills:" agents/*.md

# Find all commands with delegates-to
grep -rl "^delegates-to:" commands/

# Find all color fields
grep -rn "^color:" agents/
```
