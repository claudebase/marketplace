---
name: quality
description: "Testing strategy design and quality assessment for comprehensive test coverage. Use for test planning, coverage analysis, or testing recommendations. Activates for: design tests for, test strategy, improve coverage, what tests needed, quality assessment, how should I test this. READ-ONLY."
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - mcp__sequential-thinking__sequentialthinking
---

# Quality Skill

## Purpose

Design comprehensive testing strategies with focus on edge cases, boundary conditions, and risk-based prioritization. Assess quality and identify coverage gaps.

**Core Principle**: "Think beyond the happy path. Find the failures before users do."

**Key Distinction**: This skill DESIGNS testing strategy. To execute tests, use the `test` command.

## When to Use

**Activate When:**
- User asks "how should I test this"
- User needs a testing strategy
- User wants to improve test coverage
- User asks about edge cases
- User needs quality assessment

**Do NOT Activate When:**
- User wants to run tests → use `devops` skill or Bash
- User wants general code analysis → use `analyze` skill
- User wants to implement tests → use `implement` skill

**Boundary Clarification:**
This skill designs testing strategies and identifies coverage gaps. For executing tests, use the `devops` skill or Bash. For implementing the tests designed, use the `implement` skill. The `analyze` skill provides general code analysis and will recommend this skill for testing-specific concerns.

## Quality Mindset

> "Quality is not an act, it is a habit. Test what matters most."

- Prevent defects early, don't just detect late
- Risk-based prioritization
- Edge cases and boundaries first
- Automate the critical path

## Focus Areas

### 1. Test Strategy Design
- Unit, integration, e2e test balance
- Risk-based test prioritization
- Coverage targets and metrics
- CI/CD integration approach

### 2. Edge Case Detection
- Boundary value analysis
- Null/undefined handling
- Empty collections
- Maximum/minimum values
- Unicode and special characters

### 3. Failure Scenarios
- Network failures
- Timeout handling
- Concurrent access
- Resource exhaustion
- Invalid state transitions

### 4. Quality Metrics
- Code coverage (line, branch, path)
- Mutation testing
- Defect density
- Test execution time

## Methodology

1. **Analyze**: Understand the code and its critical paths
2. **Risk Assess**: Identify high-impact, high-probability failure areas
3. **Design**: Create test cases covering happy path + edge cases
4. **Prioritize**: Focus on high-risk areas first
5. **Recommend**: Provide actionable test implementation guidance

## Test Case Template

```markdown
### Test Case: [Feature/Function Name]

#### Happy Path
- [ ] Normal input produces expected output
- [ ] All required fields work correctly

#### Edge Cases
- [ ] Empty input
- [ ] Null/undefined input
- [ ] Maximum length input
- [ ] Minimum valid input
- [ ] Special characters

#### Error Scenarios
- [ ] Invalid input types
- [ ] Missing required fields
- [ ] Network failure
- [ ] Timeout
- [ ] Concurrent access

#### Security
- [ ] Injection attempts
- [ ] Authorization bypass
- [ ] Rate limiting
```

## MCP Integration

**Use Sequential Thinking for systematic test strategy design:**
```
mcp__sequential-thinking__sequentialthinking - Use for thorough edge case analysis
```
Sequential Thinking helps ensure comprehensive coverage by systematically exploring all failure scenarios.

## Output Format

```
## Test Strategy Report

### Coverage Analysis
| Area | Current | Target | Gap |
|------|---------|--------|-----|
| Unit tests | 45% | 80% | 35% |
| Integration | 20% | 60% | 40% |
| E2E critical paths | 30% | 90% | 60% |

### Priority Test Cases

#### P0 - Critical (Must Have)
1. **User Authentication Flow**
   - Login with valid credentials
   - Login with invalid credentials
   - Session expiration handling
   - Password reset flow

2. **Payment Processing**
   - Successful payment
   - Declined card
   - Network timeout during payment
   - Duplicate payment prevention

#### P1 - High (Should Have)
[...]

### Edge Cases Identified
1. Empty cart checkout attempt
2. Concurrent cart modifications
3. Currency conversion edge cases
4. Unicode in user names

### Recommended Test Structure
```
tests/
├── unit/           # Fast, isolated tests
├── integration/    # API and database tests
├── e2e/           # Critical user journeys
└── performance/   # Load and stress tests
```

### Quick Wins
1. Add missing null checks tests
2. Test boundary values for pagination
3. Add error response format tests
```

## Reference Files

For detailed testing patterns, see:
- `references/testing-strategies.md` - Testing methodologies
- `references/coverage-patterns.md` - Coverage analysis patterns
- `references/api-testing.md` - REST API, contract, load, and security testing patterns
