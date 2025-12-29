# OWASP Top 10 Security Vulnerabilities

## A01:2021 - Broken Access Control

### Description
Access control enforces policy so users cannot act outside their intended permissions.

### Common Vulnerabilities
- Bypassing access control checks by modifying URL/parameters
- Viewing/editing someone else's account by providing its ID (IDOR)
- Privilege escalation (acting as user without login, or as admin when logged in as user)
- Missing access control for POST, PUT, DELETE
- CORS misconfiguration allowing unauthorized API access

### Detection Patterns
```regex
# Missing authorization checks
router\.(get|post|put|delete)\s*\([^)]+\)\s*,\s*(req|request)\s*=>
# Direct object references without validation
params\.(id|userId|orderId)
req\.params\.\w+.*findById
```

### Remediation
- Deny by default (except public resources)
- Implement access control mechanisms once, reuse everywhere
- Disable web server directory listing
- Log access control failures, alert on repeated failures
- Rate limit API access

---

## A02:2021 - Cryptographic Failures

### Description
Failures related to cryptography which often lead to sensitive data exposure.

### Common Vulnerabilities
- Transmitting data in clear text (HTTP, SMTP, FTP)
- Using old or weak cryptographic algorithms (MD5, SHA1, DES)
- Using default or weak crypto keys
- Not enforcing encryption (missing TLS directives)
- Improper certificate validation

### Detection Patterns
```regex
# Weak hashing
md5\(|sha1\(|createHash\(['"]md5|createHash\(['"]sha1
# Hardcoded secrets
(password|secret|key|token)\s*[:=]\s*['"][^'"]{8,}['"]
# HTTP URLs for sensitive data
http:\/\/[^/]*\/(api|auth|login|payment)
```

### Remediation
- Classify data and apply controls per classification
- Don't store sensitive data unnecessarily
- Encrypt all sensitive data at rest
- Use strong, up-to-date algorithms (AES-256, bcrypt, Argon2)
- Enforce TLS with HSTS

---

## A03:2021 - Injection

### Description
User-supplied data is not validated, filtered, or sanitized by the application.

### Types
- SQL Injection
- NoSQL Injection
- OS Command Injection
- LDAP Injection
- XSS (Cross-Site Scripting)
- Template Injection

### Detection Patterns
```regex
# SQL Injection risk
(query|execute)\s*\(\s*['"`].*\+|f['"].*SELECT.*\{
# Command Injection risk
exec\(|system\(|child_process\.exec|subprocess\.call.*shell=True
# XSS risk
innerHTML\s*=|document\.write\(|dangerouslySetInnerHTML|v-html
```

### Remediation
- Use parameterized queries / prepared statements
- Use ORM/ODM frameworks properly
- Escape special characters for specific interpreters
- Use Content-Security-Policy headers
- Input validation with allowlists

---

## A04:2021 - Insecure Design

### Description
Risks related to design and architectural flaws.

### Common Issues
- Missing security controls in design
- Lack of business logic security
- No threat modeling performed
- Trust boundary violations

### Indicators
- No rate limiting on sensitive operations
- Missing multi-factor authentication for critical actions
- No fraud/abuse detection mechanisms
- Overly permissive default settings

### Remediation
- Establish secure development lifecycle
- Use threat modeling for critical flows
- Integrate security language in user stories
- Design for failure (fail securely)

---

## A05:2021 - Security Misconfiguration

### Description
Missing appropriate security hardening or improperly configured permissions.

### Common Issues
- Default credentials in use
- Unnecessary features enabled
- Verbose error messages exposing stack traces
- Security settings in frameworks not set
- Missing security headers

### Detection Patterns
```regex
# Debug mode in production
DEBUG\s*=\s*True|NODE_ENV\s*=\s*['"]development
# Default credentials
(admin|root|password|123456|default)
# Missing security headers check via HTTP response
```

### Remediation
- Automated hardening process
- Remove unused features and frameworks
- Review cloud storage permissions (S3 buckets, etc.)
- Send security directives (headers, CSP)
- Automated configuration verification

---

## A06:2021 - Vulnerable and Outdated Components

### Description
Using components with known vulnerabilities.

### Indicators
- Old package versions in package.json/requirements.txt
- Components without security patches
- Unsupported or deprecated libraries

### Detection
```bash
# npm audit
npm audit

# Python safety check
pip install safety
safety check

# General CVE scanning
trivy fs .
snyk test
```

### Remediation
- Remove unused dependencies
- Continuously inventory component versions
- Subscribe to security bulletins
- Only use components from official sources
- Automate dependency updates

---

## A07:2021 - Identification and Authentication Failures

### Description
Confirmation of user identity and session management weaknesses.

### Common Issues
- Permits brute force attacks
- Allows default/weak passwords
- Uses plain text or weakly hashed passwords
- Missing or ineffective MFA
- Session IDs in URL
- Session not invalidated after logout

### Detection Patterns
```regex
# Weak password validation
password.length\s*[<>]=?\s*[0-6]
# Missing rate limiting on auth endpoints
/login|/auth|/signin.*\n.*(?!.*rate)
```

### Remediation
- Implement MFA
- Enforce strong password policies
- Limit failed login attempts
- Use server-side session management
- Regenerate session ID after login

---

## A08:2021 - Software and Data Integrity Failures

### Description
Code and infrastructure that does not protect against integrity violations.

### Common Issues
- Insecure CI/CD pipelines
- Auto-update without verification
- Insecure deserialization
- Unsigned/unverified software updates

### Detection Patterns
```regex
# Insecure deserialization
pickle\.load|yaml\.load\(.*Loader|unserialize\(|JSON\.parse\(.*user
# Missing integrity checks on downloads
curl.*\|\s*bash|wget.*\|\s*sh
```

### Remediation
- Use digital signatures for verification
- Ensure CI/CD has proper access controls
- Use dependency verification (checksums)
- Review code and config changes

---

## A09:2021 - Security Logging and Monitoring Failures

### Description
Insufficient logging, detection, monitoring, and active response.

### Indicators
- Login/access control failures not logged
- Logs only stored locally
- No monitoring for suspicious activity
- No alerting thresholds

### What to Log
- Authentication events (success/failure)
- Access control failures
- Input validation failures
- API requests with sensitive parameters
- Administrative actions

### Remediation
- Log security-relevant events
- Ensure logs have sufficient context
- Centralize log management
- Establish alerting and response procedures

---

## A10:2021 - Server-Side Request Forgery (SSRF)

### Description
Web application fetches remote resource without validating user-supplied URL.

### Common Vulnerabilities
- Fetching URLs from user input
- Accessing internal services via URL manipulation
- Cloud metadata endpoint access

### Detection Patterns
```regex
# URL from user input
fetch\(.*req\.(body|query|params)|axios\(.*user|requests\.get\(.*input
# Internal IP access risk
(127\.0\.0\.1|localhost|169\.254\.|10\.|192\.168\.|172\.(1[6-9]|2[0-9]|3[01]))
```

### Remediation
- Validate and sanitize all URLs
- Use allowlist of permitted hosts/IP ranges
- Block requests to internal IP ranges
- Disable HTTP redirects
- Don't send raw responses to clients
