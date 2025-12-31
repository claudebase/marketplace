---
name: security
description: "Security audit and vulnerability analysis (READ-ONLY - reports issues but does NOT fix them). Use security-expert agent to implement fixes. Activates for: security audit, find vulnerabilities, OWASP, threat model, security review, is this secure, check security."
allowed-tools:
  # Core Analysis (READ-ONLY)
  - Read
  - Grep
  - Glob
  # Security Research
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  # Code Pattern Research
  - mcp__github__search_code
  - mcp__github__list_issues
  - mcp__github__get_pull_request
  # Security Documentation
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  # Threat Modeling
  - mcp__sequential-thinking__sequentialthinking
---

# Security Skill

Perform comprehensive security audits with a zero-trust mindset. Identify vulnerabilities, research threats, and provide actionable remediation guidance.

**CRITICAL GUARANTEE**: This skill is READ-ONLY. Security audits report findings - they NEVER modify code. This ensures audit integrity and prevents accidental changes.

## Activation Triggers

- Security audit requests ("security audit", "check security")
- Vulnerability analysis ("find vulnerabilities", "is this secure")
- OWASP compliance ("OWASP review", "Top 10 check")
- Threat modeling ("threat model", "attack vectors")
- CVE research ("check for CVEs", "vulnerability research")

## Do NOT Activate When

- User wants general code analysis → use `analyze` skill
- User wants to fix security issues → use `security-expert` agent
- User wants performance analysis → use `performance` skill

## Behavioral Flow

```
┌──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
│RECONNAISSANCE│   RESEARCH   │STATIC ANALYSIS│ THREAT MODEL │    REPORT    │
├──────────────┼──────────────┼──────────────┼──────────────┼──────────────┤
│ Understand   │ Lookup CVEs  │ Scan for     │ Model attack │ Document     │
│ architecture │ and advisories│ patterns     │ vectors      │ findings     │
│              │              │              │              │              │
│ Map entry    │ Get OWASP    │ Check OWASP  │ Assess risk  │ Provide      │
│ points       │ guidance     │ Top 10       │ & likelihood │ remediation  │
│              │              │              │              │              │
│ Trace data   │ Research     │ Find unsafe  │ Prioritize   │ Reference    │
│ flows        │ similar vulns│ patterns     │ by severity  │ standards    │
└──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘
     Read           Tavily          Grep         Sequential      Output
     Grep          Context7        GitHub        Thinking        Report
```

### Phase 1: RECONNAISSANCE

Understand the attack surface before scanning:

1. **Read codebase structure** - Identify architecture, frameworks, dependencies
2. **Map entry points** - Find all external inputs (APIs, forms, file uploads)
3. **Trace data flows** - Follow sensitive data through the system
4. **Identify assets** - What needs protection? (credentials, PII, business logic)

**Tools**: Read, Grep, Glob

### Phase 2: RESEARCH

Gather threat intelligence before analysis:

```
# Research CVEs for dependencies
mcp__tavily__tavily-search("CVE express.js 4.18 vulnerabilities 2024")

# Get OWASP guidance for specific vulnerability types
mcp__context7__resolve-library-id → "/owasp/cheat-sheet-series"
mcp__context7__query-docs("SQL injection prevention")

# Extract details from security advisories
mcp__tavily__tavily-extract(["https://nvd.nist.gov/vuln/detail/CVE-2024-XXXXX"])
```

**Tools**: Tavily (CVE/advisory lookup), Context7 (OWASP/security docs)

### Phase 3: STATIC ANALYSIS

Scan code for vulnerability patterns:

1. **Check OWASP Top 10** - Apply detection patterns from references
2. **Find hardcoded secrets** - Credentials, API keys, tokens
3. **Identify unsafe patterns** - eval(), innerHTML, SQL concatenation
4. **Analyze authentication** - Session handling, JWT, OAuth issues

```
# Search for common vulnerability patterns
Grep: password\s*=\s*["'][^"']+["']    # Hardcoded passwords
Grep: eval\(|exec\(                     # Code injection risks
Grep: innerHTML\s*=                     # XSS vulnerabilities
Grep: \+\s*["'].*SELECT|INSERT|UPDATE   # SQL injection
```

**Tools**: Grep, GitHub MCP (for pattern research)

### Phase 4: THREAT MODELING

Use structured reasoning for complex threats:

```
mcp__sequential-thinking__sequentialthinking
- Apply STRIDE to each component
- Model multi-step attack chains
- Assess likelihood and impact
- Prioritize by risk score
```

**STRIDE Framework:**

- **S**poofing - Can attackers impersonate users?
- **T**ampering - Can data be modified in transit/storage?
- **R**epudiation - Can actions be traced and audited?
- **I**nformation Disclosure - Can sensitive data leak?
- **D**enial of Service - Can availability be impacted?
- **E**levation of Privilege - Can users gain unauthorized access?

**Tools**: Sequential Thinking, GitHub MCP (research similar threats)

### Phase 5: REPORT

Document findings with actionable remediation:

1. **Categorize by severity** - Critical, High, Medium, Low
2. **Provide fix code** - Before/after examples
3. **Reference standards** - Link to OWASP, CWE, NIST
4. **Suggest next steps** - Hand off to security-expert agent

## MCP Integration

### Tavily (Security Research)

**Primary tool for threat intelligence:**

```
mcp__tavily__tavily-search - Research CVEs, security advisories, attack techniques
mcp__tavily__tavily-extract - Extract details from security bulletins
```

**Use cases:**

- "Find CVEs for lodash version 4.17.0"
- "Research latest JWT vulnerabilities"
- "What are common GraphQL security issues?"
- "Get security advisories for Django packages"

**Search patterns:**

```
CVE [package] [version] vulnerability
[framework] security advisory 2024
OWASP [vulnerability-type] prevention
[attack-type] mitigation techniques
```

### Context7 (Security Documentation)

**Get official security guidance:**

```
mcp__context7__resolve-library-id - Resolve security libraries/frameworks
mcp__context7__query-docs - Get OWASP, NIST, security library docs
```

**Known security resources:**

- OWASP Cheat Sheet Series
- Helmet.js (Node.js security headers)
- CORS configuration guides
- JWT best practices

**Use cases:**

- "Get OWASP SQL injection prevention guide"
- "Look up Content-Security-Policy best practices"
- "Find NIST password guidelines"

### GitHub MCP (Vulnerability Pattern Research)

**Research real-world vulnerabilities:**

```
mcp__github__search_code - Find vulnerable patterns in codebases
mcp__github__list_issues - Research known security issues
mcp__github__get_pull_request - Study security-focused fixes
```

**Use cases:**

- Search for how others fixed similar CVEs
- Find examples of secure implementations
- Research vulnerability disclosure patterns
- Study security PR reviews

### Sequential Thinking (Threat Modeling)

**Systematic threat analysis:**

```
mcp__sequential-thinking__sequentialthinking - Multi-step threat reasoning
```

**Use for:**

- STRIDE analysis of complex systems
- Multi-step exploit chain modeling
- Risk assessment across components
- Architecture security decisions

## Security Mindset

> "Think like an attacker. Defend like a guardian."

**Core Principles:**

- **Zero Trust** - Verify everything, trust nothing
- **Defense in Depth** - Multiple security layers
- **Least Privilege** - Minimum necessary access
- **Fail Secure** - Default to secure state on errors
- **Security by Design** - Build security in, don't bolt on

## Focus Areas

### OWASP Top 10 (2021)

| ID  | Vulnerability             | Detection Pattern                  |
| --- | ------------------------- | ---------------------------------- |
| A01 | Broken Access Control     | Missing auth checks, IDOR patterns |
| A02 | Cryptographic Failures    | Weak algorithms, plaintext storage |
| A03 | Injection                 | SQL concat, eval(), exec()         |
| A04 | Insecure Design           | Missing threat modeling            |
| A05 | Security Misconfiguration | Debug enabled, default creds       |
| A06 | Vulnerable Components     | Outdated dependencies              |
| A07 | Auth Failures             | Weak passwords, session issues     |
| A08 | Data Integrity Failures   | Deserialization, unsigned updates  |
| A09 | Logging Failures          | Missing audit logs                 |
| A10 | SSRF                      | URL fetching without validation    |

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

### Data Protection

- Encryption weaknesses
- Sensitive data exposure
- PII handling violations
- Insecure data storage

## Output Format

````markdown
## Security Audit Report

### Executive Summary

- Critical: X | High: Y | Medium: Z | Low: W
- Scan date: [date]
- Scope: [files/components analyzed]

### Critical Vulnerabilities

#### [VULN-001] SQL Injection in User Search

- **Location**: src/api/users.ts:45
- **Severity**: Critical (CVSS: 9.8)
- **CWE**: CWE-89
- **Description**: User input directly concatenated into SQL query
- **Attack Vector**: Malicious search input can extract/modify database
- **Evidence**: [code snippet showing vulnerability]
- **Remediation**: Use parameterized queries
- **Code Fix**:

  ```typescript
  // Before (vulnerable)
  const query = `SELECT * FROM users WHERE name = '${input}'`;

  // After (secure)
  const query = "SELECT * FROM users WHERE name = $1";
  const result = await db.query(query, [input]);
  ```
````

- **References**:
  - OWASP: https://owasp.org/Top10/A03_2021-Injection/
  - CWE: https://cwe.mitre.org/data/definitions/89.html

### Compliance Status

- [ ] OWASP A01: Issues found
- [x] OWASP A02: Compliant
- [ ] OWASP A03: Issues found
      ...

### Recommendations

1. **Immediate** - Fix critical vulnerabilities before next deploy
2. **Short-term** - Address high-severity issues within sprint
3. **Long-term** - Implement security training, automated scanning

```

## Reference Files

For detailed security patterns and checklists, see:
- `references/security-common.md` - Core principles, OWASP Top 10, secure coding
- `references/owasp-top-10.md` - Detailed vulnerability patterns and detection
- `references/threat-modeling.md` - STRIDE methodology, attack trees
- `references/security-headers.md` - HTTP headers (CSP, HSTS, CORS)
- `references/secrets-management.md` - Secrets handling, Vault, environment variables

## Handoffs

| Scenario | Hand off to |
|----------|-------------|
| Need to implement fixes | `security-expert` agent |
| Need general code review | `analyze` skill |
| Need performance analysis | `performance` skill |
| Need database security | `database` skill |

## Boundaries

**Will:**
- Perform comprehensive security audits with OWASP methodology
- Research CVEs and security advisories via Tavily
- Look up official security guidance via Context7
- Model threats using STRIDE and Sequential Thinking
- Provide specific, actionable remediation guidance
- Reference industry security standards

**Will Not:**
- Modify code (READ-ONLY guarantee)
- Implement security fixes (use `security-expert` agent)
- Perform live penetration testing
- Access production systems or networks
- Make changes without explicit handoff approval
```
