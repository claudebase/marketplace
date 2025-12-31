# Research Patterns

Centralized patterns for research operations. Used by `research` skill.

## Research Depth Levels

| Level      | Queries | Duration | Sources | Use When               |
| ---------- | ------- | -------- | ------- | ---------------------- |
| quick      | 1-3     | <1 min   | 3-5     | Simple fact-finding    |
| standard   | 5-10    | 2-5 min  | 5-10    | General research       |
| deep       | 10-20   | 5-10 min | 10-20   | Comprehensive analysis |
| exhaustive | 20+     | 15+ min  | 20+     | Critical decisions     |

## Research Modes

### Documentation Mode (`--docs`)

Focus on official documentation and technical references.

```yaml
Primary Sources:
  - Context7 library documentation
  - Official project docs
  - GitHub source code
  - API references

Use When:
  - Learning a library
  - Finding API syntax
  - Understanding framework patterns
  - Debugging with docs
```

### Web Mode (`--web`)

General web research for broader topics.

```yaml
Primary Sources:
  - Tavily search
  - WebSearch
  - Blog posts
  - Stack Overflow
  - Technical articles

Use When:
  - Comparing technologies
  - Finding best practices
  - Researching trends
  - Understanding concepts
```

## Source Evaluation

### Authoritative Sources (High Trust)

- Official documentation
- Framework maintainers
- RFCs and specifications
- Peer-reviewed content
- Project README/docs

### Community Sources (Medium Trust)

- Stack Overflow (high-vote answers)
- GitHub issues (closed/resolved)
- Blog posts from known experts
- Technical conference talks
- Well-maintained wikis

### User Content (Low Trust - Verify)

- Forum discussions
- Blog posts from unknown authors
- AI-generated content
- Outdated articles (>2 years)
- Unverified tutorials

## Search Strategies

### Context7 Documentation

```yaml
1. Resolve Library ID:
   mcp__context7__resolve-library-id(libraryName, query)
   → Returns Context7-compatible library ID

2. Query Documentation:
   mcp__context7__query-docs(libraryId, "specific topic or question")
   → Returns relevant documentation snippets

Example:
   # Find React hooks documentation
   mcp__context7__resolve-library-id("react", "useEffect cleanup")
   → libraryId: "/facebook/react"

   mcp__context7__query-docs("/facebook/react", "useEffect cleanup function")
   → Documentation about cleanup in useEffect
```

### GitHub Code Search

```yaml
Pattern Searches:
  mcp__github__search_code("pattern filename:.ext stars:>100")

Issue Searches:
  mcp__github__search_issues("error message repo:org/repo is:closed")

Repository Searches:
  mcp__github__search_repositories("topic language:typescript stars:>1000")

Examples:
  # Find how popular projects handle auth
  mcp__github__search_code("jwt verify filename:auth.ts stars:>500")

  # Find resolved issues about a bug
  mcp__github__search_issues("memory leak is:closed label:bug")
```

### Tavily Web Search

```yaml
General Search: mcp__tavily__tavily-search(query, options)

Best Practices: mcp__tavily__tavily-search("React Server Components best practices 2024")

Comparisons: mcp__tavily__tavily-search("Vite vs Webpack performance comparison")

Recent Updates: mcp__tavily__tavily-search("Node.js 22 new features", time_range="month")

Extract from URL: mcp__tavily__tavily-extract(["https://example.com/article"])
```

## Multi-Source Verification

```yaml
Process: 1. Find information from primary source
  2. Cross-reference with at least one other source
  3. Check for conflicting information
  4. Note recency of sources
  5. Cite all sources used

Red Flags:
  - Only one source available
  - Sources contradict each other
  - All sources are old (>2 years)
  - Source has commercial bias
  - No technical depth/evidence
```

## Research Workflow

```
PLAN → SEARCH → EVALUATE → SYNTHESIZE → DELIVER
Sequential   Tavily    Read/Verify   Write      Report
Thinking    Context7
            GitHub
```

### 1. Plan

Use Sequential Thinking to plan research:

- What question(s) need answering?
- What depth level is appropriate?
- Which sources are most relevant?
- What would validate the answer?

### 2. Search

Execute multi-source queries:

- Start with authoritative sources (Context7, official docs)
- Expand to community sources if needed
- Use specific, targeted queries
- Try alternative phrasings

### 3. Evaluate

Verify source quality:

- Check source authority
- Verify recency
- Cross-reference claims
- Note conflicting information

### 4. Synthesize

Combine findings:

- Identify consensus points
- Note areas of disagreement
- Resolve conflicts with evidence
- Create coherent summary

### 5. Deliver

Present with citations:

- Clear, actionable findings
- All sources cited
- Confidence level noted
- Caveats mentioned

## Query Optimization

```yaml
Good Queries:
  - "React useEffect dependency array best practices"
  - "Node.js error handling middleware pattern"
  - "PostgreSQL index optimization for JSON columns"

Bad Queries:
  - "react" (too broad)
  - "how to code" (not specific)
  - "fix my bug" (not a research question)

Tips:
  - Include technology name
  - Add version if relevant
  - Include year for best practices
  - Use specific error messages when debugging
```

## Citation Format

```markdown
## Sources

- [Source Title](URL) - Brief description of what was found
- [Official React Docs](https://react.dev/reference/...) - useEffect cleanup syntax
- [Stack Overflow Answer](https://stackoverflow.com/...) - Common pitfall explanation
```

## Context7 Research Resources

| Category | Libraries                   | Use Case            |
| -------- | --------------------------- | ------------------- |
| Frontend | react, vue, svelte, angular | Framework patterns  |
| Backend  | express, fastapi, django    | Server patterns     |
| Database | prisma, typeorm, mongoose   | ORM patterns        |
| Testing  | jest, vitest, pytest        | Testing patterns    |
| Build    | vite, webpack, esbuild      | Build configuration |

## Related

- [MCP Resources](./mcp-resources.md) - Context7 library IDs
- [Tool Integration](./tool-integration-patterns.md) - MCP patterns
- [Documentation Patterns](./documentation-patterns.md) - Writing findings
