---
name: research
description: "Web research with adaptive planning and intelligent search. Supports depth levels (quick/standard/deep/exhaustive) and modes (--docs for documentation, --web for general). Activates for: 'research [topic]', 'find information about', 'look up', 'search for', 'what's the latest on', 'find best practices', 'deep dive into', 'find docs for [library]', 'get documentation for', '[library] llms.txt'."
allowed-tools:
  - Read
  - Grep
  - Glob
  - Write
  - WebFetch
  - WebSearch
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  - mcp__context7__resolve-library-id
  - mcp__context7__get-library-docs
  - mcp__playwright__browser_navigate
  - mcp__playwright__browser_snapshot
  - mcp__sequential-thinking__sequentialthinking
  - mcp__github__list_issues
  - mcp__github__get_pull_request
  - mcp__github__search_code
  - mcp__github__get_file_contents
  - mcp__github__search_repositories
---

# Research Skill

Web research with adaptive planning, intelligent search strategies, and multi-source verification. Supports depth levels and specialized modes for comprehensive information gathering.

**Core Principle**: "Search smart, verify always, cite everything."

**Key Enhancement**: Leverage MCP tools (Tavily, Context7, GitHub, Playwright) for comprehensive multi-source research with proper citation and verification.

## Activation Triggers

### Research Operations

- User asks to "research" something
- User needs information beyond knowledge cutoff
- User asks "what's the latest on..."
- User wants to find best practices
- User needs library/framework comparisons
- User says "deep dive into..."
- User wants "comprehensive research"
- User needs "thorough investigation"

### Documentation Discovery

- "find docs for [library]"
- "get documentation for [framework]"
- "[library] llms.txt"
- "look up [library] docs"

## Do NOT Activate When

- User wants code explanation -> use `explain` skill
- User wants to explore ideas -> use `brainstorm` skill
- User wants implementation -> use `implement` skill
- User wants code review -> use `analyze` skill

**Boundary Clarification:**
This skill gathers and synthesizes information from external sources. For codebase exploration, use the `explore` agent. For implementation guidance, use `implement` skill.

## Behavioral Flow

```
+--------------+--------------+--------------+--------------+--------------+
|   UNDERSTAND |     PLAN     |   EXECUTE    |   VALIDATE   |  SYNTHESIZE  |
+--------------+--------------+--------------+--------------+--------------+
| Assess query | Select       | Run parallel | Verify       | Organize     |
| complexity   | search       | searches     | source       | findings     |
|              | strategy     |              | credibility  |              |
|              |              |              |              |              |
| Identify     | Identify     | Extract      | Cross-check  | Create       |
| information  | parallel     | relevant     | key claims   | citations    |
| types needed | opportunities| content      |              |              |
|              |              |              |              |              |
| Define       | Set          | Follow       | Resolve      | Note         |
| success      | investigation| promising    | contradictions| confidence  |
| criteria     | milestones   | leads        |              | levels       |
+--------------+--------------+--------------+--------------+--------------+
   Sequential     Sequential     Tavily        GitHub         Output
   Thinking       Thinking       Context7      Playwright
                                 GitHub
```

## Research Depth Levels

Select depth based on query complexity or user specification:

### Quick (~5 sources)

- Single search pass
- Basic extraction
- Summary findings
- **Good for**: Simple factual queries, quick lookups

```
mcp__tavily__tavily-search(query, max_results=5)
```

### Standard (~10 sources) [Default]

- Extended search
- 2-3 hop exploration
- Structured report
- **Good for**: Most research needs

```
mcp__tavily__tavily-search(query, max_results=10, search_depth="basic")
mcp__context7__resolve-library-id (for libraries)
```

### Deep (~20 sources)

- Comprehensive search
- 3-4 hop exploration
- Detailed analysis
- Cross-verification
- **Good for**: Technical deep-dives

```
mcp__tavily__tavily-search(query, max_results=15, search_depth="advanced")
mcp__github__search_code(related patterns)
mcp__context7__query-docs(official docs)
```

### Exhaustive (~30+ sources)

- Maximum coverage
- 5+ hop exploration
- Complete investigation
- Multi-hop reasoning
- Self-reflection checkpoints
- **Good for**: Critical decisions, academic-level research

```
# Multiple parallel searches
mcp__tavily__tavily-search(query, max_results=20, search_depth="advanced")
mcp__tavily__tavily-search(related_query, max_results=10)
mcp__github__search_repositories(topic)
mcp__github__search_code(implementation patterns)
mcp__context7__query-docs(multiple libraries)
mcp__playwright__browser_navigate (for JS-heavy sites)
```

## Research Modes

### Documentation Mode (`--docs` or "find docs for")

Specialized for framework and library documentation discovery.

**Trigger Phrases**:

- "find docs for [library]"
- "get documentation for [framework]"
- "look up [library] docs"
- "[library] documentation --docs"
- "llms.txt for [library]"

**Strategy Priority**:

1. **Context7 (Primary)**: Use `mcp__context7__resolve-library-id` + `mcp__context7__query-docs`
2. **llms.txt Discovery**: Search `context7.com/{org}/{repo}/llms.txt`
3. **GitHub Repository**: Search for official repos and README
4. **Official Docs**: WebFetch/Tavily for official documentation sites
5. **Repository Analysis**: Get file contents for complete understanding

**llms.txt URL Patterns**:

For GitHub repositories:

```
https://context7.com/{org}/{repo}/llms.txt
https://context7.com/{org}/{repo}/llms.txt?topic={query}
```

For websites:

```
https://context7.com/websites/{normalized-domain}/llms.txt
```

**Popular Documentation Sources** (via Context7):

| Resource      | Library ID                           | Snippets | Use Case                       |
| ------------- | ------------------------------------ | -------- | ------------------------------ |
| Next.js       | `/vercel/next.js`                    | 3,891    | React framework docs           |
| React         | `/facebook/react`                    | 1,847    | React core documentation       |
| TypeScript    | `/microsoft/TypeScript`              | 2,156    | TypeScript language docs       |
| Node.js       | `/nodejs/node`                       | 5,234    | Node.js runtime docs           |
| Vue.js        | `/vuejs/core`                        | 1,523    | Vue framework docs             |
| Astro         | `/withastro/astro`                   | 2,847    | Astro framework docs           |
| Remix         | `/remix-run/remix`                   | 1,234    | Remix framework docs           |
| shadcn/ui     | `/shadcn-ui/ui`                      | 892      | UI component library           |
| Tailwind CSS  | `/tailwindlabs/tailwindcss`          | 1,456    | CSS framework docs             |
| Prisma        | `/prisma/docs`                       | 4,691    | Database ORM docs              |
| PostgreSQL    | `/websites/postgresql`               | 61,065   | PostgreSQL database docs       |
| MongoDB       | `/mongodb/docs`                      | 22,287   | MongoDB database docs          |
| Redis         | `/websites/redis_io`                 | 29,026   | Redis cache docs               |
| Elasticsearch | `/websites/elastic_co_reference`     | 56,996   | Search engine docs             |
| GraphQL       | `/graphql/graphql.github.io`         | 1,196    | GraphQL specification          |
| OpenAPI       | `/websites/spec_openapis_oas_v3_2_0` | 962      | API specification docs         |
| Puppeteer     | `/puppeteer/puppeteer`               | 2,409    | Browser automation docs        |
| Playwright    | `/microsoft/playwright`              | 3,456    | Browser testing docs           |
| Scrapy        | `/websites/scrapy_en`                | 2,643    | Web scraping framework         |
| Axios         | `/axios/axios-docs`                  | 205      | HTTP client docs               |
| MDX           | `/mdx-js/mdx`                        | 337      | Markdown + JSX docs            |
| JSON Schema   | `/json-schema-org/json-schema-spec`  | 217      | Data validation specification  |
| jsdom         | `/jsdom/jsdom`                       | 527      | DOM implementation for Node.js |
| Postman       | `/websites/learning_postman_com`     | 5,184    | API testing documentation      |
| Elasticsearch | `/elastic/elasticsearch-js`          | 292      | Node.js Elasticsearch client   |

**Documentation Mode Output Format**:

```markdown
# Documentation for [Library] [Version]

## Source

- Method: [Context7 / llms.txt / Repository / Research]
- URLs: [list of sources]
- Date accessed: [current date]

## Key Information

[Extracted relevant information organized by topic]

## Code Examples

[Practical examples with source attribution]

## Additional Resources

[Related links, examples, references]
```

### Web Mode (default)

General web research for non-documentation queries.

**Good for**:

- Current events and news
- Best practices research
- Technology comparisons
- Industry trends
- How-to guides

## MCP Integration

### Tavily (Primary Web Search)

**IMPORTANT: Always use Tavily FIRST. Only use WebSearch as fallback if Tavily fails.**

```
mcp__tavily__tavily-search - AI-optimized web search
mcp__tavily__tavily-extract - Content extraction from URLs
```

**Search Parameters**:

| Parameter         | Values                         | Use Case                     |
| ----------------- | ------------------------------ | ---------------------------- |
| `search_depth`    | `basic`, `advanced`            | Quick vs deep search         |
| `topic`           | `general`, `news`              | General info vs current news |
| `max_results`     | 5-20                           | Control result count         |
| `time_range`      | `day`, `week`, `month`, `year` | Filter by recency            |
| `include_domains` | `["site1.com"]`                | Limit to specific sites      |
| `exclude_domains` | `["site2.com"]`                | Exclude specific sites       |

**Search Patterns**:

```
# Quick factual lookup
mcp__tavily__tavily-search(query="React 19 release date", max_results=5)

# Current news
mcp__tavily__tavily-search(query="AI developments", topic="news", time_range="week")

# Deep technical research
mcp__tavily__tavily-search(query="microservices vs monolith 2024", search_depth="advanced", max_results=15)

# Site-specific search
mcp__tavily__tavily-search(query="authentication best practices", include_domains=["owasp.org", "auth0.com"])

# Extract content from specific URLs
mcp__tavily__tavily-extract(urls=["https://example.com/article"])
```

### Context7 (Documentation Lookup)

**Primary source for library and framework documentation:**

```
mcp__context7__resolve-library-id - Resolve library names to IDs
mcp__context7__query-docs - Get official documentation
```

**Usage Pattern**:

```
# Step 1: Resolve library ID
mcp__context7__resolve-library-id(
  libraryName="react",
  query="hooks useState useEffect"
)

# Step 2: Query specific documentation
mcp__context7__query-docs(
  libraryId="/facebook/react",
  query="useState hook with TypeScript"
)
```

**Query Strategies by Topic**:

| Research Topic  | Query Pattern                                    |
| --------------- | ------------------------------------------------ |
| Getting started | `"[library] getting started setup installation"` |
| API reference   | `"[library] API methods functions reference"`    |
| Configuration   | `"[library] configuration options settings"`     |
| Best practices  | `"[library] best practices patterns"`            |
| Migration       | `"[library] migration upgrade guide"`            |
| Troubleshooting | `"[library] troubleshooting common errors"`      |
| Integration     | `"[library] integration with [other tool]"`      |

### GitHub MCP (Code Research)

**Find real-world implementations and patterns:**

```
mcp__github__search_code - Find code examples in repositories
mcp__github__search_repositories - Find relevant repositories
mcp__github__get_file_contents - Get specific file contents
mcp__github__list_issues - Research issues and discussions
mcp__github__get_pull_request - Review PR implementations
```

**Code Search Patterns**:

```
# Find implementation patterns
mcp__github__search_code(q="useAuth hook TypeScript filename:.ts stars:>100")

# Find configuration examples
mcp__github__search_code(q="tailwind.config extension:js")

# Find by file type
mcp__github__search_code(q="prisma schema user role filename:schema.prisma")

# Find in specific repos
mcp__github__search_code(q="repo:vercel/next.js middleware authentication")
```

**Repository Search Patterns**:

```
# Find popular projects
mcp__github__search_repositories(query="react state management stars:>1000")

# Find by topic
mcp__github__search_repositories(query="topic:authentication language:typescript")

# Find by recent activity
mcp__github__search_repositories(query="nextjs starter pushed:>2024-01-01")
```

**Issue/PR Research**:

```
# Research common issues
mcp__github__list_issues(owner="vercel", repo="next.js", labels=["bug"])

# Review implementation approaches
mcp__github__get_pull_request(owner="facebook", repo="react", pull_number=12345)
```

### Playwright (JavaScript-Heavy Sites)

**For sites requiring JavaScript rendering:**

```
mcp__playwright__browser_navigate - Navigate to pages
mcp__playwright__browser_snapshot - Capture page content (accessibility tree)
```

**Usage Pattern**:

```
# Navigate to JS-heavy site
mcp__playwright__browser_navigate(url="https://docs.example.com")

# Capture rendered content
mcp__playwright__browser_snapshot()
```

**When to Use Playwright**:

- Single-page applications (SPAs)
- Sites with client-side rendering
- Interactive documentation portals
- Sites that block traditional scrapers
- Content behind JavaScript hydration

### Sequential Thinking (Research Planning)

**Structure complex research with systematic reasoning:**

```
mcp__sequential-thinking__sequentialthinking - Multi-step research planning
```

**Use for**:

- Planning multi-hop research
- Breaking down complex queries
- Identifying information gaps
- Cross-verification strategies
- Synthesizing contradictory sources

**Research Planning Pattern**:

```
mcp__sequential-thinking__sequentialthinking({
  thought: "Breaking down research query: What are the current best practices for microservices architecture?",
  thoughtNumber: 1,
  totalThoughts: 5,
  nextThoughtNeeded: true
})

# Continue with:
# 2. Identify key subtopics (communication, deployment, security, monitoring)
# 3. Plan search strategy for each subtopic
# 4. Identify authoritative sources
# 5. Plan cross-verification approach
```

### Fallback: WebSearch and WebFetch

**Only use if MCP tools fail:**

```
WebSearch - General web search (fallback only)
WebFetch - Direct URL access for specific pages
```

## Research Methodology

### Standard Research (Quick/Standard/Deep)

**1. Understand (5-10%)**

- Assess query complexity
- Identify information types needed
- Define success criteria

```
mcp__sequential-thinking__sequentialthinking - Plan research approach
```

**2. Plan (10-15%)**

- Select search strategy
- Identify parallel opportunities
- Set investigation milestones

**3. Execute (50-60%)**

- Run parallel searches
- Extract relevant content
- Follow promising leads
- Collect evidence

```
# Parallel execution pattern
mcp__tavily__tavily-search(primary_query)
mcp__context7__query-docs(library_docs)
mcp__github__search_code(implementation_patterns)
```

**4. Validate (10-15%)**

- Verify source credibility
- Cross-check key claims
- Resolve contradictions

**5. Synthesize (15-20%)**

- Organize findings
- Create citations
- Note confidence levels

### Exhaustive Research (Additional Steps)

For exhaustive depth, add these practices:

**Multi-Hop Reasoning Patterns**:

```
Entity Expansion (5 levels max):
  Person -> Affiliations -> Related work -> Citations -> Impact
  Company -> Products -> Competitors -> Market position -> Trends
  Concept -> Applications -> Implementations -> Results -> Limitations

Temporal Progression:
  Current state -> Recent changes -> Historical context -> Future implications

Conceptual Deepening:
  Overview -> Details -> Examples -> Edge cases -> Exceptions

Causal Chains:
  Observation -> Immediate cause -> Root cause -> Contributing factors
```

**Self-Reflection Checkpoints**:
After each major step, ask:

- Have I addressed the core question?
- What gaps remain?
- Is my confidence improving?
- Should I adjust strategy?

**Replanning Triggers**:

- Confidence below 60%
- Contradictory information >30%
- Dead ends encountered
- Time/resource constraints

## Source Evaluation

### Credibility Assessment

| Factor      | High Credibility                   | Low Credibility                 |
| ----------- | ---------------------------------- | ------------------------------- |
| Source      | Official docs, academic papers     | Anonymous blogs, forums         |
| Recency     | Updated within 6 months            | >2 years old for tech topics    |
| Author      | Known expert, verified credentials | Unknown, no credentials         |
| Citations   | Well-sourced, verifiable           | No sources, unverifiable claims |
| Consistency | Matches multiple sources           | Contradicts established facts   |

### Cross-Verification Matrix

```markdown
| Claim     | Source A | Source B | Source C | Verdict   |
| --------- | -------- | -------- | -------- | --------- |
| [Claim 1] | yes      | yes      | partial  | Confirmed |
| [Claim 2] | yes      | no       | no       | Disputed  |
| [Claim 3] | yes      | yes      | yes      | Confirmed |
```

## Output Formats

### Standard Report

```markdown
## Research Summary: [Topic]

### Key Findings

1. [Finding with source]
2. [Finding with source]
3. [Finding with source]

### Details

[Organized findings with inline citations]

### Confidence Assessment

- High confidence: [topics well-covered]
- Medium confidence: [topics with limited sources]
- Low confidence: [topics needing more research]

### Sources

| #   | Title   | URL   | Credibility |
| --- | ------- | ----- | ----------- |
| 1   | [Title] | [URL] | High        |
| 2   | [Title] | [URL] | Medium      |

### Open Questions

- [Questions requiring further research]
```

### Exhaustive Report

```markdown
## Deep Research Report: [Topic]

### Executive Summary

[2-3 paragraph synthesis of key findings]

### Methodology

- Sources consulted: [number]
- Depth levels explored: [number]
- Verification passes: [number]
- Tools used: [Tavily, Context7, GitHub, Playwright]

### Key Findings

#### Finding 1: [Title]

**Evidence**: [Sources and citations]
**Confidence**: High/Medium/Low
**Details**: [Comprehensive analysis]

### Cross-Verification Results

| Claim   | Source A | Source B | Source C | Verdict   |
| ------- | -------- | -------- | -------- | --------- |
| [Claim] | yes      | yes      | partial  | Confirmed |

### Gaps and Limitations

- [Information not found]
- [Conflicting information unresolved]

### Conclusions and Recommendations

[Evidence-based conclusions with actionable recommendations]
```

### Comparison Report

```markdown
## Comparison: [Option A] vs [Option B]

### Overview

| Aspect     | Option A | Option B |
| ---------- | -------- | -------- |
| [Criteria] | [Value]  | [Value]  |
| [Criteria] | [Value]  | [Value]  |

### Detailed Analysis

#### Option A: [Name]

**Strengths**: [List]
**Weaknesses**: [List]
**Best for**: [Use cases]

#### Option B: [Name]

**Strengths**: [List]
**Weaknesses**: [List]
**Best for**: [Use cases]

### Recommendation

[Evidence-based recommendation with rationale]

### Sources

[Numbered list with URLs]
```

## Parallel Execution Patterns

### Research Query Types

**Factual Query** (parallel-safe):

```
# All searches independent
mcp__tavily__tavily-search(query)
mcp__context7__query-docs(library)
mcp__github__search_code(pattern)
```

**Exploratory Query** (sequential):

```
# Search 1 informs Search 2
result1 = mcp__tavily__tavily-search(initial_query)
# Extract key terms from result1
result2 = mcp__tavily__tavily-search(refined_query)
```

**Verification Query** (fan-out):

```
# Verify same claim across sources
mcp__tavily__tavily-search(claim, include_domains=["source1.com"])
mcp__tavily__tavily-search(claim, include_domains=["source2.com"])
mcp__tavily__tavily-search(claim, include_domains=["source3.com"])
```

## Reference Files

For detailed methodology, see:

- `references/search-strategies.md` - Search optimization techniques
- `references/source-evaluation.md` - Source credibility assessment
- `references/multi-hop-patterns.md` - Multi-hop reasoning patterns
- `references/verification-methodology.md` - Cross-verification techniques

For documentation mode (--docs), see:

- `references/docs-sources.md` - Common documentation sources and patterns
- `references/docs-workflows.md` - Documentation discovery workflows

## Handoffs

| Scenario                  | Hand off to        |
| ------------------------- | ------------------ |
| Need code explanation     | `explain` skill    |
| Need idea exploration     | `brainstorm` skill |
| Need implementation       | `implement` skill  |
| Need code review          | `analyze` skill    |
| Need codebase exploration | `explore` agent    |
| Need architecture design  | `design` skill     |

## Boundaries

**Will:**

- Search web using Tavily (primary) and WebSearch (fallback)
- Query Context7 for library/framework documentation
- Search GitHub for code examples and implementations
- Use Playwright for JavaScript-heavy sites
- Cross-verify claims across multiple sources
- Provide confidence assessments
- Cite all sources properly
- Use parallel execution for independent queries

**Will Not:**

- Make claims without sources
- Present single-source information as definitive
- Skip verification for critical information
- Use WebSearch when Tavily is available
- Provide outdated information when current data exists
- Fabricate or interpolate missing information
