---
name: dk:index
description: Index and understand the codebase structure
delegates-to: research
operation: index
argument-hint: "[path] [--depth shallow|deep] [--output <file>]"
allowed-tools: Read, Grep, Glob, Write
---

Execute the **research** skill in codebase indexing mode.

## Delegation

This command delegates to the `research` skill which provides:

- Directory structure scanning
- Key file identification (README, configs, entry points)
- Dependency mapping
- Module purpose summarization

## Parameters

| Parameter  | Description                                                  |
| ---------- | ------------------------------------------------------------ |
| `path`     | Directory to index (default: current directory)              |
| `--depth`  | Analysis depth: shallow (structure) or deep (with summaries) |
| `--output` | Save index to file (default: stdout)                         |
| `--type`   | Focus: docs, api, structure, or all                          |

## Indexing Methodology

The research skill:

1. **Scan Structure**: Map directory tree and file patterns
2. **Identify Key Files**: README, package.json, configs, entry points
3. **Map Dependencies**: Parse imports and package dependencies
4. **Summarize Modules**: Brief description of each component's purpose
5. **Create Index**: Generate navigable documentation

## Output Format

```markdown
# Project Index: [Project Name]

## Overview

[Brief project description from README]

## Structure
```

project/
├── src/
│ ├── components/ # UI components
│ ├── services/ # Business logic
│ └── utils/ # Helper functions
├── tests/
└── docs/

```

## Key Files
| File | Purpose |
|------|---------|
| src/index.ts | Application entry point |
| src/config.ts | Configuration management |

## Dependencies
- **Runtime**: react, express, ...
- **Development**: jest, typescript, ...

## Entry Points
- `src/index.ts` - Main application
- `src/cli.ts` - CLI interface
```

## Examples

```bash
index                              # Index current directory
index src/ --depth deep            # Deep analysis of src
index --output docs/INDEX.md       # Save to file
index --type api                   # Focus on API structure
```

## Related

- `research` skill - Information gathering
- `recommend` - Get recommendations
- `document` skill - Documentation generation
