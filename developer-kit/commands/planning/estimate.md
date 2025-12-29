---
name: estimate
description: Estimate implementation effort for tasks, features, or projects
delegates-to: orchestration
operation: estimate
argument-hint: "<task-description|issue-url> [--type time|effort|complexity] [--breakdown]"
allowed-tools: Read, Grep, Glob, Task
---

# estimate

Estimate implementation effort using the `orchestration` skill.

## Usage

```bash
estimate "Add user authentication with OAuth"
estimate "Refactor payment module" --type complexity
estimate https://github.com/org/repo/issues/42 --breakdown
```

## Parameters

| Parameter | Description |
|-----------|-------------|
| `task-description` | Natural language description of the task |
| `issue-url` | GitHub issue URL for context |
| `--type` | Estimation type: time, effort, or complexity |
| `--breakdown` | Include detailed task breakdown |

## What It Does

This command delegates to the `orchestration` skill which:
1. Analyzes scope, complexity, and dependencies
2. Breaks down into implementable units
3. Scores complexity and identifies risks
4. Provides confidence intervals (ranges, not point estimates)

See `skills/orchestration/SKILL.md` for detailed methodology.

## Related

- `orchestration` skill - Task coordination
- `workflow` - Full planning workflow
- `feature-dev` - Guided implementation
