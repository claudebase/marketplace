---
name: a11y
description: "Accessibility audit and compliance: WCAG 2.1 AA, screen reader compatibility, keyboard navigation, color contrast. Activates for: 'accessibility', 'a11y', 'WCAG', 'screen reader', 'keyboard navigation', 'color contrast', 'aria'."
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - mcp__playwright__browser_navigate
  - mcp__playwright__browser_snapshot
---

# Accessibility (a11y) Skill

Comprehensive accessibility auditing and WCAG compliance checking.

## Activation Triggers

- Accessibility audit requests ("check accessibility", "a11y audit")
- WCAG compliance checks ("WCAG 2.1 AA", "accessibility compliance")
- Screen reader compatibility ("screen reader friendly")
- Keyboard navigation testing ("keyboard accessible")
- Color contrast validation ("check color contrast")
- ARIA implementation review ("ARIA labels", "semantic HTML")

## Behavioral Flow

```
1. SCAN      → Identify UI components and patterns
2. AUDIT     → Check against WCAG 2.1 AA criteria
3. TEST      → Validate keyboard and screen reader paths
4. REPORT    → Categorize issues by severity
5. RECOMMEND → Provide specific fixes with code examples
```

## WCAG 2.1 AA Compliance

### 1. Perceivable

| Criterion | Check | Pass Criteria |
|-----------|-------|---------------|
| 1.1.1 Non-text Content | Images have alt text | All images have meaningful alt |
| 1.3.1 Info and Relationships | Semantic structure | Proper headings, lists, tables |
| 1.4.3 Contrast (Minimum) | Color contrast ratio | 4.5:1 normal, 3:1 large text |
| 1.4.4 Resize Text | Text scaling | Readable at 200% zoom |
| 1.4.11 Non-text Contrast | UI component contrast | 3:1 for interactive elements |

### 2. Operable

| Criterion | Check | Pass Criteria |
|-----------|-------|---------------|
| 2.1.1 Keyboard | Keyboard accessible | All functions via keyboard |
| 2.1.2 No Keyboard Trap | Focus management | Can tab away from all elements |
| 2.4.1 Bypass Blocks | Skip links | Skip to main content link |
| 2.4.3 Focus Order | Tab sequence | Logical focus progression |
| 2.4.7 Focus Visible | Focus indicators | Visible focus state |

### 3. Understandable

| Criterion | Check | Pass Criteria |
|-----------|-------|---------------|
| 3.1.1 Language of Page | Lang attribute | `<html lang="...">` present |
| 3.2.1 On Focus | No context change | Focus doesn't trigger actions |
| 3.3.1 Error Identification | Error messages | Errors clearly described |
| 3.3.2 Labels | Form labels | All inputs have labels |

### 4. Robust

| Criterion | Check | Pass Criteria |
|-----------|-------|---------------|
| 4.1.1 Parsing | Valid HTML | No duplicate IDs, valid markup |
| 4.1.2 Name, Role, Value | ARIA correct | Proper ARIA implementation |

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

### Testing Checklist

- [ ] Can access all features with keyboard only
- [ ] Focus indicator visible on all elements
- [ ] Modal focus is trapped appropriately
- [ ] Skip link works to bypass navigation
- [ ] Dropdown menus keyboard accessible
- [ ] Form errors announced and navigable

### Screen Reader Testing

| Screen Reader | Platform | Test Command |
|--------------|----------|--------------|
| VoiceOver | macOS | Cmd+F5 to toggle |
| NVDA | Windows | Free download |
| JAWS | Windows | Commercial |
| TalkBack | Android | Settings → Accessibility |
| VoiceOver | iOS | Settings → Accessibility |

### Color Contrast Testing

```bash
# Contrast ratio requirements:
# Normal text (< 18pt): 4.5:1 minimum
# Large text (≥ 18pt or 14pt bold): 3:1 minimum
# UI components: 3:1 minimum

# Online tools:
# - WebAIM Contrast Checker
# - Colour Contrast Analyser (CCA)
# - Chrome DevTools (Accessibility pane)
```

## Report Format

```yaml
Accessibility Audit Report
==========================

Overall Score: 78/100 (Needs Improvement)

Critical Issues (Must Fix):
  - [1.4.3] Low contrast on primary buttons (#777 on #fff = 4.48:1)
    Location: src/components/Button.tsx:15
    Fix: Change to #595959 for 7:1 ratio

  - [2.4.7] Missing focus indicator on nav links
    Location: src/components/Nav.css:24
    Fix: Add :focus { outline: 2px solid #0066cc }

Serious Issues (Should Fix):
  - [1.1.1] Image missing alt text
    Location: src/pages/About.tsx:42
    Fix: Add descriptive alt attribute

Moderate Issues (Consider Fixing):
  - [2.4.1] No skip link present
    Fix: Add skip-to-main-content link

Passed Checks: 42/50
```

## References

- [WCAG 2.1 Checklist](./references/wcag-checklist.md)
- [Testing Tools](./references/testing-tools.md)
- [Common Fixes](./references/common-fixes.md)

## Boundaries

**Will:**
- Audit UI components for accessibility issues
- Check WCAG 2.1 AA compliance
- Provide specific fix recommendations with code
- Test keyboard navigation paths
- Analyze color contrast ratios

**Will Not:**
- Implement fixes without approval (use frontend skill)
- Certify full WCAG compliance (requires human audit)
- Test with actual assistive technology (provides guidance only)
- Guarantee legal compliance

## Handoffs

| Scenario | Hand off to |
|----------|-------------|
| Need to implement fixes | `frontend` skill |
| Need design changes | `design` skill |
| Need component refactor | `implement` skill |
