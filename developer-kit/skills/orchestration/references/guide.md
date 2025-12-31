# Orchestration Skill - Detailed Guide

Complete behavioral flow for meta-system task orchestration.

## Behavioral Flow

```
┌──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
│   ANALYZE    │   RESEARCH   │  DECOMPOSE   │   EXECUTE    │  INTEGRATE   │
├──────────────┼──────────────┼──────────────┼──────────────┼──────────────┤
│ Parse        │ Lookup       │ Break into   │ Coordinate   │ Aggregate    │
│ complex      │ workflow     │ task         │ parallel     │ results      │
│ operation    │ patterns     │ hierarchy    │ execution    │              │
│              │              │              │              │              │
│ Identify     │ Find         │ Map          │ Monitor      │ Validate     │
│ domains      │ orchestration│ dependencies │ progress     │ completeness │
│ and scope    │ examples     │ and order    │ and status   │              │
│              │              │              │              │              │
│ Assess       │ Research     │ Determine    │ Handle       │ Report       │
│ complexity   │ best         │ coordination │ failures     │ outcomes     │
│ and risks    │ practices    │ strategy     │ and retries  │              │
└──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘
     Read           Context7      Sequential      Task           TodoWrite
     Grep           GitHub        Thinking        TodoWrite      Output
                    Tavily
```

## Phase 1: ANALYZE

Understand the complex operation and its requirements.

### Steps

1. **Parse requirements** - What is the end goal? What domains are involved?
2. **Identify scope** - How many components, services, or systems?
3. **Assess complexity** - What are the risks and failure modes?
4. **Find existing patterns** - Are there similar workflows in the codebase?

**Tools**: Read, Grep, Glob

## Phase 2: RESEARCH

Gather orchestration patterns and best practices.

### MCP Tool Usage

```yaml
# DAG patterns (Airflow)
mcp__context7__query-docs("/websites/airflow_apache_apache-airflow_3_1_1", "DAG task dependencies")

# State machine patterns (XState)
mcp__context7__query-docs("/websites/stately_ai", "parallel states coordination")

# Job queue patterns (BullMQ)
mcp__context7__query-docs("/websites/bullmq_io", "flow producer parent child")

# Durable workflows (Restate)
mcp__context7__query-docs("/restatedev/documentation", "workflow orchestration")

# Find patterns in codebases
mcp__github__search_code("workflow DAG parallel sequential filename:.ts")
```

**Tools**: Context7, GitHub MCP, Tavily

## Phase 3: DECOMPOSE

Break the operation into a coordinated task hierarchy.

```yaml
mcp__sequential-thinking__sequentialthinking:
  - What are the major phases of this operation?
  - Which tasks depend on others (must be sequential)?
  - Which tasks are independent (can run in parallel)?
  - What are the critical path tasks?
  - What failure modes exist and how to handle them?
```

### Task Hierarchy

```
Epic (Large Goal)
├── Story (Feature/Capability)
│   ├── Task (Implementation Unit)
│   │   ├── Subtask (Atomic Action)
│   │   └── Subtask
│   └── Task
└── Story
    └── Task
```

**Tools**: Sequential Thinking, TodoWrite

## Phase 4: EXECUTE

Coordinate task execution with optimal strategy.

```yaml
# Track all tasks with TodoWrite
TodoWrite - Create hierarchical task list

# Execute independent tasks in parallel
Task - Launch parallel agents for independent work

# Execute dependent tasks sequentially
Task - Chain dependent operations

# Monitor progress
TodoWrite - Update status as tasks complete
```

**Tools**: Task, TodoWrite, Bash

## Phase 5: INTEGRATE

Aggregate results and validate completeness.

1. **Collect results** - Gather outputs from all subtasks
2. **Validate completeness** - Ensure all required tasks completed
3. **Handle failures** - Address any failed tasks
4. **Report outcomes** - Summarize what was accomplished

**Tools**: TodoWrite, Output

## MCP Resources

| Resource       | Library ID                                      | Use Case          |
| -------------- | ----------------------------------------------- | ----------------- |
| Apache Airflow | `/websites/airflow_apache_apache-airflow_3_1_1` | DAG patterns      |
| XState         | `/websites/stately_ai`                          | State machines    |
| BullMQ         | `/websites/bullmq_io`                           | Job queues        |
| Restate        | `/restatedev/documentation`                     | Durable workflows |
| Temporal       | `/temporalio/temporal`                          | Workflow retries  |
| Celery         | `/websites/celeryq_dev_en_stable`               | Distributed tasks |

## Related Skills

- `implement` skill - For simple implementations
- `analyze` skill - For code analysis
- `test` skill - For test execution
- `design` skill - For architecture design
