---
name: dk:analyze
description: "Unified code analysis with mode selection: broad, security, performance, quality, review, explore"
argument-hint: "[--mode <type>] [--target <path>] [--output json|text] [--severity <level>]"
delegates-to: analyze
operation: unified-analysis
---

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

Comprehensive analysis covering:

- Code quality and style
- Security basics
- Performance overview
- Architecture patterns
- Documentation coverage

### Security Analysis

```bash
analyze --mode security
```

Focused security audit:

- OWASP Top 10 vulnerabilities
- Authentication/authorization issues
- Input validation
- Secrets detection
- Dependency vulnerabilities

### Performance Analysis

```bash
analyze --mode perf
```

Performance investigation:

- Bottleneck identification
- N+1 query detection
- Memory leak patterns
- Algorithmic complexity
- Resource usage

### Quality Analysis

```bash
analyze --mode quality
```

Test quality assessment:

- Coverage analysis
- Test strategy evaluation
- Edge case identification
- Test quality metrics
- Missing test detection

### Code Review

```bash
analyze --mode review
```

Change-focused review:

- Recent changes analysis
- Quality assessment
- Security review
- Performance impact
- Test coverage delta

### Deep Exploration

```bash
analyze --mode explore
```

Deep feature analysis:

- Execution path tracing
- Component dependencies
- Data flow mapping
- Architecture understanding

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

## Output Format

### Text Output (default)

```
═══════════════════════════════════════════════════════════════
  Code Analysis Report
═══════════════════════════════════════════════════════════════

Mode: Broad Analysis
Target: src/
Files: 47 analyzed

───────────────────────────────────────────────────────────────
  Summary
───────────────────────────────────────────────────────────────
  Critical:  0
  High:      2
  Medium:    5
  Low:       12
  Info:      8

───────────────────────────────────────────────────────────────
  High Severity Issues
───────────────────────────────────────────────────────────────

[HIGH] SQL Injection Risk
  Location: src/api/search.ts:34
  Issue: User input directly in query string
  Fix: Use parameterized queries

[HIGH] Missing Input Validation
  Location: src/api/users.ts:56
  Issue: No validation on email field
  Fix: Add email format validation

───────────────────────────────────────────────────────────────
  Recommendations
───────────────────────────────────────────────────────────────
1. Fix 2 high severity issues before deployment
2. Add input validation to API endpoints
3. Consider adding integration tests for auth flow
```

### JSON Output

```bash
analyze --output json
```

```json
{
  "mode": "broad",
  "target": "src/",
  "files_analyzed": 47,
  "summary": {
    "critical": 0,
    "high": 2,
    "medium": 5,
    "low": 12,
    "info": 8
  },
  "issues": [
    {
      "severity": "high",
      "type": "security",
      "title": "SQL Injection Risk",
      "location": "src/api/search.ts:34",
      "description": "User input directly in query string",
      "fix": "Use parameterized queries"
    }
  ],
  "recommendations": [...]
}
```

## Integration

### With check

```bash
# Quick validation
check

# Deep analysis if issues found
analyze --mode security --deep
```

### With prep-pr

```bash
# Analyze changes before PR
analyze --mode review

# Then prepare PR
prep-pr
```

### Pipeline Usage

```bash
# CI/CD integration
analyze --output json --severity error > analysis.json
# Fail if high/critical issues
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

## Boundaries

**Will:**

- Analyze code thoroughly in selected mode
- Report issues with severity and location
- Provide actionable recommendations
- Support multiple output formats

**Will Not:**

- Automatically fix issues (use specific skills for fixes)
- Modify code during analysis
- Certify compliance (provides guidance only)
- Replace human security audits for sensitive systems
