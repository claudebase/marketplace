# Completion Gates Reference

Evidence-based verification before claiming completion. This is the Iron Law of verification.

## The Iron Law

```
NO COMPLETION CLAIMS WITHOUT FRESH VERIFICATION EVIDENCE
```

If you haven't run the verification command **in this message**, you cannot claim it passes.

**Violating the letter of this rule is violating the spirit of this rule.**

## The Gate Function

Before claiming ANY status or expressing satisfaction:

```
1. IDENTIFY: What command proves this claim?
2. RUN: Execute the FULL command (fresh, complete)
3. READ: Full output, check exit code, count failures
4. VERIFY: Does output confirm the claim?
   - If NO: State actual status with evidence
   - If YES: State claim WITH evidence
5. ONLY THEN: Make the claim

Skip any step = lying, not verifying
```

## Evidence Requirements Matrix

| Claim | Evidence Required | Not Sufficient |
|-------|-------------------|----------------|
| "Tests pass" | Test command output showing 0 failures | Previous run, "should pass", assumption |
| "Linter clean" | Linter output showing 0 errors | Partial check, extrapolation |
| "Build succeeds" | Build command with exit 0 | Linter passing, logs look good |
| "Bug fixed" | Test of original symptom passes | Code changed, assumed fixed |
| "Regression test works" | Red-green cycle verified | Test passes once without red check |
| "Agent completed" | VCS diff shows actual changes | Agent reports "success" |
| "Requirements met" | Line-by-line checklist | Tests passing only |
| "Phase complete" | All requirements verified | Some tests pass |

## Red Flags - STOP Immediately

If you catch yourself:

- Using "should", "probably", "seems to"
- Expressing satisfaction before verification ("Great!", "Perfect!", "Done!")
- About to commit/push/PR without verification
- Trusting agent success reports without diff check
- Relying on partial verification
- Thinking "just this once"
- Tired and wanting to finish
- Using ANY wording implying success without running verification

**STOP. Run verification. Then claim.**

## Rationalization Prevention

| Excuse | Reality |
|--------|---------|
| "Should work now" | RUN the verification command |
| "I'm confident" | Confidence ≠ evidence |
| "Just this once" | No exceptions to the iron law |
| "Linter passed" | Linter ≠ compiler ≠ tests |
| "Agent said success" | Verify independently with diff |
| "I'm tired" | Exhaustion ≠ excuse for lying |
| "Partial check is enough" | Partial proves nothing |
| "Different words so rule doesn't apply" | Spirit over letter |

## Verification Examples

### Tests
```
CORRECT:  [Run test command] → [See: 34/34 pass] → "All 34 tests pass"
WRONG:    "Should pass now" / "Looks correct" / "I think it works"
```

### Regression Tests (TDD Red-Green)
```
CORRECT:
1. Write test → Run (should fail) → See RED
2. Implement fix → Run (should pass) → See GREEN
3. Revert fix → Run (must fail) → Confirm RED
4. Restore fix → Run (passes) → Confirm GREEN

WRONG: "I've written a regression test" (without verifying red-green cycle)
```

### Build
```
CORRECT:  [Run build] → [See: exit 0] → "Build completes successfully"
WRONG:    "Linter passed" (linter doesn't verify compilation)
```

### Requirements
```
CORRECT:
1. Re-read plan/requirements
2. Create explicit checklist
3. Verify each item
4. Report gaps OR completion with evidence

WRONG: "Tests pass, phase complete" (tests ≠ requirements)
```

### Agent Delegation
```
CORRECT:
1. Agent reports success
2. Run `git diff` to check VCS
3. Verify changes exist and are correct
4. Report actual verified state

WRONG: Trust agent report without diff verification
```

## When To Apply Gate Function

**ALWAYS before:**
- ANY variation of success/completion claims
- ANY expression of satisfaction
- ANY positive statement about work state
- Committing code
- PR creation
- Task completion
- Moving to next task
- Delegating to agents

**Rule applies to:**
- Exact phrases ("tests pass")
- Paraphrases ("verification succeeded")
- Synonyms ("looks good")
- Implications ("ready to merge")
- ANY communication suggesting completion

## Verification Checklist

Before claiming completion:

- [ ] Command was actually executed (not just planned)
- [ ] Full output was examined (not just "it ran")
- [ ] Exit code was checked (0 = success)
- [ ] All items were verified (not just first/last)
- [ ] Evidence is included in claim
- [ ] No assumptions were made

## Why This Matters

Real failure modes from skipping verification:

1. **"I don't believe you"** - Trust broken, relationship damaged
2. **Undefined functions shipped** - Would crash in production
3. **Missing requirements shipped** - Incomplete features, rework
4. **False completion claims** - Time wasted → redirect → rework
5. **Violates core principle** - "Honesty is a core value"

## The Bottom Line

**No shortcuts for verification.**

Run the command. Read the output. THEN claim the result.

This is non-negotiable.
