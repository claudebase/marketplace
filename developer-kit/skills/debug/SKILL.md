---
name: debug
description: "Unified debugging skill with tiered methodology. Activates for: 'fix this bug', 'debug this', 'why is this failing', 'troubleshoot', 'find the root cause', 'systematic debugging', 'deep investigation', 'recurring issue', 'keeps happening', 'not working', 'crashes when', 'build failing'. Tier 1 for quick fixes, Tier 2 for complex issues, Tier 3 for recurring/architectural problems."
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - Edit
  - Write
  - mcp__sequential-thinking__sequentialthinking
---

# Debug Skill

## Purpose

Diagnose and resolve issues through evidence-based investigation. This skill unifies quick troubleshooting, systematic debugging, and deep root cause analysis into a tiered approach.

**Core Principle**: "Understand before fixing. Evidence before assumptions. Verify after applying."

## When to Use

**Activate When:**
- User reports a bug, error, or unexpected behavior
- Build or test failures occur
- User says "fix", "debug", "troubleshoot", or "why is this failing"
- Issues are recurring or complex
- Previous fixes haven't worked
- User reports "not working", "crashes when", "build failing"

**Do NOT Activate When:**
- User wants code analysis only → use `analyze` skill
- User wants to improve working code → use `improve` skill
- User wants performance diagnosis only → use `performance` skill
- User wants explanation of how code works → use `explain` skill

## Tiered Approach

Select tier based on issue characteristics:

### Tier 1: Quick Fix (Default)

**When to use:**
- Simple bugs with obvious causes
- Clear error messages pointing to the issue
- Single-file, localized problems
- Expected resolution: 5-15 minutes

**Methodology:**
1. **Read error message carefully** - Don't skip past errors
2. **Identify likely cause** - Check the obvious first
3. **Apply targeted fix** - Minimal, focused change
4. **Verify resolution** - Run tests, confirm fix works

**Reference:** `references/quick-fix.md`

### Tier 2: Systematic Investigation

**When to use:**
- Multi-component or multi-file issues
- Unclear or misleading error messages
- First fix attempt didn't work
- Expected resolution: 30-60 minutes

**The Iron Law:**
```
NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST
```

If you haven't completed investigation, you cannot propose fixes.

**Methodology (Four Phases):**

#### Phase 1: Root Cause Investigation
- Read error messages completely (line numbers, file paths, codes)
- Reproduce consistently (exact steps, reliable trigger)
- Check recent changes (git diff, new dependencies, config)
- Gather evidence in multi-component systems (log each layer)
- Trace data flow backward through call stack

#### Phase 2: Pattern Analysis
- Find working examples in the codebase
- Compare against reference implementations
- Identify differences (list every one, however small)
- Understand dependencies and assumptions

#### Phase 3: Hypothesis Testing
- Form single hypothesis: "I think X because Y"
- Test minimally (smallest possible change)
- Verify before continuing (worked? → Phase 4, didn't? → new hypothesis)
- Don't add more fixes on top of failed ones

#### Phase 4: Implementation
- Create failing test case first
- Implement single fix addressing root cause
- Verify fix works and no regressions
- If 3+ fixes fail → escalate to Tier 3

**Reference:** `references/systematic.md`

### Tier 3: Deep Root Cause Analysis

**When to use:**
- Recurring issues that keep coming back
- Multiple fix attempts (3+) have failed
- Architectural or systemic problems suspected
- Each fix reveals new problems elsewhere
- Expected resolution: 1-2 hours

**Methodology (Scientific Method):**

#### 1. Evidence Collection
- Gather all available data (logs, metrics, traces)
- Document timeline of events
- Identify what changed recently
- Collect primary, secondary, and verification evidence

#### 2. Hypothesis Formation
- Develop multiple theories ranked by likelihood
- Consider all possibilities
- Avoid confirmation bias
- Apply 5 Whys technique

#### 3. Hypothesis Testing
- Test each hypothesis systematically
- Use Fishbone analysis for complex issues
- Validate with data, not assumptions
- Build fault trees for multi-factor problems

#### 4. Root Cause Identification
- Distinguish symptoms from causes
- Verify the causal chain with evidence
- Rule out alternatives
- Document the investigation

#### 5. Resolution & Prevention
- Address the true root cause
- Add defense-in-depth validation
- Create prevention strategies
- Share learnings

**Reference:** `references/root-cause.md`

## Tier Selection Guide

| Signal | Tier |
|--------|------|
| Clear error message with line number | 1 |
| "I don't understand why..." | 2 |
| Multiple components involved | 2 |
| "I already tried X and it didn't work" | 2-3 |
| "This keeps happening" | 3 |
| "We've fixed this before" | 3 |
| 3+ failed fix attempts | 3 |
| Each fix reveals new problems | 3 |

## Red Flags - Escalate Tier

If you catch yourself thinking:
- "Quick fix for now, investigate later" → Use Tier 2
- "Just try changing X and see" → Use Tier 2
- "Add multiple changes, run tests" → Use Tier 2
- "One more fix attempt" (after 2+ failures) → Use Tier 3
- "Each fix reveals new problems" → Use Tier 3, question architecture

**ALL of these mean: STOP. Escalate to higher tier.**

## Defense-in-Depth Validation

After fixing any bug at Tier 2+, add validation at multiple layers:

### Layer 1: Entry Point Validation
Reject invalid input at API boundary:
```typescript
if (!workingDirectory || workingDirectory.trim() === '') {
  throw new Error('workingDirectory cannot be empty');
}
```

### Layer 2: Business Logic Validation
Ensure data makes sense for operation:
```typescript
if (!projectDir) {
  throw new Error('projectDir required for workspace initialization');
}
```

### Layer 3: Environment Guards
Prevent dangerous operations in specific contexts:
```typescript
if (process.env.NODE_ENV === 'test') {
  if (!normalized.startsWith(tmpDir)) {
    throw new Error('Refusing operation outside temp dir during tests');
  }
}
```

### Layer 4: Debug Instrumentation
Capture context for forensics:
```typescript
logger.debug('About to execute', { directory, cwd: process.cwd(), stack });
```

**Reference:** `references/defense-in-depth.md`

## MCP Integration

**Use Sequential Thinking for Tier 2 and Tier 3:**
```
mcp__sequential-thinking__sequentialthinking - Structured hypothesis testing
```

Sequential Thinking maintains analytical rigor through complex investigations and prevents jumping to conclusions.

## Output Format

### Tier 1 Output
```markdown
## Quick Fix: [Issue]

**Error:** [Error message]
**Cause:** [Brief explanation]
**Fix:** [What was changed]
**Verified:** [How confirmed]
```

### Tier 2 Output
```markdown
## Debug Report: [Issue]

### Investigation Summary
- Tier: 2 (Systematic)
- Phases completed: [1-4]
- Hypotheses tested: [count]

### Root Cause
[Clear statement with evidence]

### Fix Applied
[Description with file:line references]

### Verification
- Tests: [pass/fail count]
- Manual verification: [steps taken]

### Prevention
[Defense-in-depth additions or recommendations]
```

### Tier 3 Output
```markdown
## Root Cause Analysis: [Issue]

### Problem Statement
[Clear description]

### Timeline
| Time | Event | Evidence |
|------|-------|----------|
| ... | ... | ... |

### Hypotheses Tested
1. **[Hypothesis]**: [Result - Confirmed/Rejected]
   - Evidence for: [...]
   - Evidence against: [...]

### Root Cause
[Clear statement with complete causal chain]

### Remediation
1. Immediate fix: [...]
2. Permanent solution: [...]
3. Prevention measures: [...]

### Lessons Learned
- [Key insights]
```

## Utilities

### find-polluter.sh
Script to identify which test causes state pollution:
```bash
./references/find-polluter.sh '.git' 'src/**/*.test.ts'
```

## Reference Files

- `references/quick-fix.md` - Tier 1 quick troubleshooting patterns
- `references/systematic.md` - Tier 2 four-phase methodology
- `references/root-cause.md` - Tier 3 RCA techniques (5 Whys, Fishbone, Fault Tree)
- `references/defense-in-depth.md` - Multi-layer validation after fixes
- `references/fix-verification.md` - How to verify fixes work

## Related Skills

- `verify` - Verification before claiming completion
- `analyze` - Code analysis without modifications
- `improve` - Enhancing working code
- `performance` - Performance-specific diagnosis
