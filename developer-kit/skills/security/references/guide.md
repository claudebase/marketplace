# Security Skill - Detailed Guide

Perform comprehensive security audits with a zero-trust mindset. Identify vulnerabilities and provide actionable remediation guidance.

**CRITICAL GUARANTEE**: This skill is READ-ONLY. Security audits report findings - they NEVER modify code.

---

## Behavioral Flow

```
┌──────────────┬──────────────┬──────────────┬──────────────┐
│    SCOPE     │     SCAN     │   ANALYZE    │    REPORT    │
├──────────────┼──────────────┼──────────────┼──────────────┤
│ Identify     │ Search for   │ Assess risk  │ Document     │
│ attack       │ vulnerability│ prioritize   │ findings     │
│ surface      │ patterns     │ findings     │ with fixes   │
│              │              │              │              │
│ Map entry    │ Grep for     │ Structured   │ Remediation  │
│ points       │ patterns     │ reasoning    │ steps        │
└──────────────┴──────────────┴──────────────┴──────────────┘
     Read           Grep         Sequential      Summary
     Glob           GitHub       Thinking
                    Tavily
```

---

## OWASP Top 10 (2021)

| ID  | Category                  | Priority | Common Patterns                  |
| --- | ------------------------- | -------- | -------------------------------- |
| A01 | Broken Access Control     | Critical | Missing auth checks, IDOR        |
| A02 | Cryptographic Failures    | Critical | Weak encryption, exposed secrets |
| A03 | Injection                 | Critical | SQL, XSS, Command injection      |
| A04 | Insecure Design           | High     | Missing threat modeling          |
| A05 | Security Misconfiguration | High     | Debug mode, default creds        |
| A06 | Vulnerable Components     | High     | Outdated dependencies            |
| A07 | Auth Failures             | High     | Weak passwords, session issues   |
| A08 | Data Integrity Failures   | Medium   | Unverified updates, CI/CD issues |
| A09 | Logging Failures          | Medium   | Missing audit logs               |
| A10 | SSRF                      | Medium   | Unvalidated URLs                 |

---

## Vulnerability Patterns

### A03: Injection

**SQL Injection:**

```javascript
// VULNERABLE
const query = `SELECT * FROM users WHERE id = ${userId}`;

// SAFE
const query = "SELECT * FROM users WHERE id = $1";
const result = await db.query(query, [userId]);
```

**Search patterns:**

```
Grep: "SELECT.*\$\{" or "SELECT.*\+"
Grep: "execute.*\$\{" or "query.*\+"
```

**XSS (Cross-Site Scripting):**

```javascript
// VULNERABLE
element.innerHTML = userInput;
document.write(userInput);

// SAFE
element.textContent = userInput;
// Or use DOMPurify for HTML
element.innerHTML = DOMPurify.sanitize(userInput);
```

**Search patterns:**

```
Grep: "innerHTML\s*=" or "document\.write"
Grep: "dangerouslySetInnerHTML"
```

### A02: Cryptographic Failures

**Exposed secrets:**

```
# Search for hardcoded secrets
Grep: "password\s*=\s*[\"']"
Grep: "api_key\s*=\s*[\"']"
Grep: "secret\s*=\s*[\"']"
Grep: "AWS_SECRET" or "PRIVATE_KEY"
```

**Weak cryptography:**

```
# Check for weak algorithms
Grep: "MD5" or "SHA1" (for passwords)
Grep: "DES" or "RC4"
```

### A01: Broken Access Control

**Missing authorization:**

```javascript
// VULNERABLE - No auth check
app.get("/api/admin/users", async (req, res) => {
  const users = await getUsers();
  res.json(users);
});

// SAFE
app.get("/api/admin/users", requireAdmin, async (req, res) => {
  const users = await getUsers();
  res.json(users);
});
```

**Search patterns:**

```
Grep: "app\.(get|post|put|delete).*admin" (then check for middleware)
Grep: "@admin" or "@auth" decorators
```

---

## MCP Tool Integration

### Context7 (OWASP Documentation)

| Resource           | Library ID                | Use Case                |
| ------------------ | ------------------------- | ----------------------- |
| OWASP Cheat Sheets | `/owasp/cheatsheetseries` | Prevention guides       |
| OWASP Top 10       | `/owasp/top10`            | Vulnerability reference |

**Queries:**

```
mcp__context7__query-docs("SQL injection prevention")
mcp__context7__query-docs("XSS prevention React")
mcp__context7__query-docs("authentication best practices")
```

### Tavily (CVE Research)

```
mcp__tavily__tavily-search("CVE-2024-XXXXX vulnerability")
mcp__tavily__tavily-search("[library] security vulnerability 2024")
```

### GitHub (Security Issues)

```
mcp__github__list_issues(owner, repo, labels: ["security"])
mcp__github__search_code("security vulnerability filename:SECURITY.md")
```

---

## Audit Workflow

### 1. Scope Definition

- Identify all entry points (APIs, forms, file uploads)
- Map authentication/authorization flows
- List external dependencies
- Note data flows (input → processing → storage)

### 2. Automated Scanning

```bash
# Dependency vulnerabilities
npm audit
pip-audit
cargo audit

# Static analysis
npx eslint --plugin security
bandit -r ./src
semgrep --config auto
```

### 3. Manual Review

Focus areas:

- Authentication/authorization logic
- Input validation
- Data sanitization
- Error handling (information leakage)
- Session management
- File operations

### 4. Risk Assessment

| Severity | Impact | Exploitability | Example                |
| -------- | ------ | -------------- | ---------------------- |
| Critical | High   | Easy           | SQL injection in login |
| High     | High   | Moderate       | XSS in user content    |
| Medium   | Medium | Moderate       | Missing rate limiting  |
| Low      | Low    | Difficult      | Verbose error messages |

---

## Output Format

````markdown
## Security Audit Report

### Executive Summary

- **Risk Level**: High
- **Critical Issues**: 2
- **High Issues**: 3
- **Medium Issues**: 5

### Critical Findings

#### 1. SQL Injection in User Search

- **Location**: src/api/users.ts:45
- **OWASP**: A03:2021 - Injection
- **Risk**: Critical
- **Description**: User input directly concatenated into SQL query
- **Evidence**: `const query = "SELECT * FROM users WHERE name = '" + name + "'"`
- **Remediation**: Use parameterized queries
- **Fix Example**:
  ```typescript
  const query = "SELECT * FROM users WHERE name = $1";
  await db.query(query, [name]);
  ```
````

### Recommendations

1. Implement parameterized queries (P0)
2. Add input validation middleware (P1)
3. Enable HTTPS-only cookies (P1)

```

---

## Handoffs

| Scenario                | Hand off to             |
| ----------------------- | ----------------------- |
| Implement security fix  | `security-expert` agent |
| General code analysis   | `analyze` skill         |
| Performance issues      | `performance` skill     |

---

## Related Reference Files

- [owasp-top-10.md](owasp-top-10.md) - Vulnerability patterns
- [secrets-management.md](secrets-management.md) - Credential handling
- [security-headers.md](security-headers.md) - HTTP security
- [threat-modeling.md](threat-modeling.md) - Risk assessment
```
