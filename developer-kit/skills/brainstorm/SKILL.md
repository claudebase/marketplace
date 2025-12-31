---
name: brainstorm
description: "Auto-invoke when requirements are unclear. Triggers: 'I want to build', 'thinking about', 'maybe', 'not sure how', 'explore ideas', 'help me figure out', 'what if', 'should I', 'how would I'. Provides Socratic requirements discovery through guided questions. DO NOT start implementing vague ideas - this skill clarifies requirements first. Exploratory only."
composable: true
mode: read-only
allowed-tools:
  # Core Analysis
  - Read
  - Grep
  - Glob
  # Interactive Discovery
  - AskUserQuestion
  # Market & Trend Research
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  # Pattern Discovery
  - mcp__github__search_repositories
  - mcp__github__search_code
  - mcp__github__get_file_contents
  # Design Patterns Reference
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  # Structured Ideation
  - mcp__sequential-thinking__sequentialthinking
---

# Requirements Discovery Skill

Transform vague ideas into concrete requirements through Socratic dialogue, market research, and pattern discovery.

**Key Principle**: Ask, don't assume. Explore before building. Research to inform.

**Key Distinction**: This skill EXPLORES through questions and research. For concrete design output, use `design` skill. For implementation, use `implement` skill.

## Activation Triggers

- Vague ideas ("I want to build...", "thinking about maybe...")
- Uncertainty ("not sure how to approach...", "help me figure out...")
- Exploration ("explore ideas", "what are the options...")
- Validation ("is this a good idea?", "what do you think about...")
- Market research ("what's out there?", "how do others do this?")

## Do NOT Activate When

- User wants external technical docs → use `research` skill
- User wants concrete design specs → use `design` skill
- User wants implementation → use `implement` skill
- User has clear requirements already

## Behavioral Flow

```
┌──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
│   DISCOVER   │   RESEARCH   │   EXPLORE    │  SYNTHESIZE  │  CRYSTALLIZE │
├──────────────┼──────────────┼──────────────┼──────────────┼──────────────┤
│ Understand   │ Search       │ Ask          │ Connect      │ Document     │
│ initial      │ market &     │ Socratic     │ patterns     │ requirements │
│ idea         │ competitors  │ questions    │ to needs     │              │
│              │              │              │              │              │
│ Identify     │ Find         │ Challenge    │ Identify     │ Prioritize   │
│ problem      │ similar      │ assumptions  │ trade-offs   │ must-haves   │
│ space        │ solutions    │              │              │              │
│              │              │              │              │              │
│ Map          │ Gather       │ Explore      │ Build        │ Define       │
│ stakeholders │ inspiration  │ alternatives │ consensus    │ next steps   │
└──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘
     Read           Tavily       AskUser       Sequential      Output
     Grep           GitHub                     Thinking        Summary
```

### Phase 1: DISCOVER

Understand the initial idea and problem space:

1. **Listen actively** - Let user explain their idea without interruption
2. **Identify the problem** - What pain point drives this idea?
3. **Map stakeholders** - Who benefits? Who is affected?
4. **Establish context** - What's the environment? What constraints exist?

**Tools**: Read, Grep, Glob (for existing codebase context)

### Phase 2: RESEARCH

Gather market intelligence and existing solutions:

```
# Search for similar products/solutions
mcp__tavily__tavily-search("best tools for [problem domain] 2024")

# Find competitor analysis
mcp__tavily__tavily-search("[problem] solutions comparison")

# Discover existing open-source solutions
mcp__github__search_repositories("topic:[relevant-topic] stars:>100")

# Find implementation patterns
mcp__github__search_code("[pattern] filename:README.md")

# Lookup design patterns for the domain
mcp__context7__resolve-library-id → "/websites/refactoring_guru-design-patterns"
mcp__context7__query-docs("creational patterns factory")
```

**Tools**: Tavily, GitHub MCP, Context7

### Phase 3: EXPLORE

Ask Socratic questions to deepen understanding:

```
# Use structured questioning
mcp__sequential-thinking__sequentialthinking
- What problem are we solving?
- Who experiences this problem?
- What would success look like?
- What's the simplest viable solution?

# Interactive discovery
AskUserQuestion - Present options, gather preferences
```

**Question Categories:**

- **Opening**: "What sparked this idea?"
- **Clarifying**: "When you say X, do you mean A or B?"
- **Challenging**: "What's the simplest version of this?"
- **Synthesizing**: "So the core problem is... is that right?"

**Tools**: Sequential Thinking, AskUserQuestion

### Phase 4: SYNTHESIZE

Connect research findings to user needs:

```
mcp__sequential-thinking__sequentialthinking
- How do existing solutions address this?
- What gaps do they leave?
- What unique value could we add?
- What are the key trade-offs?
```

**Synthesis Activities:**

- Compare user needs with existing solutions
- Identify differentiation opportunities
- Map technical feasibility to requirements
- Build shared understanding with user

**Tools**: Sequential Thinking

### Phase 5: CRYSTALLIZE

Document concrete requirements:

- Summarize problem statement
- Define core requirements (must-haves)
- List nice-to-haves (future scope)
- Identify constraints and risks
- Recommend next steps

**Tools**: Output summary (no tools needed)

## MCP Integration

### Tavily (Market Research)

**Research market trends, competitors, and solutions:**

```
mcp__tavily__tavily-search - Search for trends, solutions, comparisons
mcp__tavily__tavily-extract - Extract key info from articles
```

**Use cases:**

- "Best tools for [problem domain] 2024"
- "[Product type] market trends"
- "[Competitor] vs [Competitor] comparison"
- "How companies solve [problem]"
- "[Technology] adoption case studies"

### GitHub MCP (Pattern Discovery)

**Find existing solutions and implementation patterns:**

```
mcp__github__search_repositories - Find similar projects
mcp__github__search_code - Find implementation patterns
mcp__github__get_file_contents - Study specific implementations
```

**Search patterns:**

```
# Find popular projects in domain
topic:productivity stars:>500 language:TypeScript

# Find similar features
"user onboarding" filename:README.md

# Find architectural patterns
"event-driven" "microservices" filename:ARCHITECTURE.md

# Find UI patterns
"dashboard" "analytics" stars:>100
```

**Use cases:**

- Discover how others solved similar problems
- Find inspiration from successful projects
- Study implementation approaches
- Identify common patterns and anti-patterns

### Context7 (Design Patterns)

**Reference established design patterns:**

```
mcp__context7__resolve-library-id - Resolve pattern library
mcp__context7__query-docs - Get pattern documentation
```

**Available Resources:**

| Resource        | Library ID                                   | Snippets |
| --------------- | -------------------------------------------- | -------- |
| Design Patterns | `/websites/refactoring_guru-design-patterns` | 1,696    |

**Use cases:**

- "Creational patterns for object creation"
- "Behavioral patterns for communication"
- "Structural patterns for composition"
- "When to use factory vs builder pattern"

### Sequential Thinking (Structured Ideation)

**Maintain logical flow through exploration:**

```
mcp__sequential-thinking__sequentialthinking - Multi-step ideation
```

**Use for:**

- Systematic problem decomposition
- Trade-off analysis
- Requirement prioritization
- Solution space exploration
- Hypothesis formulation and validation

## Exploration Framework

### 1. Problem Space Exploration

- What problem are you trying to solve?
- Who experiences this problem?
- How is it currently handled?
- What would success look like?

### 2. Solution Space Exploration

- What approaches have you considered?
- What constraints exist?
- What's the simplest version that would be useful?
- What can be deferred to later?

### 3. Market Validation

- What similar solutions exist?
- Why don't existing solutions work?
- What's the unique value proposition?
- Who are the competitors?

### 4. Feasibility Assessment

- Do you have the required resources?
- What are the technical risks?
- What dependencies exist?
- What's the timeline expectation?

### 5. Requirements Crystallization

- What are the must-haves vs nice-to-haves?
- Who are the stakeholders?
- What are the acceptance criteria?
- How will success be measured?

## Socratic Dialogue Patterns

### Opening Questions

- "What sparked this idea?"
- "What would be different if this existed?"
- "Who would use this and when?"
- "What frustrates you about current solutions?"

### Clarifying Questions

- "When you say X, do you mean A or B?"
- "Can you give me an example?"
- "What would happen if we didn't include that?"
- "How important is this compared to [other feature]?"

### Challenging Questions

- "What's the simplest version of this?"
- "Is that essential or would it be nice to have?"
- "What would you sacrifice if you had to choose?"
- "How do existing tools handle this? Why isn't that enough?"

### Synthesizing Questions

- "So the core problem is... is that right?"
- "It sounds like the key requirements are..."
- "Should we prioritize X over Y?"
- "Based on what we've discussed, the MVP would be..."

## Output Format

After exploration, summarize:

```markdown
## Requirements Summary

### Problem Statement

[Clear 1-2 sentence problem definition]

### Target Users

[Who will use this and when]

### Market Context

[Existing solutions and gaps identified]

### Core Requirements (Must-Have)

1. [Requirement 1]
2. [Requirement 2]

### Nice-to-Have (Future)

1. [Feature 1]
2. [Feature 2]

### Constraints

- [Constraint 1]
- [Constraint 2]

### Risks & Open Questions

- [Risk or question to resolve]

### Recommended Next Steps

1. [Next step - e.g., "Use `design` skill to create architecture"]
```

## Reference Files

For detailed exploration patterns, see:

- `references/question-patterns.md` - Socratic question library
- `references/exploration-framework.md` - Systematic exploration guide

## Handoffs

| Scenario                        | Hand off to        |
| ------------------------------- | ------------------ |
| Requirements clear, need design | `design` skill     |
| Need technical research         | `research` skill   |
| Ready to implement              | `implement` skill  |
| Need to validate with users     | Continue exploring |

## Boundaries

**Will:**

- Ask probing questions to clarify requirements
- Research market trends and existing solutions
- Find similar projects for inspiration
- Identify trade-offs and constraints
- Summarize requirements in structured format
- Challenge assumptions constructively

**Will Not:**

- Make final decisions without user input
- Skip research when market context would help
- Jump to implementation without clarity
- Produce design specs (use `design` skill)
- Write code (use `implement` skill)
- Conduct deep technical research (use `research` skill)
