# Document Skill - Detailed Guide

Complete behavioral flow for documentation generation.

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

## Phase 1: ANALYZE

Understand the code to be documented.

### Steps

1. **Read the code** - Understand functions, classes, exports
2. **Identify public API** - What needs to be documented for users
3. **Map dependencies** - External libraries, internal modules
4. **Check existing docs** - Current documentation style and gaps

### Commands

```bash
# Find existing documentation
find . -name "README*" -o -name "*.md" | head -10

# Check for JSDoc/TSDoc comments
grep -r "@param\|@returns\|@example" --include="*.ts" src/ | head -10

# Find exported functions/classes
grep -r "^export" --include="*.ts" src/ | head -20
```

**Tools**: Read, Grep, Glob

## Phase 2: RESEARCH

Gather documentation standards and patterns.

### MCP Tool Usage

```yaml
# Lookup JSDoc syntax
mcp__context7__query-docs("/jsdoc/jsdoc.github.io", "@param @returns @example")

# Lookup TypeDoc configuration
mcp__context7__query-docs("/typestrong/typedoc", "configuration options")

# Find README patterns in popular projects
mcp__github__search_code("badge installation usage filename:README.md stars:>1000")

# Research documentation best practices
mcp__tavily__tavily-search("README best practices 2024 open source")
```

**Tools**: Context7, GitHub MCP, Tavily

## Phase 3: PLAN

Structure the documentation content.

```yaml
mcp__sequential-thinking__sequentialthinking:
  - Who is the audience (developers, users, contributors)?
  - What's the purpose (reference, tutorial, guide)?
  - What sections are needed?
  - What examples would be most helpful?
```

### Documentation Types

| Doc Type | Audience   | Purpose          | Key Sections                |
| -------- | ---------- | ---------------- | --------------------------- |
| README   | All        | First impression | Intro, Install, Usage, API  |
| API Docs | Developers | Reference        | Endpoints, Params, Examples |
| JSDoc    | Developers | Inline reference | Params, Returns, Examples   |
| Guide    | Users      | Learning         | Steps, Explanations, Tips   |

**Tools**: Sequential Thinking

## Phase 4: GENERATE

Write the documentation artifacts:

- Apply consistent formatting and style
- Include practical examples
- Add code snippets with syntax highlighting
- Ensure accuracy matches code behavior

**Tools**: Write, Edit

## Phase 5: INTEGRATE

Ensure consistency with the project:

- Cross-reference related documentation
- Link to related files and sections
- Validate examples work correctly
- Check for broken links

**Tools**: Read, Grep

## MCP Resources

| Resource   | Library ID               | Use Case         |
| ---------- | ------------------------ | ---------------- |
| JSDoc      | `/jsdoc/jsdoc.github.io` | JS documentation |
| TypeDoc    | `/typestrong/typedoc`    | TS documentation |
| TSDoc      | `/microsoft/tsdoc`       | TS doc standard  |
| Docusaurus | `/facebook/docusaurus`   | Doc sites        |
| VitePress  | `/vuejs/vitepress`       | Vue doc sites    |

## Writing Best Practices

| Principle    | Description                       |
| ------------ | --------------------------------- |
| Clarity      | Use simple language, avoid jargon |
| Completeness | Cover all public APIs             |
| Accuracy     | Keep in sync with code            |
| Examples     | Include working code snippets     |
| Scannability | Use headings, tables, lists       |

## Related Skills

- `explain` skill - For explanations without creating files
- `technical-writer` agent - For comprehensive documentation projects
- `design` skill - For API design
- `analyze` skill - For code analysis
