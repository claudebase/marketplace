# Skill-Centric Plugin Architecture Redesign Report

**Version**: 1.0.0
**Date**: 2025-12-31
**Scope**: Developer Kit Plugin (v4.0.0 → v5.0.0)
**Author**: Architecture Analysis

---

## Executive Summary

This report proposes a **skill-centric architecture** for the Developer Kit plugin that establishes Skills as the primary business logic layer, with Agents and Commands serving as thin orchestration/interface layers. The redesign addresses critical redundancies, tight coupling, and token efficiency issues identified in the current implementation.

### Key Recommendations

| Area             | Current State                 | Proposed State                 | Impact                   |
| ---------------- | ----------------------------- | ------------------------------ | ------------------------ |
| **Skills**       | 24 skills (avg 600 lines)     | 24 skills (target <100 lines)  | 85% token reduction      |
| **Agents**       | 14 agents (avg 880 lines)     | 14 agents (target <300 lines)  | 66% token reduction      |
| **Commands**     | 21 commands (some >500 lines) | 21 commands (target <80 lines) | 75% token reduction      |
| **Architecture** | Mixed responsibilities        | Clear skill-first delegation   | Improved maintainability |

---

## Part A: Current State Analysis

### A.1 Component Hierarchy Overview

```
┌─────────────────────────────────────────────────────────────────────┐
│                         User Request                                 │
└──────────────────────────────┬──────────────────────────────────────┘
                               │
         ┌─────────────────────┼─────────────────────┐
         │                     │                     │
         ▼                     ▼                     ▼
┌─────────────────┐  ┌─────────────────┐  ┌─────────────────────────┐
│   Commands (21) │  │    Skills (24)  │  │      Agents (14)        │
│   Explicit      │  │    Automatic    │  │   Domain Experts        │
│   /command-name │  │    Activation   │  │   Separate Context      │
└────────┬────────┘  └────────┬────────┘  └───────────┬─────────────┘
         │                    │                       │
         └───── delegates-to ─┴───── can preload ─────┘
                              │
                              ▼
         ┌────────────────────────────────────────────┐
         │              MCP Servers (7)               │
         │  sequential-thinking, context7, github,    │
         │  playwright, tavily, shadcn, memory        │
         └────────────────────────────────────────────┘
                              │
                              ▼
         ┌────────────────────────────────────────────┐
         │               Hooks (4)                    │
         │  Event-driven automation & validation      │
         └────────────────────────────────────────────┘
```

### A.2 Component Responsibilities

#### Skills (24 total)

**Purpose**: Context-aware capabilities that auto-activate based on user intent matching.

| Category            | Skills                                                    | Focus                |
| ------------------- | --------------------------------------------------------- | -------------------- |
| Analysis            | analyze, security, performance, quality, test, verify     | Code examination     |
| Implementation      | implement, frontend, database, containers, debug, improve | Code modification    |
| Research & Planning | research, brainstorm, explain, design, confidence-check   | Discovery & planning |
| Infrastructure      | devops, observability, migration, a11y                    | Operations           |
| Meta                | orchestration, document, sequential-thinking              | Coordination         |

**Current Issues**:

- Average SKILL.md is 600 lines (should be <100)
- 10/24 skills exceed 700 lines (VIOLATION)
- 6/24 skills are 500-700 lines (WARNING)
- Full content loaded at startup instead of on-demand

#### Agents (14 total)

**Purpose**: Specialized domain experts running in isolated context.

| Agent                  | Lines | Status   | Preloaded Skills                             |
| ---------------------- | ----- | -------- | -------------------------------------------- |
| python-expert          | 2,457 | CRITICAL | implement, analyze, improve                  |
| observability-engineer | 1,093 | CRITICAL | observability                                |
| technical-writer       | 1,025 | CRITICAL | document                                     |
| learning-guide         | 978   | WARNING  | explain                                      |
| security-expert        | 940   | WARNING  | security                                     |
| requirements-analyst   | 917   | WARNING  | brainstorm                                   |
| database-admin         | 872   | WARNING  | database                                     |
| socratic-mentor        | 765   | WARNING  | explain                                      |
| architect              | 710   | WARNING  | design, analyze, security, devops, implement |
| code-reviewer          | 693   | OK       | analyze, security                            |
| code-explorer          | 615   | OK       | —                                            |
| repo-index             | 526   | OK       | —                                            |
| pm-agent               | 516   | OK       | —                                            |
| business-panel-experts | 250   | OK       | —                                            |

**Current Issues**:

- 3 agents exceed 1,000 lines (CRITICAL)
- 6 agents are 700-1,000 lines (WARNING)
- MCP resource tables duplicated across agents
- Some agents duplicate skill logic instead of delegating

#### Commands (21 total)

**Purpose**: User-invokable workflows via `/developer-kit:command`.

| Category          | Commands                                                             | Delegation Pattern       |
| ----------------- | -------------------------------------------------------------------- | ------------------------ |
| Development (8)   | analyze, build, check, cleanup, code-review, feature-dev, git, start | → devops, analyze skills |
| Planning (4)      | business-panel, estimate, spec-panel, workflow                       | → orchestration          |
| Release (5)       | changelog, migrate, prep-pr, release, ship                           | → devops, migration      |
| Documentation (2) | index, recommend                                                     | → document               |
| Session (2)       | agent, reflect                                                       | → orchestration          |

**Current Issues**:

- cleanup.md is 989 lines (duplicates devops skill)
- build.md is 758 lines (duplicates devops skill)
- estimate.md is 453 lines (could be 100 lines)

#### MCP Servers (7 total)

**Purpose**: External tool integration via Model Context Protocol.

| Server              | Tools Provided        | Primary Use        |
| ------------------- | --------------------- | ------------------ |
| sequential-thinking | Complex reasoning     | All skills/agents  |
| context7            | Documentation lookup  | Implementation     |
| github              | Repository operations | Analysis, review   |
| playwright          | Browser automation    | Testing, frontend  |
| tavily              | Web search            | Research           |
| shadcn              | UI components         | Frontend           |
| memory              | Knowledge persistence | Session management |

**Status**: Well-structured, no issues identified.

#### Hooks (4 configurations)

**Purpose**: Event-driven automation.

| Event            | Hook             | Purpose                   |
| ---------------- | ---------------- | ------------------------- |
| PostToolUse      | format-file.sh   | Auto-format on Write/Edit |
| SessionStart     | version-announce | Display version info      |
| PreToolUse       | validate-bash.sh | Security validation       |
| UserPromptSubmit | skill-eval       | Skill evaluation          |

**Status**: Well-structured, minimal footprint.

### A.3 Architecture Diagram

```
                              ┌─────────────────────────────────────┐
                              │          User Interface             │
                              │  (CLI / IDE / Natural Language)     │
                              └─────────────────┬───────────────────┘
                                                │
                    ┌───────────────────────────┼───────────────────────────┐
                    │                           │                           │
                    ▼                           ▼                           ▼
┌───────────────────────────┐   ┌───────────────────────────┐   ┌───────────────────────────┐
│       COMMANDS            │   │         SKILLS            │   │         AGENTS            │
│   (Explicit Invocation)   │   │   (Auto-Activation)       │   │   (Domain Expertise)      │
│                           │   │                           │   │                           │
│ • /analyze               │   │ • Trigger: "analyze code" │   │ • architect              │
│ • /ship                  │   │ • Trigger: "security"     │   │ • code-reviewer          │
│ • /check                 │   │ • Trigger: "implement"    │   │ • security-expert        │
│                           │   │                           │   │                           │
│ Delegation:               │   │ Capabilities:             │   │ Isolation:                │
│ delegates-to: skill       │   │ • Business logic          │   │ • Separate context        │
│ operation: mode           │   │ • Tool restrictions       │   │ • Own tool access         │
│                           │   │ • Progressive disclosure  │   │ • Can preload skills      │
└─────────────┬─────────────┘   └─────────────┬─────────────┘   └─────────────┬─────────────┘
              │                               │                               │
              └───────────────────────────────┼───────────────────────────────┘
                                              │
                                              ▼
                              ┌─────────────────────────────────────┐
                              │         MCP SERVERS                 │
                              │  (External Tool Integration)        │
                              │                                     │
                              │  context7: Documentation lookup     │
                              │  github: Repository operations      │
                              │  playwright: Browser automation     │
                              │  tavily: Web research               │
                              │  sequential-thinking: Reasoning     │
                              │  shadcn: UI components              │
                              │  memory: Knowledge persistence      │
                              └─────────────────────────────────────┘
```

### A.4 Identified Redundancies

#### Redundancy 1: Command-Skill Duplication

Commands embed logic that should live in skills:

| Command     | Lines | Should Delegate To | Actual Duplication    |
| ----------- | ----- | ------------------ | --------------------- |
| cleanup.md  | 989   | devops             | Full cleanup workflow |
| build.md    | 758   | devops             | Full build patterns   |
| estimate.md | 453   | orchestration      | Estimation framework  |

**Impact**: ~2,200 duplicated lines, increased maintenance burden.

#### Redundancy 2: Agent MCP Tables

Multiple agents contain identical MCP library reference tables:

```markdown
# Appears in python-expert, architect, security-expert, etc.

| Resource | Library ID                     | Snippets | Use Case   |
| -------- | ------------------------------ | -------- | ---------- |
| FastAPI  | /websites/fastapi_tiangolo     | 31,710   | APIs       |
| Django   | /websites/djangoproject_en_6_0 | 10,667   | Full-stack |

...
```

**Impact**: ~500 lines duplicated across 8+ agents (~4,000 total).

#### Redundancy 3: Skill Overlap

Several skills have overlapping capabilities:

| Skill A | Skill B     | Overlap              |
| ------- | ----------- | -------------------- |
| analyze | security    | Security analysis    |
| analyze | performance | Performance analysis |
| quality | test        | Test coverage        |
| explain | document    | Documentation        |
| devops  | containers  | Build/deploy         |

**Current Solution**: Mode-based routing in `analyze` command.
**Issue**: Logic for routing exists in both command AND skills.

### A.5 Coupling Issues

#### Tight Coupling 1: Agent-Skill Logic Duplication

Agents embed implementation logic instead of delegating:

```markdown
# In python-expert.md (2,457 lines)

## FastAPI Implementation Patterns

[Full FastAPI patterns that should be in implement skill]

## Testing Strategies

[Full testing patterns that should be in test skill]
```

**Fix**: Agents should invoke skills, not duplicate their content.

#### Tight Coupling 2: Command Workflow Embedding

Commands contain full workflows instead of orchestrating skills:

```markdown
# In cleanup.md (989 lines)

## Phase 1: Detection

[Full detection workflow]

## Phase 2: Analysis

[Full analysis workflow]

## Phase 3: Cleanup

[Full cleanup workflow]
```

**Fix**: Commands should delegate phases to skills.

#### Tight Coupling 3: MCP Tool Usage Patterns

MCP usage patterns are embedded in every skill/agent instead of being referenced:

```yaml
# Repeated in 20+ files
mcp__context7__resolve-library-id("library-name")
mcp__context7__query-docs(libraryId, "query")
```

**Fix**: Create shared reference for MCP patterns.

### A.6 Reusability Analysis

#### What Enables Reuse (Good Patterns)

1. **Skill composition in agents**: `skills: design, analyze, security`
2. **Command delegation**: `delegates-to: devops`
3. **Reference files**: `skills/analyze/references/patterns.md`
4. **Shared MCP resources**: `lib/shared-references/mcp-resources.md` (recently added)

#### What Prevents Reuse (Anti-Patterns)

1. **Inline implementation**: Logic in agents/commands instead of skills
2. **Missing abstractions**: No shared patterns for common workflows
3. **Oversized skills**: Too much in SKILL.md, forcing full load
4. **Agent self-sufficiency**: Agents don't leverage skills enough

### A.7 Extension Points

| Extension Type | Location                   | Mechanism                       |
| -------------- | -------------------------- | ------------------------------- |
| New Skill      | `skills/my-skill/SKILL.md` | Auto-discovery via pattern      |
| New Agent      | `agents/my-agent.md`       | Registration in plugin          |
| New Command    | `commands/category/cmd.md` | Namespace: `/developer-kit:cmd` |
| New Hook       | `hooks/hooks.json`         | Event matching                  |
| New MCP Server | `.mcp.json`                | Server configuration            |

---

## Part B: Proposed Skill-Centric Architecture

### B.1 Core Principle

> **Skills are the primary business logic layer. Agents and Commands are thin orchestration/interface layers that delegate to Skills.**

```
┌──────────────────────────────────────────────────────────────────────────┐
│                        SKILL-CENTRIC HIERARCHY                           │
└──────────────────────────────────────────────────────────────────────────┘

                    ┌─────────────────────────────────────┐
                    │        INTERFACE LAYER              │
                    │  Commands (20-80 lines each)        │
                    │  • Route user intent                │
                    │  • Parse arguments                  │
                    │  • Delegate to skills/agents        │
                    └─────────────────┬───────────────────┘
                                      │
                    ┌─────────────────┴───────────────────┐
                    │                                     │
                    ▼                                     ▼
    ┌───────────────────────────────┐   ┌───────────────────────────────┐
    │      ORCHESTRATION LAYER      │   │        SKILL LAYER            │
    │   Agents (200-300 lines)      │   │   Skills (50-100 lines)       │
    │   • Domain expertise          │   │   • Core business logic       │
    │   • Multi-skill composition   │   │   • Tool restrictions         │
    │   • Isolated context          │   │   • Progressive disclosure    │
    │   • Complex task handling     │   │   • Reusable capabilities     │
    └───────────────┬───────────────┘   └───────────────┬───────────────┘
                    │                                   │
                    └─────────────────┬─────────────────┘
                                      │
                    ┌─────────────────┴───────────────────┐
                    │          CAPABILITY LAYER           │
                    │   MCP Servers + Standard Tools      │
                    │   • External integrations           │
                    │   • File operations                 │
                    │   • Web access                      │
                    │   • Browser automation              │
                    └─────────────────────────────────────┘
```

### B.2 Redesigned Component Responsibilities

#### Skills: The Business Logic Layer

```yaml
Purpose: "Encapsulate reusable business logic and domain knowledge"

Responsibilities:
  - Core implementation patterns
  - Tool usage constraints
  - Domain-specific methodology
  - Progressive disclosure of knowledge

Size Target: 50-100 lines per SKILL.md

Structure:
  skills/my-skill/
  ├── SKILL.md              # Frontmatter + overview (50-100 lines)
  └── references/
      ├── guide.md          # Detailed behavioral flow
      ├── patterns.md       # Implementation patterns
      └── examples.md       # Real-world examples

Frontmatter:
  name: skill-name
  description: "Concise purpose. Activates for: 'trigger1', 'trigger2'"
  allowed-tools: [Read, Grep, Glob, ...]
  composable: true          # Can combine with other skills
  mode: read-only|read-write
```

#### Agents: The Orchestration Layer

```yaml
Purpose: "Provide domain expertise by composing skills with isolated context"

Responsibilities:
  - Domain-specific decision making
  - Multi-skill coordination
  - Complex task decomposition
  - Specialized tool access

Size Target: 200-300 lines per agent

Structure:
  agents/
  ├── architect.md          # Main agent file (200-300 lines)
  └── references/           # Shared agent references
      └── patterns.md       # Common patterns

Frontmatter:
  name: agent-name
  description: "Purpose and triggers"
  tools: Read, Grep, Glob, Write, Edit, Bash, Task
  skills: design, analyze, security   # Skills to compose
  model: sonnet
  expertise: "Domain expertise statement"
```

#### Commands: The Interface Layer

```yaml
Purpose: "Provide explicit user interface with argument parsing"

Responsibilities:
  - Argument parsing
  - Mode selection
  - Skill/agent delegation
  - Output formatting

Size Target: 20-80 lines per command

Structure: commands/category/
  └── my-command.md # Thin wrapper (20-80 lines)

Frontmatter:
  name: command-name
  description: "What command does"
  argument-hint: "[--mode <type>] [target]"
  delegates-to: skill-name
  operation: specific-mode
```

### B.3 Interface Contracts

#### Skill Interface Contract

```typescript
interface SkillContract {
  // Required frontmatter
  name: string; // kebab-case identifier
  description: string; // Purpose + "Activates for:" triggers

  // Optional frontmatter
  allowedTools?: string[]; // Tool restrictions
  composable?: boolean; // Can combine with others
  mode?: "read-only" | "read-write";

  // Content structure
  overview: string; // 2-3 sentence purpose
  whenToUse: string[]; // Trigger scenarios
  whenNotToUse: string[]; // Boundary cases
  quickWorkflow: string; // 3-5 step summary
  references: string[]; // Links to reference files
}
```

#### Agent Interface Contract

```typescript
interface AgentContract {
  // Required frontmatter
  name: string;
  description: string;
  tools: string; // Comma-separated tool list

  // Optional frontmatter
  skills?: string; // Skills to preload
  model?: "sonnet" | "opus" | "haiku";
  expertise?: string; // Domain expertise statement
  permissionMode?: "default" | "plan" | "acceptEdits";

  // Content structure
  purpose: string; // 2-3 sentence role
  triggers: string[]; // When to delegate
  operatingProcedure: string; // Phased workflow
  toolUsage: string; // MCP integration (reference only)
  boundaries: {
    will: string[];
    willNot: string[];
  };
}
```

#### Command Interface Contract

```typescript
interface CommandContract {
  // Required frontmatter
  description: string;

  // Optional frontmatter
  name?: string; // Override namespace
  argumentHint?: string; // Usage hint
  delegatesTo?: string; // Target skill
  operation?: string; // Operation mode

  // Content structure
  usage: string; // Syntax example
  arguments: ArgumentSpec[]; // Argument table
  examples: string[]; // Usage examples
  seealso: string[]; // Related skills/commands
}
```

### B.4 Clear Separation of Concerns

| Layer       | Concern              | Example                                     |
| ----------- | -------------------- | ------------------------------------------- |
| **Command** | User interface       | Parse `--mode security`, validate arguments |
| **Agent**   | Domain orchestration | Coordinate security + analyze skills        |
| **Skill**   | Business logic       | Perform OWASP analysis methodology          |
| **MCP**     | External capability  | Query Context7 for vulnerability patterns   |
| **Hook**    | Automation           | Auto-format code after Write                |

### B.5 Proposed Directory Structure

```
developer-kit/
├── .claude-plugin/
│   └── plugin.json                 # v5.0.0 manifest
│
├── lib/
│   └── shared-references/
│       ├── mcp-resources.md        # Consolidated MCP library IDs
│       ├── tool-patterns.md        # Common tool integration patterns
│       └── common-workflows.md     # Shared workflow patterns
│
├── agents/                         # FLAT structure required
│   ├── architect.md                # 200-300 lines
│   ├── code-reviewer.md
│   ├── security-expert.md
│   └── ...
│
├── skills/                         # FLAT structure required
│   ├── analyze/
│   │   ├── SKILL.md                # 50-100 lines
│   │   └── references/
│   │       ├── guide.md            # Detailed methodology
│   │       ├── patterns.md         # Analysis patterns
│   │       └── output-format.md    # Report templates
│   ├── implement/
│   │   ├── SKILL.md
│   │   └── references/
│   └── ...
│
├── commands/                       # Categorized
│   ├── development/
│   │   ├── analyze.md              # 20-80 lines
│   │   ├── check.md
│   │   └── ...
│   ├── planning/
│   ├── release/
│   ├── documentation/
│   └── session/
│
├── hooks/
│   └── hooks.json
│
└── .mcp.json
```

---

## Part C: Migration Strategy

### C.1 Migration Overview

```
Phase 0: Preparation           (1 day)
Phase 1: Critical Skills       (3 days)
Phase 2: Warning Skills        (2 days)
Phase 3: Critical Agents       (2 days)
Phase 4: Warning Agents        (2 days)
Phase 5: Commands              (2 days)
Phase 6: Testing & Validation  (2 days)
─────────────────────────────────────────
Total:                         14 days
```

### C.2 Phase 0: Preparation

#### Create Shared Resources

```bash
# Already created, verify:
ls lib/shared-references/
# Should contain: mcp-resources.md, tool-integration-patterns.md
```

#### Create Templates

```bash
# Skill template
mkdir -p templates/skill-template
cat > templates/skill-template/SKILL.md << 'EOF'
---
name: skill-name
description: "Purpose. Activates for: 'trigger1', 'trigger2'."
allowed-tools:
  - Read
  - Grep
  - Glob
composable: true
mode: read-write
---

# Skill Name

Brief overview (2-3 sentences).

## When to Use

- Trigger scenario 1
- Trigger scenario 2

## When NOT to Use

- Alternative → use `other-skill`

## Quick Workflow

1. Step 1
2. Step 2
3. Step 3

## References

- [Guide](references/guide.md) - Detailed methodology
- [Patterns](references/patterns.md) - Implementation patterns
EOF
```

### C.3 Phase 1: Critical Skills (10 skills, >700 lines)

**Priority Order** (by token impact):

| Rank | Skill         | Current | Target | Action                           |
| ---- | ------------- | ------- | ------ | -------------------------------- |
| 1    | containers    | 1,055   | 80     | Move phases to guide.md          |
| 2    | observability | 1,010   | 80     | Move stack configs to references |
| 3    | database      | 965     | 80     | Move ORM patterns to references  |
| 4    | migration     | 892     | 80     | Move strategies to references    |
| 5    | implement     | 811     | 80     | Move framework patterns          |
| 6    | devops        | 766     | 80     | Move CI/CD templates             |
| 7    | research      | 738     | 80     | Move search strategies           |
| 8    | test          | 680     | 80     | Move framework detection         |
| 9    | security      | 653     | 80     | Move OWASP checklist             |
| 10   | performance   | 536     | 80     | Move profiling guides            |

**Migration Pattern for Each Skill**:

```bash
# 1. Create reference files
mkdir -p skills/my-skill/references

# 2. Move behavioral flow
mv "Behavioral Flow" section → references/guide.md

# 3. Move patterns
mv "Phase X" sections → references/guide.md

# 4. Move examples
mv code examples → references/patterns.md

# 5. Rewrite SKILL.md
# Keep: frontmatter, overview, triggers, workflow summary, references

# 6. Verify
wc -l skills/my-skill/SKILL.md  # Target: <100
```

### C.4 Phase 2: Warning Skills (6 skills, 500-700 lines)

| Skill         | Current | Target |
| ------------- | ------- | ------ |
| quality       | 601     | 80     |
| orchestration | 599     | 80     |
| document      | 582     | 80     |
| improve       | 564     | 80     |
| explain       | 553     | 80     |
| debug         | 551     | 80     |

Same migration pattern as Phase 1.

### C.5 Phase 3: Critical Agents (4 agents, >1000 lines)

**Priority Order**:

| Rank | Agent                  | Current | Target | Action                                 |
| ---- | ---------------------- | ------- | ------ | -------------------------------------- |
| 1    | python-expert          | 2,457   | 300    | Extract MCP tables, framework patterns |
| 2    | observability-engineer | 1,093   | 300    | Extract stack configs                  |
| 3    | technical-writer       | 1,025   | 300    | Extract templates                      |
| 4    | learning-guide         | 978     | 300    | Extract example libraries              |

**Migration Pattern for Agents**:

```bash
# 1. Extract MCP library tables
# Move ALL library ID tables to lib/shared-references/mcp-resources.md

# 2. Extract domain patterns
mkdir -p agents/references
mv domain patterns → agents/references/python-patterns.md

# 3. Ensure skills field is set
# Agent should preload skills instead of embedding logic
skills: implement, analyze, improve

# 4. Rewrite agent file
# Keep: frontmatter, purpose, triggers, workflow, boundaries, references

# 5. Verify
wc -l agents/my-agent.md  # Target: <300
```

### C.6 Phase 4: Warning Agents (5 agents, 700-1000 lines)

| Agent                | Current | Target |
| -------------------- | ------- | ------ |
| security-expert      | 940     | 300    |
| requirements-analyst | 917     | 300    |
| database-admin       | 872     | 300    |
| socratic-mentor      | 765     | 300    |
| architect            | 710     | 300    |

### C.7 Phase 5: Commands

**Commands to Refactor**:

| Command     | Current | Target | Delegation                 |
| ----------- | ------- | ------ | -------------------------- |
| cleanup.md  | 989     | 80     | devops (cleanup operation) |
| build.md    | 758     | 80     | devops (build operation)   |
| estimate.md | 453     | 100    | orchestration              |

**Target Command Structure**:

```yaml
---
name: cleanup
description: "Code cleanup and dead code removal"
argument-hint: "[target] [--type code|imports|files]"
delegates-to: devops
operation: cleanup
---

# cleanup

Remove unused code, imports, and files.

## Usage
/developer-kit:cleanup [target] [options]

## Arguments
| Arg | Description | Default |
|-----|-------------|---------|
| target | Directory | . |
| --type | Cleanup type | all |

## Examples
/developer-kit:cleanup
/developer-kit:cleanup src/ --type imports

## See Also
- devops skill
```

### C.8 Backward Compatibility

#### Preserved Interfaces

- All command names remain unchanged
- All skill triggers remain unchanged
- All agent invocations remain unchanged
- All MCP tool names remain unchanged

#### Migration Notes

- Reference file paths changed (update any hard-coded paths)
- Some skills may have slightly different behavior due to streamlining
- Test all skills after migration

### C.9 Deprecation Path

| Deprecated              | Replacement                            | Timeline |
| ----------------------- | -------------------------------------- | -------- |
| Large SKILL.md files    | SKILL.md + references/                 | v5.0.0   |
| Embedded MCP tables     | lib/shared-references/mcp-resources.md | v5.0.0   |
| Command-embedded logic  | Skill delegation                       | v5.0.0   |
| Agent-embedded patterns | Skill preloading                       | v5.0.0   |

---

## Part D: Design Guidelines

### D.1 When to Create a Skill vs Embedding Logic

| Create a Skill When               | Embed in Agent/Command When           |
| --------------------------------- | ------------------------------------- |
| Logic is reusable across contexts | Logic is specific to one agent        |
| Capability can auto-activate      | Workflow requires explicit invocation |
| Tool restrictions are needed      | Full tool access required             |
| Progressive disclosure benefits   | Logic is under 50 lines               |
| Multiple agents need it           | Single-use orchestration              |

### D.2 Skill Composition Patterns

#### Pattern 1: Agent Skill Preloading

```yaml
# In agent frontmatter
skills: design, analyze, security
```

Agent gets access to all three skills' knowledge.

#### Pattern 2: Skill Mode Selection

```yaml
# In skill frontmatter
mode: read-only  # For analysis skills
mode: read-write # For implementation skills
```

#### Pattern 3: Composable Skills

```yaml
# In skill frontmatter
composable: true # Can run alongside other skills
```

### D.3 Best Practices for Minimal Agents

```markdown
## Agent Design Checklist

✓ Does the agent preload skills instead of embedding logic?
✓ Is the agent file under 300 lines?
✓ Does it reference shared MCP resources?
✓ Are patterns in reference files, not inline?
✓ Is there a clear expertise statement?
✓ Are boundaries explicit (will/will not)?
```

### D.4 Best Practices for Minimal Commands

```markdown
## Command Design Checklist

✓ Is the command under 80 lines?
✓ Does it delegate to a skill via delegates-to?
✓ Are arguments clearly documented?
✓ Are examples provided?
✓ Does it reference related skills?
```

### D.5 Progressive Disclosure Pattern

```
SKILL.md (50-100 lines)
├── Frontmatter (10-20 lines)
├── Overview (2-3 sentences)
├── When to Use (bullet list)
├── When NOT to Use (bullet list)
├── Quick Workflow (3-5 steps)
└── References (links)

references/
├── guide.md (full methodology)
├── patterns.md (implementation patterns)
├── checklist.md (validation checklist)
└── examples.md (real-world examples)
```

### D.6 MCP Integration Guidelines

```markdown
## MCP Tool Usage

DO:

- Reference lib/shared-references/mcp-resources.md for library IDs
- Use lib/shared-references/tool-integration-patterns.md for usage patterns
- Include MCP tools in allowed-tools when needed

DON'T:

- Embed library ID tables in skills/agents
- Duplicate tool usage examples across files
- Hard-code library IDs (use resolve first)
```

### D.7 Skill Boundary Guidelines

| Skill Type         | Can Modify Code | Primary Use              |
| ------------------ | --------------- | ------------------------ |
| **Analysis**       | No              | Auditing, finding issues |
| **Implementation** | Yes             | Creating, modifying      |
| **Research**       | No              | Discovery, documentation |
| **Orchestration**  | Maybe           | Task coordination        |

```yaml
# Read-only skill pattern
mode: read-only
allowed-tools:
  - Read
  - Grep
  - Glob
  # NO Write, Edit, Bash

# Read-write skill pattern
mode: read-write
allowed-tools:
  - Read
  - Grep
  - Glob
  - Write
  - Edit
  - Bash
```

---

## Part E: Success Metrics

### E.1 Token Efficiency Targets

| Component         | Before   | After   | Reduction |
| ----------------- | -------- | ------- | --------- |
| Skills at startup | ~100,000 | ~5,000  | 95%       |
| Agents at startup | ~25,000  | ~7,500  | 70%       |
| Commands          | ~10,000  | ~3,000  | 70%       |
| **Total**         | ~135,000 | ~15,500 | **89%**   |

### E.2 Component Size Targets

| Component | Max Lines | Verification              |
| --------- | --------- | ------------------------- |
| SKILL.md  | 100       | `wc -l skills/*/SKILL.md` |
| Agent     | 300       | `wc -l agents/*.md`       |
| Command   | 80        | `wc -l commands/**/*.md`  |

### E.3 Validation Checklist

```markdown
## Post-Migration Validation

### Skills

- [ ] All SKILL.md files under 100 lines
- [ ] All skills have references/ directory
- [ ] All skills activate on trigger phrases
- [ ] All allowed-tools work correctly

### Agents

- [ ] All agents under 300 lines
- [ ] All agents reference shared MCP resources
- [ ] All agents preload required skills
- [ ] All agents invoke correctly

### Commands

- [ ] All commands under 80 lines
- [ ] All commands delegate to skills
- [ ] All command arguments work
- [ ] All examples execute correctly

### Integration

- [ ] Token usage at startup under 20,000
- [ ] All workflows function correctly
- [ ] No regressions in functionality
```

---

## Conclusion

The skill-centric architecture redesign transforms the Developer Kit from a collection of large, overlapping components into a lean, composable system. By establishing Skills as the primary business logic layer and reducing Agents and Commands to thin orchestration wrappers, we achieve:

1. **89% reduction in startup token usage** - From ~135,000 to ~15,500 tokens
2. **Clear separation of concerns** - Each layer has distinct responsibilities
3. **Improved maintainability** - Changes to logic only need to happen in skills
4. **Better reusability** - Skills compose easily across agents and commands
5. **Reduced redundancy** - Shared references eliminate duplication

The migration can be completed in 14 days following the phased approach, with backward compatibility maintained throughout.

---

## Appendix: Quick Reference Cards

### Skill Template (50-100 lines)

```yaml
---
name: skill-name
description: "Purpose. Activates for: 'trigger1', 'trigger2'."
allowed-tools: [Read, Grep, Glob]
composable: true
mode: read-only
---

# Skill Name

Brief overview.

## When to Use
- Scenario 1
- Scenario 2

## When NOT to Use
- Alternative → use `other-skill`

## Quick Workflow
1. Step 1
2. Step 2
3. Step 3

## References
- [Guide](references/guide.md)
```

### Agent Template (200-300 lines)

```yaml
---
name: agent-name
description: "Purpose and triggers"
tools: Read, Grep, Glob, Write, Edit, Bash, Task
skills: skill1, skill2
model: sonnet
expertise: "Domain expertise"
---

# Agent Name

## Purpose
2-3 sentence purpose.

## Triggers
- Trigger 1
- Trigger 2

## Workflow
1. Phase 1
2. Phase 2
3. Phase 3

## Tool Usage
See [MCP Resources](../lib/shared-references/mcp-resources.md).

## Boundaries
**Will**: Action 1, Action 2
**Will NOT**: Action 3, Action 4

## References
- [Patterns](../lib/shared-references/patterns.md)
```

### Command Template (20-80 lines)

```yaml
---
description: "What command does"
argument-hint: "[target] [--option]"
delegates-to: skill-name
---

# command-name

Brief description.

## Usage
/developer-kit:command-name [args]

## Arguments
| Arg | Description | Default |
|-----|-------------|---------|

## Examples
/developer-kit:command-name

## See Also
- skill-name skill
```

---

_Report generated for Developer Kit Plugin architecture redesign_
