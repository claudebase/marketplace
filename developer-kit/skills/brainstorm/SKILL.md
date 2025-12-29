---
name: brainstorm
description: "Interactive requirements discovery through Socratic dialogue and exploration. Use when users have vague ideas, uncertain requirements, or need to explore before implementation. Activates for: I want to build, thinking about, maybe we could, not sure how to, explore ideas, help me figure out. Exploratory only."
allowed-tools:
  - Read
  - Grep
  - Glob
  - AskUserQuestion
  - mcp__sequential-thinking__sequentialthinking
---

# Requirements Discovery Skill

## Purpose

Transform vague ideas into concrete requirements through Socratic dialogue. Help users discover what they actually need by asking the right questions.

**Key Principle**: Ask, don't assume. Explore before building.

**Key Distinction**: This skill EXPLORES through questions. For external research, use `research` skill. For concrete design output, use `design` skill.

## When to Use

**Activate When:**
- User has a vague idea: "I want to build..."
- User is uncertain: "thinking about maybe..."
- User needs exploration: "not sure how to approach..."
- User wants to validate concepts before building

**Do NOT Activate When:**
- User wants external information → use `research` skill
- User wants concrete design specs → use `design` skill
- User wants implementation → use `implement` skill
- User has clear requirements already

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

### 3. Feasibility Validation
- Do you have the required resources?
- What are the technical risks?
- What dependencies exist?
- What's the timeline expectation?

### 4. Requirements Crystallization
- What are the must-haves vs nice-to-haves?
- Who are the stakeholders?
- What are the acceptance criteria?
- How will success be measured?

## Socratic Dialogue Patterns

### Opening Questions
- "What sparked this idea?"
- "What would be different if this existed?"
- "Who would use this and when?"

### Clarifying Questions
- "When you say X, do you mean A or B?"
- "Can you give me an example?"
- "What would happen if we didn't include that?"

### Challenging Questions
- "What's the simplest version of this?"
- "Is that essential or would it be nice to have?"
- "What would you sacrifice if you had to choose?"

### Synthesizing Questions
- "So the core problem is... is that right?"
- "It sounds like the key requirements are..."
- "Should we prioritize X over Y?"

## MCP Integration

**Use Sequential Thinking for complex exploration:**
```
mcp__sequential-thinking__sequentialthinking - Use for structured ideation and requirement discovery
```
Sequential Thinking helps maintain logical flow through multi-faceted exploration sessions.

## Output Format

After exploration, summarize:

```markdown
## Requirements Summary

### Problem Statement
[Clear 1-2 sentence problem definition]

### Target Users
[Who will use this and when]

### Core Requirements (Must-Have)
1. [Requirement 1]
2. [Requirement 2]

### Nice-to-Have (Future)
1. [Feature 1]
2. [Feature 2]

### Constraints
- [Constraint 1]
- [Constraint 2]

### Open Questions
- [Question still to resolve]

### Recommended Next Steps
1. [Next step]
```

## Reference Files

For detailed exploration patterns, see:
- `references/question-patterns.md` - Socratic question library
- `references/exploration-framework.md` - Systematic exploration guide
