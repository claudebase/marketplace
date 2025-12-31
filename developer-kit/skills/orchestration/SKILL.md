---
name: orchestration
description: "Meta-system task orchestration with intelligent breakdown and workflow management. This skill should be used when the user asks to 'orchestrate', 'break down', 'coordinate', or 'manage tasks'. Also use when user mentions multi-step operations, complex workflows, hierarchical coordination, or spawning subtasks."
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

Meta-system task orchestration with intelligent breakdown, dependency management, and workflow coordination.

**Core Principle**: "Break complex operations into coordinated hierarchies. Execute with optimal parallelism while respecting dependencies."

**Key Distinction**: This skill ORCHESTRATES complex multi-step operations. For simple implementations, use `implement` skill.

## When to Use

- Complex multi-domain operations requiring intelligent task breakdown
- Large-scale system operations spanning multiple technical areas
- Operations requiring parallel coordination and dependency management
- Projects needing structured workflow management

## When NOT to Use

- Single-step operations → use `implement` skill
- Simple file changes → use direct Edit/Write
- Test execution → use `test` skill
- Code review → use `analyze` skill

## Quick Workflow

```
ANALYZE → RESEARCH → DECOMPOSE → EXECUTE → INTEGRATE
  Read     Context7   Sequential    Task      TodoWrite
  Grep     GitHub     Thinking      TodoWrite  Output
           Tavily
```

1. **Analyze** - Parse operation, identify domains and scope
2. **Research** - Query Context7 for workflow patterns (Airflow, XState, BullMQ)
3. **Decompose** - Break into task hierarchy, map dependencies
4. **Execute** - Coordinate parallel/sequential execution via Task
5. **Integrate** - Aggregate results, validate completeness

## Tool Integration

For library IDs and patterns, see:

- [MCP Resources](../../lib/shared-references/mcp-resources.md)
- [Tool Patterns](../../lib/shared-references/tool-integration-patterns.md)

### Key Resources

| Resource       | Library ID                                      | Use Case          |
| -------------- | ----------------------------------------------- | ----------------- |
| Apache Airflow | `/websites/airflow_apache_apache-airflow_3_1_1` | DAG patterns      |
| XState         | `/websites/stately_ai`                          | State machines    |
| BullMQ         | `/websites/bullmq_io`                           | Job queues        |
| Restate        | `/restatedev/documentation`                     | Durable workflows |

## References

- [Detailed Guide](references/guide.md) - Full workflow and phases
- [Breakdown Patterns](references/breakdown-patterns.md) - Task decomposition
- [Coordination Strategies](references/coordination-strategies.md) - Parallel vs sequential
- [Failure Handling](references/failure-handling.md) - Retry and compensation
- [Workflow Patterns](references/workflow-patterns.md) - Industry patterns

## Boundaries

**Will**: Decompose complex operations, research workflow patterns, coordinate parallel execution, handle failures with retries, track progress with TodoWrite

**Will NOT**: Replace simple commands, override user preferences, execute without dependency analysis
