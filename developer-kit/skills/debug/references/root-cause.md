# Root Cause Analysis Methodologies

## Overview of RCA Techniques

| Technique | Best For | Complexity | Time Required |
|-----------|----------|------------|---------------|
| 5 Whys | Simple linear causation | Low | 15-30 min |
| Fishbone | Multiple contributing factors | Medium | 30-60 min |
| Fault Tree | Critical system failures | High | 1-2 hours |
| Timeline | Sequence-dependent issues | Medium | 30-60 min |
| Change Analysis | Post-deployment issues | Low | 15-30 min |

## The 5 Whys Technique

### How It Works

Ask "Why?" repeatedly (typically 5 times) until you reach the root cause.

### Example: Production Outage

```
Problem: Website is down

Why 1: The web server is not responding
Why 2: The server ran out of memory
Why 3: A memory leak in the application
Why 4: Connections to the database aren't being closed
Why 5: Error handling doesn't include connection cleanup

Root Cause: Missing finally block to close DB connections
```

### 5 Whys Best Practices

```markdown
## Do's
- Start with a clear problem statement
- Stay focused on one causal chain
- Base each answer on facts, not assumptions
- Involve people with direct knowledge
- Document each step

## Don'ts
- Don't stop at symptoms
- Don't accept "human error" as root cause
- Don't branch too early
- Don't skip levels
- Don't guess - verify
```

### When 5 Whys Falls Short

- Multiple root causes exist
- Problem is systemic
- Causation is non-linear
- Political/organizational factors involved

→ Use Fishbone or Fault Tree instead

## Fishbone (Ishikawa) Diagram

### The 6 Categories

```
                    PROBLEM
                       │
    ┌──────────────────┼──────────────────┐
    │                  │                  │
 People            Process           Technology
    │                  │                  │
    ├─ Skills          ├─ Procedures      ├─ Hardware
    ├─ Training        ├─ Workflow        ├─ Software
    ├─ Communication   ├─ Documentation   ├─ Tools
    └─ Staffing        └─ Approval        └─ Infrastructure

    │                  │                  │
Environment        Materials          Methods
    │                  │                  │
    ├─ Physical        ├─ Data quality    ├─ Standards
    ├─ Organizational  ├─ Dependencies    ├─ Best practices
    ├─ Regulatory      ├─ Third-party     ├─ Testing
    └─ Market          └─ Resources       └─ Monitoring
```

### Building a Fishbone Diagram

```markdown
## Step 1: Define the Problem
Write the problem in a box on the right

## Step 2: Draw the Spine
Draw a horizontal arrow pointing to the problem

## Step 3: Add Category Branches
Draw diagonal lines for each category

## Step 4: Brainstorm Causes
Add causes as smaller branches under each category

## Step 5: Analyze
- Circle the most likely root causes
- Verify with evidence
- Prioritize for investigation
```

### Software-Specific Fishbone

```
                    BUG/FAILURE
                       │
    ┌──────────────────┼──────────────────┐
    │                  │                  │
  Code              Config             Deploy
    │                  │                  │
    ├─ Logic error     ├─ Environment     ├─ Rollout
    ├─ Race condition  ├─ Feature flags   ├─ Migration
    ├─ Memory leak     ├─ Secrets         ├─ Dependencies
    └─ Edge case       └─ Versions        └─ Infrastructure

    │                  │                  │
  Data              External           Process
    │                  │                  │
    ├─ Invalid input   ├─ API changes     ├─ Testing gaps
    ├─ Corruption      ├─ Rate limits     ├─ Review missed
    ├─ Migration       ├─ Network         ├─ Documentation
    └─ Volume          └─ Third-party     └─ Monitoring
```

## Fault Tree Analysis (FTA)

### Structure

```
                    [Top Event]
                    (System Failure)
                         │
                    ┌────┴────┐
                   AND       OR
                    │         │
               ┌────┴────┐    │
              [A]       [B]  [C]
               │
          ┌────┴────┐
         [D]       [E]
```

### Gate Types

| Gate | Symbol | Meaning |
|------|--------|---------|
| AND | ∩ | All inputs must occur |
| OR | ∪ | Any input can cause output |
| XOR | ⊕ | Exactly one input |
| NOT | ¬ | Inverter |

### FTA Example: Login Failure

```
              [Login Failure]
                    │
               ┌────┴────┐
              OR        OR
               │         │
    ┌──────────┴──┐      │
[Auth Failed]  [Network] [UI Bug]
    │
    ├── Wrong password
    ├── Account locked
    ├── Token expired
    └── Service down
```

### Building a Fault Tree

```markdown
## Step 1: Define Top Event
What failure are we analyzing?

## Step 2: Identify Immediate Causes
What could directly cause this?

## Step 3: Determine Relationships
- AND: All must occur
- OR: Any can cause it

## Step 4: Expand Each Branch
Continue until reaching basic events

## Step 5: Calculate Probabilities
If data available, compute failure rates

## Step 6: Identify Cut Sets
Minimal combinations that cause failure
```

## Timeline Analysis

### Template

```markdown
## Incident Timeline: [Title]

### Normal State
[Describe expected behavior]

### Timeline

| Time | Event | Source | Impact |
|------|-------|--------|--------|
| T-24h | Deploy v2.3.1 | Git | New feature released |
| T-12h | Traffic spike | Monitoring | 2x normal load |
| T-1h | First error logged | Logs | Single occurrence |
| T-30m | Error rate 5% | Monitoring | Users impacted |
| T-15m | Alert fired | PagerDuty | Team notified |
| T-0 | Investigation start | | |
| T+15m | Root cause identified | | |
| T+30m | Fix deployed | | |
| T+45m | Normal operation | | |

### Key Observations
1. [Correlation between events]
2. [Pattern identified]
3. [Gap in monitoring]

### Root Cause
[Based on timeline analysis]
```

## Change Analysis

### The Change Matrix

```markdown
## Change Analysis: [Problem]

### What Changed?

| Category | Before | After | Verified |
|----------|--------|-------|----------|
| Code | v2.3.0 | v2.3.1 | ✓ |
| Config | Standard | Modified | ✓ |
| Infrastructure | 3 nodes | 5 nodes | ✓ |
| Dependencies | lodash 4.17.20 | 4.17.21 | ✓ |
| Traffic | 1000 rps | 2000 rps | ✓ |
| Team | Full staff | 2 on vacation | ✓ |

### Impact Analysis

| Change | Could Cause Problem? | Evidence |
|--------|---------------------|----------|
| Code v2.3.1 | Yes | New query introduced |
| 5 nodes | Unlikely | Scaling typically helps |
| lodash update | No | Only security patch |
| 2x traffic | Possible | Timing correlates |

### Conclusion
[Most likely change that caused the issue]
```

## Choosing the Right Technique

```
Is the causation linear and simple?
├── Yes → Use 5 Whys
└── No
    ├── Multiple contributing factors?
    │   └── Yes → Use Fishbone
    ├── Critical system with known components?
    │   └── Yes → Use Fault Tree
    ├── Time-sequence dependent?
    │   └── Yes → Use Timeline
    └── Recent changes suspected?
        └── Yes → Use Change Analysis
```
