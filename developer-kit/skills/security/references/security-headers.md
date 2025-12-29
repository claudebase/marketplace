# Security Headers Reference

## Essential Security Headers

### Content-Security-Policy (CSP)

Prevents XSS and data injection attacks by controlling resource loading.

```http
Content-Security-Policy: default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'; img-src 'self' data: https:; font-src 'self'; connect-src 'self' https://api.example.com; frame-ancestors 'none'; base-uri 'self'; form-action 'self'
```

**Directive Reference:**

| Directive | Purpose | Example |
|-----------|---------|---------|
| `default-src` | Fallback for other directives | `'self'` |
| `script-src` | JavaScript sources | `'self' 'nonce-abc123'` |
| `style-src` | CSS sources | `'self' 'unsafe-inline'` |
| `img-src` | Image sources | `'self' data: https:` |
| `connect-src` | XHR, WebSocket, fetch | `'self' https://api.example.com` |
| `font-src` | Font sources | `'self' https://fonts.gstatic.com` |
| `frame-src` | iframe sources | `'none'` |
| `frame-ancestors` | Who can embed this page | `'none'` |
| `base-uri` | Base URL restrictions | `'self'` |
| `form-action` | Form submission targets | `'self'` |

**CSP with Nonces (Recommended):**

```javascript
// Express middleware
const crypto = require('crypto');

app.use((req, res, next) => {
  res.locals.nonce = crypto.randomBytes(16).toString('base64');
  res.setHeader(
    'Content-Security-Policy',
    `script-src 'self' 'nonce-${res.locals.nonce}'`
  );
  next();
});

// In template
<script nonce="<%= nonce %>">
  // Inline script allowed
</script>
```

### Strict-Transport-Security (HSTS)

Forces HTTPS connections.

```http
Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
```

| Parameter | Purpose |
|-----------|---------|
| `max-age` | Duration in seconds (1 year = 31536000) |
| `includeSubDomains` | Apply to all subdomains |
| `preload` | Allow browser preload list inclusion |

### X-Content-Type-Options

Prevents MIME type sniffing.

```http
X-Content-Type-Options: nosniff
```

### X-Frame-Options

Controls iframe embedding (legacy, use CSP frame-ancestors).

```http
X-Frame-Options: DENY
```

| Value | Effect |
|-------|--------|
| `DENY` | Never allow framing |
| `SAMEORIGIN` | Allow from same origin |
| `ALLOW-FROM uri` | Allow from specific URI (deprecated) |

### X-XSS-Protection

Legacy XSS filter (modern browsers ignore, but set for older browsers).

```http
X-XSS-Protection: 1; mode=block
```

### Referrer-Policy

Controls referrer information sent with requests.

```http
Referrer-Policy: strict-origin-when-cross-origin
```

| Value | Description |
|-------|-------------|
| `no-referrer` | Never send referrer |
| `origin` | Send only origin |
| `strict-origin` | Origin on HTTPS, nothing on HTTP |
| `strict-origin-when-cross-origin` | Full URL same-origin, origin cross-origin |
| `same-origin` | Full URL same-origin only |

### Permissions-Policy

Controls browser features.

```http
Permissions-Policy: geolocation=(), camera=(), microphone=(), payment=()
```

## Implementation Examples

### Express.js with Helmet

```javascript
const helmet = require('helmet');

app.use(helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      scriptSrc: ["'self'", (req, res) => `'nonce-${res.locals.nonce}'`],
      styleSrc: ["'self'", "'unsafe-inline'"],
      imgSrc: ["'self'", "data:", "https:"],
      connectSrc: ["'self'", "https://api.example.com"],
      fontSrc: ["'self'", "https://fonts.gstatic.com"],
      frameSrc: ["'none'"],
      frameAncestors: ["'none'"],
      baseUri: ["'self'"],
      formAction: ["'self'"]
    }
  },
  hsts: {
    maxAge: 31536000,
    includeSubDomains: true,
    preload: true
  },
  referrerPolicy: {
    policy: 'strict-origin-when-cross-origin'
  },
  permissionsPolicy: {
    features: {
      geolocation: [],
      camera: [],
      microphone: []
    }
  }
}));
```

### Nginx Configuration

```nginx
# Security headers
add_header Content-Security-Policy "default-src 'self'; script-src 'self'; style-src 'self' 'unsafe-inline'; img-src 'self' data: https:; font-src 'self'; connect-src 'self'; frame-ancestors 'none'; base-uri 'self'; form-action 'self'" always;
add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload" always;
add_header X-Content-Type-Options "nosniff" always;
add_header X-Frame-Options "DENY" always;
add_header X-XSS-Protection "1; mode=block" always;
add_header Referrer-Policy "strict-origin-when-cross-origin" always;
add_header Permissions-Policy "geolocation=(), camera=(), microphone=()" always;

# Remove server version
server_tokens off;
```

### Apache Configuration

```apache
# .htaccess or httpd.conf
<IfModule mod_headers.c>
    Header always set Content-Security-Policy "default-src 'self'; script-src 'self'; style-src 'self' 'unsafe-inline'"
    Header always set Strict-Transport-Security "max-age=31536000; includeSubDomains; preload"
    Header always set X-Content-Type-Options "nosniff"
    Header always set X-Frame-Options "DENY"
    Header always set X-XSS-Protection "1; mode=block"
    Header always set Referrer-Policy "strict-origin-when-cross-origin"
    Header always set Permissions-Policy "geolocation=(), camera=(), microphone=()"
</IfModule>

# Hide server version
ServerTokens Prod
ServerSignature Off
```

### FastAPI/Python

```python
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from starlette.middleware.base import BaseHTTPMiddleware

class SecurityHeadersMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request, call_next):
        response = await call_next(request)
        response.headers["Content-Security-Policy"] = "default-src 'self'"
        response.headers["Strict-Transport-Security"] = "max-age=31536000; includeSubDomains"
        response.headers["X-Content-Type-Options"] = "nosniff"
        response.headers["X-Frame-Options"] = "DENY"
        response.headers["Referrer-Policy"] = "strict-origin-when-cross-origin"
        return response

app = FastAPI()
app.add_middleware(SecurityHeadersMiddleware)
```

## CORS Configuration

### Express.js

```javascript
const cors = require('cors');

app.use(cors({
  origin: ['https://example.com', 'https://app.example.com'],
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization'],
  credentials: true,
  maxAge: 86400 // 24 hours
}));
```

### Nginx

```nginx
# CORS headers
add_header 'Access-Control-Allow-Origin' 'https://example.com' always;
add_header 'Access-Control-Allow-Methods' 'GET, POST, PUT, DELETE, OPTIONS' always;
add_header 'Access-Control-Allow-Headers' 'Content-Type, Authorization' always;
add_header 'Access-Control-Allow-Credentials' 'true' always;
add_header 'Access-Control-Max-Age' 86400 always;

# Handle preflight
if ($request_method = 'OPTIONS') {
    return 204;
}
```

## Cookie Security

```javascript
// Express session with secure cookies
app.use(session({
  secret: process.env.SESSION_SECRET,
  cookie: {
    secure: true,           // HTTPS only
    httpOnly: true,         // Not accessible via JavaScript
    sameSite: 'strict',     // CSRF protection
    maxAge: 3600000,        // 1 hour
    domain: '.example.com'  // Subdomain scope
  },
  resave: false,
  saveUninitialized: false
}));

// Set-Cookie header
Set-Cookie: session=abc123; Secure; HttpOnly; SameSite=Strict; Path=/; Max-Age=3600
```

## Testing Security Headers

### Online Tools
- securityheaders.com
- observatory.mozilla.org
- hstspreload.org

### curl
```bash
curl -I https://example.com | grep -i "security\|content-security\|strict-transport\|x-frame\|x-content"
```

## Security Header Checklist

| Header | Priority | Status |
|--------|----------|--------|
| Strict-Transport-Security | Critical | [ ] |
| Content-Security-Policy | Critical | [ ] |
| X-Content-Type-Options | High | [ ] |
| X-Frame-Options | High | [ ] |
| Referrer-Policy | Medium | [ ] |
| Permissions-Policy | Medium | [ ] |
| CORS (if needed) | High | [ ] |
| Secure Cookies | Critical | [ ] |
