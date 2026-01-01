# Sequential Thinking Skill - Detailed Guide

Enables structured problem-solving through iterative reasoning with revision and branching capabilities.

---

## Core Capabilities

- **Iterative reasoning**: Break complex problems into sequential thought steps
- **Dynamic scope**: Adjust total thought count as understanding evolves
- **Revision tracking**: Reconsider and modify previous conclusions
- **Branch exploration**: Explore alternative reasoning paths from any point
- **Maintained context**: Keep track of reasoning chain throughout analysis

---

## MCP Tool Usage

The skill uses `mcp__sequential-thinking__sequentialthinking` with these parameters:

### Required Parameters

| Parameter           | Type    | Description                       |
| ------------------- | ------- | --------------------------------- |
| `thought`           | string  | Current reasoning step            |
| `nextThoughtNeeded` | boolean | Whether more reasoning is needed  |
| `thoughtNumber`     | integer | Current step number (starts at 1) |
| `totalThoughts`     | integer | Estimated total steps needed      |

### Optional Parameters

| Parameter           | Type    | Description                                |
| ------------------- | ------- | ------------------------------------------ |
| `isRevision`        | boolean | Indicates this revises previous thinking   |
| `revisesThought`    | integer | Which thought number is being reconsidered |
| `branchFromThought` | integer | Thought number to branch from              |
| `branchId`          | string  | Identifier for this reasoning branch       |
| `needsMoreThoughts` | boolean | If more thoughts are needed at end         |

---

## Workflow Pattern

```
1. Start with initial thought (thoughtNumber: 1)
2. For each step:
   - Express current reasoning in `thought`
   - Estimate remaining work via `totalThoughts` (adjust dynamically)
   - Set `nextThoughtNeeded: true` to continue
3. When reaching conclusion, set `nextThoughtNeeded: false`
```

---

## Basic Example

```typescript
// First thought - establish the problem
{
  thought: "Problem involves optimizing database queries. Need to identify bottlenecks first.",
  thoughtNumber: 1,
  totalThoughts: 5,
  nextThoughtNeeded: true
}

// Second thought - analyze
{
  thought: "Analyzing query patterns reveals N+1 problem in user fetches.",
  thoughtNumber: 2,
  totalThoughts: 6, // Adjusted scope as complexity revealed
  nextThoughtNeeded: true
}

// Third thought - propose solution
{
  thought: "Solution: Use eager loading with include clause to batch queries.",
  thoughtNumber: 3,
  totalThoughts: 6,
  nextThoughtNeeded: true
}

// ... continue until conclusion

// Final thought
{
  thought: "Conclusion: Implement eager loading, expected 80% query reduction.",
  thoughtNumber: 6,
  totalThoughts: 6,
  nextThoughtNeeded: false
}
```

---

## Advanced Patterns

### Revision Pattern

When you realize a previous conclusion was wrong:

```typescript
// Original thought 3
{
  thought: "The issue is in the database query.",
  thoughtNumber: 3,
  totalThoughts: 5,
  nextThoughtNeeded: true
}

// Later revision of thought 3
{
  thought: "Revising: The issue is actually in the API layer, not database. The query was correct but data transformation is slow.",
  thoughtNumber: 5,
  totalThoughts: 7,
  nextThoughtNeeded: true,
  isRevision: true,
  revisesThought: 3
}
```

### Branching Pattern

When multiple approaches seem viable:

```typescript
// Main branch thought
{
  thought: "Two approaches possible: caching or query optimization.",
  thoughtNumber: 4,
  totalThoughts: 8,
  nextThoughtNeeded: true
}

// Branch A - explore caching
{
  thought: "Branch A: Exploring caching approach. Redis could cache user data.",
  thoughtNumber: 5,
  totalThoughts: 8,
  nextThoughtNeeded: true,
  branchFromThought: 4,
  branchId: "caching"
}

// Branch B - explore optimization
{
  thought: "Branch B: Exploring query optimization. Index on user_id could help.",
  thoughtNumber: 5,
  totalThoughts: 8,
  nextThoughtNeeded: true,
  branchFromThought: 4,
  branchId: "optimization"
}
```

---

## When to Use

**Good use cases:**

- Complex debugging requiring multiple hypotheses
- Architecture decisions with trade-offs
- Multi-step problem decomposition
- Analysis requiring backtracking
- Exploring alternative solutions

**Don't use for:**

- Simple queries with direct answers
- Single-step tasks
- Factual lookups
- Straightforward implementations

---

## Tips for Effective Use

1. **Start with rough estimate** - `totalThoughts` can be adjusted freely
2. **Express uncertainty** - Include doubts in thoughts
3. **Use revision when wrong** - Don't pretend previous conclusions were correct
4. **Branch when stuck** - Explore multiple paths simultaneously
5. **Adjust scope freely** - Accuracy matters less than progress visibility
6. **Be specific** - Vague thoughts don't help reasoning
7. **Summarize periodically** - Restate conclusions every few thoughts

---

## Example: Debugging Session

```typescript
// Thought 1: Understand the problem
{
  thought: "User reports 500 error on checkout. Need to trace the request path.",
  thoughtNumber: 1,
  totalThoughts: 6,
  nextThoughtNeeded: true
}

// Thought 2: Gather information
{
  thought: "Error logs show NullPointerException in PaymentService.process(). The payment object is null.",
  thoughtNumber: 2,
  totalThoughts: 6,
  nextThoughtNeeded: true
}

// Thought 3: Form hypothesis
{
  thought: "Hypothesis: Payment object not being created correctly. Checking PaymentFactory.",
  thoughtNumber: 3,
  totalThoughts: 6,
  nextThoughtNeeded: true
}

// Thought 4: Test hypothesis (revision needed)
{
  thought: "PaymentFactory looks correct. Revising hypothesis: The issue might be in the cart validation step before payment creation.",
  thoughtNumber: 4,
  totalThoughts: 8, // Extended scope
  nextThoughtNeeded: true,
  isRevision: true,
  revisesThought: 3
}

// Thought 5: New finding
{
  thought: "Found it: Cart validation fails silently when items are out of stock, returning null instead of throwing error.",
  thoughtNumber: 5,
  totalThoughts: 8,
  nextThoughtNeeded: true
}

// Thought 6: Conclusion
{
  thought: "Root cause: Silent failure in cart validation. Fix: Throw explicit OutOfStockException with item details.",
  thoughtNumber: 6,
  totalThoughts: 6,
  nextThoughtNeeded: false
}
```

---

## Related Reference Files

- [advanced.md](advanced.md) - Revision and branching patterns
- [examples.md](examples.md) - Real-world use cases
