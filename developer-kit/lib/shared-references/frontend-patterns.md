# Frontend Patterns

Centralized patterns for frontend development. Used by `frontend` skill and `a11y` skill.

## Component Structure

### React Component Pattern

```tsx
// Recommended component structure
export function ComponentName({ prop1, prop2, children }: Props) {
  // 1. Hooks
  const [state, setState] = useState<StateType>(initialValue);
  const ref = useRef<HTMLDivElement>(null);

  // 2. Derived state (memoized if expensive)
  const derivedValue = useMemo(() => {
    return computeExpensiveValue(prop1, prop2);
  }, [prop1, prop2]);

  // 3. Effects
  useEffect(() => {
    // Setup
    const subscription = subscribe();

    // Cleanup
    return () => {
      subscription.unsubscribe();
    };
  }, [deps]);

  // 4. Event handlers
  const handleClick = useCallback(
    (event: MouseEvent) => {
      // Handle event
    },
    [deps],
  );

  // 5. Render
  return (
    <div ref={ref} onClick={handleClick}>
      {children}
    </div>
  );
}
```

### Vue Component Pattern

```vue
<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from "vue";

// Props
const props = defineProps<{
  title: string;
  count?: number;
}>();

// Emits
const emit = defineEmits<{
  (e: "update", value: number): void;
}>();

// Reactive state
const isActive = ref(false);

// Computed
const displayTitle = computed(() => `${props.title}: ${props.count ?? 0}`);

// Lifecycle
onMounted(() => {
  // Setup
});

onUnmounted(() => {
  // Cleanup
});

// Methods
function handleClick() {
  isActive.value = !isActive.value;
  emit("update", props.count ?? 0);
}
</script>

<template>
  <div :class="{ active: isActive }" @click="handleClick">
    {{ displayTitle }}
  </div>
</template>
```

## Shadcn/UI Integration

### Discovery Workflow

```yaml
1. Search for Component: mcp__shadcn__search_items_in_registries(["@shadcn"], "button")

2. View Component Details: mcp__shadcn__view_items_in_registries(["@shadcn/button"])

3. Get Usage Examples: mcp__shadcn__get_item_examples_from_registries(["@shadcn"], "button-demo")

4. Install Component: mcp__shadcn__get_add_command_for_items(["@shadcn/button"])
  → npx shadcn@latest add button

5. Audit After Installation: mcp__shadcn__get_audit_checklist()
```

### Component Categories

| Category   | Components                      | Use Case          |
| ---------- | ------------------------------- | ----------------- |
| Input      | Button, Input, Textarea, Select | User interaction  |
| Display    | Card, Badge, Avatar, Table      | Data presentation |
| Feedback   | Alert, Toast, Progress          | User feedback     |
| Navigation | Tabs, Breadcrumb, Pagination    | Navigation        |
| Overlay    | Dialog, Sheet, Popover          | Modal content     |
| Layout     | Separator, Aspect Ratio         | Page structure    |

## Accessibility (WCAG 2.1 AA)

### Core Requirements Checklist

```yaml
Perceivable:
  - All images have meaningful alt text
  - Color contrast ratio ≥ 4.5:1 for normal text
  - Color contrast ratio ≥ 3:1 for large text
  - No information conveyed by color alone
  - Audio/video has captions or transcripts

Operable:
  - All interactive elements keyboard accessible
  - No keyboard traps
  - Focus indicators visible
  - Skip links for navigation
  - Page titles are descriptive

Understandable:
  - Language declared (lang attribute)
  - Form inputs have visible labels
  - Error messages are clear and specific
  - Navigation is consistent

Robust:
  - Valid HTML structure
  - ARIA used correctly
  - Works with assistive technology
```

### ARIA Best Practices

```yaml
Do:
  - Use semantic HTML first (button, nav, main, etc.)
  - Add aria-label when visual text absent
  - Use aria-describedby for supplementary info
  - Include aria-live for dynamic updates

Don't:
  - Add role to semantic elements (no role="button" on <button>)
  - Use aria-hidden on focusable elements
  - Overuse aria-label (prefer visible text)
  - Forget to update ARIA when state changes
```

### Keyboard Navigation Patterns

```yaml
Focus Management:
  - Tab: Move to next focusable element
  - Shift+Tab: Move to previous focusable element
  - Enter/Space: Activate buttons and links
  - Escape: Close modals, menus, popups
  - Arrow keys: Navigate within components

Focus Trap (for modals):
  - Focus moves to modal on open
  - Tab cycles within modal only
  - Escape closes modal
  - Focus returns to trigger on close
```

## Design Guidelines

### Typography

```yaml
Font Stack:
  sans: Inter, system-ui, sans-serif
  mono: JetBrains Mono, Menlo, monospace

Scale (using rem):
  xs: 0.75rem (12px)
  sm: 0.875rem (14px)
  base: 1rem (16px)
  lg: 1.125rem (18px)
  xl: 1.25rem (20px)
  2xl: 1.5rem (24px)
  3xl: 1.875rem (30px)

Line Height:
  tight: 1.25
  normal: 1.5
  relaxed: 1.75
```

### Color Contrast

```yaml
Minimum Ratios:
  Normal text (< 18px): 4.5:1
  Large text (≥ 18px or bold ≥ 14px): 3:1
  UI components and graphics: 3:1

Testing:
  - Use browser devtools accessibility checker
  - Test with color blindness simulators
  - Verify in both light and dark modes
```

### Motion and Animation

```yaml
Best Practices:
  - Respect prefers-reduced-motion
  - Keep animations under 300ms
  - Use easing functions (ease-out for exits)
  - Avoid flashing content (max 3 flashes/sec)

CSS Pattern:
  @media (prefers-reduced-motion: reduce) {
    *, *::before, *::after {
      animation-duration: 0.01ms !important;
      transition-duration: 0.01ms !important;
    }
  }
```

## Anti-Patterns to Avoid

```yaml
Generic "AI Slop" Aesthetics:
  - Excessive gradients and glows
  - Overuse of blur effects
  - Inconsistent spacing
  - Too many competing colors
  - Generic stock imagery
  - Meaningless animations

Performance Issues:
  - Large bundle sizes
  - Layout shifts (poor CLS)
  - Blocking resources
  - Unoptimized images
  - Too many re-renders

Accessibility Failures:
  - Missing alt text
  - Poor color contrast
  - No keyboard support
  - Missing focus indicators
  - Form inputs without labels
```

## Context7 Frontend Resources

| Resource | Library ID                  | Use Case         |
| -------- | --------------------------- | ---------------- |
| React    | `/facebook/react`           | React patterns   |
| Next.js  | `/vercel/next.js`           | Next.js patterns |
| Tailwind | `/tailwindlabs/tailwindcss` | Utility classes  |
| Vue      | `/vuejs/core`               | Vue patterns     |
| Svelte   | `/sveltejs/svelte`          | Svelte patterns  |

## Related

- [MCP Resources](./mcp-resources.md) - Context7 library IDs
- [Tool Integration](./tool-integration-patterns.md) - MCP patterns
- [Testing Patterns](./testing-patterns.md) - Component testing
