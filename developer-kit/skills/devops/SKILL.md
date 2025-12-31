---
name: devops
description: "DevOps operations for build, test, git, and cleanup workflows. Use for building projects, running tests, git operations, or code cleanup. Activates for: build, test, run tests, commit, git status, cleanup, remove dead code, CI/CD."
allowed-tools:
  # Core Operations
  - Read
  - Grep
  - Glob
  - Bash
  - Edit
  - Write
  - TodoWrite
  # Documentation Research
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  # Best Practices Research
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  # Structured Planning
  - mcp__sequential-thinking__sequentialthinking
  # Browser Testing
  - mcp__playwright__browser_navigate
  - mcp__playwright__browser_snapshot
  - mcp__playwright__browser_click
  - mcp__playwright__browser_evaluate
  # GitHub Operations
  - mcp__github__create_issue
  - mcp__github__list_issues
  - mcp__github__create_pull_request
  - mcp__github__get_pull_request
  - mcp__github__list_commits
  - mcp__github__search_code
  - mcp__github__get_file_contents
---

# DevOps Skill

Unified skill for build, test, git, and cleanup operations with comprehensive CI/CD support using official documentation and industry best practices.

**Core Principle**: "Automate the repeatable. Monitor the critical. Ship with confidence."

**Key Enhancement**: Research build tools, CI/CD patterns, and DevOps best practices before executing operations.

**Key Distinction**: This skill EXECUTES DevOps operations. For designing CI/CD architecture, use the `design` skill. For container orchestration design, use the `containers` skill.

## Activation Triggers

### Build Operations

- Project compilation and packaging requests
- Build optimization and artifact generation
- Error debugging during build processes
- CI/CD pipeline configuration

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

## Do NOT Activate When

- User wants CI/CD architecture design → use `design` skill
- User wants container architecture → use `containers` skill
- User wants deployment automation → use `containers` skill
- User wants test strategy design → use `quality` skill

**Boundary Clarification:**
This skill executes DevOps operations and configures pipelines. For designing CI/CD architecture from scratch, use the `design` skill. For container orchestration design (Kubernetes, Helm), use the `containers` skill.

## Behavioral Flow

```
┌──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
│    BUILD     │     TEST     │     GIT      │   CLEANUP    │    REPORT    │
├──────────────┼──────────────┼──────────────┼──────────────┼──────────────┤
│ Analyze      │ Discover     │ Analyze      │ Identify     │ Summarize    │
│ project      │ test         │ repository   │ dead         │ operation    │
│ structure    │ suites       │ state        │ code         │ results      │
│              │              │              │              │              │
│ Research     │ Research     │ Research     │ Plan         │ Provide      │
│ build        │ testing      │ git          │ safe         │ metrics      │
│ tools        │ patterns     │ workflows    │ removal      │              │
│              │              │              │              │              │
│ Execute      │ Execute      │ Execute      │ Execute      │ Recommend    │
│ with         │ with         │ with smart   │ systematic   │ next         │
│ optimization │ coverage     │ messages     │ cleanup      │ steps        │
└──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘
     Bash           Bash           Bash           Edit           Output
     Context7       Playwright     GitHub MCP     Grep           TodoWrite
     Tavily         Context7       Context7       Read
```

### Build Flow

1. **Analyze**: Project structure and build configurations
2. **Research**: Build tool documentation and optimization patterns
3. **Validate**: Dependencies and toolchain
4. **Execute**: Build with real-time monitoring
5. **Optimize**: Artifacts and bundle sizes
6. **Report**: Build metrics and recommendations

### Test Flow

1. **Discover**: Categorize tests by type
2. **Research**: Testing framework patterns
3. **Configure**: Test environment
4. **Execute**: Run with progress tracking
5. **Analyze**: Coverage and failures
6. **Report**: Quality metrics

### Git Flow

1. **Analyze**: Repository state
2. **Research**: Git workflow patterns
3. **Validate**: Operation appropriateness
4. **Execute**: Git command
5. **Optimize**: Smart commit messages
6. **Report**: Status and next steps

### Cleanup Flow

1. **Analyze**: Cleanup opportunities
2. **Research**: Safe cleanup patterns
3. **Plan**: Safe removal strategy
4. **Execute**: Systematic cleanup
5. **Validate**: No functionality loss
6. **Report**: Cleanup summary

## MCP Integration

### Context7 (Official Documentation)

**Primary source for build tool and CI/CD documentation:**

```
mcp__context7__resolve-library-id - Resolve build tool IDs
mcp__context7__query-docs - Get official documentation
```

**Available Resources:**

| Resource       | Library ID                | Snippets | Use Case                          |
| -------------- | ------------------------- | -------- | --------------------------------- |
| GitHub Actions | `/github/docs`            | 6,032    | CI/CD workflows, actions, runners |
| Vite           | `/vitejs/vite`            | 1,011    | Build config, plugins, dev server |
| Webpack        | `/webpack/webpack.js.org` | 4,569    | Bundling, loaders, optimization   |
| esbuild        | `/evanw/esbuild`          | 2,020    | Fast bundling, transforms         |
| Docker         | `/docker/docs`            | 15,954   | Containers, multi-stage builds    |
| Turborepo      | `/vercel/turborepo`       | 1,132    | Monorepo builds, caching          |
| pnpm           | `/pnpm/pnpm.io`           | 3,776    | Package management, workspaces    |
| Kubernetes     | `/kubernetes/website`     | 10,654   | Container orchestration           |
| Terraform      | `/hashicorp/terraform`    | 215,150  | Infrastructure as code            |
| Jest           | `/jestjs/jest`            | 1,717    | Testing framework                 |
| Vitest         | `/vitest-dev/vitest`      | 2,776    | Fast testing, Vite integration    |
| Playwright     | `/microsoft/playwright`   | 3,711    | E2E testing, browser automation   |
| Nx             | `/nrwl/nx`                | 3,248    | Monorepo, build orchestration     |
| Rollup         | `/rollup/rollup`          | 643      | ES module bundling                |
| Parcel         | `/parcel-bundler/parcel`  | 2,145    | Zero-config bundling              |

**Query patterns:**

```
# Build tool configuration
mcp__context7__resolve-library-id → "/vitejs/vite"
mcp__context7__query-docs("vite config production build optimization")

# CI/CD workflows
mcp__context7__resolve-library-id → "/github/docs"
mcp__context7__query-docs("GitHub Actions workflow matrix parallel jobs caching")

# Container builds
mcp__context7__resolve-library-id → "/docker/docs"
mcp__context7__query-docs("multi-stage build dockerfile optimization layers")

# Monorepo builds
mcp__context7__resolve-library-id → "/vercel/turborepo"
mcp__context7__query-docs("turborepo pipeline caching remote cache")

# Infrastructure
mcp__context7__resolve-library-id → "/hashicorp/terraform"
mcp__context7__query-docs("terraform provider aws resource lifecycle")
```

### GitHub MCP (Repository Operations)

**Direct GitHub API integration:**

```
mcp__github__create_issue       - Create issues for build failures
mcp__github__list_issues        - Track open issues
mcp__github__create_pull_request - Create PRs programmatically
mcp__github__get_pull_request   - Get PR status and checks
mcp__github__list_commits       - List commit history
mcp__github__search_code        - Find CI/CD patterns
mcp__github__get_file_contents  - Get workflow files
```

**Use cases:**

```
# Find CI/CD workflow patterns
mcp__github__search_code("workflow matrix strategy filename:.github/workflows stars:>1000")

# Get successful workflow examples
mcp__github__get_file_contents(owner: "vercel", repo: "next.js", path: ".github/workflows/build_and_test.yml")

# Create issue for build failure
mcp__github__create_issue(title: "Build failure: TypeScript errors", body: "...")

# Create PR for dependency updates
mcp__github__create_pull_request(title: "chore: update dependencies", head: "deps-update", base: "main")
```

### Tavily (Best Practices Research)

**Research current DevOps methodologies:**

```
mcp__tavily__tavily-search - Research DevOps strategies
mcp__tavily__tavily-extract - Extract from DevOps guides
```

**Use cases:**

- "CI/CD best practices 2024 GitHub Actions"
- "Docker multi-stage build optimization production"
- "Monorepo build caching strategies Turborepo Nx"
- "GitHub Actions matrix build parallel jobs"
- "Vite vs Webpack vs esbuild comparison 2024"
- "Kubernetes deployment strategies blue-green canary"
- "GitOps workflow ArgoCD Flux"

### Sequential Thinking (Structured Planning)

**Systematic DevOps planning:**

```
mcp__sequential-thinking__sequentialthinking - Multi-step operation planning
```

**Use for:**

- Complex build pipeline design
- Multi-environment deployment planning
- Migration strategy development
- Troubleshooting build failures

### Playwright (Build Validation)

**Browser-based testing and validation:**

```
mcp__playwright__browser_navigate - Navigate to deployed URLs
mcp__playwright__browser_snapshot - Capture page state
mcp__playwright__browser_click - Interact with pages
mcp__playwright__browser_evaluate - Execute JavaScript validation
```

**Use cases:**

- Smoke test deployments
- Visual regression verification
- E2E test execution
- Build artifact validation

## Build Patterns

### Vite Configuration

```javascript
// vite.config.ts - Production optimization
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  plugins: [react()],
  build: {
    // Enable minification
    minify: "terser",
    terserOptions: {
      compress: {
        drop_console: true,
        drop_debugger: true,
      },
    },
    // Code splitting
    rollupOptions: {
      output: {
        manualChunks: {
          vendor: ["react", "react-dom"],
          utils: ["lodash", "date-fns"],
        },
      },
    },
    // Source maps for production debugging
    sourcemap: true,
    // Report compressed sizes
    reportCompressedSize: true,
  },
});
```

### Webpack Optimization

```javascript
// webpack.config.js - Production build
const path = require("path");
const TerserPlugin = require("terser-webpack-plugin");
const BundleAnalyzerPlugin =
  require("webpack-bundle-analyzer").BundleAnalyzerPlugin;

module.exports = {
  mode: "production",
  optimization: {
    minimize: true,
    minimizer: [new TerserPlugin()],
    splitChunks: {
      chunks: "all",
      cacheGroups: {
        vendor: {
          test: /[\\/]node_modules[\\/]/,
          name: "vendors",
          chunks: "all",
        },
      },
    },
  },
  plugins: [
    new BundleAnalyzerPlugin({
      analyzerMode: "static",
      openAnalyzer: false,
    }),
  ],
};
```

### Turborepo Pipeline

```json
// turbo.json - Monorepo build configuration
{
  "$schema": "https://turbo.build/schema.json",
  "pipeline": {
    "build": {
      "dependsOn": ["^build"],
      "outputs": ["dist/**", ".next/**"],
      "cache": true
    },
    "test": {
      "dependsOn": ["build"],
      "outputs": ["coverage/**"],
      "cache": true
    },
    "lint": {
      "outputs": [],
      "cache": true
    },
    "dev": {
      "cache": false,
      "persistent": true
    }
  }
}
```

## CI/CD Patterns

### GitHub Actions - Matrix Build

```yaml
# .github/workflows/ci.yml
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        node-version: [18.x, 20.x]
        os: [ubuntu-latest, windows-latest]

    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js ${{ matrix.node-version }}
        uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}
          cache: "npm"

      - name: Install dependencies
        run: npm ci

      - name: Build
        run: npm run build

      - name: Test
        run: npm test -- --coverage

      - name: Upload coverage
        uses: codecov/codecov-action@v4
        with:
          token: ${{ secrets.CODECOV_TOKEN }}
```

### GitHub Actions - Caching

```yaml
# Efficient caching strategy
- name: Cache node modules
  uses: actions/cache@v4
  with:
    path: |
      ~/.npm
      node_modules
    key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
    restore-keys: |
      ${{ runner.os }}-node-

- name: Cache Turborepo
  uses: actions/cache@v4
  with:
    path: .turbo
    key: ${{ runner.os }}-turbo-${{ github.sha }}
    restore-keys: |
      ${{ runner.os }}-turbo-
```

### GitHub Actions - Reusable Workflow

```yaml
# .github/workflows/reusable-build.yml
name: Reusable Build

on:
  workflow_call:
    inputs:
      node-version:
        required: false
        type: string
        default: "20"
      environment:
        required: true
        type: string
    secrets:
      NPM_TOKEN:
        required: true

jobs:
  build:
    runs-on: ubuntu-latest
    environment: ${{ inputs.environment }}
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ inputs.node-version }}
          registry-url: "https://registry.npmjs.org"
      - run: npm ci
        env:
          NODE_AUTH_TOKEN: ${{ secrets.NPM_TOKEN }}
      - run: npm run build
```

### GitHub Actions - Deployment

```yaml
# .github/workflows/deploy.yml
name: Deploy

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: production
    concurrency:
      group: production
      cancel-in-progress: false

    steps:
      - uses: actions/checkout@v4

      - name: Build
        run: npm run build

      - name: Deploy to Vercel
        uses: amondnet/vercel-action@v25
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
          vercel-args: "--prod"
```

## Docker Patterns

### Multi-Stage Build

```dockerfile
# Dockerfile - Optimized production build
# Stage 1: Build
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production=false
COPY . .
RUN npm run build

# Stage 2: Production
FROM node:20-alpine AS runner
WORKDIR /app

ENV NODE_ENV=production

# Create non-root user
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

# Copy only necessary files
COPY --from=builder /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

USER nextjs

EXPOSE 3000

ENV PORT=3000
ENV HOSTNAME="0.0.0.0"

CMD ["node", "server.js"]
```

### Docker Compose - Development

```yaml
# docker-compose.yml
version: "3.8"

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile.dev
    volumes:
      - .:/app
      - /app/node_modules
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=development
      - DATABASE_URL=postgres://user:pass@db:5432/app
    depends_on:
      - db
      - redis

  db:
    image: postgres:16-alpine
    volumes:
      - postgres_data:/var/lib/postgresql/data
    environment:
      - POSTGRES_USER=user
      - POSTGRES_PASSWORD=pass
      - POSTGRES_DB=app

  redis:
    image: redis:7-alpine
    volumes:
      - redis_data:/data

volumes:
  postgres_data:
  redis_data:
```

## Git Patterns

### Commit Message Convention

```bash
# Conventional Commits format
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

**Types:**

| Type       | Description                   |
| ---------- | ----------------------------- |
| `feat`     | New feature                   |
| `fix`      | Bug fix                       |
| `docs`     | Documentation changes         |
| `style`    | Code style (formatting, etc.) |
| `refactor` | Code refactoring              |
| `perf`     | Performance improvement       |
| `test`     | Adding/updating tests         |
| `build`    | Build system changes          |
| `ci`       | CI/CD changes                 |
| `chore`    | Other changes (deps, configs) |
| `revert`   | Revert previous commit        |

### Branch Naming

```bash
# Feature branches
feature/add-user-authentication
feature/JIRA-123-payment-integration

# Bug fix branches
fix/login-redirect-issue
bugfix/JIRA-456-cart-calculation

# Release branches
release/v1.2.0
release/2024-01-sprint

# Hotfix branches
hotfix/critical-security-patch
```

## Cleanup Patterns

### Dead Code Detection

```bash
# Find unused exports (TypeScript)
npx ts-prune

# Find unused dependencies
npx depcheck

# Find unused files
npx unimported

# ESLint unused vars
npx eslint . --rule 'no-unused-vars: error'
```

### Safe Cleanup Strategy

```
mcp__sequential-thinking__sequentialthinking
1. Identify unused code with static analysis
2. Verify no runtime dependencies (dynamic imports, reflection)
3. Check test coverage of affected areas
4. Create backup branch before removal
5. Remove in small, tested increments
6. Run full test suite after each removal
7. Monitor production for regressions
```

## Output Format

```markdown
## DevOps Operation Report

### Operation Summary

| Aspect    | Details                   |
| --------- | ------------------------- |
| Operation | [Build/Test/Git/Cleanup]  |
| Duration  | [Time taken]              |
| Status    | [Success/Failed/Partial]  |
| Artifacts | [Generated files/outputs] |

### Research Applied

- Build tool: [Vite/Webpack/esbuild documentation]
- CI/CD pattern: [GitHub Actions workflow used]
- Best practices: [Tavily research findings]

### Execution Details

#### Commands Run

\`\`\`bash
[Commands executed with outputs]
\`\`\`

#### Results

| Metric        | Value | Target  | Status |
| ------------- | ----- | ------- | ------ |
| Build time    | 45s   | < 60s   | ✅     |
| Bundle size   | 250KB | < 300KB | ✅     |
| Test coverage | 85%   | > 80%   | ✅     |

### Issues Encountered

1. [Issue description and resolution]

### Recommendations

1. [Optimization suggestion]
2. [Next steps]

### Next Steps

- [ ] [Follow-up action 1]
- [ ] [Follow-up action 2]
```

## References

- `references/build-patterns.md` - Build configurations and optimization
- `references/test-patterns.md` - Testing strategies and coverage
- `references/git-patterns.md` - Git workflows and conventions
- `references/cleanup-patterns.md` - Safe cleanup strategies
- `references/container-patterns.md` - Docker, Kubernetes, and CI/CD container workflows
- `references/github-actions.md` - GitHub Actions CI/CD workflows and patterns
- `references/gitlab-ci.md` - GitLab CI pipeline configuration and best practices

## Handoffs

| Scenario                  | Hand off to         |
| ------------------------- | ------------------- |
| Need CI/CD architecture   | `design` skill      |
| Need container design     | `containers` skill  |
| Need test strategy        | `quality` skill     |
| Need performance analysis | `performance` skill |
| Need security hardening   | `security` skill    |

## Boundaries

**Will:**

- Execute build/test/git/cleanup operations
- Research build tools and CI/CD patterns via MCP tools
- Configure CI/CD pipelines
- Generate intelligent commit messages
- Analyze build failures and suggest fixes
- Optimize build performance
- Provide comprehensive reports and metrics

**Will Not:**

- Design CI/CD architecture from scratch (use `design` skill)
- Design container orchestration (use `containers` skill)
- Push to remote without explicit permission
- Execute destructive operations without confirmation
- Modify production configurations without authorization
