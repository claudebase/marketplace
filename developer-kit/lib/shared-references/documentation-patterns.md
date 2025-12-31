# Documentation Patterns

Centralized patterns for documentation generation. Used by `document` skill and `technical-writer` agent.

## Documentation Types

| Type         | Audience   | Purpose          | Key Sections                |
| ------------ | ---------- | ---------------- | --------------------------- |
| README       | All        | First impression | Intro, Install, Usage, API  |
| API Docs     | Developers | Reference        | Endpoints, Params, Examples |
| JSDoc/TSDoc  | Developers | Inline reference | Params, Returns, Examples   |
| Guides       | Users      | Learning         | Steps, Explanations, Tips   |
| Architecture | Team       | Design decisions | ADRs, Diagrams, Rationale   |

## README Template

```markdown
# Project Name

Brief description of the project (1-2 sentences).

## Features

- Feature 1: Brief description
- Feature 2: Brief description
- Feature 3: Brief description

## Installation

\`\`\`bash
npm install project-name

# or

yarn add project-name
\`\`\`

## Quick Start

\`\`\`typescript
import { Component } from 'project-name';

const result = Component.method();
console.log(result);
\`\`\`

## Usage

### Basic Usage

[Basic example with code]

### Advanced Usage

[Advanced example with code]

## API Reference

### `functionName(params)`

Description of function.

**Parameters:**

- `param1` (string): Description of param1
- `param2` (number, optional): Description of param2. Default: `0`

**Returns:** `ReturnType` - Description of return value

**Example:**
\`\`\`typescript
const result = functionName('value', 42);
\`\`\`

## Configuration

[Configuration options if applicable]

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md)

## License

MIT
```

## JSDoc/TSDoc Patterns

### Function Documentation

````typescript
/**
 * Calculates the total price including tax.
 *
 * @param basePrice - The base price before tax
 * @param taxRate - The tax rate as a decimal (e.g., 0.08 for 8%)
 * @returns The total price including tax
 * @throws {Error} When basePrice is negative
 *
 * @example
 * ```typescript
 * const total = calculateTotal(100, 0.08);
 * console.log(total); // 108
 * ```
 */
function calculateTotal(basePrice: number, taxRate: number): number {
  if (basePrice < 0) {
    throw new Error("Base price cannot be negative");
  }
  return basePrice * (1 + taxRate);
}
````

### Class Documentation

````typescript
/**
 * Manages user authentication state and operations.
 *
 * @example
 * ```typescript
 * const auth = new AuthManager(config);
 * await auth.login('user@example.com', 'password');
 * ```
 */
class AuthManager {
  /**
   * Creates a new AuthManager instance.
   * @param config - Configuration options for authentication
   */
  constructor(config: AuthConfig) {}

  /**
   * Authenticates a user with email and password.
   * @param email - User's email address
   * @param password - User's password
   * @returns The authenticated user or null if authentication fails
   */
  async login(email: string, password: string): Promise<User | null> {}
}
````

### Interface Documentation

```typescript
/**
 * Configuration options for the API client.
 */
interface ApiConfig {
  /** Base URL for API requests */
  baseUrl: string;

  /** Request timeout in milliseconds. Default: 5000 */
  timeout?: number;

  /** Custom headers to include in all requests */
  headers?: Record<string, string>;

  /**
   * Retry configuration for failed requests.
   * @default { attempts: 3, delay: 1000 }
   */
  retry?: RetryConfig;
}
```

## Python Docstring Patterns

### Google Style

```python
def calculate_total(base_price: float, tax_rate: float) -> float:
    """Calculate the total price including tax.

    Args:
        base_price: The base price before tax.
        tax_rate: The tax rate as a decimal (e.g., 0.08 for 8%).

    Returns:
        The total price including tax.

    Raises:
        ValueError: If base_price is negative.

    Example:
        >>> calculate_total(100, 0.08)
        108.0
    """
    if base_price < 0:
        raise ValueError("Base price cannot be negative")
    return base_price * (1 + tax_rate)
```

### Class with Google Style

```python
class AuthManager:
    """Manages user authentication state and operations.

    Attributes:
        is_authenticated: Whether a user is currently logged in.
        current_user: The currently authenticated user, or None.

    Example:
        >>> auth = AuthManager(config)
        >>> await auth.login('user@example.com', 'password')
    """

    def __init__(self, config: AuthConfig) -> None:
        """Initialize the AuthManager.

        Args:
            config: Configuration options for authentication.
        """
        self.config = config
        self.is_authenticated = False
        self.current_user = None
```

## API Documentation Template

```markdown
# API Reference

## Base URL

\`\`\`
https://api.example.com/v1
\`\`\`

## Authentication

All requests require a Bearer token:

\`\`\`
Authorization: Bearer <token>
\`\`\`

## Endpoints

### Get User

\`\`\`http
GET /users/{id}
\`\`\`

**Parameters:**

| Name    | Type   | In    | Required | Description                  |
| ------- | ------ | ----- | -------- | ---------------------------- |
| id      | string | path  | Yes      | User ID                      |
| include | string | query | No       | Related resources to include |

**Response:**

\`\`\`json
{
"id": "user_123",
"email": "user@example.com",
"name": "John Doe",
"createdAt": "2024-01-01T00:00:00Z"
}
\`\`\`

**Error Responses:**

| Status | Description    |
| ------ | -------------- |
| 404    | User not found |
| 401    | Unauthorized   |
```

## Architecture Decision Record (ADR) Template

```markdown
# ADR-001: [Title]

## Status

Proposed | Accepted | Deprecated | Superseded by ADR-XXX

## Context

What is the issue that we're seeing that is motivating this decision?

## Decision

What is the change that we're proposing and/or doing?

## Consequences

What becomes easier or more difficult to do because of this change?

### Positive

- Benefit 1
- Benefit 2

### Negative

- Drawback 1
- Drawback 2

### Neutral

- Trade-off 1
```

## Documentation Best Practices

```yaml
Clarity:
  - Write for the reader, not the writer
  - Use active voice
  - Lead with the most important information
  - Keep sentences short and direct

Examples:
  - Include working code examples
  - Show common use cases first
  - Include error handling examples
  - Test all code examples

Maintenance:
  - Keep documentation close to code
  - Update docs when code changes
  - Use automation when possible
  - Review docs during code review
```

## Context7 Documentation Resources

| Resource   | Library ID               | Use Case            |
| ---------- | ------------------------ | ------------------- |
| JSDoc      | `/jsdoc/jsdoc.github.io` | JSDoc syntax        |
| TypeDoc    | `/typestrong/typedoc`    | TypeScript docs     |
| TSDoc      | `/microsoft/tsdoc`       | TSDoc standard      |
| Docusaurus | `/facebook/docusaurus`   | Documentation sites |
| VitePress  | `/vuejs/vitepress`       | Vue documentation   |

## Related

- [MCP Resources](./mcp-resources.md) - Context7 library IDs
- [Tool Integration](./tool-integration-patterns.md) - MCP patterns
- [Technical Writing](./technical-writing-patterns.md) - Professional writing
