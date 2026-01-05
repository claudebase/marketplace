# PM Agent Session Workflow

Complete session lifecycle and PDCA workflow for continuous improvement.

## Session Start Protocol

```yaml
Activation Trigger:
  - Claude Code session start
  - "What was I working on?", "status", "progress" queries

Context Restoration:
  1. Read docs/session/current-context.md
  2. Read docs/session/last-session.md
  3. Check TodoWrite for pending tasks
  4. Review recent git commits (if available)
  5. mcp__memory__search_nodes("session:current") for persistent context

User Report:
  Previous: [last session summary]
  Progress: [current progress status]
  Next: [planned next actions]
  Blockers: [issues identified]

Ready for Work:
  - User can immediately continue from last checkpoint
  - No need to re-explain context or goals
  - PM Agent knows project state, architecture, patterns
```

## During Work (Continuous PDCA Cycle)

### 1. Plan Phase (Hypothesis)

```yaml
Actions:
  - Update docs/session/current-context.md with goal
  - Create docs/temp/hypothesis-YYYY-MM-DD.md
  - Define what to implement and why
  - Identify success criteria

Example:
  goal: "Implement user authentication with JWT"
  hypothesis: "Use existing auth patterns from codebase"
  success_criteria: "Login works, tokens validated"
```

### 2. Do Phase (Experiment)

```yaml
Actions:
  - TodoWrite for task tracking (3+ steps required)
  - Update docs/session/current-context.md regularly
  - Create docs/temp/experiment-YYYY-MM-DD.md
  - Record trial and error, errors, solutions

Example Progress:
  checkpoint: "Implemented login form, testing routes"
  errors_encountered: ["CORS issue", "JWT validation failed"]
  solutions_applied: ["Added CORS config", "Fixed JWT secret"]
```

### 3. Check Phase (Evaluation)

```yaml
Actions:
  - Self-evaluate against success criteria
  - "What worked? What failed?"
  - Create docs/temp/lessons-YYYY-MM-DD.md

Questions to Ask:
  - "Did I follow the architecture patterns?"
  - "Did I read all relevant documentation first?"
  - "Did I check for existing implementations?"
  - "Am I truly done?"
  - "What mistakes did I make?"
```

### 4. Act Phase (Improvement)

```yaml
Success Path:
  - Move docs/temp/experiment-* to docs/patterns/[pattern-name].md
  - Document in docs/patterns/
  - Update CLAUDE.md if global pattern
  - Create reusable template

Failure Path:
  - Create docs/mistakes/mistake-YYYY-MM-DD.md
  - Root cause analysis
  - Create prevention checklist
  - Update anti-patterns documentation
```

## Session End Protocol

```yaml
Final Checkpoint: 1. Review TodoWrite status
  - Verify all tasks completed or documented as blocked
  - Ensure no partial implementations left

  2. Update docs/session/last-session.md
  - What was accomplished
  - What issues were encountered
  - What was learned

  3. Update docs/session/current-context.md
  - Specific next steps for next session
  - Blockers to resolve
  - Documentation to update

Documentation Cleanup: 1. Move docs/temp/ to docs/patterns/ or docs/mistakes/
  2. Update formal documentation (CLAUDE.md, project docs)
  3. Remove outdated temporary files (>7 days)

State Preservation:
  - Ensure docs/session/ files are current
  - mcp__memory__add_observations({entityName: "session:current", contents: [context]})
  - Next session can resume seamlessly
```

## Documentation Evolution Pattern

```
Trial-and-Error (docs/temp/)
       ↓
  Success → Formal Pattern (docs/patterns/)
  Failure → Mistake Record (docs/mistakes/)
       ↓
  Accumulate Knowledge
       ↓
  Extract Best Practices → CLAUDE.md
```

### Temporary Documentation (docs/temp/)

- `hypothesis-YYYY-MM-DD.md`: Initial plan and approach
- `experiment-YYYY-MM-DD.md`: Implementation log, errors, solutions
- `lessons-YYYY-MM-DD.md`: Reflections, what worked, what failed

### Formal Documentation (docs/patterns/)

Trigger: Successful implementation with verified results

Process:

1. Read docs/temp/experiment-\*.md
2. Extract successful approach
3. Clean up and formalize
4. Add concrete examples
5. Include "Last Verified" date

### Mistake Documentation (docs/mistakes/)

Trigger: Mistake detected, root cause identified

Structure:

- What Happened
- Root Cause
- Why Missed
- Fix Applied
- Prevention Checklist
- Lesson Learned

## Session Files Structure

```
docs/session/
├── current-context.md    # Current working context and goals
├── last-session.md       # Previous session summary
├── decisions.md          # Important decisions made
└── learnings.md          # Accumulated insights
```

## Memory MCP Integration

The Memory MCP uses an entity-based knowledge graph model:

```yaml
# Create entities for different knowledge types
Create entities:
  mcp__memory__create_entities([
    {name: "pattern:jwt-auth", entityType: "pattern", observations: [content]},
    {name: "decision:db-choice", entityType: "decision", observations: [rationale]},
    {name: "mistake:edge-case", entityType: "mistake", observations: [prevention]},
    {name: "session:current", entityType: "session", observations: [context]}
  ])

# Add observations to existing entities
Add observation:
  mcp__memory__add_observations([{entityName: "pattern:jwt-auth", contents: [new_content]}])

# Retrieve knowledge
Search: mcp__memory__search_nodes("jwt-auth")
Open specific: mcp__memory__open_nodes(["pattern:jwt-auth", "decision:db-choice"])
Read all: mcp__memory__read_graph()
```
