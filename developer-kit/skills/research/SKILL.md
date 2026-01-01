---
name: research
description: "Web research with multi-source verification. Activates for: research, find information, look up, find docs, best practices."
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
composable: true
mode: read-only
---

# Research Skill

Web research with adaptive planning, intelligent search, and multi-source verification.

## Quick Reference

**Activates for**: research, find information, look up, find docs, best practices, compare
**Mode**: read-only
**Output**: Verified findings with citations

## Workflow

```
PLAN → SEARCH → EVALUATE → SYNTHESIZE → DELIVER
```

## When to Use

- Research ("research [topic]", "find information about")
- Documentation ("find docs for [library]", "get documentation")
- Best practices ("what's the latest on", "find best practices")
- Comparisons ("compare X vs Y", "which is better")

## When NOT to Use

- Codebase exploration → use `Explore` agent
- Implementation help → use `implement` skill
- Bug fixing → use `debug` skill

## References

- [Full Guide](references/guide.md) - Complete workflow and depth levels
- [Search Strategies](references/search-strategies.md) - Query patterns
- [Source Evaluation](references/source-evaluation.md) - Verification
- [Docs Sources](references/docs-sources.md) - Documentation lookup

## Boundaries

**Will**: Research topics, find documentation, compare technologies, cite sources
**Will Not**: Implement code, fix bugs, explore codebases
