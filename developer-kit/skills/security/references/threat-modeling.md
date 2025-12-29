# Threat Modeling Methodology

## STRIDE Framework

### S - Spoofing
**Question**: Can an attacker pretend to be someone else?

**Examples**:
- Fake login pages
- Session hijacking
- Token theft
- IP spoofing

**Mitigations**:
- Strong authentication (MFA)
- Secure session management
- Certificate validation
- Token binding

### T - Tampering
**Question**: Can an attacker modify data?

**Examples**:
- Man-in-the-middle attacks
- SQL injection
- Parameter manipulation
- File modification

**Mitigations**:
- Input validation
- Integrity checks (HMAC, signatures)
- TLS/HTTPS
- Audit logging

### R - Repudiation
**Question**: Can an attacker deny actions?

**Examples**:
- Missing audit logs
- Unsigned transactions
- Anonymous actions

**Mitigations**:
- Comprehensive logging
- Digital signatures
- Timestamps
- Non-repudiation controls

### I - Information Disclosure
**Question**: Can an attacker access unauthorized data?

**Examples**:
- Verbose error messages
- Directory listing
- Metadata exposure
- Cache leakage

**Mitigations**:
- Encryption at rest and in transit
- Access controls
- Data classification
- Secure error handling

### D - Denial of Service
**Question**: Can an attacker disrupt the service?

**Examples**:
- Resource exhaustion
- Algorithmic complexity attacks
- Distributed DoS
- Application crashes

**Mitigations**:
- Rate limiting
- Input validation
- Resource quotas
- CDN/WAF

### E - Elevation of Privilege
**Question**: Can an attacker gain higher access?

**Examples**:
- SQL injection to admin
- Insecure direct object references
- Missing function-level access control
- JWT manipulation

**Mitigations**:
- Least privilege principle
- Role-based access control
- Input validation
- Proper authorization checks

## Threat Modeling Process

### Step 1: Identify Assets
- What are we protecting?
- What has value to attackers?

```markdown
| Asset | Type | Sensitivity |
|-------|------|-------------|
| User credentials | Data | Critical |
| Payment data | Data | Critical |
| Session tokens | Data | High |
| User PII | Data | High |
| API keys | Secret | Critical |
```

### Step 2: Create Architecture Diagram
```
[Browser] → [Load Balancer] → [Web Server] → [App Server] → [Database]
                                    ↓
                              [Auth Service] → [Identity Provider]
```

### Step 3: Identify Entry Points
- Web interface
- API endpoints
- File uploads
- WebSocket connections
- Third-party integrations

### Step 4: Apply STRIDE to Each Component
```markdown
## Component: Authentication API

### Spoofing
- Risk: Attacker uses stolen credentials
- Mitigation: MFA, device fingerprinting

### Tampering
- Risk: Token manipulation
- Mitigation: Signed JWTs, token validation

### Repudiation
- Risk: Denied login attempts
- Mitigation: Audit logging all auth events
...
```

### Step 5: Risk Assessment

| Threat | Likelihood | Impact | Risk | Priority |
|--------|------------|--------|------|----------|
| SQL Injection | High | Critical | Critical | P0 |
| Session Hijacking | Medium | High | High | P1 |
| XSS | High | Medium | High | P1 |
| DoS | Low | High | Medium | P2 |

### Step 6: Define Mitigations
For each identified risk, define:
1. Control type (Preventive, Detective, Corrective)
2. Implementation approach
3. Verification method
4. Owner and deadline

## Data Flow Diagram (DFD) Elements

```
[External Entity]  →  Process  →  [Data Store]
                         ↓
                   Trust Boundary
                         ↓
                    Data Flow
```

### Trust Boundaries to Consider
- Network perimeter
- Between microservices
- Client/server boundary
- Between security zones
- Third-party integrations

## Attack Trees

### Goal: Access User Data
```
Access User Data
├── Direct Database Access
│   ├── SQL Injection
│   ├── Compromised credentials
│   └── Insider threat
├── Application Bypass
│   ├── IDOR vulnerability
│   ├── Broken access control
│   └── Session hijacking
└── Infrastructure Attack
    ├── Server compromise
    ├── Network interception
    └── Cloud misconfiguration
```

## Security Requirements Template

```markdown
## Feature: User Authentication

### Security Requirements
1. Passwords must be hashed with bcrypt (cost factor >= 12)
2. Failed login attempts must be rate-limited (5/minute)
3. Sessions must expire after 30 minutes of inactivity
4. MFA must be available for all users

### Threat Mitigations
- [STRIDE-S] MFA prevents credential stuffing
- [STRIDE-T] Signed tokens prevent tampering
- [STRIDE-R] All auth events logged with IP and timestamp

### Test Cases
- [ ] Verify bcrypt with correct cost factor
- [ ] Test rate limiting after 5 failed attempts
- [ ] Verify session expiration
- [ ] Test MFA enrollment and verification
```
