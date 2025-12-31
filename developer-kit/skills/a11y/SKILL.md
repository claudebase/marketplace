---
name: a11y
description: "Accessibility audit and WCAG 2.1 AA compliance. This skill should be used when the user asks about 'accessibility', 'a11y', 'WCAG compliance', 'screen reader', or 'keyboard navigation'. Also use when user mentions color contrast, ARIA attributes, or accessibility testing. READ-ONLY - audits without modifying code."
allowed-tools:
  # Core Analysis
  - Read
  - Grep
  - Glob
  - Bash
  # Accessibility Documentation
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  # Pattern Research
  - mcp__github__search_code
  - mcp__github__get_file_contents
  # Best Practices Research
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  # Visual Testing
  - mcp__playwright__browser_navigate
  - mcp__playwright__browser_snapshot
  # Complex Audit Planning
  - mcp__sequential-thinking__sequentialthinking
---

# Accessibility (a11y) Skill

Comprehensive accessibility auditing and WCAG compliance checking with official guidelines, testing tools, and accessible component patterns.

## Activation Triggers

- Accessibility audit requests ("check accessibility", "a11y audit")
- WCAG compliance checks ("WCAG 2.1 AA", "accessibility compliance")
- Screen reader compatibility ("screen reader friendly", "VoiceOver")
- Keyboard navigation testing ("keyboard accessible", "focus management")
- Color contrast validation ("check color contrast", "contrast ratio")
- ARIA implementation review ("ARIA labels", "semantic HTML", "role=")

## Do NOT Activate When

- General UI design without a11y focus → use `frontend` skill
- Performance optimization → use `performance` skill
- Security audit → use `security` skill
- General code analysis → use `analyze` skill

## Behavioral Flow

```
┌──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
│     SCAN     │   RESEARCH   │    AUDIT     │     TEST     │    REPORT    │
├──────────────┼──────────────┼──────────────┼──────────────┼──────────────┤
│ Identify     │ Lookup       │ Check        │ Validate     │ Categorize   │
│ UI           │ WCAG         │ against      │ keyboard     │ issues by    │
│ components   │ criteria     │ WCAG 2.1 AA  │ navigation   │ severity     │
│              │              │              │              │              │
│ Find         │ Find         │ Run          │ Test         │ Provide      │
│ patterns     │ accessible   │ automated    │ screen       │ specific     │
│              │ patterns     │ checks       │ reader paths │ fixes        │
│              │              │              │              │              │
│ Map          │ Research     │ Analyze      │ Check        │ Reference    │
│ interactions │ best         │ contrast     │ focus        │ WCAG         │
│              │ practices    │ ratios       │ management   │ criteria     │
└──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘
     Read           Context7      Grep/Bash      Playwright     Output
     Grep           GitHub        axe-core       Keyboard       Report
                    Tavily                       testing
```

### Phase 1: SCAN

Identify UI components and accessibility patterns:

1. **Read component structure** - Identify interactive elements, forms, navigation
2. **Find ARIA usage** - Current aria-\* attributes, roles, labels
3. **Map interactions** - Click handlers, focus management, modals
4. **Identify images** - Alt text, decorative vs informative

**Tools**: Read, Grep, Glob

### Phase 2: RESEARCH

Gather official WCAG criteria and accessible patterns:

```
# Lookup WCAG success criteria
mcp__context7__resolve-library-id → "/w3c/wcag"
mcp__context7__query-docs("WCAG 2.4.7 focus visible requirements")

# Lookup axe-core rules
mcp__context7__resolve-library-id → "/dequelabs/axe-core"
mcp__context7__query-docs("color-contrast rule explanation")

# Find accessible component patterns
mcp__github__search_code("aria-label role=dialog filename:.tsx")

# Research screen reader best practices
mcp__tavily__tavily-search("VoiceOver React modal accessibility 2024")
```

**Tools**: Context7, GitHub MCP, Tavily

### Phase 3: AUDIT

Check against WCAG 2.1 AA criteria:

```bash
# Run axe-core
npx @axe-core/cli https://localhost:3000 --exit

# Run Pa11y
npx pa11y https://localhost:3000 --standard WCAG2AA

# Run Lighthouse accessibility
npx lighthouse https://localhost:3000 --only-categories=accessibility
```

**Pattern Detection:**

```
# Find missing alt text
Grep: <img[^>]*(?!alt=)[^>]*>

# Find non-semantic buttons
Grep: <div[^>]*onClick

# Find missing form labels
Grep: <input[^>]*(?!id=|aria-label)[^>]*>
```

**Tools**: Grep, Bash (axe-core, Pa11y, Lighthouse)

### Phase 4: TEST

Validate keyboard and screen reader paths:

```
# Navigate to page
mcp__playwright__browser_navigate("http://localhost:3000")

# Capture accessibility tree
mcp__playwright__browser_snapshot()
```

**Keyboard Testing Checklist:**

- TAB through all interactive elements
- ENTER/SPACE activate buttons
- ESC closes modals
- Arrow keys navigate within components
- No keyboard traps

**Tools**: Playwright

### Phase 5: REPORT

Generate categorized findings with fixes:

```yaml
Accessibility Audit Report
==========================

Overall Score: 78/100 (Needs Improvement)

Critical Issues (Must Fix):
  - [1.4.3] Low contrast on buttons
    Location: src/components/Button.tsx:15
    Fix: Change #777 to #595959 for 7:1 ratio

Serious Issues (Should Fix):
  - [2.4.7] Missing focus indicator
    Location: src/components/Nav.css:24
    Fix: Add :focus-visible { outline: 2px solid #0066cc }

Passed Checks: 42/50
WCAG 2.1 AA Compliance: Partial
```

## MCP Integration

### Context7 (Official Documentation)

**Primary source for WCAG and accessibility standards:**

```
mcp__context7__resolve-library-id - Resolve WCAG, axe-core, React Aria IDs
mcp__context7__query-docs - Get official accessibility documentation
```

**Available Resources:**

| Resource   | Library ID                   | Snippets |
| ---------- | ---------------------------- | -------- |
| WCAG       | `/w3c/wcag`                  | 1,058    |
| axe-core   | `/dequelabs/axe-core`        | 326      |
| React Aria | `/websites/react-aria_adobe` | 4,485    |

**Use cases:**

- "WCAG 2.4.7 focus visible requirements"
- "axe-core color-contrast rule"
- "React Aria Button keyboard handling"
- "WCAG 1.4.3 contrast ratio calculation"
- "React Aria modal focus management"

### GitHub MCP (Pattern Research)

**Find accessible component implementations:**

```
mcp__github__search_code - Find accessible patterns in codebases
mcp__github__get_file_contents - Get specific component implementations
```

**Search patterns:**

```
# Find accessible modal implementations
"aria-modal" "role=dialog" "focus-trap" filename:.tsx

# Find keyboard navigation patterns
"onKeyDown" "ArrowDown" "ArrowUp" filename:.tsx

# Find skip link implementations
"skip-to-main" "skip-link" filename:.tsx

# Find accessible form patterns
"aria-describedby" "aria-invalid" filename:.tsx
```

**Use cases:**

- Find how major projects implement accessible modals
- Research focus management patterns
- Get accessible form validation examples
- Study screen reader announcement patterns

### Tavily (Best Practices Research)

**Research accessibility best practices:**

```
mcp__tavily__tavily-search - Research a11y patterns, screen reader tips
mcp__tavily__tavily-extract - Extract from accessibility articles
```

**Use cases:**

- "WCAG 2.2 new success criteria changes"
- "React accessible modal focus trap implementation"
- "Screen reader testing best practices 2024"
- "VoiceOver vs NVDA differences React"
- "Accessible data table implementation patterns"

### Playwright (Visual Testing)

**Test accessibility in browser:**

```
mcp__playwright__browser_navigate - Load page for testing
mcp__playwright__browser_snapshot - Capture accessibility tree
```

**Use for:**

- Verify focus order
- Check accessibility tree structure
- Test interactive element behavior
- Validate ARIA attributes in DOM

### Sequential Thinking (Complex Audits)

**Structured reasoning for comprehensive audits:**

```
mcp__sequential-thinking__sequentialthinking - Systematic audit planning
```

**Use for:**

- Multi-page application audits
- Complex component accessibility review
- WCAG compliance gap analysis
- Remediation priority planning

## WCAG 2.1 AA Compliance

### 1. Perceivable

| Criterion              | Check                 | Pass Criteria                  |
| ---------------------- | --------------------- | ------------------------------ |
| 1.1.1 Non-text Content | Images have alt text  | All images have meaningful alt |
| 1.3.1 Info & Relations | Semantic structure    | Proper headings, lists, tables |
| 1.4.3 Contrast (Min)   | Color contrast ratio  | 4.5:1 normal, 3:1 large text   |
| 1.4.4 Resize Text      | Text scaling          | Readable at 200% zoom          |
| 1.4.11 Non-text        | UI component contrast | 3:1 for interactive elements   |

### 2. Operable

| Criterion              | Check               | Pass Criteria                  |
| ---------------------- | ------------------- | ------------------------------ |
| 2.1.1 Keyboard         | Keyboard accessible | All functions via keyboard     |
| 2.1.2 No Keyboard Trap | Focus management    | Can tab away from all elements |
| 2.4.1 Bypass Blocks    | Skip links          | Skip to main content link      |
| 2.4.3 Focus Order      | Tab sequence        | Logical focus progression      |
| 2.4.7 Focus Visible    | Focus indicators    | Visible focus state            |

### 3. Understandable

| Criterion              | Check             | Pass Criteria                 |
| ---------------------- | ----------------- | ----------------------------- |
| 3.1.1 Language of Page | Lang attribute    | `<html lang="...">` present   |
| 3.2.1 On Focus         | No context change | Focus doesn't trigger actions |
| 3.3.1 Error ID         | Error messages    | Errors clearly described      |
| 3.3.2 Labels           | Form labels       | All inputs have labels        |

### 4. Robust

| Criterion               | Check        | Pass Criteria                  |
| ----------------------- | ------------ | ------------------------------ |
| 4.1.1 Parsing           | Valid HTML   | No duplicate IDs, valid markup |
| 4.1.2 Name, Role, Value | ARIA correct | Proper ARIA implementation     |

## Automated Checks

### Command-Line Tools

```bash
# axe-core (comprehensive)
npx @axe-core/cli https://example.com

# Pa11y (configurable)
npx pa11y https://example.com --standard WCAG2AA

# Lighthouse (Chrome-based)
npx lighthouse https://example.com --only-categories=accessibility

# HTML validator
npx html-validate src/**/*.html
```

### Code Pattern Detection

```javascript
// Bad: Missing alt text
<img src="hero.jpg">

// Good: Descriptive alt
<img src="hero.jpg" alt="Team collaborating on project">

// Bad: Non-semantic button
<div onclick="submit()">Submit</div>

// Good: Semantic button
<button type="submit">Submit</button>

// Bad: Missing form label
<input type="email" name="email">

// Good: Associated label
<label for="email">Email address</label>
<input type="email" id="email" name="email">
```

## Manual Testing Guidance

### Keyboard Testing

```
TAB       → Move forward through interactive elements
SHIFT+TAB → Move backward
ENTER     → Activate buttons, links
SPACE     → Activate buttons, checkboxes
ARROW     → Navigate within components (menus, tabs)
ESC       → Close modals, dismiss popups
```

### Screen Reader Testing

| Screen Reader | Platform | Test Command             |
| ------------- | -------- | ------------------------ |
| VoiceOver     | macOS    | Cmd+F5 to toggle         |
| NVDA          | Windows  | Free download            |
| JAWS          | Windows  | Commercial               |
| TalkBack      | Android  | Settings → Accessibility |
| VoiceOver     | iOS      | Settings → Accessibility |

### Color Contrast Testing

```
Contrast ratio requirements:
- Normal text (< 18pt): 4.5:1 minimum
- Large text (≥ 18pt or 14pt bold): 3:1 minimum
- UI components: 3:1 minimum

Online tools:
- WebAIM Contrast Checker
- Colour Contrast Analyser (CCA)
- Chrome DevTools (Accessibility pane)
```

## Reference Files

For detailed patterns and checklists, see:

- `references/wcag-checklist.md` - Full WCAG 2.1 AA checklist
- `references/testing-tools.md` - Tool configuration guides
- `references/common-fixes.md` - Code fixes for common issues

## Handoffs

| Scenario                | Hand off to       |
| ----------------------- | ----------------- |
| Need to implement fixes | `frontend` skill  |
| Need design changes     | `design` skill    |
| Need component refactor | `implement` skill |
| Need security review    | `security` skill  |

## Boundaries

**Will:**

- Audit UI components for accessibility issues
- Check WCAG 2.1 AA compliance
- Provide specific fix recommendations with code
- Test keyboard navigation paths
- Analyze color contrast ratios
- Research accessibility best practices via MCP tools

**Will Not:**

- Implement fixes without approval (use `frontend` skill)
- Certify full WCAG compliance (requires human audit)
- Test with actual assistive technology (provides guidance only)
- Guarantee legal compliance
- Make design decisions (use `design` skill)
