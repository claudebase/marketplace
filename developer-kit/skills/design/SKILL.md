---
name: design
description: "MUST USE before implementing significant features. Triggers: 'design', 'architect', 'API spec', 'schema design', 'system design', 'how should I structure', 'plan the architecture', 'component interface'. Provides concrete specifications and diagrams. DO NOT start implementing without architecture - this skill prevents costly rewrites."
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

# System Design Skill

Create comprehensive design specifications for systems, APIs, databases, and components with official documentation and real-world patterns.

**Core Principle**: "Design with intent. Every decision should be justified with rationale."

**Key Distinction**: Produces CONCRETE specs. For exploration use `brainstorm`, for implementation use `implement`.

## When to Use

- System architecture ("design a system", "architect this")
- API design ("create API spec", "OpenAPI schema")
- Database design ("database schema", "data model", "ERD")
- Component design ("interface definition", "component API")

## When NOT to Use

- Exploring ideas → use `brainstorm` skill
- Implementing code → use `implement` skill
- Documenting existing code → use `document` skill
- Database optimization → use `database` skill

## Quick Workflow

```
ANALYZE → RESEARCH → DESIGN → SPECIFY → VALIDATE
  Read    Context7  Sequential  Write   Playwright
  Grep    GitHub    Thinking    Edit
          Tavily
```

1. **Analyze** - Requirements, stakeholders, constraints
2. **Research** - Official specs, patterns, best practices
3. **Design** - Architectural decisions with reasoning
4. **Specify** - Create diagrams, schemas, contracts
5. **Validate** - Review against requirements

## Tool Integration

For library IDs and patterns, see:

- [MCP Resources](../../lib/shared-references/mcp-resources.md)
- [Tool Patterns](../../lib/shared-references/tool-integration-patterns.md)

### Key Resources

| Resource | Library ID                           | Use Case              |
| -------- | ------------------------------------ | --------------------- |
| OpenAPI  | `/websites/swagger_io_specification` | REST API specs        |
| GraphQL  | `/graphql/graphql.github.io`         | GraphQL schemas       |
| C4 Model | `/websites/c4model`                  | Architecture diagrams |
| tRPC     | `/trpc/trpc`                         | Type-safe APIs        |

## References

- [Detailed Guide](references/guide.md) - Full workflow and MCP integration
- [Design Types](references/guide.md#design-types) - Architecture, API, Database, Component
- [Design Principles](references/guide.md#design-principles) - Architecture, API, Data patterns
- [ADR Template](references/guide.md#architecture-decision-records-adr) - Decision documentation

## Boundaries

**Will**: Create architecture diagrams, API specs, database schemas, interface contracts, ADRs

**Will Not**: Implement systems, optimize queries, set up infrastructure, build UI components
