# Confidence Check Skill - Detailed Guide

Prevents wrong-direction execution by assessing confidence **BEFORE** starting implementation.

**Requirement**: ≥90% confidence to proceed with implementation.

**Test Results** (2025-10-21):

- Precision: 1.000 (no false positives)
- Recall: 1.000 (no false negatives)
- 8/8 test cases passed

---

## Behavioral Flow

```
┌──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
│  DUPLICATE   │ ARCHITECTURE │    DOCS      │     OSS      │  ROOT CAUSE  │
├──────────────┼──────────────┼──────────────┼──────────────┼──────────────┤
│ Search for   │ Verify tech  │ Review       │ Find proven  │ Understand   │
│ existing     │ stack        │ official     │ open source  │ the actual   │
│ functionality│ alignment    │ documentation│ examples     │ problem      │
│              │              │              │              │              │
│ Use Grep     │ Read project │ Use Context7 │ Use Tavily   │ Analyze      │
│ Use Glob     │ config files │ Use WebFetch │ Search GitHub│ error logs   │
│              │              │              │              │              │
│ Weight: 25%  │ Weight: 25%  │ Weight: 20%  │ Weight: 15%  │ Weight: 15%  │
└──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘
```

---

## Confidence Assessment Criteria

Calculate confidence score (0.0 - 1.0) based on 5 checks:

### 1. No Duplicate Implementations? (25%)

**Check**: Search codebase for existing functionality

```bash
# Use Grep to search for similar functions
# Use Glob to find related modules
```

✅ Pass if no duplicates found
❌ Fail if similar implementation exists

### 2. Architecture Compliance? (25%)

**Check**: Verify tech stack alignment

- Read `CLAUDE.md`, `PLANNING.md`
- Confirm existing patterns used
- Avoid reinventing existing solutions

✅ Pass if uses existing tech stack (e.g., Supabase, UV, pytest)
❌ Fail if introduces new dependencies unnecessarily

### 3. Official Documentation Verified? (20%)

**Check**: Review official docs before implementation

- Use Context7 MCP for official docs
- Use WebFetch for documentation URLs
- Verify API compatibility

✅ Pass if official docs reviewed
❌ Fail if relying on assumptions

### 4. Working OSS Implementations Referenced? (15%)

**Check**: Find proven implementations

- Use Tavily MCP or WebSearch
- Search GitHub for examples
- Verify working code samples

✅ Pass if OSS reference found
❌ Fail if no working examples

### 5. Root Cause Identified? (15%)

**Check**: Understand the actual problem

- Analyze error messages
- Check logs and stack traces
- Identify underlying issue

✅ Pass if root cause clear
❌ Fail if symptoms unclear

---

## Confidence Score Calculation

```
Total = Check1 (25%) + Check2 (25%) + Check3 (20%) + Check4 (15%) + Check5 (15%)

If Total >= 0.90:  ✅ Proceed with implementation
If Total >= 0.70:  ⚠️  Present alternatives, ask questions
If Total < 0.70:   ❌ STOP - Request more context
```

---

## Output Format

### High Confidence (≥90%)

```
📋 Confidence Checks:
   ✅ No duplicate implementations found
   ✅ Uses existing tech stack
   ✅ Official documentation verified
   ✅ Working OSS implementation found
   ✅ Root cause identified

📊 Confidence: 1.00 (100%)
✅ High confidence - Proceeding to implementation
```

### Medium Confidence (70-89%)

```
📋 Confidence Checks:
   ✅ No duplicate implementations found
   ✅ Uses existing tech stack
   ⚠️ Official documentation partially reviewed
   ❌ No OSS implementation found
   ✅ Root cause identified

📊 Confidence: 0.75 (75%)
⚠️ Medium confidence - Clarification needed before proceeding

Questions:
1. [Specific question about unclear area]
2. [Alternative approach consideration]
```

### Low Confidence (<70%)

```
📋 Confidence Checks:
   ❌ Possible duplicate found in [module]
   ⚠️ May need new dependency
   ❌ Documentation not found
   ❌ No OSS implementation found
   ⚠️ Root cause uncertain

📊 Confidence: 0.45 (45%)
❌ Low confidence - Cannot proceed

Blockers:
1. [What's preventing higher confidence]
2. [What information is needed]
```

---

## ROI

**Token Savings**: Spend 100-200 tokens on confidence check to save 5,000-50,000 tokens on wrong-direction work.

**Success Rate**: 100% precision and recall in production testing.

---

## Implementation Reference

The TypeScript implementation is available in `confidence.ts` for reference, containing:

- `confidenceCheck(context)` - Main assessment function
- Detailed check implementations
- Context interface definitions

---

## Handoffs

| Scenario                  | Hand off to        |
| ------------------------- | ------------------ |
| ≥90% confidence           | `implement` skill  |
| Need design before code   | `design` skill     |
| Need more research        | `research` skill   |
| Requirements unclear      | `brainstorm` skill |
| After implementation done | `verify` skill     |

---

## Related Reference Files

- [assessment-criteria.md](assessment-criteria.md) - Detailed criteria explanations
- [examples.md](examples.md) - Real-world confidence check examples
