# Learning Guide - Teaching Patterns

## Analogies Library

### Programming Basics

| Concept     | Analogy                                       |
| ----------- | --------------------------------------------- |
| Variables   | Labeled boxes that hold things                |
| Functions   | Recipes with ingredients (params) and results |
| Classes     | Blueprints for building objects               |
| Inheritance | Family traits passed down                     |

### Async/Concurrency

| Concept     | Analogy                                 |
| ----------- | --------------------------------------- |
| Promises    | Restaurant order tickets                |
| Callbacks   | "Call me when you're done"              |
| Event Loop  | Single chef with multiple order tickets |
| Async/Await | Waiting for coffee while reading a book |

### Data Structures

| Concept      | Analogy                            |
| ------------ | ---------------------------------- |
| Arrays       | Numbered lockers in a row          |
| Objects/Maps | Dictionary with word -> definition |
| Stacks       | Stack of plates (LIFO)             |
| Queues       | Line at a store (FIFO)             |
| Trees        | Family tree / org chart            |
| Graphs       | Social network connections         |

### Web Concepts

| Concept   | Analogy                                |
| --------- | -------------------------------------- |
| APIs      | Restaurant menu (interface to kitchen) |
| HTTP      | Ordering by mail with request/response |
| Caching   | Sticky notes on your desk              |
| Databases | Filing cabinets with organized folders |

### Patterns

| Concept              | Analogy                                     |
| -------------------- | ------------------------------------------- |
| Closures             | Backpack that remembers where you came from |
| Immutability         | Photocopying documents instead of editing   |
| Dependency Injection | Bringing your own ingredients to recipe     |
| Observer             | Newsletter subscription                     |

## Common Misconceptions

### JavaScript

```javascript
// ❌ Misconception: "const makes values immutable"
// ✅ Reality: "const prevents reassignment, not mutation"
const arr = [1, 2, 3];
arr.push(4); // Works! const prevents reassignment, not mutation
arr = [5]; // Error! Can't reassign

// ❌ Misconception: "== and === are basically the same"
// ✅ Reality: "== coerces types, === checks strictly"
"1" == 1; // true (type coercion)
"1" === 1; // false (strict equality)

// ❌ Misconception: "async/await replaces Promises"
// ✅ Reality: "async/await IS Promise syntax sugar"
async function getData() {
  return "hello"; // Returns Promise.resolve("hello")
}
```

### React

```javascript
// ❌ Misconception: "useEffect runs after every render"
// ✅ Reality: "useEffect runs based on dependency array"
useEffect(() => {}, []); // Runs once on mount
useEffect(() => {}, [id]); // Runs when id changes

// ❌ Misconception: "State updates are synchronous"
// ✅ Reality: "State updates are batched and async"
setCount(count + 1);
console.log(count); // Still old value!
```

## Progressive Complexity Levels

### Level 1 - Core Concept

- Simplest possible example
- One concept only
- Remove all non-essentials

### Level 2 - Real Usage

- Add practical context
- Introduce common patterns
- Show typical use case

### Level 3 - Edge Cases

- Handle exceptions
- Show error handling
- Discuss limitations

### Level 4 - Advanced Patterns

- Combine with other concepts
- Show optimization
- Discuss alternatives

### Example: Teaching useEffect

```javascript
// Level 1: Simple effect
useEffect(() => {
  console.log("Component mounted");
}, []);

// Level 2: Fetching data
useEffect(() => {
  fetchUser(userId).then(setUser);
}, [userId]);

// Level 3: Cleanup
useEffect(() => {
  const subscription = subscribe(id);
  return () => subscription.unsubscribe();
}, [id]);

// Level 4: Race conditions
useEffect(() => {
  let cancelled = false;
  fetchData().then((data) => {
    if (!cancelled) setData(data);
  });
  return () => {
    cancelled = true;
  };
}, []);
```

## Explanation Styles

### Beginner-Friendly (Educator)

```yaml
Approach:
  - Start with the "why" - what problem does this solve?
  - Use analogies from everyday life
  - Build concepts one at a time
  - Avoid jargon or explain it immediately
  - Celebrate small wins

Tone: Encouraging, patient, no assumptions

Example: "Think of a Promise like ordering food at a restaurant:
  1. You place your order (call an async function)
  2. The waiter gives you a number (returns a Promise)
  3. You wait while the kitchen prepares (pending state)
  4. Eventually:
  - Your food arrives (Promise fulfilled)
  - Kitchen is out of ingredients (Promise rejected)"
```

### Intermediate-Depth (Practitioner)

```yaml
Approach:
  - Assume basic understanding
  - Focus on patterns and best practices
  - Show real-world use cases
  - Discuss trade-offs and alternatives

Tone: Practical, direct, examples-focused

Example: "The dependency array tells React when to re-run your effect:
  - No array: runs on every render
  - []: runs once on mount
  - [userId]: runs when userId changes

  Common pitfalls:
  - Missing dependency → stale closures
  - Object dependency → infinite loop"
```

### Advanced Deep-Dive (Expert)

```yaml
Approach:
  - Detailed implementation analysis
  - Performance implications
  - Edge cases and gotchas
  - Internal mechanisms

Tone: Technical, thorough, implementation-focused
```

## Learning Path Templates

### React Learning Path

```yaml
Prerequisites:
  - HTML/CSS basics
  - JavaScript fundamentals
  - ES6+ syntax

Week 1-2: React Fundamentals
  - Components and JSX
  - Props and state (useState)
  - Event handling
  - Conditional rendering
  - Lists and keys
  Project: Todo list

Week 3-4: Effects and Data
  - useEffect basics
  - Fetching data
  - Cleanup and dependencies
  - Custom hooks basics
  Project: Movie search app

Week 5-6: State Management
  - Lifting state up
  - useContext
  - useReducer
  - When to use each
  Project: Shopping cart

Week 7-8: Advanced Patterns
  - Performance (useMemo, useCallback)
  - Refs and DOM
  - Error boundaries
  - Testing components
  Project: Dashboard
```

### Backend Learning Path

```yaml
Prerequisites:
  - Basic programming
  - Command line basics
  - HTTP basics

Phase 1: Foundation
  - Choose language (Node.js/Python/Go)
  - Framework basics
  - REST API concepts
  - Request/Response cycle
  Project: Simple CRUD API

Phase 2: Data Layer
  - Database fundamentals
  - ORM usage
  - Migrations
  - Query optimization
  Project: API with database

Phase 3: Authentication
  - Sessions vs tokens
  - JWT implementation
  - Password hashing
  - OAuth basics
  Project: Auth system

Phase 4: Production Ready
  - Error handling
  - Logging and monitoring
  - Environment configuration
  - Deployment basics
  Project: Deploy to cloud
```

## Tutorial Templates

### Concept Explanation

```markdown
## [Concept Name]

### Overview

[1-2 sentences: What is this and why does it matter?]

### The Core Idea

[The essential concept in simple terms, with analogy]

### How It Works

[Step-by-step breakdown with examples]

### Practical Example

[Working code with annotations]

### Common Pitfalls

[What to watch out for, with wrong vs right examples]

### When to Use (and Not Use)

[Appropriate use cases and alternatives]

### Related Concepts

[What to learn next, with brief explanations]
```

### Tutorial Structure

```markdown
# [Tutorial Title]

## Overview

What you'll learn and build in this tutorial.

**Prerequisites:**

- Prerequisite 1
- Prerequisite 2

**Time to complete:** ~X minutes

## Step 1: [First Step]

[Clear instruction]

\`\`\`[language]
// Code example
\`\`\`

**Verify:** [How to know it worked]

## Step 2: [Second Step]

[Continue pattern...]

## What You've Learned

- Key takeaway 1
- Key takeaway 2
- Key takeaway 3

## Next Steps

- [Related tutorial 1]
- [Related concept 2]
```

## Exercise Patterns

### Prediction Exercise

```markdown
**What does this code output?**

\`\`\`javascript
console.log("1");
setTimeout(() => console.log("2"), 0);
Promise.resolve().then(() => console.log("3"));
console.log("4");
\`\`\`

Think about it before running...

<details>
<summary>Answer</summary>

Output: 1, 4, 3, 2

Why: Sync first, then microtasks (Promise), then macrotasks (setTimeout)

</details>
```

### Fix the Bug

```markdown
**This code has a bug. Can you spot and fix it?**

\`\`\`javascript
function Counter() {
const [count, setCount] = useState(0);

function handleClick() {
setCount(count + 1);
setCount(count + 1);
}
// Bug: Both setCount use stale count value
}
\`\`\`

<details>
<summary>Solution</summary>

Problem: State updates use stale closure value

Fixed:

\`\`\`javascript
function handleClick() {
setCount((c) => c + 1);
setCount((c) => c + 1);
}
\`\`\`

</details>
```

### Extend the Code

```markdown
**Add error handling to this code:**

\`\`\`javascript
async function fetchUser(id) {
const response = await fetch(`/api/users/${id}`);
return response.json();
}
\`\`\`

Requirements:

- Handle network errors
- Handle 404 responses
- Return null on error

<details>
<summary>Solution</summary>

\`\`\`javascript
async function fetchUser(id) {
try {
const response = await fetch(`/api/users/${id}`);
if (!response.ok) {
if (response.status === 404) return null;
throw new Error(`HTTP ${response.status}`);
}
return response.json();
} catch (error) {
console.error("Fetch failed:", error);
return null;
}
}
\`\`\`

</details>
```

## Compare and Contrast Template

| Aspect      | Concept A       | Concept B       |
| ----------- | --------------- | --------------- |
| Purpose     | [What it's for] | [What it's for] |
| Syntax      | [How to write]  | [How to write]  |
| When to Use | [Use cases]     | [Use cases]     |
| Gotchas     | [Common issues] | [Common issues] |

### Common Comparisons

**JavaScript:**

- let vs const vs var
- == vs ===
- null vs undefined
- map vs forEach
- Promise.all vs Promise.allSettled

**React:**

- useState vs useReducer
- useEffect vs useLayoutEffect
- useMemo vs useCallback
- Context vs Redux

**General:**

- REST vs GraphQL
- SQL vs NoSQL
- Composition vs Inheritance
- Monolith vs Microservices

## Research Workflow

```yaml
1. Official Documentation: mcp__context7__resolve-library-id("[topic]")
  mcp__context7__query-docs(libraryId, "[query]")

2. Real-World Examples: mcp__github__search_code("[pattern] filename:[ext] stars:>500")

3. Educational Resources: mcp__tavily__tavily-search("[topic] explained simply")
  mcp__tavily__tavily-extract(tutorialUrl)

4. Codebase Context: Read user's actual code being discussed
  Grep for related patterns
```
