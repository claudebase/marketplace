---
name: document
description: "Create documentation artifacts (README, API docs, JSDoc/docstrings, guides). This skill should be used when the user asks to 'document this', 'create API docs', 'generate README', or 'add documentation'. Also use when user mentions writing JSDoc, adding docstrings, or creating guides. For explanations, use explain skill; for professional writing, use technical-writer agent."
composable: true
mode: read-write
allowed-tools:
  # Core Analysis
  - Read
  - Grep
  - Glob
  # Documentation Generation
  - Write
  - Edit
  # Documentation Standards
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  # Pattern Research
  - mcp__github__search_code
  - mcp__github__get_file_contents
  # Best Practices Research
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  # Structured Planning
  - mcp__sequential-thinking__sequentialthinking
---

# Documentation Generation Skill

Generate focused, high-quality documentation for code components, APIs, and features using official documentation standards and industry best practices.

**Core Principle**: "Good documentation is written for the reader, not the writer."

**Key Enhancement**: Research documentation patterns and standards before generating content.

**Key Distinction**: This skill CREATES documentation artifacts. For explanations without creating files, use the `explain` skill. For professional technical writing, use the `technical-writer` agent.

## Activation Triggers

- Documentation creation ("document this", "add documentation")
- README generation ("generate README", "create README")
- API documentation ("create API docs", "document endpoints")
- Code comments ("write JSDoc", "add docstrings", "add comments")
- Guides ("create guide", "write tutorial", "getting started")

## Do NOT Activate When

- User wants to understand code → use `explain` skill
- User wants code analysis → use `analyze` skill
- User wants to design systems → use `design` skill
- User needs professional tech writing → use `technical-writer` agent

**Boundary Clarification:**
This skill generates documentation artifacts (files). For educational explanations in conversation, use the `explain` skill. For comprehensive technical documentation projects, use the `technical-writer` agent.

## Behavioral Flow

```
┌──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
│   ANALYZE    │   RESEARCH   │    PLAN      │   GENERATE   │   INTEGRATE  │
├──────────────┼──────────────┼──────────────┼──────────────┼──────────────┤
│ Read target  │ Lookup       │ Structure    │ Write        │ Ensure       │
│ code to      │ documentation│ content      │ documentation│ consistency  │
│ understand   │ standards    │ outline      │ artifacts    │ with project │
│              │              │              │              │              │
│ Identify     │ Find         │ Identify     │ Apply        │ Add cross    │
│ public API   │ patterns     │ audience     │ appropriate  │ references   │
│ and exports  │ and examples │ and purpose  │ format       │              │
│              │              │              │              │              │
│ Map          │ Research     │ Define       │ Include      │ Validate     │
│ dependencies │ best         │ sections     │ examples     │ completeness │
│              │ practices    │              │              │              │
└──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘
     Read           Context7      Sequential      Write          Read
     Grep           GitHub        Thinking        Edit           Grep
                    Tavily
```

### Phase 1: ANALYZE

Understand the code to be documented:

1. **Read the code** - Understand functions, classes, exports
2. **Identify public API** - What needs to be documented for users
3. **Map dependencies** - External libraries, internal modules
4. **Check existing docs** - Current documentation style and gaps

```bash
# Find existing documentation
find . -name "README*" -o -name "*.md" | head -10

# Check for JSDoc/TSDoc comments
grep -r "@param\|@returns\|@example" --include="*.ts" src/ | head -10

# Find exported functions/classes
grep -r "^export" --include="*.ts" src/ | head -20
```

**Tools**: Read, Grep, Glob

### Phase 2: RESEARCH

Gather documentation standards and patterns:

```
# Lookup JSDoc syntax
mcp__context7__resolve-library-id → "/jsdoc/jsdoc.github.io"
mcp__context7__query-docs("@param @returns @example syntax")

# Lookup TypeDoc configuration
mcp__context7__resolve-library-id → "/typestrong/typedoc"
mcp__context7__query-docs("configuration options output formats")

# Lookup TSDoc specification
mcp__context7__resolve-library-id → "/microsoft/tsdoc"
mcp__context7__query-docs("standard tags modifier tags")

# Find README patterns in popular projects
mcp__github__search_code("badge installation usage filename:README.md stars:>1000")

# Research documentation best practices
mcp__tavily__tavily-search("README best practices 2024 open source")
```

**Tools**: Context7, GitHub MCP, Tavily

### Phase 3: PLAN

Structure the documentation content:

```
mcp__sequential-thinking__sequentialthinking
- Who is the audience (developers, users, contributors)?
- What's the purpose (reference, tutorial, guide)?
- What sections are needed?
- What examples would be most helpful?
- What's the appropriate level of detail?
```

**Documentation Structure:**

| Doc Type | Audience   | Purpose          | Key Sections                |
| -------- | ---------- | ---------------- | --------------------------- |
| README   | All        | First impression | Intro, Install, Usage, API  |
| API Docs | Developers | Reference        | Endpoints, Params, Examples |
| JSDoc    | Developers | Inline reference | Params, Returns, Examples   |
| Guide    | Users      | Learning         | Steps, Explanations, Tips   |

**Tools**: Sequential Thinking

### Phase 4: GENERATE

Write the documentation artifacts:

- Apply consistent formatting and style
- Include practical examples
- Add code snippets with syntax highlighting
- Ensure accuracy matches code behavior

**Tools**: Write, Edit

### Phase 5: INTEGRATE

Ensure consistency with the project:

- Cross-reference related documentation
- Link to related files and sections
- Validate examples work correctly
- Check for broken links

**Tools**: Read, Grep

## MCP Integration

### Context7 (Official Documentation)

**Primary source for documentation tool standards:**

```
mcp__context7__resolve-library-id - Resolve JSDoc, TypeDoc, Docusaurus IDs
mcp__context7__query-docs - Get official documentation standards
```

**Available Resources:**

| Resource   | Library ID               | Snippets |
| ---------- | ------------------------ | -------- |
| JSDoc      | `/jsdoc/jsdoc.github.io` | 197      |
| TypeDoc    | `/typestrong/typedoc`    | 431      |
| TSDoc      | `/microsoft/tsdoc`       | 107      |
| Docusaurus | `/facebook/docusaurus`   | 11,402   |
| VitePress  | `/vuejs/vitepress`       | 647      |
| Storybook  | `/storybookjs/storybook` | 2,914    |

**Use cases:**

- "JSDoc @param @returns syntax"
- "TypeDoc configuration options"
- "TSDoc standard tags"
- "Docusaurus markdown features"
- "VitePress frontmatter options"
- "Storybook documentation addon"

### GitHub MCP (Pattern Research)

**Find documentation patterns in production codebases:**

```
mcp__github__search_code - Find documentation patterns
mcp__github__get_file_contents - Get specific documentation files
```

**Search patterns:**

```
# Find well-structured READMEs
"## Installation" "## Usage" "## API" filename:README.md stars:>1000

# Find JSDoc patterns
"@param" "@returns" "@example" "@throws" filename:.ts stars:>500

# Find API documentation patterns
"## Endpoints" "### Request" "### Response" filename:.md

# Find CHANGELOG patterns
"## [Unreleased]" "### Added" "### Changed" filename:CHANGELOG.md

# Find CONTRIBUTING guides
"## How to Contribute" "Pull Request" filename:CONTRIBUTING.md
```

**Use cases:**

- Find how popular projects structure READMEs
- Research JSDoc documentation patterns
- Get API documentation examples
- Study CHANGELOG formats

### Tavily (Best Practices Research)

**Research current documentation standards:**

```
mcp__tavily__tavily-search - Research documentation practices
mcp__tavily__tavily-extract - Extract from documentation guides
```

**Use cases:**

- "README best practices 2024"
- "API documentation standards OpenAPI"
- "Developer documentation writing guide"
- "Technical writing for software documentation"
- "Documentation-driven development"
- "JSDoc vs TSDoc comparison"

### Sequential Thinking (Structured Planning)

**Systematic documentation planning:**

```
mcp__sequential-thinking__sequentialthinking - Multi-step documentation planning
```

**Use for:**

- Audience and purpose analysis
- Content structure planning
- Section prioritization
- Example selection
- Consistency verification

## Documentation Types

### 1. Inline Documentation (JSDoc/TSDoc)

**Standard JSDoc Tags:**

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

**TSDoc Tags:**

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

### 2. README Files

**Standard Structure:**

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

### 3. API Documentation

**REST API Format:**

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
```

### 4. Component Documentation

**React Component:**

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
```

## Documentation Best Practices

### Content Guidelines

| Principle    | Description                       |
| ------------ | --------------------------------- |
| Clarity      | Use simple language, avoid jargon |
| Completeness | Cover all public APIs             |
| Accuracy     | Keep in sync with code            |
| Examples     | Include working code snippets     |
| Scannability | Use headings, tables, lists       |

### Writing Tips

1. **Start with the "why"** - Explain purpose before details
2. **Show, don't just tell** - Include examples
3. **Be concise** - Respect reader's time
4. **Use active voice** - "Returns the user" not "The user is returned"
5. **Keep updated** - Outdated docs are worse than no docs

### Common Mistakes

```javascript
// ❌ Bad: Too vague
/**
 * Processes the data.
 */
function process(data) {}

// ✅ Good: Specific and helpful
/**
 * Validates and transforms user input into a normalized format.
 *
 * @param {UserInput} data - Raw user input from the form
 * @returns {NormalizedData} Validated and normalized data
 * @throws {ValidationError} If required fields are missing
 */
function process(data) {}
```

## Output Format

```markdown
## Documentation Summary

### Files Created/Updated

| File        | Type     | Status  |
| ----------- | -------- | ------- |
| README.md   | README   | Created |
| src/auth.ts | JSDoc    | Updated |
| docs/api.md | API Docs | Created |

### Coverage

| Area               | Before | After |
| ------------------ | ------ | ----- |
| Exported functions | 3/10   | 10/10 |
| Public classes     | 1/3    | 3/3   |
| API endpoints      | 0/5    | 5/5   |

### Research Applied

- JSDoc syntax: Official JSDoc documentation
- README structure: Based on popular open-source patterns
- API format: OpenAPI-inspired markdown

### Next Steps

1. Add more usage examples
2. Create getting started guide
3. Set up documentation site with Docusaurus
```

## Reference Files

For detailed templates and patterns, see:

- `references/doc-templates.md` - Documentation templates
- `references/jsdoc-patterns.md` - JSDoc/TSDoc patterns
- `references/readme-checklist.md` - README quality checklist
- `references/api-doc-guide.md` - API documentation guide

## Handoffs

| Scenario                       | Hand off to              |
| ------------------------------ | ------------------------ |
| Need code explanation          | `explain` skill          |
| Need professional tech writing | `technical-writer` agent |
| Need API design                | `design` skill           |
| Need code analysis             | `analyze` skill          |
| Need documentation site setup  | `devops` skill           |

## Boundaries

**Will:**

- Generate README files with proper structure
- Write JSDoc/TSDoc comments for functions and classes
- Create API documentation in markdown
- Document component props and usage
- Research documentation patterns via MCP tools
- Apply consistent formatting and style

**Will Not:**

- Explain code without creating files (use `explain` skill)
- Create comprehensive documentation sites (use `technical-writer` agent)
- Design API specifications (use `design` skill)
- Analyze code quality (use `analyze` skill)
- Set up documentation infrastructure (use `devops` skill)
