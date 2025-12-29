---
name: orchestration
description: "Meta-system task orchestration with intelligent breakdown and workflow management. Use for complex multi-domain operations or tasks needing hierarchical coordination. Activates for: spawn, orchestrate, break down, coordinate, manage tasks, multi-step operations."
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - Edit
  - Write
  - TodoWrite
  - Task
  - mcp__sequential-thinking__sequentialthinking
  - mcp__context7__resolve-library-id
  - mcp__context7__get-library-docs
---

# Orchestration Skill

Unified skill for spawn and task orchestration operations.

## Activation Triggers

### Spawn Operations
- Complex multi-domain operations requiring intelligent task breakdown
- Large-scale system operations spanning multiple technical areas
- Operations requiring parallel coordination and dependency management

### Task Operations
- Complex tasks requiring multi-agent coordination
- Projects needing structured workflow management
- Operations requiring intelligent routing and delegation

## Behavioral Flow

### Spawn Flow (Task Breakdown)
1. **Analyze**: Parse complex operation requirements
2. **Decompose**: Break into coordinated subtask hierarchies
3. **Orchestrate**: Execute with optimal coordination strategy
4. **Monitor**: Track progress with dependency management
5. **Integrate**: Aggregate results

### Task Flow (Execution Management)
1. **Analyze**: Determine optimal execution strategy
2. **Delegate**: Route to appropriate tools and approaches
3. **Coordinate**: Execute with intelligent workflow management
4. **Validate**: Apply quality gates
5. **Optimize**: Analyze and recommend improvements

## Task Hierarchy

```
Epic (Large Goal)
├── Story (Feature/Capability)
│   ├── Task (Implementation Unit)
│   │   ├── Subtask (Atomic Action)
│   │   └── Subtask
│   └── Task
└── Story
```

## Coordination Strategies

### Sequential
- Tasks with dependencies
- Order matters
- One at a time

### Parallel
- Independent tasks
- No dependencies
- Maximum speed

### Adaptive
- Mix of sequential and parallel
- Dynamic adjustment based on results
- Optimal for complex operations

## MCP Integration

**Use Sequential Thinking for complex orchestration planning:**
```
mcp__sequential-thinking__sequentialthinking - Use for multi-step task breakdown and coordination
```
Sequential Thinking helps analyze dependencies and plan execution order systematically.

**Use Context7 for framework-aware task delegation:**
```
mcp__context7__resolve-library-id - Resolve library names first
mcp__context7__get-library-docs - Fetch framework patterns for implementation subtasks
```
Context7 ensures orchestrated tasks follow framework best practices.

## References

- `references/breakdown-patterns.md` - Task decomposition strategies
- `references/coordination-strategies.md` - Parallel vs sequential execution

## Boundaries

**Will:**
- Decompose complex operations into coordinated hierarchies
- Provide intelligent orchestration strategies
- Execute meta-system operations

**Will Not:**
- Replace simple commands for basic operations
- Override user coordination preferences
- Execute without proper dependency analysis
