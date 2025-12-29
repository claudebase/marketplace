# JSDoc and Docstring Patterns

## JavaScript/TypeScript JSDoc

### Function Documentation

```javascript
/**
 * Calculates the total price including tax.
 *
 * @param {number} price - The base price before tax
 * @param {number} taxRate - Tax rate as decimal (e.g., 0.08 for 8%)
 * @returns {number} Total price including tax
 * @throws {Error} If price or taxRate is negative
 *
 * @example
 * const total = calculateTotal(100, 0.08);
 * console.log(total); // 108
 */
function calculateTotal(price, taxRate) {
  if (price < 0 || taxRate < 0) {
    throw new Error('Values must be non-negative');
  }
  return price * (1 + taxRate);
}
```

### Class Documentation

```javascript
/**
 * Manages user authentication and session state.
 *
 * @class
 * @example
 * const auth = new AuthManager({ tokenExpiry: 3600 });
 * await auth.login('user@example.com', 'password');
 */
class AuthManager {
  /**
   * Creates an AuthManager instance.
   * @param {Object} config - Configuration options
   * @param {number} [config.tokenExpiry=3600] - Token expiry in seconds
   * @param {string} [config.apiUrl] - API base URL
   */
  constructor(config) {
    this.config = config;
  }

  /**
   * Authenticates user with credentials.
   * @async
   * @param {string} email - User email
   * @param {string} password - User password
   * @returns {Promise<AuthResult>} Authentication result
   * @throws {AuthError} If credentials are invalid
   */
  async login(email, password) {
    // Implementation
  }
}
```

### TypeScript with JSDoc

```typescript
/**
 * User data transfer object
 * @interface
 */
interface UserDTO {
  /** Unique user identifier */
  id: string;
  /** User's email address */
  email: string;
  /** Account creation timestamp */
  createdAt: Date;
}

/**
 * Fetches user by ID from the database.
 *
 * @template T - Return type extending UserDTO
 * @param {string} id - User ID to fetch
 * @returns {Promise<T | null>} User data or null if not found
 */
async function getUser<T extends UserDTO>(id: string): Promise<T | null> {
  // Implementation
}
```

## Python Docstrings

### Google Style

```python
def calculate_total(price: float, tax_rate: float) -> float:
    """Calculate the total price including tax.

    Args:
        price: The base price before tax.
        tax_rate: Tax rate as decimal (e.g., 0.08 for 8%).

    Returns:
        Total price including tax.

    Raises:
        ValueError: If price or tax_rate is negative.

    Example:
        >>> calculate_total(100, 0.08)
        108.0
    """
    if price < 0 or tax_rate < 0:
        raise ValueError("Values must be non-negative")
    return price * (1 + tax_rate)
```

### NumPy Style

```python
def calculate_total(price, tax_rate):
    """
    Calculate the total price including tax.

    Parameters
    ----------
    price : float
        The base price before tax.
    tax_rate : float
        Tax rate as decimal (e.g., 0.08 for 8%).

    Returns
    -------
    float
        Total price including tax.

    Raises
    ------
    ValueError
        If price or tax_rate is negative.

    Examples
    --------
    >>> calculate_total(100, 0.08)
    108.0
    """
    pass
```

### Class Docstring

```python
class AuthManager:
    """Manage user authentication and session state.

    This class handles user login, logout, and token management
    for the application.

    Attributes:
        token_expiry: Token expiration time in seconds.
        api_url: Base URL for authentication API.

    Example:
        >>> auth = AuthManager(token_expiry=3600)
        >>> await auth.login("user@example.com", "password")
    """

    def __init__(self, token_expiry: int = 3600, api_url: str = None):
        """Initialize AuthManager.

        Args:
            token_expiry: Token expiration in seconds. Defaults to 3600.
            api_url: API base URL. Defaults to None.
        """
        self.token_expiry = token_expiry
        self.api_url = api_url
```

## Common JSDoc Tags Reference

| Tag | Purpose | Example |
|-----|---------|---------|
| `@param` | Document parameter | `@param {string} name - User name` |
| `@returns` | Document return value | `@returns {boolean} Success status` |
| `@throws` | Document exceptions | `@throws {Error} If invalid` |
| `@example` | Usage example | `@example foo('bar')` |
| `@async` | Mark async function | `@async` |
| `@deprecated` | Mark deprecated | `@deprecated Use newFunc instead` |
| `@see` | Reference link | `@see {@link OtherClass}` |
| `@since` | Version added | `@since 1.2.0` |
| `@type` | Variable type | `@type {string}` |
| `@typedef` | Custom type | `@typedef {Object} Config` |
