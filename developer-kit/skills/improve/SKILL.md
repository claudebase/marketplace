---
name: improve
description: "Apply systematic improvements to code quality, performance, and maintainability. Use for enhancing working code through refactoring or optimization. Activates for: improve this code, optimize this, refactor, make this better, enhance performance, clean up code, reduce complexity, apply best practices. For broken code use debug."
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - Edit
  - Write
  - mcp__context7__resolve-library-id
  - mcp__context7__get-library-docs
  - mcp__sequential-thinking__sequentialthinking
---

# Improve Skill

## Purpose

Apply systematic improvements to code quality, performance, and maintainability through structured refactoring and optimization.

**Core Principle**: "Enhance incrementally, verify continuously."

**Key Distinction**: This skill enhances WORKING code. For fixing broken code, use `debug`. For analysis without changes, use `analyze`.

## When to Use

**Activate When:**
- User says "improve this code"
- User wants to "optimize" or "refactor"
- User asks to "clean up" or "make better"
- User wants "best practices" applied
- User seeks "performance improvements"

**Do NOT Activate When:**
- Code is broken/buggy → use `debug`
- User wants analysis only → use `analyze`
- User wants explanation → use `explain`

## Improvement Domains

### Quality Improvements
```
Code analysis → Smell detection → Refactoring → Validation
```
- Reduce complexity
- Improve naming
- Extract functions/classes
- Remove duplication

### Performance Improvements
```
Profiling → Bottleneck identification → Optimization → Benchmarking
```
- Algorithm optimization
- Caching strategies
- Resource efficiency
- Lazy loading

### Maintainability Improvements
```
Structure analysis → Coupling assessment → Restructuring → Documentation
```
- Improve modularity
- Reduce coupling
- Enhance cohesion
- Add clarity

### Security Improvements
```
Vulnerability scan → Risk assessment → Hardening → Verification
```
- Input validation
- Output encoding
- Authentication/Authorization
- Secure defaults

## Improvement Workflow

### 1. Analyze Current State
- Read and understand existing code
- Identify improvement opportunities
- Assess current quality metrics

### 2. Plan Improvements
- Prioritize by impact and risk
- Define expected outcomes
- Plan verification approach

### 3. Apply Changes
- Make incremental changes
- Use safe refactoring patterns
- Keep changes reversible

### 4. Validate Results
- Run tests after each change
- Verify no regressions
- Measure improvement

### 5. Document Changes
- Summarize improvements made
- Note any trade-offs
- Recommend future improvements

## Safe Refactoring Principles

### Golden Rules

1. **Working code first**: Never break working functionality
2. **Small steps**: Make incremental changes
3. **Test after each change**: Verify continuously
4. **Preserve behavior**: Same inputs → same outputs
5. **Reversibility**: Be able to undo any change

### Change Size Guidelines

| Change Size | Testing Required | Risk |
|-------------|------------------|------|
| Rename | Run related tests | Low |
| Extract function | Run unit tests | Low |
| Move code | Run module tests | Medium |
| Change interface | Run all tests | High |
| Restructure | Full regression | High |

## MCP Integration

**Use Context7 for framework-specific best practices:**
```
mcp__context7__resolve-library-id - Resolve library names first
mcp__context7__get-library-docs - Fetch current best practices for React, Node.js, TypeScript, etc.
```
Context7 ensures improvements align with official framework recommendations.

**Use Sequential Thinking for complex refactoring decisions:**
```
mcp__sequential-thinking__sequentialthinking - Use for structured improvement planning
```
Sequential Thinking helps analyze trade-offs and plan safe refactoring steps.

### Framework-Specific Patterns

```markdown
### React Improvements
- Component composition patterns
- Hook optimization
- Memoization strategies
- State management

### Node.js Improvements
- Async patterns
- Error handling
- Performance optimization
- Security hardening

### TypeScript Improvements
- Type safety enhancements
- Generic patterns
- Interface design
- Strict mode compliance
```

## Output Format

```markdown
## Improvement Report: [Target]

### Summary
[Brief overview of improvements made]

### Changes Applied

#### [Improvement 1]
- **What**: [Description]
- **Why**: [Benefit]
- **Files**: [List of modified files]

#### [Improvement 2]
...

### Metrics
| Metric | Before | After |
|--------|--------|-------|
| Complexity | X | Y |
| Coverage | X% | Y% |
| Performance | X ms | Y ms |

### Future Recommendations
- [Additional improvements not applied]
```

## Reference Files

For detailed patterns, see:
- `references/refactoring-patterns.md` - Safe refactoring techniques
- `references/improvement-checklist.md` - Quality/performance/security patterns
- `references/solid-principles.md` - SOLID principles and code metrics
