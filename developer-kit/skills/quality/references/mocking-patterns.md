# Mocking Patterns for Testing

Common mocking patterns and best practices for test isolation.

## Jest Mocking

```javascript
// Mock external dependency
jest.mock("./api", () => ({
  fetchUser: jest.fn(),
}));

// Mock with implementation
jest.mock("./api", () => ({
  fetchUser: jest.fn().mockResolvedValue({ name: "John" }),
}));

// Spy on method
const spy = jest.spyOn(object, "method");
```

## Vitest Mocking

```javascript
// Same syntax as Jest
vi.mock("./api", () => ({
  fetchUser: vi.fn(),
}));

// Mock modules
vi.mock("axios");
```

## MSW (Mock Service Worker)

```javascript
import { rest } from "msw";
import { setupServer } from "msw/node";

const server = setupServer(
  rest.get("/api/user", (req, res, ctx) => {
    return res(ctx.json({ name: "John" }));
  }),
);

beforeAll(() => server.listen());
afterEach(() => server.resetHandlers());
afterAll(() => server.close());
```

## Async Testing Patterns

```javascript
// Wait for element
await waitFor(() => {
  expect(screen.getByText("Loaded")).toBeInTheDocument();
});

// Wait for element to disappear
await waitForElementToBeRemoved(() => screen.queryByText("Loading"));

// Test async function
await expect(asyncFunction()).resolves.toBe(expected);
await expect(asyncFunction()).rejects.toThrow("Error");
```

## Component Testing with Testing Library

```javascript
import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";

test("submits form with user data", async () => {
  const user = userEvent.setup();
  render(<LoginForm onSubmit={mockSubmit} />);

  await user.type(screen.getByLabelText(/email/i), "test@example.com");
  await user.type(screen.getByLabelText(/password/i), "password123");
  await user.click(screen.getByRole("button", { name: /submit/i }));

  expect(mockSubmit).toHaveBeenCalledWith({
    email: "test@example.com",
    password: "password123",
  });
});
```

## Anti-Patterns to Avoid

1. **Over-mocking** - Test behavior, not implementation
2. **Leaky mocks** - Reset mocks between tests
3. **Brittle selectors** - Use accessible queries
4. **Testing implementation** - Test what, not how
