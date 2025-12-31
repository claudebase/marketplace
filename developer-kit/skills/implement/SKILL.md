---
name: implement
description: "Feature and code implementation with framework-specific best practices. Auto-invoke when user asks to 'implement', 'create', 'build', or 'develop' something. Auto-invoke when user requests 'code this', 'add functionality', 'make a component', or 'build feature'. Do NOT load for analysis-only, debugging, or review tasks."
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
composable: true
mode: read-write
---

# Implement Skill

Feature and code implementation with framework-specific best practices using official documentation and real-world patterns.

**Core Principle**: "Implement features that follow framework conventions, are type-safe, and integrate cleanly."

## When to Use

- Feature implementation ("implement X", "create component", "build feature")
- API development ("add endpoint", "create API route")
- UI components ("build form", "create page", "add component")
- Service development ("add functionality", "code this")

## When NOT to Use

- Code analysis → use `analyze` skill
- Multi-domain orchestration → use `orchestration` skill
- Performance optimization → use `performance` skill
- Bug fixing → use `debug` skill

## Quick Workflow

```
UNDERSTAND → RESEARCH → PLAN → IMPLEMENT → VERIFY
   Read        Context7   Sequential   Write      Bash
   Grep        GitHub     Thinking     Edit       Playwright
               shadcn
```

1. **Understand** - Read existing code, identify patterns
2. **Research** - Query Context7 for framework docs, search examples
3. **Plan** - Break down into tasks, identify components
4. **Implement** - Write code following framework conventions
5. **Verify** - Test implementation, validate UI

## Tool Integration

For library IDs and patterns, see:

- [MCP Resources](../../lib/shared-references/mcp-resources.md)
- [Tool Patterns](../../lib/shared-references/tool-integration-patterns.md)

### Key Resources

| Resource | Library ID                   | Use Case         |
| -------- | ---------------------------- | ---------------- |
| React    | `/facebook/react`            | UI components    |
| Next.js  | `/vercel/next.js`            | Full-stack React |
| FastAPI  | `/websites/fastapi_tiangolo` | Python APIs      |
| shadcn   | MCP: shadcn                  | UI components    |

## References

- [Implementation Patterns](references/implementation-patterns.md) - Framework patterns

## Boundaries

**Will**: Implement features, create components, build APIs, integrate UI

**Will Not**: Analyze code quality, orchestrate multi-domain tasks, optimize performance
