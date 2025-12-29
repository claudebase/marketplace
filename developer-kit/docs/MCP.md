# MCP Servers Guide

MCP (Model Context Protocol) servers extend Claude Code with additional tools and capabilities. The Developer Kit includes 7 MCP server integrations.

---

## Overview

| Server | Purpose | API Key Required |
|--------|---------|------------------|
| `sequential-thinking` | Structured multi-step reasoning | No |
| `context7` | Library documentation lookup | No |
| `playwright` | Browser automation and testing | No |
| `tavily` | Web search and content extraction | Yes |
| `shadcn` | UI component registry | No |
| `github` | GitHub API integration | Yes |
| `memory` | Cross-session knowledge persistence | No |

---

## Configuration

MCP servers are configured in `.mcp.json`:

```json
{
  "mcpServers": {
    "server-name": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@org/package"],
      "env": {
        "API_KEY": "${API_KEY}"
      }
    }
  }
}
```

### Environment Variables

Configure in `~/.claude/settings.json`:

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

> **Important**: Claude Code does NOT load `.env` files for MCP servers. Use `settings.json` instead.

---

## Server Details

### sequential-thinking

**Purpose**: Structured problem-solving through iterative reasoning.

**Package**: `@modelcontextprotocol/server-sequential-thinking`

**Tools**:
- `mcp__sequential-thinking__sequentialthinking`

**Usage**:
```
# Automatic - used by skills like debug, design, implement
# Or explicitly:
"Think through this problem step by step using sequential thinking"
```

**Parameters**:
```typescript
{
  thought: string,           // Current reasoning step
  nextThoughtNeeded: boolean,// Continue reasoning?
  thoughtNumber: number,     // Current step (1, 2, 3...)
  totalThoughts: number,     // Estimated total steps
  isRevision?: boolean,      // Revising previous thought?
  revisesThought?: number,   // Which thought to revise
  branchFromThought?: number,// Branch point
  branchId?: string          // Branch identifier
}
```

**When Used By**:
- `debug` skill (Tier 2 and 3)
- `design` skill
- `implement` skill
- `architect` agent
- Complex analysis tasks

---

### context7

**Purpose**: Library and framework documentation lookup.

**Package**: `@upstash/context7-mcp`

**Tools**:
- `mcp__context7__resolve-library-id` - Find library ID
- `mcp__context7__query-docs` - Query documentation

**Usage**:
```
# Automatic - used when implementing with frameworks
"How do I use useQuery in TanStack Query?"
```

**Workflow**:
1. Resolve library ID: `resolve-library-id("react")`
2. Query docs: `query-docs("/facebook/react", "hooks")`

**Supported Libraries**:
- React, Vue, Angular, Svelte
- Next.js, Nuxt, Remix
- Express, Fastify, NestJS
- Prisma, Drizzle, TypeORM
- And many more...

**When Used By**:
- `implement` skill
- `frontend` skill
- `research` skill (--docs mode)
- `architect` agent
- `python-expert` agent

---

### playwright

**Purpose**: Browser automation and UI testing.

**Package**: `@playwright/mcp@latest`

**Tools**:
- `mcp__playwright__browser_navigate` - Go to URL
- `mcp__playwright__browser_snapshot` - Accessibility snapshot
- `mcp__playwright__browser_click` - Click element
- `mcp__playwright__browser_type` - Type text
- `mcp__playwright__browser_take_screenshot` - Screenshot
- `mcp__playwright__browser_fill_form` - Fill forms
- And more...

**Usage**:
```
"Test the login flow in the browser"
"Take a screenshot of the homepage"
"Fill out the registration form"
```

**Common Patterns**:

```typescript
// Navigate and snapshot
browser_navigate({ url: "http://localhost:3000" })
browser_snapshot({})

// Interact with elements
browser_click({ element: "Login button", ref: "button#login" })
browser_type({ element: "Email field", ref: "input#email", text: "user@example.com" })
```

**When Used By**:
- `test` skill (E2E testing)
- `implement` skill (validation)
- `frontend` skill (UI testing)
- `architect` agent

---

### tavily

**Purpose**: Web search and content extraction.

**Package**: `tavily-mcp@0.1.2`

**Required**: `TAVILY_API_KEY`

**Tools**:
- `mcp__tavily__tavily-search` - Web search
- `mcp__tavily__tavily-extract` - Content extraction

**Usage**:
```
"Research best practices for microservices authentication"
"Search for recent React 19 features"
```

**Search Parameters**:
```typescript
{
  query: string,
  search_depth?: "basic" | "advanced",
  topic?: "general" | "news",
  max_results?: number,      // 5-20
  include_domains?: string[],
  exclude_domains?: string[],
  time_range?: "day" | "week" | "month" | "year"
}
```

**Extract Parameters**:
```typescript
{
  urls: string[],
  extract_depth?: "basic" | "advanced",
  include_images?: boolean
}
```

**When Used By**:
- `research` skill
- `business-panel-experts` agent
- Any task requiring current information

---

### shadcn

**Purpose**: UI component registry for React projects.

**Package**: `shadcn@latest mcp`

**Tools**:
- `mcp__shadcn__get_project_registries` - Get configured registries
- `mcp__shadcn__list_items_in_registries` - List available components
- `mcp__shadcn__search_items_in_registries` - Search components
- `mcp__shadcn__view_items_in_registries` - View component details
- `mcp__shadcn__get_item_examples_from_registries` - Get examples
- `mcp__shadcn__get_add_command_for_items` - Get install command
- `mcp__shadcn__get_audit_checklist` - Audit checklist

**Usage**:
```
"Add a button component from shadcn"
"Search for a date picker component"
"Show me the card component examples"
```

**Workflow**:
1. Search: `search_items_in_registries(["@shadcn"], "button")`
2. View: `view_items_in_registries(["@shadcn/button"])`
3. Examples: `get_item_examples_from_registries(["@shadcn"], "button-demo")`
4. Install: `get_add_command_for_items(["@shadcn/button"])`

**When Used By**:
- `frontend` skill
- `implement` skill (React UI)

---

### github

**Purpose**: GitHub API integration for repository operations.

**Package**: `@modelcontextprotocol/server-github`

**Required**: `GITHUB_TOKEN`

**Tools**:
- `mcp__github__search_repositories` - Search repos
- `mcp__github__get_file_contents` - Read files
- `mcp__github__create_or_update_file` - Write files
- `mcp__github__create_issue` - Create issues
- `mcp__github__list_issues` - List issues
- `mcp__github__create_pull_request` - Create PRs
- `mcp__github__list_pull_requests` - List PRs
- `mcp__github__get_pull_request` - Get PR details
- `mcp__github__create_pull_request_review` - Review PRs
- `mcp__github__search_code` - Search code
- And more...

**Usage**:
```
"List open issues in this repository"
"Create a PR for my changes"
"Search for authentication implementations on GitHub"
```

**Token Scopes Needed**:
- `repo` - Full repository access
- `read:org` - Organization access
- `workflow` - GitHub Actions (optional)

**When Used By**:
- `devops` skill
- `research` skill (code search)
- `code-reviewer` agent
- Release commands

---

### memory

**Purpose**: Cross-session knowledge persistence.

**Package**: `@modelcontextprotocol/server-memory`

**Tools**:
- `mcp__memory__create_entities` - Store entities
- `mcp__memory__create_relations` - Create relationships
- `mcp__memory__add_observations` - Add observations
- `mcp__memory__search_nodes` - Search knowledge
- `mcp__memory__open_nodes` - Retrieve entities
- `mcp__memory__read_graph` - Read full graph
- `mcp__memory__delete_entities` - Remove entities
- `mcp__memory__delete_relations` - Remove relations
- `mcp__memory__delete_observations` - Remove observations

**Usage**:
```
"Remember that we decided to use PostgreSQL for the database"
"What decisions have we made about authentication?"
```

**Entity Structure**:
```typescript
{
  name: string,
  entityType: string,
  observations: string[]
}
```

**When Used By**:
- `pm-agent` (session management)
- Long-running projects
- Decision tracking

---

## Checking MCP Status

Inside Claude Code:
```
/mcp
```

Shows:
- Server names
- Connection status
- Available tools

---

## Troubleshooting

### Server Not Starting

1. Check Node.js version (18+ required)
2. Verify package installation:
```bash
npx -y @modelcontextprotocol/server-sequential-thinking --help
```

3. Check environment variables:
```bash
echo $TAVILY_API_KEY
echo $GITHUB_TOKEN
```

### API Key Errors

1. Verify key is set in `~/.claude/settings.json` under `"env"`
2. Check key format is correct
3. Verify key has required permissions
4. Restart Claude Code after changing settings

### Tool Not Found

1. Run `/mcp` to check server status
2. Restart Claude Code after config changes
3. Check `.mcp.json` syntax:
```bash
cat .mcp.json | jq .
```

---

## Adding Custom MCP Servers

1. Add to `.mcp.json`:
```json
{
  "mcpServers": {
    "my-server": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@my-org/my-mcp-server"],
      "env": {
        "MY_API_KEY": "${MY_API_KEY}"
      }
    }
  }
}
```

2. Set environment variable in `~/.claude/settings.json`:
```json
{
  "env": {
    "MY_API_KEY": "your-api-key-here"
  }
}
```

3. Restart Claude Code

4. Use in skills/agents:
```yaml
allowed-tools:
  - mcp__my-server__my-tool
```

---

## MCP Tool Naming

Format: `mcp__<server>__<tool>`

Examples:
- `mcp__sequential-thinking__sequentialthinking`
- `mcp__context7__resolve-library-id`
- `mcp__playwright__browser_navigate`
- `mcp__tavily__tavily-search`
- `mcp__github__create_pull_request`
- `mcp__memory__search_nodes`

---

## Best Practices

1. **Set API keys securely** - Use `~/.claude/settings.json`, never commit keys
2. **Check server status** - Run `/mcp` to verify connections
3. **Use appropriate servers** - Match server capabilities to task
4. **Handle rate limits** - Some APIs have usage limits
5. **Cache when possible** - Reduce redundant API calls
6. **Test independently** - Test MCP tools before relying on them
