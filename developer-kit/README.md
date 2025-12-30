# Developer Kit Plugin

> Comprehensive Claude Code plugin with 24 skills, 14 agents, and 21 commands for the full software development lifecycle.

**Version 4.0.0** | [Repository](https://github.com/claudebase/marketplace) | [Changelog](./CHANGELOG.md) | MIT License

**Multi-Platform Support**: Windows, macOS, Linux, WSL

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

Configure API keys in your platform-specific settings file:

| Platform | Settings Location |
|----------|------------------|
| **macOS/Linux** | `~/.claude/settings.json` |
| **Windows** | `%APPDATA%\.claude\settings.json` |
| **WSL** | `~/.claude/settings.json` (inside WSL) |

Use the appropriate template from `templates/settings/`:

```bash
# macOS/Linux
cp templates/settings/unix-settings.json ~/.claude/settings.json

# Windows PowerShell
copy templates\settings\windows-settings.json $env:APPDATA\.claude\settings.json

# WSL
cp templates/settings/wsl-settings.json ~/.claude/settings.json
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

### Windows-Specific Notes

- Ensure Python 3.8+ is installed and in your PATH
- The plugin automatically detects Windows and uses PowerShell-compatible commands
- All hooks use Python scripts for cross-platform compatibility
- WSL is auto-detected; Unix commands work seamlessly in WSL environments

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
├── hooks/                    # Event-driven automation
│   ├── hooks.json            # Hook definitions
│   ├── platform_instructions_hook.py  # Platform detection
│   ├── validate_bash_command.py
│   ├── format_file_hook.py
│   ├── security_reminder_hook.py
│   ├── validate_env_vars.py
│   ├── restore_session_context.py
│   └── save_session_state.py
├── lib/                      # Cross-platform utilities
│   ├── __init__.py
│   └── platform_utils.py     # PlatformInfo, CommandRunner, FileUtils
├── scripts/                  # Validation scripts (Python)
│   ├── test_components.py    # Full test suite (124 tests)
│   └── validate.py           # Unified validation
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
│   └── settings/             # Platform-specific settings
│       ├── windows-settings.json
│       ├── unix-settings.json
│       └── wsl-settings.json
└── docs/                     # Documentation
    └── workflows/            # Workflow guides
```

---

## Hooks

The plugin includes automated hooks that run on specific events:

| Event | Hook | Action |
|-------|------|--------|
| `SessionStart` | `platform_instructions_hook.py` | Injects platform-specific instructions |
| `SessionStart` | `validate_env_vars.py` | Checks required API keys |
| `SessionStart` | `restore_session_context.py` | Restores previous session context |
| `PostToolUse` | `format_file_hook.py` | Auto-formats edited files |
| `PostToolUse` | `security_reminder_hook.py` | Warns about security patterns |
| `PreToolUse` | `validate_bash_command.py` | Blocks dangerous commands |
| `Stop` | `save_session_state.py` | Saves session state |

### Platform Detection

At session start, the plugin automatically detects your platform (Windows/macOS/Linux/WSL) and injects appropriate instructions for Claude to use the correct commands.

---

## Validation

All validation scripts are Python-based for cross-platform compatibility:

```bash
# Full test suite (99+ tests)
python3 scripts/test_components.py

# With verbose output
python3 scripts/test_components.py --verbose

# Quick validation (all checks)
python3 scripts/validate.py

# Individual validators
python3 scripts/validate.py --skills      # Skill descriptions
python3 scripts/validate.py --agents      # Agent fields
python3 scripts/validate.py --refs        # Reference files
python3 scripts/validate.py --frontmatter # Frontmatter syntax
python3 scripts/validate.py --json        # JSON configs
```

**Windows users**: Use `python` instead of `python3` if `python3` is not in PATH.

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

### Windows-Specific Issues

**Python not found:**
```powershell
# Check Python installation
python --version
# Or try python3
python3 --version

# Install Python from https://www.python.org/downloads/
# Ensure "Add Python to PATH" is checked during installation
```

**Hooks not executing:**
```powershell
# Verify hooks.json uses Python commands
# Check that CLAUDE_PLUGIN_ROOT is set correctly
echo $env:CLAUDE_PLUGIN_ROOT
```

**Path issues:**
- Use forward slashes `/` or escaped backslashes `\\` in paths
- Avoid spaces in directory names
- Settings file: `%APPDATA%\.claude\settings.json`

**WSL Detection:**
- The plugin auto-detects WSL and uses Unix commands
- To force Windows mode, set `WSL_INTEROP=0` in settings.json

---

## Contributing

See [ARCHITECTURE.md](./docs/ARCHITECTURE.md) for:
- Plugin structure and conventions
- Adding new skills, agents, and commands
- Frontmatter specifications
- Testing requirements

---

## License

MIT - see [LICENSE](./LICENSE)

---

**Developer Kit v4.0.0** | 24 Skills | 14 Agents | 21 Commands
