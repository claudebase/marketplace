---
name: document
description: "Create documentation artifacts (README, API docs, JSDoc/docstrings, guides). This skill should be used when the user asks to 'document this', 'create API docs', 'generate README', or 'add documentation'. Also use when user mentions writing JSDoc, adding docstrings, or creating guides. For explanations, use explain skill; for professional writing, use technical-writer agent."
composable: true
mode: read-write
allowed-tools:
  - Read
  - Grep
  - Glob
  - Write
  - Edit
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  - mcp__github__search_code
  - mcp__github__get_file_contents
  - mcp__tavily__tavily-search
  - mcp__sequential-thinking__sequentialthinking
---

# Document Skill

Generate focused, high-quality documentation for code components, APIs, and features.

**Core Principle**: "Good documentation is written for the reader, not the writer."

**Key Distinction**: This skill CREATES documentation artifacts. For explanations without files, use `explain` skill. For professional tech writing, use `technical-writer` agent.

## When to Use

- Documentation creation ("document this", "add documentation")
- README generation ("generate README", "create README")
- API documentation ("create API docs", "document endpoints")
- Code comments ("write JSDoc", "add docstrings")
- Guides ("create guide", "write tutorial")

## When NOT to Use

- Understand code → use `explain` skill
- Code analysis → use `analyze` skill
- Design systems → use `design` skill
- Professional tech writing → use `technical-writer` agent

## Quick Workflow

```
ANALYZE → RESEARCH → PLAN → GENERATE → INTEGRATE
  Read     Context7   Sequential   Write     Read
  Grep     GitHub     Thinking     Edit      Grep
           Tavily
```

1. **Analyze** - Read code, identify public API and exports
2. **Research** - Query Context7 for JSDoc/TypeDoc standards
3. **Plan** - Structure content, identify audience and purpose
4. **Generate** - Write documentation with examples
5. **Integrate** - Cross-reference and validate

## Tool Integration

For library IDs and patterns, see:

- [MCP Resources](../../lib/shared-references/mcp-resources.md)
- [Tool Patterns](../../lib/shared-references/tool-integration-patterns.md)

### Key Resources

| Resource   | Library ID               | Use Case         |
| ---------- | ------------------------ | ---------------- |
| JSDoc      | `/jsdoc/jsdoc.github.io` | JS documentation |
| TypeDoc    | `/typestrong/typedoc`    | TS documentation |
| TSDoc      | `/microsoft/tsdoc`       | TS doc standard  |
| Docusaurus | `/facebook/docusaurus`   | Doc sites        |

## References

- [Detailed Guide](references/guide.md) - Full workflow and phases
- [Doc Templates](references/doc-templates.md) - README, API docs templates
- [JSDoc Patterns](references/jsdoc-patterns.md) - JSDoc/TSDoc patterns

## Boundaries

**Will**: Generate READMEs, write JSDoc/TSDoc, create API docs, document component props, apply consistent formatting

**Will NOT**: Explain code without files (use `explain`), comprehensive doc sites (use `technical-writer`), design APIs (use `design`)
