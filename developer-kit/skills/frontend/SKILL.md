---
name: frontend
description: "Frontend development with UI/UX, accessibility, and distinctive design. Activates for: 'create component', 'build UI', 'design interface', 'frontend page', 'React component', 'Vue component', 'web application', 'user interface', 'landing page', 'dashboard'."
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

Create distinctive, production-grade frontend interfaces. Leverage component libraries for rapid development while applying unique design principles.

**Core Principle**: "Components provide structure; design provides soul. Avoid generic AI slop aesthetics."

## When to Use

- Component creation ("create a button", "build a card")
- Page development ("landing page", "dashboard", "settings page")
- UI patterns ("navigation menu", "sidebar", "modal")
- Framework-specific ("React component", "Vue component", "Next.js page")

## When NOT to Use

- Backend logic → use `implement` skill
- Architecture decisions → use `design` skill
- Accessibility audit → use `a11y` skill

## Quick Workflow

```
UNDERSTAND → DISCOVER → DESIGN → IMPLEMENT → VALIDATE
   Read       Shadcn    Apply     Install     Playwright
   Glob       Context7  aesthetics  Edit      Audit
```

1. **Understand** - Analyze requirements, detect framework
2. **Discover** - Search Shadcn for components (438+ available)
3. **Design** - Apply distinctive aesthetic principles
4. **Implement** - Install and customize components
5. **Validate** - Visual test with Playwright, run audit

## Tool Integration

For library IDs and patterns, see:

- [MCP Resources](../../lib/shared-references/mcp-resources.md)
- [Tool Patterns](../../lib/shared-references/tool-integration-patterns.md)

### Key Resources

| Resource   | Tool/Library                | Use Case            |
| ---------- | --------------------------- | ------------------- |
| Shadcn     | MCP: shadcn                 | Component discovery |
| React      | `/facebook/react`           | React patterns      |
| Next.js    | `/vercel/next.js`           | Next.js patterns    |
| Tailwind   | `/tailwindlabs/tailwindcss` | Utility classes     |
| Playwright | MCP: playwright             | Visual validation   |

## References

- [Detailed Guide](references/guide.md) - Full workflow, phases, and MCP integration
- [Design Guidelines](references/guide.md#design-guidelines) - Typography, color, motion
- [Anti-Patterns](references/guide.md#anti-patterns-to-avoid) - What to avoid

## Boundaries

**Will**: Create distinctive UI, use Shadcn components, apply aesthetic principles, validate visually

**Will Not**: Build from scratch when libraries exist, use generic aesthetics, implement backend logic
