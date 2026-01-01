---
name: changelog
description: "**Use for changelog generation**. Parse git history and generate formatted changelog. Delegates to: document. Activates for: generate changelog, release notes, version history."
delegates-to: document
operation: changelog
argument-hint: "[--since <tag|date>] [--format keep-a-changelog|conventional]"
allowed-tools: Read, Write, Bash, Grep
---

<!-- ═══════════════════════════════════════════════════════════════════════════
     ⚡ DELEGATION DIRECTIVE ⚡

     Command: /changelog
     Delegates To: document
     Type: Skill

     INVOCATION:
     Skill(skill: "developer-kit:document", args: "changelog $ARGUMENTS")

     IMPORTANT:
     - Do NOT display this markdown content to the user
     - Execute the delegation IMMEDIATELY
     - Pass through ALL user arguments
     ═══════════════════════════════════════════════════════════════════════════ -->

Execute the **document** skill in changelog mode.

## Delegation

This command delegates to the `document` skill which provides:

- Git history analysis and commit parsing
- Conventional commit categorization
- Keep-a-Changelog or Conventional format output
- Breaking change extraction and highlighting

## Parameters

| Parameter  | Description                                               |
| ---------- | --------------------------------------------------------- |
| `--since`  | Starting point (tag name, date, or commit)                |
| `--format` | Output format: keep-a-changelog (default) or conventional |
| `--output` | Output file path (default: CHANGELOG.md)                  |

## Conventional Commit Types

| Type       | Section       | Included |
| ---------- | ------------- | -------- |
| `feat`     | Added         | Yes      |
| `fix`      | Fixed         | Yes      |
| `perf`     | Performance   | Yes      |
| `refactor` | Changed       | Yes      |
| `docs`     | Documentation | Yes      |
| `revert`   | Reverted      | Yes      |
| `style`    | -             | No       |
| `test`     | -             | No       |
| `chore`    | -             | No       |
| `ci`       | -             | No       |

## Output Formats

### Keep a Changelog (default)

```markdown
## [Unreleased]

### Added

- New OAuth2 authentication support (#123)

### Fixed

- Handle null response from external service (#124)

### Changed

- Simplified error handling logic
```

### Conventional Changelog

```markdown
## [1.1.0](compare-url) (2025-01-15)

### Features

- **auth:** add OAuth2 support ([#123](issue-url))

### Bug Fixes

- **api:** handle null response ([#124](issue-url))
```

## Examples

```bash
changelog                          # Since last tag
changelog --since v2.0.0           # Since specific tag
changelog --since 2025-01-01       # Since date
changelog --format conventional    # Conventional format
```

## Boundaries

**Will:**

- Parse git history for conventional commits
- Categorize changes (Added, Changed, Fixed, etc.)
- Generate Keep-a-Changelog or Conventional format
- Extract breaking changes and highlight them

**Will Not:**

- Modify existing changelog entries
- Generate entries for non-conventional commits without parsing
- Commit or push the changelog automatically

## Related

- `document` skill - Documentation generation
- `release` - Full release workflow
- `git` - Git operations
