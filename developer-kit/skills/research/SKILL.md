---
name: research
description: "Performs comprehensive web research on ANY topic with multi-source verification and structured analysis. Use for ALL research requests regardless of domain - technical documentation, market analysis, product comparisons, industry trends, financial research, competitive analysis, or learning about unfamiliar concepts. Triggers on: 'research [topic]', 'deep research', 'find information about', 'look up', 'what is X', 'how does Y work', 'what's the latest on', 'analyze [topic]', 'compare X vs Y'. This is the DEFAULT skill for any research or information gathering task."
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

**Activates for**: research, deep research, find information, look up, analyze, compare X vs Y, what is, how does X work, what's the latest on, market analysis, find docs
**Mode**: read-only
**Output**: Verified findings with citations

## Workflow

```
PLAN → SEARCH → EVALUATE → SYNTHESIZE → DELIVER
```

## When to Use

- **Any research request** ("research [topic]", "deep research", "find information about")
- Technical documentation ("find docs for [library]", "get documentation")
- Market/financial research ("analyze stock", "market trends", "investment research")
- Product/technology comparisons ("compare X vs Y", "which is better")
- Industry analysis ("what's the latest on", "trends in [field]")
- Learning ("what is X", "how does Y work", "explain [concept]")

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

**Will**: Research ANY topic (technical, financial, market, industry), find documentation, compare options, analyze data, cite sources
**Will Not**: Implement code, fix bugs, explore codebases
