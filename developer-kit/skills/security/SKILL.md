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

## MCP Integration

### Context7 Security Resources

| Resource              | Library ID                               | Snippets | Use For                         |
| --------------------- | ---------------------------------------- | -------- | ------------------------------- |
| OWASP Cheat Sheets    | `/owasp/cheatsheetseries`                | 963      | Vulnerability prevention guides |
| OWASP Top 10          | `/owasp/top10`                           | 98       | Top 10 vulnerability reference  |
| OWASP Developer Guide | `/owasp/devguide`                        | 67       | Secure development practices    |
| Helmet.js             | `/helmetjs/helmet`                       | 93       | Security headers configuration  |
| jsonwebtoken          | `/auth0/node-jsonwebtoken`               | 70       | JWT security patterns           |
| bcrypt.js             | `/dcodeio/bcrypt.js`                     | 47       | Password hashing                |
| Snyk CLI              | `/snyk/cli`                              | 6,237    | Vulnerability scanning          |
| Auth0 Node.js         | `/auth0/node-auth0`                      | 4,770    | Authentication patterns         |
| Passport OAuth2       | `/jaredhanson/passport-oauth2`           | 32       | OAuth security                  |
| Passport JWT          | `/mikenicholson/passport-jwt`            | 11       | JWT authentication              |
| Express Rate Limit    | `/express-rate-limit/express-rate-limit` | 86       | Rate limiting patterns          |
| ESLint                | `/websites/eslint`                       | 1,899    | Security linting rules          |

### Context7 Query Patterns

```
# Get OWASP prevention guidance
mcp__context7__resolve-library-id(query="OWASP security cheat sheets", libraryName="OWASP")
mcp__context7__query-docs(libraryId="/owasp/cheatsheetseries", query="SQL injection prevention parameterized queries")

# Get security header configuration
mcp__context7__query-docs(libraryId="/helmetjs/helmet", query="Content-Security-Policy CSP headers")

# Get JWT security best practices
mcp__context7__query-docs(libraryId="/auth0/node-jsonwebtoken", query="JWT verification algorithm restriction")

# Get password hashing guidance
mcp__context7__query-docs(libraryId="/dcodeio/bcrypt.js", query="password hashing salt rounds security")

# Get vulnerability scanning commands
mcp__context7__query-docs(libraryId="/snyk/cli", query="vulnerability scanning dependency audit")
```

### Tavily Security Research

```
# CVE and vulnerability research
mcp__tavily__tavily-search(query="CVE [package] [version] vulnerability 2024", search_depth="advanced")

# Security advisory lookup
mcp__tavily__tavily-search(query="[framework] security advisory disclosure", topic="news", days=30)

# Attack technique research
mcp__tavily__tavily-search(query="[attack-type] mitigation techniques OWASP")

# Extract security bulletin details
mcp__tavily__tavily-extract(urls=["https://nvd.nist.gov/vuln/detail/CVE-2024-XXXXX"])
```

### GitHub Security Research

```
# Find vulnerability fix patterns
mcp__github__search_code(q="fix CVE sql injection parameterized query language:javascript")

# Research security issues in similar projects
mcp__github__list_issues(owner="org", repo="project", labels=["security"])

# Study security-focused PRs
mcp__github__get_pull_request(owner="org", repo="project", pull_number=123)
```

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

```javascript
// Research CVEs for dependencies
mcp__tavily__tavily -
  search({
    query: "CVE express.js 4.18 vulnerabilities 2024",
    search_depth: "advanced",
    max_results: 10,
  });

// Get OWASP guidance for specific vulnerability types
mcp__context7__resolve -
  library -
  id({
    query: "OWASP security vulnerability prevention",
    libraryName: "OWASP",
  });
// Returns: /owasp/cheatsheetseries

mcp__context7__query -
  docs({
    libraryId: "/owasp/cheatsheetseries",
    query: "SQL injection prevention parameterized queries",
  });

// Extract details from security advisories
mcp__tavily__tavily -
  extract({
    urls: ["https://nvd.nist.gov/vuln/detail/CVE-2024-XXXXX"],
    extract_depth: "advanced",
  });
```

**Tools**: Tavily (CVE/advisory lookup), Context7 (OWASP/security docs)

### Phase 3: STATIC ANALYSIS

Scan code for vulnerability patterns:

1. **Check OWASP Top 10** - Apply detection patterns from references
2. **Find hardcoded secrets** - Credentials, API keys, tokens
3. **Identify unsafe patterns** - eval(), innerHTML, SQL concatenation
4. **Analyze authentication** - Session handling, JWT, OAuth issues

```bash
# Search for common vulnerability patterns
Grep: password\s*=\s*["'][^"']+["']    # Hardcoded passwords
Grep: eval\(|exec\(                     # Code injection risks
Grep: innerHTML\s*=                     # XSS vulnerabilities
Grep: \+\s*["'].*SELECT|INSERT|UPDATE   # SQL injection
Grep: process\.env\.\w+                 # Environment variable usage
Grep: crypto\.createCipher\(            # Deprecated crypto (use createCipheriv)
Grep: Math\.random\(\).*password|token  # Weak randomness for secrets
```

**Tools**: Grep, GitHub MCP (for pattern research)

### Phase 4: THREAT MODELING

Use structured reasoning for complex threats:

```javascript
mcp__sequential -
  thinking__sequentialthinking({
    thought: "Applying STRIDE to authentication component...",
    thoughtNumber: 1,
    totalThoughts: 6,
    nextThoughtNeeded: true,
  });
```

**STRIDE Framework:**

| Threat                     | Question                                 | Detection                               |
| -------------------------- | ---------------------------------------- | --------------------------------------- |
| **S**poofing               | Can attackers impersonate users?         | Check auth mechanisms, session handling |
| **T**ampering              | Can data be modified in transit/storage? | Check integrity controls, signatures    |
| **R**epudiation            | Can actions be traced and audited?       | Check logging, audit trails             |
| **I**nformation Disclosure | Can sensitive data leak?                 | Check encryption, access controls       |
| **D**enial of Service      | Can availability be impacted?            | Check rate limiting, resource limits    |
| **E**levation of Privilege | Can users gain unauthorized access?      | Check authorization, role validation    |

**Tools**: Sequential Thinking, GitHub MCP (research similar threats)

### Phase 5: REPORT

Document findings with actionable remediation:

1. **Categorize by severity** - Critical, High, Medium, Low
2. **Provide fix code** - Before/after examples
3. **Reference standards** - Link to OWASP, CWE, NIST
4. **Suggest next steps** - Hand off to security-expert agent

## OWASP Top 10 (2021) Detection Patterns

| ID  | Vulnerability             | Grep Patterns                                       | Context7 Query                                                  |
| --- | ------------------------- | --------------------------------------------------- | --------------------------------------------------------------- |
| A01 | Broken Access Control     | `@Public\|@AllowAnonymous`, missing auth middleware | `/owasp/cheatsheetseries` → "access control authorization"      |
| A02 | Cryptographic Failures    | `MD5\|SHA1\|DES\|createCipher\(`                    | `/owasp/cheatsheetseries` → "cryptographic failures encryption" |
| A03 | Injection                 | `eval\|\$\{.*\}\|concat.*SELECT`                    | `/owasp/cheatsheetseries` → "SQL injection prevention"          |
| A04 | Insecure Design           | Architecture review needed                          | `/owasp/cheatsheetseries` → "secure design principles"          |
| A05 | Security Misconfiguration | `DEBUG.*true\|default.*password`                    | `/helmetjs/helmet` → "security headers configuration"           |
| A06 | Vulnerable Components     | Check package.json/lock files                       | `/snyk/cli` → "vulnerability scanning dependency"               |
| A07 | Auth Failures             | `session.*cookie\|jwt.*none`                        | `/auth0/node-jsonwebtoken` → "JWT verification security"        |
| A08 | Data Integrity Failures   | `deserialize\|pickle\|unserialize`                  | `/owasp/cheatsheetseries` → "deserialization prevention"        |
| A09 | Logging Failures          | Missing audit logs                                  | `/owasp/cheatsheetseries` → "logging monitoring security"       |
| A10 | SSRF                      | `fetch\|axios\|request` with user input             | `/owasp/cheatsheetseries` → "SSRF prevention"                   |

## Vulnerability Detection Patterns

### SQL Injection Prevention

**Detection Pattern:**

```bash
# Find SQL concatenation vulnerabilities
Grep: \+\s*["'].*SELECT|INSERT|UPDATE|DELETE
Grep: \`SELECT.*\$\{
Grep: query\(.*\+.*\)
Grep: execute\(.*%s
```

**OWASP Remediation (from Context7):**

```java
// UNSAFE: String concatenation allows SQL injection
String query = "SELECT * FROM users WHERE name = " + customerName;

// SAFE: Parameterized query with PreparedStatement
String query = "SELECT * FROM users WHERE name = ?";
PreparedStatement pstmt = connection.prepareStatement(query);
pstmt.setString(1, customerName);
ResultSet results = pstmt.executeQuery();
```

```javascript
// UNSAFE: Template literal in query
const query = `SELECT * FROM users WHERE id = ${userId}`;

// SAFE: Parameterized query
const query = "SELECT * FROM users WHERE id = $1";
const result = await db.query(query, [userId]);
```

### XSS Prevention

**Detection Pattern:**

```bash
# Find XSS vulnerabilities
Grep: innerHTML\s*=
Grep: document\.write\(
Grep: dangerouslySetInnerHTML
Grep: \{\{.*\}\}.*\|safe  # Django/Jinja unsafe filter
```

**OWASP Remediation (from Context7):**

```javascript
// UNSAFE: innerHTML allows script execution
document.getElementById("output").innerHTML = userInput;

// SAFE: textContent automatically encodes
document.getElementById("output").textContent = userInput;

// SAFE: Use DOMPurify for HTML content
import DOMPurify from "dompurify";
element.innerHTML = DOMPurify.sanitize(userInput);
```

```php
<!-- UNSAFE: Direct variable insertion -->
<div><?php echo $userInput; ?></div>

<!-- SAFE: HTML entity encoding -->
<div><?php echo htmlspecialchars($userInput, ENT_QUOTES, 'UTF-8'); ?></div>
```

### JWT Security

**Detection Pattern:**

```bash
# Find JWT vulnerabilities
Grep: algorithm.*none
Grep: verify.*false
Grep: jwt\.decode\(  # decode without verify
Grep: expiresIn.*[0-9]+d  # Very long expiration
```

**Secure JWT Verification (from Context7):**

```javascript
const jwt = require("jsonwebtoken");

// UNSAFE: No algorithm restriction
const decoded = jwt.verify(token, secret);

// SAFE: Explicit algorithm restriction
const decoded = jwt.verify(token, publicKey, {
  algorithms: ["RS256"], // Only allow RS256
  audience: "my-api",
  issuer: "my-app",
  clockTolerance: 5, // 5 seconds tolerance
  maxAge: "1h", // Token must not be older than 1 hour
});

// SAFE: Multiple allowed algorithms (explicit list)
jwt.verify(token, key, {
  algorithms: ["RS256", "RS384", "RS512", "ES256"],
});
```

### Password Hashing

**Detection Pattern:**

```bash
# Find weak password handling
Grep: MD5\|SHA1\|SHA256.*password
Grep: createHash.*password
Grep: password.*=.*password  # Plaintext comparison
```

**Secure Password Hashing (from Context7):**

```javascript
import bcrypt from "bcryptjs";

// Hash password with appropriate rounds (10-12 recommended)
const hash = bcrypt.hashSync(password, 12);

// Verify password
const isValid = await bcrypt.compare(inputPassword, storedHash);

// Check if rehashing needed (upgrade security over time)
const currentRounds = bcrypt.getRounds(storedHash);
if (currentRounds < 12) {
  const newHash = await bcrypt.hash(password, 12);
  // Update database with newHash
}
```

### Security Headers (Helmet.js)

**Detection Pattern:**

```bash
# Check for missing security headers
Grep -v: helmet\(
Grep -v: Content-Security-Policy
Grep -v: X-Frame-Options
```

**Secure Configuration (from Context7):**

```javascript
import express from "express";
import helmet from "helmet";

const app = express();

// Apply all security headers
app.use(
  helmet({
    contentSecurityPolicy: {
      directives: {
        defaultSrc: ["'self'"],
        scriptSrc: ["'self'", "https://cdn.example.com"],
        styleSrc: ["'self'", "https://fonts.googleapis.com"],
        imgSrc: ["'self'", "data:", "https:"],
        connectSrc: ["'self'", "https://api.example.com"],
        fontSrc: ["'self'", "https://fonts.gstatic.com"],
        objectSrc: ["'none'"],
        frameSrc: ["'none'"],
      },
    },
    hsts: {
      maxAge: 31536000,
      includeSubDomains: true,
      preload: true,
    },
  }),
);
```

### Dependency Vulnerability Scanning

**Using Snyk CLI (from Context7):**

```bash
# Test current project for vulnerabilities
snyk test

# Test with severity filtering
snyk test --severity-threshold=high

# Test all projects in monorepo
snyk test --all-projects --detection-depth=3

# Output JSON for CI/CD integration
snyk test --json --json-file-output=results.json

# Scan source code (SAST)
snyk code test

# Scan and report to Snyk UI
snyk code test --report --project-name=my-app
```

**npm audit alternative:**

```bash
# Check for vulnerabilities
npm audit

# Fix automatically where possible
npm audit fix

# Generate detailed report
npm audit --json > audit-report.json
```

### Rate Limiting

**Detection Pattern:**

```bash
# Check for missing rate limiting
Grep -v: rateLimit\|rate-limit\|throttle
```

**Secure Configuration:**

```javascript
import rateLimit from "express-rate-limit";

// General API rate limiting
const apiLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // 100 requests per window
  standardHeaders: true,
  legacyHeaders: false,
  message: { error: "Too many requests, please try again later." },
});

// Strict limiting for auth endpoints
const authLimiter = rateLimit({
  windowMs: 60 * 60 * 1000, // 1 hour
  max: 5, // 5 attempts per hour
  skipSuccessfulRequests: true,
});

app.use("/api/", apiLimiter);
app.use("/api/auth/", authLimiter);
```

## Security Mindset

> "Think like an attacker. Defend like a guardian."

**Core Principles:**

- **Zero Trust** - Verify everything, trust nothing
- **Defense in Depth** - Multiple security layers
- **Least Privilege** - Minimum necessary access
- **Fail Secure** - Default to secure state on errors
- **Security by Design** - Build security in, don't bolt on

## CVSS Severity Classification

| Score    | Severity | Response Time | Example                             |
| -------- | -------- | ------------- | ----------------------------------- |
| 9.0-10.0 | Critical | Immediate     | Remote code execution, auth bypass  |
| 7.0-8.9  | High     | 24-48 hours   | SQL injection, privilege escalation |
| 4.0-6.9  | Medium   | 1-2 weeks     | XSS, information disclosure         |
| 0.1-3.9  | Low      | Next release  | Minor information leak              |

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

## Common Vulnerability Checklist

### Authentication & Session Management
- [ ] Passwords hashed with bcrypt/Argon2 (cost factor ≥10)
- [ ] JWT tokens have expiration and algorithm restriction
- [ ] Session tokens are cryptographically random
- [ ] Logout invalidates session server-side
- [ ] Password reset tokens expire quickly
- [ ] Multi-factor authentication for sensitive operations

### Input Validation
- [ ] All user input validated on server-side
- [ ] Parameterized queries for all database operations
- [ ] File uploads validated by type and size
- [ ] URL parameters sanitized
- [ ] JSON/XML parsing with entity expansion limits

### Output Encoding
- [ ] HTML output encoded to prevent XSS
- [ ] JSON responses have proper Content-Type
- [ ] Error messages don't expose sensitive info
- [ ] Stack traces disabled in production

### Access Control
- [ ] Authorization checked on every request
- [ ] Direct object references validated
- [ ] Admin functions protected
- [ ] API endpoints require authentication
- [ ] CORS configured restrictively

### Cryptography
- [ ] TLS 1.2+ enforced
- [ ] Strong cipher suites only
- [ ] Secrets stored in environment/vault
- [ ] No hardcoded credentials
- [ ] Cryptographic randomness from secure source

### Security Headers
- [ ] Content-Security-Policy configured
- [ ] X-Frame-Options set (clickjacking)
- [ ] X-Content-Type-Options: nosniff
- [ ] Strict-Transport-Security (HSTS)
- [ ] Referrer-Policy configured

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
