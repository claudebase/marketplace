---
name: debug
description: "Tiered debugging methodology (quick→systematic→RCA). Activates for: debug, fix bug, not working, error, broken, troubleshoot."
composable: true
mode: read-write
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - Edit
  - Write
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  - mcp__github__search_issues
  - mcp__github__search_code
  - mcp__github__get_file_contents
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  - mcp__sequential-thinking__sequentialthinking
---

# Debug Skill

Evidence-based debugging through tiered investigation methodology.

## Quick Reference

**Activates for**: debug, fix bug, not working, error, broken, troubleshoot, crashes
**Mode**: read-write
**Output**: Root cause identification and verified fix

## Workflow

```
OBSERVE → RESEARCH → HYPOTHESIZE → FIX → VERIFY
```

## Tiered Approach

- **Tier 1**: Clear error, simple fix → Quick research & fix
- **Tier 2**: Multi-file, unclear cause → Systematic investigation
- **Tier 3**: Recurring, 3+ failed attempts → Deep root cause analysis

## When to Use

- Bug reports, error investigation, build failures, runtime issues

## When NOT to Use

- Code analysis only → use `analyze` skill
- Improving working code → use `improve` skill
- Performance diagnosis → use `performance` skill

## References

- [Full Guide](references/guide.md) - Tiered methodology details
- [Tier Selection](references/guide.md#tier-selection-guide) - Which tier to use
- [Error Patterns](references/guide.md#common-error-research-patterns) - Common fixes

## Boundaries

**Will**: Investigate bugs, research errors, apply evidence-based fixes
**Will Not**: Guess at fixes, skip verification, ignore recurring patterns
