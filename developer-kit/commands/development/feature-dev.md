---
name: feature-dev
description: Guided feature development with 7-phase workflow
delegates-to: orchestration
operation: feature
argument-hint: "<feature-description|issue-url> [--phase discovery|design|implementation]"
allowed-tools: Read, Grep, Glob, Write, Edit, Bash, Task, TodoWrite
---

Execute the **orchestration** skill in feature development mode.

## Delegation

This command delegates to the `orchestration` skill which coordinates:
- Multi-phase structured workflow
- Agent coordination (explorer, architect, reviewer)
- Skill activation (brainstorm, design, implement) + code-reviewer agent
- Progress tracking via TodoWrite

## 7-Phase Workflow

### Phase 1: Discovery
**Goal**: Understand what needs to be built

- Create todo list with all phases
- Clarify unclear requirements
- Confirm understanding with user

### Phase 2: Codebase Exploration
**Goal**: Understand existing code and patterns

- Launch 2-3 code-explorer agents in parallel
- Target different aspects: similar features, architecture, UI patterns
- Read all files identified by agents
- Present summary of patterns discovered

### Phase 3: Clarifying Questions
**Goal**: Fill in gaps before designing

**CRITICAL - DO NOT SKIP**

- Identify underspecified aspects
- Present questions in organized list
- Wait for answers before proceeding

### Phase 4: Architecture Design
**Goal**: Design implementation approaches

- Launch architect agents with different focuses:
  - Minimal changes (smallest change, maximum reuse)
  - Clean architecture (maintainability)
  - Pragmatic balance (speed + quality)
- Present trade-offs and recommendation
- Ask user which approach they prefer

### Phase 5: Implementation
**Goal**: Build the feature

**Requires explicit user approval**

- Read all relevant files
- Implement following chosen architecture
- Follow codebase conventions
- Update todos as you progress

### Phase 6: Quality Review
**Goal**: Ensure code quality

- Launch 3 code-reviewer agents:
  - Simplicity/DRY/elegance
  - Bugs/functional correctness
  - Project conventions
- Present findings and ask user what to do
- Address issues based on user decision

### Phase 7: Summary
**Goal**: Document what was accomplished

- Mark all todos complete
- Summarize: what was built, decisions, files modified
- Suggest next steps

## Core Principles

- **Ask clarifying questions** early, before implementation
- **Understand before acting** - read existing code first
- **Read files identified by agents** - build detailed context
- **Simple and elegant** - prioritize maintainability
- **Use TodoWrite** - track all progress

## Examples

```bash
feature-dev "Add user settings page"
feature-dev "Implement OAuth login" --phase design
feature-dev https://github.com/org/repo/issues/123
```

## Related

- `orchestration` skill - Task coordination
- `design` skill - Architecture design
- `implement` skill - Code implementation
- `code-reviewer` agent - Quality review
