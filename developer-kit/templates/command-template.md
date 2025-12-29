---
name: command-name
description: [Brief description of what this command does]
argument-hint: "<required-arg> [optional-arg] [--flag] [--option value]"
allowed-tools: Read, Grep, Glob, Bash
---

# command-name

[1-2 sentence description of the command's purpose and primary use case]

## Usage

```bash
command-name <required>                    # Basic usage
command-name <required> [optional]         # With optional arg
command-name <required> --flag             # With flag
command-name <required> --option value     # With option
```

## Parameters

| Parameter | Required | Description |
|-----------|----------|-------------|
| `<required-arg>` | Yes | [Description of this parameter] |
| `[optional-arg]` | No | [Description, default behavior if omitted] |
| `--flag` | No | [What this flag enables] |
| `--option` | No | [Description, default: X] |

## What It Does

Describe the command's behavior step by step:

1. [First action the command takes]
2. [Second action]
3. [Third action]
4. [Final action or output]

## Output Format

**Success:**
```markdown
## [Output Title]

### [Section 1]
[Expected output content]

### [Section 2]
[Expected output content]
```

**Error:**
```markdown
## Error: [Error Type]

[Error message explaining what went wrong]

**Resolution:** [How to fix the error]
```

## Examples

```bash
# Example 1: Basic usage
command-name my-feature
# [Brief description of what this does]

# Example 2: With options
command-name my-feature --flag
# [Brief description of what this does]

# Example 3: Full usage
command-name my-feature optional-value --option custom
# [Brief description of what this does]
```

## [Optional: Delegation]

If this command delegates to a skill or agent, document it:

This command delegates to the `[skill-name]` skill, which provides:
- [Capability 1]
- [Capability 2]

See `skills/[skill-name]/SKILL.md` for detailed methodology.

## Related

- `[skill-name]` skill - [Relationship]
- `[agent-name]` agent - [Relationship]
- `[other-command]` - [Relationship or when to use instead]
