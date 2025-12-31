---
name: devops
description: "MUST USE for build, test, and git workflows. Triggers: 'build', 'compile', 'git', 'commit', 'CI/CD', 'pipeline', 'deploy', 'cleanup', 'dead code', 'lint'. Provides structured DevOps workflows with proper sequencing. DO NOT run ad-hoc build/git commands - this skill ensures consistent workflows and proper commit messages."
composable: true
mode: read-write
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - Edit
  - Write
  - TodoWrite
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  - mcp__tavily__tavily-search
  - mcp__sequential-thinking__sequentialthinking
  - mcp__playwright__browser_navigate
  - mcp__playwright__browser_snapshot
  - mcp__github__create_pull_request
  - mcp__github__list_commits
  - mcp__github__search_code
---

# DevOps Skill

Unified skill for build, test, git, and cleanup operations with CI/CD support.

**Core Principle**: "Automate the repeatable. Monitor the critical. Ship with confidence."

## When to Use

- Build operations ("build project", "compile", "package")
- Test operations ("run tests", "test coverage", "e2e tests")
- Git operations ("commit", "git status", "create PR")
- Cleanup ("remove dead code", "cleanup imports", "prune")
- CI/CD ("GitHub Actions", "pipeline", "deploy")

## When NOT to Use

- Container orchestration → use `containers` skill
- Infrastructure provisioning → use external tools
- Security scanning → use `security` skill

## Operations

### Build

```bash
npm run build / yarn build / pnpm build
go build / cargo build / poetry build
```

### Test

```bash
npm test / pytest / go test / cargo test
```

### Git

```bash
git status / git add / git commit / git push
gh pr create / gh pr view
```

### Cleanup

```bash
# Find unused exports, dead code, stale deps
```

## Tool Integration

For library IDs and patterns, see:

- [MCP Resources](../../lib/shared-references/mcp-resources.md)
- [Tool Patterns](../../lib/shared-references/tool-integration-patterns.md)

### Key Resources

| Resource       | Library ID                     | Use Case       |
| -------------- | ------------------------------ | -------------- |
| GitHub Actions | `/websites/docs_github_com_en` | CI/CD          |
| Jest           | `/jestjs/jest`                 | JS testing     |
| Pytest         | `/pytest-dev/pytest`           | Python testing |

## References

- [Build Patterns](references/build-patterns.md) - Build configurations
- [Test Patterns](references/test-patterns.md) - Testing strategies
- [Git Patterns](references/git-patterns.md) - Git workflows
- [Cleanup Patterns](references/cleanup-patterns.md) - Dead code removal
- [GitHub Actions](references/github-actions.md) - CI/CD workflows

## Boundaries

**Will**: Build projects, run tests, execute git operations, cleanup code, configure CI/CD

**Will Not**: Design container orchestration, provision infrastructure, perform security audits
