# Frontmatter Specification

This document defines the standard frontmatter fields for all Developer Kit plugin components based on the skill-centric architecture (v5.2.0).

## Description Pattern (Emphatic Triggers)

All components use the **emphatic trigger pattern** for descriptions:

```
**EMPHATIC TRIGGER**. Core purpose. Delegates to: [skill/agent]. Activates for: trigger1, trigger2.
```

This pattern ensures:

- Clear visibility of when to activate (bold trigger)
- Delegation path for discoverability
- Trigger phrases for auto-activation

---

## Skills

Skills are the **primary business logic layer** - core capabilities that auto-activate based on trigger phrases.

**Target Size**: 50-100 lines per SKILL.md

### Required Fields

```yaml
---
name: skill-name # kebab-case, unique identifier
description: "**EMPHATIC TRIGGER**. Purpose. Activates for: 'trigger1', 'trigger2', 'trigger3'..."
---
```

### Optional Fields

```yaml
---
allowed-tools: # Restrict tool access (plugin-specific extension)
  - Read
  - Grep
  - Glob
  - Bash
---
```

### Field Guidelines

| Field           | Required | Format     | Notes                                         |
| --------------- | -------- | ---------- | --------------------------------------------- |
| `name`          | Yes      | kebab-case | Must be unique across all skills              |
| `description`   | Yes      | String     | Include "Activates for:" with trigger phrases |
| `allowed-tools` | No       | YAML list  | Restricts available tools for this skill      |

### Deprecated Fields (Do Not Use)

| Field         | Reason     | Migration                        |
| ------------- | ---------- | -------------------------------- |
| `when_to_use` | Redundant  | Merge content into `description` |
| `version`     | Not useful | Use plugin version instead       |
| `languages`   | Not useful | Remove entirely                  |

### Example

```yaml
---
name: debug
description: "**MUST USE for bug fixing**. Tiered debugging from quick fix to deep RCA. Activates for: 'fix this bug', 'debug this', 'why is this failing', 'troubleshoot'."
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - Edit
  - Write
---
```

---

## Agents

Agents are the **orchestration layer** - specialized domain experts that compose skills and run in isolated context.

**Target Size**: 200-300 lines per agent

### Required Fields

```yaml
---
name: agent-name
description: "Purpose and when to invoke"
tools: Read, Grep, Glob # Comma-separated tool list
model: sonnet # sonnet | opus | haiku
---
```

### Optional Fields

```yaml
---
permissionMode: default # Permission handling mode
color: red # Display color for UI
skills: skill1, skill2 # Plugin extension: associated skills
---
```

### Field Guidelines

| Field            | Required | Format          | Notes                                   |
| ---------------- | -------- | --------------- | --------------------------------------- |
| `name`           | Yes      | kebab-case      | Must be unique across all agents        |
| `description`    | Yes      | String          | Clear purpose and invocation triggers   |
| `tools`          | Yes      | Comma-separated | Available tools for this agent          |
| `model`          | Yes      | Enum            | `sonnet`, `opus`, or `haiku`            |
| `permissionMode` | No       | String          | Permission handling behavior            |
| `color`          | No       | String          | UI display color                        |
| `skills`         | No       | Comma-separated | Plugin extension for skill associations |

### Example

```yaml
---
name: code-reviewer
description: "**MUST BE USED after writing code**. Confidence-based review (≥80%) for PRs and local changes. Delegates to: analyze. Activates for: review code, check changes."
tools: Glob, Grep, Read, Bash, WebFetch, TodoWrite, WebSearch
model: sonnet
skills: analyze, security
---
```

---

## Commands

Commands are the **interface layer** - thin wrappers that route user intent and delegate to skills.

**Target Size**: 20-80 lines per command

### Required Fields

```yaml
---
name: command-name
description: "**EMPHATIC TRIGGER**. Purpose. Delegates to: skill. Activates for: triggers."
---
```

### Optional Fields

```yaml
---
delegates-to: skill-name # Skill this command invokes
operation: mode # Operation mode for delegated skill
argument-hint: "[args]" # Argument syntax hint for help
allowed-tools: Read, Grep # Tool restrictions
---
```

### Field Guidelines

| Field           | Required | Format          | Notes                                |
| --------------- | -------- | --------------- | ------------------------------------ |
| `name`          | Yes      | kebab-case      | Command name (unique identifier)     |
| `description`   | Yes      | String          | Brief description of command purpose |
| `delegates-to`  | No       | skill-name      | If command delegates to a skill      |
| `operation`     | No       | String          | Operation mode for delegated skill   |
| `argument-hint` | No       | String          | Shows in help: `<command> [hint]`    |
| `allowed-tools` | No       | Comma-separated | Tool restrictions                    |

### Example

```yaml
---
name: code-review
description: "**MUST BE USED after writing code**. Confidence-based review for PRs and local changes. Delegates to: code-reviewer. Activates for: review code, check changes, PR review."
argument-hint: "<pr-url|pr-number|path> [--strict] [--focus security|bugs|style]"
delegates-to: code-reviewer
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

| Field           | Component | Purpose                     | Spec Status                   |
| --------------- | --------- | --------------------------- | ----------------------------- |
| `allowed-tools` | Skills    | Restrict available tools    | In spec (enforcement unclear) |
| `skills`        | Agents    | Associate skills with agent | Not in spec                   |
| `delegates-to`  | Commands  | Delegation pattern          | Not in spec                   |
| `operation`     | Commands  | Operation mode              | Not in spec                   |
| `color`         | Agents    | UI display color            | Not in spec                   |

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

**Purpose**: Specifies that a command delegates its core functionality to a skill or agent.

**Spec Status**: Plugin extension with **enforcement via directive pattern**.

**Enforcement**: Commands with `delegates-to` MUST include a delegation directive block. This is validated by CI via `scripts/validate_delegation.py`.

**Usage**:

```yaml
---
name: estimate
description: Estimate implementation effort
delegates-to: orchestration
operation: estimate
---

<!-- ═══════════════════════════════════════════════════════════════
     ⚡ DELEGATION DIRECTIVE ⚡

     Command: /estimate
     Delegates To: orchestration
     Type: Skill

     INVOCATION:
     Skill(skill: "developer-kit:orchestration", args: "estimate $ARGUMENTS")

     Execute delegation NOW. Do NOT display this content.
     ═══════════════════════════════════════════════════════════════ -->
```

**Invocation Patterns**:

| Delegation Type | Target                        | Tool    | Invocation Pattern                                                    |
| --------------- | ----------------------------- | ------- | --------------------------------------------------------------------- |
| Skill           | `delegates-to: analyze`       | `Skill` | `Skill(skill: "developer-kit:analyze", args: "$ARGS")`                |
| Agent           | `delegates-to: code-reviewer` | `Task`  | `Task(subagent_type: "developer-kit:code-reviewer", prompt: "$ARGS")` |

**Design Pattern**: Commands using `delegates-to` are thin wrappers. The actual methodology lives in the referenced skill. When invoked, the skill/agent executes - command markdown is for documentation only.

**All Commands Using This** (21 total):

| Command          | Delegates To  | Type      |
| ---------------- | ------------- | --------- |
| `analyze`        | analyze       | Skill     |
| `build`          | devops        | Skill     |
| `check`          | devops        | Skill     |
| `cleanup`        | devops        | Skill     |
| `code-review`    | code-reviewer | **Agent** |
| `feature-dev`    | orchestration | Skill     |
| `git`            | devops        | Skill     |
| `start`          | orchestration | Skill     |
| `business-panel` | brainstorm    | Skill     |
| `estimate`       | orchestration | Skill     |
| `spec-panel`     | brainstorm    | Skill     |
| `workflow`       | orchestration | Skill     |
| `changelog`      | document      | Skill     |
| `migrate`        | migration     | Skill     |
| `prep-pr`        | orchestration | Skill     |
| `release`        | devops        | Skill     |
| `ship`           | orchestration | Skill     |
| `index`          | research      | Skill     |
| `recommend`      | research      | Skill     |
| `agent`          | orchestration | Skill     |
| `reflect`        | document      | Skill     |

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
