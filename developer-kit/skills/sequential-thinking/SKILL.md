---
name: sequential-thinking
description: "Enables structured problem-solving through iterative reasoning with revision and branching for complex decisions. Use when facing a complex problem that requires systematic thinking, multiple considerations, or careful analysis. Triggers on requests like 'think through this', 'step by step analysis', 'reason about', 'analyze systematically', 'break down this problem', 'consider all angles', or 'help me think through'. This is a reasoning meta-skill that can be combined with other skills."
license: MIT
composable: true
mode: meta
allowed-tools:
  - mcp__sequential-thinking__sequentialthinking
---

# Sequential Thinking Skill

Structured problem-solving through iterative reasoning with revision and branching.

## Quick Reference

**Activates for**: think through, step by step, break down, analyze systematically, reason about
**Mode**: meta (reasoning orchestration)
**Output**: Structured thought chain with conclusions

## Workflow

```
THINK → ADJUST → REVISE → BRANCH → CONCLUDE
```

## When to Use

- Complex problems requiring multiple reasoning steps
- Uncertain scope or approach
- May need to backtrack or revise conclusions
- Exploring alternative solution paths

## When NOT to Use

- Simple queries with direct answers
- Single-step tasks
- Factual lookups

## References

- [Full Guide](references/guide.md) - Parameters, workflow patterns, examples
- [Advanced Usage](references/advanced.md) - Revision and branching patterns
- [Examples](references/examples.md) - Real-world use cases

## Boundaries

**Will**: Break down problems, track reasoning, revise conclusions, explore branches
**Will Not**: Make final decisions without evidence, skip verification steps
