---
name: explain
description: "Educational explanations of code, concepts, and system behavior (READ-ONLY - teaches understanding without modifying code). For creating documentation artifacts, use 'document' skill. Activates for: what does this do, how does this work, explain this, teach me about, help me understand, walk me through."
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
---

# Code Explanation Skill

Provide clear, educational explanations of code, concepts, and system behavior using official documentation and progressive teaching.

**Core Principle**: "Teach, don't just describe. Build understanding progressively."

**Key Distinction**: EXPLAINS concepts (read-only). For documentation files use `document`. For analysis use `analyze`.

## When to Use

- Understanding ("what does this do", "how does this work")
- Learning ("explain this", "teach me about")
- Clarification ("help me understand", "walk me through")
- Concepts ("what is", "why would I use", "what's the difference")

## When NOT to Use

- Creating documentation files → use `document` skill
- Code analysis/review → use `analyze` skill
- Finding bugs → use `debug` skill
- Improving code → use `improve` skill

## Quick Workflow

```
ANALYZE → RESEARCH → STRUCTURE → EXPLAIN → CONNECT
  Read    Context7   Sequential   Output   References
  Grep    GitHub     Thinking
          Tavily
```

1. **Analyze** - Read code, identify key concepts
2. **Research** - Lookup official docs, find examples
3. **Structure** - Plan depth level, organize concepts
4. **Explain** - Build understanding progressively
5. **Connect** - Link to related concepts

## Tool Integration

For library IDs and patterns, see:

- [MCP Resources](../../lib/shared-references/mcp-resources.md)
- [Tool Patterns](../../lib/shared-references/tool-integration-patterns.md)

### Key Resources

| Resource        | Library ID                                   | Use Case       |
| --------------- | -------------------------------------------- | -------------- |
| MDN Web Docs    | `/mdn/content`                               | Web concepts   |
| React           | `/reactjs/react.dev`                         | React patterns |
| TypeScript      | `/websites/typescriptlang`                   | TS concepts    |
| Design Patterns | `/websites/refactoring_guru-design-patterns` | Patterns       |
| Node.js         | `/websites/nodejs_api`                       | Node concepts  |

## Explanation Depth

| Level        | Audience     | Focus                    |
| ------------ | ------------ | ------------------------ |
| Beginner     | New          | Why it exists, analogies |
| Intermediate | Knows basics | How it works, patterns   |
| Advanced     | Experienced  | Edge cases, internals    |

## References

- [Detailed Guide](references/guide.md) - Full workflow and phases
- [Explanation Styles](references/guide.md#explanation-styles) - Beginner, System, Deep-dive
- [Teaching Techniques](references/guide.md#teaching-techniques) - Analogies, misconceptions
- [Output Format](references/guide.md#output-format) - Structured explanation template

## Boundaries

**Will**: Explain concepts, research docs, use analogies, adapt to user level

**Will Not**: Create files, modify code, make architectural decisions
