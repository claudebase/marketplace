---
name: code-review
description: "**MUST BE USED after writing code**. Confidence-based review for PRs and local changes. Delegates to: code-reviewer. Activates for: review code, check changes, PR review."
argument-hint: "<pr-url|pr-number|path> [--strict] [--focus security|bugs|style]"
delegates-to: code-reviewer
allowed-tools: Bash(gh:*), Read, Grep, Glob, Task
---

# code-review

Invoke the `code-reviewer` agent for comprehensive code review with confidence-based filtering.

## Usage

```bash
code-review                           # Review unstaged changes
code-review 123                        # Review PR #123
code-review https://github.com/org/repo/pull/456
code-review src/auth/ --focus security
code-review --strict                   # 90% confidence threshold
```

## Parameters

| Parameter   | Description                           |
| ----------- | ------------------------------------- |
| `pr-url`    | Full GitHub PR URL                    |
| `pr-number` | PR number in current repo             |
| `path`      | Local file/directory                  |
| `--strict`  | Raise threshold to 90% (default: 80%) |
| `--focus`   | Limit scope: security, bugs, or style |

## What It Does

The `code-reviewer` agent:

1. Gathers context (CLAUDE.md, git history)
2. Analyzes changes for bugs, security issues, quality problems
3. Scores each issue 0-100 for confidence
4. Reports only high-confidence issues (≥80%, or ≥90% with --strict)

See `agents/code-reviewer.md` for detailed methodology.

## False Positive Prevention

Issues NOT flagged:

- Pre-existing issues (only reviews the diff)
- Linter/typechecker catches
- Pedantic nitpicks (unless --strict)
- Lines user didn't modify

## Related

- `code-reviewer` agent - The agent performing review
- `verify` skill - Pre-commit verification
- `git` - Git operations
