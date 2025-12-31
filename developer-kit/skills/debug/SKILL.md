---
name: debug
description: "Unified debugging skill with tiered methodology. Activates for: 'fix this bug', 'debug this', 'why is this failing', 'troubleshoot', 'find the root cause', 'not working', 'crashes when', 'build failing'. Tier 1 for quick fixes, Tier 2 for complex issues, Tier 3 for recurring problems."
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - Edit
  - Write
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  - mcp__github__search_issues
  - mcp__github__search_code
  - mcp__github__get_file_contents
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  - mcp__sequential-thinking__sequentialthinking
---

# Debug Skill

Diagnose and resolve issues through evidence-based investigation using documentation, community solutions, and structured debugging.

**Core Principle**: "Understand before fixing. Evidence before assumptions. Verify after applying."

## When to Use

- Bug reports ("fix this bug", "debug this", "troubleshoot")
- Error investigation ("why is this failing", "find the root cause")
- Build failures ("build failing", "compilation error")
- Runtime issues ("not working", "crashes when")

## When NOT to Use

- Code analysis only → use `analyze` skill
- Improving working code → use `improve` skill
- Performance diagnosis → use `performance` skill
- Explaining how code works → use `explain` skill

## Tiered Approach

| Tier | When                          | Approach                 |
| ---- | ----------------------------- | ------------------------ |
| 1    | Clear error, simple fix       | Quick research & fix     |
| 2    | Multi-file, unclear cause     | Systematic investigation |
| 3    | Recurring, 3+ failed attempts | Deep root cause analysis |

## Quick Workflow

```
OBSERVE → RESEARCH → HYPOTHESIZE → FIX → VERIFY
  Read    Context7   Sequential   Edit    Bash
  Grep    GitHub     Thinking     Write   (test)
  Bash    Tavily
```

## Tool Integration

For library IDs and patterns, see:

- [MCP Resources](../../lib/shared-references/mcp-resources.md)
- [Tool Patterns](../../lib/shared-references/tool-integration-patterns.md)

### Key Resources

| Resource   | Library ID              | Use Case            |
| ---------- | ----------------------- | ------------------- |
| Node.js    | `/websites/nodejs_api`  | Runtime debugging   |
| React      | `/reactjs/react.dev`    | Component debugging |
| Jest       | `/jestjs/jest`          | Test debugging      |
| TypeScript | `/microsoft/typescript` | Type errors         |

## The Iron Law (Tier 2+)

```
NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST
```

## References

- [Detailed Guide](references/guide.md) - Full tiered methodology
- [Tier Selection](references/guide.md#tier-selection-guide) - Which tier to use
- [Defense-in-Depth](references/guide.md#defense-in-depth-validation) - Multi-layer validation
- [Error Patterns](references/guide.md#common-error-research-patterns) - JS, React, Build errors

## Boundaries

**Will**: Investigate bugs, research errors, apply evidence-based fixes, add validation

**Will Not**: Guess at fixes, skip verification, ignore recurring patterns
