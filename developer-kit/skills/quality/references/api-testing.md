# API Testing Reference

## Testing Pyramid for APIs

```
        /\
       /  \      E2E Tests (few)
      /----\     - Full API workflows
     /      \    - Critical paths only
    /--------\   Integration Tests (some)
   /          \  - API contracts
  /            \ - Database integration
 /--------------\ Unit Tests (many)
                  - Business logic
                  - Validators
                  - Transformers
```

## REST API Testing

### Jest + Supertest (Node.js)

```javascript
import request from 'supertest';
import app from '../src/app';

describe('Users API', () => {
  describe('GET /api/users', () => {
    it('returns list of users', async () => {
      const response = await request(app)
        .get('/api/users')
        .set('Authorization', `Bearer ${token}`)
        .expect('Content-Type', /json/)
        .expect(200);

      expect(response.body).toHaveProperty('data');
      expect(Array.isArray(response.body.data)).toBe(true);
    });

    it('returns 401 without auth', async () => {
      await request(app)
        .get('/api/users')
        .expect(401);
    });
  });

  describe('POST /api/users', () => {
    it('creates a new user', async () => {
      const newUser = {
        email: 'test@example.com',
        name: 'Test User'
      };

      const response = await request(app)
        .post('/api/users')
        .set('Authorization', `Bearer ${token}`)
        .send(newUser)
        .expect(201);

      expect(response.body.data).toMatchObject({
        email: newUser.email,
        name: newUser.name
      });
      expect(response.body.data).toHaveProperty('id');
    });

    it('validates required fields', async () => {
      const response = await request(app)
        .post('/api/users')
        .set('Authorization', `Bearer ${token}`)
        .send({})
        .expect(400);

      expect(response.body.errors).toContainEqual(
        expect.objectContaining({ field: 'email' })
      );
    });
  });
});
```

### Pytest (Python)

```python
import pytest
from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

class TestUsersAPI:
    def test_get_users_returns_list(self, auth_headers):
        response = client.get("/api/users", headers=auth_headers)

        assert response.status_code == 200
        assert "data" in response.json()
        assert isinstance(response.json()["data"], list)

    def test_get_users_requires_auth(self):
        response = client.get("/api/users")
        assert response.status_code == 401

    def test_create_user(self, auth_headers):
        new_user = {"email": "test@example.com", "name": "Test User"}

        response = client.post(
            "/api/users",
            json=new_user,
            headers=auth_headers
        )

        assert response.status_code == 201
        data = response.json()["data"]
        assert data["email"] == new_user["email"]
        assert "id" in data

    def test_create_user_validates_email(self, auth_headers):
        response = client.post(
            "/api/users",
            json={"email": "invalid", "name": "Test"},
            headers=auth_headers
        )

        assert response.status_code == 422

@pytest.fixture
def auth_headers():
    # Get auth token
    response = client.post("/auth/login", json={
        "email": "admin@example.com",
        "password": "password"
    })
    token = response.json()["token"]
    return {"Authorization": f"Bearer {token}"}
```

## Contract Testing

### OpenAPI Validation

```javascript
import { OpenAPIValidator } from 'express-openapi-validator';

// Validate requests/responses against OpenAPI spec
app.use(
  OpenAPIValidator.middleware({
    apiSpec: './openapi.yaml',
    validateRequests: true,
    validateResponses: true
  })
);
```

### Pact (Consumer-Driven Contracts)

```javascript
// Consumer test
import { Pact } from '@pact-foundation/pact';

describe('User Service Contract', () => {
  const provider = new Pact({
    consumer: 'Frontend',
    provider: 'UserService',
  });

  beforeAll(() => provider.setup());
  afterAll(() => provider.finalize());

  it('gets user by id', async () => {
    await provider.addInteraction({
      state: 'user with id 1 exists',
      uponReceiving: 'a request for user 1',
      withRequest: {
        method: 'GET',
        path: '/api/users/1',
      },
      willRespondWith: {
        status: 200,
        body: {
          id: 1,
          name: Matchers.string('John Doe'),
          email: Matchers.email()
        }
      }
    });

    const response = await userClient.getUser(1);
    expect(response.id).toBe(1);
  });
});
```

## Load Testing

### k6 Load Test

```javascript
// load-test.js
import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  stages: [
    { duration: '30s', target: 20 },   // Ramp up
    { duration: '1m', target: 20 },    // Stay at 20
    { duration: '30s', target: 50 },   // Ramp to 50
    { duration: '1m', target: 50 },    // Stay at 50
    { duration: '30s', target: 0 },    // Ramp down
  ],
  thresholds: {
    http_req_duration: ['p(95)<500'],  // 95% of requests < 500ms
    http_req_failed: ['rate<0.01'],    // Error rate < 1%
  },
};

export default function () {
  const response = http.get('http://api.example.com/users');

  check(response, {
    'status is 200': (r) => r.status === 200,
    'response time < 500ms': (r) => r.timings.duration < 500,
  });

  sleep(1);
}

// Run: k6 run load-test.js
```

### Artillery

```yaml
# artillery.yml
config:
  target: "http://api.example.com"
  phases:
    - duration: 60
      arrivalRate: 10
      name: "Warm up"
    - duration: 120
      arrivalRate: 50
      name: "Sustained load"
  defaults:
    headers:
      Authorization: "Bearer {{ $processEnvironment.API_TOKEN }}"

scenarios:
  - name: "Browse and create"
    flow:
      - get:
          url: "/api/users"
          capture:
            - json: "$.data[0].id"
              as: "userId"
      - get:
          url: "/api/users/{{ userId }}"
      - post:
          url: "/api/users"
          json:
            email: "user{{ $randomNumber() }}@example.com"
            name: "Load Test User"
```

## API Mocking

### MSW (Mock Service Worker)

```javascript
import { rest } from 'msw';
import { setupServer } from 'msw/node';

const handlers = [
  rest.get('/api/users', (req, res, ctx) => {
    return res(
      ctx.status(200),
      ctx.json({
        data: [
          { id: 1, name: 'John Doe', email: 'john@example.com' },
          { id: 2, name: 'Jane Doe', email: 'jane@example.com' }
        ]
      })
    );
  }),

  rest.post('/api/users', async (req, res, ctx) => {
    const body = await req.json();
    return res(
      ctx.status(201),
      ctx.json({
        data: { id: 3, ...body }
      })
    );
  })
];

const server = setupServer(...handlers);

beforeAll(() => server.listen());
afterEach(() => server.resetHandlers());
afterAll(() => server.close());
```

## Security Testing

### OWASP ZAP Automation

```yaml
# zap-config.yaml
env:
  contexts:
    - name: "API Context"
      urls:
        - "http://api.example.com"
      authentication:
        method: "json"
        parameters:
          loginUrl: "http://api.example.com/auth/login"
          loginRequestData: '{"email":"test@example.com","password":"password"}'

jobs:
  - type: spider
    parameters:
      context: "API Context"
      maxDuration: 5

  - type: activeScan
    parameters:
      context: "API Context"
      policy: "API-Scan"

  - type: report
    parameters:
      template: "modern"
      reportFile: "zap-report.html"
```

## Test Data Management

### Factories

```javascript
// factories/user.js
import { faker } from '@faker-js/faker';

export const createUser = (overrides = {}) => ({
  id: faker.string.uuid(),
  email: faker.internet.email(),
  name: faker.person.fullName(),
  createdAt: faker.date.past(),
  ...overrides
});

export const createUsers = (count, overrides = {}) =>
  Array.from({ length: count }, () => createUser(overrides));

// Usage in tests
const user = createUser({ email: 'specific@example.com' });
const users = createUsers(10);
```

### Database Seeding

```javascript
// seeds/test-data.js
export async function seed(db) {
  await db('users').del();  // Clean table

  await db('users').insert([
    { id: 1, email: 'admin@example.com', role: 'admin' },
    { id: 2, email: 'user@example.com', role: 'user' }
  ]);
}

// In test setup
beforeEach(async () => {
  await seed(db);
});
```
