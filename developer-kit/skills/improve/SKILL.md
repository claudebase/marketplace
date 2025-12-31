---
name: improve
description: "MUST USE for code improvements on WORKING code. Triggers: 'improve', 'optimize', 'refactor', 'make better', 'clean up', 'simplify', 'reduce complexity', 'best practices', 'modernize'. Provides systematic improvement methodology. DO NOT make ad-hoc changes - this skill ensures measurable improvements. For BROKEN code, use debug skill."
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - Edit
  - Write
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  - mcp__github__search_code
  - mcp__github__get_file_contents
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  - mcp__sequential-thinking__sequentialthinking
composable: true
mode: read-write
---

# Improve Skill

Apply systematic improvements to code quality, performance, and maintainability through evidence-based refactoring.

**Core Principle**: "Enhance incrementally, verify continuously. Never break working code."

**Key Distinction**: Enhances WORKING code. For broken code use `debug`. For analysis only use `analyze`.

## When to Use

- Code improvement ("improve this code", "make this better")
- Refactoring ("refactor this", "clean up code")
- Optimization ("optimize this", "enhance performance")
- Quality enhancement ("reduce complexity", "apply best practices")

## When NOT to Use

- Code is broken → use `debug` skill
- Analysis only → use `analyze` skill
- Performance profiling → use `performance` skill
- Security fixes → use `security-expert` agent

## Quick Workflow

```
ANALYZE → RESEARCH → PLAN → APPLY → VERIFY
  Read    Context7  Sequential  Edit    Bash
  Grep    GitHub    Thinking    Write   (test)
          Tavily
```

1. **Analyze** - Identify improvement opportunities
2. **Research** - Lookup refactoring patterns, clean code principles
3. **Plan** - Prioritize by impact, plan safe sequence
4. **Apply** - Make incremental changes
5. **Verify** - Run tests, confirm no regressions

## Tool Integration

For library IDs and patterns, see:

- [MCP Resources](../../lib/shared-references/mcp-resources.md)
- [Tool Patterns](../../lib/shared-references/tool-integration-patterns.md)

### Key Resources

| Resource         | Library ID                                   | Use Case             |
| ---------------- | -------------------------------------------- | -------------------- |
| Refactoring.Guru | `/websites/refactoring_guru`                 | Refactoring patterns |
| Clean Code TS    | `/labs42io/clean-code-typescript`            | Best practices       |
| Design Patterns  | `/websites/refactoring_guru-design-patterns` | Architecture         |
| Code Smells      | `/websites/refactoring_guru_smells`          | Smell detection      |

## Golden Rules

1. **Working code first** - Never break functionality
2. **Small steps** - One refactoring at a time
3. **Test after each change** - Verify continuously
4. **Preserve behavior** - Same inputs → same outputs

## References

- [Detailed Guide](references/guide.md) - Full workflow and phases
- [Code Smells](references/guide.md#1-code-quality---code-smells-and-fixes) - Smell catalog with fixes
- [Safe Refactoring](references/guide.md#safe-refactoring-principles) - Golden rules
- [Refactoring Catalog](references/guide.md#refactoring-catalog) - Pattern reference

## Boundaries

**Will**: Apply refactoring patterns, research best practices, verify no regressions

**Will Not**: Fix broken code, skip verification, apply multiple changes at once
