---
name: orchestration
description: "Meta-system task orchestration with intelligent breakdown and workflow management. This skill should be used when the user asks to 'orchestrate', 'break down', 'coordinate', or 'manage tasks'. Also use when user mentions multi-step operations, complex workflows, hierarchical coordination, or spawning subtasks."
composable: true
mode: meta
allowed-tools:
  # Core Analysis
  - Read
  - Grep
  - Glob
  - Bash
  # Task Management
  - Edit
  - Write
  - TodoWrite
  - Task
  # Workflow Documentation
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  # Pattern Research
  - mcp__github__search_code
  - mcp__github__get_file_contents
  # Best Practices Research
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  # Structured Planning
  - mcp__sequential-thinking__sequentialthinking
---

# Orchestration Skill

Meta-system task orchestration with intelligent breakdown, dependency management, and workflow coordination using industry-standard patterns from workflow engines like Airflow, Temporal, and XState.

**Core Principle**: "Break complex operations into coordinated hierarchies. Execute with optimal parallelism while respecting dependencies."

**Key Enhancement**: Research workflow patterns and orchestration best practices before designing task breakdowns.

**Key Distinction**: This skill ORCHESTRATES complex multi-step operations. For simple implementations, use the `implement` skill. For test execution, use the `test` skill.

## Activation Triggers

### Spawn Operations

- Complex multi-domain operations requiring intelligent task breakdown
- Large-scale system operations spanning multiple technical areas
- Operations requiring parallel coordination and dependency management

### Task Operations

- Complex tasks requiring multi-agent coordination
- Projects needing structured workflow management
- Operations requiring intelligent routing and delegation

## Do NOT Activate When

- Single-step operations → use `implement` skill
- Simple file changes → use direct Edit/Write
- Test execution → use `test` skill
- Code review → use `analyze` skill

**Boundary Clarification:**
This skill coordinates complex multi-step workflows. For simple operations that don't require dependency management or parallel execution, use the appropriate specialized skill directly.

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

### Phase 1: ANALYZE

Understand the complex operation and its requirements:

1. **Parse requirements** - What is the end goal? What domains are involved?
2. **Identify scope** - How many components, services, or systems?
3. **Assess complexity** - What are the risks and failure modes?
4. **Find existing patterns** - Are there similar workflows in the codebase?

```bash
# Find existing workflow patterns
Grep - "workflow|orchestrat|pipeline|dag" in project files

# Check for task management patterns
Glob - "**/tasks/**", "**/workflows/**", "**/pipelines/**"

# Analyze existing coordination code
Read - Existing orchestration implementations
```

**Tools**: Read, Grep, Glob

### Phase 2: RESEARCH

Gather orchestration patterns and best practices:

```
# Lookup DAG patterns for task dependencies
mcp__context7__resolve-library-id → "/websites/airflow_apache_apache-airflow_3_1_1"
mcp__context7__query-docs("DAG task dependencies parallel execution")

# Lookup state machine patterns for complex workflows
mcp__context7__resolve-library-id → "/websites/stately_ai"
mcp__context7__query-docs("parallel states coordination actor model")

# Lookup job queue patterns for task hierarchies
mcp__context7__resolve-library-id → "/websites/bullmq_io"
mcp__context7__query-docs("flow producer parent child dependencies")

# Lookup durable workflow patterns
mcp__context7__resolve-library-id → "/restatedev/documentation"
mcp__context7__query-docs("workflow orchestration durable execution")

# Find orchestration patterns in codebases
mcp__github__search_code("workflow DAG parallel sequential filename:.ts")

# Research current best practices
mcp__tavily__tavily-search("task orchestration patterns DAG workflow 2024")
```

**Tools**: Context7, GitHub MCP, Tavily

### Phase 3: DECOMPOSE

Break the operation into a coordinated task hierarchy:

```
mcp__sequential-thinking__sequentialthinking
- What are the major phases of this operation?
- Which tasks depend on others (must be sequential)?
- Which tasks are independent (can run in parallel)?
- What are the critical path tasks?
- What failure modes exist and how to handle them?
- What checkpoints and validation gates are needed?
```

**Task Hierarchy:**

```
Epic (Large Goal)
├── Story (Feature/Capability)
│   ├── Task (Implementation Unit)
│   │   ├── Subtask (Atomic Action)
│   │   └── Subtask
│   └── Task
│       └── Subtask
└── Story
    └── Task
```

**Tools**: Sequential Thinking, TodoWrite

### Phase 4: EXECUTE

Coordinate task execution with optimal strategy:

```
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

### Phase 5: INTEGRATE

Aggregate results and validate completeness:

1. **Collect results** - Gather outputs from all subtasks
2. **Validate completeness** - Ensure all required tasks completed
3. **Handle failures** - Address any failed tasks with retries or alternatives
4. **Report outcomes** - Summarize what was accomplished

**Tools**: TodoWrite, Output

## MCP Integration

### Context7 (Workflow Documentation)

**Primary source for orchestration pattern documentation:**

```
mcp__context7__resolve-library-id - Resolve workflow engine IDs
mcp__context7__query-docs - Get official documentation
```

**Available Resources:**

| Resource       | Library ID                                      | Snippets | Use Case                        |
| -------------- | ----------------------------------------------- | -------- | ------------------------------- |
| Apache Airflow | `/websites/airflow_apache_apache-airflow_3_1_1` | 1,977    | DAG patterns, task dependencies |
| XState         | `/websites/stately_ai`                          | 1,191    | State machines, parallel states |
| BullMQ         | `/websites/bullmq_io`                           | 561      | Job queues, parent-child flows  |
| Restate        | `/restatedev/documentation`                     | 7,522    | Durable workflows, coordination |
| Temporal       | `/temporalio/temporal`                          | 410      | Workflow orchestration, retries |
| Celery         | `/websites/celeryq_dev_en_stable`               | 6,062    | Distributed task queues         |
| n8n            | `/n8n-io/n8n`                                   | 1,241    | Workflow automation             |

**Query patterns:**

- "DAG task dependencies workflow orchestration" (Airflow)
- "parallel states coordination actor model" (XState)
- "flow producer parent child dependencies" (BullMQ)
- "workflow durable execution state" (Restate)
- "workflow activity task queue retry policy" (Temporal)
- "task queue distributed job scheduling" (Celery)

### GitHub MCP (Pattern Research)

**Find orchestration patterns in production codebases:**

```
mcp__github__search_code - Find workflow patterns
mcp__github__get_file_contents - Get specific implementations
```

**Search patterns:**

```
# Find DAG implementations
"dag" "task" "dependency" "execute" filename:.ts stars:>500

# Find workflow orchestration
"workflow" "orchestrat" "parallel" "sequential" filename:.ts

# Find job queue patterns
"queue" "job" "worker" "process" filename:.ts stars:>100

# Find state machine patterns
"state" "machine" "transition" "action" filename:.ts

# Find retry/resilience patterns
"retry" "backoff" "resilience" "circuit" filename:.ts
```

**Use cases:**

- Find how large projects structure workflows
- Research task dependency patterns
- Get job queue implementations
- Study state machine coordination

### Tavily (Best Practices Research)

**Research current orchestration methodologies:**

```
mcp__tavily__tavily-search - Research workflow strategies
mcp__tavily__tavily-extract - Extract from orchestration guides
```

**Use cases:**

- "Task orchestration patterns DAG workflow 2024"
- "Microservices orchestration vs choreography"
- "Distributed task queue best practices"
- "Workflow engine comparison Temporal Airflow"
- "Event-driven architecture orchestration"
- "Saga pattern distributed transactions"

### Sequential Thinking (Structured Planning)

**Systematic task decomposition and coordination:**

```
mcp__sequential-thinking__sequentialthinking - Multi-step orchestration planning
```

**Use for:**

- Complex task breakdown
- Dependency graph analysis
- Critical path identification
- Failure mode analysis
- Coordination strategy selection

## Coordination Strategies

### Sequential Execution

**When to use:**

- Tasks have strict dependencies
- Order matters for correctness
- Resource constraints require serialization

```
Task A → Task B → Task C → Task D
```

**Pattern (Airflow-style):**

```python
# Task dependencies with bitshift operators
task_a >> task_b >> task_c >> task_d

# Or explicit set_downstream
task_a.set_downstream(task_b)
task_b.set_downstream(task_c)
```

### Parallel Execution

**When to use:**

- Tasks are independent
- No shared resource conflicts
- Maximum speed is priority

```
┌─ Task A ─┐
├─ Task B ─┼→ Join
└─ Task C ─┘
```

**Pattern (XState parallel states):**

```javascript
{
  type: 'parallel',
  states: {
    taskA: { /* state machine */ },
    taskB: { /* state machine */ },
    taskC: { /* state machine */ }
  },
  onDone: 'joinState'
}
```

### Fan-Out / Fan-In

**When to use:**

- Process multiple items independently
- Aggregate results at the end
- Dynamic number of subtasks

```
         ┌─ Process Item 1 ─┐
Split ───┼─ Process Item 2 ─┼─── Aggregate
         └─ Process Item N ─┘
```

**Pattern (BullMQ flows):**

```typescript
const flow = await flowProducer.add({
  name: "aggregate-results",
  queueName: "aggregation",
  children: items.map((item) => ({
    name: "process-item",
    data: { item },
    queueName: "processing",
  })),
});
```

### Adaptive / Hybrid

**When to use:**

- Mix of dependent and independent tasks
- Dynamic adjustment based on results
- Complex real-world workflows

```
Task A ──┬─→ Task B ─┬─→ Task E
         │          │
         └─→ Task C ─┤
                    │
         Task D ────┘
```

**Pattern:**

```
mcp__sequential-thinking__sequentialthinking
- Analyze each task's dependencies
- Group independent tasks for parallel execution
- Chain dependent tasks sequentially
- Identify synchronization points
```

## Task Decomposition Patterns

### Epic → Story → Task Breakdown

| Level   | Scope           | Duration | Example                         |
| ------- | --------------- | -------- | ------------------------------- |
| Epic    | Major feature   | Weeks    | "Implement user authentication" |
| Story   | User capability | Days     | "User can login with OAuth"     |
| Task    | Implementation  | Hours    | "Create OAuth callback handler" |
| Subtask | Atomic action   | Minutes  | "Add route for /auth/callback"  |

### Domain-Based Decomposition

```
Full-Stack Feature
├── Frontend
│   ├── Components
│   ├── State management
│   └── API integration
├── Backend
│   ├── API endpoints
│   ├── Business logic
│   └── Database models
└── Infrastructure
    ├── Configuration
    └── Deployment
```

### Phase-Based Decomposition

```
Feature Development
├── Phase 1: Discovery
│   ├── Requirements analysis
│   └── Technical research
├── Phase 2: Design
│   ├── Architecture design
│   └── API specification
├── Phase 3: Implementation
│   ├── Core functionality
│   └── Edge cases
├── Phase 4: Testing
│   ├── Unit tests
│   └── Integration tests
└── Phase 5: Deployment
    ├── Documentation
    └── Release
```

## Failure Handling

### Retry Strategies

| Strategy            | Use Case                  | Pattern                       |
| ------------------- | ------------------------- | ----------------------------- |
| Immediate retry     | Transient failures        | Retry up to N times instantly |
| Exponential backoff | Rate limiting, congestion | Wait 1s, 2s, 4s, 8s...        |
| Fixed delay         | Resource recovery         | Wait fixed interval between   |
| Circuit breaker     | Service unavailability    | Stop retrying after threshold |

**Pattern (Temporal-style):**

```go
RetryPolicy: &commonpb.RetryPolicy{
    InitialInterval:    durationpb.New(1 * time.Second),
    BackoffCoefficient: 2.0,
    MaximumInterval:    durationpb.New(60 * time.Second),
    MaximumAttempts:    5,
}
```

### Parent-Child Failure Propagation

**Pattern (BullMQ-style):**

```typescript
{
  name: 'child-task',
  opts: { failParentOnFailure: true },  // Critical child
  children: [
    {
      name: 'grandchild-task',
      opts: { failParentOnFailure: true }  // Propagate up
    }
  ]
}
```

### Compensation / Rollback

**Saga Pattern:**

```
┌─────────────────────────────────────────────────────┐
│ Forward Flow (Success)                              │
│ T1 → T2 → T3 → T4 → Complete                        │
├─────────────────────────────────────────────────────┤
│ Compensation Flow (Failure at T3)                   │
│ T1 → T2 → T3(fail) → C2 → C1 → Rolled Back         │
└─────────────────────────────────────────────────────┘
```

## Output Format

```markdown
## Orchestration Report

### Operation Summary

| Aspect      | Details                             |
| ----------- | ----------------------------------- |
| Operation   | [Description of the complex task]   |
| Domains     | [Frontend, Backend, Infrastructure] |
| Strategy    | [Sequential/Parallel/Adaptive]      |
| Total Tasks | [Count of tasks at each level]      |

### Research Applied

- Workflow pattern: [Airflow DAG / XState / BullMQ flow]
- Coordination strategy: [From research]
- Failure handling: [Retry policy applied]

### Task Hierarchy

#### Phase 1: [Phase Name]

- [x] Task 1.1 - Completed
- [x] Task 1.2 - Completed
- [ ] Task 1.3 - In Progress

#### Phase 2: [Phase Name]

- [ ] Task 2.1 - Pending (depends on 1.3)
- [ ] Task 2.2 - Pending

### Execution Timeline

| Task | Status    | Duration | Dependencies |
| ---- | --------- | -------- | ------------ |
| 1.1  | Completed | 5m       | None         |
| 1.2  | Completed | 3m       | None         |
| 1.3  | Running   | -        | None         |
| 2.1  | Pending   | -        | 1.3          |

### Outcomes

- Tasks completed: X/Y
- Parallel efficiency: Z%
- Failures handled: N retries

### Next Steps

1. [Remaining work]
2. [Follow-up tasks]
```

## Reference Files

For detailed orchestration patterns, see:

- `references/breakdown-patterns.md` - Task decomposition strategies
- `references/coordination-strategies.md` - Parallel vs sequential execution
- `references/failure-handling.md` - Retry and compensation patterns
- `references/workflow-patterns.md` - Industry workflow engine patterns

## Handoffs

| Scenario                   | Hand off to         |
| -------------------------- | ------------------- |
| Need simple implementation | `implement` skill   |
| Need code analysis         | `analyze` skill     |
| Need test execution        | `test` skill        |
| Need architecture design   | `design` skill      |
| Need performance analysis  | `performance` skill |

## Boundaries

**Will:**

- Decompose complex operations into coordinated hierarchies
- Research workflow patterns via MCP tools
- Determine optimal coordination strategy (parallel/sequential/adaptive)
- Execute multi-step operations with dependency management
- Handle failures with appropriate retry and compensation strategies
- Track progress with TodoWrite throughout execution
- Aggregate and validate results

**Will Not:**

- Replace simple commands for basic operations
- Override user coordination preferences
- Execute without proper dependency analysis
- Make architectural decisions without research
- Skip validation gates or quality checks
