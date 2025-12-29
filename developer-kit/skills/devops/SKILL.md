---
name: devops
description: "DevOps operations for build, test, git, and cleanup workflows. Use for building projects, running tests, git operations, or code cleanup. Activates for: build, test, run tests, commit, git status, cleanup, remove dead code, CI/CD."
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - Edit
  - Write
  - TodoWrite
  - mcp__playwright__browser_navigate
  - mcp__playwright__browser_snapshot
  - mcp__playwright__browser_click
  - mcp__playwright__browser_evaluate
  - mcp__github__create_issue
  - mcp__github__list_issues
  - mcp__github__create_pull_request
  - mcp__github__get_pull_request
  - mcp__github__list_commits
  - mcp__github__search_code
---

# DevOps Skill

Unified skill for build, test, git, and cleanup operations.

## Activation Triggers

### Build Operations
- Project compilation and packaging requests
- Build optimization and artifact generation
- Error debugging during build processes

### Test Operations
- Test execution for unit, integration, or e2e tests
- Coverage analysis and quality gate validation
- Test failure analysis and debugging

### Git Operations
- Repository operations: status, add, commit, push, pull
- Intelligent commit message generation
- Branch management and workflow optimization

### Cleanup Operations
- Dead code removal and import optimization
- Project structure improvement
- Technical debt reduction

## Behavioral Flows

### Build Flow
1. **Analyze**: Project structure and build configurations
2. **Validate**: Dependencies and toolchain
3. **Execute**: Build with real-time monitoring
4. **Optimize**: Artifacts and bundle sizes
5. **Report**: Build metrics and recommendations

### Test Flow
1. **Discover**: Categorize tests by type
2. **Configure**: Test environment
3. **Execute**: Run with progress tracking
4. **Analyze**: Coverage and failures
5. **Report**: Quality metrics

### Git Flow
1. **Analyze**: Repository state
2. **Validate**: Operation appropriateness
3. **Execute**: Git command
4. **Optimize**: Smart commit messages
5. **Report**: Status and next steps

### Cleanup Flow
1. **Analyze**: Cleanup opportunities
2. **Plan**: Safe removal strategy
3. **Execute**: Systematic cleanup
4. **Validate**: No functionality loss
5. **Report**: Cleanup summary

## MCP Integration

**Use Playwright for E2E testing and build validation:**
```
mcp__playwright__browser_navigate - Navigate to test URLs
mcp__playwright__browser_snapshot - Capture page state for validation
mcp__playwright__browser_click - Interact with page elements
mcp__playwright__browser_evaluate - Execute JavaScript for testing
```
Playwright enables automated browser-based testing and visual validation of builds.

**Use GitHub MCP for repository operations:**
```
mcp__github__create_issue       - Create new GitHub issues
mcp__github__list_issues        - List and filter issues
mcp__github__create_pull_request - Create PRs programmatically
mcp__github__get_pull_request   - Get PR details and status
mcp__github__list_commits       - List commit history
mcp__github__search_code        - Search code in repositories
```
GitHub MCP enables direct GitHub API interactions for PR/issue management.

## References

- `references/build-patterns.md` - Build configurations and optimization
- `references/test-patterns.md` - Testing strategies and coverage
- `references/git-patterns.md` - Git workflows and conventions
- `references/cleanup-patterns.md` - Safe cleanup strategies
- `references/container-patterns.md` - Docker, Kubernetes, and CI/CD container workflows
- `references/github-actions.md` - GitHub Actions CI/CD workflows and patterns
- `references/gitlab-ci.md` - GitLab CI pipeline configuration and best practices

## Boundaries

**Will:**
- Execute build/test/git/cleanup operations
- Provide intelligent automation and analysis
- Generate reports and recommendations

**Will Not:**
- Modify configuration without authorization
- Execute destructive operations without confirmation
- Push to remote without explicit permission
