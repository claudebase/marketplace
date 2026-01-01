# Architecture & Contributing Guide

This document covers the Developer Kit plugin architecture, conventions, and guidelines for contributing.

---

## Skill-Centric Architecture

> **Core Principle**: Skills are the primary business logic layer. Agents and Commands are thin orchestration/interface layers that delegate to Skills.

### Component Hierarchy

```
┌──────────────────────────────────────────────────────────────────────────┐
│                        SKILL-CENTRIC HIERARCHY                           │
└──────────────────────────────────────────────────────────────────────────┘

                    ┌─────────────────────────────────────┐
                    │        INTERFACE LAYER              │
                    │  Commands (21) - 20-80 lines each   │
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
    │   Agents (14) - 200-300 lines │   │   Skills (24) - 50-100 lines  │
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
                    │   MCP Servers (7) + Hooks (4)       │
                    │   • External integrations           │
                    │   • Event automation                │
                    │   • Browser automation              │
                    │   • Web research                    │
                    └─────────────────────────────────────┘
```

### Component Size Targets

| Component | Max Lines | Purpose                                         |
| --------- | --------- | ----------------------------------------------- |
| SKILL.md  | 100       | Core business logic with progressive disclosure |
| Agent     | 300       | Domain expertise, skill composition             |
| Command   | 80        | Thin wrapper, delegation to skills              |

### Directory Structure

```
developer-kit/
├── .claude-plugin/
│   └── plugin.json          # Plugin manifest (REQUIRED)
├── .mcp.json                 # MCP server configuration
├── .lsp.json                 # LSP server configuration
│
├── commands/                 # Slash commands
│   ├── development/          # Build, test, review
│   ├── planning/             # Estimation, workflows
│   ├── release/              # Versioning, deployment
│   ├── documentation/        # Indexing, recommendations
│   └── session/              # Orchestration, reflection
│
├── agents/                   # Agent definitions (FLAT)
│   ├── architect.md
│   ├── code-reviewer.md
│   └── ...
│
├── skills/                   # Skill definitions (FLAT)
│   ├── analyze/
│   │   ├── SKILL.md          # Main skill file
│   │   └── references/       # Supporting docs
│   ├── implement/
│   └── ...
│
├── hooks/
│   ├── hooks.json            # Hook configuration
│   └── security_reminder_hook.py
│
├── scripts/                  # Utility scripts
│   ├── format-file.sh
│   ├── validate-bash-command.sh
│   ├── test-components.sh
│   └── ...
│
├── templates/                # Reusable templates
│   ├── ci-cd/
│   ├── docker/
│   ├── kubernetes/
│   └── adr/
│
└── docs/                     # Documentation
    ├── GETTING-STARTED.md
    ├── SKILLS.md
    ├── AGENTS.md
    ├── COMMANDS.md
    ├── HOOKS.md
    ├── MCP.md
    └── workflows/
```

---

## Critical Constraints

### 1. Skills Must Be Flat

```
✅ CORRECT
skills/
├── analyze/
│   └── SKILL.md
├── implement/
│   └── SKILL.md

❌ WRONG
skills/
├── analysis/
│   ├── analyze/
│   │   └── SKILL.md    # Nested - won't be discovered!
```

**Reason**: Claude Code discovers skills by scanning `skills/*/SKILL.md` only.

### 2. Agents Must Be Flat

```
✅ CORRECT
agents/
├── architect.md
├── code-reviewer.md

❌ WRONG
agents/
├── development/
│   └── architect.md    # Won't be discovered!
```

### 3. Required Frontmatter

**Skills** - must have `name` and `description`:

```yaml
---
name: skill-name
description: "Purpose. Activates for: 'trigger1', 'trigger2'..."
---
```

**Agents** - must have `name`, `description`, `tools`:

```yaml
---
name: agent-name
description: "Purpose and when to invoke"
tools: Read, Grep, Glob
---
```

**Commands** - must have `description`:

```yaml
---
description: "What this command does"
---
```

### 4. Description Patterns (Emphatic Triggers)

**Skills**:

```yaml
# ✅ CORRECT - Emphatic trigger pattern
description: "**PROACTIVELY activate for security concerns**. OWASP-based audit methodology. Activates for: 'security', 'vulnerabilities', 'OWASP', 'is this secure'."

# ❌ WRONG - No emphatic trigger, no activation phrases
description: "Security audit and vulnerability scanning"
```

**Commands**:

```yaml
# ✅ CORRECT - Emphatic trigger with delegation
description: "**Use for release shipping**. Full workflow: validate, version, changelog, tag. Delegates to: orchestration. Activates for: ship release, deploy."

# ❌ WRONG - Missing emphatic trigger
description: "Ship a release with version bump and changelog"
```

**Agents**:

```yaml
# ✅ CORRECT - Purpose with triggers
description: "**Session controller**. Orchestrates investigation, implementation, and review. Delegates to: orchestration. Activates for: complex task, multi-phase workflow."
```

### 5. No Hardcoded Secrets

```json
// ✅ CORRECT
"env": {
  "API_KEY": "${API_KEY}"
}

// ❌ WRONG
"env": {
  "API_KEY": "sk-abc123..."
}
```

---

## Frontmatter Specification

### Skill Frontmatter

| Field           | Required | Type   | Description                         |
| --------------- | -------- | ------ | ----------------------------------- |
| `name`          | Yes      | string | Kebab-case identifier               |
| `description`   | Yes      | string | Purpose + "Activates for:" triggers |
| `allowed-tools` | No       | array  | Tool restrictions                   |
| `model`         | No       | string | Model override                      |
| `license`       | No       | string | License reference                   |

### Agent Frontmatter

| Field            | Required | Type   | Description                 |
| ---------------- | -------- | ------ | --------------------------- |
| `name`           | Yes      | string | Unique identifier           |
| `description`    | Yes      | string | Purpose and when to invoke  |
| `tools`          | Yes      | string | Comma-separated tool list   |
| `model`          | No       | string | sonnet, opus, haiku         |
| `permissionMode` | No       | string | default, plan, acceptEdits  |
| `skills`         | No       | string | Comma-separated skill names |

### Command Frontmatter

| Field           | Required | Type   | Description          |
| --------------- | -------- | ------ | -------------------- |
| `description`   | Yes      | string | What command does    |
| `argument-hint` | No       | string | Usage hint for /help |
| `delegates-to`  | No       | string | Skill delegation     |
| `operation`     | No       | string | Operation mode       |

---

## Adding Components

### Adding a New Skill

1. **Create directory and file**:

```bash
mkdir skills/my-skill
cp templates/skill-template/SKILL.md skills/my-skill/SKILL.md
```

2. **Edit frontmatter**:

```yaml
---
name: my-skill
description: "Purpose of skill. Activates for: 'trigger1', 'trigger2', 'trigger3'..."
allowed-tools:
  - Read
  - Grep
  - Glob
---
```

3. **Add content**:

```markdown
# My Skill

## Purpose

What this skill does...

## When to Use

- Condition 1
- Condition 2

## Methodology

1. Step 1
2. Step 2

## Output Format

...
```

4. **Add references** (optional):

```bash
mkdir skills/my-skill/references
# Add supporting documentation
```

5. **Validate**:

```bash
./scripts/validate-skill-descriptions.sh
```

### Adding a New Agent

1. **Create file**:

```bash
cp templates/agent-template.md agents/my-agent.md
```

2. **Edit frontmatter**:

```yaml
---
name: my-agent
description: "What this agent does. Invoke for: 'trigger1', 'trigger2'"
tools: Read, Grep, Glob, Write, Edit, Bash
model: sonnet
---
```

3. **Add content**:

```markdown
# My Agent

Purpose and methodology...

## Capabilities

- Capability 1
- Capability 2

## When to Use

...

## Output Format

...
```

4. **Validate**:

```bash
./scripts/validate-agent-fields.sh
```

### Adding a New Command

1. **Create file**:

```bash
# Choose appropriate category
touch commands/development/my-command.md
```

2. **Edit content**:

```yaml
---
description: "What this command does"
argument-hint: "[--flag <value>] [args]"
delegates-to: skill-name
---

# my-command - Command Title

## Usage
\`\`\`
my-command [options]
\`\`\`

## Options
| Option | Description |
|--------|-------------|
| `--flag` | What it does |

## Examples
\`\`\`
my-command --flag value
\`\`\`
```

3. **Validate**:

```bash
./scripts/check-frontmatter.sh
```

---

## Testing

### Full Test Suite

```bash
./scripts/test-components.sh
```

Runs 89+ tests covering:

- Structure validation
- Skill validation
- Agent validation
- Command validation
- Hook validation
- Reference validation

### Individual Validators

```bash
# Validate skill descriptions
./scripts/validate-skill-descriptions.sh

# Validate agent fields
./scripts/validate-agent-fields.sh

# Validate reference links
./scripts/validate-references.sh

# Check frontmatter syntax
./scripts/check-frontmatter.sh

# Quick component count
./scripts/validate-components.sh
```

### Testing Hooks

```bash
# Test hook script
echo '{"tool_name": "Write"}' | ./scripts/format-file.sh

# Test Python hook
echo '{}' | python3 hooks/security_reminder_hook.py
```

---

## Version Management

When releasing a new version:

1. **Update plugin.json**:

```json
{
  "version": "4.1.0"
}
```

2. **Update hooks.json SessionStart**:

```json
"command": "echo 'Developer Kit v4.1.0 | Skills: 24 | Agents: 14'"
```

3. **Update CHANGELOG.md**:

```markdown
## [4.1.0] - YYYY-MM-DD

### Added

- New feature...

### Changed

- Updated...
```

4. **Update test expectations** (if counts changed):

```bash
# In test-components.sh
EXPECTED_SKILLS=25  # if added skill
```

5. **Run full validation**:

```bash
./scripts/test-components.sh
```

---

## Code Style

### Skill Files

- Keep `SKILL.md` under 100 lines (target: 50-100)
- Use progressive disclosure (reference files for detailed content)
- Include clear "When to Use" and "When NOT to Use" sections
- Include "Quick Workflow" (3-5 steps)
- Cross-reference related skills/agents

### Agent Files

- Keep agents under 300 lines (target: 200-300)
- Focus on domain expertise and skill composition
- Include clear invocation triggers in description
- Reference shared MCP resources (don't embed tables)
- Include Boundaries (Will/Will Not sections)

### Command Files

- Keep commands under 80 lines (target: 20-80)
- Commands are thin wrappers that delegate to skills
- Include usage syntax and examples
- Use emphatic trigger in description

### Scripts

- Use bash for shell scripts
- Return JSON from hooks
- Use proper exit codes (0=success, 2=block)
- Include error handling

---

## Pull Request Checklist

Before submitting:

- [ ] Run `./scripts/test-components.sh` (all tests pass)
- [ ] Skill has "Activates for:" in description
- [ ] Agent has required frontmatter (name, description, tools)
- [ ] Command has description frontmatter
- [ ] No hardcoded secrets
- [ ] Reference files exist (if linked)
- [ ] CHANGELOG.md updated (for features)
- [ ] README.md updated (if needed)

---

## Common Patterns

### Skill Delegation

Commands delegate to skills:

```yaml
---
description: "Run security audit"
delegates-to: security
operation: audit
---
```

### MCP Tool Usage

In skills:

```yaml
allowed-tools:
  - mcp__sequential-thinking__sequentialthinking
  - mcp__context7__resolve-library-id
```

In agents:

```yaml
tools: Read, Grep, mcp__playwright__browser_navigate
```

### Read-Only Skills

For analysis-only skills:

```yaml
allowed-tools:
  - Read
  - Grep
  - Glob
  # No Write, Edit, Bash
```

Note in description:

```yaml
description: "Security audit (READ-ONLY). Activates for:..."
```

### Reference Files

Structure supporting documentation:

```
skills/my-skill/
├── SKILL.md
└── references/
    ├── patterns.md
    ├── checklist.md
    └── examples.md
```

Reference in SKILL.md:

```markdown
## References

- `references/patterns.md` - Common patterns
- `references/checklist.md` - Validation checklist
```

---

## Troubleshooting Development

### Skill Not Discovered

1. Check structure: `skills/<name>/SKILL.md`
2. Verify not nested in subdirectory
3. Check YAML frontmatter syntax

### Agent Not Available

1. Check structure: `agents/<name>.md`
2. Verify frontmatter has required fields
3. Check tools list is comma-separated

### Command Not Working

1. Check frontmatter has description
2. Verify file is in commands/ directory
3. Restart Claude Code after changes

### Hooks Not Executing

1. Check hooks.json syntax: `cat hooks/hooks.json | jq .`
2. Verify scripts are executable: `chmod +x scripts/*.sh`
3. Check matcher pattern matches event

---

## Getting Help

- **Issues**: [GitHub Issues](https://github.com/claudebase/marketplace/issues)
- **Documentation**: This docs folder
- **Existing Examples**: Study existing skills/agents/commands

---

## License

MIT - See [LICENSE](../LICENSE)
