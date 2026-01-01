---
name: verify
description: "Validates completed work through evidence-based checklists before marking tasks as done or committing code. Use when the user thinks they're finished and wants to verify everything is actually complete and working. Triggers on requests like 'verify this is done', 'check my work', 'is this ready to commit', 'validate I'm finished', 'did I miss anything', 'review before committing', or 'prove this works'. This skill validates completion - for fixing issues found, use debug or improve skills."
composable: true
mode: read-only
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
---

# Verify Skill

Evidence-based work validation with pre-commit checklists and completion verification.

## Quick Reference

**Activates**: verify, validate, ready to commit, is this done, check my work, prove it works
**Mode**: read-only (validates only, no modifications)
**Output**: Checklist report with evidence and recommendations

## Workflow

```
IDENTIFY → RUN → READ → VERIFY → REPORT
```

## Verification Modes

- `--review`: Pre-commit 4-point checklist (tests, edge cases, requirements, follow-ups)
- `--complete`: Iron law completion verification (evidence before claims)

## When to Use

- Before claiming work is complete
- Before committing or creating PRs
- After implementing features or fixes
- User says "check my work" or "ready to commit"

## When NOT to Use

- Code analysis → use `analyze` skill
- Fixing issues → use `debug` skill
- Confidence assessment → use `confidence-check` skill
- External review → use `code-reviewer` agent

## References

- [Full Guide](references/guide.md) - Complete methodology, gate function, evidence tables
- [Pre-commit Checklist](references/pre-commit.md) - 4-point checklist details
- [Completion Gates](references/completion-gates.md) - Iron law and gate patterns
- [Evidence Patterns](references/evidence-patterns.md) - Verification by claim type

## Boundaries

**Will**: Run validation commands, check evidence, report status with proof
**Will Not**: Modify code, express satisfaction without evidence, skip verification steps
