---
name: estimate
description: "Estimate implementation effort for tasks, features, or projects"
delegates-to: orchestration
operation: estimate
argument-hint: "<task-description|issue-url> [--method pert|tshirt|points] [--breakdown]"
allowed-tools: Read, Grep, Glob, Task
---

# estimate - Implementation Effort Estimation

Analyze tasks and provide data-driven effort estimates with confidence intervals.

## Usage

```bash
estimate <task-description|issue-url> [options]
```

## Arguments

| Argument           | Description                              |
| ------------------ | ---------------------------------------- |
| `task-description` | Natural language description of the task |
| `issue-url`        | GitHub issue URL for context extraction  |

## Options

| Option         | Default | Description                             |
| -------------- | ------- | --------------------------------------- |
| `--method`     | pert    | Estimation method: pert, tshirt, points |
| `--type`       | effort  | Output type: time, effort, complexity   |
| `--breakdown`  | false   | Include detailed task breakdown         |
| `--confidence` | medium  | Required confidence: low, medium, high  |
| `--json`       | false   | Output in JSON format                   |

## What This Does

1. **Context Gathering** - Parse task, identify affected components, map dependencies
2. **Complexity Analysis** - Evaluate code, integration, testing, documentation needs
3. **Effort Estimation** - Generate optimistic, likely, pessimistic estimates
4. **Risk Assessment** - Identify unknowns, dependencies, skill gaps

## Estimation Methods

| Method   | Best For                | Output                   |
| -------- | ----------------------- | ------------------------ |
| `pert`   | Statistical confidence  | Expected time +/- stddev |
| `tshirt` | Sprint planning         | XS, S, M, L, XL, XXL     |
| `points` | Agile velocity tracking | 1, 2, 3, 5, 8, 13, 21    |

## Examples

```bash
# Basic PERT estimate
estimate "Add user authentication with OAuth"

# T-shirt sizing for sprint planning
estimate "Fix login timeout bug" --method tshirt

# Story points for backlog
estimate "Implement notification system" --method points

# Estimate from GitHub issue
estimate https://github.com/org/repo/issues/42

# Detailed breakdown for planning
estimate "Refactor payment module" --breakdown

# JSON output for tooling
estimate "Add search feature" --json
```

## Confidence Levels

| Level  | Range  | When                                  |
| ------ | ------ | ------------------------------------- |
| High   | +/-20% | Well-understood, similar past work    |
| Medium | +/-40% | Some unknowns, reasonable assumptions |
| Low    | +/-60% | Significant unknowns, needs spike     |

## When to Re-estimate

- After discovery of significant unknowns
- When scope changes
- After completing a spike
- If confidence drops below 50%

## References

- [Estimate Patterns](../../lib/shared-references/estimate-patterns.md) - Methods, output formats, complexity factors

## Boundaries

**Will:**

- Analyze task scope and complexity
- Provide multiple estimation formats
- Include confidence intervals
- Identify risks and dependencies

**Will Not:**

- Guarantee accuracy (estimates are uncertain)
- Replace team estimation sessions
- Account for non-development work

## Related Commands

- `workflow` - Generate implementation plan
- `start` - Initialize feature development
- `feature-dev` - Guided implementation
