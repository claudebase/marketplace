---
name: explain
description: "Educational explanations of code, concepts, and system behavior (READ-ONLY - teaches understanding without modifying code). For creating documentation artifacts, use 'document' skill. Activates for: what does this do, how does this work, explain this, teach me about, help me understand, walk me through."
allowed-tools:
  # Core Analysis
  - Read
  - Grep
  - Glob
  # Official Documentation
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  # Pattern Research
  - mcp__github__search_code
  - mcp__github__get_file_contents
  # Educational Resources
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  # Structured Explanation
  - mcp__sequential-thinking__sequentialthinking
---

# Code Explanation Skill

Provide clear, educational explanations of code, concepts, and system behavior using official documentation, real-world examples, and progressive teaching techniques.

**Core Principle**: "Teach, don't just describe. Build understanding progressively from foundations to mastery."

**Key Enhancement**: Research official documentation and find real examples before explaining concepts.

**Key Distinction**: This skill EXPLAINS concepts (read-only). For creating documentation files, use the `document` skill. For analyzing code quality, use the `analyze` skill.

## Activation Triggers

- Understanding requests ("what does this do", "how does this work")
- Learning requests ("explain this", "teach me about")
- Clarification ("help me understand", "walk me through")
- Concept exploration ("what is", "why would I use")
- Pattern questions ("when should I use", "what's the difference between")

## Do NOT Activate When

- User wants to create documentation files → use `document` skill
- User wants code analysis/review → use `analyze` skill
- User wants to find bugs → use `debug` skill
- User wants to fix or improve code → use `improve` skill
- User wants security assessment → use `security` skill

**Boundary Clarification:**
This skill provides educational explanations in conversation. For creating documentation artifacts (README, API docs, JSDoc), use the `document` skill. For professional technical writing, use the `technical-writer` agent.

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

### Phase 1: ANALYZE

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

**Tools**: Read, Grep, Glob

### Phase 2: RESEARCH

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

**Tools**: Context7, GitHub MCP, Tavily

### Phase 3: STRUCTURE

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

**Tools**: Sequential Thinking

### Phase 4: EXPLAIN

Deliver the explanation using progressive teaching:

- Start with the "why" before the "how"
- Use analogies and real-world comparisons
- Build concepts incrementally
- Include working code examples
- Highlight common pitfalls

**Tools**: Output explanation

### Phase 5: CONNECT

Link to related concepts and learning paths:

- Reference related concepts
- Suggest next topics to explore
- Provide official documentation links
- Answer anticipated follow-up questions

**Tools**: Output references

## MCP Integration

### Context7 (Official Documentation)

**Primary source for accurate concept explanations:**

```
mcp__context7__resolve-library-id - Resolve language/framework IDs
mcp__context7__query-docs - Get official documentation
```

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
| Algorithms      | `/websites/algs4_cs_princeton_edu`           | 17,071   |

**Use cases:**

- "React hooks useEffect dependencies explained"
- "TypeScript generics with constraints"
- "Node.js event loop phases"
- "Python asyncio coroutines"
- "Design patterns factory vs abstract factory"
- "Go channels and goroutines"
- "Rust ownership and borrowing"

### GitHub MCP (Real Examples)

**Find real-world code examples:**

```
mcp__github__search_code - Find implementation patterns
mcp__github__get_file_contents - Get specific examples
```

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

# Find algorithm implementations
"function quickSort" "partition" filename:.ts
```

**Use cases:**

- Find how popular projects implement patterns
- Get real-world usage examples
- Show best practices in context
- Compare different approaches

### Tavily (Educational Resources)

**Research tutorials and educational content:**

```
mcp__tavily__tavily-search - Find explanations and tutorials
mcp__tavily__tavily-extract - Extract from educational content
```

**Use cases:**

- "React useEffect explained for beginners"
- "TypeScript generics tutorial with examples"
- "JavaScript closure explained simply"
- "Design patterns real world examples"
- "Node.js streams tutorial"
- "Async await vs promises comparison"

### Sequential Thinking (Structured Explanation)

**Systematic explanation planning:**

```
mcp__sequential-thinking__sequentialthinking - Plan progressive explanation
```

**Use for:**

- Determining explanation depth
- Organizing concept hierarchy
- Planning analogy selection
- Structuring multi-part explanations
- Anticipating follow-up questions

## Explanation Styles

### 1. Beginner-Friendly (Educator)

**Approach:**

- Start with the "why" - what problem does this solve?
- Use analogies from everyday life
- Build concepts one at a time
- Avoid jargon or explain it immediately
- Celebrate small wins

````markdown
## What is a Promise?

Think of a Promise like ordering food at a restaurant:

1. You place your order (call an async function)
2. The waiter gives you a number (returns a Promise)
3. You wait while the kitchen prepares your food (pending state)
4. Eventually, either:
   - Your food arrives (Promise fulfilled/resolved)
   - The kitchen is out of ingredients (Promise rejected)

```javascript
// Placing an order (calling async function)
const myOrder = fetch("/api/menu");

// Waiting for the result
myOrder
  .then((food) => console.log("Yay, food!", food)) // Fulfilled
  .catch((error) => console.log("No food :(", error)); // Rejected
```
````

The key insight: Promises let you write code that says "do this later,
when the result is ready" without blocking everything else.

````

### 2. System-Level (Architect)

**Approach:**
- Focus on how components interact
- Explain data flow and state changes
- Highlight architectural decisions
- Connect to broader system context
- Discuss trade-offs

```markdown
## React's Reconciliation Algorithm

When state changes, React doesn't just re-render everything. Here's the flow:

````

State Change
↓
Virtual DOM Update (fast, in-memory)
↓
Diffing Algorithm (compare old vs new)
↓
Minimal DOM Updates (only what changed)

```

**Key Architectural Decisions:**

1. **Virtual DOM**: React maintains a lightweight copy of the DOM in memory.
   This allows fast comparisons without touching the real DOM.

2. **Fiber Architecture**: Work is broken into units that can be paused
   and resumed, enabling prioritization of urgent updates.

3. **Keys for Lists**: When you provide unique keys, React can track
   which items moved vs which were added/removed.

**Trade-offs:**
- Memory overhead for virtual DOM
- Initial bundle size for React runtime
- Learning curve for mental model
```

### 3. Technical Deep-Dive

**Approach:**

- Detailed implementation analysis
- Performance implications
- Edge cases and gotchas
- Advanced patterns and techniques
- Source code references

```markdown
## JavaScript Event Loop Internals

The event loop processes tasks in a specific order:
```

┌───────────────────────────────┐
│ Call Stack │ ← Synchronous code runs here
├───────────────────────────────┤
│ │
│ ┌─────────────────────────┐ │
│ │ Microtask Queue │ │ ← Promises, queueMicrotask
│ │ (drain completely) │ │
│ └─────────────────────────┘ │
│ │
│ ┌─────────────────────────┐ │
│ │ Macrotask Queue │ │ ← setTimeout, setInterval, I/O
│ │ (one per tick) │ │
│ └─────────────────────────┘ │
│ │
└───────────────────────────────┘

````

**Critical Detail:** Microtasks drain completely before the next macrotask.
This means Promise.then() callbacks run before setTimeout(..., 0).

```javascript
console.log('1');
setTimeout(() => console.log('2'), 0);
Promise.resolve().then(() => console.log('3'));
console.log('4');

// Output: 1, 4, 3, 2
// Why? 1,4 are sync, 3 is microtask, 2 is macrotask
````

**Edge Case:** If microtasks keep adding more microtasks, the macrotask
queue starves. This can cause UI freezing.

````

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
````

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
- Tutorials: [Tavily resources referenced]

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
- Official docs: [Link to documentation]
```

## Reference Files

For detailed explanation patterns, see:

- `references/explanation-patterns.md` - How to structure explanations
- `references/analogy-library.md` - Common analogies for concepts
- `references/misconceptions.md` - Common misunderstandings by topic
- `references/progressive-teaching.md` - Building understanding incrementally

## Handoffs

| Scenario                           | Hand off to              |
| ---------------------------------- | ------------------------ |
| Need to create documentation files | `document` skill         |
| Need code analysis                 | `analyze` skill          |
| Need to fix issues                 | `debug` skill            |
| Need to improve code               | `improve` skill          |
| Need comprehensive tech writing    | `technical-writer` agent |
| Need learning curriculum           | `learning-guide` agent   |

## Boundaries

**Will:**

- Explain code, concepts, and system behavior clearly
- Research official documentation via Context7
- Find real-world examples via GitHub MCP
- Use analogies and progressive teaching
- Adapt explanation depth to user's level
- Connect concepts to learning paths
- Highlight common pitfalls and misconceptions

**Will Not:**

- Create documentation files (use `document` skill)
- Modify source code (read-only skill)
- Make architectural decisions
- Analyze code quality (use `analyze` skill)
- Fix or debug issues (use `debug` skill)
- Replace comprehensive tutorials (suggest resources instead)
