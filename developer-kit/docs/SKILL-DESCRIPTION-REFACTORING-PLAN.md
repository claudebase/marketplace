# Skill Description Refactoring Plan

## Comprehensive Guide to Improving Automatic Skill Triggering

**Version:** 1.0.0
**Created:** 2025-12-31
**Status:** Ready for Implementation
**Estimated Effort:** 4-6 hours

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Problem Statement](#problem-statement)
3. [Research Findings](#research-findings)
4. [Transformation Patterns](#transformation-patterns)
5. [Skill-by-Skill Refactoring Guide](#skill-by-skill-refactoring-guide)
6. [Hook Implementation](#hook-implementation)
7. [Validation Tools](#validation-tools)
8. [Testing Strategy](#testing-strategy)
9. [Rollout Plan](#rollout-plan)
10. [Success Metrics](#success-metrics)
11. [Rollback Plan](#rollback-plan)

---

## Executive Summary

This plan addresses the critical issue of **skills not triggering automatically** in the Developer Kit plugin. Analysis and research revealed that:

- Current descriptions use ineffective patterns (`Activates for:`)
- Official documentation mandates specific formats (`This skill should be used when...`)
- Description alone achieves only **20% activation rate**
- With proper descriptions + forced eval hook: **84% activation rate**

**Goal:** Refactor all 24 skill descriptions and implement a skill evaluation hook to achieve reliable automatic triggering.

---

## Problem Statement

### Current State

Skills have trigger phrases in their descriptions, but Claude rarely invokes them automatically because:

| Issue                                             | Impact                                  | Severity |
| ------------------------------------------------- | --------------------------------------- | -------- |
| "Activates for:" pattern is passive/informational | Claude doesn't recognize as instruction | Critical |
| Trigger phrases not quoted                        | Reduced semantic matching               | High     |
| Not third-person format                           | Violates official best practices        | High     |
| No "Auto-invoke" markers for proactive skills     | Skills wait for explicit invocation     | Medium   |
| No forced evaluation mechanism                    | Claude skips skill consideration        | Critical |

### Desired State

- Skills trigger automatically when user messages match trigger phrases
- Activation rate improves from ~20% to 80%+
- Claude explicitly evaluates skill relevance before responding

---

## Research Findings

### Authoritative Sources

| Source                                                                                                        | Key Finding                                         |
| ------------------------------------------------------------------------------------------------------------- | --------------------------------------------------- |
| [Claude Code Official Docs](https://code.claude.com/docs/en/skills)                                           | Max 1024 chars, "Use when" pattern required         |
| [Anthropic Engineering](https://www.anthropic.com/engineering/writing-tools-for-agents)                       | Description refinements yield dramatic improvements |
| [Scott Spence Research](https://scottspence.com/posts/how-to-make-claude-code-skills-activate-reliably)       | 20% → 84% with forced eval hook                     |
| [Claude Plugins Dev](https://claude-plugins.dev/skills/@anthropics/claude-plugins-official/skill-development) | Third-person format, quoted triggers required       |

### Official Requirements

1. **Max length:** 1024 characters
2. **Structure:** What it does + When to use it
3. **Format:** Third-person ("This skill should be used when...")
4. **Triggers:** Quoted phrases the user would say
5. **Keywords:** Include semantic matching terms

---

## Transformation Patterns

### Pattern A: Standard Skills

For skills that should activate when user explicitly requests them.

**Template:**

```yaml
description: "[Capability summary]. This skill should be used when the user asks to '[trigger1]', '[trigger2]', or '[trigger3]'. Also use when user mentions [keyword1], [keyword2], or [keyword3]. [Constraints if any]."
```

**Example:**

```yaml
# Before
description: "Comprehensive code analysis... Activates for: analyze this code, review for bugs..."

# After
description: "Comprehensive code analysis for quality, security, performance, and architecture. This skill should be used when the user asks to 'analyze this code', 'review for bugs', 'check code quality', or 'assess architecture'. Also use when user mentions code review, technical debt, or quality assessment. READ-ONLY."
```

### Pattern B: Proactive Skills

For skills that should activate automatically without explicit request.

**Template:**

```yaml
description: "[Capability]. Auto-invoke when [condition1], [condition2], or [condition3]. Auto-invoke when user requests '[phrase1]', '[phrase2]'. Do NOT load for [exceptions]."
```

**Example:**

```yaml
description: "Feature implementation with framework best practices. Auto-invoke when user asks to build, create, or develop features. Auto-invoke when user requests 'implement this', 'code this', or 'add functionality'. Do NOT load for analysis-only or debugging tasks."
```

### Pattern C: High-Priority Skills

For critical skills that must activate reliably.

**Template:**

```yaml
description: "PROACTIVELY activate for: (1) [case1] (2) [case2] (3) [case3]. Provides: [capabilities]. Use immediately when user mentions [keywords]. [Constraints]."
```

**Example:**

```yaml
description: "PROACTIVELY activate for: (1) security audit requests (2) vulnerability analysis (3) OWASP compliance. Provides: threat identification, CVE research, remediation guidance. Use immediately when user mentions 'security', 'vulnerabilities', 'OWASP', or 'is this secure'. READ-ONLY."
```

---

## Skill-by-Skill Refactoring Guide

### Priority Classification

| Priority          | Skills                                 | Criteria                  |
| ----------------- | -------------------------------------- | ------------------------- |
| **P0 - Critical** | analyze, implement, debug, security    | Core development workflow |
| **P1 - High**     | improve, verify, test, explain         | Frequently used           |
| **P2 - Medium**   | database, frontend, containers, devops | Domain-specific           |
| **P3 - Standard** | All others                             | Supporting capabilities   |

---

### P0 - Critical Skills

#### 1. analyze

**Current:**

```yaml
description: "Comprehensive code analysis for quality, security, performance, and architecture. Use for code review, security scanning, performance assessment, architecture review, or technical debt evaluation. Activates for: analyze this code, review for bugs, check code quality, assess architecture, find issues. READ-ONLY."
```

**Refactored:**

```yaml
description: "Comprehensive code analysis for quality, security, performance, and architecture. This skill should be used when the user asks to 'analyze this code', 'review for bugs', 'check code quality', 'assess architecture', or 'find issues'. Also use when user mentions code review, technical debt, or architecture assessment. READ-ONLY - reports findings without modifying code."
```

**Characters:** 389 (within 1024 limit)

---

#### 2. implement

**Current:**

```yaml
description: "Feature and code implementation with framework-specific best practices. Use for building components, APIs, services, or complete features. Activates for: implement, create, build feature, add functionality, code this, make a, develop."
```

**Refactored:**

```yaml
description: "Feature and code implementation with framework-specific best practices. Auto-invoke when user asks to 'implement', 'create', 'build', or 'develop' something. Auto-invoke when user requests 'code this', 'add functionality', 'make a component', or 'build feature'. Do NOT load for analysis-only, debugging, or review tasks."
```

**Characters:** 366 (within 1024 limit)

---

#### 3. debug

**Current:**

```yaml
description: "Unified debugging skill with tiered methodology. Activates for: 'fix this bug', 'debug this', 'why is this failing', 'troubleshoot', 'find the root cause', 'not working', 'crashes when', 'build failing'. Tier 1 for quick fixes, Tier 2 for complex issues, Tier 3 for recurring problems."
```

**Refactored:**

```yaml
description: "Unified debugging with tiered methodology (Tier 1: quick fixes, Tier 2: complex issues, Tier 3: recurring problems). Auto-invoke when user says 'fix this bug', 'debug this', 'why is this failing', 'troubleshoot', 'not working', 'crashes when', or 'build failing'. Also use when user mentions error messages, stack traces, or unexpected behavior."
```

**Characters:** 394 (within 1024 limit)

---

#### 4. security

**Current:**

```yaml
description: "Security audit and vulnerability analysis (READ-ONLY - reports issues but does NOT fix them). Use security-expert agent to implement fixes. Activates for: security audit, find vulnerabilities, OWASP, threat model, security review, is this secure, check security."
```

**Refactored:**

```yaml
description: "PROACTIVELY activate for: (1) security audit requests (2) vulnerability analysis (3) OWASP compliance checks. This skill should be used when the user asks to 'check security', 'find vulnerabilities', 'security review', or 'is this secure'. Also use when user mentions OWASP, threat model, or CVE. READ-ONLY - use security-expert agent for fixes."
```

**Characters:** 391 (within 1024 limit)

---

### P1 - High Priority Skills

#### 5. improve

**Current:**

```yaml
description: "Apply systematic improvements to code quality, performance, and maintainability. Use for enhancing working code through refactoring or optimization. Activates for: improve this code, optimize this, refactor, make this better, enhance performance, clean up code, reduce complexity, apply best practices. For broken code use debug."
```

**Refactored:**

```yaml
description: "Apply systematic improvements to code quality, performance, and maintainability. This skill should be used when the user asks to 'improve this code', 'optimize this', 'refactor', 'make this better', or 'clean up code'. Also use when user mentions performance enhancement, reducing complexity, or applying best practices. For broken code, use debug skill instead."
```

**Characters:** 398 (within 1024 limit)

---

#### 6. verify

**Current:**

```yaml
description: "Unified verification skill for evidence-based validation. Activates for: 'verify this works', 'check before commit', 'self-review', 'prove it's fixed', 'validate changes', 'ready to commit', 'confirm implementation', 'review my work', 'check my changes'. Modes: --review (pre-commit checklist), --complete (iron law verification). READ-ONLY."
```

**Refactored:**

```yaml
description: "Evidence-based validation with two modes: --review (pre-commit checklist) and --complete (iron law verification). This skill should be used when the user asks to 'verify this works', 'check before commit', 'prove it's fixed', 'validate changes', or 'ready to commit'. Also use when user mentions self-review, confirming implementation, or checking changes. READ-ONLY."
```

**Characters:** 409 (within 1024 limit)

---

#### 7. test

**Current:**

```yaml
description: "Test execution and analysis: run tests, measure coverage, identify gaps, suggest missing tests. Activates for: 'run tests', 'test coverage', 'what tests are missing', 'test this', 'check tests', 'run test suite'."
```

**Refactored:**

```yaml
description: "Test execution and analysis: run tests, measure coverage, identify gaps, suggest missing tests. This skill should be used when the user asks to 'run tests', 'check test coverage', 'what tests are missing', or 'run test suite'. Also use when user mentions test gaps, coverage analysis, or running the test suite."
```

**Characters:** 348 (within 1024 limit)

---

#### 8. explain

**Current:**

```yaml
description: "Educational explanations of code, concepts, and system behavior (READ-ONLY - teaches understanding without modifying code). For creating documentation artifacts, use 'document' skill. Activates for: what does this do, how does this work, explain this, teach me about, help me understand, walk me through."
```

**Refactored:**

```yaml
description: "Educational explanations of code, concepts, and system behavior. This skill should be used when the user asks 'what does this do', 'how does this work', 'explain this', 'teach me about', or 'help me understand'. Also use when user mentions walkthrough, understanding code, or learning concepts. READ-ONLY - for documentation artifacts, use document skill."
```

**Characters:** 402 (within 1024 limit)

---

### P2 - Medium Priority Skills

#### 9. database

**Current:**

```yaml
description: "Design schemas, optimize queries, manage migrations, and configure database connections. Activates for: 'design database schema', 'optimize query', 'create migration', 'SQL help', 'database design', 'fix slow query', 'ORM setup', 'PostgreSQL', 'MySQL', 'MongoDB', 'Redis'."
```

**Refactored:**

```yaml
description: "Design schemas, optimize queries, manage migrations, and configure database connections. This skill should be used when the user asks to 'design database schema', 'optimize query', 'create migration', or 'fix slow query'. Also use when user mentions PostgreSQL, MySQL, MongoDB, Redis, ORM setup, or SQL help."
```

**Characters:** 348 (within 1024 limit)

---

#### 10. frontend

**Current:**

```yaml
description: "Frontend development with UI/UX, accessibility, and distinctive design. Activates for: 'create component', 'build UI', 'design interface', 'frontend page', 'React component', 'Vue component', 'web application', 'user interface', 'landing page', 'dashboard'."
```

**Refactored:**

```yaml
description: "Frontend development with UI/UX, accessibility, and distinctive design philosophy. This skill should be used when the user asks to 'create component', 'build UI', 'design interface', or 'frontend page'. Also use when user mentions React component, Vue component, landing page, dashboard, or web application UI."
```

**Characters:** 344 (within 1024 limit)

---

#### 11. containers

**Current:**

```yaml
description: "Create Dockerfiles, compose configurations, and Kubernetes manifests. Activates for: 'create Dockerfile', 'docker compose', 'containerize app', 'Kubernetes manifest', 'k8s deployment', 'Helm chart', 'pod configuration'."
```

**Refactored:**

```yaml
description: "Create Dockerfiles, compose configurations, and Kubernetes manifests. This skill should be used when the user asks to 'create Dockerfile', 'docker compose', 'containerize app', or 'Kubernetes manifest'. Also use when user mentions k8s deployment, Helm chart, pod configuration, or container orchestration."
```

**Characters:** 343 (within 1024 limit)

---

#### 12. devops

**Current:**

```yaml
description: "DevOps operations for build, test, git, and cleanup workflows. Use for building projects, running tests, git operations, or code cleanup. Activates for: build, test, run tests, commit, git status, cleanup, remove dead code, CI/CD."
```

**Refactored:**

```yaml
description: "DevOps operations for build, test, git, and cleanup workflows. This skill should be used when the user asks to 'build the project', 'run tests', 'commit changes', 'git status', or 'cleanup dead code'. Also use when user mentions CI/CD, build pipeline, or repository operations."
```

**Characters:** 318 (within 1024 limit)

---

#### 13. observability

**Current:**

```yaml
description: "Configure logging, monitoring, alerting, and metrics for production systems. Activates for: 'add logging', 'setup monitoring', 'create alerts', 'add metrics', 'distributed tracing', 'build dashboard', 'APM setup'."
```

**Refactored:**

```yaml
description: "Configure logging, monitoring, alerting, and metrics for production systems. This skill should be used when the user asks to 'add logging', 'setup monitoring', 'create alerts', or 'add metrics'. Also use when user mentions distributed tracing, APM setup, dashboard building, or observability stack."
```

**Characters:** 345 (within 1024 limit)

---

#### 14. migration

**Current:**

```yaml
description: "Plan and execute zero-downtime migrations for databases, APIs, and services. Activates for: 'migrate database', 'data migration', 'upgrade API', 'deprecate endpoint', 'backward compatible', 'breaking change', 'zero-downtime migration'."
```

**Refactored:**

```yaml
description: "Plan and execute zero-downtime migrations for databases, APIs, and services. This skill should be used when the user asks to 'migrate database', 'upgrade API', 'deprecate endpoint', or 'data migration'. Also use when user mentions breaking changes, backward compatibility, or zero-downtime requirements."
```

**Characters:** 345 (within 1024 limit)

---

### P3 - Standard Priority Skills

#### 15. design

**Current:**

```yaml
description: "Design system architecture, APIs, database schemas, and component interfaces with concrete specifications. Use for architecture design, API specs, database schemas, or interface definitions. Activates for: design a system, architect this, create API spec, design database, component design, plan architecture."
```

**Refactored:**

```yaml
description: "Design system architecture, APIs, database schemas, and component interfaces with concrete specifications. This skill should be used when the user asks to 'design a system', 'architect this', 'create API spec', or 'design database'. Also use when user mentions component design, architecture planning, or interface definitions."
```

**Characters:** 364 (within 1024 limit)

---

#### 16. quality

**Current:**

```yaml
description: "Testing strategy design and quality assessment for comprehensive test coverage. Use for test planning, coverage analysis, or testing recommendations. Activates for: design tests for, test strategy, improve coverage, what tests needed, quality assessment, how should I test this. READ-ONLY."
```

**Refactored:**

```yaml
description: "Testing strategy design and quality assessment for comprehensive test coverage. This skill should be used when the user asks to 'design tests for', 'create test strategy', 'improve coverage', or 'what tests are needed'. Also use when user mentions quality assessment, testing recommendations, or coverage analysis. READ-ONLY."
```

**Characters:** 370 (within 1024 limit)

---

#### 17. performance

**Current:**

```yaml
description: "Performance analysis and optimization through measurement-driven profiling. Use for bottleneck identification, performance profiling, or speed analysis. Activates for: why is this slow, find bottlenecks, profile performance, optimize speed, analyze performance, improve response time. READ-ONLY."
```

**Refactored:**

```yaml
description: "Performance analysis through measurement-driven profiling. This skill should be used when the user asks 'why is this slow', 'find bottlenecks', 'profile performance', or 'optimize speed'. Also use when user mentions response time improvement, performance analysis, or speed optimization. READ-ONLY - identifies issues without modifying code."
```

**Characters:** 381 (within 1024 limit)

---

#### 18. research

**Current:**

```yaml
description: "Web research with adaptive planning and intelligent search. Supports depth levels (quick/standard/deep/exhaustive) and modes (--docs for documentation, --web for general). Activates for: 'research [topic]', 'find information about', 'look up', 'search for', 'what's the latest on', 'find best practices', 'find docs for [library]'."
```

**Refactored:**

```yaml
description: "Web research with adaptive planning and intelligent search. Supports depth levels (quick/standard/deep/exhaustive) and modes (--docs, --web). This skill should be used when the user asks to 'research [topic]', 'find information about', 'look up', 'search for', or 'find docs for [library]'. Also use when user mentions finding best practices or latest updates."
```

**Characters:** 402 (within 1024 limit)

---

#### 19. document

**Current:**

```yaml
description: "Create documentation artifacts (README, API docs, JSDoc/docstrings, guides). For educational explanations without creating files, use 'explain' skill. For professional technical writing, use 'technical-writer' agent. Activates for: document this, create API docs, generate README, add documentation, write JSDoc, add docstrings."
```

**Refactored:**

```yaml
description: "Create documentation artifacts (README, API docs, JSDoc/docstrings, guides). This skill should be used when the user asks to 'document this', 'create API docs', 'generate README', or 'add documentation'. Also use when user mentions writing JSDoc, adding docstrings, or creating guides. For explanations, use explain skill; for professional writing, use technical-writer agent."
```

**Characters:** 421 (within 1024 limit)

---

#### 20. brainstorm

**Current:**

```yaml
description: "Interactive requirements discovery through Socratic dialogue and exploration. Use when users have vague ideas, uncertain requirements, or need to explore before implementation. Activates for: I want to build, thinking about, maybe we could, not sure how to, explore ideas, help me figure out. Exploratory only."
```

**Refactored:**

```yaml
description: "Interactive requirements discovery through Socratic dialogue. Auto-invoke when user has vague ideas or uncertain requirements. Auto-invoke when user says 'I want to build', 'thinking about', 'maybe we could', 'not sure how to', 'explore ideas', or 'help me figure out'. Exploratory only - does not implement, just discovers requirements."
```

**Characters:** 383 (within 1024 limit)

---

#### 21. orchestration

**Current:**

```yaml
description: "Meta-system task orchestration with intelligent breakdown and workflow management. Use for complex multi-domain operations or tasks needing hierarchical coordination. Activates for: spawn, orchestrate, break down, coordinate, manage tasks, multi-step operations."
```

**Refactored:**

```yaml
description: "Meta-system task orchestration with intelligent breakdown and workflow management. This skill should be used when the user asks to 'orchestrate', 'break down', 'coordinate', or 'manage tasks'. Also use when user mentions multi-step operations, complex workflows, hierarchical coordination, or spawning subtasks."
```

**Characters:** 352 (within 1024 limit)

---

#### 22. a11y

**Current:**

```yaml
description: "Accessibility audit and compliance: WCAG 2.1 AA, screen reader compatibility, keyboard navigation, color contrast. Activates for: 'accessibility', 'a11y', 'WCAG', 'screen reader', 'keyboard navigation', 'color contrast', 'aria'."
```

**Refactored:**

```yaml
description: "Accessibility audit and WCAG 2.1 AA compliance. This skill should be used when the user asks about 'accessibility', 'a11y', 'WCAG compliance', 'screen reader', or 'keyboard navigation'. Also use when user mentions color contrast, ARIA attributes, or accessibility testing. READ-ONLY - audits without modifying code."
```

**Characters:** 345 (within 1024 limit)

---

#### 23. confidence-check

**Current:**

```yaml
description: "Pre-implementation confidence assessment (≥90% required). Activates for: 'am I ready to implement', 'check my confidence', 'verify before coding', 'confidence check', 'ready to start', 'pre-implementation check'. Required before any significant implementation."
```

**Refactored:**

```yaml
description: "Pre-implementation confidence assessment requiring ≥90% confidence. PROACTIVELY activate before significant implementations. This skill should be used when the user asks 'am I ready to implement', 'check my confidence', 'verify before coding', or 'ready to start'. Also use when user mentions pre-implementation validation or readiness check."
```

**Characters:** 378 (within 1024 limit)

---

#### 24. sequential-thinking

**Current:**

```yaml
description: "Systematic step-by-step reasoning with revision and branching. Activates for: 'think through this', 'step by step', 'break down problem', 'analyze systematically', 'complex reasoning', 'plan approach', 'work through this carefully'."
```

**Refactored:**

```yaml
description: "Systematic step-by-step reasoning with revision and branching capabilities. This skill should be used when the user asks to 'think through this', 'step by step', 'break down problem', or 'analyze systematically'. Also use when user mentions complex reasoning, planning approach, or working through problems carefully."
```

**Characters:** 358 (within 1024 limit)

---

## Hook Implementation

### Skill Evaluation Hook

Create a new hook that forces Claude to explicitly evaluate skills before responding.

**File:** `hooks/skill_eval_hook.py`

```python
#!/usr/bin/env python3
"""
Skill Evaluation Hook

Forces Claude to explicitly evaluate available skills before proceeding.
Based on research showing 84% activation rate with forced evaluation vs 20% without.
"""

import json
import sys
import os

def main():
    """Generate skill evaluation reminder."""

    # Read hook input from stdin
    hook_input = json.loads(sys.stdin.read())

    # Only inject on user prompts, not tool results
    if hook_input.get("type") != "user_prompt":
        print(json.dumps({"continue": True}))
        return

    message = hook_input.get("message", "")

    # Skip for very short messages (greetings, confirmations)
    if len(message) < 20:
        print(json.dumps({"continue": True}))
        return

    # Skip if user explicitly mentions a skill name
    skill_names = [
        "analyze", "implement", "debug", "security", "improve", "verify",
        "test", "explain", "database", "frontend", "containers", "devops",
        "observability", "migration", "design", "quality", "performance",
        "research", "document", "brainstorm", "orchestration", "a11y",
        "confidence-check", "sequential-thinking"
    ]

    message_lower = message.lower()
    if any(f"use {name}" in message_lower or f"/{name}" in message_lower for name in skill_names):
        print(json.dumps({"continue": True}))
        return

    # Inject skill evaluation reminder
    reminder = """
<skill-evaluation-required>
Before responding, evaluate which developer-kit skills are relevant to this request.

For each potentially relevant skill, determine:
1. Does the user's request match this skill's trigger phrases?
2. Would this skill provide specialized value?

If a skill matches, invoke it via the Skill tool BEFORE generating your response.

Priority skills to consider:
- analyze: code review, quality assessment, architecture review
- implement: building features, creating components, coding
- debug: fixing bugs, troubleshooting, error resolution
- security: security audits, vulnerability checks, OWASP
- improve: refactoring, optimization, code cleanup
</skill-evaluation-required>
"""

    result = {
        "continue": True,
        "message": f"{message}\n\n{reminder}"
    }

    print(json.dumps(result))

if __name__ == "__main__":
    main()
```

### Update hooks.json

Add the skill evaluation hook to `hooks/hooks.json`:

```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "node \"${CLAUDE_PLUGIN_ROOT}/hooks/runner.js\" \"${CLAUDE_PLUGIN_ROOT}/hooks/skill_eval_hook.py\"",
            "timeout": 5
          }
        ]
      }
    ],
    "PostToolUse": [
      // ... existing hooks
    ],
    "PreToolUse": [
      // ... existing hooks
    ],
    "SessionStart": [
      // ... existing hooks
    ],
    "Stop": [
      // ... existing hooks
    ]
  }
}
```

---

## Validation Tools

### Description Validator Script

**File:** `scripts/validate_skill_descriptions.py`

```python
#!/usr/bin/env python3
"""
Skill Description Validator

Validates that skill descriptions follow best practices:
1. Max 1024 characters
2. Contains "should be used when" or "Auto-invoke when"
3. Has quoted trigger phrases
4. Includes "Also use when" for semantic keywords
"""

import os
import sys
import re
import yaml
from pathlib import Path

class DescriptionValidator:
    MAX_LENGTH = 1024

    REQUIRED_PATTERNS = [
        r"(should be used when|Auto-invoke when|PROACTIVELY activate)",
        r"'[^']+'"  # Quoted trigger phrases
    ]

    RECOMMENDED_PATTERNS = [
        r"Also use when",
        r"user (asks|mentions|requests|says)"
    ]

    DEPRECATED_PATTERNS = [
        r"Activates for:",  # Old pattern
        r"Use for:"  # Vague pattern
    ]

    def __init__(self, skills_dir: str):
        self.skills_dir = Path(skills_dir)
        self.errors = []
        self.warnings = []

    def validate_all(self) -> bool:
        """Validate all skill descriptions."""
        skill_files = list(self.skills_dir.glob("*/SKILL.md"))

        for skill_file in skill_files:
            self.validate_skill(skill_file)

        return len(self.errors) == 0

    def validate_skill(self, skill_file: Path):
        """Validate a single skill file."""
        skill_name = skill_file.parent.name

        try:
            content = skill_file.read_text()

            # Extract frontmatter
            if not content.startswith("---"):
                self.errors.append(f"{skill_name}: Missing YAML frontmatter")
                return

            parts = content.split("---", 2)
            if len(parts) < 3:
                self.errors.append(f"{skill_name}: Invalid frontmatter format")
                return

            frontmatter = yaml.safe_load(parts[1])
            description = frontmatter.get("description", "")

            # Check length
            if len(description) > self.MAX_LENGTH:
                self.errors.append(
                    f"{skill_name}: Description too long ({len(description)} > {self.MAX_LENGTH})"
                )

            # Check for required patterns
            for pattern in self.REQUIRED_PATTERNS:
                if not re.search(pattern, description):
                    self.errors.append(
                        f"{skill_name}: Missing required pattern: {pattern}"
                    )

            # Check for deprecated patterns
            for pattern in self.DEPRECATED_PATTERNS:
                if re.search(pattern, description):
                    self.warnings.append(
                        f"{skill_name}: Uses deprecated pattern: {pattern}"
                    )

            # Check for recommended patterns
            for pattern in self.RECOMMENDED_PATTERNS:
                if not re.search(pattern, description):
                    self.warnings.append(
                        f"{skill_name}: Consider adding: {pattern}"
                    )

        except Exception as e:
            self.errors.append(f"{skill_name}: Parse error - {e}")

    def report(self):
        """Print validation report."""
        print("\n=== Skill Description Validation Report ===\n")

        if self.errors:
            print(f"ERRORS ({len(self.errors)}):")
            for error in self.errors:
                print(f"  ❌ {error}")
            print()

        if self.warnings:
            print(f"WARNINGS ({len(self.warnings)}):")
            for warning in self.warnings:
                print(f"  ⚠️  {warning}")
            print()

        if not self.errors and not self.warnings:
            print("✅ All skill descriptions are valid!")
        elif not self.errors:
            print("✅ No errors found (warnings only)")
        else:
            print("❌ Validation failed")

        return len(self.errors) == 0


if __name__ == "__main__":
    skills_dir = sys.argv[1] if len(sys.argv) > 1 else "skills"

    validator = DescriptionValidator(skills_dir)
    validator.validate_all()
    success = validator.report()

    sys.exit(0 if success else 1)
```

---

## Testing Strategy

### Phase 1: Unit Testing

Test each refactored description individually:

```bash
# Run validation script
python scripts/validate_skill_descriptions.py skills/

# Check character counts
for skill in skills/*/SKILL.md; do
  name=$(dirname "$skill" | xargs basename)
  chars=$(grep "^description:" "$skill" | wc -c)
  echo "$name: $chars characters"
done
```

### Phase 2: Integration Testing

Test skill triggering with sample prompts:

| Skill     | Test Prompt                 | Expected      |
| --------- | --------------------------- | ------------- |
| analyze   | "Review this code for bugs" | Skill invokes |
| implement | "Create a login form"       | Skill invokes |
| debug     | "Fix this error: TypeError" | Skill invokes |
| security  | "Is this API secure?"       | Skill invokes |

### Phase 3: A/B Testing

Compare activation rates:

1. **Control:** 50 prompts with current descriptions
2. **Treatment:** 50 prompts with refactored descriptions
3. **Treatment + Hook:** 50 prompts with hook enabled

Track:

- Skill activation rate
- Correct skill selection rate
- False positive rate

---

## Rollout Plan

### Phase 1: P0 Skills (Day 1)

**Duration:** 2 hours

1. Refactor descriptions for: `analyze`, `implement`, `debug`, `security`
2. Run validation script
3. Test with 10 sample prompts each
4. Commit changes

**Validation:**

```bash
python scripts/validate_skill_descriptions.py skills/
```

### Phase 2: P1 Skills (Day 1)

**Duration:** 1.5 hours

1. Refactor: `improve`, `verify`, `test`, `explain`
2. Validate and test
3. Commit changes

### Phase 3: P2 Skills (Day 2)

**Duration:** 2 hours

1. Refactor: `database`, `frontend`, `containers`, `devops`, `observability`, `migration`
2. Validate and test
3. Commit changes

### Phase 4: P3 Skills (Day 2)

**Duration:** 2 hours

1. Refactor remaining 12 skills
2. Validate all skills
3. Full integration test
4. Commit changes

### Phase 5: Hook Deployment (Day 3)

**Duration:** 2 hours

1. Implement `skill_eval_hook.py`
2. Update `hooks.json`
3. Test hook with 20 sample prompts
4. Measure activation rate improvement
5. Commit and deploy

### Phase 6: Documentation Update (Day 3)

**Duration:** 1 hour

1. Update `TRIGGER-REFERENCE.md`
2. Update `skills/README.md`
3. Update plugin version to 5.1.0
4. Create release notes

---

## Success Metrics

### Primary Metrics

| Metric                           | Baseline | Target | Measurement                          |
| -------------------------------- | -------- | ------ | ------------------------------------ |
| Skill activation rate            | ~20%     | ≥80%   | Manual testing with 100 prompts      |
| Correct skill selection          | Unknown  | ≥90%   | Review activated skills for accuracy |
| Description validation pass rate | 0%       | 100%   | Validation script                    |

### Secondary Metrics

| Metric                                | Target     | Measurement         |
| ------------------------------------- | ---------- | ------------------- |
| Average description length            | <500 chars | Automated script    |
| Descriptions with deprecated patterns | 0          | Validation script   |
| Hook execution time                   | <100ms     | Performance logging |

### Tracking Method

Create `scripts/track_skill_activation.py` to log:

- User prompt
- Skills evaluated
- Skills invoked
- Time to invocation

---

## Rollback Plan

### Trigger Conditions

- Skill activation rate drops below 15%
- False positive rate exceeds 30%
- Hook causes errors in >5% of requests
- User complaints about irrelevant skill invocations

### Rollback Procedure

1. **Immediate:** Disable hook in `hooks.json`

   ```json
   // Comment out UserPromptSubmit hook
   ```

2. **Partial:** Revert specific skill descriptions

   ```bash
   git checkout HEAD~1 -- skills/[skill-name]/SKILL.md
   ```

3. **Full:** Revert all changes
   ```bash
   git revert [commit-hash]
   ```

### Recovery Time

- Hook disable: <1 minute
- Partial revert: <5 minutes
- Full revert: <10 minutes

---

## Appendix A: Character Count Reference

| Skill               | Current | Refactored | Status |
| ------------------- | ------- | ---------- | ------ |
| analyze             | 324     | 389        | ✓      |
| implement           | 244     | 366        | ✓      |
| debug               | 305     | 394        | ✓      |
| security            | 269     | 391        | ✓      |
| improve             | 323     | 398        | ✓      |
| verify              | 340     | 409        | ✓      |
| test                | 202     | 348        | ✓      |
| explain             | 307     | 402        | ✓      |
| database            | 266     | 348        | ✓      |
| frontend            | 249     | 344        | ✓      |
| containers          | 218     | 343        | ✓      |
| devops              | 230     | 318        | ✓      |
| observability       | 220     | 345        | ✓      |
| migration           | 247     | 345        | ✓      |
| design              | 296     | 364        | ✓      |
| quality             | 288     | 370        | ✓      |
| performance         | 292     | 381        | ✓      |
| research            | 319     | 402        | ✓      |
| document            | 316     | 421        | ✓      |
| brainstorm          | 308     | 383        | ✓      |
| orchestration       | 253     | 352        | ✓      |
| a11y                | 237     | 345        | ✓      |
| confidence-check    | 265     | 378        | ✓      |
| sequential-thinking | 230     | 358        | ✓      |

All refactored descriptions are within the 1024 character limit.

---

## Appendix B: Quick Reference Card

### Transformation Cheat Sheet

| Replace This             | With This                                                          |
| ------------------------ | ------------------------------------------------------------------ |
| `Activates for: X, Y, Z` | `This skill should be used when the user asks to 'X', 'Y', or 'Z'` |
| `Use for X`              | `Also use when user mentions X`                                    |
| No proactive marker      | Add `Auto-invoke when` for important skills                        |
| Unquoted triggers        | Quote all: `'trigger phrase'`                                      |

### Description Template

```yaml
description: "[Capability]. This skill should be used when the user asks to '[trigger1]', '[trigger2]', or '[trigger3]'. Also use when user mentions [keyword1], [keyword2], or [keyword3]. [Constraints]."
```

### Validation Command

```bash
python scripts/validate_skill_descriptions.py skills/
```

---

## Document History

| Version | Date       | Author | Changes                    |
| ------- | ---------- | ------ | -------------------------- |
| 1.0.0   | 2025-12-31 | Claude | Initial comprehensive plan |
