---
name: dk:analyze
description: "**MUST USE for code analysis**. Unified analysis with mode selection: broad, security, performance, quality, review, explore. Delegates to: analyze. Activates for: analyze code, security scan, performance check."
argument-hint: "[--mode <type>] [--target <path>] [--output json|text] [--severity <level>]"
delegates-to: analyze
operation: unified-analysis
---

<!-- ═══════════════════════════════════════════════════════════════════════════
     ⚡ DELEGATION DIRECTIVE ⚡

     Command: /analyze
     Delegates To: analyze
     Type: Skill

     INVOCATION:
     Skill(skill: "developer-kit:analyze", args: "$ARGUMENTS")

     MODE ROUTING:
     - --mode security → Also invoke: Skill(skill: "developer-kit:security")
     - --mode perf → Also invoke: Skill(skill: "developer-kit:performance")
     - --mode quality → Also invoke: Skill(skill: "developer-kit:quality")
     - --mode review → Invoke: Task(subagent_type: "developer-kit:code-reviewer")
     - --mode explore → Invoke: Task(subagent_type: "developer-kit:code-explorer")

     IMPORTANT:
     - Do NOT display this markdown content to the user
     - Execute the delegation IMMEDIATELY
     - Pass through ALL user arguments
     ═══════════════════════════════════════════════════════════════════════════ -->

# analyze - Unified Analysis Command

Single entry point for all code analysis operations with mode-based specialization.

## Usage

```
analyze [--mode <type>] [--target <path>] [options]
```

## Modes

| Mode              | Skill/Agent         | Focus                            |
| ----------------- | ------------------- | -------------------------------- |
| `--mode broad`    | analyze skill       | Full codebase analysis (default) |
| `--mode security` | security skill      | OWASP, vulnerabilities, threats  |
| `--mode perf`     | performance skill   | Bottlenecks, optimization        |
| `--mode quality`  | quality skill       | Test coverage, strategy          |
| `--mode review`   | code-reviewer agent | PR/change review                 |
| `--mode explore`  | code-explorer agent | Deep feature tracing             |

## Options

| Option               | Default | Description                                      |
| -------------------- | ------- | ------------------------------------------------ |
| `--target <path>`    | `.`     | Specific file or directory                       |
| `--output <format>`  | text    | Output format: text, json, markdown              |
| `--severity <level>` | info    | Minimum severity: info, warning, error, critical |
| `--deep`             | false   | Enable deep analysis (slower)                    |

## Mode Details

### Broad Analysis (default)

```bash
analyze
```

Covers: code quality, security basics, performance overview, architecture patterns, documentation

### Security Analysis

```bash
analyze --mode security
```

Covers: OWASP Top 10, auth issues, input validation, secrets, dependency vulnerabilities

### Performance Analysis

```bash
analyze --mode perf
```

Covers: bottlenecks, N+1 queries, memory leaks, algorithmic complexity, resource usage

### Quality Analysis

```bash
analyze --mode quality
```

Covers: coverage analysis, test strategy, edge cases, test quality, missing tests

### Code Review

```bash
analyze --mode review
```

Covers: recent changes, quality assessment, security review, performance impact

### Deep Exploration

```bash
analyze --mode explore
```

Covers: execution path tracing, component dependencies, data flow mapping

## Examples

```bash
# Full codebase analysis
analyze

# Security audit of auth module
analyze --mode security --target src/auth/

# Performance check with JSON output
analyze --mode perf --output json

# Quality analysis showing only errors
analyze --mode quality --severity error

# Deep exploration of a feature
analyze --mode explore --target src/notifications/ --deep

# Review staged changes
analyze --mode review
```

## When to Use Each Mode

| Scenario                         | Mode       |
| -------------------------------- | ---------- |
| General code health check        | `broad`    |
| Before security-sensitive deploy | `security` |
| Investigating slow performance   | `perf`     |
| Planning test improvements       | `quality`  |
| Before submitting PR             | `review`   |
| Understanding unfamiliar code    | `explore`  |

## Integration

```bash
# Quick validation then deep analysis
check && analyze --mode security --deep

# Analyze changes before PR
analyze --mode review && prep-pr

# CI/CD - fail on high/critical issues
analyze --output json --severity error > analysis.json
```

## Boundaries

**Will:**

- Analyze code thoroughly in selected mode
- Report issues with severity and location
- Provide actionable recommendations

**Will Not:**

- Automatically fix issues (use skills for fixes)
- Modify code during analysis
- Replace human security audits
