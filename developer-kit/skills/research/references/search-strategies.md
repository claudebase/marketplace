# Search Optimization Strategies

## Query Formulation

### Basic Query Enhancement
```
Original: "react hooks"
Enhanced: "react hooks best practices 2024"

Original: "python async"
Enhanced: "python asyncio tutorial async await patterns"
```

### Operator Usage
```
# Exact phrase
"react server components"

# Site-specific
site:github.com react hooks examples

# Exclude terms
javascript frameworks -jquery

# File type
filetype:pdf machine learning guide

# Date range
react 18 features after:2023-01-01
```

### Query Expansion Patterns

**Technical Topics**
```
[topic] tutorial
[topic] best practices
[topic] vs [alternative]
[topic] examples
[topic] documentation
```

**Comparison Research**
```
[option A] vs [option B]
[option A] comparison [option B]
[option A] advantages disadvantages
when to use [option A] or [option B]
```

**Problem Solving**
```
[error message] solution
[problem] fix
how to [task] in [technology]
[technology] [problem] workaround
```

## Search Tool Selection

### Tavily Search
**Best for:**
- Current events and news
- Technology updates
- General web content
- API and library documentation

**Query tips:**
- Use natural language
- Include time context for current info
- Specify domain when known

### Context7 (Library Docs)
**Best for:**
- Official framework documentation
- API references
- Library usage patterns
- Code examples

**Usage:**
```
1. resolve-library-id: Find library ID
2. query-docs: Fetch specific docs
   - topic: Focus area (e.g., "hooks", "routing")
   - mode: "code" for API, "info" for concepts
```

### WebFetch
**Best for:**
- Direct URL access
- Specific page content
- Known documentation URLs
- GitHub READMEs

### Playwright
**Best for:**
- JavaScript-heavy pages
- Dynamic content
- Single-page applications
- Interactive documentation

## Parallel Search Strategy

### Batch Similar Queries
```javascript
// Instead of sequential:
await search("react hooks");
await search("react context");
await search("react state");

// Do parallel:
await Promise.all([
  search("react hooks"),
  search("react context"),
  search("react state")
]);
```

### Search Phases

**Phase 1: Broad Coverage**
- 3-5 general queries
- Different angles on topic
- Run in parallel

**Phase 2: Deep Dives**
- Focus on promising sources
- Extract detailed content
- Follow citations

**Phase 3: Gap Filling**
- Address missing information
- Verify uncertain claims
- Find alternative sources

## Result Processing

### Relevance Assessment
| Signal | Weight | Description |
|--------|--------|-------------|
| Title match | High | Query terms in title |
| Recent date | Medium | Published recently |
| Authoritative domain | High | Known quality source |
| Content depth | Medium | Comprehensive coverage |

### Extraction Priority
1. Official documentation
2. Authoritative tutorials
3. Stack Overflow (high votes)
4. GitHub discussions
5. Blog posts (check date)

### Deduplication
- Same content different URLs
- Syndicated articles
- Copied documentation
- Mirror sites

## Common Search Patterns

### Technology Comparison
```
1. "[tech A] vs [tech B]"
2. "[tech A] advantages"
3. "[tech B] advantages"
4. "when to use [tech A]"
5. "migrate from [tech A] to [tech B]"
```

### Best Practices Research
```
1. "[topic] best practices"
2. "[topic] common mistakes"
3. "[topic] production tips"
4. "[topic] performance optimization"
5. "[topic] security considerations"
```

### Problem Investigation
```
1. "[error] solution"
2. "[error] cause"
3. "[technology] [symptom]"
4. "github [error]" (for issues)
5. "stackoverflow [error]" (for solutions)
```

### API/Library Research
```
1. Context7 for official docs
2. "[library] examples"
3. "[library] tutorial"
4. "github [library] awesome"
5. "[library] alternatives"
```
