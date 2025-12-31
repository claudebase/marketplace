# Debug Skill - Detailed Guide

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

## Tier 1: Quick Fix (Default)

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

## Tier 2: Systematic Investigation

**When to use:**

- Multi-component or multi-file issues
- Unclear or misleading error messages
- First fix attempt didn't work
- Expected resolution: 30-60 minutes

**The Iron Law:**

```
NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST
```

### Phase 1: Root Cause Investigation

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

### Phase 2: Pattern Analysis

- Find working examples in the codebase
- Compare against reference implementations
- Search GitHub for how others solved similar issues
- Identify differences (list every one, however small)

### Phase 3: Hypothesis Testing

```
mcp__sequential-thinking__sequentialthinking
- Form single hypothesis: "I think X because Y"
- Test minimally (smallest possible change)
- Verify before continuing
- Don't add more fixes on top of failed ones
```

### Phase 4: Implementation

- Create failing test case first
- Implement single fix addressing root cause
- Verify fix works and no regressions
- If 3+ fixes fail → escalate to Tier 3

## Tier 3: Deep Root Cause Analysis

**When to use:**

- Recurring issues that keep coming back
- Multiple fix attempts (3+) have failed
- Architectural or systemic problems suspected
- Expected resolution: 1-2 hours

### 1. Evidence Collection

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

### 2. Hypothesis Formation

```
mcp__sequential-thinking__sequentialthinking
- Develop multiple theories ranked by likelihood
- Consider all possibilities
- Avoid confirmation bias
- Apply 5 Whys technique
```

### 3. Hypothesis Testing

- Test each hypothesis systematically
- Use Fishbone analysis for complex issues
- Validate with data, not assumptions

### 4. Root Cause Identification

- Distinguish symptoms from causes
- Verify the causal chain with evidence
- Rule out alternatives

### 5. Resolution & Prevention

- Address the true root cause
- Add defense-in-depth validation
- Create prevention strategies
- Share learnings

## MCP Integration

### Context7 (Framework Documentation)

**Available Resources:**

| Resource               | Library ID                        | Snippets |
| ---------------------- | --------------------------------- | -------- |
| Node.js API            | `/websites/nodejs_api`            | 5,046    |
| Node.js Best Practices | `/goldbergyoni/nodebestpractices` | 734      |
| React                  | `/reactjs/react.dev`              | 3,742    |
| Jest                   | `/jestjs/jest`                    | 1,717    |
| VS Code Debugger       | `/microsoft/vscode-js-debug`      | 414      |

### GitHub MCP (Similar Issues)

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

### Tavily (Error Research)

**Use cases:**

- "TypeError cannot read property of undefined JavaScript fix"
- "[Framework] [error code] solution"
- "[Library] version compatibility issues"
- "How to debug [specific error pattern]"

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

## Output Formats

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
```

### Tier 3 Output

```markdown
## Root Cause Analysis: [Issue]

### Problem Statement

[Clear description]

### Research Summary

- Issues reviewed: [count and links]
- Documentation consulted: [list]

### Hypotheses Tested

1. **[Hypothesis]**: [Result - Confirmed/Rejected]

### Root Cause

[Clear statement with complete causal chain]

### Remediation

1. Immediate fix: [...]
2. Permanent solution: [...]
3. Prevention measures: [...]
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
