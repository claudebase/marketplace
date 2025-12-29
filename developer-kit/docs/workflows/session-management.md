# Session Management Workflow

Managing work context across sessions using PM Agent's PDCA cycle.

## Overview

```
Session Start → Work (PDCA) → Session End → Knowledge Evolution
```

## Session Lifecycle

### Session Start

When Claude Code starts, the Developer Kit:

1. **Displays version info**
   ```
   Developer Kit v3.4.0 | Skills: 22 | Agents: 14 | Commands: 21
   ```

2. **Restores context** (if available)
   ```
   Session restored: Branch: feature/notifications | Goal: Add email notifications | Progress: 3 done, 4 pending
   ```

3. **Loads session files**
   - `docs/session/current-context.md`
   - `docs/session/last-session.md`

### During Work (PDCA Cycle)

PM Agent runs continuous PDCA:

```
┌───────────┐    ┌───────────┐
│   PLAN    │───▶│    DO     │
│ Hypothesis│    │ Experiment│
└───────────┘    └───────────┘
      ▲                │
      │                ▼
┌───────────┐    ┌───────────┐
│    ACT    │◀───│   CHECK   │
│ Improve   │    │ Evaluate  │
└───────────┘    └───────────┘
```

### Session End

When session ends, the Developer Kit:

1. **Saves current state**
   - Updates `docs/session/last-session.md`
   - Preserves progress in `current-context.md`

2. **Evolves knowledge**
   - Success → `docs/patterns/`
   - Failure → `docs/mistakes/`

## Session Files

```
docs/
├── session/
│   ├── current-context.md    # Current work context
│   └── last-session.md       # Previous session summary
├── temp/                     # PDCA working files
│   ├── hypothesis-YYYY-MM-DD.md
│   ├── experiment-YYYY-MM-DD.md
│   └── lessons-YYYY-MM-DD.md
├── patterns/                 # Successful patterns
│   └── <pattern-name>.md
└── mistakes/                 # Documented mistakes
    └── <issue-name>.md
```

## Current Context File

`docs/session/current-context.md`:

```markdown
# Current Context: User Notifications

## Goal
Implement email notification system with templates

## Status
- [x] Branch created: feature/notifications
- [x] Requirements gathered
- [x] Design completed
- [ ] Implementation started
- [ ] Tests written
- [ ] Documentation updated
- [ ] PR ready

## Started
Date: 2025-01-15 10:30
Base: main

## Notes
- Using SendGrid for email delivery
- Need to handle rate limiting
```

## Last Session File

`docs/session/last-session.md`:

```markdown
# Last Session Summary

**Date**: 2025-01-14 17:45
**Branch**: feature/notifications

## Goal
Implement email notification system with templates

## Progress
- Completed: 3 tasks
- Pending: 4 tasks

## What Was Done
- Designed notification service architecture
- Created database schema for templates
- Set up SendGrid integration

## Next Steps
- Implement template rendering
- Add queue for async delivery
- Write unit tests

## Session Notes
Session ended normally.
```

## PDCA Workflow Details

### Plan Phase (Hypothesis)

Before starting work:
```markdown
docs/temp/hypothesis-2025-01-15.md

## Hypothesis
Template rendering should use Handlebars for flexibility

## Success Criteria
- Templates render correctly
- Variables are properly escaped
- Performance < 50ms per render

## Risks
- Complex templates may slow down
- Need to handle missing variables
```

### Do Phase (Experiment)

During implementation:
```markdown
docs/temp/experiment-2025-01-15.md

## Implementation Log

### 10:30 - Started template engine
- Chose Handlebars over Mustache
- Set up basic rendering

### 11:15 - First test
- Basic template works
- Found issue with nested objects

### 12:00 - Fixed nesting
- Added helper for deep access
- All tests passing
```

### Check Phase (Evaluation)

After implementation:
```markdown
docs/temp/lessons-2025-01-15.md

## What Worked
- Handlebars was good choice
- Helper functions are powerful

## What Failed
- Underestimated escaping complexity
- Initial approach too simple

## Metrics
- Render time: 12ms average
- Test coverage: 95%
```

### Act Phase (Improvement)

Based on results:
- **Success** → Create `docs/patterns/handlebars-templates.md`
- **Failure** → Create `docs/mistakes/template-escaping.md`
- **Global** → Update `CLAUDE.md` with learnings

## Triggering PM Agent

### Automatic Triggers
- Session start/end
- After task completion
- When mistakes detected

### Manual Triggers
```bash
reflect
```

Explicitly asks PM Agent to:
- Review current progress
- Document learnings
- Update session files

## Pattern Documentation

`docs/patterns/handlebars-templates.md`:

```markdown
# Pattern: Handlebars Templates

## Context
Need flexible email templates with variables

## Solution
Use Handlebars with custom helpers

## Implementation
\`\`\`javascript
const Handlebars = require('handlebars');

Handlebars.registerHelper('deepGet', (obj, path) => {
  return path.split('.').reduce((o, k) => o?.[k], obj);
});
\`\`\`

## When to Use
- Email templates with dynamic content
- Complex nested data structures
- Need for custom formatting

## Last Verified
2025-01-15
```

## Mistake Documentation

`docs/mistakes/template-escaping.md`:

```markdown
# Mistake: Template Escaping Issue

## What Happened
HTML in user content was being double-escaped

## Root Cause
Handlebars auto-escapes, but we also escaped before

## Why Missed
- Didn't test with HTML content
- Assumed double-escaping was safe

## Fix Applied
Used triple-mustache {{{content}}} for pre-escaped content

## Prevention Checklist
- [ ] Test with HTML content
- [ ] Document escaping strategy
- [ ] Add integration test for rendering

## Lesson Learned
Always test with special characters and HTML content
```

## Tips

1. **Start sessions with `start`** - Proper context initialization
2. **Use `reflect` regularly** - Capture learnings while fresh
3. **Review `last-session.md`** - Continue where you left off
4. **Document mistakes immediately** - Don't wait until later
5. **Extract patterns** - Turn successes into reusable knowledge
