---
name: document
description: "Create documentation artifacts (README, API docs, JSDoc/docstrings, guides). For educational explanations without creating files, use 'explain' skill. For professional technical writing, use 'technical-writer' agent. Activates for: document this, create API docs, generate README, add documentation, write JSDoc, add docstrings."
allowed-tools:
  - Read
  - Grep
  - Glob
  - Write
  - Edit
  - mcp__context7__resolve-library-id
  - mcp__context7__get-library-docs
---

# Documentation Generation Skill

## Purpose

Generate focused, high-quality documentation for code components, APIs, and features. Create documentation artifacts that help developers understand and use code effectively.

**Key Distinction**: This skill CREATES documentation artifacts. For explanations without creating files, use the `explain` skill.

## When to Use

**Activate When:**
- User asks to "document" something
- User needs API documentation or README files
- User wants JSDoc, docstrings, or inline comments
- User requests technical guides or user documentation

**Do NOT Activate When:**
- User wants to understand code → use `explain` skill
- User wants code analysis → use `analyze` skill
- User wants to design systems → use `design` skill

## Documentation Types

### 1. Inline Documentation
- JSDoc comments for JavaScript/TypeScript
- Docstrings for Python
- XML docs for C#
- Inline comments for complex logic

### 2. API Documentation
- Endpoint documentation
- Request/response schemas
- Authentication details
- Usage examples

### 3. External Documentation
- README files
- Component documentation
- Integration guides
- Architecture overviews

### 4. User Guides
- Getting started guides
- Tutorial content
- How-to articles
- Troubleshooting guides

## Methodology

1. **Analyze**: Read target code to understand functionality
2. **Identify**: Determine documentation type and audience
3. **Generate**: Create appropriate documentation content
4. **Format**: Apply consistent structure and style
5. **Integrate**: Ensure compatibility with existing docs

## Output Formats

### JSDoc Example
```javascript
/**
 * Authenticates a user with the provided credentials.
 * @param {string} username - The user's username
 * @param {string} password - The user's password
 * @returns {Promise<AuthResult>} Authentication result with token
 * @throws {AuthError} If credentials are invalid
 * @example
 * const result = await authenticate('john', 'secret123');
 */
```

### API Doc Example
```markdown
## POST /api/auth/login

Authenticate a user and receive an access token.

### Request Body
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| username | string | Yes | User's username |
| password | string | Yes | User's password |

### Response
- `200`: Success with token
- `401`: Invalid credentials
```

## MCP Integration

**Use Context7 for framework-specific documentation patterns:**
```
mcp__context7__resolve-library-id - Resolve library names first
mcp__context7__get-library-docs - Fetch official documentation patterns
```
Context7 ensures documentation follows official framework conventions and best practices.

## Reference Files

For detailed templates and patterns, see:
- `references/doc-templates.md` - Documentation templates
- `references/jsdoc-patterns.md` - JSDoc/docstring patterns
