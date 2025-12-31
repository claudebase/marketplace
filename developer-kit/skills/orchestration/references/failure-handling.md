# Failure Handling Patterns

Retry and compensation strategies for task orchestration.

## Retry Strategies

| Strategy            | Use Case                  | Pattern                       |
| ------------------- | ------------------------- | ----------------------------- |
| Immediate retry     | Transient failures        | Retry up to N times instantly |
| Exponential backoff | Rate limiting, congestion | Wait 1s, 2s, 4s, 8s...        |
| Fixed delay         | Resource recovery         | Wait fixed interval between   |
| Circuit breaker     | Service unavailability    | Stop retrying after threshold |

### Temporal-style Retry Policy

```go
RetryPolicy: &commonpb.RetryPolicy{
    InitialInterval:    durationpb.New(1 * time.Second),
    BackoffCoefficient: 2.0,
    MaximumInterval:    durationpb.New(60 * time.Second),
    MaximumAttempts:    5,
}
```

## Parent-Child Failure Propagation

### BullMQ-style Pattern

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

## Compensation / Rollback (Saga Pattern)

```
┌─────────────────────────────────────────────────────┐
│ Forward Flow (Success)                              │
│ T1 → T2 → T3 → T4 → Complete                        │
├─────────────────────────────────────────────────────┤
│ Compensation Flow (Failure at T3)                   │
│ T1 → T2 → T3(fail) → C2 → C1 → Rolled Back         │
└─────────────────────────────────────────────────────┘
```

### When to Use Saga Pattern

- Distributed transactions across services
- Long-running operations that may fail mid-way
- Operations requiring clean rollback on failure

## Circuit Breaker Pattern

```typescript
class CircuitBreaker {
  private failures = 0;
  private state: "closed" | "open" | "half-open" = "closed";

  async execute<T>(fn: () => Promise<T>): Promise<T> {
    if (this.state === "open") {
      throw new Error("Circuit is open");
    }
    try {
      const result = await fn();
      this.onSuccess();
      return result;
    } catch (error) {
      this.onFailure();
      throw error;
    }
  }
}
```
