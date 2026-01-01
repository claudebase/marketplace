---
name: frontend
description: "UI/frontend development with accessibility. Activates for: create component, build UI, React, Vue, dashboard, form, modal."
composable: true
mode: read-write
allowed-tools:
  - Read
  - Grep
  - Glob
  - Write
  - Edit
  - Bash
  - TodoWrite
  - mcp__shadcn__search_items_in_registries
  - mcp__shadcn__list_items_in_registries
  - mcp__shadcn__view_items_in_registries
  - mcp__shadcn__get_item_examples_from_registries
  - mcp__shadcn__get_add_command_for_items
  - mcp__shadcn__get_audit_checklist
  - mcp__shadcn__get_project_registries
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  - mcp__playwright__browser_navigate
  - mcp__playwright__browser_snapshot
  - mcp__playwright__browser_click
  - mcp__sequential-thinking__sequentialthinking
---

# Frontend Skill

Create distinctive, production-grade frontend interfaces with accessibility.

## Quick Reference

**Activates for**: create component, build UI, React, Vue, dashboard, form, modal
**Mode**: read-write
**Output**: Production-ready UI components with accessibility

## Workflow

```
UNDERSTAND → DISCOVER → DESIGN → IMPLEMENT → VALIDATE
```

## When to Use

- Component creation ("create a button", "build a card")
- Page development ("landing page", "dashboard", "settings page")
- UI patterns ("navigation menu", "sidebar", "modal")
- Framework-specific ("React component", "Vue component")

## When NOT to Use

- Backend logic → use `implement` skill
- Architecture decisions → use `design` skill
- Accessibility audit → use `a11y` skill

## References

- [Full Guide](references/guide.md) - Complete workflow and MCP integration
- [Design Guidelines](references/guide.md#design-guidelines) - Typography, color, motion
- [Anti-Patterns](references/guide.md#anti-patterns-to-avoid) - What to avoid

## Boundaries

**Will**: Create distinctive UI, use Shadcn components, apply aesthetic principles, validate visually
**Will Not**: Build from scratch when libraries exist, use generic aesthetics, implement backend logic
