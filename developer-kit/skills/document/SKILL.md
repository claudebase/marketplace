---
name: document
description: "Creates structured documentation artifacts including READMEs, API documentation, JSDoc comments, and technical guides. Use when the user needs documentation files created or updated for their code, APIs, or projects. Triggers on requests like 'write a README', 'document this API', 'add JSDoc comments', 'create documentation for', 'write docs for this', 'generate API docs', 'add docstrings', or 'create a technical guide'. NOT for explaining code verbally (use explain) or inline code comments during implementation."
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

Generate focused, high-quality documentation for code, APIs, and features.

## Quick Reference

**Activates for**: document, README, API docs, write docs, docstring, JSDoc
**Mode**: read-write
**Output**: Documentation files (README, API docs, JSDoc/TSDoc)

## Workflow

```
ANALYZE → RESEARCH → PLAN → GENERATE → INTEGRATE
```

## When to Use

- Documentation creation ("document this", "add documentation")
- README generation ("generate README", "create README")
- API documentation ("create API docs", "document endpoints")
- Code comments ("write JSDoc", "add docstrings")

## When NOT to Use

- Understand code → use `explain` skill
- Code analysis → use `analyze` skill
- Design systems → use `design` skill
- Professional tech writing → use `technical-writer` agent

## References

- [Full Guide](references/guide.md) - Complete workflow and phases
- [Doc Templates](references/doc-templates.md) - README, API docs templates
- [JSDoc Patterns](references/jsdoc-patterns.md) - JSDoc/TSDoc patterns

## Boundaries

**Will**: Generate READMEs, write JSDoc/TSDoc, create API docs, document props
**Will NOT**: Explain code without files, comprehensive doc sites, design APIs
