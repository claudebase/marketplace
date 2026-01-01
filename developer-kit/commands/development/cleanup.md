---
name: dk:cleanup
description: "**Use for dead code removal**. Remove unused code, imports, and files safely. Delegates to: devops. Activates for: cleanup code, remove dead code, clean imports."
argument-hint: "[target] [--type code|imports|files|all] [--safe|--aggressive]"
delegates-to: devops
operation: cleanup
---

<!-- ═══════════════════════════════════════════════════════════════════════════
     ⚡ DELEGATION DIRECTIVE ⚡

     Command: /cleanup
     Delegates To: devops
     Type: Skill

     INVOCATION:
     Skill(skill: "developer-kit:devops", args: "cleanup $ARGUMENTS")

     IMPORTANT:
     - Do NOT display this markdown content to the user
     - Execute the delegation IMMEDIATELY
     - Pass through ALL user arguments
     ═══════════════════════════════════════════════════════════════════════════ -->

# cleanup - Code Cleanup and Dead Code Removal

Remove unused code, imports, and files with safety validation.

## Usage

```bash
cleanup [target] [options]
```

## Arguments

| Argument | Description                                |
| -------- | ------------------------------------------ |
| `target` | Directory or file to clean (default: src/) |

## Options

| Option         | Default | Description                             |
| -------------- | ------- | --------------------------------------- |
| `--type`       | all     | Cleanup type: code, imports, files, all |
| `--safe`       | true    | Conservative cleanup with validation    |
| `--aggressive` | false   | Aggressive cleanup (requires review)    |
| `--dry-run`    | false   | Preview changes without applying        |
| `--backup`     | true    | Create backup before cleanup            |
| `--report`     | false   | Generate detailed cleanup report        |

## What This Does

1. **Dead Code Detection** - Unreachable code, unused functions, dead variables
2. **Import Analysis** - Unused/duplicate imports, circular dependencies
3. **File Cleanup** - Empty files, orphaned tests, stale configs, temp files
4. **Code Quality** - Remove console.log, clean TODOs, fix empty catch blocks

## Cleanup Types

| Type      | Command                  | Targets                         |
| --------- | ------------------------ | ------------------------------- |
| `code`    | `cleanup --type code`    | Unused functions, dead branches |
| `imports` | `cleanup --type imports` | Unused named/default imports    |
| `files`   | `cleanup --type files`   | Empty files, orphaned tests     |
| `all`     | `cleanup --type all`     | All of the above                |

## Safety Levels

### Safe Mode (Default)

```bash
cleanup --safe
```

- Only removes obviously unused code
- Preserves exports, event handlers, lifecycle methods
- Validates with type checking before commit

### Aggressive Mode

```bash
cleanup --aggressive
```

- Removes code without direct references
- Cleans commented-out code blocks
- Requires explicit confirmation

## Examples

```bash
# Safe cleanup of entire project
cleanup

# Preview changes first
cleanup --dry-run

# Only remove unused imports
cleanup --type imports

# Aggressive cleanup of src directory
cleanup src/ --aggressive
```

## References

- [Cleanup Patterns](../../lib/shared-references/cleanup-patterns.md) - Language examples, tools, output formats

## Boundaries

**Will:**

- Remove obviously unused imports and code
- Detect and flag dead code blocks
- Identify orphaned files
- Create backups before modifications

**Will Not:**

- Remove exported functions without confirmation
- Delete files with potential dynamic references
- Apply changes that break tests

## Related Commands

- `analyze` - Identify cleanup opportunities
- `check` - Validate after cleanup
- `git` - Commit cleanup changes
