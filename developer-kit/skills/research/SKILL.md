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
---

# Research Skill

## Purpose

Gather current, accurate information from the web using intelligent search strategies. Provide evidence-based findings with proper source citations.

**Core Principle**: "Search smart, verify always, cite everything."

## When to Use

**Activate When:**
- User asks to "research" something
- User needs information beyond knowledge cutoff
- User asks "what's the latest on..."
- User wants to find best practices
- User needs library/framework comparisons
- User says "deep dive into..."
- User wants "comprehensive research"
- User needs "thorough investigation"

**Do NOT Activate When:**
- User wants code explanation → use `explain` skill
- User wants to explore ideas → use `brainstorm` skill

## Research Depth Levels

Select depth based on query complexity or user specification:

### Quick (~5 sources)
- Single search pass
- Basic extraction
- Summary findings
- **Good for**: Simple factual queries, quick lookups

### Standard (~10 sources) [Default]
- Extended search
- 2-3 hop exploration
- Structured report
- **Good for**: Most research needs

### Deep (~20 sources)
- Comprehensive search
- 3-4 hop exploration
- Detailed analysis
- Cross-verification
- **Good for**: Technical deep-dives

### Exhaustive (~30+ sources)
- Maximum coverage
- 5+ hop exploration
- Complete investigation
- Multi-hop reasoning
- Self-reflection checkpoints
- **Good for**: Critical decisions, academic-level research

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
1. **Context7 (Primary)**: Use `mcp__context7__resolve-library-id` + `mcp__context7__get-library-docs`
2. **llms.txt Discovery**: Search `context7.com/{org}/{repo}/llms.txt`
3. **Official Docs**: WebSearch for official documentation
4. **Repository Analysis**: Clone + analyze for complete codebase

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

**Popular llms.txt locations** (try context7.com first):
- Astro: `https://context7.com/withastro/astro/llms.txt`
- Next.js: `https://context7.com/vercel/next.js/llms.txt`
- Remix: `https://context7.com/remix-run/remix/llms.txt`
- shadcn/ui: `https://context7.com/shadcn-ui/ui/llms.txt`

**Output Format** (docs mode):
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

General web research as documented below. Use for non-documentation queries.

## Methodology

### Standard Research (Quick/Standard/Deep)

**1. Understand (5-10%)**
- Assess query complexity
- Identify information types needed
- Define success criteria

**2. Plan (10-15%)**
- Select search strategy
- Identify parallel opportunities
- Set investigation milestones

**3. Execute (50-60%)**
- Run parallel searches
- Extract relevant content
- Follow promising leads
- Collect evidence

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

**Multi-Hop Reasoning Patterns**
```
Entity Expansion (5 levels max):
  Person → Affiliations → Related work → Citations → Impact
  Company → Products → Competitors → Market position → Trends
  Concept → Applications → Implementations → Results → Limitations

Temporal Progression:
  Current state → Recent changes → Historical context → Future implications

Conceptual Deepening:
  Overview → Details → Examples → Edge cases → Exceptions

Causal Chains:
  Observation → Immediate cause → Root cause → Contributing factors
```

**Self-Reflection Checkpoints**
After each major step, ask:
- Have I addressed the core question?
- What gaps remain?
- Is my confidence improving?
- Should I adjust strategy?

**Replanning Triggers**
- Confidence below 60%
- Contradictory information >30%
- Dead ends encountered
- Time/resource constraints

## Search Strategy

**IMPORTANT: Always use Tavily FIRST. Only use WebSearch as fallback if Tavily fails.**

### 1. Primary: Tavily (USE FIRST)
```
mcp__tavily__tavily-search - Use for ALL web searches
mcp__tavily__tavily-extract - Use for content extraction from URLs
```
Tavily provides better search results with AI-optimized responses.

### 2. Documentation: Context7
```
mcp__context7__resolve-library-id - Resolve library names
mcp__context7__get-library-docs - Get official documentation
```
Use for library/framework documentation lookups.

### 3. JavaScript-Heavy Sites: Playwright
```
mcp__playwright__browser_navigate - Navigate to pages
mcp__playwright__browser_snapshot - Capture page content
```
Use for sites that require JavaScript rendering.

### 4. Fallback: WebSearch (ONLY IF TAVILY FAILS)
```
WebSearch - Use ONLY if Tavily is unavailable or returns errors
```

### 5. Direct Access: WebFetch
```
WebFetch - Only for accessing specific URLs directly
```

### 6. GitHub Research
```
mcp__github__list_issues   - Research issues and discussions
mcp__github__get_pull_request - Review PR implementations
mcp__github__search_code   - Find code examples in repositories
```
Use for researching how others have solved similar problems.

### Parallel Execution
- Batch similar searches
- Concurrent extractions
- Never sequential without reason

## Output Format

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
| # | Title | URL | Credibility |
|---|-------|-----|-------------|
| 1 | [Title] | [URL] | High/Medium/Low |

### Open Questions
- [Questions requiring further research]
```

### Exhaustive Report (Additional Sections)
```markdown
## Deep Research Report: [Topic]

### Executive Summary
[2-3 paragraph synthesis of key findings]

### Methodology
- Sources consulted: [number]
- Depth levels explored: [number]
- Verification passes: [number]

### Key Findings
#### Finding 1: [Title]
**Evidence**: [Sources and citations]
**Confidence**: High/Medium/Low
**Details**: [Comprehensive analysis]

### Cross-Verification Results
| Claim | Source A | Source B | Source C | Verdict |
|-------|----------|----------|----------|---------|
| [Claim] | ✅ | ✅ | ⚠️ | Confirmed |

### Gaps and Limitations
- [Information not found]
- [Conflicting information unresolved]

### Conclusions and Recommendations
[Evidence-based conclusions with actionable recommendations]
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
