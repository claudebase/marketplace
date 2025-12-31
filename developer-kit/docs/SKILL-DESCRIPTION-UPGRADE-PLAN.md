# Skill Description Upgrade Plan

**Goal**: Improve skill triggering reliability by upgrading all 24 skill descriptions to use stronger, more reliable trigger patterns.

**Status**: 24/24 complete ✓

## Executive Summary

Claude Code skills trigger based on semantic matching against their YAML frontmatter descriptions. Weak descriptions lead to unreliable triggering where Claude uses direct tools instead of invoking the skill.

**Problem**: User says "find information about MongoDB" → Claude uses WebSearch directly instead of invoking the research skill.

**Solution**: Upgrade descriptions with imperative patterns, explicit triggers, and bypass prevention.

## The Pattern

Each upgraded description follows this template:

```yaml
description: "[IMPERATIVE]. Triggers: '[phrase1]', '[phrase2]', ... [VALUE_PROPOSITION]. [BYPASS_PREVENTION]."
```

### Components

| Component             | Purpose                 | Example                                                        |
| --------------------- | ----------------------- | -------------------------------------------------------------- |
| **Imperative**        | Forces action           | `MUST USE for`, `Auto-invoke when`, `PROACTIVELY activate for` |
| **Triggers**          | Explicit matching       | `Triggers: 'fix bug', 'debug', 'not working'`                  |
| **Value Proposition** | Why skill > direct tool | `Provides structured methodology`                              |
| **Bypass Prevention** | Prevents shortcuts      | `DO NOT use Read + manual review`                              |

### Example (Research Skill - DONE)

```yaml
description: "MUST USE for any web research or information gathering. Triggers: 'find information', 'research', 'look up', 'search for', 'what is', 'tell me about', 'find docs', 'documentation for', 'how does X work', 'best practices', 'latest updates', 'compare X vs Y'. Provides multi-source verification and citations. DO NOT use WebSearch/Tavily directly - this skill ensures proper source evaluation."
```

---

## Priority Tiers

Update skills in this order based on usage frequency:

| Tier                | Skills                                                                                               | Rationale                 |
| ------------------- | ---------------------------------------------------------------------------------------------------- | ------------------------- |
| **1 (Critical)**    | implement, debug, analyze, explain, improve                                                          | Highest daily usage       |
| **2 (High)**        | design, test, security, frontend, database                                                           | Common workflows          |
| **3 (Medium)**      | containers, observability, migration, devops, document                                               | Regular but less frequent |
| **4 (Specialized)** | a11y, quality, verify, orchestration, brainstorm, confidence-check, sequential-thinking, performance | Niche use cases           |

---

## Tier 1: Critical Skills

### 1. implement

**Current:**

```yaml
description: "Feature and code implementation with framework-specific best practices. Auto-invoke when user asks to 'implement', 'create', 'build', or 'develop' something. Auto-invoke when user requests 'code this', 'add functionality', 'make a component', or 'build feature'. Do NOT load for analysis-only, debugging, or review tasks."
```

**Issues:**

- Good auto-invoke pattern but missing explicit trigger list
- No value proposition
- No bypass prevention for direct coding

**Proposed:**

```yaml
description: "Auto-invoke for any code implementation task. Triggers: 'implement', 'create', 'build', 'develop', 'code this', 'add feature', 'make component', 'write function', 'add endpoint', 'create class'. Provides framework-specific patterns and best practices. DO NOT start coding without this skill - ensures consistent architecture. Skip for: analysis, debugging, review."
```

**Key Changes:**

- Added `Triggers:` list with more phrases
- Added value proposition
- Added bypass prevention
- Kept exclusion pattern

---

### 2. debug

**Current:**

```yaml
description: "Unified debugging with tiered methodology (Tier 1: quick fixes, Tier 2: complex issues, Tier 3: recurring problems). Auto-invoke when user says 'fix this bug', 'debug this', 'why is this failing', 'troubleshoot', 'not working', 'crashes when', or 'build failing'. Also use when user mentions error messages, stack traces, or unexpected behavior."
```

**Issues:**

- Good auto-invoke but could be stronger
- Missing bypass prevention
- Value proposition buried

**Proposed:**

```yaml
description: "Auto-invoke for ANY bug, error, or unexpected behavior. Triggers: 'fix bug', 'debug', 'not working', 'failing', 'error', 'broken', 'crashes', 'troubleshoot', 'why does this', 'stack trace', 'exception'. Provides tiered methodology (quick→systematic→RCA). DO NOT randomly try fixes - this skill ensures root cause identification."
```

**Key Changes:**

- Stronger imperative with "ANY"
- Expanded triggers including 'error', 'broken'
- Clearer value proposition
- Added bypass prevention

---

### 3. analyze

**Current:**

```yaml
description: "Comprehensive code analysis for quality, security, performance, and architecture. This skill should be used when the user asks to 'analyze this code', 'review for bugs', 'check code quality', 'assess architecture', or 'find issues'. Also use when user mentions code review, technical debt, or architecture assessment. READ-ONLY - reports findings without modifying code."
```

**Issues:**

- Weak "This skill should be used" pattern
- No bypass prevention
- READ-ONLY at end (less prominent)

**Proposed:**

```yaml
description: "MUST USE for code analysis and review. Triggers: 'analyze', 'review code', 'check quality', 'assess', 'find issues', 'code review', 'technical debt', 'what's wrong with'. Provides structured multi-dimensional analysis (quality, security, performance, architecture). DO NOT use Read + manual review - this skill ensures comprehensive coverage. READ-ONLY."
```

**Key Changes:**

- `MUST USE` imperative
- `Triggers:` list format
- Added bypass prevention
- READ-ONLY more prominent

---

### 4. explain

**Current:**

```yaml
description: "Educational explanations of code, concepts, and system behavior. This skill should be used when the user asks 'what does this do', 'how does this work', 'explain this', 'teach me about', or 'help me understand'. Also use when user mentions walkthrough, understanding code, or learning concepts. READ-ONLY - for documentation artifacts, use document skill."
```

**Issues:**

- Weak pattern
- Missing common triggers like "why", "walk me through"
- No bypass prevention

**Proposed:**

```yaml
description: "MUST USE for understanding code or concepts. Triggers: 'explain', 'what does this do', 'how does this work', 'teach me', 'help me understand', 'why does', 'walk me through', 'what is', 'how is this'. Provides educational explanations with examples and analogies. DO NOT just read and summarize - this skill ensures pedagogical approach. READ-ONLY."
```

**Key Changes:**

- `MUST USE` imperative
- Added 'why does', 'walk me through'
- Added value proposition
- Added bypass prevention

---

### 5. improve

**Current:**

```yaml
description: "Apply systematic improvements to code quality, performance, and maintainability. This skill should be used when the user asks to 'improve this code', 'optimize this', 'refactor', 'make this better', or 'clean up code'. Also use when user mentions performance enhancement, reducing complexity, or applying best practices. For broken code, use debug skill instead."
```

**Issues:**

- Weak pattern
- Good exclusion but could be clearer
- No bypass prevention

**Proposed:**

```yaml
description: "MUST USE for code improvements on WORKING code. Triggers: 'improve', 'optimize', 'refactor', 'make better', 'clean up', 'simplify', 'reduce complexity', 'best practices', 'modernize'. Provides systematic improvement methodology. DO NOT make ad-hoc changes - this skill ensures measurable improvements. For BROKEN code, use debug skill."
```

**Key Changes:**

- `MUST USE` with clarification "WORKING code"
- Added 'simplify', 'modernize'
- Added bypass prevention
- Clearer debug skill delegation

---

## Tier 2: High-Usage Skills

### 6. design

**Current:**

```yaml
description: "Design system architecture, APIs, database schemas, and component interfaces with concrete specifications. This skill should be used when the user asks to 'design a system', 'architect this', 'create API spec', or 'design database'. Also use when user mentions component design, architecture planning, or interface definitions."
```

**Proposed:**

```yaml
description: "MUST USE before implementing significant features. Triggers: 'design', 'architect', 'API spec', 'schema design', 'system design', 'how should I structure', 'plan the architecture', 'component interface'. Provides concrete specifications and diagrams. DO NOT start implementing without architecture - this skill prevents costly rewrites."
```

---

### 7. test

**Current:**

```yaml
description: "Test execution and analysis: run tests, measure coverage, identify gaps, suggest missing tests. This skill should be used when the user asks to 'run tests', 'check test coverage', 'what tests are missing', or 'run test suite'. Also use when user mentions test gaps, coverage analysis, or running the test suite."
```

**Proposed:**

```yaml
description: "MUST USE for test execution and coverage analysis. Triggers: 'run tests', 'test coverage', 'what tests missing', 'test suite', 'run specs', 'check tests', 'test this', 'coverage report'. Provides execution + gap analysis + suggestions. DO NOT run test commands directly - this skill ensures coverage tracking and gap identification."
```

---

### 8. security

**Current:**

```yaml
description: "PROACTIVELY activate for: (1) security audit requests (2) vulnerability analysis (3) OWASP compliance checks. This skill should be used when the user asks to 'check security', 'find vulnerabilities', 'security review', or 'is this secure'. Also use when user mentions OWASP, threat model, or CVE. READ-ONLY - use security-expert agent for fixes."
```

**Issues:**

- Good PROACTIVELY pattern
- Could add more triggers
- Missing bypass prevention

**Proposed:**

```yaml
description: "PROACTIVELY activate for ANY security concern. Triggers: 'security', 'vulnerabilities', 'is this secure', 'OWASP', 'CVE', 'injection', 'XSS', 'authentication', 'authorization', 'secrets', 'credentials'. Provides OWASP-based audit methodology. DO NOT grep for security patterns manually - this skill ensures comprehensive coverage. READ-ONLY. Use security-expert agent for fixes."
```

---

### 9. frontend

**Current:**

```yaml
description: "Frontend development with UI/UX, accessibility, and distinctive design philosophy. This skill should be used when the user asks to 'create component', 'build UI', 'design interface', or 'frontend page'. Also use when user mentions React component, Vue component, landing page, dashboard, or web application UI."
```

**Proposed:**

```yaml
description: "MUST USE for UI/frontend development. Triggers: 'create component', 'build UI', 'frontend', 'React component', 'Vue component', 'landing page', 'dashboard', 'form', 'modal', 'button', 'layout'. Provides UI/UX best practices with accessibility built-in. DO NOT build UI without this skill - ensures consistent design patterns and a11y compliance."
```

---

### 10. database

**Current:**

```yaml
description: "Design schemas, optimize queries, manage migrations, and configure database connections. This skill should be used when the user asks to 'design database schema', 'optimize query', 'create migration', or 'fix slow query'. Also use when user mentions PostgreSQL, MySQL, MongoDB, Redis, ORM setup, or SQL help."
```

**Proposed:**

```yaml
description: "MUST USE for database work. Triggers: 'database', 'schema', 'query', 'SQL', 'migration', 'PostgreSQL', 'MySQL', 'MongoDB', 'Redis', 'ORM', 'slow query', 'index', 'table design'. Provides optimized schemas and queries with performance considerations. DO NOT write raw SQL without this skill - ensures proper indexing and query optimization."
```

---

## Tier 3: Medium-Usage Skills

### 11. containers

**Current:**

```yaml
description: "Create Dockerfiles, compose configurations, and Kubernetes manifests. This skill should be used when the user asks to 'create Dockerfile', 'docker compose', 'containerize app', or 'Kubernetes manifest'. Also use when user mentions k8s deployment, Helm chart, pod configuration, or container orchestration."
```

**Proposed:**

```yaml
description: "MUST USE for containerization. Triggers: 'Docker', 'Dockerfile', 'docker-compose', 'container', 'Kubernetes', 'k8s', 'Helm', 'pod', 'deployment', 'containerize'. Provides production-ready configurations with security best practices. DO NOT write container configs without this skill - ensures multi-stage builds, security scanning, and proper resource limits."
```

---

### 12. observability

**Current:**

```yaml
description: "Configure logging, monitoring, alerting, and metrics for production systems. This skill should be used when the user asks to 'add logging', 'setup monitoring', 'create alerts', or 'add metrics'. Also use when user mentions distributed tracing, APM setup, dashboard building, or observability stack."
```

**Proposed:**

```yaml
description: "MUST USE for logging, monitoring, and alerting. Triggers: 'logging', 'monitoring', 'alerts', 'metrics', 'tracing', 'APM', 'dashboard', 'observability', 'Prometheus', 'Grafana', 'DataDog'. Provides structured observability with correlation IDs and proper log levels. DO NOT add console.log manually - this skill ensures production-grade observability."
```

---

### 13. migration

**Current:**

```yaml
description: "Plan and execute zero-downtime migrations for databases, APIs, and services. This skill should be used when the user asks to 'migrate database', 'upgrade API', 'deprecate endpoint', or 'data migration'. Also use when user mentions breaking changes, backward compatibility, or zero-downtime requirements."
```

**Proposed:**

```yaml
description: "MUST USE for any migration or breaking change. Triggers: 'migrate', 'migration', 'upgrade API', 'deprecate', 'breaking change', 'backward compatibility', 'zero-downtime', 'data migration', 'schema change'. Provides zero-downtime migration strategies with rollback plans. DO NOT make breaking changes without this skill - ensures safe, reversible migrations."
```

---

### 14. devops

**Current:**

```yaml
description: "DevOps operations for build, test, git, and cleanup workflows. This skill should be used when the user asks to 'build the project', 'run tests', 'commit changes', 'git status', or 'cleanup dead code'. Also use when user mentions CI/CD, build pipeline, or repository operations."
```

**Proposed:**

```yaml
description: "MUST USE for build, test, and git workflows. Triggers: 'build', 'compile', 'git', 'commit', 'CI/CD', 'pipeline', 'deploy', 'cleanup', 'dead code', 'lint'. Provides structured DevOps workflows with proper sequencing. DO NOT run ad-hoc build/git commands - this skill ensures consistent workflows and proper commit messages."
```

---

### 15. document

**Current:**

```yaml
description: "Create documentation artifacts (README, API docs, JSDoc/docstrings, guides). This skill should be used when the user asks to 'document this', 'create API docs', 'generate README', or 'add documentation'. Also use when user mentions writing JSDoc, adding docstrings, or creating guides. For explanations, use explain skill; for professional writing, use technical-writer agent."
```

**Proposed:**

```yaml
description: "MUST USE for creating documentation artifacts. Triggers: 'document', 'README', 'API docs', 'JSDoc', 'docstring', 'guide', 'write docs', 'add comments', 'documentation'. Provides structured, consistent documentation formats. DO NOT write docs inline - this skill ensures proper format and completeness. For explanations use explain skill; for professional docs use technical-writer agent."
```

---

## Tier 4: Specialized Skills

### 16. a11y

**Current:**

```yaml
description: "Accessibility audit and WCAG 2.1 AA compliance. This skill should be used when the user asks about 'accessibility', 'a11y', 'WCAG compliance', 'screen reader', or 'keyboard navigation'. Also use when user mentions color contrast, ARIA attributes, or accessibility testing. READ-ONLY - audits without modifying code."
```

**Proposed:**

```yaml
description: "MUST USE for accessibility concerns. Triggers: 'accessibility', 'a11y', 'WCAG', 'screen reader', 'keyboard navigation', 'color contrast', 'ARIA', 'alt text', 'focus management'. Provides WCAG 2.1 AA compliance auditing. DO NOT manually check a11y - this skill ensures comprehensive coverage of all WCAG criteria. READ-ONLY."
```

---

### 17. quality

**Current:**

```yaml
description: "Testing strategy design and quality assessment for comprehensive test coverage. This skill should be used when the user asks to 'design tests for', 'create test strategy', 'improve coverage', or 'what tests are needed'. Also use when user mentions quality assessment, testing recommendations, or coverage analysis. READ-ONLY."
```

**Proposed:**

```yaml
description: "MUST USE for test strategy design. Triggers: 'test strategy', 'what tests needed', 'testing approach', 'coverage strategy', 'test plan', 'how to test', 'testing pyramid'. Provides comprehensive testing strategy with coverage recommendations. DO NOT write tests without strategy - this skill ensures proper test distribution (unit/integration/e2e). READ-ONLY."
```

---

### 18. verify

**Current:**

```yaml
description: "Evidence-based validation with two modes: --review (pre-commit checklist) and --complete (iron law verification). This skill should be used when the user asks to 'verify this works', 'check before commit', 'prove it's fixed', 'validate changes', or 'ready to commit'. Also use when user mentions self-review, confirming implementation, or checking changes. READ-ONLY."
```

**Proposed:**

```yaml
description: "MUST USE before claiming work is complete. Triggers: 'verify', 'validate', 'ready to commit', 'is this done', 'check my work', 'prove it works', 'self-review', 'before merge'. Provides evidence-based validation (--review for checklist, --complete for iron law). DO NOT claim completion without this skill - ensures claims have proof. READ-ONLY."
```

---

### 19. orchestration

**Current:**

```yaml
description: "Meta-system task orchestration with intelligent breakdown and workflow management. This skill should be used when the user asks to 'orchestrate', 'break down', 'coordinate', or 'manage tasks'. Also use when user mentions multi-step operations, complex workflows, hierarchical coordination, or spawning subtasks."
```

**Proposed:**

```yaml
description: "MUST USE for complex multi-step tasks. Triggers: 'orchestrate', 'break down', 'coordinate', 'complex task', 'multi-step', 'workflow', 'manage tasks', 'large feature'. Provides intelligent task breakdown with dependency management. DO NOT tackle large tasks monolithically - this skill ensures proper decomposition and parallel execution where possible."
```

---

### 20. brainstorm

**Current:**

```yaml
description: "Interactive requirements discovery through Socratic dialogue. Auto-invoke when user has vague ideas or uncertain requirements. Auto-invoke when user says 'I want to build', 'thinking about', 'maybe we could', 'not sure how to', 'explore ideas', or 'help me figure out'. Exploratory only - does not implement, just discovers requirements."
```

**Issues:**

- Already has auto-invoke, which is good
- Could add more vague-idea triggers

**Proposed:**

```yaml
description: "Auto-invoke when requirements are unclear. Triggers: 'I want to build', 'thinking about', 'maybe', 'not sure how', 'explore ideas', 'help me figure out', 'what if', 'should I', 'how would I'. Provides Socratic requirements discovery through guided questions. DO NOT start implementing vague ideas - this skill clarifies requirements first. Exploratory only."
```

---

### 21. confidence-check

**Current:**

```yaml
description: "Pre-implementation confidence assessment requiring ≥90% confidence. PROACTIVELY activate before significant implementations. This skill should be used when the user asks 'am I ready to implement', 'check my confidence', 'verify before coding', or 'ready to start'. Also use when user mentions pre-implementation validation or readiness check."
```

**Proposed:**

```yaml
description: "PROACTIVELY activate before significant implementations. Triggers: 'ready to implement', 'confident enough', 'before I start', 'ready to code', 'should I start'. Requires ≥90% confidence before proceeding. DO NOT start significant implementations without this check - ensures understanding of requirements, approach, and edge cases. READ-ONLY gate."
```

---

### 22. sequential-thinking

**Current:**

```yaml
description: "Systematic step-by-step reasoning with revision and branching capabilities. This skill should be used when the user asks to 'think through this', 'step by step', 'break down problem', or 'analyze systematically'. Also use when user mentions complex reasoning, planning approach, or working through problems carefully."
```

**Proposed:**

```yaml
description: "MUST USE for complex reasoning problems. Triggers: 'think through', 'step by step', 'break down', 'analyze systematically', 'reason about', 'figure out', 'work through'. Provides structured reasoning with revision and branching. DO NOT solve complex problems in one shot - this skill ensures thorough analysis with course correction."
```

---

### 23. performance

**Current:**

```yaml
description: "Performance analysis through measurement-driven profiling. This skill should be used when the user asks 'why is this slow', 'find bottlenecks', 'profile performance', or 'optimize speed'. Also use when user mentions response time improvement, performance analysis, or speed optimization. READ-ONLY - identifies issues without modifying code."
```

**Proposed:**

```yaml
description: "MUST USE for performance concerns. Triggers: 'slow', 'performance', 'bottleneck', 'optimize speed', 'latency', 'response time', 'profiling', 'benchmark'. Provides measurement-driven analysis - profile first, then identify bottlenecks. DO NOT guess at performance issues - this skill ensures data-driven optimization. READ-ONLY. Use improve skill for fixes."
```

---

## Implementation Checklist

Execute in priority order:

### Tier 1 (Do First)

- [x] implement
- [x] debug
- [x] analyze
- [x] explain
- [x] improve

### Tier 2

- [x] design
- [x] test
- [x] security
- [x] frontend
- [x] database

### Tier 3

- [x] containers
- [x] observability
- [x] migration
- [x] devops
- [x] document

### Tier 4

- [x] a11y
- [x] quality
- [x] verify
- [x] orchestration
- [x] brainstorm
- [x] confidence-check
- [x] sequential-thinking
- [x] performance

### Already Done

- [x] research

---

## Validation

After updating each skill, test with these prompts:

| Skill     | Test Prompt                   | Expected      |
| --------- | ----------------------------- | ------------- |
| implement | "create a login form"         | Skill invoked |
| debug     | "this is broken"              | Skill invoked |
| analyze   | "review this code"            | Skill invoked |
| explain   | "what does this do"           | Skill invoked |
| improve   | "make this better"            | Skill invoked |
| research  | "find information about X"    | Skill invoked |
| design    | "how should I architect this" | Skill invoked |
| test      | "run the tests"               | Skill invoked |
| security  | "is this secure"              | Skill invoked |

---

## Quick Reference: New Description Templates

### For Core Skills (implement, debug, improve)

```yaml
description: "Auto-invoke for [SCOPE]. Triggers: '[t1]', '[t2]', ... Provides [VALUE]. DO NOT [BYPASS] - this skill ensures [BENEFIT]. [EXCLUSIONS if any]."
```

### For Analysis Skills (analyze, security, performance, quality)

```yaml
description: "MUST USE for [SCOPE]. Triggers: '[t1]', '[t2]', ... Provides [VALUE]. DO NOT [BYPASS] - this skill ensures [BENEFIT]. READ-ONLY."
```

### For Planning Skills (design, orchestration, confidence-check)

```yaml
description: "MUST USE before [ACTION]. Triggers: '[t1]', '[t2]', ... Provides [VALUE]. DO NOT [BYPASS] - this skill prevents [PROBLEM]."
```

### For Proactive Skills (security, confidence-check)

```yaml
description: "PROACTIVELY activate for [SCOPE]. Triggers: '[t1]', '[t2]', ... [VALUE]. DO NOT [BYPASS] - this skill ensures [BENEFIT]."
```
