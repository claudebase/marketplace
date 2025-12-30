# Contributing to Claude Code Plugin Marketplace

Thank you for your interest in contributing to the Claude Code Plugin Marketplace! This document provides guidelines and instructions for contributing.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Security](#security)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [How to Contribute](#how-to-contribute)
- [Plugin Development Guidelines](#plugin-development-guidelines)
- [Testing](#testing)
- [Pull Request Process](#pull-request-process)
- [Style Guide](#style-guide)

## Code of Conduct

This project adheres to a Code of Conduct that all contributors are expected to follow. Please read [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) before contributing.

## Security

If you discover a security vulnerability, please follow our [Security Policy](SECURITY.md) for responsible disclosure. **Do not report security issues through public GitHub issues.**

## Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR-USERNAME/marketplace.git
   cd marketplace
   ```
3. **Add upstream remote**:
   ```bash
   git remote add upstream https://github.com/claudebase/marketplace.git
   ```

## Development Setup

### Prerequisites

- Git
- Python 3.8+ (for hook scripts)
- Bash (for validation scripts)
- Claude Code CLI installed

### Environment Setup

1. Install the Developer Kit plugin locally:
   ```bash
   claude plugin install ./developer-kit
   ```

2. Configure API keys in `~/.claude/settings.json`:
   ```json
   {
     "enabledPlugins": {
       "developer-kit@claudebase": true
     },
     "env": {
       "TAVILY_API_KEY": "your-key",
       "GITHUB_TOKEN": "your-token"
     }
   }
   ```

### Validation Scripts

Run validation before submitting:

```bash
# Full test suite (89+ tests)
./developer-kit/scripts/test-components.sh

# Quick validation
./developer-kit/scripts/validate-components.sh

# Individual checks
./developer-kit/scripts/validate-skill-descriptions.sh
./developer-kit/scripts/validate-agent-fields.sh
./developer-kit/scripts/validate-references.sh
./developer-kit/scripts/check-frontmatter.sh
```

## How to Contribute

### Reporting Bugs

1. **Check existing issues** to avoid duplicates
2. **[Create a bug report](.github/ISSUE_TEMPLATE/bug_report.yml)** - The template will guide you through providing:
   - Clear description of the bug
   - Steps to reproduce
   - Expected vs actual behavior
   - Environment details (OS, Claude Code version)
   - Relevant logs or screenshots

### Suggesting Features

1. **Check existing feature requests** to avoid duplicates
2. **[Create a feature request](.github/ISSUE_TEMPLATE/feature_request.yml)** - The template will guide you through describing:
   - The problem you're trying to solve
   - Your proposed solution
   - Alternative solutions considered
   - Use cases and benefits

### Improving Documentation

Found unclear or missing documentation?

1. **[Create a documentation issue](.github/ISSUE_TEMPLATE/documentation.yml)** - The template will help you specify what needs improvement

### Contributing Code

1. **Create a feature branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes** following our guidelines

3. **Test thoroughly**:
   ```bash
   ./developer-kit/scripts/test-components.sh
   ```

4. **Commit with clear messages**:
   ```bash
   git commit -m "Add: new feature description"
   ```

5. **Push to your fork**:
   ```bash
   git push origin feature/your-feature-name
   ```

6. **[Open a Pull Request](../../compare)** - The PR template will guide you through the submission process

## Plugin Development Guidelines

### Creating a New Plugin

1. **Directory structure**:
   ```
   my-plugin/
   ├── .claude-plugin/
   │   └── plugin.json
   ├── skills/
   │   └── my-skill/
   │       └── SKILL.md
   ├── agents/
   │   └── my-agent.md
   ├── commands/
   │   └── category/
   │       └── command.md
   └── .mcp.json (optional)
   ```

2. **Follow naming conventions**:
   - Skills: lowercase-with-hyphens
   - Agents: lowercase-with-hyphens
   - Commands: lowercase-with-hyphens

3. **Required frontmatter**:
   - Skills must include trigger phrases
   - Agents must specify tools and model
   - Commands must have clear descriptions

### Developer Kit Contributions

#### Adding a Skill

1. Create directory: `developer-kit/skills/skill-name/`
2. Add `SKILL.md` with frontmatter:
   ```yaml
   ---
   name: skill-name
   description: "Purpose. Activates for: 'trigger1', 'trigger2', 'trigger3'"
   allowed-tools:
     - Read
     - Grep
     - Glob
   ---
   ```
3. Add progressive documentation in `references/` subdirectory
4. Update `SKILLS.md` documentation
5. Add triggers to `TRIGGER-REFERENCE.md`

#### Adding an Agent

1. Create file: `developer-kit/agents/agent-name.md`
2. Add frontmatter:
   ```yaml
   ---
   name: agent-name
   description: "Purpose and when to invoke"
   tools: Read, Grep, Glob
   model: sonnet
   skills: related-skill1, related-skill2
   ---
   ```
3. Update `AGENTS.md` documentation

#### Adding a Command

1. Create file: `developer-kit/commands/category/command-name.md`
2. Add frontmatter:
   ```yaml
   ---
   description: "What this command does"
   delegates-to: skill-name
   operation: mode-name
   ---
   ```
3. Update `COMMANDS.md` documentation

### Critical Constraints

1. **Skills must use flat structure** - No nested `SKILL.md` files
2. **Agents must be flat files** - No subdirectories
3. **Include trigger phrases** - All skill descriptions need activation triggers
4. **No hardcoded secrets** - Use `${VAR}` syntax in .mcp.json
5. **Validate before committing** - Run test suite

## Testing

### Running Tests

```bash
# Full validation suite
./developer-kit/scripts/test-components.sh

# Expected output:
# ✓ 24 skills found
# ✓ 14 agents found
# ✓ 21 commands found
# ✓ All tests passed (89+)
```

### Test Checklist

- [ ] All frontmatter valid YAML
- [ ] Skill descriptions include triggers
- [ ] Agent required fields present
- [ ] Reference links resolve correctly
- [ ] No nested SKILL.md files
- [ ] Scripts executable
- [ ] JSON files valid
- [ ] Python syntax correct

### Manual Testing

1. Install plugin locally
2. Test skill activation with trigger phrases
3. Test command execution
4. Verify agent invocation
5. Check hook execution

## Pull Request Process

1. **Update documentation** for any changes
2. **Run full test suite** and ensure all tests pass
3. **Update version** in appropriate files if needed:
   - `.claude-plugin/plugin.json`
   - `CHANGELOG.md`
   - `hooks/hooks.json` (SessionStart message)
4. **Fill out PR template** completely
5. **Link related issues** using keywords (Fixes #123)
6. **Request review** from maintainers
7. **Address feedback** promptly
8. **Squash commits** if requested

### PR Requirements

- [ ] All tests pass
- [ ] Documentation updated
- [ ] CHANGELOG.md updated (if applicable)
- [ ] No breaking changes (or clearly marked)
- [ ] Code follows style guide
- [ ] Commits are clear and descriptive

## Style Guide

### Markdown

- Use ATX-style headers (`#` not `===`)
- One blank line between sections
- Code blocks with language specifiers
- Lists with `-` not `*`
- No trailing whitespace

### YAML Frontmatter

- Double quotes for descriptions
- Lowercase names with hyphens
- Consistent indentation (2 spaces)
- Array items on separate lines

### Python

- PEP 8 compliant
- Type hints where applicable
- Docstrings for functions
- No unused imports

### Bash

- Use `#!/usr/bin/env bash`
- Set error handling: `set -euo pipefail`
- Quote variables: `"$variable"`
- Comment complex logic

### Commit Messages

Format: `Type: Description`

Types:
- `Add:` New feature or component
- `Fix:` Bug fix
- `Update:` Changes to existing feature
- `Docs:` Documentation only
- `Test:` Test additions or changes
- `Refactor:` Code restructuring
- `Chore:` Maintenance tasks

Examples:
```
Add: sequential-thinking skill for structured reasoning
Fix: skill validation script handling nested directories
Update: architect agent with frontend expertise
Docs: add workflow guide for feature development
```

## Version Management

When releasing a new version:

1. Update version in `.claude-plugin/plugin.json`
2. Update `hooks/hooks.json` SessionStart message
3. Update `CHANGELOG.md` with changes
4. Update test expectations in `scripts/test-components.sh`
5. Tag release: `git tag -a v4.1.0 -m "Release v4.1.0"`

## Questions?

- Open an issue for questions about contributing
- Check existing issues and discussions
- Review documentation in `developer-kit/docs/`

## Recognition

Contributors will be recognized in:
- CHANGELOG.md for their contributions
- Git commit history
- Release notes

Thank you for contributing to Claude Code Plugin Marketplace!
