# Getting Started with Developer Kit

This guide walks you through installing, configuring, and using the Developer Kit plugin for Claude Code.

---

## Prerequisites

- **Claude Code** installed and configured
- **Node.js 18+** (for MCP servers)
- **Git** (for repository operations)

---

## Installation

### Option 1: Marketplace Install (Recommended)

```bash
# Start Claude Code
claude

# Install from marketplace
/plugin marketplace add https://github.com/claudebase/marketplace.git

# Enable the plugin
/plugin
# Select developer-kit from the list
```

### Option 2: Local Install

```bash
# Clone the repository
git clone https://github.com/claudebase/marketplace.git

# Install the plugin
claude plugin install ./marketplace/developer-kit

# Verify installation
claude plugin list
```

### Option 3: Development Install

For contributing or customizing:

```bash
# Clone to your plugins directory
cd ~/.claude/plugins
git clone https://github.com/claudebase/marketplace.git

# Symlink for development
ln -s marketplace/developer-kit developer-kit
```

---

## Configuration

### Environment Variables

Add your API keys to `~/.claude/settings.json`:

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

> **Note**: Claude Code does NOT automatically load `.env` files for MCP servers. Environment variables must be configured in `~/.claude/settings.json` under the `env` key.

### Getting API Keys

#### Tavily API Key
1. Go to [tavily.com](https://tavily.com)
2. Sign up for a free account
3. Copy your API key from the dashboard

#### GitHub Token
1. Go to [GitHub Settings > Developer Settings > Personal Access Tokens](https://github.com/settings/tokens)
2. Generate a new token (classic) with these scopes:
   - `repo` (for private repos) or `public_repo` (for public only)
   - `read:org` (for organization repos)
3. Copy the token

---

## Verification

### Check Plugin Loading

```bash
# Start with debug output
claude --debug

# Look for:
# [plugin] Loading developer-kit...
# [plugin] developer-kit loaded successfully
```

### Check MCP Servers

Inside Claude Code:
```
/mcp
```

You should see:
- `sequential-thinking` - Active
- `context7` - Active
- `playwright` - Active
- `tavily` - Active (requires TAVILY_API_KEY)
- `shadcn` - Active
- `github` - Active (requires GITHUB_TOKEN)
- `memory` - Active

### Test a Command

```
analyze --help
```

Should display the analyze command documentation.

---

## First Steps

### 1. Explore Your Codebase

```
# Get an overview of project structure
index

# Analyze code quality
analyze
```

### 2. Start a Feature

```
# Initialize feature development
start my-new-feature

# This creates:
# - New git branch
# - Session context file
# - Initial todo list
```

### 3. Get Help

```
# Research a topic
research how to implement JWT authentication

# Explain existing code
explain this authentication middleware
```

### 4. Validate Changes

```
# Run all checks
check

# Prepare for PR
prep-pr
```

---

## Understanding Components

### Skills (Auto-Activate)

Skills activate automatically based on your request:

```
"analyze this code for security issues"
→ Activates: security skill

"why is this function slow?"
→ Activates: performance skill

"implement a user registration form"
→ Activates: implement skill
```

### Agents (Specialized Experts)

Agents are invoked for complex domain tasks:

```
# Claude automatically uses agents when appropriate
"design the database schema for a blog platform"
→ May invoke: architect agent, database-admin agent

# Or explicitly request
"use the security-expert agent to fix this vulnerability"
```

### Commands (Direct Actions)

Commands are invoked by name:

```
analyze                    # Run analysis
check --strict             # Validate project
ship minor                 # Release new version
```

---

## Common Workflows

### Feature Development

```
start feature-name         # 1. Initialize
# ... develop ...
check                      # 2. Validate
code-review                # 3. Review
prep-pr                    # 4. Prepare PR
# ... merge PR ...
ship patch                 # 5. Release
```

### Bug Fixing

```
# Claude automatically uses tiered debugging
"fix this authentication bug"
→ Tier 1: Quick fix for simple issues
→ Tier 2: Systematic investigation
→ Tier 3: Deep root cause analysis
```

### Code Review

```
code-review                # Review local changes
code-review PR-123         # Review specific PR
```

---

## Tips for Effective Use

### 1. Use Natural Language

Skills activate on natural phrases:
- "check if this code is secure" → security skill
- "help me understand this function" → explain skill
- "make this code faster" → improve skill

### 2. Be Specific

More context = better results:
```
# Good
"analyze the authentication module for SQL injection vulnerabilities"

# Better
"security audit src/auth/ focusing on OWASP Top 10"
```

### 3. Use Commands for Workflows

Commands provide structured workflows:
```
# Instead of manually checking everything
check

# Instead of writing PR descriptions manually
prep-pr
```

### 4. Leverage MCP Servers

```
# Research with web search
research best practices for React state management

# Look up library docs
"how do I use useQuery in TanStack Query?"
→ Uses context7 for official docs
```

---

## Troubleshooting

### Plugin Not Loading

```bash
# Check for syntax errors
cat developer-kit/.claude-plugin/plugin.json | jq .

# Check Claude Code logs
claude --debug 2>&1 | grep -i error
```

### MCP Server Errors

```bash
# Test MCP server manually
npx -y @modelcontextprotocol/server-sequential-thinking

# Check environment variables are set in ~/.claude/settings.json
cat ~/.claude/settings.json | grep -A5 '"env"'
```

### Skills Not Activating

1. Check trigger phrases in skill description
2. Use explicit invocation: "use the [skill] skill to..."
3. Verify skill exists: check `skills/[name]/SKILL.md`

### Commands Not Found

1. Verify plugin is enabled: `claude plugin list`
2. Check command exists: `ls developer-kit/commands/`
3. Restart Claude Code after plugin changes

---

## Next Steps

- [Skills Guide](./SKILLS.md) - Deep dive into all 24 skills
- [Agents Guide](./AGENTS.md) - Understanding the 14 agents
- [Commands Guide](./COMMANDS.md) - Complete command reference
- [Workflows](./workflows/) - Step-by-step workflow guides
- [Architecture](./ARCHITECTURE.md) - Contributing and customization

---

## Getting Help

- **Documentation**: This docs folder
- **Issues**: [GitHub Issues](https://github.com/claudebase/marketplace/issues)
- **Skill Reference**: `skills/TRIGGER-REFERENCE.md`
