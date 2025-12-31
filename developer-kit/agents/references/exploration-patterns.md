# Code Exploration Patterns

Reusable patterns for systematic codebase exploration.

## Pattern: Feature Implementation Trace

```yaml
Goal: Understand how a specific feature works end-to-end

Steps:
  1. Search for feature keywords
     - Grep for "login", "auth", "payment", etc.
     - Glob for related file names

  2. Identify entry point
     - API endpoint, UI event, CLI command

  3. Trace execution path (use sequential thinking)
     - Follow function calls
     - Note each transformation
     - Track to storage/output

  4. Document findings
     - Execution flow diagram
     - Key files with line numbers
     - Architecture insights

Output Template:
  ## Feature: [Name]

  ### Entry Point
  - File: `path/to/entry.ts:42`
  - Type: REST API / UI Event / CLI Command

  ### Execution Flow
  1. `entry.ts:42` → Receives request, validates input
  2. `service.ts:15` → Business logic processing
  3. `repository.ts:28` → Database operation
  4. `entry.ts:55` → Response formatting

  ### Key Components
  | Component | File | Responsibility |
  |-----------|------|----------------|
  | Controller | entry.ts | Request handling |
  | Service | service.ts | Business logic |
  | Repository | repository.ts | Data access |

  ### Architecture Insights
  - Pattern: [Repository pattern with DI]
  - Strengths: [Clean separation]
  - Concerns: [Missing error handling at line X]
```

## Pattern: Architecture Overview

```yaml
Goal: Understand overall codebase structure

Steps:
  1. Map directory structure
     - LS for top-level directories
     - Identify conventional folders

  2. Detect framework and patterns
     - mcp__context7__resolve-library-id
     - Compare against standard patterns

  3. Identify layers
     - Presentation, business, data
     - Cross-cutting concerns

  4. Document architecture
     - Layer diagram
     - Key abstractions
     - Integration points

Output Template:
  ## Architecture Overview

  ### Tech Stack
  - Framework: [Next.js 14]
  - Language: [TypeScript]
  - Database: [PostgreSQL + Prisma]

  ### Directory Structure
  src/
  ├── app/           # Next.js App Router
  ├── components/    # React components
  ├── lib/           # Shared utilities
  ├── services/      # Business logic
  └── db/            # Database layer

  ### Architectural Patterns
  - **Pattern**: [Clean Architecture]
  - **Data Flow**: [Unidirectional]
  - **State Management**: [React Context + Server State]

  ### Key Abstractions
  - `ServiceBase`: Common service interface
  - `Repository<T>`: Generic data access
  - `withAuth`: Authentication HOC
```

## Pattern: Dependency Investigation

```yaml
Goal: Understand what depends on a specific module

Steps:
  1. Find all imports of target module
     - Grep for import statements
     - Check re-exports

  2. Map dependency graph
     - Direct dependents
     - Transitive dependents

  3. Assess coupling
     - How tightly coupled?
     - Can it be changed safely?

Output Template:
  ## Dependency Analysis: [Module Name]

  ### Direct Dependents (5 files)
  - `src/api/users.ts:3` - imports UserService
  - `src/api/orders.ts:5` - imports UserService
  - ...

  ### Usage Patterns
  - Primary: User lookup for authorization
  - Secondary: Profile data retrieval

  ### Coupling Assessment
  - **Level**: Moderate
  - **Impact of Change**: Medium (5 files affected)
  - **Safe to Modify**: Yes, with interface stability
```

## Pattern: Remote Repository Exploration

```yaml
Goal: Explore a GitHub repository without cloning

Steps:
  1. Parse repository URL
     - Extract owner, repo from URL

  2. Get repository structure
     - mcp__github__get_file_contents(owner, repo, "/")
     - Map key directories

  3. Read key files
     - README.md for context
     - Main entry points
     - Configuration files

  4. Search for specific patterns
     - mcp__github__search_code("repo:owner/repo query")
     - Find implementations of interest

Output Template:
  ## Repository: [owner/repo]

  ### Overview
  - Description: [From README]
  - Tech Stack: [Detected]
  - Structure: [Conventional/Custom]

  ### Key Files Analyzed
  - `src/index.ts` - Entry point
  - `src/core/` - Core logic

  ### Patterns Found
  - [Pattern 1 with file references]
  - [Pattern 2 with file references]
```

## Output Structure Template

```markdown
## Exploration: [Topic/Feature]

### Summary

[One paragraph overview]

### Tech Stack

- Framework: [Detected framework]
- Language: [Primary language]
- Key Libraries: [Important dependencies]

### Entry Points

| Entry Point | File        | Type       |
| ----------- | ----------- | ---------- |
| [Name]      | `path:line` | API/UI/CLI |

### Execution Flow

1. `file.ts:42` → [Description of step]
2. `service.ts:15` → [Description of step]
3. ...

### Architecture

[Layer diagram or description]

### Key Components

| Component | File   | Responsibility |
| --------- | ------ | -------------- |
| [Name]    | `path` | [What it does] |

### Patterns Identified

- **[Pattern Name]**: [Where and how used]

### Dependencies

**Internal**: [List of internal modules used]
**External**: [List of external packages/APIs]

### Insights & Observations

- **Strengths**: [What's done well]
- **Concerns**: [Potential issues]
- **Opportunities**: [Possible improvements]

### Essential Files

[List of must-read files for understanding this feature]
```
