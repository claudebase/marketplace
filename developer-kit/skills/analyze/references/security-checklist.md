# Security Analysis Quick Reference

> For comprehensive security audits, use the `security` skill

## Common Vulnerabilities (OWASP Top 10 Overview)

### A01: Broken Access Control
- [ ] Missing authorization checks
- [ ] IDOR (Insecure Direct Object References)
- [ ] Path traversal vulnerabilities
- [ ] CORS misconfiguration

### A02: Cryptographic Failures
- [ ] Hardcoded secrets/API keys
- [ ] Weak encryption algorithms
- [ ] Missing HTTPS enforcement
- [ ] Sensitive data in logs

### A03: Injection
- [ ] SQL injection risks
- [ ] Command injection
- [ ] XSS (Cross-Site Scripting)
- [ ] Template injection

### A04: Insecure Design
- [ ] Missing rate limiting
- [ ] No input validation
- [ ] Trust boundary violations
- [ ] Missing security headers

### A05: Security Misconfiguration
- [ ] Debug mode in production
- [ ] Default credentials
- [ ] Verbose error messages
- [ ] Unnecessary features enabled

## Quick Patterns to Flag

### Secrets in Code
```regex
# API keys, tokens, passwords
(api[_-]?key|secret|password|token)\s*[=:]\s*['"][^'"]+['"]
```

### SQL Injection Risk
```regex
# String concatenation in queries
query\s*=.*\+.*\$|f".*SELECT.*{
```

### XSS Risk
```regex
# Direct HTML insertion
innerHTML\s*=|dangerouslySetInnerHTML|v-html
```

### Hardcoded Credentials
```regex
# Common credential patterns
password\s*=\s*['"][^'"]+['"]
```

## Severity Mapping

| Finding | Severity |
|---------|----------|
| Hardcoded secrets | Critical |
| SQL injection | Critical |
| XSS vulnerability | High |
| Missing auth check | High |
| CORS misconfiguration | Medium |
| Verbose errors | Medium |
| Missing headers | Low |
