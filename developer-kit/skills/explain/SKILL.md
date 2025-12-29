---
name: explain
description: "Educational explanations of code, concepts, and system behavior (READ-ONLY - teaches understanding without modifying code). For creating documentation artifacts, use 'document' skill. Activates for: what does this do, how does this work, explain this, teach me about, help me understand, walk me through."
allowed-tools:
  - Read
  - Grep
  - Glob
  - mcp__context7__resolve-library-id
  - mcp__context7__get-library-docs
  - mcp__sequential-thinking__sequentialthinking
---

# Code Explanation Skill

## Purpose

Provide clear, educational explanations of code, concepts, and system behavior. Help users understand how things work with appropriate depth and context.

**Key Principle**: Teach, don't just describe. Build understanding progressively.

## When to Use

**Activate When:**
- User asks "what does this do" or "how does this work"
- User wants to understand code, algorithms, or patterns
- User asks to "explain", "teach", or "walk through" something
- User needs framework or library concept clarification

**Do NOT Activate When:**
- User wants to find bugs or issues → use `analyze` skill
- User wants security assessment → use `security` skill
- User wants to fix or improve code → use `debug` or `improve` skills

## Explanation Styles

### 1. Beginner-Friendly (Educator)
- Start with the "why" before the "how"
- Use analogies and real-world comparisons
- Build concepts progressively
- Avoid jargon or explain it when used

### 2. System-Level (Architect)
- Focus on component interactions
- Explain data flow and dependencies
- Highlight architectural decisions
- Connect to broader system context

### 3. Technical Deep-Dive
- Detailed implementation analysis
- Performance implications
- Edge cases and gotchas
- Advanced patterns and techniques

## Methodology

1. **Analyze**: Read and understand the target code/concept
2. **Assess**: Determine appropriate explanation depth
3. **Structure**: Plan explanation with progressive complexity
4. **Generate**: Create clear explanation with examples
5. **Validate**: Ensure accuracy and educational value

## Progressive Explanation Structure

```
## Overview
[1-2 sentences: What is this and why does it matter?]

## How It Works
[Step-by-step breakdown with examples]

## Key Concepts
[Important terms and patterns explained]

## Example
[Practical code example with annotations]

## Common Pitfalls
[What to watch out for]

## Related Concepts
[What to learn next]
```

## MCP Integration

**Use Context7 for framework-accurate explanations:**
```
mcp__context7__resolve-library-id - Resolve library names first
mcp__context7__get-library-docs - Fetch official documentation
```
Context7 ensures explanations align with official patterns and best practices.

**Use Sequential Thinking for complex concept breakdowns:**
```
mcp__sequential-thinking__sequentialthinking - Use for structured educational reasoning
```
Sequential Thinking helps organize multi-layered explanations progressively.

## Reference Files

For detailed explanation patterns, see:
- `references/explanation-patterns.md` - How to structure explanations
- `references/analogy-library.md` - Common analogies for concepts
