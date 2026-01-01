# DevOps Skill - Detailed Guide

Unified skill for build, test, git, and cleanup operations with CI/CD support.

**Core Principle**: "Automate the repeatable. Monitor the critical. Ship with confidence."

---

## Behavioral Flow

```
┌──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
│    BUILD     │     TEST     │     GIT      │   CLEANUP    │    CI/CD     │
├──────────────┼──────────────┼──────────────┼──────────────┼──────────────┤
│ Detect build │ Run test     │ Stage, commit│ Find unused  │ Configure    │
│ system       │ suites       │ push changes │ code/imports │ pipelines    │
│              │              │              │              │              │
│ npm/yarn     │ jest/pytest  │ git add/     │ dead code    │ GitHub       │
│ go/cargo     │ vitest/mocha │ commit/push  │ detection    │ Actions      │
│              │              │              │              │              │
│ Auto-detect  │ Coverage     │ Smart        │ Safe         │ Workflow     │
│ package mgr  │ analysis     │ messages     │ removal      │ generation   │
└──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘
     Bash           Bash          Bash          Grep           Write
                                  GitHub        Edit           GitHub
```

---

## Operations

### Build Operations

**Auto-detect and execute builds:**

```bash
# JavaScript/TypeScript
npm run build
yarn build
pnpm build

# Go
go build ./...
go build -o bin/app

# Rust
cargo build
cargo build --release

# Python
poetry build
python -m build
pip wheel .
```

**Build Verification:**

1. Check for build configuration (package.json, Cargo.toml, pyproject.toml)
2. Verify dependencies are installed
3. Run build command
4. Verify output artifacts exist

### Test Operations

**Run tests with coverage:**

```bash
# JavaScript/TypeScript
npm test
npm run test:coverage
npx vitest run --coverage

# Python
pytest
pytest --cov=src --cov-report=term-missing

# Go
go test ./...
go test -cover ./...

# Rust
cargo test
cargo test --all-features
```

**Test Workflow:**

1. Ensure dependencies installed
2. Run full test suite
3. Parse output for failures
4. Report coverage percentage
5. Identify failing tests

### Git Operations

**Staging and committing:**

```bash
# Check status
git status
git diff --stat

# Stage changes
git add .
git add -p  # Interactive staging

# Commit with conventional message
git commit -m "feat(module): add feature description"
git commit -m "fix(component): resolve issue description"

# Push
git push origin branch-name
git push -u origin branch-name  # Set upstream
```

**Commit Message Format:**

```
<type>(<scope>): <description>

Types: feat, fix, docs, style, refactor, test, chore
Scope: component/module affected
Description: imperative mood, lowercase, no period
```

**Pull Request Creation:**

```bash
# Create PR with GitHub CLI
gh pr create --title "feat: description" --body "## Summary\n..."
gh pr view
gh pr merge
```

### Cleanup Operations

**Find and remove dead code:**

```bash
# Find unused exports (TypeScript)
npx ts-prune

# Find unused dependencies
npx depcheck

# Find unused imports
npx eslint --fix src/

# Python unused imports
ruff check --select F401 --fix
```

**Safe Removal Process:**

1. Identify unused code/imports
2. Verify no dynamic usage
3. Remove in isolated commits
4. Run tests after each removal
5. Verify build succeeds

---

## MCP Tool Integration

### Context7 (Documentation)

```
mcp__context7__resolve-library-id - Resolve build tool docs
mcp__context7__query-docs - Get configuration examples
```

**Key Resources:**

| Resource       | Library ID                     | Use Case       |
| -------------- | ------------------------------ | -------------- |
| GitHub Actions | `/websites/docs_github_com_en` | CI/CD          |
| Jest           | `/jestjs/jest`                 | JS testing     |
| Pytest         | `/pytest-dev/pytest`           | Python testing |
| Vite           | `/vitejs/vite`                 | Build tool     |
| esbuild        | `/evanw/esbuild`               | Bundling       |

### GitHub MCP

```
mcp__github__create_pull_request - Create PRs
mcp__github__list_commits - View commit history
mcp__github__search_code - Find patterns
```

### Sequential Thinking

```
mcp__sequential-thinking__sequentialthinking - Plan multi-step workflows
```

---

## CI/CD Patterns

### GitHub Actions Basic Workflow

```yaml
name: CI
on: [push, pull_request]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
      - run: npm ci
      - run: npm test
      - run: npm run build
```

### Common Workflow Patterns

- **Build on push**: Compile and verify on every commit
- **Test on PR**: Run tests before merge
- **Deploy on tag**: Ship releases automatically
- **Scheduled cleanup**: Regular dependency updates

---

## Handoffs

| Scenario                    | Hand off to           |
| --------------------------- | --------------------- |
| Container orchestration     | `containers` skill    |
| Security scanning           | `security` skill      |
| Code review                 | `code-reviewer` agent |
| Performance testing         | `test` skill          |
| Infrastructure provisioning | External tools        |

---

## Related Reference Files

- [build-patterns.md](build-patterns.md) - Build configurations by language
- [test-patterns.md](test-patterns.md) - Testing strategies and coverage
- [git-patterns.md](git-patterns.md) - Git workflows and conventions
- [cleanup-patterns.md](cleanup-patterns.md) - Dead code removal strategies
- [github-actions.md](github-actions.md) - CI/CD workflow templates
