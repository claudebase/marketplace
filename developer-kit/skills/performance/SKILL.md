---
name: performance
description: "Performance analysis and optimization through measurement-driven profiling. Use for bottleneck identification, performance profiling, or speed analysis. Activates for: why is this slow, find bottlenecks, profile performance, optimize speed, analyze performance, improve response time. READ-ONLY."
allowed-tools:
  # Core Analysis
  - Read
  - Grep
  - Glob
  - Bash
  # Performance Documentation
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  # Pattern Research
  - mcp__github__search_code
  - mcp__github__get_file_contents
  # Best Practices Research
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  # Visual Performance Testing
  - mcp__playwright__browser_navigate
  - mcp__playwright__browser_snapshot
  # Structured Analysis
  - mcp__sequential-thinking__sequentialthinking
---

# Performance Skill

Identify performance bottlenecks through measurement-driven analysis using official documentation, profiling tools, and industry best practices. Provide data-backed optimization recommendations with clear metrics.

**Core Principle**: "Measure first, optimize second. Never assume where performance problems lie."

**Key Enhancement**: Research optimization patterns and best practices before making recommendations.

**Key Distinction**: This skill ANALYZES performance (read-only). For implementing optimizations, use the `improve` skill.

## Activation Triggers

- Speed issues ("why is this slow", "find bottlenecks")
- Performance profiling ("profile performance", "optimize speed")
- Web vitals ("Core Web Vitals", "LCP", "CLS", "INP")
- Response times ("improve response time", "API is slow")
- Load times ("page takes too long", "slow to load")
- Resource usage ("memory leak", "high CPU", "memory usage")

## Do NOT Activate When

- User wants to implement optimizations → use `improve` skill
- User wants general code analysis → use `analyze` skill
- User wants security assessment → use `security` skill
- User wants database query help → use `database` skill

**Boundary Clarification:**
This skill performs measurement-driven performance analysis. For implementing the optimizations identified, use the `improve` skill. The `analyze` skill provides general code analysis and will recommend this skill for performance-specific concerns.

## Behavioral Flow

```
┌──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
│   PROFILE    │   RESEARCH   │   ANALYZE    │   DIAGNOSE   │    REPORT    │
├──────────────┼──────────────┼──────────────┼──────────────┼──────────────┤
│ Gather       │ Lookup       │ Identify     │ Find root    │ Present      │
│ performance  │ official     │ bottlenecks  │ causes       │ findings     │
│ metrics      │ docs         │              │              │              │
│              │              │              │              │              │
│ Run          │ Find         │ Compare      │ Prioritize   │ Provide      │
│ profiling    │ optimization │ against      │ by impact    │ actionable   │
│ tools        │ patterns     │ benchmarks   │              │ fixes        │
│              │              │              │              │              │
│ Measure      │ Research     │ Calculate    │ Validate     │ Define       │
│ baselines    │ best         │ impact       │ hypotheses   │ success      │
│              │ practices    │              │              │ metrics      │
└──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘
     Bash           Context7      Grep/Read      Sequential      Output
     Lighthouse     GitHub        Playwright     Thinking        Report
                    Tavily
```

### Phase 1: PROFILE

Gather performance metrics with real data:

1. **Run profiling tools** - Lighthouse, Node.js profiler, browser DevTools
2. **Measure baselines** - Establish current performance metrics
3. **Identify hotspots** - CPU, memory, network, I/O
4. **Collect traces** - Flame graphs, heap snapshots, network waterfalls

```bash
# Frontend profiling with Lighthouse
npx lighthouse https://example.com --output=json --output-path=./report.json

# Node.js profiling
node --prof app.js
node --prof-process isolate-*.log > processed.txt

# Memory profiling
node --inspect app.js  # Connect Chrome DevTools

# Bundle analysis
npx webpack-bundle-analyzer stats.json
```

**Tools**: Bash, Read

### Phase 2: RESEARCH

Gather official documentation and optimization patterns:

```
# Lookup Lighthouse audit explanations
mcp__context7__resolve-library-id → "/googlechrome/lighthouse"
mcp__context7__query-docs("performance scoring metrics audits")

# Lookup Web Vitals measurement
mcp__context7__resolve-library-id → "/googlechrome/web-vitals"
mcp__context7__query-docs("LCP CLS INP measurement thresholds")

# Lookup Node.js performance APIs
mcp__context7__resolve-library-id → "/websites/nodejs_api"
mcp__context7__query-docs("performance hooks profiling")

# Find optimization patterns in codebases
mcp__github__search_code("React.memo useMemo useCallback filename:.tsx")

# Research current best practices
mcp__tavily__tavily-search("React performance optimization 2024 best practices")
```

**Tools**: Context7, GitHub MCP, Tavily

### Phase 3: ANALYZE

Identify bottlenecks and compare against benchmarks:

```
# Visual performance testing
mcp__playwright__browser_navigate("http://localhost:3000")
mcp__playwright__browser_snapshot()

# Pattern detection for common issues
Grep: useEffect.*\[\].*fetch  # Missing dependency arrays
Grep: JSON\.parse.*JSON\.stringify  # Unnecessary serialization
Grep: new Date\(\)  # Repeated date instantiation in loops
```

**Analysis Areas:**

- Bundle size and code splitting opportunities
- Render blocking resources
- Memory allocation patterns
- Database query efficiency
- Network waterfall analysis

**Tools**: Grep, Read, Playwright

### Phase 4: DIAGNOSE

Find root causes with structured reasoning:

```
mcp__sequential-thinking__sequentialthinking
- What does the profiling data show?
- Where is time actually being spent?
- What's the theoretical vs actual performance?
- What dependencies are in the critical path?
- What are the quick wins vs major refactors?
```

**Diagnosis Framework:**

- **Critical Path Analysis** - What blocks rendering/response?
- **Resource Contention** - CPU, memory, I/O bottlenecks?
- **Algorithmic Complexity** - O(n²) where O(n) possible?
- **Caching Opportunities** - What can be memoized/cached?

**Tools**: Sequential Thinking

### Phase 5: REPORT

Present findings with actionable recommendations:

- Summary with key bottlenecks
- Prioritized issues by impact
- Specific optimization recommendations
- Success metrics and targets

**Tools**: Output report

## MCP Integration

### Context7 (Official Documentation)

**Primary source for performance tooling documentation:**

```
mcp__context7__resolve-library-id - Resolve Lighthouse, Web Vitals, Node.js IDs
mcp__context7__query-docs - Get official documentation
```

**Available Resources:**

| Resource        | Library ID                          | Snippets |
| --------------- | ----------------------------------- | -------- |
| Lighthouse      | `/googlechrome/lighthouse`          | 600      |
| Web Vitals      | `/googlechrome/web-vitals`          | 138      |
| Node.js API     | `/websites/nodejs_api`              | 5,046    |
| React           | `/reactjs/react.dev`                | 3,742    |
| webpack         | `/websites/webpack_js`              | 4,569    |
| Chrome DevTools | `/chromedevtools/devtools-frontend` | 6,708    |

**Use cases:**

- "Lighthouse performance scoring calculation"
- "Web Vitals LCP optimization techniques"
- "Node.js performance hooks API"
- "React rendering optimization patterns"
- "webpack code splitting configuration"
- "Chrome DevTools Performance panel usage"

### GitHub MCP (Pattern Research)

**Find performance optimization patterns in production codebases:**

```
mcp__github__search_code - Find optimization patterns
mcp__github__get_file_contents - Get specific implementations
```

**Search patterns:**

```
# Find React performance optimizations
"React.memo" "useMemo" "useCallback" filename:.tsx stars:>500

# Find bundle optimization configs
"splitChunks" "optimization" filename:webpack.config.js

# Find caching implementations
"lru-cache" "memoize" filename:.ts stars:>100

# Find database query optimizations
"explain analyze" "index" filename:.sql

# Find lazy loading patterns
"React.lazy" "Suspense" "dynamic import" filename:.tsx
```

**Use cases:**

- Find how large projects optimize React rendering
- Research bundle splitting strategies
- Get caching implementation examples
- Study database query optimization patterns

### Tavily (Best Practices Research)

**Research current performance optimization techniques:**

```
mcp__tavily__tavily-search - Research optimization strategies
mcp__tavily__tavily-extract - Extract from performance guides
```

**Use cases:**

- "Core Web Vitals optimization strategies 2024"
- "React 18 concurrent rendering performance"
- "Node.js memory leak detection techniques"
- "Next.js performance optimization guide"
- "Database query optimization PostgreSQL"
- "CDN caching strategies best practices"

### Playwright (Visual Performance Testing)

**Test performance in real browser environment:**

```
mcp__playwright__browser_navigate - Load page for testing
mcp__playwright__browser_snapshot - Capture page state
```

**Use for:**

- Verify Core Web Vitals in real browser
- Test loading states and progressive rendering
- Validate lazy loading behavior
- Check resource loading waterfall

### Sequential Thinking (Structured Analysis)

**Systematic bottleneck investigation:**

```
mcp__sequential-thinking__sequentialthinking - Multi-step performance reasoning
```

**Use for:**

- Trace performance issues through complex systems
- Evaluate optimization trade-offs
- Prioritize fixes by impact
- Root cause analysis for memory leaks

## Focus Areas

### 1. Frontend Performance (Core Web Vitals)

| Metric | Target  | Description               |
| ------ | ------- | ------------------------- |
| LCP    | < 2.5s  | Largest Contentful Paint  |
| INP    | < 200ms | Interaction to Next Paint |
| CLS    | < 0.1   | Cumulative Layout Shift   |
| FCP    | < 1.8s  | First Contentful Paint    |
| TTFB   | < 800ms | Time to First Byte        |

**Common Issues:**

```javascript
// Bad: Render-blocking resources
<script src="large-bundle.js"></script>

// Good: Defer non-critical scripts
<script src="large-bundle.js" defer></script>

// Bad: Layout shift from images
<img src="hero.jpg">

// Good: Reserve space with dimensions
<img src="hero.jpg" width="800" height="600">

// Bad: Synchronous data fetching in component
const data = fetchDataSync();

// Good: Suspense with lazy loading
const LazyComponent = React.lazy(() => import('./Component'));
```

### 2. Backend Performance

| Metric          | Target  | Description                  |
| --------------- | ------- | ---------------------------- |
| API p95         | < 500ms | 95th percentile response     |
| DB query time   | < 100ms | Average query duration       |
| Memory usage    | < 512MB | Heap size under load         |
| Queries per req | < 10    | Database queries per request |

**Common Issues:**

```javascript
// Bad: N+1 query pattern
const users = await User.findAll();
for (const user of users) {
  user.posts = await Post.findAll({ where: { userId: user.id } });
}

// Good: Eager loading
const users = await User.findAll({
  include: [{ model: Post }]
});

// Bad: Missing database index
SELECT * FROM orders WHERE user_id = 123;

// Good: Add index
CREATE INDEX idx_orders_user_id ON orders(user_id);
```

### 3. Bundle Optimization

```javascript
// Analyze bundle size
npx webpack-bundle-analyzer stats.json

// Code splitting with dynamic imports
const HeavyComponent = React.lazy(() => import('./HeavyComponent'));

// Tree shaking - use named exports
import { debounce } from 'lodash-es'; // Good
import _ from 'lodash'; // Bad - imports entire library
```

### 4. Memory Management

```javascript
// Bad: Memory leak - event listener not cleaned
useEffect(() => {
  window.addEventListener("resize", handler);
  // Missing cleanup!
}, []);

// Good: Cleanup on unmount
useEffect(() => {
  window.addEventListener("resize", handler);
  return () => window.removeEventListener("resize", handler);
}, []);

// Bad: Holding references in closures
const cache = {};
function process(key, data) {
  cache[key] = data; // Never cleared
}

// Good: Use LRU cache with size limit
import LRU from "lru-cache";
const cache = new LRU({ max: 100 });
```

## Profiling Commands

```bash
# Node.js CPU profiling
node --prof app.js
node --prof-process isolate-*.log > processed.txt

# Node.js heap snapshot
node --inspect app.js
# Connect Chrome DevTools → Memory → Take snapshot

# Python profiling
python -m cProfile -o output.prof script.py
python -m snakeviz output.prof  # Visualize

# Frontend Lighthouse
npx lighthouse https://example.com --output=html
npx lighthouse https://example.com --only-categories=performance

# Bundle analysis
npx webpack --profile --json > stats.json
npx webpack-bundle-analyzer stats.json

# General timing
time command
hyperfine 'command1' 'command2'  # Benchmarking
```

## Output Format

```markdown
## Performance Analysis Report

### Summary

- **Critical bottlenecks**: 3
- **Quick wins identified**: 5
- **Estimated improvement**: 60% reduction in load time

### Core Web Vitals

| Metric | Current | Target  | Status |
| ------ | ------- | ------- | ------ |
| LCP    | 4.2s    | < 2.5s  | ❌     |
| INP    | 150ms   | < 200ms | ✅     |
| CLS    | 0.25    | < 0.1   | ❌     |

### Bottleneck #1: Large Contentful Paint (Critical)

- **Location**: Hero image on homepage
- **Current**: 4.2s LCP
- **Root Cause**: 2.5MB unoptimized hero image
- **Impact**: 40% of load time
- **Recommendation**:
  1. Convert to WebP format (est. 80% size reduction)
  2. Add width/height attributes
  3. Implement responsive images with srcset
- **Expected Improvement**: 4.2s → 1.5s LCP

### Bottleneck #2: Cumulative Layout Shift (High)

- **Location**: Ad placements and dynamic content
- **Current**: 0.25 CLS
- **Root Cause**: No reserved space for async content
- **Recommendation**: Add skeleton loaders with fixed dimensions
- **Expected Improvement**: 0.25 → 0.05 CLS

### Quick Wins

1. Enable gzip/brotli compression (est. 70% transfer reduction)
2. Add `loading="lazy"` to below-fold images
3. Defer non-critical JavaScript
4. Add `font-display: swap` to web fonts
5. Implement HTTP/2 server push for critical CSS

### Research Findings

- Similar issues: [Lighthouse issue #12345](link)
- Best practice: [Web.dev LCP guide](link)
- Pattern used by: [Next.js Image optimization](link)

### Metrics Baseline

| Metric         | Current | Target  | Priority |
| -------------- | ------- | ------- | -------- |
| Bundle size    | 2.1MB   | < 500KB | High     |
| API p95        | 1.2s    | < 500ms | Critical |
| Memory (heap)  | 890MB   | < 512MB | High     |
| DB queries/req | 47      | < 10    | Critical |
```

## Reference Files

For detailed profiling guides and patterns, see:

- `references/profiling-guide.md` - Profiling tools and techniques
- `references/optimization-patterns.md` - Common optimization patterns
- `references/caching-strategies.md` - Redis, in-memory, and HTTP caching patterns
- `references/database-performance.md` - Query optimization, indexing, and connection pooling
- `references/web-vitals-guide.md` - Core Web Vitals optimization

## Handoffs

| Scenario                        | Hand off to      |
| ------------------------------- | ---------------- |
| Need to implement optimizations | `improve` skill  |
| Need database query help        | `database` skill |
| Need frontend component changes | `frontend` skill |
| Need bundle configuration       | `devops` skill   |
| Need caching infrastructure     | `devops` skill   |

## Boundaries

**Will:**

- Profile and measure performance with real data
- Identify bottlenecks with evidence
- Research optimization patterns via MCP tools
- Provide specific, actionable recommendations
- Calculate expected impact of optimizations
- Define success metrics and targets
- Test performance in browser with Playwright

**Will Not:**

- Implement optimizations (use `improve` skill)
- Make architectural changes without approval
- Optimize without measuring first
- Assume where problems lie without profiling
- Skip baseline measurements
