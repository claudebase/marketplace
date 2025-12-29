# Developer Kit Skills Reference

Skills are organized into logical groups for discoverability. Per Claude Code spec,
all skills remain in flat `skills/<name>/SKILL.md` structure.

## Quick Reference

| Category | Skills | Purpose |
|----------|--------|---------|
| Analysis | 5 | Code quality, security, performance, testing, test execution |
| Creation | 4 | Implementation, UI, database, containers |
| Process | 4 | Debugging, refactoring, migration, validation |
| Research | 4 | Web research, explanations, documentation |
| Planning | 3 | Architecture, orchestration, confidence gates |
| Meta | 4 | Reasoning, DevOps, observability, accessibility |

**Total: 24 skills**

## Skill Categories

### Analysis Skills

| Skill | Purpose | Read-Only |
|-------|---------|-----------|
| [analyze](./analyze/SKILL.md) | Broad code analysis (quality, security, performance, architecture) | No |
| [security](./security/SKILL.md) | Security-focused audit (OWASP Top 10, vulnerabilities) | **Yes** |
| [performance](./performance/SKILL.md) | Bottleneck identification through measurement | **Yes** |
| [quality](./quality/SKILL.md) | Testing strategy design and coverage assessment | **Yes** |
| [test](./test/SKILL.md) | Test execution, coverage analysis, gap identification | No |

### Creation Skills

| Skill | Purpose | Read-Only |
|-------|---------|-----------|
| [implement](./implement/SKILL.md) | Feature and code implementation with framework best practices | No |
| [frontend](./frontend/SKILL.md) | UI/UX components with distinctive design philosophy | No |
| [database](./database/SKILL.md) | Schema design, query optimization, migrations | No |
| [containers](./containers/SKILL.md) | Docker, docker-compose, Kubernetes manifests | No |

### Process Skills

| Skill | Purpose | Read-Only |
|-------|---------|-----------|
| [debug](./debug/SKILL.md) | Tiered debugging (quick, systematic, RCA) | No |
| [improve](./improve/SKILL.md) | Refactoring and optimization for working code | No |
| [migration](./migration/SKILL.md) | Zero-downtime database/API/service migrations | No |
| [verify](./verify/SKILL.md) | Evidence-based validation (--review and --complete modes) | **Yes** |

### Research Skills

| Skill | Purpose | Read-Only |
|-------|---------|-----------|
| [research](./research/SKILL.md) | Web research with adaptive planning (quick/standard/deep) | No |
| [explain](./explain/SKILL.md) | Code and concept explanations for learning | **Yes** |
| [document](./document/SKILL.md) | API docs, README, guides, technical documentation | No |
| [brainstorm](./brainstorm/SKILL.md) | Requirements discovery through Socratic dialogue | No |

### Planning Skills

| Skill | Purpose | Read-Only |
|-------|---------|-----------|
| [design](./design/SKILL.md) | System architecture, API specs, database schemas | No |
| [orchestration](./orchestration/SKILL.md) | Meta-system task orchestration and coordination | No |
| [confidence-check](./confidence-check/SKILL.md) | Pre-implementation confidence assessment (>=90% required) | **Yes** |

### Meta Skills

| Skill | Purpose | Read-Only |
|-------|---------|-----------|
| [sequential-thinking](./sequential-thinking/SKILL.md) | Systematic step-by-step reasoning (MCP integration) | N/A |
| [devops](./devops/SKILL.md) | Build, test, git, cleanup workflows | No |
| [observability](./observability/SKILL.md) | Logging, monitoring, alerting, distributed tracing | No |
| [a11y](./a11y/SKILL.md) | Accessibility audit, WCAG 2.1 AA compliance | **Yes** |

## Skill Activation

Skills activate automatically based on trigger phrases in their descriptions.
Each skill includes "Activates for:" with common trigger keywords.

**Examples:**
- "analyze this code" → `analyze` skill
- "is this secure?" → `security` skill
- "why is this slow?" → `performance` skill
- "implement a feature" → `implement` skill
- "explain how this works" → `explain` skill

## Read-Only Skills

Skills marked **Read-Only** analyze but don't modify code:

| Skill | Safe For | Use Agent For Fixes |
|-------|----------|---------------------|
| `security` | Auditing any codebase | `security-expert` agent |
| `performance` | Measuring without changes | `improve` skill |
| `quality` | Assessing test coverage | `implement` skill |
| `verify` | Validating claims | - |
| `explain` | Educational purposes | - |
| `confidence-check` | Pre-implementation gates | - |

## Skill vs Agent vs Command

| Type | Invocation | Best For |
|------|------------|----------|
| Skill | Automatic (based on context) | Core capabilities |
| Agent | Explicit (`agent`) or delegated | Domain expertise |
| Command | User types `<command>` | Quick workflows |

## Adding New Skills

Use the template at `templates/skill-template/SKILL.md`:

```bash
cp -r templates/skill-template skills/my-new-skill
# Edit skills/my-new-skill/SKILL.md
```

Required frontmatter:
```yaml
---
name: my-new-skill
description: "Purpose. Activates for: 'trigger1', 'trigger2'..."
allowed-tools:
  - Read
  - Grep
  - Glob
---
```
