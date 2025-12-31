---
name: security
description: "PROACTIVELY activate for: (1) security audit requests (2) vulnerability analysis (3) OWASP compliance checks. This skill should be used when the user asks to 'check security', 'find vulnerabilities', 'security review', or 'is this secure'. Also use when user mentions OWASP, threat model, or CVE. READ-ONLY - use security-expert agent for fixes."
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
---

# Security Skill

Perform comprehensive security audits with a zero-trust mindset. Identify vulnerabilities and provide actionable remediation guidance.

**CRITICAL GUARANTEE**: This skill is READ-ONLY. Security audits report findings - they NEVER modify code.

## When to Use

- Security audits ("security audit", "check security")
- Vulnerability analysis ("find vulnerabilities", "is this secure")
- OWASP compliance ("OWASP review", "Top 10 check")
- Threat modeling ("threat model", "attack vectors")
- CVE research ("check for CVEs")

## When NOT to Use

- General code analysis → use `analyze` skill
- Fixing security issues → use `security-expert` agent
- Performance analysis → use `performance` skill

## OWASP Top 10 (2021)

| ID  | Category               | Priority |
| --- | ---------------------- | -------- |
| A01 | Broken Access Control  | Critical |
| A02 | Cryptographic Failures | Critical |
| A03 | Injection              | Critical |
| A07 | XSS                    | High     |
| A09 | Logging Failures       | Medium   |

## Quick Workflow

```
SCOPE → SCAN → ANALYZE → REPORT
 Read    Grep    Sequential   Summary
 Glob    GitHub  Thinking
         Tavily
```

1. **Scope** - Identify attack surface, entry points
2. **Scan** - Search for vulnerability patterns
3. **Analyze** - Assess risk, prioritize findings
4. **Report** - Document findings with remediation steps

## Tool Integration

For library IDs and patterns, see:

- [MCP Resources](../../lib/shared-references/mcp-resources.md)
- [Tool Patterns](../../lib/shared-references/tool-integration-patterns.md)

### Key Resources

| Resource           | Library ID                | Use Case                |
| ------------------ | ------------------------- | ----------------------- |
| OWASP Cheat Sheets | `/owasp/cheatsheetseries` | Prevention guides       |
| OWASP Top 10       | `/owasp/top10`            | Vulnerability reference |

## References

- [OWASP Top 10](references/owasp-top-10.md) - Vulnerability patterns
- [Secrets Management](references/secrets-management.md) - Credential handling
- [Security Headers](references/security-headers.md) - HTTP security
- [Threat Modeling](references/threat-modeling.md) - Risk assessment

## Boundaries

**Will**: Audit code, identify vulnerabilities, research CVEs, assess OWASP compliance

**Will Not**: Modify code, fix vulnerabilities, implement security controls
