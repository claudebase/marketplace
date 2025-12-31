---
name: analyze
description: "Comprehensive code analysis for quality, security, performance, and architecture. This skill should be used when the user asks to 'analyze this code', 'review for bugs', 'check code quality', 'assess architecture', or 'find issues'. Also use when user mentions code review, technical debt, or architecture assessment. READ-ONLY - reports findings without modifying code."
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
composable: true
mode: read-only
---

# Code Analysis Skill

Perform comprehensive static code analysis across quality, security, performance, and architecture domains. Generate severity-rated findings with actionable recommendations.

**Core Principle**: "Evidence-based analysis. Every finding references a specific rule or best practice."

**Key Guarantee**: Read-only operation - analyzes and reports, never modifies code.

## When to Use

- Code review ("analyze this code", "review for bugs")
- Quality assessment ("check code quality", "find issues")
- Architecture review ("assess architecture", "evaluate design")
- Pre-merge review ("review this PR", "check changes")

## When NOT to Use

- Security audit → use `security` skill (OWASP focus)
- Performance profiling → use `performance` skill
- Fixing issues → use `improve` or `debug` skills
- Explanation → use `explain` skill

## Quick Workflow

```
DISCOVER → RESEARCH → ANALYZE → EVALUATE → REPORT
  Read     Context7    Grep    Sequential  Summary
  Glob     GitHub      Bash    Thinking
           Tavily
```

1. **Discover** - Scan project structure, identify languages/frameworks
2. **Research** - Lookup linting rules, clean code principles
3. **Analyze** - Run static analysis, detect patterns
4. **Evaluate** - Rate by severity, calculate metrics
5. **Report** - Present structured findings

## Tool Integration

For library IDs and patterns, see:

- [MCP Resources](../../lib/shared-references/mcp-resources.md)
- [Tool Patterns](../../lib/shared-references/tool-integration-patterns.md)

### Key Resources

| Resource        | Library ID                                   | Use Case       |
| --------------- | -------------------------------------------- | -------------- |
| ESLint          | `/eslint/eslint`                             | JS/TS linting  |
| TypeScript      | `/websites/typescriptlang`                   | Type checking  |
| Clean Code TS   | `/labs42io/clean-code-typescript`            | Best practices |
| Design Patterns | `/websites/refactoring_guru-design-patterns` | Architecture   |

## Severity Levels

| Level    | Description      | Examples                          |
| -------- | ---------------- | --------------------------------- |
| Critical | Immediate action | Security vulns, data loss         |
| High     | Fix soon         | Memory leaks, unhandled errors    |
| Medium   | Plan to fix      | Code smells, missing types        |
| Low      | Nice to fix      | Style issues, minor optimizations |

## References

- [Detailed Guide](references/guide.md) - Full workflow and phases
- [Analysis Domains](references/guide.md#analysis-domains) - Quality, Security, Performance, Architecture
- [Issue Patterns](references/guide.md#common-issue-patterns) - Critical, High, Medium examples
- [Output Format](references/guide.md#output-format) - Report structure

## Boundaries

**Will**: Analyze code, run linting tools, rate findings, provide recommendations

**Will Not**: Modify code, replace specialized audits, make architectural decisions
