# Frontend Skill - Detailed Guide

## Behavioral Flow

```
┌─────────────┬─────────────┬─────────────┬───────────┬──────────┐
│  UNDERSTAND │   DISCOVER  │    DESIGN   │ IMPLEMENT │ VALIDATE │
├─────────────┼─────────────┼─────────────┼───────────┼──────────┤
│ Analyze     │ Search      │ Apply       │ Install   │ Visual   │
│ requirements│ Shadcn      │ aesthetic   │ components│ test     │
│             │             │ principles  │           │          │
│ Detect      │ View        │ Plan UX     │ Customize │ Audit    │
│ framework   │ examples    │ flow        │ styling   │ checklist│
│             │             │             │           │          │
│ Identify    │ Check       │ Motion &    │ Add       │ A11y     │
│ patterns    │ blocks      │ animation   │ animations│ check    │
└─────────────┴─────────────┴─────────────┴───────────┴──────────┘
```

## Phase 1: UNDERSTAND

Analyze requirements and detect project context:

1. **Read existing code** to understand patterns, framework, styling approach
2. **Detect framework**: React, Vue, Next.js, Astro, etc.
3. **Identify styling**: Tailwind, CSS Modules, styled-components
4. **Check for shadcn/ui**: Look for `components.json` or existing shadcn components

## Phase 2: DISCOVER

Search for reusable components before building from scratch:

```
# Check available registries
mcp__shadcn__get_project_registries

# Search for relevant components
mcp__shadcn__search_items_in_registries(["@shadcn"], "dashboard sidebar")

# View component details and dependencies
mcp__shadcn__view_items_in_registries(["@shadcn/sidebar", "@shadcn/card"])

# Get usage examples
mcp__shadcn__get_item_examples_from_registries(["@shadcn"], "sidebar-demo")
```

### Available Block Categories

| Category  | Examples                                      | Use Case                      |
| --------- | --------------------------------------------- | ----------------------------- |
| Dashboard | `dashboard-01`                                | Admin panels, analytics       |
| Auth      | `login-01-05`, `signup-01-05`, `otp-01-05`    | Authentication flows          |
| Sidebar   | `sidebar-01-16`                               | Navigation, collapsible menus |
| Calendar  | `calendar-01-32`                              | Date pickers, scheduling      |
| Charts    | `chart-area-*`, `chart-bar-*`, `chart-line-*` | Data visualization            |
| Forms     | `form-rhf-*`, `form-tanstack-*`               | Validated forms               |

## Phase 3: DESIGN

Apply distinctive aesthetic principles. Components provide structure; design provides soul.

**Design Thinking Questions:**

- **Purpose**: What problem does this interface solve? Who uses it?
- **Tone**: What aesthetic direction? (minimalist, maximalist, brutalist, editorial, etc.)
- **Differentiation**: What makes this UNFORGETTABLE?

**CRITICAL**: Choose a clear conceptual direction and execute with precision.

## Phase 4: IMPLEMENT

Install components and customize:

```bash
# Get installation command
mcp__shadcn__get_add_command_for_items(["@shadcn/sidebar", "@shadcn/card"])

# Run installation
npx shadcn@latest add sidebar card
```

## Phase 5: VALIDATE

```
# Run audit checklist
mcp__shadcn__get_audit_checklist

# Visual testing with Playwright
mcp__playwright__browser_navigate → navigate to page
mcp__playwright__browser_snapshot → capture accessibility tree
```

## MCP Integration

### Shadcn MCP (Primary Component Source)

**ALWAYS check Shadcn first** before building components from scratch:

```
# Discovery workflow
mcp__shadcn__search_items_in_registries - Find components by keyword
mcp__shadcn__list_items_in_registries   - Browse all available (438+ items)
mcp__shadcn__view_items_in_registries   - Get details, dependencies, files

# Learning workflow
mcp__shadcn__get_item_examples_from_registries - See usage patterns

# Installation workflow
mcp__shadcn__get_add_command_for_items - Get CLI command

# Validation workflow
mcp__shadcn__get_audit_checklist - Post-implementation checks
```

### Context7 (Framework Documentation)

For framework-specific patterns (React hooks, Vue composables, etc.):

```
mcp__context7__resolve-library-id - Resolve "react" → "/facebook/react"
mcp__context7__query-docs         - Get official documentation
```

### Playwright (Visual Validation)

Test implementations visually:

```
mcp__playwright__browser_navigate - Load the page
mcp__playwright__browser_snapshot - Capture accessibility tree
mcp__playwright__browser_click    - Test interactions
```

## Design Guidelines

Components provide the 70% foundation. These guidelines create the distinctive 30%.

### Typography

- **Avoid generic fonts**: Inter, Roboto, Arial, system fonts
- **Choose distinctive fonts**: Pair a characterful display font with refined body font
- **Create hierarchy**: Clear visual distinction between heading levels
- **Consider context**: Editorial needs different typography than dashboard

### Color & Theme

- **Commit to an aesthetic**: Dark mode, light mode, or something unique
- **Use CSS variables**: Enable easy theme switching
- **Dominant + accent**: Strong primary with sharp accents outperforms evenly-distributed palettes
- **Shadcn themes**: Consider `theme-stone`, `theme-zinc`, `theme-neutral`, `theme-slate`

### Motion & Animation

- **Prioritize impact**: One well-orchestrated page load beats scattered micro-interactions
- **Staggered reveals**: Use `animation-delay` for sequential entrance
- **Hover states**: Subtle transforms, color shifts
- **CSS-first**: Prefer CSS animations; use Motion library for complex sequences
- **Scroll triggers**: Reveal on scroll for long pages

### Spatial Composition

- **Break the grid**: Asymmetry, overlap, diagonal flow
- **Generous whitespace**: Or controlled density - commit to one
- **Unexpected layouts**: Not every page needs header-content-footer

### Visual Details

- **Backgrounds**: Gradient meshes, noise textures, geometric patterns
- **Depth**: Layered transparencies, dramatic shadows
- **Polish**: Custom cursors, grain overlays, decorative borders

## Anti-Patterns to Avoid

**Generic "AI Slop" Aesthetics:**

- Purple gradients on white backgrounds
- Overused font families (Inter, Space Grotesk)
- Predictable layouts
- Cookie-cutter components without customization
- Same aesthetic across different contexts

**Technical Anti-Patterns:**

- Building from scratch when Shadcn has it
- Ignoring existing project patterns
- Over-engineering simple components
- Missing accessibility basics

## Component Customization Patterns

### After Installing Shadcn Components

```tsx
// 1. Extend with variants
const Button = ({ variant = "default", ...props }) => {
  // Add custom variants beyond shadcn defaults
}

// 2. Override CSS variables in globals.css
:root {
  --primary: 220 90% 56%;      /* Custom brand color */
  --radius: 0.75rem;           /* Rounder corners */
}

// 3. Add motion
import { motion } from "framer-motion"
const AnimatedCard = motion(Card)
```

### Responsive Considerations

- Mobile-first approach
- Use `use-mobile` hook from Shadcn when needed
- Test at multiple breakpoints
- Consider touch targets on mobile
