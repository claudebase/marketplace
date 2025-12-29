# Cross-Verification Methodology

## Verification Principles

### The Triangle Rule
Every key claim should be verified by at least 3 independent sources:
```
        Source A
          /\
         /  \
        /    \
Source B ---- Source C

Claim verified when: A + B + C agree
Claim questionable when: Any disagree
```

### Independence Criteria
Sources are independent when:
- Different authors
- Different organizations
- Different publication dates
- Different primary sources cited
- Different methodology used

### Verification Levels

| Level | Sources | Confidence |
|-------|---------|------------|
| Single source | 1 | Low (50%) |
| Corroborated | 2 | Medium (70%) |
| Verified | 3+ | High (85%) |
| Consensus | 5+ | Very High (95%) |

## Verification Process

### Step 1: Identify Key Claims
Extract the critical claims that need verification:
```markdown
## Claims to Verify

1. [Claim A] - Critical
2. [Claim B] - Important
3. [Claim C] - Supporting
```

### Step 2: Find Independent Sources
For each claim:
1. Search with different query formulations
2. Look for primary sources
3. Check official documentation
4. Find expert opinions
5. Look for contradicting views

### Step 3: Cross-Check
Create verification matrix:
```markdown
| Claim | Source 1 | Source 2 | Source 3 | Status |
|-------|----------|----------|----------|--------|
| Claim A | ✅ | ✅ | ✅ | Verified |
| Claim B | ✅ | ⚠️ | ❌ | Disputed |
| Claim C | ✅ | ✅ | - | Likely |
```

### Step 4: Resolve Conflicts
When sources disagree:
1. Check source authority
2. Check publication dates
3. Look for primary source
4. Find additional sources
5. Document uncertainty

### Step 5: Document Confidence
```markdown
## Verification Summary

### High Confidence (3+ sources agree)
- [Claim 1]
- [Claim 2]

### Medium Confidence (2 sources, no contradiction)
- [Claim 3]

### Low Confidence (single source or disputed)
- [Claim 4] - Note: Only found in [source]
- [Claim 5] - Note: Sources disagree

### Unverified
- [Claim 6] - Could not find additional sources
```

## Source Type Hierarchy

For verification, prioritize in order:

### Primary Sources (Highest)
- Original research papers
- Official announcements
- First-hand accounts
- Raw data/statistics

### Secondary Sources
- Review articles
- News reporting on primary sources
- Documentation citing primary
- Expert analysis

### Tertiary Sources
- Encyclopedias
- Textbooks
- Aggregated guides
- Tutorial sites

## Specific Verification Techniques

### Factual Claims
```
1. Find original source/study
2. Check methodology
3. Look for replication
4. Check for retractions
5. Find expert commentary
```

### Statistical Claims
```
1. Find original data source
2. Verify calculation method
3. Check sample size
4. Look for peer review
5. Find alternative analyses
```

### Technical Claims
```
1. Check official documentation
2. Test if possible
3. Find implementation examples
4. Look for known issues
5. Check version compatibility
```

### Quotes and Statements
```
1. Find original context
2. Verify attribution
3. Check for misquoting
4. Find full statement
5. Verify date and venue
```

## Handling Contradictions

### Document the Conflict
```markdown
## Contradiction Report

**Topic**: [What the disagreement is about]

**View A**: [Position]
- Source: [URL]
- Evidence: [What they claim]
- Authority: [Credibility]

**View B**: [Position]
- Source: [URL]
- Evidence: [What they claim]
- Authority: [Credibility]

**Analysis**:
- Possible reasons for disagreement
- Which is more credible and why
- What additional research would resolve

**Conclusion**: [Best assessment or "unresolved"]
```

### Common Causes of Contradiction
1. **Outdated information** - One source is old
2. **Different context** - Applies to different situations
3. **Different definitions** - Using terms differently
4. **Incomplete information** - Each has partial picture
5. **Actual disagreement** - Genuine expert dispute

## Verification Templates

### Quick Verification
```markdown
**Claim**: [Statement]
**Source 1**: [URL] - ✅/❌
**Source 2**: [URL] - ✅/❌
**Verdict**: Verified/Disputed/Uncertain
```

### Full Verification
```markdown
## Verification: [Claim]

### Claim Statement
[Exact claim being verified]

### Sources Consulted
| Source | Position | Credibility | Notes |
|--------|----------|-------------|-------|
| [S1] | Supports | High | [notes] |
| [S2] | Supports | Medium | [notes] |
| [S3] | Neutral | High | [notes] |

### Evidence Assessment
- Supporting: [count]
- Contradicting: [count]
- Neutral: [count]

### Confidence Level
[High/Medium/Low] - [Reasoning]

### Caveats
[Any limitations or conditions]
```
