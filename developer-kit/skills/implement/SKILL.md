---
name: implement
description: "Implements features, components, and functionality following framework-specific patterns and best practices. Use when the user wants to add new functionality, create components, build APIs, or write new code. Triggers on requests like 'implement X', 'create a component for Y', 'build this feature', 'add a function that', 'write code to', 'develop this', 'code this for me', 'make a new endpoint', or 'add this functionality'. NOT for fixing bugs (use debug) or improving existing code (use improve)."
composable: true
mode: read-write
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - Edit
  - Write
  - TodoWrite
  - Task
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  - mcp__github__search_code
  - mcp__github__get_file_contents
  - mcp__tavily__tavily-search
  - mcp__shadcn__search_items_in_registries
  - mcp__shadcn__view_items_in_registries
  - mcp__shadcn__get_add_command_for_items
  - mcp__playwright__browser_navigate
  - mcp__playwright__browser_snapshot
  - mcp__sequential-thinking__sequentialthinking
---

# Implement Skill

Feature and code implementation with framework-specific best practices.

## Quick Reference

**Activates for**: implement, create, build, develop, add feature, write function
**Mode**: read-write
**Output**: Production-ready code following framework conventions

## Workflow

```
UNDERSTAND → RESEARCH → PLAN → IMPLEMENT → VERIFY
```

## When to Use

- Feature implementation ("implement X", "create component")
- API development ("add endpoint", "create API route")
- UI components ("build form", "create page")
- Service development ("add functionality", "code this")

## When NOT to Use

- Code analysis → use `analyze` skill
- Multi-domain orchestration → use `orchestration` skill
- Performance optimization → use `performance` skill
- Bug fixing → use `debug` skill

## References

- [Full Guide](references/guide.md) - Complete workflow and patterns
- [Implementation Patterns](references/implementation-patterns.md) - Framework patterns

## Boundaries

**Will**: Implement features, create components, build APIs, integrate UI
**Will Not**: Analyze code quality, orchestrate multi-domain tasks, optimize performance
