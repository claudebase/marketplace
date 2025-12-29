# API Versioning Reference

## Versioning Strategies

### URL Path Versioning

```javascript
// Express.js example
const express = require('express');
const app = express();

// Version 1
const v1Router = express.Router();
v1Router.get('/users/:id', (req, res) => {
  res.json({
    id: req.params.id,
    name: 'John Doe',
    email: 'john@example.com'
  });
});

// Version 2 - different response structure
const v2Router = express.Router();
v2Router.get('/users/:id', (req, res) => {
  res.json({
    data: {
      id: req.params.id,
      attributes: {
        name: 'John Doe',
        email: 'john@example.com'
      }
    },
    meta: { version: 'v2' }
  });
});

app.use('/api/v1', v1Router);
app.use('/api/v2', v2Router);
```

### Header Versioning

```javascript
// Middleware for header-based versioning
const apiVersion = (req, res, next) => {
  const version = req.headers['api-version'] ||
                  req.headers['accept']?.match(/version=(\d+)/)?.[1] ||
                  '1';
  req.apiVersion = parseInt(version);
  next();
};

app.use(apiVersion);

app.get('/api/users/:id', (req, res) => {
  const user = getUserById(req.params.id);

  if (req.apiVersion >= 2) {
    return res.json({
      data: { id: user.id, attributes: user },
      meta: { version: req.apiVersion }
    });
  }

  res.json(user);  // v1 format
});
```

## Deprecation Workflow

### Sunset Headers

```javascript
// Middleware to add deprecation headers
const deprecationMiddleware = (deprecationDate, sunsetDate) => {
  return (req, res, next) => {
    res.set('Deprecation', deprecationDate);  // RFC 8594
    res.set('Sunset', sunsetDate);
    res.set('Link', '</api/v2/users>; rel="successor-version"');
    next();
  };
};

// Apply to deprecated endpoints
v1Router.use('/users', deprecationMiddleware(
  'Sat, 01 Jan 2025 00:00:00 GMT',
  'Sat, 01 Jul 2025 00:00:00 GMT'
));
```

### Deprecation Response Wrapper

```javascript
const wrapDeprecated = (handler, options) => {
  return async (req, res, next) => {
    const result = await handler(req, res, next);

    // Log deprecated endpoint usage
    logger.warn('Deprecated API called', {
      endpoint: req.path,
      version: options.version,
      clientId: req.headers['x-client-id'],
      sunsetDate: options.sunsetDate
    });

    // Add deprecation notice to response
    if (typeof result === 'object') {
      result._deprecated = {
        message: options.message,
        successor: options.successor,
        sunsetDate: options.sunsetDate
      };
    }

    return result;
  };
};
```

## Backward Compatibility Patterns

### Response Transformation

```javascript
// Transform new internal format to old API format
const transformToV1 = (user) => ({
  id: user.id,
  name: user.fullName,  // v2 uses fullName, v1 expects name
  email: user.email,
  // v1 doesn't include these fields
});

const transformToV2 = (user) => ({
  data: {
    id: user.id,
    type: 'user',
    attributes: {
      fullName: user.fullName,
      email: user.email,
      createdAt: user.createdAt
    }
  }
});
```

### Request Normalization

```javascript
// Normalize different request formats to internal format
const normalizeUserRequest = (body, version) => {
  if (version === 1) {
    // v1: { name: 'John', email: 'john@example.com' }
    return {
      fullName: body.name,
      email: body.email
    };
  }

  // v2: { data: { attributes: { fullName: 'John', email: '...' } } }
  return body.data?.attributes || body;
};
```

### Feature Detection

```javascript
// Client-side feature detection
class ApiClient {
  constructor(baseUrl) {
    this.baseUrl = baseUrl;
    this.version = null;
  }

  async detectVersion() {
    const response = await fetch(`${this.baseUrl}/api`);
    const capabilities = await response.json();

    this.version = capabilities.latestVersion;
    this.features = capabilities.features;

    return this.version;
  }

  async getUsers() {
    if (this.features.includes('json-api')) {
      // Use v2 format
      const response = await this.request('/api/v2/users');
      return response.data;
    }
    // Fall back to v1
    return this.request('/api/v1/users');
  }
}
```

## GraphQL Versioning

```graphql
# Instead of versioning, use @deprecated directive
type User {
  id: ID!
  name: String @deprecated(reason: "Use fullName instead")
  fullName: String!
  email: String!
}

# Add new fields alongside old ones
type Query {
  # Old endpoint
  user(id: ID!): User @deprecated(reason: "Use userById")

  # New endpoint with better naming
  userById(id: ID!): User
}
```

## Migration Communication

### Changelog Template

```markdown
# API Changelog

## v2.0.0 (2025-01-15)

### Breaking Changes
- Response format changed to JSON:API specification
- `GET /users/:id` now returns `{ data: { ... } }` wrapper

### Migration Guide
1. Update response parsing to handle new structure
2. Change `response.name` to `response.data.attributes.fullName`

### Deprecations
- `GET /api/v1/*` endpoints deprecated, sunset: 2025-07-01

## v1.5.0 (2024-12-01)

### New Features
- Added `fullName` field to User (use instead of `name`)
```

### Client Notification

```javascript
// Notify clients of upcoming deprecation
app.use((req, res, next) => {
  const clientVersion = req.headers['x-client-version'];

  if (clientVersion && semver.lt(clientVersion, '2.0.0')) {
    res.set('X-Upgrade-Notice', 'Client version outdated. Please upgrade to 2.x');
  }

  next();
});
```
