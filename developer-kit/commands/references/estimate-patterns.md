# Estimate Command - Reference Patterns

## Estimation Methods

### PERT (Default)

Program Evaluation and Review Technique - weighted three-point estimation.

```
Expected = (Optimistic + 4 x Most Likely + Pessimistic) / 6
Standard Deviation = (Pessimistic - Optimistic) / 6
```

**Best for**: Projects requiring statistical confidence intervals.

### T-Shirt Sizing

Quick relative sizing for backlog grooming.

| Size | Complexity              | Typical Duration |
| ---- | ----------------------- | ---------------- |
| XS   | Trivial change          | < 1 hour         |
| S    | Simple, well-understood | 1-4 hours        |
| M    | Moderate complexity     | 1-2 days         |
| L    | Significant effort      | 3-5 days         |
| XL   | Major feature           | 1-2 weeks        |
| XXL  | Epic, needs breakdown   | 2+ weeks         |

**Best for**: Sprint planning, relative comparison.

### Story Points

Fibonacci-based effort scoring (1, 2, 3, 5, 8, 13, 21).

| Points | Description                          |
| ------ | ------------------------------------ |
| 1      | Trivial, no unknowns                 |
| 2      | Simple, minimal risk                 |
| 3      | Straightforward with some complexity |
| 5      | Moderate complexity, some unknowns   |
| 8      | Complex, multiple components         |
| 13     | Very complex, significant risk       |
| 21     | Epic, should be broken down          |

**Best for**: Agile teams, velocity tracking.

## Complexity Factors

| Factor            | Low (1-3)              | Medium (4-6)            | High (7-10)                |
| ----------------- | ---------------------- | ----------------------- | -------------------------- |
| **Code**          | Bug fix, config change | New feature, module     | Architecture change        |
| **Integration**   | Isolated change        | API calls, 1-2 services | Multiple systems, external |
| **Testing**       | Existing coverage      | New test cases          | E2E, performance, security |
| **Documentation** | None needed            | Update existing         | New guides, API docs       |
| **Risk**          | Well-understood        | Some unknowns           | Significant unknowns       |

## Confidence Levels

| Level           | Range  | When to Use                           |
| --------------- | ------ | ------------------------------------- |
| High (80-95%)   | +/-20% | Well-understood, similar past work    |
| Medium (60-80%) | +/-40% | Some unknowns, reasonable assumptions |
| Low (40-60%)    | +/-60% | Significant unknowns, needs spike     |

## Output Examples

### Basic Estimate

```
Effort Estimate: Add user authentication with OAuth

Summary:
  T-Shirt Size:     L (Large)
  Story Points:     8
  Expected Effort:  3-5 days
  Confidence:       Medium (70%)

PERT Analysis:
  Optimistic:       2 days
  Most Likely:      4 days
  Pessimistic:      8 days
  Expected:         4.3 days
  Std Deviation:    1 day

Complexity Factors:
  Code Changes:     Medium (new auth module)
  Integration:      High (OAuth provider, session)
  Testing:          High (security-critical)
  Documentation:    Medium (API docs, user guide)

Risk Factors:
  - External dependency on OAuth provider
  - Security review required
  - Database schema changes

Recommendations:
  1. Spike OAuth integration first (1 day)
  2. Plan security review checkpoint
  3. Consider breaking into 2 PRs
```

### With Task Breakdown

```
Effort Estimate: Refactor payment module

Summary:
  T-Shirt Size:     XL (Extra Large)
  Story Points:     13
  Expected Effort:  6-10 days
  Confidence:       Medium (65%)

Task Breakdown:
  1. Analysis & Planning                [S] 0.5 days
  2. Payment Gateway Abstraction        [M] 2 days
  3. Transaction Model Updates          [M] 1.5 days
  4. API Endpoint Refactoring           [M] 2 days
  5. Testing                            [L] 2 days
  6. Documentation & Deployment         [S] 1 day

Dependencies:
  [2] -> [3] -> [4] (sequential)
  [5] depends on [2,3,4]
  [6] depends on all

Total: 9 days (range: 6-12 days)
```

### T-Shirt Sizing Output

```
T-Shirt Estimate: Fix login timeout bug

Size: S (Small)
Typical Duration: 1-4 hours
Confidence: High (85%)

Rationale:
  - Bug is well-defined (clear repro steps)
  - Likely single-file fix (session config)
  - Low risk (isolated change)
  - Existing test coverage
```

### Story Points Output

```
Story Point Estimate: Notification system

Points: 13
Velocity Impact: ~25% of sprint capacity
Confidence: Medium (70%)

Point Breakdown:
  Backend service: 5 points
  Database schema: 3 points
  UI components: 3 points
  Integration: 2 points

Comparison (similar past work):
  Email system: 8 points (simpler)
  Audit logging: 5 points (backend only)
  Dashboard widgets: 13 points (comparable)
```

### JSON Output

```json
{
  "task": "Add search feature",
  "method": "pert",
  "estimates": {
    "tshirt": "L",
    "points": 8,
    "time": {
      "optimistic": "2d",
      "mostLikely": "4d",
      "pessimistic": "7d",
      "expected": "4.2d",
      "stdDeviation": "0.8d"
    }
  },
  "complexity": {
    "overall": 6,
    "dimensions": {
      "code": 5,
      "integration": 7,
      "testing": 6,
      "documentation": 4
    }
  },
  "risks": [
    {
      "type": "technical",
      "description": "Search indexing performance",
      "impact": "medium",
      "mitigation": "Spike Elasticsearch first"
    }
  ],
  "confidence": 0.7
}
```

## When to Re-estimate

- After discovery of significant unknowns
- When scope changes (add/remove requirements)
- After completing a spike
- If confidence drops below 50%
