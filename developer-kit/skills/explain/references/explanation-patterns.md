# Explanation Patterns Guide

## Core Principles

### 1. Start with WHY
Before explaining HOW something works, explain WHY it exists:
- What problem does it solve?
- Why was this approach chosen?
- What would happen without it?

### 2. Build Progressively
Layer explanations from simple to complex:
1. High-level concept (1 sentence)
2. Basic mechanics (1 paragraph)
3. Detailed implementation (as needed)
4. Edge cases and advanced usage

### 3. Use Concrete Examples
Abstract concepts need concrete grounding:
- Show before telling
- Use realistic, relatable scenarios
- Include code snippets with comments

## Explanation Templates

### For Functions/Methods
```markdown
## What It Does
[One sentence: Input → Output transformation]

## How It Works
1. [First step with example]
2. [Second step with example]
3. [Result and return value]

## Parameters
- `param1`: [Purpose and valid values]
- `param2`: [Purpose and valid values]

## Example Usage
[Code example with comments]

## Edge Cases
- [Edge case 1 and how it's handled]
- [Edge case 2 and how it's handled]
```

### For Classes/Components
```markdown
## Purpose
[Why this class exists and its responsibility]

## Key Properties
- `property1`: [What it stores and why]
- `property2`: [What it stores and why]

## Key Methods
- `method1()`: [What it does]
- `method2()`: [What it does]

## Lifecycle
[How instances are created, used, and destroyed]

## Usage Pattern
[Common usage example]
```

### For Algorithms
```markdown
## Problem It Solves
[The problem and why it matters]

## Core Idea
[One-sentence intuition]

## Step by Step
1. [Step with visualization]
2. [Step with visualization]
3. [Final result]

## Time/Space Complexity
- Time: O(n) because...
- Space: O(1) because...

## When to Use
[Ideal scenarios for this algorithm]

## When NOT to Use
[Scenarios where alternatives are better]
```

### For Concepts/Patterns
```markdown
## What It Is
[Definition in plain language]

## Why It Matters
[Problems it solves, benefits]

## Real-World Analogy
[Relatable comparison]

## Code Example
[Minimal working example]

## Common Misconceptions
[What people often get wrong]

## Related Concepts
[What to learn next]
```

## Depth Calibration

### Beginner Level
- Assume no prior knowledge of the specific topic
- Explain all jargon when first introduced
- Use more analogies, fewer technical details
- Shorter code examples with more comments

### Intermediate Level
- Assume basic programming knowledge
- Brief jargon explanations
- Balance analogies with technical detail
- Full working examples

### Advanced Level
- Assume domain expertise
- Technical terminology without explanation
- Focus on nuances and edge cases
- Complex, real-world examples

## Avoiding Common Pitfalls

### Don't
- Assume knowledge without checking
- Use jargon without explanation
- Give only abstract descriptions
- Skip the "why"

### Do
- Start with what they likely know
- Define terms in context
- Show concrete examples first
- Connect to real problems
