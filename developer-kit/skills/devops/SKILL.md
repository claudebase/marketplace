---
name: devops
description: "Handles build processes, git operations, CI/CD pipelines, deployments, and code cleanup workflows. Use when the user needs to build their project, commit changes, set up CI/CD, deploy, or clean up the codebase. Triggers on requests like 'build the project', 'set up CI/CD', 'help me commit this', 'deploy this', 'create a pipeline', 'clean up dead code', 'compile this', 'run the build', or 'set up GitHub Actions'. NOT for writing application code (use implement) or containerization (use containers)."
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

Build, test, git, and cleanup operations with CI/CD support.

## Quick Reference

**Activates**: build, compile, git, commit, CI/CD, pipeline, deploy, cleanup, dead code
**Mode**: read-write
**Output**: Executed commands with results, workflow configurations

## Workflow

```
BUILD → TEST → GIT → CLEANUP → CI/CD
```

## When to Use

- Build projects (npm/yarn, go, cargo, poetry)
- Run tests (jest, pytest, go test)
- Git operations (commit, push, create PRs)
- Cleanup (dead code, unused imports)
- CI/CD configuration (GitHub Actions)

## When NOT to Use

- Container orchestration → use `containers` skill
- Security scanning → use `security` skill
- Code review → use `code-reviewer` agent

## References

- [Full Guide](references/guide.md) - Complete methodology, all command patterns
- [Build Patterns](references/build-patterns.md) - Build configurations by language
- [Git Patterns](references/git-patterns.md) - Git workflows and conventions

## Boundaries

**Will**: Build, test, commit, push, create PRs, cleanup code, configure CI
**Will Not**: Container orchestration, infrastructure provisioning, security audits
