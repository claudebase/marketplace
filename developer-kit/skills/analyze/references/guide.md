# Analyze Skill - Detailed Guide

## Behavioral Flow

```
┌──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
│   DISCOVER   │   RESEARCH   │   ANALYZE    │   EVALUATE   │    REPORT    │
├──────────────┼──────────────┼──────────────┼──────────────┼──────────────┤
│ Scan project │ Lookup       │ Apply        │ Rate by      │ Present      │
│ structure    │ linting      │ pattern      │ severity     │ structured   │
│              │ rules        │ detection    │              │ findings     │
│              │              │              │              │              │
│ Identify     │ Find         │ Run          │ Prioritize   │ Provide      │
│ languages &  │ clean code   │ static       │ issues       │ actionable   │
│ frameworks   │ principles   │ analysis     │              │ fixes        │
│              │              │              │              │              │
│ Check        │ Research     │ Check        │ Calculate    │ Generate     │
│ existing     │ best         │ anti-        │ metrics      │ metrics      │
│ linting      │ practices    │ patterns     │              │ summary      │
└──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘
     Read           Context7      Grep/Bash      Sequential      Output
     Glob           GitHub                       Thinking        Report
                    Tavily
```

## Phase 1: DISCOVER

Scan project structure and identify context:

1. **Scan project structure** - Languages, frameworks, patterns
2. **Check existing linting** - ESLint, Biome, TSConfig, Prettier configs
3. **Identify architecture** - Monolith, microservices, modular
4. **Map dependencies** - Package.json, requirements.txt, go.mod

**Tools**: Read, Grep, Glob

## Phase 2: RESEARCH

Gather relevant analysis rules and best practices:

```
# Lookup ESLint rules documentation
mcp__context7__resolve-library-id → "/eslint/eslint"
mcp__context7__query-docs("no-unused-vars rule explanation")

# Lookup TypeScript best practices
mcp__context7__resolve-library-id → "/websites/typescriptlang"
mcp__context7__query-docs("strict mode type checking")

# Lookup Clean Code principles
mcp__context7__resolve-library-id → "/labs42io/clean-code-typescript"
mcp__context7__query-docs("function arguments best practices")

# Find code quality patterns in well-maintained repos
mcp__github__search_code("eslint-disable filename:.ts stars:>1000")

# Research current best practices
mcp__tavily__tavily-search("code quality metrics 2024 best practices")
```

## Phase 3: ANALYZE

Apply pattern detection and static analysis:

```bash
# Run ESLint if available
npx eslint . --format json 2>/dev/null

# Run TypeScript type checking
npx tsc --noEmit 2>/dev/null

# Run Biome if available
npx biome check . 2>/dev/null

# Check for common issues with grep
grep -r "console.log" --include="*.ts" src/
grep -r "any" --include="*.ts" src/
grep -r "TODO\|FIXME\|HACK" --include="*.ts" src/
```

**Pattern Detection:**

```
# Find potential memory leaks
Grep: addEventListener.*(?!removeEventListener)

# Find unhandled promises
Grep: \.then\([^)]*\)(?!\.catch)

# Find hardcoded secrets
Grep: (password|secret|key|token)\s*=\s*["'][^"']+["']

# Find console statements
Grep: console\.(log|debug|info|warn|error)
```

## Phase 4: EVALUATE

Rate findings by severity with structured reasoning:

```
mcp__sequential-thinking__sequentialthinking
- Categorize each issue by domain (quality, security, performance, architecture)
- Assess impact on maintainability, reliability, security
- Prioritize by severity (Critical, High, Medium, Low)
- Calculate overall health metrics
```

**Severity Criteria:**

| Severity | Description               | Examples                                   |
| -------- | ------------------------- | ------------------------------------------ |
| Critical | Immediate action required | Security vulnerabilities, data loss risk   |
| High     | Should fix soon           | Memory leaks, unhandled errors, logic bugs |
| Medium   | Plan to fix               | Code smells, complexity, missing types     |
| Low      | Nice to fix               | Style issues, minor optimizations          |

## Phase 5: REPORT

Present structured findings:

- Summary with counts by severity
- Detailed issues with file locations
- Actionable recommendations
- Overall metrics and health score

## MCP Integration

### Context7 (Official Documentation)

**Available Resources:**

| Resource        | Library ID                                   | Snippets |
| --------------- | -------------------------------------------- | -------- |
| ESLint          | `/eslint/eslint`                             | 4,069    |
| TypeScript      | `/websites/typescriptlang`                   | 2,391    |
| SonarQube       | `/websites/sonarsource`                      | 14,888   |
| Biome           | `/biomejs/biome`                             | 895      |
| Clean Code TS   | `/labs42io/clean-code-typescript`            | 62       |
| Clean Code JS   | `/ryanmcdermott/clean-code-javascript`       | 78       |
| Design Patterns | `/websites/refactoring_guru-design-patterns` | 1,696    |

### GitHub MCP (Pattern Research)

**Search patterns:**

```
# Find ESLint configurations
"extends" "rules" filename:.eslintrc

# Find TypeScript strict configs
"strict" "noImplicitAny" filename:tsconfig.json

# Find Biome configurations
"formatter" "linter" filename:biome.json

# Find code review patterns
"eslint-disable" "reason" filename:.ts

# Find error handling patterns
"try" "catch" "finally" filename:.ts stars:>500
```

### Tavily (Best Practices Research)

**Use cases:**

- "Code quality metrics 2024 best practices"
- "ESLint vs Biome comparison performance"
- "Technical debt measurement strategies"
- "Code complexity thresholds cyclomatic"

## Analysis Domains

### 1. Code Quality

- **Code smells** - Long methods, large classes, duplicate code
- **Anti-patterns** - God objects, spaghetti code, magic numbers
- **Complexity** - Cyclomatic complexity, nesting depth
- **Naming** - Unclear names, inconsistent conventions
- **Documentation** - Missing JSDoc, outdated comments

### 2. Security (Overview)

- **Input validation** - Unsanitized user input
- **Authentication** - Weak patterns, exposed credentials
- **Injection risks** - SQL, XSS, command injection
- For deep security audits, recommend `security` skill

### 3. Performance

- **Algorithmic** - O(n²) where O(n) possible
- **Memory** - Leaks, unnecessary allocations
- **Database** - N+1 queries, missing indexes
- **Async** - Unhandled promises, blocking operations

### 4. Architecture

- **Coupling** - Tight dependencies between modules
- **Cohesion** - Unrelated functionality grouped
- **SOLID violations** - Single responsibility, dependency inversion
- **Pattern misuse** - Inappropriate design patterns

## Common Issue Patterns

### Critical Issues

```typescript
// Hardcoded secrets
const API_KEY = "sk-12345..."; // ❌ Use environment variables

// SQL Injection
db.query(`SELECT * FROM users WHERE id = ${userId}`); // ❌ Use parameterized queries

// Unvalidated input
const data = JSON.parse(userInput); // ❌ Validate before parsing
```

### High Priority Issues

```typescript
// Memory leak - event listener not cleaned up
useEffect(() => {
  window.addEventListener("resize", handler);
  // ❌ Missing cleanup: return () => window.removeEventListener(...)
}, []);

// Unhandled promise rejection
fetch(url).then(handleData); // ❌ Missing .catch() or try/catch

// Type assertion hiding errors
const user = data as User; // ❌ Use type guards instead
```

### Medium Priority Issues

```typescript
// Magic numbers
if (items.length > 100) {
} // ❌ Use named constant: MAX_ITEMS = 100

// Any type usage
function process(data: any) {} // ❌ Use specific types or generics

// Console statements in production
console.log("debug:", value); // ❌ Remove or use proper logging
```

## Output Format

```markdown
## Analysis Summary

| Category     | Critical | High | Medium | Low |
| ------------ | -------- | ---- | ------ | --- |
| Quality      | 0        | 2    | 5      | 3   |
| Security     | 1        | 0    | 2      | 0   |
| Performance  | 0        | 1    | 2      | 1   |
| Architecture | 0        | 1    | 3      | 2   |

**Health Score**: 72/100
**Files Analyzed**: 45
**Lines of Code**: 3,420

## Critical Issues

### SEC-001: Hardcoded API Key

- **File**: `src/config.ts:15`
- **Severity**: Critical
- **Rule**: no-hardcoded-secrets
- **Description**: API key exposed in source code
- **Recommendation**: Move to environment variable

## High Priority Issues

### QUAL-001: Unhandled Promise Rejection

- **File**: `src/api/client.ts:42`
- **Severity**: High
- **Rule**: no-floating-promises
- **Description**: Promise rejection not handled
- **Recommendation**: Add .catch() or wrap in try/catch

## Metrics

| Metric                      | Value     | Threshold | Status |
| --------------------------- | --------- | --------- | ------ |
| Cyclomatic Complexity (avg) | 8.2       | < 10      | ✅     |
| Function Length (avg)       | 45 lines  | < 50      | ✅     |
| File Length (max)           | 520 lines | < 500     | ⚠️     |
| Type Coverage               | 87%       | > 90%     | ⚠️     |
| Test Coverage               | 65%       | > 80%     | ❌     |
```
