# Skills Guide

Skills are the **primary business logic layer** in Developer Kit's skill-centric architecture. They auto-activate based on trigger phrases and contain core capabilities (50-100 lines each).

> **Architecture**: Skills are the core layer. Agents and Commands are thin orchestration/interface layers that delegate to Skills.

---

## How Skills Work

1. **Primary Logic Layer**: Skills contain the core business logic and methodology
2. **Automatic Activation**: Claude analyzes your request and activates relevant skills
3. **Emphatic Triggers**: Each skill uses bold trigger phrases for clear activation
4. **Tool Restrictions**: Skills may have restricted tool access for safety
5. **Progressive Disclosure**: Skills load reference files as needed (keeping core under 100 lines)

### Emphatic Trigger Pattern

Skills use this description pattern for reliable activation:

```
**EMPHATIC TRIGGER**. Core purpose. Activates for: 'trigger1', 'trigger2', 'trigger3'.
```

Example:

```yaml
description: "**MUST USE for bug fixing**. Tiered debugging from quick fix to deep RCA. Activates for: 'fix this bug', 'debug this', 'why is failing'."
```

### Activation Example

```
User: "Is this authentication code secure?"

Claude thinks:
- Matches "secure" trigger → security skill
- Loads security/SKILL.md
- Applies OWASP methodology
- Returns security audit report
```

### Manual Activation

```
"Use the performance skill to analyze this function"
```

---

## Skill Categories

| Category                                          | Skills | Focus                                       |
| ------------------------------------------------- | ------ | ------------------------------------------- |
| [Analysis](#analysis-skills)                      | 6      | Code review, security, performance, testing |
| [Implementation](#implementation-skills)          | 6      | Building features, UI, databases, debugging |
| [Research & Planning](#research--planning-skills) | 5      | Discovery, architecture, documentation      |
| [Infrastructure](#infrastructure-skills)          | 4      | DevOps, observability, migrations           |
| [Meta](#meta-skills)                              | 3      | Orchestration, reasoning, accessibility     |

---

## Analysis Skills

### analyze

**Purpose**: Comprehensive code analysis across quality, security, performance, and architecture.

**Triggers**: "analyze this code", "review for bugs", "check code quality", "assess architecture", "what's wrong with this code"

**Capabilities**:

- Code smell detection
- Complexity metrics
- Pattern matching
- Dependency analysis
- Severity-rated findings

**Example**:

```
analyze src/api/ for code quality issues
```

**Output Format**:

```
## Analysis Summary
- Files analyzed: 15
- Issues found: 8 (1 critical, 2 high, 5 medium)

## Critical Issues
### Unvalidated User Input
- File: src/api/users.ts:45
- Severity: Critical
- Recommendation: Add input validation
```

**Tools**: Read, Grep, Glob, Bash, Sequential Thinking MCP

---

### security

**Purpose**: Security audit with OWASP methodology. **READ-ONLY** - reports but doesn't fix.

**Triggers**: "security audit", "find vulnerabilities", "OWASP check", "threat model", "is this secure"

**Capabilities**:

- OWASP Top 10 scanning
- Authentication/authorization review
- Input validation checks
- Secrets detection
- Threat modeling

**Example**:

```
security audit the payment processing module
```

**Output Format**:

```
## Security Audit Report

### Executive Summary
- Critical: 1 | High: 2 | Medium: 3

### VULN-001: SQL Injection
- Location: src/db/queries.ts:89
- Severity: Critical (CVSS: 9.8)
- Attack Vector: User search input
- Remediation: Use parameterized queries
```

**Tools**: Read, Grep, Glob (restricted for audit integrity)

**Related**: Use `security-expert` agent to implement fixes

---

### performance

**Purpose**: Performance profiling and bottleneck identification. **READ-ONLY**.

**Triggers**: "why is this slow", "find bottlenecks", "profile performance", "optimize speed", "improve response time"

**Capabilities**:

- Algorithmic complexity analysis
- N+1 query detection
- Memory leak patterns
- I/O bottleneck identification
- Resource usage assessment

**Example**:

```
why is the user search endpoint slow?
```

**Tools**: Read, Grep, Glob (restricted for analysis integrity)

**Related**: Use `improve` skill to implement optimizations

---

### quality

**Purpose**: Testing strategy design and coverage assessment. **READ-ONLY**.

**Triggers**: "design tests for", "test strategy", "improve coverage", "what tests needed", "how should I test"

**Capabilities**:

- Coverage analysis
- Test strategy recommendations
- Edge case identification
- Test quality metrics
- Gap analysis

**Example**:

```
what tests are missing for the authentication module?
```

**Tools**: Read, Grep, Glob

---

### test

**Purpose**: Test execution, coverage analysis, and gap identification.

**Triggers**: "run tests", "test coverage", "what tests are missing", "check tests", "run test suite"

**Capabilities**:

- Framework detection (Jest, Vitest, Pytest, Go, Rust, etc.)
- Test execution
- Coverage reporting
- E2E testing via Playwright
- Test gap suggestions

**Example**:

```
run tests for the user module and show coverage
```

**Tools**: Read, Grep, Glob, Bash, Playwright MCP

---

### verify

**Purpose**: Evidence-based validation before claiming completion. **READ-ONLY**.

**Triggers**: "verify this works", "prove it's fixed", "check before commit", "confirm implementation", "ready to commit"

**Modes**:

- `--review`: Pre-commit checklist
- `--complete`: Full verification (Iron Law)

**Example**:

```
verify my changes are ready to commit
```

**Verification Pattern**:

```
1. IDENTIFY: What proves this claim?
2. RUN: Execute verification command
3. READ: Check output and exit code
4. VERIFY: Does output confirm claim?
5. CLAIM: Make claim with evidence
```

**Tools**: Read, Grep, Glob, Bash

---

## Implementation Skills

### implement

**Purpose**: Feature implementation with framework-specific best practices.

**Triggers**: "implement", "create", "build feature", "add functionality", "code this", "make a"

**Capabilities**:

- Context-based approach selection
- Framework pattern lookup (via Context7)
- Multi-component coordination
- Testing integration

**Example**:

```
implement a user registration form with validation
```

**Tools**: Read, Grep, Glob, Bash, Edit, Write, TodoWrite, Task, Context7 MCP, Playwright MCP

---

### frontend

**Purpose**: UI development with distinctive, non-generic design.

**Triggers**: "create component", "build UI", "design interface", "React component", "Vue component", "landing page", "dashboard"

**Design Philosophy**:

- Bold aesthetic choices
- Distinctive typography (avoid generic fonts)
- Thoughtful color palettes
- Meaningful animations
- Spatial composition

**Example**:

```
create a pricing page with a bold, modern design
```

**Tools**: All tools (unrestricted for full creative control)

---

### database

**Purpose**: Schema design, query optimization, and migration management.

**Triggers**: "design database schema", "optimize query", "create migration", "SQL help", "PostgreSQL", "MySQL", "MongoDB"

**Capabilities**:

- Schema design patterns
- Query optimization
- Index recommendations
- Migration planning
- Connection management

**Example**:

```
design a database schema for a multi-tenant SaaS application
```

**References**: schema-design.md, query-optimization.md, migration-patterns.md

**Tools**: Read, Grep, Glob, Bash, Edit, Write, Sequential Thinking MCP

---

### containers

**Purpose**: Docker, Kubernetes, and Helm patterns.

**Triggers**: "create Dockerfile", "docker compose", "containerize app", "Kubernetes manifest", "k8s deployment", "Helm chart"

**Capabilities**:

- Multi-stage Dockerfiles
- Docker Compose configurations
- Kubernetes manifests
- Helm chart creation
- Security best practices

**Example**:

```
create a Dockerfile for this Node.js application with multi-stage build
```

**References**: dockerfile-patterns.md, compose-patterns.md, kubernetes-patterns.md, helm-patterns.md

---

### debug

**Purpose**: Tiered debugging from quick fixes to deep root cause analysis.

**Triggers**: "fix this bug", "debug this", "why is this failing", "troubleshoot", "not working", "crashes when", "build failing"

**Tiers**:

| Tier          | When                              | Approach                             |
| ------------- | --------------------------------- | ------------------------------------ |
| 1: Quick Fix  | Simple bugs, clear errors         | Read error → Identify → Fix → Verify |
| 2: Systematic | Multi-component, unclear errors   | 4-phase investigation                |
| 3: Deep RCA   | Recurring issues, 3+ failed fixes | Scientific method, 5 Whys            |

**Iron Law** (Tier 2+):

```
NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST
```

**Example**:

```
debug why the tests are failing in CI but passing locally
```

**Tools**: Read, Grep, Glob, Bash, Edit, Write, Sequential Thinking MCP

---

### improve

**Purpose**: Refactoring and optimization for working code.

**Triggers**: "improve this code", "optimize this", "refactor", "make this better", "enhance performance", "clean up code"

**Capabilities**:

- SOLID principle application
- Code smell removal
- Performance optimization
- Readability improvements
- Pattern application

**Example**:

```
refactor this function to be more maintainable
```

**Tools**: Read, Grep, Glob, Bash, Edit, Write

**Note**: For broken code, use `debug` skill instead

---

## Research & Planning Skills

### research

**Purpose**: Web research with adaptive planning and intelligent search.

**Triggers**: "research [topic]", "find information about", "look up", "search for", "find docs for [library]"

**Depth Levels**:

- `--quick`: Fast surface search
- `--standard`: Moderate exploration (default)
- `--deep`: Comprehensive research
- `--exhaustive`: Leave no stone unturned

**Modes**:

- `--web`: General web search
- `--docs`: Documentation-focused

**Example**:

```
research best practices for React error boundaries --deep
```

**Tools**: Read, Grep, Glob, Bash, WebSearch, Tavily MCP, Context7 MCP

---

### brainstorm

**Purpose**: Requirements discovery through Socratic dialogue.

**Triggers**: "I want to build", "thinking about", "maybe we could", "not sure how to", "explore ideas", "help me figure out"

**Approach**:

- Exploratory questioning
- Assumption challenging
- Scope refinement
- Trade-off discussion

**Example**:

```
I want to build a real-time collaboration feature, help me think through it
```

**Note**: Exploration only - does not implement

---

### explain

**Purpose**: Educational explanations of code and concepts. **READ-ONLY**.

**Triggers**: "what does this do", "how does this work", "explain this code", "teach me about", "help me understand"

**Capabilities**:

- Code walkthroughs
- Concept explanations
- Analogy generation
- Progressive complexity

**Example**:

```
explain how this authentication middleware works
```

**Tools**: Read, Grep, Glob

**Related**: Use `document` skill to create documentation artifacts

---

### design

**Purpose**: System architecture, API specs, and database schemas.

**Triggers**: "design a system", "architect this", "create API spec", "design database", "component design", "plan architecture"

**Deliverables**:

- Architecture diagrams (text-based)
- API specifications
- Database schemas
- Component interfaces
- Trade-off analysis

**Example**:

```
design a notification system that supports email, SMS, and push
```

**Tools**: Read, Grep, Glob, Write, Bash, Task, Sequential Thinking MCP, Context7 MCP

---

### confidence-check

**Purpose**: Pre-implementation confidence assessment. **READ-ONLY**.

**Triggers**: "am I ready to implement", "check my confidence", "verify before coding", "pre-implementation check"

**Requirement**: ≥90% confidence to proceed

**Checks**:

1. No duplicate implementations? (25%)
2. Architecture compliance? (25%)
3. Official documentation verified? (20%)
4. Working OSS implementations found? (15%)
5. Root cause identified? (15%)

**Example**:

```
am I ready to implement OAuth integration?
```

**Output**:

```
📋 Confidence Checks:
   ✅ No duplicate implementations found
   ✅ Uses existing tech stack
   ✅ Official documentation verified
   ✅ Working OSS implementation found
   ✅ Root cause identified

📊 Confidence: 1.00 (100%)
✅ High confidence - Proceeding to implementation
```

---

## Infrastructure Skills

### devops

**Purpose**: Build, test, git, and cleanup workflows.

**Triggers**: "build", "test", "run tests", "commit", "git status", "cleanup", "CI/CD"

**Operations**:

- Build execution
- Test running
- Git operations
- Code cleanup
- CI/CD configuration

**Example**:

```
run the build and fix any errors
```

**Tools**: Read, Grep, Glob, Bash, Edit, Write, GitHub MCP

---

### observability

**Purpose**: Logging, monitoring, alerting, and distributed tracing.

**Triggers**: "add logging", "setup monitoring", "create alerts", "add metrics", "distributed tracing", "build dashboard"

**Capabilities**:

- Structured logging patterns
- Prometheus/Grafana setup
- Alert rule configuration
- Dashboard creation
- OpenTelemetry integration

**Example**:

```
add structured logging to the API layer
```

**References**: logging-patterns.md, monitoring-setup.md, alerting-strategies.md, dashboard-templates.md

---

### migration

**Purpose**: Zero-downtime migrations for databases, APIs, and services.

**Triggers**: "migrate database", "data migration", "upgrade API", "deprecate endpoint", "breaking change", "zero-downtime"

**Patterns**:

- Expand-contract migrations
- Blue-green deployments
- API versioning strategies
- Data backfill approaches

**Example**:

```
plan a zero-downtime migration to add a new required column
```

**References**: database-migration-patterns.md, api-versioning.md, zero-downtime.md

---

### a11y

**Purpose**: Accessibility audit and WCAG 2.1 AA compliance. **READ-ONLY**.

**Triggers**: "accessibility", "a11y", "WCAG", "screen reader", "keyboard navigation", "color contrast"

**Checks**:

- WCAG 2.1 Level AA criteria
- Color contrast ratios
- Keyboard navigation
- Screen reader compatibility
- ARIA usage

**Example**:

```
audit this form for accessibility issues
```

**References**: wcag-checklist.md, testing-tools.md, common-fixes.md

---

## Meta Skills

### orchestration

**Purpose**: Meta-system task orchestration and coordination.

**Triggers**: "spawn", "orchestrate", "break down", "coordinate", "manage tasks", "multi-step operations"

**Capabilities**:

- Task decomposition
- Dependency mapping
- Parallel execution planning
- Progress tracking

**Example**:

```
break down this feature into implementable tasks
```

---

### document

**Purpose**: Documentation generation (README, API docs, JSDoc, guides).

**Triggers**: "document this", "create API docs", "generate README", "add documentation", "write JSDoc"

**Output Types**:

- README files
- API documentation
- JSDoc/docstrings
- User guides
- Technical specs

**Example**:

```
create API documentation for the user endpoints
```

**Related**: Use `explain` skill for educational explanations without creating files

---

### sequential-thinking

**Purpose**: Systematic step-by-step reasoning with revision and branching.

**Triggers**: "think through this", "step by step", "break down problem", "analyze systematically", "complex reasoning"

**Capabilities**:

- Iterative reasoning
- Dynamic scope adjustment
- Revision tracking
- Branch exploration

**MCP Tool**: `mcp__sequential-thinking__sequentialthinking`

**Example**:

```
think through the implications of changing our authentication system step by step
```

---

## Skill Boundaries

### Read-Only Skills

These skills analyze but never modify code:

| Skill              | Safe For                  | Use This for Fixes      |
| ------------------ | ------------------------- | ----------------------- |
| `security`         | Auditing any codebase     | `security-expert` agent |
| `performance`      | Measuring without changes | `improve` skill         |
| `quality`          | Assessing test coverage   | `implement` skill       |
| `verify`           | Validating claims         | -                       |
| `explain`          | Educational purposes      | -                       |
| `confidence-check` | Pre-implementation gates  | -                       |
| `a11y`             | Accessibility audits      | `improve` skill         |

### Skill vs Agent vs Command

| Type    | Invocation            | Best For          |
| ------- | --------------------- | ----------------- |
| Skill   | Automatic             | Core capabilities |
| Agent   | Delegated or explicit | Domain expertise  |
| Command | User types name       | Quick workflows   |

---

## Adding New Skills

1. Copy template:

```bash
cp -r templates/skill-template skills/my-skill
```

2. Edit `skills/my-skill/SKILL.md`:

```yaml
---
name: my-skill
description: "Purpose. Activates for: 'trigger1', 'trigger2', 'trigger3'..."
allowed-tools:
  - Read
  - Grep
  - Glob
---
```

3. Add reference files as needed in `skills/my-skill/references/`

4. Validate:

```bash
./scripts/validate-skill-descriptions.sh
```

---

## Quick Reference

See [TRIGGER-REFERENCE.md](../skills/TRIGGER-REFERENCE.md) for a compact trigger phrase list.
