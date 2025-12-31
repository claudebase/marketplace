---
name: dk:recommend
description: Get recommendations for libraries, tools, patterns, or approaches
delegates-to: research
operation: recommend
argument-hint: "<topic> [--criteria performance|simplicity|popularity] [--alternatives]"
allowed-tools: Read, Grep, Glob, WebSearch, Task
---

Execute the **research** skill in recommendation mode.

## Delegation

This command delegates to the `research` skill which provides:

- Multi-source information gathering
- Feature comparison and analysis
- Community health assessment
- Ranked recommendations with rationale

## Parameters

| Parameter        | Description                                                          |
| ---------------- | -------------------------------------------------------------------- |
| `topic`          | What to get recommendations for                                      |
| `--criteria`     | Optimization focus: performance, simplicity, popularity, or balanced |
| `--alternatives` | Include multiple options with trade-offs                             |
| `--expertise`    | Target level: beginner, intermediate, or expert                      |

## Recommendation Methodology

The research skill:

1. **Search**: Find options via web search and documentation
2. **Compare**: Analyze features, trade-offs, and use cases
3. **Evaluate**: Check community health, maintenance, ecosystem
4. **Rank**: Order by relevance to criteria
5. **Present**: Provide actionable recommendations

## Output Format

````markdown
## Recommendation: [Topic]

### Top Pick: [Library/Tool Name]

**Why**: [Rationale]

**Pros**:

- [Advantage 1]
- [Advantage 2]

**Cons**:

- [Limitation 1]

**Quick Start**:

```bash
npm install [package]
```
````

### Alternatives

| Option  | Best For   | Trade-off   |
| ------- | ---------- | ----------- |
| [Alt 1] | [Use case] | [Trade-off] |
| [Alt 2] | [Use case] | [Trade-off] |

### Community Health

- GitHub Stars: X
- Last Updated: [date]
- Maintainer: [active/inactive]

````

## Examples

```bash
recommend "state management for React"
recommend "testing framework for Node.js" --criteria simplicity
recommend "database for serverless" --alternatives
recommend "authentication library" --expertise beginner
````

## Related

- `research` skill - Information gathering
- `index` - Codebase indexing
- `brainstorm` skill - Explore ideas
