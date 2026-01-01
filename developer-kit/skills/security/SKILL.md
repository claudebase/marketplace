---
name: security
description: "OWASP-based security auditing. Activates for: security, vulnerabilities, OWASP, CVE, injection, XSS, authentication."
allowed-tools:
  - Read
  - Grep
  - Glob
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  - mcp__github__search_code
  - mcp__github__list_issues
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  - mcp__sequential-thinking__sequentialthinking
composable: true
mode: read-only
---

# Security Skill

Comprehensive security audits with a zero-trust mindset.

**CRITICAL**: This skill is READ-ONLY. Security audits report findings - they NEVER modify code.

## Quick Reference

**Activates for**: security, vulnerabilities, OWASP, CVE, injection, XSS, authentication
**Mode**: read-only (audit only, never modifies)
**Output**: Severity-rated findings with remediation guidance

## Workflow

```
SCOPE → SCAN → ANALYZE → REPORT
```

## When to Use

- Security audits ("security audit", "check security")
- Vulnerability analysis ("find vulnerabilities", "is this secure")
- OWASP compliance ("OWASP review", "Top 10 check")
- Threat modeling ("threat model", "attack vectors")

## When NOT to Use

- General code analysis → use `analyze` skill
- Fixing security issues → use `security-expert` agent
- Performance analysis → use `performance` skill

## References

- [Full Guide](references/guide.md) - Complete workflow and phases
- [OWASP Top 10](references/owasp-top-10.md) - Vulnerability patterns
- [Secrets Management](references/secrets-management.md) - Credential handling
- [Security Headers](references/security-headers.md) - HTTP security

## Boundaries

**Will**: Audit code, identify vulnerabilities, research CVEs, assess OWASP compliance
**Will Not**: Modify code, fix vulnerabilities, implement security controls
