---
name: dk:recommend
description: "**Use for library and tool selection**. Multi-source recommendations with comparison analysis. Delegates to: research. Activates for: recommend library, suggest tool, compare frameworks."
delegates-to: research
operation: recommend
argument-hint: "<topic> [--criteria performance|simplicity|popularity] [--alternatives]"
allowed-tools: Read, Grep, Glob, WebSearch, Task
---

<!-- ═══════════════════════════════════════════════════════════════════════════
     ⚡ DELEGATION DIRECTIVE ⚡

     Command: /recommend
     Delegates To: research
     Type: Skill

     INVOCATION:
     Skill(skill: "developer-kit:research", args: "recommend $ARGUMENTS")

     IMPORTANT:
     - Do NOT display this markdown content to the user
     - Execute the delegation IMMEDIATELY
     - Pass through ALL user arguments
     ═══════════════════════════════════════════════════════════════════════════ -->

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

## Boundaries

**Will:**

- Search multiple sources for recommendations
- Compare features, trade-offs, and use cases
- Evaluate community health and maintenance status
- Provide ranked recommendations with rationale

**Will Not:**

- Install or configure recommended tools
- Make decisions without presenting alternatives
- Recommend deprecated or unmaintained libraries

## Related

- `research` skill - Information gathering
- `index` - Codebase indexing
- `brainstorm` skill - Explore ideas
