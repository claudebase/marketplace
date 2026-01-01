---
name: confidence-check
description: "Pre-implementation confidence gate (≥90% required). Activates for: ready to implement, confident enough, before I start."
composable: true
mode: read-only
allowed-tools:
  - Read
  - Grep
  - Glob
  - WebFetch
  - WebSearch
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  - mcp__tavily__tavily-search
---

# Confidence Check Skill

Prevents wrong-direction execution by assessing confidence before implementation.

## Quick Reference

**Activates**: ready to implement, confident enough, before I start, ready to code, should I start
**Mode**: read-only (assessment only, no implementation)
**Output**: Confidence score with pass/fail per criterion

## Workflow

```
DUPLICATE CHECK → ARCHITECTURE → DOCS → OSS → ROOT CAUSE → SCORE
```

## 5-Point Assessment (≥90% to proceed)

1. **No duplicates** (25%) - Search codebase for existing functionality
2. **Architecture compliant** (25%) - Verify tech stack alignment
3. **Docs verified** (20%) - Review official documentation
4. **OSS referenced** (15%) - Find proven implementations
5. **Root cause clear** (15%) - Understand the actual problem

## When to Use

- Before implementing any significant task
- When uncertain about approach
- Before starting new features

## When NOT to Use

- After implementation → use `verify` skill
- Need design first → use `design` skill
- Requirements unclear → use `brainstorm` skill

## References

- [Full Guide](references/guide.md) - Complete methodology, criteria details, output formats
- [Assessment Criteria](references/assessment-criteria.md) - Detailed check explanations
- [Examples](references/examples.md) - Real-world confidence check examples

## Boundaries

**Will**: Assess confidence, search for duplicates, verify documentation, calculate score
**Will Not**: Implement code, proceed below 90% without asking, skip any criterion
