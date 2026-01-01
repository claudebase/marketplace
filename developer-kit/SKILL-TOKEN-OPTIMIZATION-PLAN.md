# SKILL.md Token Optimization Plan

**Created**: 2026-01-01
**Objective**: Reduce skill token consumption at startup by ~80% through minimal SKILL.md files with progressive disclosure
**Expected Outcome**: ~36,000 tokens → ~7,200 tokens (5x reduction)

---

## Executive Summary

### Problem Statement

Claude Code loads **full SKILL.md content** at startup for plugin skills, consuming ~36,000 tokens for 24 skills. Official documentation states only descriptions should load (~50-100 tokens/skill), but plugin skills behave differently.

### Solution: Minimal SKILL.md with Reference Files

Reduce each SKILL.md to **≤60 lines** containing:

- YAML frontmatter with shortened description (~100 chars)
- Brief overview (2-3 sentences)
- Quick reference (activation/boundaries)
- Links to `references/guide.md` for detailed content

### Impact Projection

| Metric                 | Current    | After Refactoring | Reduction |
| ---------------------- | ---------- | ----------------- | --------- |
| Avg lines per SKILL.md | 150        | 55                | 63%       |
| Avg tokens per skill   | 1,500      | 300               | 80%       |
| Total skill tokens     | ~36,000    | ~7,200            | 80%       |
| Description length     | ~300 chars | ~100 chars        | 67%       |

---

## Current State Analysis

### Skills by Refactoring Priority

| Priority        | Skill               | Lines | Est. Tokens | Status                         | Effort   |
| --------------- | ------------------- | ----- | ----------- | ------------------------------ | -------- |
| **P1-CRITICAL** | a11y                | 437   | ~3,100      | Needs major refactor           | High     |
| **P1-CRITICAL** | brainstorm          | 398   | ~2,600      | Needs major refactor           | High     |
| **P2-HIGH**     | verify              | 271   | ~1,600      | Needs refactor                 | Medium   |
| **P2-HIGH**     | confidence-check    | 137   | ~746        | Needs minor refactor           | Low      |
| **P2-HIGH**     | devops              | 100   | ~650        | At limit                       | Low      |
| **P3-OK**       | sequential-thinking | 99    | ~709        | Acceptable                     | Optional |
| **P3-OK**       | All others (18)     | 83-93 | ~500-650    | Good but optimize descriptions | Optional |

### Reference Model: `research/SKILL.md`

The research skill (90 lines) demonstrates the target pattern:

- Concise frontmatter
- Brief overview
- Quick workflow diagram
- When to use / When NOT to use
- Links to reference files
- Clear boundaries

---

## Target SKILL.md Template

### Structure (≤60 lines)

```markdown
---
name: skill-name
description: "Brief purpose. Activates: trigger1, trigger2. Mode: read-only."
composable: true
mode: read-only
allowed-tools:
  - Tool1
  - Tool2
---

# Skill Name

One-sentence purpose statement.

## Quick Reference

**Activates**: keyword1, keyword2, keyword3
**Mode**: read-only | read-write
**Output**: Brief description of output

## Workflow
```

PHASE1 → PHASE2 → PHASE3 → PHASE4

```

## When to Use

- Trigger scenario 1
- Trigger scenario 2

## When NOT to Use

- Scenario → use `other-skill` instead

## References

- [Detailed Guide](references/guide.md) - Full methodology
- [Patterns](references/patterns.md) - Code examples

## Boundaries

**Will**: Action1, Action2
**Will Not**: Action3, Action4
```

### Description Format (≤100 chars)

**Current format (~300 chars)**:

```yaml
description: "MUST USE for any web research or information gathering. Triggers: 'find information', 'research', 'look up', 'search for', 'what is', 'tell me about', 'find docs', 'documentation for', 'how does X work', 'best practices', 'latest updates', 'compare X vs Y'. Provides multi-source verification and citations. DO NOT use WebSearch/Tavily directly - this skill ensures proper source evaluation."
```

**Target format (~100 chars)**:

```yaml
description: "Web research with verification. Activates: research, find, lookup, docs, compare."
```

**Principles**:

1. Remove "MUST USE" - Claude already knows when to use skills
2. Remove "DO NOT" warnings - put in boundaries section
3. Keep only essential trigger keywords (5-7 max)
4. Use "Activates:" instead of verbose "Triggers:"
5. State the mode if important (read-only)

---

## Phase 1: Critical Refactoring (P1)

### Task 1.1: Refactor `a11y` Skill

**Current**: 437 lines, ~3,100 tokens
**Target**: 60 lines, ~350 tokens

#### Step 1.1.1: Create `references/guide.md`

Move these sections from SKILL.md to guide.md:

- Behavioral flow diagram (lines 48-69)
- All phase details with code examples (lines 71-179)
- MCP Integration section (lines 180-286)
- WCAG 2.1 AA Compliance tables (lines 287-324)
- Automated checks section (lines 325-365)
- Manual testing guidance (lines 366-402)

#### Step 1.1.2: Rewrite SKILL.md

```markdown
---
name: a11y
description: "WCAG accessibility auditing. Activates: a11y, WCAG, accessibility, screen reader, ARIA."
composable: true
mode: read-only
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  - mcp__github__search_code
  - mcp__github__get_file_contents
  - mcp__tavily__tavily-search
  - mcp__playwright__browser_navigate
  - mcp__playwright__browser_snapshot
  - mcp__sequential-thinking__sequentialthinking
---

# Accessibility (a11y) Skill

WCAG 2.1 AA compliance auditing with automated checks and manual testing guidance.

## Quick Reference

**Activates**: accessibility, a11y, WCAG, screen reader, keyboard nav, color contrast, ARIA
**Mode**: read-only (audit only, no fixes)
**Output**: Categorized issues with severity and WCAG references

## Workflow
```

SCAN → RESEARCH → AUDIT → TEST → REPORT

```

## When to Use

- Accessibility audits ("check accessibility", "a11y audit")
- WCAG compliance checks
- Screen reader compatibility review
- Keyboard navigation testing
- Color contrast validation

## When NOT to Use

- General UI design → use `frontend` skill
- Implementing fixes → use `frontend` skill after audit

## References

- [Full Audit Guide](references/guide.md) - Complete methodology
- [WCAG Checklist](references/wcag-checklist.md) - All criteria
- [Testing Tools](references/testing-tools.md) - Automated tools
- [Common Fixes](references/common-fixes.md) - Fix patterns

## Boundaries

**Will**: Audit components, check WCAG compliance, report issues with fixes
**Will Not**: Implement fixes (use frontend skill), certify compliance
```

#### Step 1.1.3: Verify and Test

- [ ] Verify guide.md has all moved content
- [ ] Test activation on keywords: "accessibility", "a11y audit", "WCAG check"
- [ ] Test reference file loading
- [ ] Count final lines (target: ≤60)

---

### Task 1.2: Refactor `brainstorm` Skill

**Current**: 398 lines, ~2,600 tokens
**Target**: 60 lines, ~350 tokens

#### Step 1.2.1: Create `references/guide.md`

Move these sections from SKILL.md to guide.md:

- All phase details (lines 71-163)
- MCP Integration examples (lines 164-253)
- Exploration Framework (lines 254-290)
- Socratic Dialogue Patterns (lines 291-320)
- Output Format template (lines 321-363)

#### Step 1.2.2: Rewrite SKILL.md

```markdown
---
name: brainstorm
description: "Requirements discovery via Socratic dialogue. Activates: thinking about, not sure, explore ideas."
composable: true
mode: read-only
allowed-tools:
  - Read
  - Grep
  - Glob
  - AskUserQuestion
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  - mcp__github__search_repositories
  - mcp__github__search_code
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  - mcp__sequential-thinking__sequentialthinking
---

# Brainstorm Skill

Transform vague ideas into concrete requirements through Socratic dialogue and market research.

## Quick Reference

**Activates**: "I want to build", "thinking about", "not sure how", "explore ideas", "help me figure out"
**Mode**: read-only (exploration only)
**Output**: Requirements summary with priorities

## Workflow
```

DISCOVER → RESEARCH → EXPLORE → SYNTHESIZE → CRYSTALLIZE

```

## When to Use

- Vague ideas need clarification
- Uncertainty about approach
- Market research needed
- Validating concepts

## When NOT to Use

- Clear requirements exist → use `design` skill
- Need external docs → use `research` skill
- Ready to implement → use `implement` skill

## References

- [Full Guide](references/guide.md) - Complete methodology
- [Question Patterns](references/question-patterns.md) - Socratic questions
- [Exploration Framework](references/exploration-framework.md) - Systematic exploration

## Boundaries

**Will**: Ask questions, research market, explore options, summarize requirements
**Will Not**: Make decisions, implement code, produce design specs
```

#### Step 1.2.3: Verify and Test

- [ ] Verify guide.md has all moved content
- [ ] Test activation on keywords: "I want to build", "thinking about"
- [ ] Test reference file loading
- [ ] Count final lines (target: ≤60)

---

## Phase 2: High Priority Refactoring (P2)

### Task 2.1: Refactor `verify` Skill

**Current**: 271 lines, ~1,600 tokens
**Target**: 55 lines, ~320 tokens

#### Step 2.1.1: Create `references/guide.md`

Move these sections:

- Mode 1 detailed checklist (lines 43-81)
- Mode 2 iron law details (lines 83-150)
- Evidence catalog (lines 151-200)
- Anti-patterns section (lines 201-250)

#### Step 2.1.2: Rewrite SKILL.md

```markdown
---
name: verify
description: "Evidence-based validation before completion claims. Activates: verify, validate, check my work."
composable: true
mode: read-only
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
---

# Verify Skill

Ensure work quality through evidence-based validation before claiming completion.

## Quick Reference

**Activates**: verify, validate, ready to commit, check my work, prove it works
**Mode**: read-only (validates, does not fix)
**Core Law**: No completion claims without fresh verification evidence

## Modes

| Mode         | Usage                   | Trigger             |
| ------------ | ----------------------- | ------------------- |
| `--review`   | Pre-commit checklist    | "review my changes" |
| `--complete` | Completion verification | "is this done?"     |

## When to Use

- Before claiming work is complete
- Before committing or creating PRs
- After implementing features or fixes

## When NOT to Use

- Code analysis → use `analyze` skill
- Fixing issues → use `debug` skill
- External review → use `code-reviewer` agent

## References

- [Full Guide](references/guide.md) - Complete methodology
- [Pre-commit Checklist](references/pre-commit.md) - 4-point checklist
- [Evidence Patterns](references/evidence-patterns.md) - What counts as proof

## Boundaries

**Will**: Validate work, run checks, report status with evidence
**Will Not**: Fix issues, modify code, skip verification steps
```

---

### Task 2.2: Refactor `confidence-check` Skill

**Current**: 137 lines, ~746 tokens
**Target**: 50 lines, ~300 tokens

#### Step 2.2.1: Create `references/guide.md`

Move detailed confidence criteria and question templates.

#### Step 2.2.2: Rewrite SKILL.md

Keep only:

- Frontmatter with short description
- Brief overview
- Confidence threshold (≥90%)
- When to use / When NOT to use
- Links to guide.md
- Boundaries

---

### Task 2.3: Trim `devops` Skill

**Current**: 100 lines, ~650 tokens
**Target**: 60 lines, ~400 tokens

#### Changes

- Remove inline workflow details
- Add links to existing `references/` files
- Shorten description

---

## Phase 3: Description Optimization (All 24 Skills)

### Task 3.1: New Description Mapping

Apply to all skills. Target: ≤100 characters.

| Skill               | New Description                                                                                       |
| ------------------- | ----------------------------------------------------------------------------------------------------- |
| a11y                | `"WCAG accessibility auditing. Activates: a11y, WCAG, accessibility, screen reader, ARIA."`           |
| analyze             | `"Code analysis. Activates: analyze, review, check quality, find issues."`                            |
| brainstorm          | `"Requirements discovery via Socratic dialogue. Activates: thinking about, not sure, explore ideas."` |
| confidence-check    | `"Pre-implementation gate. Activates: ready to implement, confident enough."`                         |
| containers          | `"Containerization. Activates: Docker, Kubernetes, container, Helm."`                                 |
| database            | `"Database work with optimization. Activates: database, schema, query, SQL, migration."`              |
| debug               | `"Bug fixing methodology. Activates: debug, fix, error, not working, broken."`                        |
| design              | `"Architecture design. Activates: design, architect, API spec, system design."`                       |
| devops              | `"Build and git workflows. Activates: build, git, commit, CI/CD, deploy."`                            |
| document            | `"Documentation creation. Activates: document, README, API docs, JSDoc."`                             |
| explain             | `"Code explanations. Activates: explain, what does this do, how does this work."`                     |
| frontend            | `"UI development. Activates: component, UI, React, form, modal, layout."`                             |
| implement           | `"Code implementation. Activates: implement, create, build, add feature."`                            |
| improve             | `"Code improvement. Activates: improve, refactor, clean up, simplify."`                               |
| migration           | `"Migration planning. Activates: migrate, upgrade, breaking change, zero-downtime."`                  |
| observability       | `"Logging and monitoring. Activates: logging, monitoring, alerts, metrics."`                          |
| orchestration       | `"Task breakdown. Activates: orchestrate, break down, complex task, workflow."`                       |
| performance         | `"Performance analysis. Activates: slow, performance, bottleneck, optimize."`                         |
| quality             | `"Test strategy design. Activates: test strategy, coverage strategy, test plan."`                     |
| research            | `"Web research with verification. Activates: research, find, lookup, docs, compare."`                 |
| security            | `"Security auditing. Activates: security, vulnerabilities, OWASP, injection."`                        |
| sequential-thinking | `"Structured reasoning. Activates: think through, step by step, analyze systematically."`             |
| test                | `"Test execution and coverage. Activates: run tests, coverage, test suite."`                          |
| verify              | `"Evidence-based validation before completion claims. Activates: verify, validate, check my work."`   |

### Task 3.2: Apply Description Updates

For each skill:

```bash
# In skills/<skill>/SKILL.md, update the description field
sed -i '' 's/description: ".*"/description: "NEW_SHORT_DESCRIPTION"/' SKILL.md
```

---

## Phase 4: Reference File Consolidation

### Task 4.1: Ensure Each Skill Has `guide.md`

| Skill               | Has guide.md? | Action Required                  |
| ------------------- | ------------- | -------------------------------- |
| a11y                | No            | **CREATE** from SKILL.md content |
| analyze             | Yes           | Verify completeness              |
| brainstorm          | No            | **CREATE** from SKILL.md content |
| confidence-check    | No            | **CREATE** from SKILL.md content |
| containers          | Yes           | Verify completeness              |
| database            | Yes           | Verify completeness              |
| debug               | Yes           | Verify completeness              |
| design              | Yes           | Verify completeness              |
| devops              | No            | **CREATE** from existing refs    |
| document            | Yes           | Verify completeness              |
| explain             | Yes           | Verify completeness              |
| frontend            | Yes           | Verify completeness              |
| implement           | No            | **CREATE** from shared refs      |
| improve             | No            | **CREATE** from SKILL.md         |
| migration           | No            | **CREATE** from SKILL.md         |
| observability       | No            | **CREATE** from shared refs      |
| orchestration       | No            | **CREATE** from SKILL.md         |
| performance         | No            | **CREATE** from SKILL.md         |
| quality             | No            | **CREATE** from SKILL.md         |
| research            | No            | **CREATE** from existing refs    |
| security            | No            | **CREATE** from shared refs      |
| sequential-thinking | No            | **CREATE** minimal guide         |
| test                | No            | **CREATE** from shared refs      |
| verify              | No            | **CREATE** from SKILL.md content |

### Task 4.2: Guide.md Template

Each guide.md should follow this structure:

```markdown
# [Skill Name] - Detailed Guide

## Overview

[Expanded description from original SKILL.md]

## Behavioral Flow

[ASCII diagram from original]

## Phase Details

### Phase 1: [Name]

[Detailed instructions]

### Phase 2: [Name]

[Detailed instructions]

## MCP Tool Integration

[Tool examples with code blocks]

## Patterns & Examples

[Code examples, templates]

## Anti-Patterns

[What to avoid]

## Related Skills

[Handoff guidance]
```

---

## Phase 5: Validation and Testing

### Task 5.1: Line Count Verification

```bash
# Run after all refactoring
wc -l skills/*/SKILL.md | sort -n

# Expected output: all files ≤60 lines
# Actual target lines per skill:
# - P1 skills (a11y, brainstorm): 55-60 lines
# - P2 skills (verify, confidence-check, devops): 50-60 lines
# - P3 skills (all others): ≤90 lines (most already compliant)
```

### Task 5.2: Token Estimation

```bash
# Rough token estimate: chars/4 + lines
for skill in skills/*/SKILL.md; do
  chars=$(wc -c < "$skill")
  lines=$(wc -l < "$skill")
  tokens=$((chars/4 + lines))
  echo "$(basename $(dirname $skill)): ~$tokens tokens"
done | sort -t: -k2 -n -r
```

### Task 5.3: Functional Testing

For each refactored skill:

| Test              | Command/Action         | Expected Result       |
| ----------------- | ---------------------- | --------------------- |
| Activation        | Use trigger keyword    | Skill activates       |
| Reference Loading | Request details        | Claude reads guide.md |
| Boundary Respect  | Try prohibited action  | Skill refuses         |
| Composability     | Chain with other skill | Works correctly       |

### Task 5.4: Context Window Check

After deployment:

1. Start new Claude Code session
2. Run `/context` to see token usage
3. Compare skills section size before/after
4. Target: Skills section ≤7,200 tokens (was ~36,000)

---

## Implementation Schedule

### Week 1: Critical Skills (Days 1-3)

| Day | Task     | Deliverable                              |
| --- | -------- | ---------------------------------------- |
| 1   | Task 1.1 | a11y refactored + guide.md created       |
| 2   | Task 1.2 | brainstorm refactored + guide.md created |
| 3   | Testing  | Both P1 skills validated                 |

### Week 2: High Priority + Descriptions (Days 4-7)

| Day | Task          | Deliverable                            |
| --- | ------------- | -------------------------------------- |
| 4   | Task 2.1      | verify refactored + guide.md created   |
| 5   | Task 2.2, 2.3 | confidence-check, devops trimmed       |
| 6   | Task 3.1      | All 24 descriptions shortened          |
| 7   | Testing       | All P2 skills + descriptions validated |

### Week 3: Reference Files + Final Validation (Days 8-10)

| Day | Task          | Deliverable                           |
| --- | ------------- | ------------------------------------- |
| 8-9 | Task 4.1, 4.2 | guide.md files created for all skills |
| 10  | Task 5.1-5.4  | Full validation complete              |

---

## Rollback Plan

### Git Strategy

Each phase should be a separate commit:

```bash
# Phase 1
git add skills/a11y skills/brainstorm
git commit -m "refactor(skills): minimize a11y and brainstorm SKILL.md files"

# Phase 2
git add skills/verify skills/confidence-check skills/devops
git commit -m "refactor(skills): minimize P2 skill files"

# Phase 3
git add skills/*/SKILL.md
git commit -m "refactor(skills): shorten all skill descriptions"

# Phase 4
git add skills/*/references/
git commit -m "docs(skills): add guide.md reference files"
```

### Rollback Commands

```bash
# Revert specific phase
git revert <commit-hash>

# Revert all changes
git revert HEAD~4..HEAD
```

### Gradual Rollout

1. Refactor 2 skills, test thoroughly
2. If working, continue with next batch
3. If issues, diagnose and fix before proceeding

---

## Success Criteria

| Metric                 | Current | Target | Verification      |
| ---------------------- | ------- | ------ | ----------------- |
| a11y lines             | 437     | ≤60    | `wc -l`           |
| brainstorm lines       | 398     | ≤60    | `wc -l`           |
| verify lines           | 271     | ≤55    | `wc -l`           |
| confidence-check lines | 137     | ≤50    | `wc -l`           |
| Avg description chars  | ~300    | ≤100   | Frontmatter audit |
| Total skill tokens     | ~36,000 | ≤7,200 | Context check     |
| Activation accuracy    | -       | 100%   | Functional tests  |
| guide.md coverage      | ~50%    | 100%   | File existence    |

---

## Appendix A: Files Checklist

### Files to Modify (SKILL.md)

- [ ] `skills/a11y/SKILL.md` - Major refactor
- [ ] `skills/brainstorm/SKILL.md` - Major refactor
- [ ] `skills/verify/SKILL.md` - Medium refactor
- [ ] `skills/confidence-check/SKILL.md` - Minor refactor
- [ ] `skills/devops/SKILL.md` - Minor trim
- [ ] All 24 skills - Description update

### Files to Create (guide.md)

- [ ] `skills/a11y/references/guide.md`
- [ ] `skills/brainstorm/references/guide.md`
- [ ] `skills/verify/references/guide.md`
- [ ] `skills/confidence-check/references/guide.md`
- [ ] `skills/devops/references/guide.md`
- [ ] `skills/implement/references/guide.md`
- [ ] `skills/improve/references/guide.md`
- [ ] `skills/migration/references/guide.md`
- [ ] `skills/observability/references/guide.md`
- [ ] `skills/orchestration/references/guide.md`
- [ ] `skills/performance/references/guide.md`
- [ ] `skills/quality/references/guide.md`
- [ ] `skills/research/references/guide.md`
- [ ] `skills/security/references/guide.md`
- [ ] `skills/sequential-thinking/references/guide.md`
- [ ] `skills/test/references/guide.md`

---

## Appendix B: Verification Script

Save as `scripts/verify-skill-optimization.sh`:

```bash
#!/bin/bash

echo "=== SKILL.md Line Count Analysis ==="
echo ""

total_lines=0
over_limit=0

for skill_dir in skills/*/; do
  skill_name=$(basename "$skill_dir")
  skill_file="${skill_dir}SKILL.md"

  if [ -f "$skill_file" ]; then
    lines=$(wc -l < "$skill_file")
    total_lines=$((total_lines + lines))

    if [ "$lines" -gt 60 ]; then
      status="OVER LIMIT"
      over_limit=$((over_limit + 1))
    else
      status="OK"
    fi

    printf "%-20s %4d lines  [%s]\n" "$skill_name" "$lines" "$status"
  fi
done

echo ""
echo "=== Summary ==="
echo "Total lines: $total_lines"
echo "Skills over 60 lines: $over_limit"
echo "Estimated tokens: ~$((total_lines * 6))"
echo ""

echo "=== Description Length Check ==="
for skill_dir in skills/*/; do
  skill_file="${skill_dir}SKILL.md"
  if [ -f "$skill_file" ]; then
    desc=$(grep "^description:" "$skill_file" | head -1)
    len=${#desc}
    skill_name=$(basename "$skill_dir")

    if [ "$len" -gt 120 ]; then
      echo "$skill_name: $len chars (TOO LONG)"
    fi
  fi
done

echo ""
echo "=== Guide.md Coverage ==="
for skill_dir in skills/*/; do
  skill_name=$(basename "$skill_dir")
  if [ -f "${skill_dir}references/guide.md" ]; then
    echo "$skill_name: guide.md EXISTS"
  else
    echo "$skill_name: guide.md MISSING"
  fi
done
```

---

## Appendix C: Example Before/After

### Before: `a11y/SKILL.md` (437 lines, ~3,100 tokens)

```markdown
---
name: a11y
description: "MUST USE for accessibility concerns. Triggers: 'accessibility', 'a11y', 'WCAG', 'screen reader', 'keyboard navigation', 'color contrast', 'ARIA', 'alt text', 'focus management'. Provides WCAG 2.1 AA compliance auditing. DO NOT manually check a11y - this skill ensures comprehensive coverage of all WCAG criteria. READ-ONLY."
composable: true
mode: read-only
allowed-tools:
  # Core Analysis
  - Read
  - Grep
  ... (26 lines of tools)
---

# Accessibility (a11y) Skill

Comprehensive accessibility auditing and WCAG compliance checking...

## Activation Triggers

... (10 lines)

## Do NOT Activate When

... (5 lines)

## Behavioral Flow

... (22 lines ASCII diagram)

### Phase 1: SCAN

... (50 lines detailed instructions)

### Phase 2: RESEARCH

... (50 lines with code examples)

... (300+ more lines of detailed content)
```

### After: `a11y/SKILL.md` (58 lines, ~340 tokens)

```markdown
---
name: a11y
description: "WCAG accessibility auditing. Activates: a11y, WCAG, accessibility, screen reader, ARIA."
composable: true
mode: read-only
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  - mcp__github__search_code
  - mcp__github__get_file_contents
  - mcp__tavily__tavily-search
  - mcp__playwright__browser_navigate
  - mcp__playwright__browser_snapshot
  - mcp__sequential-thinking__sequentialthinking
---

# Accessibility (a11y) Skill

WCAG 2.1 AA compliance auditing with automated checks and manual testing guidance.

## Quick Reference

**Activates**: accessibility, a11y, WCAG, screen reader, keyboard nav, color contrast, ARIA
**Mode**: read-only (audit only, no fixes)
**Output**: Categorized issues with severity and WCAG references

## Workflow
```

SCAN → RESEARCH → AUDIT → TEST → REPORT

```

## When to Use

- Accessibility audits ("check accessibility", "a11y audit")
- WCAG compliance checks
- Screen reader compatibility review
- Keyboard navigation testing

## When NOT to Use

- General UI design → use `frontend` skill
- Implementing fixes → use `frontend` skill after audit

## References

- [Full Audit Guide](references/guide.md) - Complete methodology
- [WCAG Checklist](references/wcag-checklist.md) - All criteria
- [Testing Tools](references/testing-tools.md) - Automated tools
- [Common Fixes](references/common-fixes.md) - Fix patterns

## Boundaries

**Will**: Audit components, check WCAG compliance, report issues with fixes
**Will Not**: Implement fixes (use frontend skill), certify compliance
```

---

_Plan created: 2026-01-01_
_Ready for implementation_
