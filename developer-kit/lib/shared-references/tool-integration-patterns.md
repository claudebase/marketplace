# Common Tool Integration Patterns

Reusable MCP tool patterns for skills and agents.

---

## Context7 Workflow

### Basic Documentation Lookup

```yaml
# Step 1: Resolve library ID
mcp__context7__resolve-library-id:
  libraryName: "fastapi"
  query: "async request handling"
# Returns: /websites/fastapi_tiangolo

# Step 2: Query specific documentation
mcp__context7__query-docs:
  libraryId: "/websites/fastapi_tiangolo"
  query: "dependency injection async Depends"
```

### Multi-Library Research

```yaml
# Parallel lookups for comparison
mcp__context7__resolve-library-id:
  libraryName: "prisma"
  query: "ORM comparison"

mcp__context7__resolve-library-id:
  libraryName: "drizzle"
  query: "ORM comparison"

# Then query both for same topic
mcp__context7__query-docs:
  libraryId: "/prisma/docs"
  query: "relations one-to-many"

mcp__context7__query-docs:
  libraryId: "/drizzle-team/drizzle-orm-docs"
  query: "relations one-to-many"
```

---

## GitHub Patterns

### Code Search

```yaml
# Find implementation patterns
mcp__github__search_code:
  q: "@app.post Depends HTTPException filename:.py stars:>100"

# Find schema patterns
mcp__github__search_code:
  q: "model @relation @@index filename:schema.prisma stars:>500"

# Find configuration patterns
mcp__github__search_code:
  q: "FROM node alpine multi-stage filename:Dockerfile"
```

### Issue Search

```yaml
# Find solutions to errors
mcp__github__search_issues:
  q: "[error message] in:title,body is:closed"

# Find framework-specific issues
mcp__github__search_issues:
  q: "repo:fastify/fastify memory leak is:closed"
```

### Repository Search

```yaml
# Find starter templates
mcp__github__search_repositories:
  query: "typescript nextjs starter template stars:>1000"

# Find best-practices repos
mcp__github__search_repositories:
  query: "kubernetes helm chart production stars:>200"
```

### File Contents

```yaml
# Get specific file from repo
mcp__github__get_file_contents:
  owner: "tiangolo"
  repo: "fastapi"
  path: "docs/en/docs/tutorial/dependencies.md"
```

---

## Tavily Research Patterns

### Best Practices Search

```yaml
mcp__tavily__tavily-search:
  query: "Python 3.12 best practices 2025"
  search_depth: "basic"
  max_results: 10

mcp__tavily__tavily-search:
  query: "FastAPI async dependency injection patterns"
  search_depth: "advanced"
  max_results: 5
```

### Technology Comparison

```yaml
mcp__tavily__tavily-search:
  query: "Prisma vs Drizzle vs TypeORM comparison 2025"
  search_depth: "advanced"
  max_results: 10
```

### Error Research

```yaml
mcp__tavily__tavily-search:
  query: "TypeError cannot read property undefined JavaScript causes fix"
  search_depth: "basic"
  max_results: 5
```

### Content Extraction

```yaml
mcp__tavily__tavily-extract:
  urls:
    - "https://docs.python.org/3/library/asyncio.html"
  extract_depth: "basic"
```

---

## Sequential Thinking Patterns

### Problem Analysis

```yaml
mcp__sequential-thinking__sequentialthinking:
  thought: "Analyzing the error pattern. The stack trace shows..."
  thoughtNumber: 1
  totalThoughts: 5
  nextThoughtNeeded: true
```

### Hypothesis Testing

```yaml
# Initial hypothesis
mcp__sequential-thinking__sequentialthinking:
  thought: "Hypothesis: The memory leak is caused by unclosed connections."
  thoughtNumber: 1
  totalThoughts: 4
  nextThoughtNeeded: true

# Revision if needed
mcp__sequential-thinking__sequentialthinking:
  thought: "Revising: Connection pooling is correct. Issue is event listener accumulation."
  thoughtNumber: 3
  totalThoughts: 5
  isRevision: true
  revisesThought: 1
  nextThoughtNeeded: true
```

### Branching

```yaml
# Explore alternative approach
mcp__sequential-thinking__sequentialthinking:
  thought: "Alternative approach: Instead of caching, use lazy loading."
  thoughtNumber: 4
  totalThoughts: 6
  branchFromThought: 2
  branchId: "lazy-loading"
  nextThoughtNeeded: true
```

---

## Playwright Browser Patterns

### Page Navigation and Snapshot

```yaml
# Navigate to URL
mcp__playwright__browser_navigate:
  url: "http://localhost:3000"

# Get accessibility snapshot (preferred over screenshot)
mcp__playwright__browser_snapshot: {}

# Take screenshot if visual verification needed
mcp__playwright__browser_take_screenshot:
  filename: "page-state.png"
```

### Form Interaction

```yaml
# Fill multiple form fields
mcp__playwright__browser_fill_form:
  fields:
    - name: "email"
      type: "textbox"
      ref: "[ref from snapshot]"
      value: "test@example.com"
    - name: "password"
      type: "textbox"
      ref: "[ref from snapshot]"
      value: "secure123"
```

### Element Interaction

```yaml
# Click element
mcp__playwright__browser_click:
  element: "Submit button"
  ref: "[ref from snapshot]"

# Wait for element
mcp__playwright__browser_wait_for:
  text: "Success"
```

---

## shadcn Component Patterns

### Search and Install

```yaml
# Search for components
mcp__shadcn__search_items_in_registries:
  registries: ["@shadcn"]
  query: "button"

# View component details
mcp__shadcn__view_items_in_registries:
  items: ["@shadcn/button"]

# Get install command
mcp__shadcn__get_add_command_for_items:
  items: ["@shadcn/button", "@shadcn/card"]

# Get usage examples
mcp__shadcn__get_item_examples_from_registries:
  registries: ["@shadcn"]
  query: "button-demo"
```

---

## Memory (Knowledge Graph) Patterns

### Store Information

```yaml
# Create entities
mcp__memory__create_entities:
  entities:
    - name: "ProjectConfig"
      entityType: "configuration"
      observations:
        - "Uses TypeScript 5.0"
        - "Next.js 14 with app router"

# Create relations
mcp__memory__create_relations:
  relations:
    - from: "ProjectConfig"
      to: "Database"
      relationType: "uses"
```

### Retrieve Information

```yaml
# Search knowledge graph
mcp__memory__search_nodes:
  query: "database configuration"

# Read entire graph
mcp__memory__read_graph: {}

# Open specific nodes
mcp__memory__open_nodes:
  names: ["ProjectConfig", "Database"]
```

---

## Combined Workflow Examples

### Debug Workflow

```yaml
# 1. Search for error solutions
mcp__tavily__tavily-search:
  query: "[error message] solution fix"

# 2. Check GitHub issues
mcp__github__search_issues:
  q: "[error message] repo:[framework] is:closed"

# 3. Get framework documentation
mcp__context7__resolve-library-id:
  libraryName: "[framework]"
  query: "error handling"

mcp__context7__query-docs:
  libraryId: "[resolved-id]"
  query: "[error type] debugging"

# 4. Analyze with sequential thinking
mcp__sequential-thinking__sequentialthinking:
  thought: "Based on research, the root cause is..."
  thoughtNumber: 1
  totalThoughts: 3
  nextThoughtNeeded: true
```

### Design Research Workflow

```yaml
# 1. Research best practices
mcp__tavily__tavily-search:
  query: "[technology] best practices 2025"

# 2. Find reference implementations
mcp__github__search_code:
  q: "[pattern] filename:.[ext] stars:>500"

# 3. Get official documentation
mcp__context7__resolve-library-id:
  libraryName: "[library]"
  query: "[design topic]"

mcp__context7__query-docs:
  libraryId: "[resolved-id]"
  query: "[specific pattern]"
```

---

## Notes

- Always verify library IDs with `resolve-library-id` before querying
- Use parallel tool calls when queries are independent
- Prefer `browser_snapshot` over `browser_take_screenshot` for interactions
- Use `search_depth: "advanced"` for Tavily only when basic results insufficient
- Include `stars:>N` in GitHub searches to find quality examples
