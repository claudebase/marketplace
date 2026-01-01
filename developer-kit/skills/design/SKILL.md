---
name: design
description: "Architecture and API design before implementation. Activates for: design, architect, API spec, system design, schema design."
composable: true
mode: read-write
allowed-tools:
  - Read
  - Grep
  - Glob
  - Write
  - Edit
  - Task
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  - mcp__github__search_code
  - mcp__github__get_file_contents
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  - mcp__playwright__browser_navigate
  - mcp__playwright__browser_snapshot
  - mcp__sequential-thinking__sequentialthinking
---

# Design Skill

Architecture, API, and database design specifications with justified decisions.

## Quick Reference

**Activates for**: design, architect, API spec, system design, schema design
**Mode**: read-write
**Output**: Concrete specifications with diagrams and ADRs

## Workflow

```
ANALYZE → RESEARCH → DESIGN → SPECIFY → VALIDATE
```

## When to Use

- System architecture ("design a system", "architect this")
- API design ("create API spec", "OpenAPI schema")
- Database design ("database schema", "data model")
- Component design ("interface definition", "component API")

## When NOT to Use

- Exploring ideas → use `brainstorm` skill
- Implementing code → use `implement` skill
- Documenting existing code → use `document` skill
- Database optimization → use `database` skill

## References

- [Full Guide](references/guide.md) - Complete workflow and MCP integration
- [Design Types](references/guide.md#design-types) - Architecture, API, Database
- [Design Principles](references/guide.md#design-principles) - Patterns and rationale
- [ADR Template](references/guide.md#architecture-decision-records-adr) - Decision docs

## Boundaries

**Will**: Create architecture diagrams, API specs, database schemas, interface contracts
**Will Not**: Implement systems, optimize queries, set up infrastructure
