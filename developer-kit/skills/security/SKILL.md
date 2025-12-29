---
name: security
description: "Security audit and vulnerability analysis (READ-ONLY - reports issues but does NOT fix them). Use security-expert agent to implement fixes. Activates for: security audit, find vulnerabilities, OWASP, threat model, security review, is this secure, check security."
allowed-tools:
  - Read
  - Grep
  - Glob
---

# Security Skill

## Purpose

Perform comprehensive security audits with a zero-trust mindset. Identify vulnerabilities, assess threats, and provide actionable remediation guidance.

**CRITICAL GUARANTEE**: This skill is READ-ONLY. Security audits report findings - they NEVER modify code. This ensures audit integrity and prevents accidental changes.

## When to Use

**Activate When:**
- User requests security audit or review
- User asks about vulnerabilities or security issues
- User needs OWASP compliance verification
- User wants threat modeling or attack vector analysis
- User asks "is this code secure?"

**Do NOT Activate When:**
- User wants general code analysis → use `analyze` skill (broad analysis)
- User wants to fix security issues → use `debug` skill after analysis
- User wants performance analysis → use `performance` skill

**Boundary Clarification:**
This skill performs dedicated security audits with OWASP methodology. The `analyze` skill provides general code analysis and will recommend this skill for security-specific concerns.

## Security Mindset

> "Think like an attacker. Defend like a guardian."

See `references/security-common.md` for core security principles (Zero Trust, Defense in Depth, Least Privilege, Fail Secure).

## Focus Areas

This skill audits for vulnerabilities across these categories:

### OWASP Top 10
Full OWASP Top 10 (2021) coverage. See `references/security-common.md` for detailed prevention strategies.

### Code-Level Vulnerabilities
- Hardcoded secrets and credentials
- Unsafe deserialization
- Path traversal vulnerabilities
- Race conditions
- Buffer overflows (in applicable languages)

### Authentication & Authorization
- Session management issues
- Privilege escalation risks
- JWT/token vulnerabilities
- OAuth implementation flaws

See `references/security-common.md` for authentication patterns and secure coding examples.

### Data Protection
- Encryption weaknesses
- Sensitive data exposure
- PII handling violations
- Insecure data storage

## Methodology

1. **Reconnaissance**: Understand application architecture and data flows
2. **Static Analysis**: Scan code for vulnerability patterns
3. **Threat Modeling**: Identify attack vectors and entry points
4. **Risk Assessment**: Rate severity and likelihood
5. **Remediation**: Provide specific fix recommendations

## Output Format

```
## Security Audit Report

### Executive Summary
- Critical: X | High: Y | Medium: Z | Low: W

### Critical Vulnerabilities
#### [VULN-001] SQL Injection in User Search
- **Location**: src/api/users.ts:45
- **Severity**: Critical (CVSS: 9.8)
- **Description**: User input directly concatenated into SQL query
- **Attack Vector**: Malicious search input can extract/modify database
- **Remediation**: Use parameterized queries
- **Code Fix**:
  ```typescript
  // Before (vulnerable)
  const query = `SELECT * FROM users WHERE name = '${input}'`;

  // After (secure)
  const query = 'SELECT * FROM users WHERE name = $1';
  const result = await db.query(query, [input]);
  ```

### Compliance Status
- [ ] OWASP A01: Issues found
- [x] OWASP A02: Compliant
...
```

## Reference Files

For detailed security patterns and checklists, see:
- `references/security-common.md` - Shared security patterns, OWASP Top 10, authentication patterns, secure coding
- `references/owasp-top-10.md` - OWASP vulnerability patterns (detailed)
- `references/threat-modeling.md` - Threat modeling methodology
- `references/security-headers.md` - HTTP security headers (CSP, HSTS, CORS)
- `references/secrets-management.md` - Secrets handling, Vault, and environment variables

## Related

- `security-expert` agent - For implementing security fixes (can write code)
- `analyze` skill - General code analysis (refers to this skill for security)
