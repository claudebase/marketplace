---
name: research
description: "Web research with adaptive planning and intelligent search. Supports depth levels (quick/standard/deep/exhaustive) and modes (--docs, --web). This skill should be used when the user asks to 'research [topic]', 'find information about', 'look up', 'search for', or 'find docs for [library]'. Also use when user mentions finding best practices or latest updates."
allowed-tools:
  - Read
  - Grep
  - Glob
  - Write
  - WebFetch
  - WebSearch
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  - mcp__playwright__browser_navigate
  - mcp__playwright__browser_snapshot
  - mcp__sequential-thinking__sequentialthinking
  - mcp__github__search_code
  - mcp__github__search_repositories
---

# Research Skill

Web research with adaptive planning, intelligent search, and multi-source verification.

**Core Principle**: "Search smart, verify always, cite everything."

## When to Use

- Research ("research [topic]", "find information about")
- Documentation ("find docs for [library]", "get documentation")
- Best practices ("what's the latest on", "find best practices")
- Comparisons ("compare X vs Y", "which is better")

## When NOT to Use

- Codebase exploration → use `Explore` agent
- Implementation help → use `implement` skill
- Bug fixing → use `debug` skill

## Depth Levels

| Level      | Queries | Time    | Use Case           |
| ---------- | ------- | ------- | ------------------ |
| quick      | 1-3     | <1min   | Quick facts        |
| standard   | 5-10    | 2-5min  | General research   |
| deep       | 10-20   | 5-10min | Comprehensive      |
| exhaustive | 20+     | 15+min  | Full investigation |

## Modes

- `--docs`: Documentation focus (Context7, official docs)
- `--web`: General web research (Tavily, WebSearch)

## Quick Workflow

```
PLAN → SEARCH → EVALUATE → SYNTHESIZE → DELIVER
Sequential   Tavily    Read/Verify   Write      Report
Thinking    Context7
            GitHub
```

1. **Plan** - Define search strategy based on depth
2. **Search** - Execute multi-source queries
3. **Evaluate** - Verify sources, check recency
4. **Synthesize** - Combine findings, resolve conflicts
5. **Deliver** - Present with citations

## Tool Integration

For library IDs and patterns, see:

- [MCP Resources](../../lib/shared-references/mcp-resources.md)
- [Tool Patterns](../../lib/shared-references/tool-integration-patterns.md)

## References

- [Search Strategies](references/search-strategies.md) - Query patterns
- [Source Evaluation](references/source-evaluation.md) - Verification
- [Docs Sources](references/docs-sources.md) - Documentation lookup
- [Multi-hop Patterns](references/multi-hop-patterns.md) - Complex research

## Boundaries

**Will**: Research topics, find documentation, compare technologies, cite sources

**Will Not**: Implement code, fix bugs, explore codebases
