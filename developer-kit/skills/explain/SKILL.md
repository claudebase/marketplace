---
name: explain
description: "Educational code/concept explanations with examples. Activates for: explain, what does this do, how does this work, teach me."
allowed-tools:
  - Read
  - Grep
  - Glob
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  - mcp__github__search_code
  - mcp__github__get_file_contents
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  - mcp__sequential-thinking__sequentialthinking
composable: true
mode: read-only
---

# Explain Skill

Clear, educational explanations of code, concepts, and system behavior.

## Quick Reference

**Activates for**: explain, what does this do, how does this work, teach me, help me understand
**Mode**: read-only (explains only, never modifies)
**Output**: Progressive explanations with examples and analogies

## Workflow

```
ANALYZE → RESEARCH → STRUCTURE → EXPLAIN → CONNECT
```

## When to Use

- Understanding ("what does this do", "how does this work")
- Learning ("explain this", "teach me about")
- Clarification ("help me understand", "walk me through")
- Concepts ("what is", "why would I use")

## When NOT to Use

- Creating documentation files → use `document` skill
- Code analysis/review → use `analyze` skill
- Finding bugs → use `debug` skill
- Improving code → use `improve` skill

## References

- [Full Guide](references/guide.md) - Complete workflow and phases
- [Explanation Styles](references/guide.md#explanation-styles) - Beginner, System, Deep-dive
- [Teaching Techniques](references/guide.md#teaching-techniques) - Analogies, misconceptions

## Boundaries

**Will**: Explain concepts, research docs, use analogies, adapt to user level
**Will Not**: Create files, modify code, make architectural decisions
