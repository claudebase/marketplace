---
name: improve
description: "Systematically improves working code through refactoring, optimization, and modernization while preserving functionality. Use when the user has working code that needs to be cleaner, faster, more readable, or more maintainable. Triggers on requests like 'improve this code', 'refactor this', 'clean up this code', 'optimize this', 'make this more readable', 'simplify this', 'modernize this code', 'reduce complexity', or 'make this better'. NOT for fixing broken code (use debug) or adding new features (use implement)."
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
  - mcp__github__search_code
  - mcp__github__get_file_contents
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  - mcp__sequential-thinking__sequentialthinking
---

# Improve Skill

Systematic improvements to working code through evidence-based refactoring.

## Quick Reference

**Activates for**: improve, optimize, refactor, clean up, simplify, modernize
**Mode**: read-write
**Output**: Improved code with verified no regressions

## Workflow

```
ANALYZE → RESEARCH → PLAN → APPLY → VERIFY
```

## Golden Rules

1. Working code first - never break functionality
2. Small steps - one refactoring at a time
3. Test after each change - verify continuously

## When to Use

- Code improvement, refactoring, optimization, quality enhancement

## When NOT to Use

- Code is broken → use `debug` skill
- Analysis only → use `analyze` skill
- Performance profiling → use `performance` skill

## References

- [Full Guide](references/guide.md) - Complete workflow and phases
- [Code Smells](references/guide.md#1-code-quality---code-smells-and-fixes) - Smell catalog
- [Refactoring Catalog](references/guide.md#refactoring-catalog) - Pattern reference

## Boundaries

**Will**: Apply refactoring patterns, research best practices, verify no regressions
**Will Not**: Fix broken code, skip verification, apply multiple changes at once
