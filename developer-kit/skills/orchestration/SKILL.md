---
name: orchestration
description: "Complex task breakdown with dependency management. Activates for: orchestrate, break down, complex task, multi-step, workflow."
composable: true
mode: meta
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - Edit
  - Write
  - TodoWrite
  - Task
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  - mcp__github__search_code
  - mcp__tavily__tavily-search
  - mcp__sequential-thinking__sequentialthinking
---

# Orchestration Skill

Meta-system task orchestration with intelligent breakdown and dependency management.

## Quick Reference

**Activates for**: orchestrate, break down, complex task, multi-step, workflow
**Mode**: meta (coordinates other skills/agents)
**Output**: Executed workflow with tracked progress

## Workflow

```
ANALYZE → RESEARCH → DECOMPOSE → EXECUTE → INTEGRATE
```

## When to Use

- Complex multi-domain operations requiring intelligent breakdown
- Large-scale system operations spanning multiple areas
- Operations requiring parallel coordination and dependencies
- Projects needing structured workflow management

## When NOT to Use

- Single-step operations → use `implement` skill
- Simple file changes → use direct Edit/Write
- Test execution → use `test` skill
- Code review → use `analyze` skill

## References

- [Full Guide](references/guide.md) - Complete workflow and phases
- [Breakdown Patterns](references/breakdown-patterns.md) - Task decomposition
- [Coordination Strategies](references/coordination-strategies.md) - Parallel vs sequential
- [Failure Handling](references/failure-handling.md) - Retry and compensation

## Boundaries

**Will**: Decompose complex operations, coordinate parallel execution, track progress
**Will NOT**: Replace simple commands, override user preferences, skip dependency analysis
