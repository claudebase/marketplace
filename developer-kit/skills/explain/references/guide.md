# Explain Skill - Detailed Guide

## Behavioral Flow

```
┌──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
│   ANALYZE    │   RESEARCH   │   STRUCTURE  │   EXPLAIN    │   CONNECT    │
├──────────────┼──────────────┼──────────────┼──────────────┼──────────────┤
│ Read target  │ Lookup       │ Plan         │ Build        │ Link to      │
│ code to      │ official     │ explanation  │ understanding│ related      │
│ understand   │ documentation│ structure    │ progressively│ concepts     │
│              │              │              │              │              │
│ Identify     │ Find         │ Determine    │ Use          │ Suggest      │
│ key          │ examples     │ appropriate  │ analogies    │ next         │
│ concepts     │ and patterns │ depth level  │ and examples │ learning     │
│              │              │              │              │              │
│ Map          │ Research     │ Organize     │ Highlight    │ Answer       │
│ dependencies │ tutorials    │ concepts     │ common       │ follow-up    │
│              │              │              │ pitfalls     │ questions    │
└──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘
     Read           Context7      Sequential      Output         Output
     Grep           GitHub        Thinking        Explanation    References
                    Tavily
```

## Phase 1: ANALYZE

Understand the target code or concept:

1. **Read the code** - Understand the implementation and context
2. **Identify key concepts** - What fundamental ideas need explanation?
3. **Map dependencies** - What prerequisites does the user need?
4. **Assess complexity** - How deep should the explanation go?

```bash
# Find the code to explain
Read - Get the target file or function

# Understand context
Grep - Find related usages and patterns

# Check for existing documentation
Glob - Find related docs, comments, tests
```

## Phase 2: RESEARCH

Gather accurate information from official sources:

```
# Lookup React hooks concepts
mcp__context7__resolve-library-id → "/reactjs/react.dev"
mcp__context7__query-docs("useEffect cleanup function lifecycle")

# Lookup TypeScript generics
mcp__context7__resolve-library-id → "/websites/typescriptlang"
mcp__context7__query-docs("generics constraints extends keyof")

# Lookup Node.js event loop
mcp__context7__resolve-library-id → "/websites/nodejs_api"
mcp__context7__query-docs("event loop phases timers")

# Lookup design patterns
mcp__context7__resolve-library-id → "/websites/refactoring_guru-design-patterns"
mcp__context7__query-docs("factory pattern when to use")

# Find real-world examples in codebases
mcp__github__search_code("useEffect cleanup return filename:.tsx stars:>500")

# Research tutorials and explanations
mcp__tavily__tavily-search("React useEffect cleanup explained beginner")
```

## Phase 3: STRUCTURE

Plan the explanation with structured reasoning:

```
mcp__sequential-thinking__sequentialthinking
- What does the user already know (or need to know first)?
- What's the core concept in one sentence?
- What analogies would make this click?
- What examples would be most helpful?
- What common mistakes should I warn about?
- What should they learn next?
```

**Explanation Depth Levels:**

| Level        | Audience       | Focus                    | Examples             |
| ------------ | -------------- | ------------------------ | -------------------- |
| Beginner     | New to concept | Why it exists, analogies | Simple, isolated     |
| Intermediate | Knows basics   | How it works, patterns   | Real-world use cases |
| Advanced     | Experienced    | Edge cases, internals    | Complex scenarios    |

## Phase 4: EXPLAIN

Deliver the explanation using progressive teaching:

- Start with the "why" before the "how"
- Use analogies and real-world comparisons
- Build concepts incrementally
- Include working code examples
- Highlight common pitfalls

## Phase 5: CONNECT

Link to related concepts and learning paths:

- Reference related concepts
- Suggest next topics to explore
- Provide official documentation links
- Answer anticipated follow-up questions

## MCP Integration

### Context7 (Official Documentation)

**Available Resources:**

| Resource        | Library ID                                   | Snippets |
| --------------- | -------------------------------------------- | -------- |
| MDN Web Docs    | `/mdn/content`                               | 46,626   |
| React           | `/reactjs/react.dev`                         | 3,742    |
| Node.js API     | `/websites/nodejs_api`                       | 5,046    |
| TypeScript      | `/websites/typescriptlang`                   | 2,391    |
| Python          | `/websites/devdocs_io_python_3_14`           | 21,524   |
| Design Patterns | `/websites/refactoring_guru-design-patterns` | 1,696    |
| Vue.js 3        | `/vuejs/docs`                                | 1,178    |
| Go              | `/golang/go`                                 | 6,415    |
| Rust Book       | `/websites/doc_rust-lang_stable_book`        | 838      |

### GitHub MCP (Real Examples)

**Search patterns:**

```
# Find React hook patterns
"useEffect" "cleanup" "return" filename:.tsx stars:>500

# Find TypeScript generic examples
"<T extends" "keyof" filename:.ts stars:>500

# Find design pattern implementations
"class Factory" "createProduct" filename:.ts

# Find async/await patterns
"async function" "try" "catch" "await" filename:.ts stars:>1000
```

### Tavily (Educational Resources)

**Use cases:**

- "React useEffect explained for beginners"
- "TypeScript generics tutorial with examples"
- "JavaScript closure explained simply"
- "Design patterns real world examples"

## Explanation Styles

### 1. Beginner-Friendly (Educator)

- Start with the "why" - what problem does this solve?
- Use analogies from everyday life
- Build concepts one at a time
- Avoid jargon or explain it immediately

**Example:**

```markdown
## What is a Promise?

Think of a Promise like ordering food at a restaurant:

1. You place your order (call an async function)
2. The waiter gives you a number (returns a Promise)
3. You wait while the kitchen prepares your food (pending state)
4. Eventually, either:
   - Your food arrives (Promise fulfilled/resolved)
   - The kitchen is out of ingredients (Promise rejected)
```

### 2. System-Level (Architect)

- Focus on how components interact
- Explain data flow and state changes
- Highlight architectural decisions
- Discuss trade-offs

### 3. Technical Deep-Dive

- Detailed implementation analysis
- Performance implications
- Edge cases and gotchas
- Source code references

## Progressive Explanation Structure

```markdown
## [Concept Name]

### Overview

[1-2 sentences: What is this and why does it matter?]

### The Core Idea

[The essential concept in simple terms, possibly with an analogy]

### How It Works

[Step-by-step breakdown with examples]

### Practical Example

[Working code with annotations]

### Common Pitfalls

[What to watch out for, with examples of wrong vs right]

### When to Use (and Not Use)

[Appropriate use cases and alternatives]

### Related Concepts

[What to learn next, with brief explanations of connections]
```

## Teaching Techniques

### Analogies Library

| Concept      | Analogy                                       |
| ------------ | --------------------------------------------- |
| Variables    | Labeled boxes that hold things                |
| Functions    | Recipes with ingredients (params) and results |
| Promises     | Restaurant order tickets                      |
| Callbacks    | "Call me when you're done"                    |
| Closures     | Backpack that remembers where you came from   |
| APIs         | Restaurant menus (interface to kitchen)       |
| Caching      | Sticky notes on your desk                     |
| Recursion    | Russian nesting dolls                         |
| Event Loop   | Single chef with multiple order tickets       |
| Immutability | Photocopying documents instead of editing     |

### Common Misconceptions

```javascript
// Misconception: == and === are basically the same
"1" == 1; // true (type coercion)
"1" === 1; // false (strict equality)
// Always use === unless you specifically need type coercion

// Misconception: const means immutable
const arr = [1, 2, 3];
arr.push(4); // Works! const prevents reassignment, not mutation
arr = [5]; // Error! Can't reassign

// Misconception: async/await replaces Promises
// Reality: async/await IS Promise syntax sugar
async function getData() {
  return "hello"; // Returns Promise.resolve("hello")
}
```

## Output Format

```markdown
## Explanation: [Concept/Code Being Explained]

### Overview

[Brief summary of what this is and why it matters]

### Research Sources

- Official docs: [Context7 sources used]
- Real examples: [GitHub patterns found]

### Explanation Level: [Beginner/Intermediate/Advanced]

[Main explanation content following progressive structure]

### Key Takeaways

1. [Most important point]
2. [Second key point]
3. [Third key point]

### Common Pitfalls

- [Pitfall 1 with example]
- [Pitfall 2 with example]

### Learn More

- [Related concept 1]: [Brief description]
- [Related concept 2]: [Brief description]
```
