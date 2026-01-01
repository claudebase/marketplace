---
name: a11y
description: "Audits applications for WCAG 2.1 AA accessibility compliance, checking screen reader support, keyboard navigation, and ARIA usage. Use when the user wants to check accessibility, ensure their app works for all users, or fix accessibility issues. Triggers on requests like 'check accessibility', 'is this accessible', 'audit for WCAG', 'make this accessible', 'check screen reader support', 'fix a11y issues', 'add ARIA labels', or 'ensure keyboard navigation'. For implementing accessibility fixes in frontend components, use frontend skill."
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
  - mcp__tavily__tavily-extract
  - mcp__playwright__browser_navigate
  - mcp__playwright__browser_snapshot
  - mcp__sequential-thinking__sequentialthinking
---

# Accessibility (a11y) Skill

WCAG 2.1 AA compliance auditing with automated checks and manual testing guidance.

## Quick Reference

**Activates**: accessibility, a11y, WCAG, screen reader, keyboard nav, color contrast, ARIA
**Mode**: read-only (audit only, no fixes)
**Output**: Categorized issues with severity and WCAG criterion references

## Workflow

```
SCAN → RESEARCH → AUDIT → TEST → REPORT
```

## When to Use

- Accessibility audits ("check accessibility", "a11y audit")
- WCAG compliance checks ("WCAG 2.1 AA")
- Screen reader compatibility review
- Keyboard navigation testing
- Color contrast validation
- ARIA implementation review

## When NOT to Use

- General UI design → use `frontend` skill
- Implementing fixes → use `frontend` skill after audit
- Performance optimization → use `performance` skill
- Security audit → use `security` skill

## References

- [Full Audit Guide](references/guide.md) - Complete methodology, phases, MCP integration
- [WCAG Checklist](references/wcag-checklist.md) - All WCAG 2.1 AA criteria
- [Testing Tools](references/testing-tools.md) - axe-core, Pa11y, Lighthouse setup
- [Common Fixes](references/common-fixes.md) - Code patterns for fixes

## Boundaries

**Will**: Audit components, check WCAG compliance, report issues with specific fixes, test keyboard paths
**Will Not**: Implement fixes (use `frontend`), certify compliance, guarantee legal compliance
