# Security Expert - Implementation Patterns

## SQL Injection Fix

```yaml
Phase 1 - Assess:
  1. Grep for string concatenation in queries
  2. Map data flow from input to database
  3. Identify all affected queries

Phase 2 - Implement:
  # Before (VULNERABLE)
  const query = `SELECT * FROM users WHERE id = ${userId}`;

  # After (SECURE)
  const query = 'SELECT * FROM users WHERE id = $1';
  const result = await db.query(query, [userId]);

Phase 3 - Verify:
  1. Grep for remaining string concatenation
  2. Test with injection payloads
  3. Verify error messages don't leak info
```

## JWT Authentication

```typescript
import jwt from "jsonwebtoken";

// Token Generation
const generateTokens = (userId: string) => {
  const accessToken = jwt.sign({ sub: userId, type: "access" }, privateKey, {
    algorithm: "RS256",
    expiresIn: "15m",
    issuer: "my-app",
    audience: "my-api",
  });

  const refreshToken = jwt.sign(
    { sub: userId, type: "refresh" },
    refreshSecret,
    {
      algorithm: "RS256",
      expiresIn: "7d",
    },
  );

  return { accessToken, refreshToken };
};

// Token Verification - CRITICAL: Restrict algorithms
const verifyToken = (token: string) => {
  return jwt.verify(token, publicKey, {
    algorithms: ["RS256"], // Prevent algorithm confusion attack
    audience: "my-api",
    issuer: "my-app",
    clockTolerance: 5,
  });
};

// Authentication Middleware
const authMiddleware = async (req, res, next) => {
  const authHeader = req.headers.authorization;
  if (!authHeader?.startsWith("Bearer ")) {
    return res.status(401).json({ error: "Missing token" });
  }

  try {
    const token = authHeader.slice(7);
    const payload = verifyToken(token);
    req.user = payload;
    next();
  } catch (err) {
    return res.status(401).json({ error: "Invalid token" });
  }
};
```

## Security Headers (Express)

```javascript
import helmet from "helmet";

app.use(
  helmet({
    contentSecurityPolicy: {
      directives: {
        defaultSrc: ["'self'"],
        scriptSrc: ["'self'", "https://cdn.example.com"],
        styleSrc: ["'self'", "'unsafe-inline'", "https://fonts.googleapis.com"],
        imgSrc: ["'self'", "data:", "https:"],
        connectSrc: ["'self'", "https://api.example.com"],
        fontSrc: ["'self'", "https://fonts.gstatic.com"],
        objectSrc: ["'none'"],
        frameSrc: ["'none'"],
        upgradeInsecureRequests: [],
      },
    },
    hsts: {
      maxAge: 31536000,
      includeSubDomains: true,
      preload: true,
    },
    referrerPolicy: { policy: "strict-origin-when-cross-origin" },
    crossOriginEmbedderPolicy: true,
    crossOriginOpenerPolicy: { policy: "same-origin" },
    crossOriginResourcePolicy: { policy: "same-origin" },
  }),
);
```

## Security Headers (Next.js)

```javascript
// next.config.js
const securityHeaders = [
  {
    key: "Content-Security-Policy",
    value:
      "default-src 'self'; script-src 'self' 'unsafe-eval' 'unsafe-inline';",
  },
  { key: "X-Frame-Options", value: "DENY" },
  { key: "X-Content-Type-Options", value: "nosniff" },
  {
    key: "Strict-Transport-Security",
    value: "max-age=31536000; includeSubDomains; preload",
  },
];

module.exports = {
  async headers() {
    return [{ source: "/:path*", headers: securityHeaders }];
  },
};
```

## Rate Limiting

```javascript
import rateLimit from "express-rate-limit";
import RedisStore from "rate-limit-redis";

// General API rate limit
const apiLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100,
  standardHeaders: true,
  legacyHeaders: false,
  message: { error: "Too many requests, please try again later" },
  store: new RedisStore({
    sendCommand: (...args) => redisClient.sendCommand(args),
  }),
});

// Strict auth rate limit (prevent brute force)
const authLimiter = rateLimit({
  windowMs: 60 * 60 * 1000, // 1 hour
  max: 5,
  skipSuccessfulRequests: true,
  message: { error: "Too many login attempts, account locked for 1 hour" },
});

// Password reset limiter
const passwordResetLimiter = rateLimit({
  windowMs: 24 * 60 * 60 * 1000, // 24 hours
  max: 3,
  message: { error: "Too many password reset attempts" },
});

// Apply limiters
app.use("/api/", apiLimiter);
app.use("/api/auth/login", authLimiter);
app.use("/api/auth/reset-password", passwordResetLimiter);
```

## Password Hashing

```javascript
import bcrypt from "bcryptjs";

const SALT_ROUNDS = 12; // NIST recommends 10+

const hashPassword = async (password: string): Promise<string> => {
  if (!isStrongPassword(password)) {
    throw new Error("Password does not meet requirements");
  }
  return bcrypt.hash(password, SALT_ROUNDS);
};

const verifyPassword = async (
  inputPassword: string,
  storedHash: string,
): Promise<boolean> => {
  return bcrypt.compare(inputPassword, storedHash);
};

const needsRehash = (hash: string): boolean => {
  return bcrypt.getRounds(hash) < SALT_ROUNDS;
};

const isStrongPassword = (password: string): boolean => {
  const minLength = 12;
  const hasUppercase = /[A-Z]/.test(password);
  const hasLowercase = /[a-z]/.test(password);
  const hasNumber = /[0-9]/.test(password);
  const hasSpecial = /[!@#$%^&*(),.?":{}|<>]/.test(password);

  return (
    password.length >= minLength &&
    hasUppercase &&
    hasLowercase &&
    hasNumber &&
    hasSpecial
  );
};
```

## XSS Prevention

```javascript
// DOM manipulation - use textContent instead of innerHTML
// Before (VULNERABLE)
element.innerHTML = userInput;

// After (SECURE)
element.textContent = userInput;

// If HTML is required, use DOMPurify
import DOMPurify from "dompurify";
element.innerHTML = DOMPurify.sanitize(userInput, {
  ALLOWED_TAGS: ["b", "i", "em", "strong", "a"],
  ALLOWED_ATTR: ["href"],
});

// React - avoid dangerouslySetInnerHTML
// Before (VULNERABLE)
<div dangerouslySetInnerHTML={{ __html: userInput }} />;

// After (SECURE)
<div>{userInput}</div>; // React auto-escapes

// Server-side output encoding
import { encode } from "html-entities";
const safeOutput = encode(userInput);
```

## RBAC Authorization

```typescript
type Permission = string;
type Role = "admin" | "manager" | "user" | "guest";

const rolePermissions: Record<Role, Permission[]> = {
  admin: ["*"],
  manager: ["users:read", "users:write", "reports:read", "reports:write"],
  user: ["profile:read", "profile:write"],
  guest: ["public:read"],
};

const hasPermission = (
  userRole: Role,
  requiredPermission: Permission,
): boolean => {
  const permissions = rolePermissions[userRole];

  if (permissions.includes("*")) return true;
  if (permissions.includes(requiredPermission)) return true;

  const [resource] = requiredPermission.split(":");
  return permissions.includes(`${resource}:*`);
};

const requirePermission = (permission: Permission) => {
  return (req: Request, res: Response, next: NextFunction) => {
    if (!req.user) {
      return res.status(401).json({ error: "Authentication required" });
    }

    if (!hasPermission(req.user.role, permission)) {
      return res.status(403).json({ error: "Permission denied" });
    }

    next();
  };
};

// Usage
app.get("/api/users", requirePermission("users:read"), listUsers);
app.post("/api/users", requirePermission("users:write"), createUser);
```

## OWASP Top 10 Fixes

### A01 - Broken Access Control

```javascript
// Check ownership before access
const checkOwnership = async (req, res, next) => {
  const resource = await db.resources.findById(req.params.id);

  if (!resource) {
    return res.status(404).json({ error: "Not found" });
  }

  if (resource.ownerId !== req.user.id && req.user.role !== "admin") {
    return res.status(403).json({ error: "Access denied" });
  }

  req.resource = resource;
  next();
};

app.get("/api/documents/:id", authenticate, checkOwnership, getDocument);
```

### A02 - Cryptographic Failures

```javascript
import crypto from "crypto";

// NEVER use MD5/SHA1 for passwords or sensitive data
// Use SHA-256 for data integrity
const hash = crypto.createHash("sha256").update(data).digest("hex");

// For encryption - use AES-256-GCM
const encrypt = (plaintext: string, key: Buffer): string => {
  const iv = crypto.randomBytes(16);
  const cipher = crypto.createCipheriv("aes-256-gcm", key, iv);
  const encrypted = Buffer.concat([
    cipher.update(plaintext, "utf8"),
    cipher.final(),
  ]);
  const authTag = cipher.getAuthTag();
  return Buffer.concat([iv, authTag, encrypted]).toString("base64");
};
```

### A05 - Security Misconfiguration

```javascript
// Environment-based configuration
const config = {
  debug: process.env.NODE_ENV !== "production",
  errorDetails: process.env.NODE_ENV !== "production",
};

// Error handler that doesn't leak info
app.use((err, req, res, next) => {
  console.error(err); // Log full error server-side

  res.status(err.status || 500).json({
    error: config.errorDetails ? err.message : "Internal server error",
    ...(config.debug && { stack: err.stack }),
  });
});
```

### A07 - Authentication Failures

```javascript
// Session regeneration on login
app.post("/login", async (req, res) => {
  const user = await authenticateUser(req.body);

  if (!user) {
    // Generic message to prevent user enumeration
    return res.status(401).json({ error: "Invalid credentials" });
  }

  // Regenerate session to prevent fixation
  req.session.regenerate((err) => {
    if (err) return res.status(500).json({ error: "Login failed" });

    req.session.userId = user.id;
    req.session.loginTime = Date.now();
    res.json({ success: true });
  });
});

// Account lockout
const MAX_ATTEMPTS = 5;
const LOCKOUT_DURATION = 60 * 60 * 1000; // 1 hour

const checkLockout = async (email: string): Promise<boolean> => {
  const attempts = await getLoginAttempts(email);
  return (
    attempts.count >= MAX_ATTEMPTS &&
    Date.now() - attempts.lastAttempt < LOCKOUT_DURATION
  );
};
```

## Security Checklist

### Before Implementation

- [ ] Understand the vulnerability/requirement
- [ ] Fetch OWASP guidance via Context7
- [ ] Research CVEs if applicable (Tavily)
- [ ] Study similar implementations (GitHub MCP)
- [ ] Plan defense in depth strategy

### During Implementation

- [ ] Use established security libraries (don't roll your own crypto)
- [ ] Implement input validation at boundaries
- [ ] Use parameterized queries for all DB operations
- [ ] Apply output encoding appropriate to context
- [ ] Add proper error handling (fail secure)
- [ ] Log security events (without sensitive data)

### After Implementation

- [ ] Test with malicious inputs
- [ ] Verify error messages don't leak info
- [ ] Check logs don't contain sensitive data
- [ ] Grep for remaining vulnerabilities
- [ ] Run security linters
- [ ] Test edge cases and bypass attempts
