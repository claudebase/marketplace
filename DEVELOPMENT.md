# Developer Kit - Development Environment

This document explains how to use the Developer Kit plugin during development without formal installation.

## Quick Start

The repository includes a `.claude/` directory with symbolic links to the Developer Kit components. This allows you to use all features without installing the plugin.

### 1. Configure API Keys

```bash
# Copy the example settings file
cp .claude/settings.local.json.example .claude/settings.local.json

# Edit with your actual API keys
```

Add your API keys to `.claude/settings.local.json`:

```json
{
  "env": {
    "TAVILY_API_KEY": "your-actual-tavily-api-key",
    "GITHUB_TOKEN": "your-actual-github-token"
  }
}
```

### 2. Start Claude Code

Simply run Claude Code from the marketplace directory:

```bash
cd /path/to/marketplace
claude
```

Claude Code will automatically discover the `.claude/` directory and load:
- 24 skills
- 14 agents
- 21 commands
- 7 hooks
- MCP servers (Tavily, GitHub, Playwright, etc.)
- LSP servers (TypeScript, Python, JSON, YAML, Markdown)

## Directory Structure

```
marketplace/
├── .claude/                          # Development environment (symbolic links)
│   ├── commands -> ../developer-kit/commands
│   ├── agents -> ../developer-kit/agents
│   ├── skills -> ../developer-kit/skills
│   ├── hooks -> ../developer-kit/hooks    # Includes hooks.json config
│   ├── settings.json                 # Base settings
│   ├── settings.local.json           # Your API keys (gitignored)
│   ├── settings.local.json.example   # Template for settings.local.json
│   ├── .mcp.json -> ../developer-kit/.mcp.json
│   └── .lsp.json -> ../developer-kit/.lsp.json
└── developer-kit/                    # The actual plugin source
    ├── .claude-plugin/
    │   └── plugin.json
    ├── commands/
    ├── agents/
    ├── skills/
    ├── hooks/                        # Hook scripts + hooks.json
    ├── scripts/
    └── templates/
```

## How It Works

The `.claude/` directory uses symbolic links to reference the actual plugin files in `developer-kit/`. This means:

1. **Changes are reflected immediately** - Edit files in `developer-kit/` and they're available in your Claude Code session
2. **No installation required** - Just run `claude` in the marketplace directory
3. **Commands work without namespace** - Use `/analyze` instead of `/developer-kit:analyze`

## Available Features

### Commands (21)

Use slash commands directly:

```
/start feature-branch     # Initialize feature development
/analyze --mode security  # Code analysis
/check                    # Run lint, tests, security scan
/code-review              # Review changes
/prep-pr                  # Prepare pull request
/ship minor               # Ship a release
```

### Skills (24)

Skills activate automatically based on context:

- **analyze** - Code analysis
- **security** - Vulnerability scanning
- **implement** - Feature implementation
- **debug** - Bug fixing
- **research** - Web research
- **devops** - Build and deployment
- And 18 more...

### Agents (14)

Specialized domain experts:

- **architect** - System design
- **code-reviewer** - PR review
- **security-expert** - Security implementation
- **database-admin** - Database operations
- And 10 more...

### Hooks

Automated behaviors:

| Event | Hook | Action |
|-------|------|--------|
| SessionStart | session_instructions_hook.sh | Injects session context |
| SessionStart | validate_env_vars.sh | Checks API keys |
| PreToolUse | validate_bash_command.sh | Blocks dangerous commands |
| PostToolUse | format_file_hook.sh | Auto-formats files |
| PostToolUse | security_reminder_hook.sh | Security warnings |

## Validation Scripts

Run tests and validations from the developer-kit directory:

```bash
cd developer-kit

# Run all tests
bash scripts/test_components.sh

# Validate all components
bash scripts/validate.sh

# Check delegation compliance
bash scripts/validate_delegation.sh

# CI tests
bash scripts/ci_tests.sh
```

## Alternative: Using --plugin-dir

You can also load the plugin explicitly without the `.claude/` setup:

```bash
claude --plugin-dir ./developer-kit
```

With this approach:
- Commands are namespaced: `/developer-kit:analyze`
- Plugin manifest is used directly
- Useful for testing plugin installation behavior

## Troubleshooting

### Commands not found

Ensure you're in the marketplace directory:
```bash
pwd  # Should show .../marketplace
```

### Hooks not executing

Check that hook scripts are executable:
```bash
ls -la developer-kit/hooks/*.sh
# Should show -rwx permissions
```

If not:
```bash
chmod +x developer-kit/hooks/*.sh
```

### MCP servers not working

1. Verify API keys are set in `.claude/settings.local.json`
2. Check MCP status: `/mcp`
3. Ensure Node.js and npx are available

### Symbolic links broken

Recreate the links:
```bash
cd .claude
rm -f commands agents skills hooks .mcp.json .lsp.json
ln -s ../developer-kit/commands commands
ln -s ../developer-kit/agents agents
ln -s ../developer-kit/skills skills
ln -s ../developer-kit/hooks hooks
ln -s ../developer-kit/.mcp.json .mcp.json
ln -s ../developer-kit/.lsp.json .lsp.json
```

## Requirements

- **jq** - Required for hook JSON parsing
- **Node.js & npm** - Required for MCP servers
- **Bash** - Required for hook scripts
- **Claude Code CLI** - The main tool

Install dependencies:

```bash
# macOS
brew install jq node

# Ubuntu/Debian
sudo apt-get install jq nodejs npm
```
