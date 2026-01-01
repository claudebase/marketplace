# Confidence Check - Assessment Criteria

Detailed explanation of the 5-point confidence assessment system.

## 1. No Duplicate Implementations (25%)

**Purpose**: Prevent reinventing existing functionality

**How to Check**:

```bash
# Search for similar functions
Grep: "function.*[similar_name]"
Glob: "**/*[related_module]*"
```

**Pass Criteria**:

- No existing implementation found
- Or existing implementation is inadequate for requirements

**Fail Criteria**:

- Similar implementation exists and meets requirements
- Duplicate code would be created

---

## 2. Architecture Compliance (25%)

**Purpose**: Ensure alignment with project conventions

**How to Check**:

- Read `CLAUDE.md`, `PLANNING.md`, `README.md`
- Check existing patterns in codebase
- Verify tech stack alignment

**Pass Criteria**:

- Uses existing frameworks/libraries
- Follows established patterns
- No unnecessary new dependencies

**Fail Criteria**:

- Introduces incompatible technology
- Violates architectural decisions
- Creates technical debt

---

## 3. Official Documentation Verified (20%)

**Purpose**: Ensure implementation follows best practices

**How to Check**:

```
mcp__context7__resolve-library-id → Get library ID
mcp__context7__query-docs → Query specific APIs
WebFetch → Official documentation URLs
```

**Pass Criteria**:

- Official docs reviewed for relevant APIs
- Version compatibility confirmed
- Known issues/limitations noted

**Fail Criteria**:

- Relying on assumptions
- Using deprecated APIs
- Version mismatch

---

## 4. Working OSS Implementations Referenced (15%)

**Purpose**: Learn from proven implementations

**How to Check**:

```
mcp__tavily__tavily-search("implementation pattern")
mcp__github__search_code("pattern filename:.ts")
```

**Pass Criteria**:

- Found working example in reputable project
- Pattern is applicable to current requirements
- Code quality is acceptable

**Fail Criteria**:

- No working examples found
- Examples are outdated or broken
- Patterns don't apply

---

## 5. Root Cause Identified (15%)

**Purpose**: Understand the actual problem before solving

**How to Check**:

- Analyze error messages and stack traces
- Review related code
- Trace data flow

**Pass Criteria**:

- Clear understanding of what causes the issue
- Can explain the problem in simple terms
- Solution addresses root cause, not symptoms

**Fail Criteria**:

- Symptoms unclear
- Multiple possible causes
- Solution might be a workaround
