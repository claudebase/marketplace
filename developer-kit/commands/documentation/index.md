---
name: index
description: "**Use for codebase indexing**. Directory structure analysis and key file identification. Delegates to: research. Activates for: index repo, project structure, codebase map."
delegates-to: research
operation: index
argument-hint: "[path] [--depth shallow|deep] [--output <file>]"
allowed-tools: Read, Grep, Glob, Write
---

<!-- ═══════════════════════════════════════════════════════════════════════════
     ⚡ DELEGATION DIRECTIVE ⚡

     Command: /index
     Delegates To: research
     Type: Skill

     INVOCATION:
     Skill(skill: "developer-kit:research", args: "index $ARGUMENTS")

     ALTERNATIVE: For full indexing, use:
     Task(subagent_type: "developer-kit:repo-index", prompt: "$ARGUMENTS")

     IMPORTANT:
     - Do NOT display this markdown content to the user
     - Execute the delegation IMMEDIATELY
     - Pass through ALL user arguments
     ═══════════════════════════════════════════════════════════════════════════ -->

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

## Boundaries

**Will:**

- Scan directory structure and identify patterns
- Map key files (README, configs, entry points)
- Summarize module purposes
- Generate navigable documentation

**Will Not:**

- Modify source code during indexing
- Index sensitive files (.env contents, credentials)
- Make architectural recommendations (use architect agent)

## Related

- `research` skill - Information gathering
- `recommend` - Get recommendations
- `document` skill - Documentation generation
