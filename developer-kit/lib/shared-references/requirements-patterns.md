# Requirements Analyst - Document Templates & Techniques

## PRD Template

```markdown
# [Product Name] PRD

## Overview

### Problem Statement

[Clear description of the problem being solved]

### Target Users

[Primary and secondary user personas]

### Success Metrics

[Measurable outcomes that define success]

## Market Context

### Existing Solutions

[Summary of competitor analysis]

### Gaps Identified

[What current solutions lack]

### Our Differentiation

[Unique value proposition]

## Requirements

### Functional Requirements

#### Must Have (MVP)

| ID  | Requirement | User Story | Acceptance Criteria |
| --- | ----------- | ---------- | ------------------- |
| F1  | [Feature]   | As a...    | Given... When...    |

#### Should Have

| ID  | Requirement | User Story | Acceptance Criteria |
| --- | ----------- | ---------- | ------------------- |

#### Could Have

| ID  | Requirement | User Story | Acceptance Criteria |
| --- | ----------- | ---------- | ------------------- |

### Non-Functional Requirements

| Category     | Requirement      | Target          |
| ------------ | ---------------- | --------------- |
| Performance  | Page load time   | < 2 seconds     |
| Scalability  | Concurrent users | 10,000          |
| Security     | Authentication   | OAuth 2.0 + MFA |
| Availability | Uptime           | 99.9%           |

### Constraints

| Constraint | Description           | Impact          |
| ---------- | --------------------- | --------------- |
| Technical  | Must use existing API | Limited options |
| Timeline   | Launch by Q2          | Reduced scope   |

### Dependencies

| Dependency  | Owner   | Status    | Risk Level |
| ----------- | ------- | --------- | ---------- |
| Payment API | Finance | Available | Low        |

## Risks and Mitigations

| Risk       | Probability | Impact | Mitigation       |
| ---------- | ----------- | ------ | ---------------- |
| API delays | Medium      | High   | Mock API for dev |

## Timeline

| Phase     | Duration | Key Deliverables       |
| --------- | -------- | ---------------------- |
| Discovery | 2 weeks  | Requirements finalized |
| Design    | 3 weeks  | Architecture complete  |
| Build MVP | 6 weeks  | Core features live     |
```

## User Story Template

```markdown
## User Story: [Title]

**ID**: US-001
**Epic**: [Parent epic]
**Priority**: Must Have / Should Have / Could Have

### Story

As a [role],
I want [feature/capability],
So that [benefit/value].

### Acceptance Criteria

**Scenario 1: [Happy path]**

- Given [context]
- When [action]
- Then [expected result]

**Scenario 2: [Edge case]**

- Given [context]
- When [action]
- Then [expected result]

**Scenario 3: [Error case]**

- Given [context]
- When [action]
- Then [expected result]

### Technical Notes

[Implementation considerations]

### Dependencies

- [Dependency 1]
- [Dependency 2]

### Out of Scope

- [Explicitly excluded items]
```

## Feature Specification Template

```markdown
# Feature: [Feature Name]

## Summary

[One paragraph description]

## Problem

[What problem does this solve?]

## Solution

[How does this feature solve it?]

## User Stories

- [US-001]: [Title]
- [US-002]: [Title]

## Requirements

### Functional

| Req ID | Description | Priority | Status |
| ------ | ----------- | -------- | ------ |
| FR-001 | [Desc]      | Must     | Draft  |

### Non-Functional

| Req ID  | Description   | Target | Measurement |
| ------- | ------------- | ------ | ----------- |
| NFR-001 | Response time | <500ms | P95 latency |

## User Interface

[Wireframes or descriptions]

## Data Requirements

[Data models or schema requirements]

## API Requirements

[Endpoint specifications]

## Security Considerations

[Authentication, authorization, data protection]

## Testing Strategy

[How to validate requirements are met]
```

## Socratic Questioning Technique

```yaml
Opening Questions:
  - "What sparked this idea?"
  - "What would be different if this existed?"
  - "Who would use this and when?"
  - "What frustrates you about current solutions?"

Clarifying Questions:
  - "When you say X, do you mean A or B?"
  - "Can you give me an example?"
  - "What would happen if we didn't include that?"
  - "How important is this compared to [other feature]?"

Challenging Questions:
  - "What's the simplest version that would be useful?"
  - "Is that essential or nice-to-have?"
  - "What would you sacrifice if you had to choose?"
  - "How do existing tools handle this?"

Synthesizing Questions:
  - "So the core problem is... is that right?"
  - "It sounds like the key requirements are..."
  - "Should we prioritize X over Y?"
  - "Based on our discussion, the MVP would include..."
```

## Stakeholder Analysis Matrix

```yaml
Stakeholder Mapping:
  | Stakeholder    | Role             | Interest       | Influence |
  |----------------|------------------|----------------|-----------|
  | End Users      | Primary users    | Ease of use    | High      |
  | Administrators | System managers  | Maintainability| Medium    |
  | Executives     | Decision makers  | ROI            | High      |
  | Support Team   | User support     | Debuggability  | Low       |

Perspective Questions:
  For each stakeholder:
    - What are their goals?
    - What are their pain points?
    - What would make them successful?
    - What concerns do they have?
    - How will they measure success?
```

## MoSCoW Prioritization

```yaml
Categories:
  Must Have (M):
    - Critical for launch
    - Business will fail without
    - No workaround exists
    - Contractually required

  Should Have (S):
    - Important but not critical
    - Workaround exists
    - Significant value
    - Expected by users

  Could Have (C):
    - Nice to have
    - Improves experience
    - Low effort/high reward
    - Can be deferred

  Won't Have (W):
    - Out of scope for now
    - Future consideration
    - Low priority
    - Resource constraints

Prioritization Matrix:
  | Requirement      | Value | Effort | Priority | Rationale       |
  |------------------|-------|--------|----------|-----------------|
  | User login       | High  | Medium | Must     | Core security   |
  | Social login     | Medium| Low    | Should   | User convenience|
  | Biometric auth   | Low   | High   | Could    | Nice to have    |
```

## User Story Mapping

```yaml
Story Map Structure:
  Activities (Top Level):
    - Major user goals
    - High-level capabilities

  User Tasks (Middle Level):
    - Steps to achieve activities
    - Smaller user goals

  User Stories (Bottom Level):
    - Specific features
    - Detailed requirements

Example Map:
  Activity: Manage Expenses
    Task: Track Expenses
      Story: Add expense manually
      Story: Import bank statement
      Story: Photograph receipt
    Task: Categorize Expenses
      Story: Auto-categorize
      Story: Create custom categories
    Task: Report Expenses
      Story: Monthly summary
      Story: Export to PDF
```

## Requirements Checklist

```yaml
Completeness Checklist:
  Stakeholders:
    - [ ] All stakeholders identified
    - [ ] Each stakeholder interviewed
    - [ ] Conflicting needs resolved
    - [ ] Sign-off obtained

  Functional Requirements:
    - [ ] All user stories written
    - [ ] Acceptance criteria defined
    - [ ] Edge cases considered
    - [ ] Error handling specified

  Non-Functional Requirements:
    - [ ] Performance targets set
    - [ ] Security requirements defined
    - [ ] Scalability needs identified
    - [ ] Compliance requirements documented

  Constraints:
    - [ ] Technical constraints listed
    - [ ] Business constraints documented
    - [ ] Regulatory requirements identified
    - [ ] Timeline constraints acknowledged

  Dependencies:
    - [ ] External dependencies mapped
    - [ ] Internal dependencies identified
    - [ ] Third-party services documented
    - [ ] Data sources specified

  Risks:
    - [ ] Risks identified
    - [ ] Probability/impact assessed
    - [ ] Mitigations planned
    - [ ] Contingencies defined
```

## Research Workflows

```yaml
Greenfield Project:
  1. Discovery (RESEARCH):
    mcp__tavily__tavily-search("best [product-type] tools 2024")
    mcp__github__search_repositories("topic:[domain] stars:>500")

  2. Stakeholder Analysis: Use mcp__sequential-thinking__sequentialthinking

  3. Requirements Elicitation:
    - Conduct Socratic questioning
    - Create user story map

  4. Specification:
    - Write PRD using template
    - Prioritize using MoSCoW

Feature Enhancement:
  1. Context Analysis:
    - Read existing codebase
    - Understand current architecture

  2. Gap Analysis: mcp__github__search_code("[feature] implementation")

  3. Requirements Definition:
    - Define delta from current state
    - Document backward compatibility

Migration/Modernization: 1. Current State Analysis
  2. Future State Vision
  3. Gap Analysis with Sequential Thinking
  4. Migration Requirements
```
