---
name: estimate
description: Estimate implementation effort for tasks, features, or projects
delegates-to: orchestration
operation: estimate
argument-hint: "<task-description|issue-url> [--type time|effort|complexity] [--breakdown] [--method pert|tshirt|points]"
allowed-tools: Read, Grep, Glob, Task
---

# estimate - Implementation Effort Estimation

Analyze tasks and provide data-driven effort estimates with confidence intervals and risk factors.

## Usage

```bash
estimate <task-description|issue-url> [options]
```

## Arguments

| Argument           | Description                                       |
| ------------------ | ------------------------------------------------- |
| `task-description` | Natural language description of the task          |
| `issue-url`        | GitHub issue URL for automatic context extraction |

## Options

| Option              | Default | Description                                |
| ------------------- | ------- | ------------------------------------------ |
| `--type <type>`     | effort  | Output type: time, effort, or complexity   |
| `--breakdown`       | false   | Include detailed task breakdown            |
| `--method <method>` | pert    | Estimation method: pert, tshirt, or points |
| `--confidence`      | medium  | Required confidence: low, medium, high     |
| `--json`            | false   | Output in JSON format                      |

## What This Does

### 1. Context Gathering

```
Analyze task scope:
├── Parse task description or fetch GitHub issue
├── Identify affected components via codebase search
├── Map dependencies and integration points
└── Assess technical complexity factors
```

### 2. Complexity Analysis

```
Evaluate complexity dimensions:
├── Code complexity (new vs. modification)
├── Integration complexity (APIs, services)
├── Testing requirements
├── Documentation needs
└── Risk factors (unknowns, dependencies)
```

### 3. Effort Estimation

```
Generate estimates with confidence intervals:
├── Optimistic (best case)
├── Most Likely (realistic)
├── Pessimistic (worst case)
└── Expected (weighted average)
```

### 4. Risk Assessment

```
Identify risk factors:
├── Technical unknowns
├── External dependencies
├── Skill gaps
├── Timeline constraints
└── Scope creep indicators
```

## Estimation Methods

### PERT (Default)

Program Evaluation and Review Technique - weighted three-point estimation.

```
Expected = (Optimistic + 4×Most Likely + Pessimistic) / 6
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

## Examples

### Basic Estimate

```bash
estimate "Add user authentication with OAuth"
```

Output:

```
══════════════════════════════════════════════════════════
  Effort Estimate: Add user authentication with OAuth
══════════════════════════════════════════════════════════

Method: PERT (Three-Point Estimation)

──────────────────────────────────────────────────────────
  Summary
──────────────────────────────────────────────────────────
  T-Shirt Size:     L (Large)
  Story Points:     8
  Expected Effort:  3-5 days
  Confidence:       Medium (70%)

──────────────────────────────────────────────────────────
  PERT Analysis
──────────────────────────────────────────────────────────
  Optimistic:       2 days
  Most Likely:      4 days
  Pessimistic:      8 days
  Expected:         4.3 days
  Std Deviation:    1 day

──────────────────────────────────────────────────────────
  Complexity Factors
──────────────────────────────────────────────────────────
  Code Changes:     Medium (new auth module)
  Integration:      High (OAuth provider, session management)
  Testing:          High (security-critical)
  Documentation:    Medium (API docs, user guide)

──────────────────────────────────────────────────────────
  Risk Factors
──────────────────────────────────────────────────────────
  ⚠ External dependency on OAuth provider
  ⚠ Security review required
  ⚠ Database schema changes

──────────────────────────────────────────────────────────
  Recommendations
──────────────────────────────────────────────────────────
  1. Spike OAuth integration first (1 day)
  2. Plan security review checkpoint
  3. Consider breaking into 2 PRs (auth + UI)
```

### With Task Breakdown

```bash
estimate "Refactor payment module" --breakdown
```

Output:

```
══════════════════════════════════════════════════════════
  Effort Estimate: Refactor payment module
══════════════════════════════════════════════════════════

Method: PERT with Breakdown

──────────────────────────────────────────────────────────
  Summary
──────────────────────────────────────────────────────────
  T-Shirt Size:     XL (Extra Large)
  Story Points:     13
  Expected Effort:  6-10 days
  Confidence:       Medium (65%)

──────────────────────────────────────────────────────────
  Task Breakdown
──────────────────────────────────────────────────────────

  1. Analysis & Planning                    [S] 0.5 days
     └── Review current payment flow
     └── Document refactoring scope
     └── Identify breaking changes

  2. Payment Gateway Abstraction            [M] 2 days
     └── Create gateway interface
     └── Implement Stripe adapter
     └── Implement PayPal adapter

  3. Transaction Model Updates              [M] 1.5 days
     └── Update database schema
     └── Create migration scripts
     └── Update ORM models

  4. API Endpoint Refactoring               [M] 2 days
     └── Refactor payment endpoints
     └── Update request/response DTOs
     └── Implement versioning

  5. Testing                                [L] 2 days
     └── Unit tests for adapters
     └── Integration tests
     └── E2E payment flow tests

  6. Documentation & Deployment             [S] 1 day
     └── Update API documentation
     └── Create migration guide
     └── Deployment checklist

──────────────────────────────────────────────────────────
  Dependencies
──────────────────────────────────────────────────────────
  [2] → [3] → [4] (sequential)
  [5] depends on [2,3,4]
  [6] depends on all

──────────────────────────────────────────────────────────
  Total: 9 days (range: 6-12 days)
```

### GitHub Issue Estimate

```bash
estimate https://github.com/org/repo/issues/42 --type complexity
```

Output:

```
══════════════════════════════════════════════════════════
  Complexity Analysis: Issue #42
══════════════════════════════════════════════════════════

Issue: Add dark mode support
Labels: enhancement, ui
Assignees: None

──────────────────────────────────────────────────────────
  Complexity Score: 6/10 (Medium-High)
──────────────────────────────────────────────────────────

  Dimension Scores:
  ├── Code Volume:        5/10  (moderate new code)
  ├── Architectural:      7/10  (theme system needed)
  ├── Integration:        4/10  (CSS variables, storage)
  ├── Testing:            6/10  (visual testing)
  └── Documentation:      3/10  (user preferences)

──────────────────────────────────────────────────────────
  Affected Files (estimated)
──────────────────────────────────────────────────────────
  src/styles/           ~15 files
  src/components/       ~8 files
  src/hooks/            ~2 files
  src/utils/storage     ~1 file

──────────────────────────────────────────────────────────
  Recommendation
──────────────────────────────────────────────────────────
  Story Points: 8
  T-Shirt: L
  Suggested Sprint: Current (fits capacity)
```

### T-Shirt Sizing

```bash
estimate "Fix login timeout bug" --method tshirt
```

Output:

```
┌─────────────────────────────────────────────────────┐
│  T-Shirt Estimate: Fix login timeout bug            │
├─────────────────────────────────────────────────────┤
│  Size: S (Small)                                    │
│  Typical Duration: 1-4 hours                        │
│  Confidence: High (85%)                             │
├─────────────────────────────────────────────────────┤
│  Rationale:                                         │
│  • Bug is well-defined (clear repro steps)          │
│  • Likely single-file fix (session config)          │
│  • Low risk (isolated change)                       │
│  • Existing test coverage                           │
└─────────────────────────────────────────────────────┘
```

### Story Points

```bash
estimate "Implement notification system" --method points
```

Output:

```
┌─────────────────────────────────────────────────────┐
│  Story Point Estimate: Notification system          │
├─────────────────────────────────────────────────────┤
│  Points: 13                                         │
│  Velocity Impact: ~25% of sprint capacity           │
│  Confidence: Medium (70%)                           │
├─────────────────────────────────────────────────────┤
│  Point Breakdown:                                   │
│  • Backend service: 5 points                        │
│  • Database schema: 3 points                        │
│  • UI components: 3 points                          │
│  • Integration: 2 points                            │
├─────────────────────────────────────────────────────┤
│  Comparison (similar past work):                    │
│  • Email system: 8 points (simpler)                 │
│  • Audit logging: 5 points (backend only)           │
│  • Dashboard widgets: 13 points (comparable)        │
└─────────────────────────────────────────────────────┘
```

### JSON Output

```bash
estimate "Add search feature" --json
```

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
      "mitigation": "Spike Elasticsearch integration first"
    }
  ],
  "confidence": 0.7,
  "breakdown": null
}
```

## Complexity Factors Reference

| Factor            | Low (1-3)              | Medium (4-6)            | High (7-10)                |
| ----------------- | ---------------------- | ----------------------- | -------------------------- |
| **Code**          | Bug fix, config change | New feature, module     | Architecture change        |
| **Integration**   | Isolated change        | API calls, 1-2 services | Multiple systems, external |
| **Testing**       | Existing coverage      | New test cases          | E2E, performance, security |
| **Documentation** | None needed            | Update existing         | New guides, API docs       |
| **Risk**          | Well-understood        | Some unknowns           | Significant unknowns       |

## Confidence Levels

| Level           | Range | When to Use                           |
| --------------- | ----- | ------------------------------------- |
| High (80-95%)   | ±20%  | Well-understood, similar past work    |
| Medium (60-80%) | ±40%  | Some unknowns, reasonable assumptions |
| Low (40-60%)    | ±60%  | Significant unknowns, needs spike     |

## Workflow Integration

```
estimate              ←── You are here
    ↓
workflow              # Generate implementation plan
    ↓
start                 # Initialize feature branch
    ↓
feature-dev           # Guided implementation
    ↓
check                 # Validate
    ↓
prep-pr               # Prepare for review
```

## When to Re-estimate

- After discovery of significant unknowns
- When scope changes (add/remove requirements)
- After completing a spike
- If confidence drops below 50%

## Boundaries

**Will:**

- Analyze task scope and complexity
- Provide multiple estimation formats
- Include confidence intervals (never single-point estimates)
- Identify risks and dependencies
- Break down into subtasks when requested

**Will Not:**

- Guarantee accuracy (estimates are inherently uncertain)
- Replace team estimation sessions (use as input)
- Account for non-development work (meetings, reviews)
- Estimate without sufficient context

## Related Commands

- `workflow` - Generate implementation plan from estimate
- `start` - Initialize feature development
- `feature-dev` - Guided implementation workflow
- `analyze` - Deep codebase analysis for context
