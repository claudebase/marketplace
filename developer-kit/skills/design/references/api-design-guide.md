# API Design Best Practices

## RESTful Design Principles

### Resource Naming
```
# Good
GET /users
GET /users/{id}
GET /users/{id}/orders
POST /users
PUT /users/{id}
DELETE /users/{id}

# Bad
GET /getUsers
GET /user/{id}
POST /createUser
GET /users/{id}/getOrders
```

### HTTP Methods
| Method | Purpose | Idempotent | Safe |
|--------|---------|------------|------|
| GET | Retrieve | Yes | Yes |
| POST | Create | No | No |
| PUT | Replace | Yes | No |
| PATCH | Partial update | No | No |
| DELETE | Remove | Yes | No |

### Status Codes
```
2xx - Success
  200 OK - General success
  201 Created - Resource created
  204 No Content - Success, no body

4xx - Client Error
  400 Bad Request - Invalid input
  401 Unauthorized - Auth required
  403 Forbidden - Not permitted
  404 Not Found - Resource missing
  409 Conflict - State conflict
  422 Unprocessable - Validation failed

5xx - Server Error
  500 Internal Error - Server bug
  502 Bad Gateway - Upstream error
  503 Service Unavailable - Overloaded
```

## Request/Response Patterns

### Pagination
```json
// Request
GET /users?page=2&limit=20

// Response
{
  "data": [...],
  "pagination": {
    "page": 2,
    "limit": 20,
    "total": 156,
    "totalPages": 8
  }
}
```

### Filtering
```
GET /users?status=active&role=admin
GET /orders?created_after=2024-01-01
GET /products?price_min=10&price_max=100
```

### Sorting
```
GET /users?sort=created_at:desc
GET /products?sort=price:asc,name:asc
```

### Field Selection
```
GET /users?fields=id,name,email
GET /users/{id}?fields=id,name,orders
```

## Error Response Format

### Standard Error
```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid input data",
    "details": [
      {
        "field": "email",
        "message": "Must be a valid email address"
      }
    ]
  }
}
```

### With Request ID
```json
{
  "error": {
    "code": "INTERNAL_ERROR",
    "message": "An unexpected error occurred",
    "requestId": "req_abc123"
  }
}
```

## Authentication Patterns

### Bearer Token
```
Authorization: Bearer eyJhbGciOiJIUzI1NiIs...
```

### API Key
```
X-API-Key: sk_live_abc123
# or
Authorization: ApiKey sk_live_abc123
```

### OAuth 2.0 Flow
```
1. GET /oauth/authorize?client_id=X&redirect_uri=Y&scope=Z
2. User grants access
3. Redirect to Y with code
4. POST /oauth/token with code
5. Receive access_token + refresh_token
```

## Versioning Strategies

### URL Versioning (Recommended)
```
GET /v1/users
GET /v2/users
```

### Header Versioning
```
Accept: application/vnd.api+json; version=1
```

### Query Parameter
```
GET /users?version=1
```

## OpenAPI Specification Template

```yaml
openapi: 3.0.0
info:
  title: API Name
  version: 1.0.0
  description: API description

servers:
  - url: https://api.example.com/v1

paths:
  /users:
    get:
      summary: List users
      tags: [Users]
      parameters:
        - name: page
          in: query
          schema:
            type: integer
            default: 1
      responses:
        '200':
          description: Success
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/UserList'
        '401':
          $ref: '#/components/responses/Unauthorized'

    post:
      summary: Create user
      tags: [Users]
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/CreateUser'
      responses:
        '201':
          description: Created
        '400':
          $ref: '#/components/responses/BadRequest'

components:
  schemas:
    User:
      type: object
      properties:
        id:
          type: string
          format: uuid
        email:
          type: string
          format: email
        createdAt:
          type: string
          format: date-time

    CreateUser:
      type: object
      required: [email, password]
      properties:
        email:
          type: string
          format: email
        password:
          type: string
          minLength: 8

  responses:
    Unauthorized:
      description: Authentication required
    BadRequest:
      description: Invalid request

  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer
```

## Rate Limiting

### Headers
```
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1640000000
```

### Response (429)
```json
{
  "error": {
    "code": "RATE_LIMIT_EXCEEDED",
    "message": "Too many requests",
    "retryAfter": 60
  }
}
```

## Webhook Design

### Payload
```json
{
  "id": "evt_123",
  "type": "user.created",
  "created": "2024-01-15T10:00:00Z",
  "data": {
    "id": "usr_456",
    "email": "user@example.com"
  }
}
```

### Security
- Signature verification (HMAC)
- Timestamp validation
- Idempotency keys
- Retry with exponential backoff
