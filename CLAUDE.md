# Claude Code Plugin Marketplace

This repository contains Claude Code plugins. Each plugin has its own CLAUDE.md with specific instructions.

## Available Plugins

| Plugin | Version | Description |
|--------|---------|-------------|
| `developer-kit` | 4.0.0 | 24 skills, 14 agents, 21 commands for software development |

## Repository Structure

```
marketplace/
├── developer-kit/           # Developer Kit plugin
│   ├── CLAUDE.md            # Plugin-specific instructions (auto-loaded)
│   ├── .claude-plugin/      # Plugin manifest
│   ├── skills/              # 24 skills
│   ├── agents/              # 14 agents
│   ├── commands/            # 21 commands
│   ├── hooks/               # Bash hooks
│   └── scripts/             # Validation scripts
└── .github/                 # CI workflows
```

## Plugin Installation

```bash
# Install from marketplace
claude plugin install claudebase/marketplace/developer-kit

# Or clone and install locally
git clone https://github.com/claudebase/marketplace.git
claude plugin install ./marketplace/developer-kit
```

## Platform Support

All plugins in this marketplace support Unix-like systems (macOS and Linux).
