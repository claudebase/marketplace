---
name: reflect
description: "**Use at session end**. Capture progress, decisions, and learnings for continuity. Delegates to: document. Activates for: session summary, capture learnings, document decisions."
delegates-to: document
operation: reflect
argument-hint: "[--summary] [--decisions] [--next] [--save <path>]"
allowed-tools: Read, Grep, Glob, Write, TodoWrite
---

Execute the **document** skill in reflection mode.

## Delegation

This command delegates to the `document` skill which provides:

- Session activity summarization
- Decision documentation
- Learning capture
- Context preservation for continuity

## Parameters

| Parameter     | Description             |
| ------------- | ----------------------- |
| `--summary`   | Focus on work summary   |
| `--decisions` | Focus on key decisions  |
| `--next`      | Focus on next steps     |
| `--save`      | Save reflection to file |

## When to Use

- End of work session to summarize progress
- Before context handoff to another session
- To document key decisions made
- To capture insights and learnings

## Reflection Methodology

The document skill:

1. **Analyze**: Review TodoWrite status and file changes
2. **Summarize**: Document work accomplished
3. **Capture**: Record decisions and rationale
4. **Plan**: Identify next steps and follow-ups

## Output Format

```markdown
## Session Reflection

### Work Completed

- [Task 1 with outcome]
- [Task 2 with outcome]

### Key Decisions

| Decision | Rationale | Alternatives    |
| -------- | --------- | --------------- |
| [Choice] | [Why]     | [Other options] |

### Files Changed

- `path/to/file` - [purpose of change]

### Challenges Encountered

- [Challenge and how resolved]

### Lessons Learned

- [Insight 1]
- [Insight 2]

### Follow-up Items

- [ ] [Next task]
- [ ] [Technical debt]

### Context for Next Session

[Key information needed to continue]
```

## Session State Storage

Reflections can be saved to:

```
docs/session/
├── current-context.md    # Current working context
├── decisions.md          # Important decisions
└── learnings.md          # Accumulated insights
```

## Examples

```bash
reflect                              # Full reflection
reflect --summary                    # Just work summary
reflect --decisions                  # Focus on decisions
reflect --save docs/session/day1.md  # Save to file
```

## Boundaries

**Will:**

- Summarize work completed in session
- Document key decisions with rationale
- Capture lessons learned and insights
- Identify follow-up items and next steps

**Will Not:**

- Fabricate progress not actually made
- Skip documenting challenges encountered
- Overwrite existing session context without confirmation

## Related

- `document` skill - Documentation generation
- `verify` skill - Evidence-based validation (pre-commit and completion)
- `agent` - Guided session start
