---
name: analyze
description: "Comprehensive code analysis for quality, security, performance, and architecture. Use for code review, security scanning, performance assessment, architecture review, or technical debt evaluation. Activates for: analyze this code, review for bugs, check code quality, assess architecture, find issues, what's wrong with this code. READ-ONLY."
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - mcp__sequential-thinking__sequentialthinking
---

# Code Analysis Skill

## Purpose

Perform comprehensive static code analysis across multiple domains without modifying code. Generate severity-rated findings with actionable recommendations.

**Key Guarantee**: Read-only operation. This skill analyzes and reports - it never modifies source code.

## When to Use

**Activate When:**
- User asks to "analyze", "review", "assess", or "evaluate" code
- User wants to find bugs, issues, or problems in code
- User needs code quality assessment
- User asks "what's wrong with this code"

**Do NOT Activate When:**
- User wants security audit → use `security` skill (OWASP focus)
- User wants performance profiling → use `performance` skill (metrics focus)
- User wants test strategy → use `quality` skill (testing focus)
- User wants to fix or improve code → use `debug` or `improve` skills
- User wants explanation → use `explain` skill

**Boundary Clarification:**
This skill provides broad code analysis. For specialized deep dives:
- Security vulnerabilities → `security` skill has OWASP methodology
- Performance bottlenecks → `performance` skill has profiling tools
- Test coverage gaps → `quality` skill has testing strategies

## Analysis Domains

### 1. Code Quality
- Code smells and anti-patterns
- Maintainability issues
- Complexity metrics
- Naming conventions
- Documentation gaps

### 2. Security (Overview)
- Common vulnerability patterns
- Input validation issues
- Authentication/authorization gaps
- For deep security audits, recommend `security` skill

### 3. Performance
- Algorithmic inefficiencies
- Resource leaks
- N+1 query patterns
- Memory management issues

### 4. Architecture
- Coupling and cohesion
- SOLID principle violations
- Design pattern misuse
- Dependency issues

## Methodology

1. **Discover**: Scan project structure, identify languages and frameworks
2. **Analyze**: Apply domain-specific pattern matching and heuristics
3. **Evaluate**: Rate findings by severity (Critical/High/Medium/Low)
4. **Recommend**: Provide actionable fix suggestions
5. **Report**: Present structured findings with metrics

## MCP Integration

**Use Sequential Thinking for complex multi-step analysis:**
```
mcp__sequential-thinking__sequentialthinking - Use for structured reasoning through complex codebases
```
Sequential Thinking helps maintain analytical rigor across multiple files and domains.

## Output Format

```
## Analysis Summary
- Files analyzed: X
- Issues found: Y (X critical, Y high, Z medium)

## Critical Issues
### [Issue Title]
- **File**: path/to/file.ts:42
- **Severity**: Critical
- **Description**: [What's wrong]
- **Recommendation**: [How to fix]

## High Priority Issues
[...]

## Metrics
- Complexity score: X/10
- Maintainability: X/10
```

## Reference Files

For detailed checklists, see:
- `references/analysis-patterns.md` - Code quality patterns
- `references/security-checklist.md` - Security quick reference
- `references/performance-checklist.md` - Performance patterns
