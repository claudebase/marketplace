---
name: debug
description: "Unified debugging skill with tiered methodology. Activates for: 'fix this bug', 'debug this', 'why is this failing', 'troubleshoot', 'find the root cause', 'systematic debugging', 'deep investigation', 'recurring issue', 'keeps happening', 'not working', 'crashes when', 'build failing'. Tier 1 for quick fixes, Tier 2 for complex issues, Tier 3 for recurring/architectural problems."
allowed-tools:
  # Core Investigation
  - Read
  - Grep
  - Glob
  - Bash
  # Fix Implementation
  - Edit
  - Write
  # Error Research
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  # Similar Issues & Solutions
  - mcp__github__search_issues
  - mcp__github__search_code
  - mcp__github__get_file_contents
  # Error Message Research
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  # Structured Investigation
  - mcp__sequential-thinking__sequentialthinking
---

# Debug Skill

Diagnose and resolve issues through evidence-based investigation using official documentation, community solutions, and structured debugging methodologies.

**Core Principle**: "Understand before fixing. Evidence before assumptions. Verify after applying."

**Key Enhancement**: Research error messages and find similar issues before attempting fixes.

## Activation Triggers

- Bug reports ("fix this bug", "debug this", "troubleshoot")
- Error investigation ("why is this failing", "find the root cause")
- Build failures ("build failing", "compilation error")
- Runtime issues ("not working", "crashes when", "throws error")
- Recurring problems ("keeps happening", "we've fixed this before")

## Do NOT Activate When

- User wants code analysis only → use `analyze` skill
- User wants to improve working code → use `improve` skill
- User wants performance diagnosis only → use `performance` skill
- User wants explanation of how code works → use `explain` skill

## Behavioral Flow

```
┌──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
│   OBSERVE    │   RESEARCH   │  HYPOTHESIZE │     FIX      │    VERIFY    │
├──────────────┼──────────────┼──────────────┼──────────────┼──────────────┤
│ Read error   │ Search for   │ Form         │ Apply        │ Run tests    │
│ messages     │ similar      │ hypothesis   │ minimal      │ and verify   │
│ carefully    │ issues       │              │ fix          │              │
│              │              │              │              │              │
│ Reproduce    │ Lookup       │ Test         │ Add          │ Confirm      │
│ the issue    │ official     │ hypothesis   │ defense-in-  │ no           │
│ reliably     │ docs         │              │ depth        │ regressions  │
│              │              │              │              │              │
│ Gather       │ Find         │ Reject or    │ Document     │ Share        │
│ evidence     │ solutions    │ confirm      │ the fix      │ learnings    │
└──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘
     Read           Context7      Sequential      Edit           Bash
     Grep           GitHub        Thinking        Write          (test)
     Bash           Tavily
```

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
2. **Research the error** - Search for similar issues
3. **Identify likely cause** - Check the obvious first
4. **Apply targeted fix** - Minimal, focused change
5. **Verify resolution** - Run tests, confirm fix works

```
# Quick research for common errors
mcp__tavily__tavily-search("TypeError cannot read property undefined JavaScript")

# Check GitHub issues for similar problems
mcp__github__search_issues("q=[error message] repo:[framework-repo]")
```

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

```
# Read error messages completely
Read - Get full stack trace, line numbers, file paths

# Search for similar issues
mcp__github__search_issues("error message in:title,body")

# Lookup framework-specific debugging docs
mcp__context7__resolve-library-id → "/nodejs/node"
mcp__context7__query-docs("debugging async errors")

# Research error patterns
mcp__tavily__tavily-search("[framework] [error type] solution 2024")
```

- Read error messages completely (line numbers, file paths, codes)
- Reproduce consistently (exact steps, reliable trigger)
- Check recent changes (git diff, new dependencies, config)
- Search for similar issues in GitHub and forums

#### Phase 2: Pattern Analysis

- Find working examples in the codebase
- Compare against reference implementations
- Search GitHub for how others solved similar issues
- Identify differences (list every one, however small)

#### Phase 3: Hypothesis Testing

```
mcp__sequential-thinking__sequentialthinking
- Form single hypothesis: "I think X because Y"
- Test minimally (smallest possible change)
- Verify before continuing
- Don't add more fixes on top of failed ones
```

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

```
# Comprehensive research
mcp__tavily__tavily-search("[problem] root cause analysis")
mcp__github__search_code("fix for [problem pattern]")

# Framework-specific guidance
mcp__context7__query-docs("debugging [specific issue type]")
```

- Gather all available data (logs, metrics, traces)
- Document timeline of events
- Search for similar issues across multiple sources

#### 2. Hypothesis Formation

```
mcp__sequential-thinking__sequentialthinking
- Develop multiple theories ranked by likelihood
- Consider all possibilities
- Avoid confirmation bias
- Apply 5 Whys technique
```

#### 3. Hypothesis Testing

- Test each hypothesis systematically
- Use Fishbone analysis for complex issues
- Validate with data, not assumptions

#### 4. Root Cause Identification

- Distinguish symptoms from causes
- Verify the causal chain with evidence
- Rule out alternatives

#### 5. Resolution & Prevention

- Address the true root cause
- Add defense-in-depth validation
- Create prevention strategies
- Share learnings

**Reference:** `references/root-cause.md`

## MCP Integration

### Context7 (Framework Documentation)

**Primary source for debugging documentation:**

```
mcp__context7__resolve-library-id - Resolve Node.js, React, Jest IDs
mcp__context7__query-docs - Get debugging documentation
```

**Available Resources:**

| Resource               | Library ID                        | Snippets |
| ---------------------- | --------------------------------- | -------- |
| Node.js API            | `/websites/nodejs_api`            | 5,046    |
| Node.js Best Practices | `/goldbergyoni/nodebestpractices` | 734      |
| React                  | `/reactjs/react.dev`              | 3,742    |
| Jest                   | `/jestjs/jest`                    | 1,717    |
| VS Code Debugger       | `/microsoft/vscode-js-debug`      | 414      |

**Use cases:**

- "Node.js debugging async errors"
- "React error boundary implementation"
- "Jest debugging test failures"
- "Node.js uncaught exception handling"
- "React component lifecycle debugging"

### GitHub MCP (Similar Issues)

**Find similar issues and community solutions:**

```
mcp__github__search_issues - Search for similar issues
mcp__github__search_code - Find fix patterns
mcp__github__get_file_contents - Get specific fixes
```

**Search patterns:**

```
# Find similar issues in framework repos
"TypeError" "undefined" repo:facebook/react is:issue

# Find closed issues with solutions
"error message" is:issue is:closed label:bug

# Find how others fixed similar problems
"fix" "bug" "error message" filename:CHANGELOG.md

# Find error handling patterns
"try" "catch" "error" filename:.ts stars:>500
```

**Use cases:**

- Find if your error is a known issue
- See how maintainers recommend fixing it
- Get code examples from similar fixes
- Check if there's a workaround

### Tavily (Error Research)

**Search for error solutions and debugging guidance:**

```
mcp__tavily__tavily-search - Search error messages and solutions
mcp__tavily__tavily-extract - Extract debugging guides
```

**Use cases:**

- "TypeError cannot read property of undefined JavaScript fix"
- "[Framework] [error code] solution"
- "[Library] version compatibility issues"
- "How to debug [specific error pattern]"
- "[Technology] common pitfalls and solutions"

### Sequential Thinking (Structured Investigation)

**Structured reasoning for complex debugging:**

```
mcp__sequential-thinking__sequentialthinking - Hypothesis testing
```

**Use for:**

- Systematic hypothesis formation and testing
- 5 Whys root cause analysis
- Fishbone diagram reasoning
- Multi-factor problem decomposition
- Avoiding confirmation bias

## Tier Selection Guide

| Signal                                 | Tier | Research Focus           |
| -------------------------------------- | ---- | ------------------------ |
| Clear error message with line number   | 1    | Quick search for error   |
| "I don't understand why..."            | 2    | Framework docs + issues  |
| Multiple components involved           | 2    | Architecture patterns    |
| "I already tried X and it didn't work" | 2-3  | Similar closed issues    |
| "This keeps happening"                 | 3    | Deep root cause analysis |
| "We've fixed this before"              | 3    | Architectural patterns   |
| 3+ failed fix attempts                 | 3    | Alternative approaches   |

## Red Flags - Escalate Tier

If you catch yourself thinking:

- "Quick fix for now, investigate later" → Use Tier 2
- "Just try changing X and see" → Use Tier 2, research first
- "Add multiple changes, run tests" → Use Tier 2
- "One more fix attempt" (after 2+ failures) → Use Tier 3
- "Each fix reveals new problems" → Use Tier 3, question architecture

**ALL of these mean: STOP. Research first, then escalate.**

## Defense-in-Depth Validation

After fixing any bug at Tier 2+, add validation at multiple layers:

### Layer 1: Entry Point Validation

```typescript
if (!workingDirectory || workingDirectory.trim() === "") {
  throw new Error("workingDirectory cannot be empty");
}
```

### Layer 2: Business Logic Validation

```typescript
if (!projectDir) {
  throw new Error("projectDir required for workspace initialization");
}
```

### Layer 3: Environment Guards

```typescript
if (process.env.NODE_ENV === "test") {
  if (!normalized.startsWith(tmpDir)) {
    throw new Error("Refusing operation outside temp dir during tests");
  }
}
```

### Layer 4: Debug Instrumentation

```typescript
logger.debug("About to execute", { directory, cwd: process.cwd(), stack });
```

**Reference:** `references/defense-in-depth.md`

## Output Format

### Tier 1 Output

```markdown
## Quick Fix: [Issue]

**Error:** [Error message]
**Research:** [What was found searching for similar issues]
**Cause:** [Brief explanation with evidence]
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

### Research Findings

- Similar issues: [links to GitHub issues, forum posts]
- Official docs: [relevant documentation referenced]

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

### Research Summary

- Issues reviewed: [count and links]
- Documentation consulted: [list]
- Patterns identified: [list]

### Timeline

| Time | Event | Evidence |
| ---- | ----- | -------- |
| ...  | ...   | ...      |

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

## Common Error Research Patterns

### JavaScript/TypeScript Errors

```
# TypeError: Cannot read property
mcp__tavily__tavily-search("TypeError cannot read property undefined JavaScript causes fix")

# ReferenceError: X is not defined
mcp__github__search_issues("ReferenceError not defined repo:microsoft/TypeScript")

# Unhandled Promise Rejection
mcp__context7__query-docs("Node.js unhandled promise rejection")
```

### React Errors

```
# Hooks errors
mcp__context7__query-docs("React hooks rules error")

# State update on unmounted component
mcp__tavily__tavily-search("React state update unmounted component warning fix")

# Hydration mismatch
mcp__github__search_issues("hydration mismatch repo:facebook/react")
```

### Build Errors

```
# Module not found
mcp__tavily__tavily-search("[bundler] module not found error resolve")

# TypeScript compilation errors
mcp__context7__query-docs("TypeScript strict mode errors")

# Dependency conflicts
mcp__github__search_issues("peer dependency conflict")
```

## Reference Files

- `references/quick-fix.md` - Tier 1 quick troubleshooting patterns
- `references/systematic.md` - Tier 2 four-phase methodology
- `references/root-cause.md` - Tier 3 RCA techniques (5 Whys, Fishbone, Fault Tree)
- `references/defense-in-depth.md` - Multi-layer validation after fixes
- `references/fix-verification.md` - How to verify fixes work

## Handoffs

| Scenario                     | Hand off to         |
| ---------------------------- | ------------------- |
| Need code analysis only      | `analyze` skill     |
| Need to improve working code | `improve` skill     |
| Need performance diagnosis   | `performance` skill |
| Need security audit          | `security` skill    |
| Need test strategy           | `quality` skill     |

## Boundaries

**Will:**

- Investigate and diagnose bugs systematically
- Research error messages and find similar issues
- Apply fixes based on evidence and root cause
- Add defense-in-depth validation
- Document findings and lessons learned
- Search community solutions via MCP tools

**Will Not:**

- Guess at fixes without investigation
- Apply multiple untested changes at once
- Skip verification after fixing
- Ignore recurring patterns
- Make architectural changes without escalation
