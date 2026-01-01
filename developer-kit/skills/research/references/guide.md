# Research Skill - Detailed Guide

Web research with adaptive planning, intelligent search, and multi-source verification.

**Core Principle**: "Search smart, verify always, cite everything."

---

## Behavioral Flow

```
┌──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
│     PLAN     │    SEARCH    │   EVALUATE   │  SYNTHESIZE  │   DELIVER    │
├──────────────┼──────────────┼──────────────┼──────────────┼──────────────┤
│ Define       │ Execute      │ Verify       │ Combine      │ Present      │
│ search       │ multi-source │ sources      │ findings     │ with         │
│ strategy     │ queries      │ check recency│ resolve      │ citations    │
│              │              │              │ conflicts    │              │
│ Determine    │ Tavily       │ Cross-       │ Build        │ Format       │
│ depth level  │ Context7     │ reference    │ coherent     │ for user     │
│              │ GitHub       │ facts        │ narrative    │              │
└──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘
   Sequential     Tavily        Read          Write         Report
   Thinking       Context7      Verify
                  GitHub
```

---

## Depth Levels

| Level      | Queries | Time    | Use Case                           |
| ---------- | ------- | ------- | ---------------------------------- |
| quick      | 1-3     | <1min   | Quick facts, single-source answer  |
| standard   | 5-10    | 2-5min  | General research, multiple sources |
| deep       | 10-20   | 5-10min | Comprehensive analysis             |
| exhaustive | 20+     | 15+min  | Full investigation, all sources    |

**Auto-selection criteria:**

- Quick: Simple questions, known topics
- Standard: General research requests
- Deep: "comprehensive", "thorough", "all options"
- Exhaustive: Critical decisions, legal/security topics

---

## Research Modes

### Documentation Mode (`--docs`)

Focus on official documentation:

```
# Primary: Context7 for official docs
mcp__context7__resolve-library-id("react")
mcp__context7__query-docs("useEffect cleanup")

# Secondary: GitHub for examples
mcp__github__search_code("useEffect cleanup filename:.tsx")
```

**Best for:**

- Library/framework documentation
- API references
- Implementation examples

### Web Mode (`--web`)

General web research:

```
# Primary: Tavily for web search
mcp__tavily__tavily-search("React vs Vue 2024 comparison")

# Secondary: Extract from articles
mcp__tavily__tavily-extract(["url1", "url2"])
```

**Best for:**

- Current events
- Comparisons
- Best practices
- Trends

---

## MCP Tool Integration

### Tavily (Web Search)

```
mcp__tavily__tavily-search
- query: Search query
- search_depth: "basic" or "advanced"
- max_results: Number of results (5-20)
- include_domains: Filter to specific sites
- exclude_domains: Block specific sites
```

**Use cases:**

- General web research
- News and current events
- Technology comparisons
- Best practices articles

### Context7 (Documentation)

```
mcp__context7__resolve-library-id - Get library ID
mcp__context7__query-docs - Query specific docs
```

**Key library IDs:**

| Library    | ID                           |
| ---------- | ---------------------------- |
| React      | `/facebook/react`            |
| Next.js    | `/vercel/next.js`            |
| Vue        | `/vuejs/core`                |
| FastAPI    | `/websites/fastapi_tiangolo` |
| PostgreSQL | `/postgres/postgres`         |

### GitHub MCP (Code Examples)

```
mcp__github__search_code - Find code patterns
mcp__github__search_repositories - Find projects
```

### Playwright (Page Extraction)

```
mcp__playwright__browser_navigate - Load page
mcp__playwright__browser_snapshot - Extract content
```

---

## Source Evaluation

### Credibility Hierarchy

1. **Official documentation** - Framework/library docs
2. **Primary sources** - RFCs, specifications, papers
3. **Authoritative sites** - MDN, official blogs
4. **Community verified** - Stack Overflow (high votes)
5. **Blog posts** - Consider recency and author

### Recency Check

```
Check publication date:
- Technical docs: <2 years preferred
- Framework versions: Match user's version
- Security: <6 months for CVE info
- Best practices: <1 year
```

### Cross-Verification

- Verify facts across 2+ sources
- Note conflicts and present both views
- Prefer consensus over single sources
- Flag outdated information

---

## Output Format

```markdown
## Research: [Topic]

### Summary

[2-3 sentence overview of findings]

### Key Findings

1. **[Finding 1]**
   - Details...
   - Source: [citation]

2. **[Finding 2]**
   - Details...
   - Source: [citation]

### Comparison (if applicable)

| Aspect  | Option A | Option B |
| ------- | -------- | -------- |
| Feature | Yes      | No       |
| Cost    | Free     | Paid     |

### Recommendations

[Based on findings, what action to take]

### Sources

1. [Title](URL) - Description
2. [Title](URL) - Description
```

---

## Handoffs

| Scenario              | Hand off to       |
| --------------------- | ----------------- |
| Codebase exploration  | `Explore` agent   |
| Implementation needed | `implement` skill |
| Bug investigation     | `debug` skill     |
| Security research     | `security` skill  |

---

## Related Reference Files

- [search-strategies.md](search-strategies.md) - Query patterns
- [source-evaluation.md](source-evaluation.md) - Verification criteria
- [docs-sources.md](docs-sources.md) - Documentation lookup
- [multi-hop-patterns.md](multi-hop-patterns.md) - Complex research
