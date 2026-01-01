# Verify Skill - Detailed Guide

Ensure work quality through evidence-based validation. This skill combines pre-commit checklists with completion verification into a unified approach.

**Core Principle**: "Evidence before claims, always. No shortcuts for verification."

**Key Guarantee**: READ-ONLY - This skill validates and reports; it does not modify code.

---

## Behavioral Flow

```
┌──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
│   IDENTIFY   │     RUN      │     READ     │    VERIFY    │    REPORT    │
├──────────────┼──────────────┼──────────────┼──────────────┼──────────────┤
│ What command │ Execute the  │ Full output  │ Does output  │ Make claim   │
│ proves this  │ FULL command │ check exit   │ confirm the  │ WITH         │
│ claim?       │ (fresh)      │ code, count  │ claim?       │ evidence     │
│              │              │ failures     │              │              │
│ Define       │ Complete     │ Parse        │ Yes/No       │ State actual │
│ evidence     │ execution    │ results      │ decision     │ status       │
└──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘
     Analyze        Bash          Read          Compare        Output
```

---

## Verification Modes

### Mode 1: Pre-Commit Review (`--review`)

**When to use:** Before committing changes, user says "review my changes", "ready to commit"

**The 4-Point Checklist:**

#### 1. Tests/Validation Executed?

- Were tests run? What was the outcome?
- Command used and results
- Any failures to address?

#### 2. Edge Cases Covered?

- What edge cases were considered?
- What was intentionally left out?
- Known limitations?

#### 3. Requirements Matched?

- Do changes meet acceptance criteria?
- Any scope creep or missing features?
- Documentation updated?

#### 4. Follow-up Needed?

- Any technical debt created?
- Performance considerations?
- Rollback plan if needed?

**Methodology:**

1. **Review Diff**: Examine all changes made
2. **Run Checks**: Execute tests, linting, type checks
3. **Validate Requirements**: Compare against original request
4. **Identify Gaps**: Note any missing coverage
5. **Report**: Provide checklist-style summary

### Mode 2: Completion Verification (`--complete`)

**When to use:** Before claiming any work is done, user says "verify this works", "prove it's fixed"

**The Iron Law:**

```
NO COMPLETION CLAIMS WITHOUT FRESH VERIFICATION EVIDENCE
```

If you haven't run the verification command in this message, you cannot claim it passes.

**The Gate Function:**

```
BEFORE claiming any status or expressing satisfaction:

1. IDENTIFY: What command proves this claim?
2. RUN: Execute the FULL command (fresh, complete)
3. READ: Full output, check exit code, count failures
4. VERIFY: Does output confirm the claim?
   - If NO: State actual status with evidence
   - If YES: State claim WITH evidence
5. ONLY THEN: Make the claim

Skip any step = lying, not verifying
```

---

## Evidence Requirements

| Claim            | Requires                | Not Sufficient              |
| ---------------- | ----------------------- | --------------------------- |
| Tests pass       | Test output: 0 failures | Previous run, "should pass" |
| Linter clean     | Linter output: 0 errors | Partial check               |
| Build succeeds   | Build command: exit 0   | Linter passing              |
| Bug fixed        | Test original symptom   | Code changed                |
| Requirements met | Line-by-line checklist  | Tests passing               |
| Agent completed  | VCS diff shows changes  | Agent reports "success"     |

---

## Red Flags - STOP

If you catch yourself:

- Using "should", "probably", "seems to"
- Expressing satisfaction before verification ("Great!", "Perfect!", "Done!")
- About to commit without verification
- Trusting agent success reports
- Relying on partial verification
- Thinking "just this once"
- **ANY wording implying success without running verification**

**STOP. Run the verification. Then claim.**

---

## Rationalization Prevention

| Excuse                    | Reality                |
| ------------------------- | ---------------------- |
| "Should work now"         | RUN the verification   |
| "I'm confident"           | Confidence != evidence |
| "Just this once"          | No exceptions          |
| "Linter passed"           | Linter != compiler     |
| "Agent said success"      | Verify independently   |
| "I'm tired"               | Exhaustion != excuse   |
| "Partial check is enough" | Partial proves nothing |

---

## Validation Commands

```bash
# Git status and diff
git status
git diff --stat
git diff HEAD

# Run tests
npm test
pytest
go test ./...

# Type checking
tsc --noEmit
mypy .

# Linting
npm run lint
ruff check .
```

---

## Output Formats

### Pre-Commit Review Report

```markdown
## Pre-Commit Review

### Changes Summary

- Files changed: X
- Lines added: Y
- Lines removed: Z

### Checklist

✅ **Tests Executed**

- Command: `npm test`
- Result: 45 passed, 0 failed
- Coverage: 78% (+3%)

⚠️ **Edge Cases**

- Covered: null input, empty array
- Not covered: concurrent access (noted for future)

✅ **Requirements Matched**

- [x] Feature A implemented
- [x] Feature B implemented

📋 **Follow-up Items**

- Add rate limiting (next sprint)

### Residual Risks

| Risk             | Likelihood | Mitigation                   |
| ---------------- | ---------- | ---------------------------- |
| Concurrent edits | Low        | Add optimistic locking later |

### Recommendation

✅ Ready to commit with noted follow-ups
```

### Completion Verification Report

```markdown
## Verification: [Claim]

### Evidence

- Command: `[command run]`
- Exit code: [0/1]
- Output: [summary]

### Verdict

✅ Verified: [claim confirmed with evidence]
```

### Quick Checklist (Minimal)

```
✅ Tests pass
✅ No type errors
✅ Lint clean
⚠️ Edge case: [note]
📋 Follow-up: [note]
→ Ready to commit
```

---

## Why This Matters

From real failure modes:

- "I don't believe you" - trust broken
- Undefined functions shipped - would crash
- Missing requirements shipped - incomplete features
- Time wasted on false completion → redirect → rework
- Violates: "Honesty is a core value"

**No shortcuts for verification.**

Run the command. Read the output. THEN claim the result.

This is non-negotiable.

---

## Handoffs

| Scenario                   | Hand off to              |
| -------------------------- | ------------------------ |
| Issues found during verify | `debug` skill            |
| Need code review           | `code-reviewer` agent    |
| Pre-implementation check   | `confidence-check` skill |
| Code analysis needed       | `analyze` skill          |

---

## Related Reference Files

- [pre-commit.md](pre-commit.md) - Comprehensive pre-commit checklist (4-point system)
- [completion-gates.md](completion-gates.md) - Gate function and iron law patterns
- [evidence-patterns.md](evidence-patterns.md) - Common verification patterns by claim type
