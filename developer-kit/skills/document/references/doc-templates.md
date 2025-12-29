# Documentation Templates

## README Template

```markdown
# Project Name

Brief description of what this project does.

## Features

- Feature 1
- Feature 2
- Feature 3

## Installation

\`\`\`bash
npm install project-name
\`\`\`

## Quick Start

\`\`\`javascript
import { something } from 'project-name';

// Basic usage example
const result = something();
\`\`\`

## API Reference

### `functionName(param1, param2)`

Description of what the function does.

**Parameters:**
- `param1` (type): Description
- `param2` (type): Description

**Returns:** Description of return value

**Example:**
\`\`\`javascript
const result = functionName('value1', 'value2');
\`\`\`

## Configuration

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| option1 | string | 'default' | Description |
| option2 | boolean | false | Description |

## Contributing

Instructions for contributing.

## License

MIT
```

## Component Documentation Template

```markdown
# ComponentName

Brief description of the component.

## Props

| Prop | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| prop1 | string | Yes | - | Description |
| prop2 | boolean | No | false | Description |

## Usage

### Basic Usage

\`\`\`jsx
<ComponentName prop1="value" />
\`\`\`

### With All Props

\`\`\`jsx
<ComponentName
  prop1="value"
  prop2={true}
  onEvent={handleEvent}
/>
\`\`\`

## Examples

### Example 1: Common Use Case

\`\`\`jsx
// Description of this example
<ComponentName prop1="example" />
\`\`\`

## Styling

How to customize the component's appearance.

## Accessibility

Accessibility considerations and ARIA attributes.

## Related Components

- [RelatedComponent1](./RelatedComponent1.md)
- [RelatedComponent2](./RelatedComponent2.md)
```

## API Endpoint Documentation Template

```markdown
# Endpoint Name

## Overview

Brief description of what this endpoint does.

## Request

\`\`\`
METHOD /api/path/:param
\`\`\`

### Headers

| Header | Required | Description |
|--------|----------|-------------|
| Authorization | Yes | Bearer token |
| Content-Type | Yes | application/json |

### Path Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| param | string | Description |

### Query Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| page | number | No | 1 | Page number |
| limit | number | No | 20 | Items per page |

### Request Body

\`\`\`json
{
  "field1": "string",
  "field2": 123
}
\`\`\`

## Response

### Success (200)

\`\`\`json
{
  "data": {
    "id": "123",
    "field1": "value"
  }
}
\`\`\`

### Error Responses

| Status | Description |
|--------|-------------|
| 400 | Bad request - invalid parameters |
| 401 | Unauthorized - invalid token |
| 404 | Not found |
| 500 | Server error |

## Example

\`\`\`bash
curl -X POST https://api.example.com/endpoint \
  -H "Authorization: Bearer token" \
  -H "Content-Type: application/json" \
  -d '{"field1": "value"}'
\`\`\`
```

## Changelog Template

```markdown
# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

### Added
- New feature description

### Changed
- Change description

### Fixed
- Bug fix description

## [1.0.0] - YYYY-MM-DD

### Added
- Initial release features
```
