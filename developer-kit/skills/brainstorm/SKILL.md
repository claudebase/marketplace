---
name: brainstorm
description: "Transforms vague ideas into concrete requirements through Socratic questioning and structured exploration. Use when the user has an unclear idea, isn't sure what they need, or wants to explore possibilities before committing to an approach. Triggers on requests like 'I'm thinking about', 'I'm not sure how to', 'help me figure out', 'explore ideas for', 'what should I consider', 'brainstorm with me', 'I have this vague idea', or 'help me clarify'. NOT for implementation (use implement) or research (use research)."
composable: true
mode: read-only
allowed-tools:
  - Read
  - Grep
  - Glob
  - AskUserQuestion
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  - mcp__github__search_repositories
  - mcp__github__search_code
  - mcp__github__get_file_contents
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  - mcp__sequential-thinking__sequentialthinking
---

# Brainstorm Skill

Transform vague ideas into concrete requirements through Socratic dialogue and market research.

## Quick Reference

**Activates**: "I want to build", "thinking about", "not sure how", "explore ideas", "help me figure out"
**Mode**: read-only (exploration only, no implementation)
**Output**: Requirements summary with problem statement, priorities, and next steps

## Workflow

```
DISCOVER → RESEARCH → EXPLORE → SYNTHESIZE → CRYSTALLIZE
```

## When to Use

- Vague ideas need clarification ("I want to build...")
- Uncertainty about approach ("not sure how to...")
- Market research needed ("what's out there?")
- Validating concepts ("is this a good idea?")

## When NOT to Use

- Clear requirements exist → use `design` skill
- Need external technical docs → use `research` skill
- Ready to implement → use `implement` skill

## References

- [Full Guide](references/guide.md) - Complete methodology, phases, MCP integration
- [Question Patterns](references/question-patterns.md) - Socratic question library
- [Exploration Framework](references/exploration-framework.md) - Systematic exploration

## Boundaries

**Will**: Ask probing questions, research market, find similar projects, summarize requirements
**Will Not**: Make final decisions, produce design specs, write code
