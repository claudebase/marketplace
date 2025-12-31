# Workflow Patterns

Industry-standard patterns from workflow engines.

## Sequential Execution

**When to use:**

- Tasks have strict dependencies
- Order matters for correctness
- Resource constraints require serialization

```
Task A → Task B → Task C → Task D
```

### Airflow Pattern

```python
# Task dependencies with bitshift operators
task_a >> task_b >> task_c >> task_d

# Or explicit set_downstream
task_a.set_downstream(task_b)
```

## Parallel Execution

**When to use:**

- Tasks are independent
- No shared resource conflicts
- Maximum speed is priority

```
┌─ Task A ─┐
├─ Task B ─┼→ Join
└─ Task C ─┘
```

### XState Parallel States

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

## Fan-Out / Fan-In

**When to use:**

- Process multiple items independently
- Aggregate results at the end
- Dynamic number of subtasks

```
         ┌─ Process Item 1 ─┐
Split ───┼─ Process Item 2 ─┼─── Aggregate
         └─ Process Item N ─┘
```

### BullMQ Flows

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

## Adaptive / Hybrid

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

## Decomposition Levels

| Level   | Scope           | Duration | Example                         |
| ------- | --------------- | -------- | ------------------------------- |
| Epic    | Major feature   | Weeks    | "Implement user authentication" |
| Story   | User capability | Days     | "User can login with OAuth"     |
| Task    | Implementation  | Hours    | "Create OAuth callback handler" |
| Subtask | Atomic action   | Minutes  | "Add route for /auth/callback"  |
