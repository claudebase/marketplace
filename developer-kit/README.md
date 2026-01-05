# Developer Kit Plugin

> Comprehensive Claude Code plugin with 24 skills, 14 agents, and 21 commands for the full software development lifecycle.

**Version 7.0.0** | [Repository](https://github.com/claudebase/marketplace) | [Changelog](./CHANGELOG.md) | MIT License

**Platform**: macOS, Linux

---

## Quick Start

### Installation

```bash
# Install from marketplace
claude plugin install claudebase/marketplace/developer-kit

# Or clone and install locally
git clone https://github.com/claudebase/marketplace.git
claude plugin install ./marketplace/developer-kit
```

### Environment Setup

Configure API keys in your settings file at `~/.claude/settings.json`:

```bash
# Copy the template
cp templates/settings/settings.json ~/.claude/settings.json
```

**Minimal required configuration:**

```json
{
  "enabledPlugins": {
    "developer-kit@claudebase": true
  },
  "env": {
    "TAVILY_API_KEY": "your-actual-tavily-api-key",
    "GITHUB_TOKEN": "your-actual-github-token"
  }
}
```

Get your API keys:
- **Tavily**: https://tavily.com (required for web search)
- **GitHub**: https://github.com/settings/tokens (optional, for GitHub integration)

### Verify Installation

```bash
claude --debug  # Check for loading errors
```

---

## Feature Overview

| Component | Count | Description |
|-----------|-------|-------------|
| **Skills** | 24 | Auto-activating capabilities based on context |
| **Agents** | 14 | Specialized domain experts for complex tasks |
| **Commands** | 21 | Direct workflow actions |
| **MCP Servers** | 7 | Extended tooling integrations |
| **Templates** | 10+ | CI/CD, Docker, K8s, ADR templates |

---

## Common Workflows

### Start a New Feature
```
start my-feature-branch
# Creates branch, initializes todos, sets up session tracking
```

### Analyze Code
```
analyze                          # Broad analysis
analyze --mode security          # Security audit
analyze --mode perf              # Performance analysis
```

### Development Cycle
```
check                            # Run lint, tests, security scan
code-review                      # Review changes
prep-pr                          # Prepare pull request
```

### Release
```
ship patch                       # Ship patch release
ship minor                       # Ship minor release
changelog                        # Generate changelog
```

---

## Skills Reference

Skills activate automatically based on your request context.

### Analysis & Review

| Skill | Triggers | Purpose |
|-------|----------|---------|
| `analyze` | "analyze this code", "check code quality" | Broad code analysis |
| `security` | "security audit", "OWASP check" | Vulnerability scanning (read-only) |
| `performance` | "why is this slow", "find bottlenecks" | Performance profiling (read-only) |
| `quality` | "design tests", "improve coverage" | Testing strategies (read-only) |
| `verify` | "prove it works", "check before commit" | Evidence-based validation |
| `test` | "run tests", "check coverage" | Test execution and analysis |

### Implementation

| Skill | Triggers | Purpose |
|-------|----------|---------|
| `implement` | "create", "build feature", "code this" | Feature implementation |
| `frontend` | "create component", "build UI" | UI development with distinctive design |
| `database` | "design schema", "optimize query" | Database design and optimization |
| `containers` | "create Dockerfile", "k8s manifest" | Container orchestration |
| `debug` | "fix this bug", "why is this failing" | Tiered debugging (quick/systematic/RCA) |
| `improve` | "refactor", "make this better" | Code enhancement |

### Research & Planning

| Skill | Triggers | Purpose |
|-------|----------|---------|
| `research` | "research [topic]", "find docs for" | Web research with depth levels |
| `brainstorm` | "I want to build", "explore ideas" | Requirements discovery |
| `explain` | "how does this work", "teach me" | Educational explanations (read-only) |
| `design` | "architect this", "API design" | System architecture |
| `confidence-check` | "am I ready to implement" | Pre-implementation gates |

### Infrastructure

| Skill | Triggers | Purpose |
|-------|----------|---------|
| `devops` | "build", "test", "CI/CD" | Build and deployment workflows |
| `observability` | "add logging", "setup monitoring" | Logging, metrics, alerting |
| `migration` | "migrate database", "zero-downtime" | Migration planning |
| `a11y` | "accessibility", "WCAG" | Accessibility audits |

### Meta

| Skill | Triggers | Purpose |
|-------|----------|---------|
| `orchestration` | "coordinate", "break down" | Multi-task coordination |
| `document` | "create docs", "generate README" | Documentation generation |
| `sequential-thinking` | "think step by step" | Structured reasoning |

---

## Agents Reference

Agents are specialized domain experts for complex tasks.

| Agent | Focus | When to Use |
|-------|-------|-------------|
| `architect` | System design across all domains | Architecture decisions, API design |
| `code-reviewer` | PR review with confidence scoring | Code review, quality gates |
| `security-expert` | Security implementation | Fixing vulnerabilities (can write) |
| `database-admin` | Database operations | Schema design, query optimization |
| `python-expert` | Python development | Python-specific implementation |
| `technical-writer` | Documentation | API docs, user guides |
| `requirements-analyst` | Requirements | PRD creation, scope definition |
| `code-explorer` | Codebase analysis | Understanding unfamiliar code |
| `observability-engineer` | Monitoring | Logging, alerting, dashboards |
| `business-panel-experts` | Business strategy | Strategic analysis, planning |
| `socratic-mentor` | Teaching | Guided learning |
| `learning-guide` | Education | Tutorials, concept explanations |
| `pm-agent` | Session management | Progress tracking, learnings |
| `repo-index` | Repository indexing | Codebase structure analysis |

---

## Commands Reference

Commands are invoked directly by name.

### Development

| Command | Usage | Purpose |
|---------|-------|---------|
| `start` | `start feature-branch` | Initialize feature development |
| `analyze` | `analyze --mode security` | Code analysis |
| `check` | `check --strict` | Project validation |
| `build` | `build` | Build/compile project |
| `git` | `git status` | Git operations |
| `cleanup` | `cleanup` | Code cleanup |
| `code-review` | `code-review` | Review changes |
| `feature-dev` | `feature-dev` | Guided development |

### Planning

| Command | Usage | Purpose |
|---------|-------|---------|
| `workflow` | `workflow prd.md` | Generate implementation workflow |
| `estimate` | `estimate feature` | Effort estimation |
| `business-panel` | `business-panel idea` | Business analysis |
| `spec-panel` | `spec-panel spec.md` | Specification review |

### Release

| Command | Usage | Purpose |
|---------|-------|---------|
| `ship` | `ship minor` | Ship release |
| `release` | `release` | Version automation |
| `changelog` | `changelog` | Generate changelog |
| `prep-pr` | `prep-pr` | Prepare pull request |
| `migrate` | `migrate` | Migration management |

### Documentation

| Command | Usage | Purpose |
|---------|-------|---------|
| `index` | `index` | Generate project index |
| `recommend` | `recommend` | Get recommendations |

### Session

| Command | Usage | Purpose |
|---------|-------|---------|
| `agent` | `agent` | Session orchestration |
| `reflect` | `reflect` | Session review |

---

## MCP Servers

| Server | Purpose | Required API Key |
|--------|---------|------------------|
| `sequential-thinking` | Structured multi-step reasoning | None |
| `context7` | Library documentation lookup | None |
| `playwright` | Browser automation and testing | None |
| `tavily` | Web search and extraction | `TAVILY_API_KEY` |
| `shadcn` | UI component registry | None |
| `github` | GitHub API integration | `GITHUB_TOKEN` |
| `memory` | Cross-session knowledge | None |

---

## Directory Structure

```
developer-kit/
├── .claude-plugin/
│   └── plugin.json          # Plugin manifest
├── .mcp.json                 # MCP server configuration
├── .lsp.json                 # LSP server configuration
├── hooks/                    # Event-driven automation (Bash)
│   ├── hooks.json            # Hook definitions
│   ├── session_instructions_hook.sh
│   ├── validate_bash_command.sh
│   ├── format_file_hook.sh
│   ├── security_reminder_hook.sh
│   ├── validate_env_vars.sh
│   ├── restore_session_context.sh
│   └── save_session_state.sh
├── scripts/                  # Validation scripts (Bash)
│   ├── test_components.sh    # Full test suite
│   ├── validate.sh           # Unified validation
│   ├── validate_delegation.sh
│   └── ci_tests.sh
├── commands/                 # 21 commands by category
│   ├── development/
│   ├── planning/
│   ├── release/
│   ├── documentation/
│   └── session/
├── agents/                   # 14 agent definitions
├── skills/                   # 24 skills with references
│   └── <skill>/
│       ├── SKILL.md          # Skill definition
│       └── references/       # Supporting documentation
├── templates/                # Reusable templates
│   ├── ci-cd/
│   ├── docker/
│   ├── kubernetes/
│   ├── adr/
│   └── settings/
│       └── settings.json     # Settings template
└── docs/                     # Documentation
    └── workflows/            # Workflow guides
```

---

## Hooks

The plugin includes automated hooks that run on specific events:

| Event | Hook | Action |
|-------|------|--------|
| `SessionStart` | `session_instructions_hook.sh` | Injects session instructions |
| `SessionStart` | `validate_env_vars.sh` | Checks required API keys |
| `SessionStart` | `restore_session_context.sh` | Restores previous session context |
| `PostToolUse` | `format_file_hook.sh` | Auto-formats edited files |
| `PostToolUse` | `security_reminder_hook.sh` | Warns about security patterns |
| `PreToolUse` | `validate_bash_command.sh` | Blocks dangerous commands |
| `Stop` | `save_session_state.sh` | Saves session state |

---

## Validation

All validation scripts are Bash-based:

```bash
# Full test suite
bash scripts/test_components.sh

# With verbose output
bash scripts/test_components.sh --verbose

# Quick validation (all checks)
bash scripts/validate.sh

# Individual validators
bash scripts/validate.sh --skills      # Skill descriptions
bash scripts/validate.sh --agents      # Agent fields
bash scripts/validate.sh --refs        # Reference files
bash scripts/validate.sh --frontmatter # Frontmatter syntax
bash scripts/validate.sh --json        # JSON configs

# Delegation validation
bash scripts/validate_delegation.sh

# CI tests
bash scripts/ci_tests.sh
```

---

## Documentation

- [Getting Started](./docs/GETTING-STARTED.md) - Installation and setup
- [Skills Guide](./docs/SKILLS.md) - Detailed skill documentation
- [Agents Guide](./docs/AGENTS.md) - Agent capabilities and usage
- [Commands Guide](./docs/COMMANDS.md) - Command reference
- [Hooks Guide](./docs/HOOKS.md) - Hook customization
- [MCP Guide](./docs/MCP.md) - MCP server configuration
- [Architecture](./docs/ARCHITECTURE.md) - Plugin architecture and contributing
- [Workflows](./docs/workflows/) - Development workflow guides
- [Changelog](./CHANGELOG.md) - Version history

---

## Troubleshooting

### Plugin Not Loading
```bash
claude --debug  # Check for errors
claude plugin list  # Verify enabled
```

### MCP Servers Not Working
```bash
/mcp  # Check server status
# Ensure API keys are set in settings.json under "env"
```

### Skills Not Activating
- Use explicit trigger phrases: "use the security skill to..."
- Check skill descriptions for activation triggers
- See [TRIGGER-REFERENCE.md](./skills/TRIGGER-REFERENCE.md)

---

## Contributing

See [ARCHITECTURE.md](./docs/ARCHITECTURE.md) for:
- Plugin structure and conventions
- Adding new skills, agents, and commands
- Frontmatter specifications
- Testing requirements

---

## License

MIT - see [LICENSE](../LICENSE)

---

**Developer Kit v7.0.0** | 24 Skills | 14 Agents | 21 Commands
