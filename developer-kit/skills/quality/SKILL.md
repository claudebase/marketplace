---
name: quality
description: "Testing strategy design and quality assessment for comprehensive test coverage. This skill should be used when the user asks to 'design tests for', 'create test strategy', 'improve coverage', or 'what tests are needed'. Also use when user mentions quality assessment, testing recommendations, or coverage analysis. READ-ONLY."
allowed-tools:
  # Core Analysis
  - Read
  - Grep
  - Glob
  - Bash
  # Testing Documentation
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  # Pattern Research
  - mcp__github__search_code
  - mcp__github__get_file_contents
  # Best Practices Research
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  # Structured Analysis
  - mcp__sequential-thinking__sequentialthinking
---

# Quality Skill

Design comprehensive testing strategies with focus on edge cases, boundary conditions, and risk-based prioritization using official testing documentation and industry best practices.

**Core Principle**: "Think beyond the happy path. Find the failures before users do."

**Key Enhancement**: Research testing patterns and best practices before designing test strategies.

**Key Distinction**: This skill DESIGNS testing strategy (read-only). To execute tests, use the `test` skill. To implement tests, use the `implement` skill.

## Activation Triggers

- Test strategy ("how should I test this", "testing strategy")
- Coverage improvement ("improve test coverage", "what tests needed")
- Edge case analysis ("find edge cases", "boundary testing")
- Quality assessment ("assess quality", "coverage gaps")
- Test prioritization ("which tests to write first", "risk-based testing")

## Do NOT Activate When

- User wants to run tests → use `test` skill or `devops` skill
- User wants general code analysis → use `analyze` skill
- User wants to implement tests → use `implement` skill
- User wants security testing → use `security` skill

**Boundary Clarification:**
This skill designs testing strategies and identifies coverage gaps. For executing tests, use the `test` skill. For implementing the tests designed, use the `implement` skill. The `analyze` skill provides general code analysis and will recommend this skill for testing-specific concerns.

## Behavioral Flow

```
┌──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
│   ANALYZE    │   RESEARCH   │    DESIGN    │  PRIORITIZE  │    REPORT    │
├──────────────┼──────────────┼──────────────┼──────────────┼──────────────┤
│ Understand   │ Lookup       │ Create test  │ Rank by      │ Present      │
│ code and     │ testing      │ cases for    │ risk and     │ test         │
│ critical     │ docs         │ all paths    │ impact       │ strategy     │
│ paths        │              │              │              │              │
│              │              │              │              │              │
│ Identify     │ Find         │ Cover edge   │ Identify     │ Provide      │
│ testable     │ testing      │ cases and    │ quick wins   │ implementation│
│ units        │ patterns     │ boundaries   │              │ guidance     │
│              │              │              │              │              │
│ Map          │ Research     │ Plan         │ Calculate    │ Define       │
│ dependencies │ best         │ integration  │ coverage     │ success      │
│              │ practices    │ points       │ targets      │ metrics      │
└──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘
     Read           Context7      Sequential      Sequential      Output
     Grep           GitHub        Thinking        Thinking        Report
                    Tavily
```

### Phase 1: ANALYZE

Understand the code and its critical paths:

1. **Read the code** - Understand functions, classes, and their responsibilities
2. **Map dependencies** - External services, databases, APIs
3. **Identify critical paths** - User journeys, data flows, business logic
4. **Find existing tests** - Current coverage, test patterns used

```bash
# Find existing tests
find . -name "*.test.*" -o -name "*.spec.*" | head -20

# Check test configuration
cat jest.config.* vitest.config.* playwright.config.* 2>/dev/null

# Analyze current coverage
npx jest --coverage --coverageReporters=text-summary 2>/dev/null
```

**Tools**: Read, Grep, Glob, Bash

### Phase 2: RESEARCH

Gather official documentation and testing patterns:

```
# Lookup Jest testing patterns
mcp__context7__resolve-library-id → "/jestjs/jest"
mcp__context7__query-docs("mocking async functions best practices")

# Lookup Vitest configuration
mcp__context7__resolve-library-id → "/vitest-dev/vitest"
mcp__context7__query-docs("coverage configuration v8 istanbul")

# Lookup Playwright test patterns
mcp__context7__resolve-library-id → "/microsoft/playwright"
mcp__context7__query-docs("page object model testing patterns")

# Lookup Testing Library queries
mcp__context7__resolve-library-id → "/websites/testing-library"
mcp__context7__query-docs("getByRole queries accessibility")

# Find testing patterns in codebases
mcp__github__search_code("describe it expect mock filename:.test.ts stars:>500")

# Research current best practices
mcp__tavily__tavily-search("React testing best practices 2024 testing-library")
```

**Tools**: Context7, GitHub MCP, Tavily

### Phase 3: DESIGN

Create comprehensive test cases:

```
mcp__sequential-thinking__sequentialthinking
- What are the happy path scenarios?
- What edge cases exist (null, empty, max, min)?
- What error conditions should be handled?
- What integration points need testing?
- What race conditions or timing issues exist?
```

**Test Case Categories:**

- **Unit Tests** - Individual functions and methods
- **Integration Tests** - Component interactions, API calls
- **E2E Tests** - Full user journeys
- **Edge Cases** - Boundary values, error states
- **Security Tests** - Input validation, authorization

**Tools**: Sequential Thinking

### Phase 4: PRIORITIZE

Rank tests by risk and impact:

```
mcp__sequential-thinking__sequentialthinking
- Which failures would cause the most damage?
- Which areas are most likely to have bugs?
- What's the complexity vs value trade-off?
- Which tests provide the most confidence?
```

**Prioritization Framework:**

| Priority      | Criteria                               | Examples                  |
| ------------- | -------------------------------------- | ------------------------- |
| P0 - Critical | Business-critical, high failure impact | Payment, auth, data loss  |
| P1 - High     | Frequently used, user-facing           | Core features, navigation |
| P2 - Medium   | Important but lower risk               | Settings, preferences     |
| P3 - Low      | Nice to have, edge cases               | Rare scenarios            |

**Tools**: Sequential Thinking

### Phase 5: REPORT

Present the test strategy with implementation guidance:

- Coverage analysis and gaps
- Prioritized test cases
- Implementation recommendations
- Success metrics

**Tools**: Output report

## MCP Integration

### Context7 (Official Documentation)

**Primary source for testing framework documentation:**

```
mcp__context7__resolve-library-id - Resolve Jest, Vitest, Playwright IDs
mcp__context7__query-docs - Get official documentation
```

**Available Resources:**

| Resource        | Library ID                          | Snippets |
| --------------- | ----------------------------------- | -------- |
| Jest            | `/jestjs/jest`                      | 1,717    |
| Vitest          | `/vitest-dev/vitest`                | 2,776    |
| Playwright      | `/microsoft/playwright`             | 3,711    |
| Testing Library | `/websites/testing-library`         | 953      |
| Cypress         | `/cypress-io/cypress-documentation` | 2,053    |
| Jest DOM        | `/testing-library/jest-dom`         | 86       |

**Use cases:**

- "Jest mock implementation patterns"
- "Vitest coverage configuration"
- "Playwright page object model"
- "Testing Library getByRole queries"
- "Cypress intercept network requests"
- "Jest snapshot testing best practices"

### GitHub MCP (Pattern Research)

**Find testing patterns in production codebases:**

```
mcp__github__search_code - Find test patterns
mcp__github__get_file_contents - Get specific test files
```

**Search patterns:**

```
# Find unit test patterns
"describe" "it" "expect" "mock" filename:.test.ts stars:>500

# Find integration test patterns
"beforeAll" "afterAll" "setupServer" filename:.test.ts

# Find E2E test patterns
"test" "page" "expect" filename:.spec.ts stars:>100

# Find mock patterns
"jest.mock" "vi.mock" "mockImplementation" filename:.test.ts

# Find coverage configurations
"coverageThreshold" "coverage" filename:jest.config.*

# Find testing utilities
"renderWithProviders" "customRender" filename:test-utils.*
```

**Use cases:**

- Find how large projects structure tests
- Research mocking strategies
- Get test utility implementations
- Study E2E test organization

### Tavily (Best Practices Research)

**Research current testing methodologies:**

```
mcp__tavily__tavily-search - Research testing strategies
mcp__tavily__tavily-extract - Extract from testing guides
```

**Use cases:**

- "React Testing Library best practices 2024"
- "Jest vs Vitest comparison performance"
- "E2E testing strategies Playwright Cypress"
- "Test-driven development TDD patterns"
- "Integration testing microservices"
- "Mutation testing JavaScript Stryker"

### Sequential Thinking (Structured Analysis)

**Systematic test strategy design:**

```
mcp__sequential-thinking__sequentialthinking - Multi-step test planning
```

**Use for:**

- Comprehensive edge case analysis
- Risk-based prioritization
- Coverage gap identification
- Test dependency mapping

## Quality Mindset

> "Quality is not an act, it is a habit. Test what matters most."

- **Prevent defects early** - Don't just detect late
- **Risk-based prioritization** - Test critical paths first
- **Edge cases and boundaries** - Where bugs hide
- **Automate the critical path** - Consistent verification

## Focus Areas

### 1. Test Strategy Design

**Test Pyramid:**

```
        /\
       /  \      E2E Tests (few, slow, expensive)
      /----\
     /      \    Integration Tests (some, medium)
    /--------\
   /          \  Unit Tests (many, fast, cheap)
  --------------
```

**Coverage Targets:**

| Test Type   | Target         | Purpose                     |
| ----------- | -------------- | --------------------------- |
| Unit        | 80%+           | Function/method correctness |
| Integration | 60%+           | Component interactions      |
| E2E         | Critical paths | User journey validation     |

### 2. Edge Case Detection

**Boundary Value Analysis:**

```javascript
// For a function that accepts age 0-120
describe("validateAge", () => {
  // Boundary values
  it("accepts minimum valid age (0)", () => {});
  it("accepts maximum valid age (120)", () => {});
  it("rejects below minimum (-1)", () => {});
  it("rejects above maximum (121)", () => {});

  // Special values
  it("handles null", () => {});
  it("handles undefined", () => {});
  it("handles non-numeric input", () => {});
  it("handles floating point (18.5)", () => {});
});
```

**Common Edge Cases:**

| Category   | Examples                                      |
| ---------- | --------------------------------------------- |
| Empty/Null | `null`, `undefined`, `""`, `[]`, `{}`         |
| Boundaries | 0, -1, MAX_INT, empty string, max length      |
| Special    | Unicode, emojis, SQL injection strings        |
| Timing     | Concurrent access, race conditions, timeouts  |
| State      | Invalid transitions, stale data, cache expiry |

### 3. Failure Scenarios

```javascript
describe("API Error Handling", () => {
  it("handles network timeout", async () => {});
  it("handles 500 server error", async () => {});
  it("handles 401 unauthorized", async () => {});
  it("handles malformed response", async () => {});
  it("retries on transient failure", async () => {});
  it("shows user-friendly error message", async () => {});
});
```

### 4. Quality Metrics

| Metric              | Description               | Target  |
| ------------------- | ------------------------- | ------- |
| Line Coverage       | Lines executed by tests   | > 80%   |
| Branch Coverage     | Decision branches tested  | > 75%   |
| Function Coverage   | Functions called by tests | > 90%   |
| Mutation Score      | Bugs caught by tests      | > 60%   |
| Test Execution Time | Time to run all tests     | < 5 min |

## Test Case Template

```markdown
### Test Case: [Feature/Function Name]

#### Happy Path

- [ ] Normal input produces expected output
- [ ] All required fields work correctly
- [ ] Success response format is correct

#### Edge Cases

- [ ] Empty input
- [ ] Null/undefined input
- [ ] Maximum length/value input
- [ ] Minimum valid input
- [ ] Special characters (Unicode, emojis)
- [ ] Whitespace-only input

#### Error Scenarios

- [ ] Invalid input types
- [ ] Missing required fields
- [ ] Network failure/timeout
- [ ] Unauthorized access
- [ ] Concurrent modifications
- [ ] Resource not found

#### Integration Points

- [ ] Database operations
- [ ] External API calls
- [ ] Event publishing
- [ ] Cache interactions

#### Security

- [ ] Input validation/sanitization
- [ ] Authorization checks
- [ ] Rate limiting
- [ ] Injection prevention
```

## Common Testing Patterns

### Mocking Best Practices

```javascript
// Jest - Mock external dependency
jest.mock("./api", () => ({
  fetchUser: jest.fn(),
}));

// Vitest - Same syntax
vi.mock("./api", () => ({
  fetchUser: vi.fn(),
}));

// Testing Library - Mock API with MSW
import { rest } from "msw";
import { setupServer } from "msw/node";

const server = setupServer(
  rest.get("/api/user", (req, res, ctx) => {
    return res(ctx.json({ name: "John" }));
  }),
);
```

### Async Testing

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

### Component Testing

```javascript
// Testing Library - User-centric testing
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

## Output Format

```markdown
## Test Strategy Report

### Coverage Analysis

| Area               | Current | Target | Gap | Priority |
| ------------------ | ------- | ------ | --- | -------- |
| Unit tests         | 45%     | 80%    | 35% | High     |
| Integration        | 20%     | 60%    | 40% | High     |
| E2E critical paths | 30%     | 90%    | 60% | Critical |

### Research Findings

- Framework recommendation: [Jest/Vitest based on codebase]
- Similar project patterns: [links to examples]
- Best practices: [relevant articles]

### Priority Test Cases

#### P0 - Critical (Must Have)

1. **User Authentication Flow**
   - Login with valid credentials
   - Login with invalid credentials
   - Session expiration handling
   - Password reset flow

2. **Payment Processing**
   - Successful payment
   - Declined card
   - Network timeout during payment
   - Duplicate payment prevention

#### P1 - High (Should Have)

1. **User Profile Management**
   - Update profile information
   - Change password
   - Account deletion

### Edge Cases Identified

1. Empty cart checkout attempt
2. Concurrent cart modifications
3. Currency conversion edge cases
4. Unicode in user names
5. Maximum item quantity limits

### Recommended Test Structure
```

tests/
├── unit/ # Fast, isolated tests
│ ├── utils/
│ └── hooks/
├── integration/ # API and database tests
│ ├── api/
│ └── services/
├── e2e/ # Critical user journeys
│ ├── auth/
│ └── checkout/
└── **mocks**/ # Shared mocks

```

### Quick Wins

1. Add missing null checks tests (est. +10% coverage)
2. Test boundary values for pagination
3. Add error response format tests
4. Mock external API calls consistently

### Success Metrics

| Metric | Current | Target | Timeline |
|--------|---------|--------|----------|
| Unit coverage | 45% | 80% | 2 weeks |
| CI test time | 8 min | < 5 min | 1 week |
| Flaky tests | 5 | 0 | 1 week |
```

## Reference Files

For detailed testing patterns, see:

- `references/testing-strategies.md` - Testing methodologies
- `references/coverage-patterns.md` - Coverage analysis patterns
- `references/api-testing.md` - REST API, contract, load, and security testing patterns
- `references/mocking-patterns.md` - Mock and stub patterns

## Handoffs

| Scenario                   | Hand off to         |
| -------------------------- | ------------------- |
| Need to implement tests    | `implement` skill   |
| Need to run tests          | `test` skill        |
| Need performance testing   | `performance` skill |
| Need security testing      | `security` skill    |
| Need accessibility testing | `a11y` skill        |

## Boundaries

**Will:**

- Analyze code to identify testable units
- Design comprehensive test cases
- Research testing patterns via MCP tools
- Identify edge cases and failure scenarios
- Prioritize tests by risk and impact
- Recommend test structure and organization
- Define coverage targets and success metrics

**Will Not:**

- Execute tests (use `test` skill)
- Implement test code (use `implement` skill)
- Make architectural decisions
- Modify source code
- Run coverage reports (provides guidance only)
