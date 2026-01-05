# Developer Kit Plugin

Version 7.0.0 | A comprehensive development assistant plugin with skills, agents, and workflows for the full SDLC.

## Quick Start

```bash
# Install the plugin
claude plugin install claudebase/marketplace/developer-kit

# Or install from local path
claude plugin install ./developer-kit
```

## Components

| Type | Count | Description |
|------|-------|-------------|
| Skills | 24 | Focused capabilities (implement, debug, test, etc.) |
| Agents | 14 | Specialized assistants (code-reviewer, architect, etc.) |
| Commands | 21 | Slash commands for common workflows |
| Hooks | 6 | Automated behaviors (format, security checks) |

## Skills

Skills are focused capabilities that can be invoked directly or composed by agents.

### Core Development
- **implement** - Feature implementation with framework patterns
- **debug** - Systematic debugging with hypothesis testing
- **test** - Test execution and coverage analysis
- **improve** - Code refactoring and optimization

### Analysis
- **analyze** - Code quality and pattern analysis
- **security** - OWASP-based security audits
- **performance** - Profiling and optimization analysis
- **a11y** - Accessibility compliance checking

### Documentation & Planning
- **document** - Technical documentation generation
- **explain** - Code explanations with analogies
- **design** - Architecture and API design
- **brainstorm** - Requirements exploration

### Infrastructure
- **devops** - Build, CI/CD, and git operations
- **containers** - Docker and Kubernetes
- **database** - Schema design and query optimization
- **observability** - Logging, monitoring, alerting
- **migration** - Zero-downtime migrations

### Meta Skills
- **orchestration** - Multi-step task coordination
- **research** - Web research with verification
- **quality** - Test strategy design
- **verify** - Evidence-based validation
- **confidence-check** - Readiness assessment
- **frontend** - UI component development
- **sequential-thinking** - Structured problem-solving

## Agents

Agents are specialized assistants that compose multiple skills.

| Agent | Model | Use Case |
|-------|-------|----------|
| architect | opus | System design and architecture |
| business-panel-experts | opus | Strategic business analysis |
| code-explorer | haiku | Codebase exploration |
| code-reviewer | sonnet | PR and code review |
| database-admin | sonnet | Database operations |
| learning-guide | sonnet | Teaching programming concepts |
| observability-engineer | sonnet | Monitoring setup |
| pm-agent | sonnet | Session and project management |
| python-expert | sonnet | Python development |
| repo-index | haiku | Repository indexing |
| requirements-analyst | sonnet | Requirements gathering |
| security-expert | sonnet | Security implementations |
| socratic-mentor | sonnet | Guided discovery learning |
| technical-writer | sonnet | Documentation creation |

## Commands

Commands are organized by category:

### Development
- `/analyze` - Code analysis
- `/build` - Build project
- `/check` - Run validations
- `/cleanup` - Remove dead code
- `/code-review` - Review changes
- `/feature-dev` - Full feature workflow
- `/git` - Git operations
- `/start` - Initialize development session

### Planning
- `/business-panel` - Business strategy analysis
- `/estimate` - Effort estimation
- `/spec-panel` - Technical specification
- `/workflow` - Custom workflow execution

### Release
- `/changelog` - Generate changelog
- `/migrate` - Data/schema migration
- `/prep-pr` - Prepare pull request
- `/release` - Version and release
- `/ship` - Full release workflow

### Documentation
- `/index` - Generate repository index
- `/recommend` - Documentation recommendations

### Session
- `/agent` - Spawn specialized agent
- `/reflect` - Session reflection

## Hooks

Hooks automate common tasks:

| Hook | Trigger | Action |
|------|---------|--------|
| format_file_hook.sh | PostToolUse (Write/Edit) | Auto-format files |
| security_reminder_hook.sh | PostToolUse (Write/Edit) | Security pattern detection |
| validate_bash_command.sh | PreToolUse (Bash) | Block dangerous commands |
| validate_env_vars.sh | SessionStart | Check API keys |
| restore_session_context.sh | SessionStart | Restore session state |
| save_session_state.sh | Stop | Save session state |

## MCP Servers

The plugin configures these MCP servers:

- **sequential-thinking** - Structured reasoning
- **context7** - Documentation lookup
- **playwright** - Browser automation
- **tavily** - Web search
- **shadcn** - UI components
- **github** - GitHub integration
- **memory** - Knowledge graph

## Configuration

### Required Environment Variables

Add to `~/.claude/settings.json`:

```json
{
  "env": {
    "TAVILY_API_KEY": "your-tavily-key",
    "GITHUB_TOKEN": "your-github-token"
  }
}
```

### Validation

```bash
# Run all validations
bash scripts/validate.sh

# Run component tests
bash scripts/test_components.sh

# Validate delegation compliance
bash scripts/validate_delegation.sh
```

## Usage Examples

### Feature Development
```
/feature-dev add user authentication with JWT
```

### Code Review
```
/code-review --focus security
```

### Architecture Design
```
/agent architect design a microservices migration strategy
```

### Repository Indexing
```
/index
```

## Platform Support

This plugin supports Unix-like systems (macOS and Linux).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development guidelines.

## License

MIT
