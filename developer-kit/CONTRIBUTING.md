# Contributing to Developer Kit

Welcome! This guide explains how to extend the Developer Kit plugin.

## Quick Reference

| Component | Location | Purpose |
|-----------|----------|---------|
| Skills | `skills/<name>/SKILL.md` | Teach Claude patterns and methodologies |
| Agents | `agents/<name>.md` | Specialized workers with isolated context |
| Commands | `commands/dk/<category>/<name>.md` | User-invoked workflows |
| Hooks | `hooks/hooks.json` | Event-driven automation |
| Templates | `templates/<category>/` | Infrastructure scaffolds |

## Adding a New Skill

### 1. Create the skill directory

```bash
mkdir -p skills/my-skill/references
```

### 2. Create SKILL.md

```markdown
---
name: my-skill
description: "Brief purpose. Activates for: 'trigger1', 'trigger2', 'trigger3'."
allowed-tools:
  - Read
  - Grep
  - Glob
---

# My Skill

## Purpose

[What this skill does and when to use it]

## When to Use

**Activate When:**
- [Condition 1]
- [Condition 2]

**Do NOT Activate When:**
- [Condition] → use `other-skill` skill

## Methodology

[Step-by-step approach]

## Output Format

[Expected output structure]

## Reference Files

For detailed documentation, see:
- `references/guide.md` - [Description]
```

### 3. Add trigger phrases

Include 5-8 trigger phrases in the description:

```yaml
description: "Brief purpose. Activates for: 'phrase1', 'phrase2', 'phrase3'..."
```

### 4. Add references (optional)

For complex skills, use progressive disclosure:

```
skills/my-skill/
├── SKILL.md
└── references/
    ├── detailed-guide.md
    └── examples.md
```

### 5. Validate

```bash
./scripts/validate-components.sh
```

## Adding a New Agent

### 1. Create agent file

```bash
touch agents/my-agent.md
```

### 2. Write agent definition

```markdown
---
name: my-agent
description: "[Responsibility]. Use when: '[trigger1]', '[trigger2]'."
tools: Read, Grep, Glob
model: sonnet
permissionMode: default
skills: skill1, skill2
---

# My Agent

## Triggers

Activate when user:
- [Trigger condition 1]
- [Trigger condition 2]

## Behavioral Mindset

You are a [role] with expertise in [domain].

**Core Principles:**
- [Principle 1]
- [Principle 2]

## Focus Areas

1. **[Area 1]**: [Detail]
2. **[Area 2]**: [Detail]

## Key Actions

1. [Action 1]
2. [Action 2]

## Boundaries

**Do:**
- [Guideline 1]

**Don't:**
- [Anti-pattern 1]
```

### 3. Test autodiscovery

Ask Claude: "Use the my-agent agent to..."

## Adding a New Command

### 1. Choose category

| Category | Purpose |
|----------|---------|
| `session/` | Session management |
| `development/` | Development workflows |
| `documentation/` | Documentation tasks |
| `planning/` | Planning and estimation |
| `release/` | Release management |

### 2. Create command file

```markdown
---
name: my-command
description: Brief description
delegates-to: skill-name
operation: specific-operation
argument-hint: "<arg1> [--flag]"
---

Execute the **skill-name** skill.

## Delegation

This command delegates to the `skill-name` skill which provides:
- [Capability 1]
- [Capability 2]

## Parameters

| Parameter | Description |
|-----------|-------------|
| `arg1` | [Description] |
| `--flag` | [Description] |

## Examples

```bash
my-command arg1
my-command --flag
```
```

### 3. Prefer delegation

Commands should be thin orchestration layers. Put logic in skills:

```yaml
delegates-to: existing-skill
operation: specific-operation
```

## Modifying Hooks

### Hook events

| Event | Timing | Purpose |
|-------|--------|---------|
| PreToolUse | Before tool execution | Validate, modify, or block |
| PostToolUse | After tool execution | Format, validate, log |
| SessionStart | On session start | Initialize, show welcome |
| UserPromptSubmit | On user input | Add context, validate |
| Stop | Before Claude stops | Validate completion |
| SubagentStop | Before subagent stops | Validate agent completion |

### Adding a hook

1. Edit `hooks/hooks.json`:

```json
{
  "EventName": [
    {
      "matcher": "ToolPattern",
      "hooks": [
        {
          "type": "command",
          "command": "python3 ${CLAUDE_PLUGIN_ROOT}/hooks/my-hook.py",
          "timeout": 10
        }
      ]
    }
  ]
}
```

2. Create hook script in `hooks/`

3. Make executable: `chmod +x hooks/my-hook.py`

4. Test: `echo '{}' | python3 hooks/my-hook.py`

### Hook exit codes

| Code | Meaning |
|------|---------|
| 0 | Success, continue |
| 2 | Block operation (stderr shown) |
| Other | Non-blocking error |

## Code Style

- Use **kebab-case** for component names
- Keep SKILL.md under **500 lines**
- Include **explicit trigger phrases** in descriptions
- Document **boundaries** (Do/Don't)
- Prefer **progressive disclosure** (main file + references)

## Testing

```bash
# Full validation
./scripts/validate-components.sh

# Check for stale references
grep -r "old-name" skills/ commands/ agents/

# Test hook scripts
echo '{}' | python3 hooks/my-hook.py
```

## Version Bumping

When releasing a new version:

1. Update `.claude-plugin/plugin.json` version
2. Update `hooks/hooks.json` SessionStart message
3. Update `CHANGELOG.md`
4. Create git tag: `git tag -a vX.Y.Z -m "vX.Y.Z"`

## Component Relationships

```
Commands (User Interface)
    ↓ delegates to
Skills (Core Capabilities)
    ↓ uses
MCP Tools (Extended Functionality)

Agents reference Skills via `skills:` frontmatter
Hooks execute on events (Pre/Post tool use, session events)
```

## Trigger Reference

See `skills/TRIGGER-REFERENCE.md` for a complete list of skill activation phrases.

## Questions?

- Check existing documentation in `docs/`
- Review similar components for patterns
- Open an issue for discussion
