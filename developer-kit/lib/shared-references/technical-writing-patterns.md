# Technical Writer - Documentation Patterns

## README Template

```markdown
# Project Name

Brief description of what the project does.

[![npm version](https://badge.fury.io/js/package.svg)](https://badge.fury.io/js/package)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Features

- Feature 1
- Feature 2
- Feature 3

## Installation

\`\`\`bash
npm install package-name
\`\`\`

## Quick Start

\`\`\`javascript
import { feature } from "package-name";

const result = feature();
\`\`\`

## API Reference

### `functionName(param)`

Description of the function.

| Parameter | Type     | Description          |
| --------- | -------- | -------------------- |
| param     | `string` | Description of param |

**Returns:** `ReturnType` - Description of return value

## Configuration

| Option  | Type      | Default | Description |
| ------- | --------- | ------- | ----------- |
| option1 | `boolean` | `true`  | Description |

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

MIT © [Author Name](https://github.com/author)
```

## API Documentation Template

```markdown
## POST /api/auth/login

Authenticate a user and receive an access token.

### Request

**Headers:**

| Header       | Value            | Required |
| ------------ | ---------------- | -------- |
| Content-Type | application/json | Yes      |

**Body:**

\`\`\`json
{
"username": "string",
"password": "string"
}
\`\`\`

| Field    | Type   | Required | Description     |
| -------- | ------ | -------- | --------------- |
| username | string | Yes      | User's username |
| password | string | Yes      | User's password |

### Response

**Success (200):**

\`\`\`json
{
"token": "eyJhbGciOiJIUzI1NiIs...",
"expiresIn": 3600
}
\`\`\`

**Error (401):**

\`\`\`json
{
"error": "Invalid credentials",
"code": "AUTH_FAILED"
}
\`\`\`

### Example

\`\`\`bash
curl -X POST https://api.example.com/auth/login \\
-H "Content-Type: application/json" \\
-d '{"username": "john", "password": "secret"}'
\`\`\`
```

## JSDoc/TSDoc Examples

### Standard JSDoc

```javascript
/**
 * Authenticates a user with the provided credentials.
 *
 * @param {string} username - The user's username
 * @param {string} password - The user's password
 * @returns {Promise<AuthResult>} Authentication result with token
 * @throws {AuthError} If credentials are invalid
 * @example
 * const result = await authenticate('john', 'secret123');
 * console.log(result.token);
 *
 * @see {@link logout} for ending sessions
 * @since 1.0.0
 */
async function authenticate(username, password) {
  // ...
}
```

### TSDoc Format

````typescript
/**
 * Authenticates a user with the provided credentials.
 *
 * @param username - The user's username
 * @param password - The user's password
 * @returns Authentication result with token
 * @throws {@link AuthError} If credentials are invalid
 *
 * @example
 * ```typescript
 * const result = await authenticate('john', 'secret123');
 * console.log(result.token);
 * ```
 *
 * @public
 */
````

## User Guide Template

```markdown
# Getting Started with [Product]

## Overview

Brief description of what you'll learn and accomplish.

**Prerequisites:**

- Requirement 1
- Requirement 2

**Time to complete:** ~15 minutes

## Step 1: Installation

First, install the package:

\`\`\`bash
npm install package-name
\`\`\`

**Verify installation:**

\`\`\`bash
npx package-name --version
\`\`\`

You should see: `v1.0.0`

## Step 2: Configuration

Create a configuration file:

\`\`\`javascript
// config.js
module.exports = {
option1: "value",
option2: true,
};
\`\`\`

## Step 3: First Usage

Now let's use the feature:

\`\`\`javascript
import { feature } from "package-name";

const result = feature();
console.log(result);
\`\`\`

**Expected output:**

\`\`\`
{ success: true, data: "Hello, World!" }
\`\`\`

## Next Steps

- [Advanced Configuration](./advanced-config.md)
- [API Reference](./api-reference.md)
- [Troubleshooting](./troubleshooting.md)
```

## Architecture Decision Record (ADR) Template

```markdown
# ADR-001: [Title]

## Status

[Proposed | Accepted | Deprecated | Superseded by ADR-XXX]

## Context

What is the issue that we're seeing that is motivating this decision or change?

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

- Side effect 1

## Alternatives Considered

### Alternative 1

Description and why it was rejected.

### Alternative 2

Description and why it was rejected.

## References

- [Link to relevant documentation]
- [Link to related ADR]
```

## CHANGELOG Template (Keep a Changelog)

```markdown
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- New feature description

### Changed

- Change description

### Deprecated

- Deprecated feature description

### Removed

- Removed feature description

### Fixed

- Bug fix description

### Security

- Security fix description

## [1.0.0] - 2024-01-15

### Added

- Initial release
- Feature A
- Feature B

[Unreleased]: https://github.com/user/repo/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/user/repo/releases/tag/v1.0.0
```

## Component Documentation Template

```markdown
## Button

A customizable button component with various styles and sizes.

### Props

| Prop     | Type                       | Default     | Description          |
| -------- | -------------------------- | ----------- | -------------------- |
| variant  | `'primary' \| 'secondary'` | `'primary'` | Button style variant |
| size     | `'sm' \| 'md' \| 'lg'`     | `'md'`      | Button size          |
| disabled | `boolean`                  | `false`     | Disable button       |
| onClick  | `(e: MouseEvent) => void`  | -           | Click handler        |
| children | `ReactNode`                | -           | Button content       |

### Usage

\`\`\`tsx
import { Button } from "@/components";

<Button variant="primary" size="lg" onClick={handleClick}>
  Click me
</Button>
\`\`\`

### Examples

#### Primary Button

\`\`\`tsx
<Button variant="primary">Submit</Button>
\`\`\`

#### Disabled State

\`\`\`tsx
<Button disabled>Cannot Click</Button>
\`\`\`

### Accessibility

- Uses native `<button>` element
- Supports keyboard navigation
- Includes proper ARIA attributes when disabled
```

## Diátaxis Framework

### 1. Tutorials (Learning-Oriented)

```yaml
Purpose: Take user through a series of steps to complete a project
Audience: Beginners, new users
Style: Step-by-step, hand-holding

Structure:
  - Clear goal statement
  - Prerequisites list
  - Numbered steps
  - Expected outcomes at each step
  - Verification instructions
  - Next steps

Example Titles:
  - "Build Your First App"
  - "Getting Started in 5 Minutes"
  - "Tutorial: Creating a REST API"
```

### 2. How-To Guides (Task-Oriented)

```yaml
Purpose: Guide user through steps to solve a real-world problem
Audience: Users with specific goals
Style: Direct, practical, action-focused

Structure:
  - Problem statement
  - Quick solution overview
  - Step-by-step instructions
  - Variations and options
  - Related guides

Example Titles:
  - "How to Configure Authentication"
  - "Migrating from v1 to v2"
  - "Deploying to Production"
```

### 3. Reference (Information-Oriented)

```yaml
Purpose: Describe the machinery, accurate and complete
Audience: Users looking up specific information
Style: Dry, consistent, structured

Structure:
  - Alphabetical or logical ordering
  - Consistent format for each item
  - Type information
  - Default values
  - Examples

Example Titles:
  - "API Reference"
  - "Configuration Options"
  - "CLI Commands"
```

### 4. Explanation (Understanding-Oriented)

```yaml
Purpose: Explain concepts, give background and context
Audience: Users wanting deeper understanding
Style: Discursive, exploratory, illuminating

Structure:
  - Context and background
  - Concepts and principles
  - Alternatives and comparisons
  - Historical context if relevant

Example Titles:
  - "Understanding the Architecture"
  - "How Authentication Works"
  - "Design Decisions"
```

## Writing Guidelines

### Clarity Principles

| Principle       | Description                   | Example                                |
| --------------- | ----------------------------- | -------------------------------------- |
| Active voice    | Use active instead of passive | "Run the command" not "Command is run" |
| Concrete words  | Be specific, not vague        | "3 files" not "several files"          |
| Short sentences | Keep sentences under 25 words | Split long sentences                   |
| One idea        | One main idea per paragraph   | Use lists for multiple items           |
| Present tense   | Write in present tense        | "Returns" not "Will return"            |

### Code Examples Best Practices

```yaml
Guidelines:
  - Show complete, working examples
  - Include imports and setup
  - Add comments explaining non-obvious parts
  - Use realistic data, not "foo" and "bar"
  - Show expected output
  - Handle errors in examples

Example Structure:
  # Context comment
  import { something } from 'package';

  // Setup (if needed)
  const config = { ... };

  // Main example
  const result = something(config);

  // Expected output
  // { success: true, data: [...] }
```

### Accessibility Checklist

```yaml
Content:
  - Use descriptive headings (H1 -> H2 -> H3)
  - Add alt text to images
  - Use descriptive link text (not "click here")
  - Provide text alternatives for visual content

Code:
  - Use syntax highlighting
  - Don't rely on color alone to convey meaning
  - Add descriptive labels to code blocks

Structure:
  - Use proper semantic HTML
  - Include skip links for long pages
  - Ensure keyboard navigation works
  - Test with screen readers
```

## Documentation Workflows

### README Creation

```yaml
Goal: Create comprehensive README for project

Steps:
  1. Research:
     mcp__github__search_code("## Installation ## Usage filename:README.md stars:>1000")
     mcp__tavily__tavily-search("README best practices 2025")

  2. Analyze Project:
     - Read main entry points
     - Identify key features
     - Find configuration options
     - Check existing documentation

  3. Plan Structure:
     Use mcp__sequential-thinking__sequentialthinking:
     - What does this project do?
     - Who is the target audience?
     - What are the key features?
     - How do users install and use it?

  4. Write:
     - Project description and badges
     - Features list
     - Installation instructions
     - Quick start guide
     - API reference
     - Contributing guidelines

Output:
  - README.md with standard structure
  - Badges for build status, version, license
```

### API Documentation

```yaml
Goal: Document REST/GraphQL API endpoints

Steps:
  1. Research: mcp__context7__resolve-library-id("openapi")
    mcp__context7__get-library-docs(libraryId, "paths components schemas")

  2. Analyze API:
    - Read route handlers
    - Identify request/response schemas
    - Map authentication requirements
    - Find error responses

  3. Write:
    - Endpoint description
    - Request headers, params, body
    - Response codes and schemas
    - Working curl/code examples
    - Error handling
```

### JSDoc/TSDoc Comments

```yaml
Goal: Add documentation to code

Steps:
  1. Research:
     mcp__context7__resolve-library-id("jsdoc")
     mcp__context7__get-library-docs(libraryId, "@param @returns @example")

  2. Analyze Code:
     - Read exported functions/classes
     - Identify parameters and return types
     - Find usage patterns for examples

  3. Write Comments:
     - Function description
     - @param for each parameter
     - @returns with description
     - @throws for errors
     - @example with working code
```
