---
name: skill-name
description: "[Purpose statement]. Activates for: '[trigger1]', '[trigger2]', '[trigger3]'. [Capability notes - e.g., READ-ONLY or modes available]."
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
---

# [Skill Name] Skill

## Purpose

[1-2 sentences describing what this skill does and why it exists]

**Key Guarantee**: [Any important guarantees, e.g., "READ-ONLY - never modifies code"]

## When to Use

**Activate When:**
- [User action or phrase that triggers this skill]
- [Another trigger condition]
- [Another trigger condition]

**Do NOT Activate When:**
- [Condition] → use `[other-skill]` skill
- [Condition] → use `[other-skill]` skill

**Boundary Clarification:**
[Explain how this skill differs from related skills. This prevents activation conflicts.]

## Methodology

1. **[Phase 1 Name]**: [Description of what happens in this phase]
2. **[Phase 2 Name]**: [Description of what happens in this phase]
3. **[Phase 3 Name]**: [Description of what happens in this phase]

## [Optional: Modes/Tiers]

If your skill has multiple modes or tiers, document them here.

### [Mode 1 Name]

**When to use:** [Condition that triggers this mode]

**Methodology:**
1. [Step 1]
2. [Step 2]

### [Mode 2 Name]

**When to use:** [Condition that triggers this mode]

**Methodology:**
1. [Step 1]
2. [Step 2]

## MCP Integration

If your skill uses MCP servers, document the integration:

**Use [MCP Server] for [purpose]:**
```
mcp__[server]__[tool] - [When and how to use this tool]
```

## Output Format

Define the expected output structure:

```markdown
## [Output Title]

### [Section 1]
- [Key information]
- [Key information]

### [Section 2]
[Detailed content]

### [Metrics/Summary]
| Metric | Value |
|--------|-------|
| [Metric 1] | [Value] |
```

## Reference Files

For detailed documentation, create reference files in the `references/` subdirectory:

- `references/[ref1].md` - [Description of what this reference covers]
- `references/[ref2].md` - [Description of what this reference covers]

## Related Skills

Document relationships to other skills:

- `[skill-name]` - [How this skill relates, e.g., "Use for X instead of this skill"]
- `[skill-name]` - [Relationship description]
