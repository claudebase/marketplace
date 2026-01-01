---
name: analyze
description: "Multi-dimensional code analysis (quality, security, performance). Activates for: analyze, review code, check quality, find issues."
composable: true
mode: read-only
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  - mcp__github__search_code
  - mcp__github__get_file_contents
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  - mcp__sequential-thinking__sequentialthinking
---

# Analyze Skill

Comprehensive code analysis across quality, security, performance, and architecture.

## Quick Reference

**Activates for**: analyze, review code, check quality, find issues, code review
**Mode**: read-only (analyzes only, never modifies)
**Output**: Severity-rated findings with recommendations

## Workflow

```
DISCOVER → RESEARCH → ANALYZE → EVALUATE → REPORT
```

## When to Use

- Code review ("analyze this code", "review for bugs")
- Quality assessment ("check code quality", "find issues")
- Architecture review ("assess architecture", "evaluate design")

## When NOT to Use

- Security audit → use `security` skill
- Performance profiling → use `performance` skill
- Fixing issues → use `improve` or `debug` skills

## References

- [Full Guide](references/guide.md) - Complete methodology and phases
- [Analysis Domains](references/guide.md#analysis-domains) - Quality, Security, Performance
- [Issue Patterns](references/guide.md#common-issue-patterns) - Finding examples

## Boundaries

**Will**: Analyze code, run linting tools, rate findings, provide recommendations
**Will Not**: Modify code, replace specialized audits, make architectural decisions
