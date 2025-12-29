# Security Common Reference

Shared security patterns and methodologies used by both the `security` skill (read-only audits) and `security-expert` agent (full implementation capabilities).

## Security Mindset

> "Think like an attacker. Defend like a guardian."

### Core Principles

| Principle | Description |
|-----------|-------------|
| **Zero Trust** | Verify everything, trust nothing. Assume breach. |
| **Defense in Depth** | Multiple layers of security controls |
| **Least Privilege** | Minimum necessary permissions |
| **Fail Secure** | Errors should deny, not allow |
| **Security by Design** | Build security in, don't bolt on |

## OWASP Top 10 (2021)

| ID | Vulnerability | Prevention Strategies |
|----|---------------|----------------------|
| A01 | Broken Access Control | RBAC, validate on server, deny by default |
| A02 | Cryptographic Failures | TLS everywhere, strong algorithms, proper key management |
| A03 | Injection | Parameterized queries, input validation, output encoding |
| A04 | Insecure Design | Threat modeling, secure design patterns, defense in depth |
| A05 | Security Misconfiguration | Security headers, least privilege, remove defaults |
| A06 | Vulnerable Components | Dependency scanning, regular updates, SCA tools |
| A07 | Authentication Failures | MFA, secure sessions, password policies, account lockout |
| A08 | Software Integrity Failures | Code signing, integrity checks, secure CI/CD |
| A09 | Logging & Monitoring | Audit logs, alerting, incident response |
| A10 | SSRF | Allowlist URLs, disable redirects, network segmentation |

## Authentication Patterns

### OAuth 2.0 / OIDC
- Social login integration
- SSO for enterprise
- Token refresh strategies
- Scope management

### JWT Best Practices
- Short expiration times
- Secure signing algorithms (RS256, ES256)
- Validate all claims
- Store securely (httpOnly cookies)

### Session Management
- Secure cookie flags (httpOnly, secure, sameSite)
- Session regeneration after login
- Absolute and idle timeouts
- CSRF protection

### API Authentication
- API keys with rate limiting
- Scoped access tokens
- Key rotation policies
- Request signing

### Multi-Factor Authentication
- TOTP (Google Authenticator)
- WebAuthn/FIDO2
- SMS (less secure, fallback only)
- Backup codes

## Secure Coding Patterns

### Input Validation
```javascript
// Schema validation (Joi, Zod, Yup)
const schema = Joi.object({
  email: Joi.string().email().required(),
  age: Joi.number().integer().min(0).max(150)
});

// Type checking
if (typeof input !== 'string') {
  throw new Error('Invalid input type');
}
```

### Parameterized Queries
```javascript
// Node.js with pg
const result = await db.query(
  'SELECT * FROM users WHERE id = $1 AND status = $2',
  [userId, 'active']
);

// Python with psycopg2
cursor.execute(
  "SELECT * FROM users WHERE id = %s",
  (user_id,)
)
```

### Output Encoding
```javascript
// HTML sanitization
const safeHtml = DOMPurify.sanitize(userInput);

// React auto-escapes by default
<div>{userInput}</div>  // Safe

// Dangerous - avoid
<div dangerouslySetInnerHTML={{__html: userInput}} />
```

### Secrets Management
```javascript
// Environment variables
const apiKey = process.env.API_SECRET_KEY;

// Never hardcode
const apiKey = 'sk-1234...';  // WRONG

// Validate presence
if (!process.env.DATABASE_URL) {
  throw new Error('DATABASE_URL required');
}
```

## Security Headers

### Essential Headers
```
Strict-Transport-Security: max-age=31536000; includeSubDomains
X-Content-Type-Options: nosniff
X-Frame-Options: DENY
X-XSS-Protection: 1; mode=block
Referrer-Policy: strict-origin-when-cross-origin
```

### Content Security Policy
```
Content-Security-Policy:
  default-src 'self';
  script-src 'self' 'unsafe-inline';
  style-src 'self' 'unsafe-inline';
  img-src 'self' data: https:;
  connect-src 'self' https://api.example.com;
```

### CORS Configuration
```javascript
// Restrictive CORS
app.use(cors({
  origin: ['https://app.example.com'],
  methods: ['GET', 'POST'],
  credentials: true
}));
```

## Vulnerability Severity Ratings

| Severity | CVSS Score | Response Time | Examples |
|----------|------------|---------------|----------|
| Critical | 9.0-10.0 | Immediate | RCE, SQL injection with admin access |
| High | 7.0-8.9 | 24-48 hours | Auth bypass, stored XSS |
| Medium | 4.0-6.9 | 1-2 weeks | Reflected XSS, information disclosure |
| Low | 0.1-3.9 | Next release | Minor info leak, verbose errors |

## Related Resources

- [OWASP Top 10](https://owasp.org/Top10/)
- [OWASP Cheat Sheet Series](https://cheatsheetseries.owasp.org/)
- [CWE Top 25](https://cwe.mitre.org/top25/)
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)
