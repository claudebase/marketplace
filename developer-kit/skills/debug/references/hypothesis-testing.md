# Hypothesis Testing for Debugging

## The Scientific Method Applied to Debugging

```
        ┌─────────────┐
        │  Observe    │
        │  Problem    │
        └──────┬──────┘
               │
        ┌──────▼──────┐
        │   Form      │
        │ Hypothesis  │
        └──────┬──────┘
               │
        ┌──────▼──────┐
        │   Design    │
        │    Test     │
        └──────┬──────┘
               │
        ┌──────▼──────┐
        │   Execute   │
        │    Test     │
        └──────┬──────┘
               │
        ┌──────▼──────┐     ┌─────────────┐
        │  Analyze    │────►│   Refine    │
        │  Results    │     │ Hypothesis  │
        └──────┬──────┘     └──────┬──────┘
               │                   │
               │◄──────────────────┘
               │
        ┌──────▼──────┐
        │  Conclude   │
        │  & Document │
        └─────────────┘
```

## Forming Good Hypotheses

### Hypothesis Criteria

```markdown
## A Good Hypothesis Is:

### Testable
- Can be verified or falsified with evidence
- Has clear success/failure criteria
- Doesn't require special access you don't have

### Specific
- Identifies exact mechanism
- Names specific components
- Describes expected behavior

### Falsifiable
- Evidence could prove it wrong
- Not vague enough to explain anything
- Has clear negative case

### Based on Evidence
- Starts from observed facts
- Considers known constraints
- Uses available data
```

### Hypothesis Template

```markdown
## Hypothesis: [ID]

### Statement
If [condition], then [expected outcome], because [mechanism].

### Evidence Supporting
- [Observation 1]
- [Observation 2]

### Evidence Against
- [Contradiction 1]

### Test Plan
1. [Step to verify]
2. [Expected result]
3. [How to interpret]

### Likelihood: High/Medium/Low

### Priority: 1/2/3
```

## Generating Multiple Hypotheses

### Brainstorming Categories

```markdown
## For Any Bug, Consider:

### Code Issues
- Logic error in the specific function
- Edge case not handled
- Race condition
- Memory leak
- Type mismatch

### Data Issues
- Invalid input
- Missing data
- Corrupt data
- Wrong format
- Encoding problems

### Configuration Issues
- Wrong environment variable
- Incorrect setting
- Version mismatch
- Feature flag state

### Infrastructure Issues
- Resource exhaustion
- Network problem
- Service dependency down
- Timeout too short

### External Factors
- Third-party API change
- Rate limiting
- Certificate expired
- DNS issue
```

### Hypothesis Matrix

```markdown
| ID | Hypothesis | Likelihood | Evidence | Test Difficulty |
|----|------------|------------|----------|-----------------|
| H1 | Memory leak in auth | High | OOM errors | Medium |
| H2 | Database timeout | Medium | Slow queries | Easy |
| H3 | Race condition | Low | Intermittent | Hard |
| H4 | Config mismatch | Medium | Recent deploy | Easy |
```

## Testing Hypotheses Systematically

### Test Priority Order

```
            ┌─────────────────────────────────────┐
            │     Prioritization Matrix           │
            │                                     │
            │  High    │ 1. Test   │ 2. Test     │
            │Likelihood│    First  │    Second   │
            │          │           │             │
            │  Low     │ 3. Test   │ 4. Test     │
            │Likelihood│    Third  │    Last     │
            │          │           │             │
            │          │ Easy Test │ Hard Test   │
            └─────────────────────────────────────┘
```

### Test Design Principles

```markdown
## Isolation
- Test one variable at a time
- Control other factors
- Use known-good baselines

## Reproducibility
- Document exact steps
- Note all conditions
- Make it repeatable

## Observability
- Capture all relevant data
- Log before and after
- Measure what matters

## Reversibility
- Don't make permanent changes
- Be able to restore state
- Test in safe environment
```

### Test Execution Template

```markdown
## Test for Hypothesis: [H1]

### Setup
- Environment: [staging/local/prod-like]
- Data state: [describe initial state]
- Configuration: [relevant settings]

### Steps
1. [Precise action]
   - Expected: [what should happen]
   - Actual: [fill in during test]

2. [Precise action]
   - Expected: [what should happen]
   - Actual: [fill in during test]

### Observations
- [What was observed]
- [Any unexpected behavior]

### Conclusion
- [ ] Hypothesis CONFIRMED
- [ ] Hypothesis REJECTED
- [ ] Inconclusive - needs more testing

### Next Steps
- [Based on results]
```

## Avoiding Cognitive Biases

### Common Debugging Biases

```markdown
## Confirmation Bias
**What**: Seeking evidence that supports your theory
**Counter**: Actively look for evidence AGAINST your hypothesis

## Anchoring Bias
**What**: Over-relying on first piece of information
**Counter**: Generate multiple hypotheses before testing any

## Availability Bias
**What**: Assuming recent/memorable issues are the cause
**Counter**: Systematically consider all categories

## Sunk Cost Fallacy
**What**: Continuing with theory because time invested
**Counter**: Set clear criteria for abandoning hypothesis

## Recency Bias
**What**: Blaming the most recent change
**Counter**: Consider all changes, not just recent ones
```

### Bias Prevention Checklist

```markdown
Before concluding, ask:
- [ ] Did I consider alternative explanations?
- [ ] Did I look for disconfirming evidence?
- [ ] Did I test the most likely cause first, not my favorite theory?
- [ ] Can someone else reproduce my findings?
- [ ] Am I concluding based on evidence or assumption?
```

## Evidence Evaluation

### Evidence Quality Tiers

| Tier | Type | Reliability | Example |
|------|------|-------------|---------|
| 1 | Direct reproduction | Highest | Bug reproduced on demand |
| 2 | System logs | High | Error message with stack trace |
| 3 | Metrics/monitoring | High | Graph showing correlation |
| 4 | User reports | Medium | "It crashed around 3pm" |
| 5 | Inference | Lower | "It must be X because..." |
| 6 | Speculation | Lowest | "Maybe it's the new code" |

### Evidence Documentation

```markdown
## Evidence Record

### Evidence ID: E-001

**Type**: System Log
**Source**: /var/log/application.log
**Timestamp**: 2024-01-15 14:32:05 UTC
**Content**:
```
ERROR: Connection pool exhausted
  at Database.getConnection (db.js:45)
  at UserService.findById (user.js:23)
```

**Relevance**: Directly supports H1 (connection leak)
**Reliability**: High (system-generated)
**Preserved**: Yes (log archived)
```

## Concluding the Investigation

### Conclusion Checklist

```markdown
## Before Concluding Root Cause:

### Evidence Chain
- [ ] Each step in causal chain has evidence
- [ ] No gaps in reasoning
- [ ] Alternative explanations ruled out

### Verification
- [ ] Root cause explains ALL symptoms
- [ ] Fix addresses root cause, not symptoms
- [ ] Can reproduce problem with cause present
- [ ] Problem doesn't occur with cause removed

### Documentation
- [ ] Investigation steps recorded
- [ ] Evidence preserved
- [ ] Reasoning explained
- [ ] Learnings captured
```

### Final Report Structure

```markdown
## Investigation Conclusion

### Root Cause Statement
[One clear sentence identifying the root cause]

### Confidence Level
- High: Direct evidence, reproduced, fix verified
- Medium: Strong evidence, logical chain complete
- Low: Best hypothesis, but gaps remain

### Evidence Summary
| Evidence | Supports | Contradicts |
|----------|----------|-------------|
| [E1] | Root cause | |
| [E2] | Root cause | |
| [E3] | | Alternative theory |

### Causal Chain
[Trigger] → [Intermediate] → [Root Cause] → [Symptom]

### Remediation Verification
- Fix applied: [yes/no]
- Problem resolved: [yes/no]
- Side effects: [none/describe]
```
