# Accessibility Testing Tools

Comprehensive guide to accessibility testing tools and techniques.

## Automated Testing Tools

### Browser Extensions

#### axe DevTools (Chrome/Firefox/Edge)
```
Best for: Quick automated audits
Install: Chrome Web Store / Firefox Add-ons
Usage: DevTools → axe tab → Analyze
Features:
  - WCAG 2.0/2.1 A/AA checking
  - Best practice recommendations
  - Guided remediation
```

#### WAVE (Chrome/Firefox)
```
Best for: Visual error highlighting
Install: Chrome Web Store / Firefox Add-ons
Usage: Click extension icon
Features:
  - Inline error indicators
  - Color contrast analysis
  - Document structure view
```

#### Lighthouse (Built into Chrome)
```
Best for: Performance + accessibility audit
Access: DevTools → Lighthouse tab
Usage: Generate report
Features:
  - Accessibility score
  - SEO audit included
  - Performance metrics
```

### Command-Line Tools

#### axe-core CLI
```bash
# Install
npm install -g @axe-core/cli

# Run audit
axe https://example.com

# With specific rules
axe https://example.com --rules wcag2aa

# Output to file
axe https://example.com --save results.json
```

#### Pa11y
```bash
# Install
npm install -g pa11y

# Basic usage
pa11y https://example.com

# WCAG 2.1 AA standard
pa11y https://example.com --standard WCAG2AA

# Output formats
pa11y https://example.com --reporter cli
pa11y https://example.com --reporter json
pa11y https://example.com --reporter html

# CI/CD integration
pa11y https://example.com --threshold 0
```

#### Lighthouse CLI
```bash
# Install
npm install -g lighthouse

# Run accessibility audit only
lighthouse https://example.com --only-categories=accessibility

# Output formats
lighthouse https://example.com --output html --output-path report.html
lighthouse https://example.com --output json --output-path report.json
```

#### HTML Validator
```bash
# Install
npm install -g html-validate

# Validate files
html-validate src/**/*.html

# With config
# .htmlvalidate.json
{
  "extends": ["html-validate:recommended"],
  "rules": {
    "require-sri": "off"
  }
}
```

### CI/CD Integration

#### GitHub Actions
```yaml
name: Accessibility Tests

on: [push, pull_request]

jobs:
  a11y:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Setup Node
        uses: actions/setup-node@v3
        with:
          node-version: '18'

      - name: Install dependencies
        run: npm ci

      - name: Start server
        run: npm start &

      - name: Wait for server
        run: npx wait-on http://localhost:3000

      - name: Run Pa11y
        run: npx pa11y http://localhost:3000 --threshold 0
```

#### Jest + axe-core
```javascript
// jest.setup.js
import { toHaveNoViolations } from 'jest-axe';
expect.extend(toHaveNoViolations);

// component.test.js
import { axe } from 'jest-axe';
import { render } from '@testing-library/react';

test('should have no accessibility violations', async () => {
  const { container } = render(<MyComponent />);
  const results = await axe(container);
  expect(results).toHaveNoViolations();
});
```

#### Cypress + cypress-axe
```javascript
// cypress/support/commands.js
import 'cypress-axe';

// cypress/e2e/a11y.cy.js
describe('Accessibility', () => {
  beforeEach(() => {
    cy.visit('/');
    cy.injectAxe();
  });

  it('should have no violations on load', () => {
    cy.checkA11y();
  });

  it('should have no violations after interaction', () => {
    cy.get('button').click();
    cy.checkA11y();
  });
});
```

## Manual Testing Tools

### Screen Readers

#### VoiceOver (macOS)
```
Enable:  Cmd + F5
Rotor:   Ctrl + Option + U
Navigate: Ctrl + Option + Arrow keys
Read all: Ctrl + Option + A

Common shortcuts:
  Ctrl + Option + Right → Next element
  Ctrl + Option + Left  → Previous element
  Ctrl + Option + Space → Activate
```

#### NVDA (Windows - Free)
```
Download: nvaccess.org
Start:    Ctrl + Alt + N

Common shortcuts:
  Insert + Down → Read all
  Tab          → Next form field
  H            → Next heading
  B            → Next button
  K            → Next link
```

#### JAWS (Windows - Commercial)
```
Common shortcuts:
  Insert + Down → Read all
  Insert + F6   → Headings list
  Insert + F7   → Links list
```

### Color Contrast Tools

#### WebAIM Contrast Checker
```
URL: webaim.org/resources/contrastchecker/
Features:
  - Foreground/background input
  - WCAG 2.0/2.1 ratings
  - Color picker
```

#### Colour Contrast Analyser (CCA)
```
Download: tpgi.com/color-contrast-checker/
Features:
  - Desktop application
  - Eye dropper tool
  - Luminosity and color difference
```

#### Chrome DevTools
```
1. Open DevTools (F12)
2. Select element
3. Styles panel → Color swatch
4. Contrast ratio shown
```

### Keyboard Testing

#### Focus Order Visualization
```css
/* Temporary debugging style */
*:focus {
  outline: 3px solid red !important;
  outline-offset: 2px !important;
}
```

#### Tab Index Inspector (Browser Extension)
```
Shows tab order visually
Highlights focusable elements
```

### Document Structure Tools

#### HeadingsMap (Browser Extension)
```
Shows heading hierarchy
Identifies skipped levels
Visualizes document outline
```

#### Landmarks (Browser Extension)
```
Shows ARIA landmarks
Identifies main, nav, banner, etc.
```

## Testing Methodology

### Audit Process

```
1. AUTOMATED SCAN
   - Run axe/Lighthouse
   - Fix critical issues
   - Re-scan

2. KEYBOARD TEST
   - Tab through all elements
   - Verify focus indicators
   - Test all interactions

3. SCREEN READER TEST
   - Navigate with headings
   - Read forms
   - Test dynamic content

4. VISUAL TEST
   - Check contrast
   - Test at 200% zoom
   - Test responsive views

5. DOCUMENT REVIEW
   - Check heading structure
   - Verify landmarks
   - Review ARIA usage
```

### Severity Classification

| Level | Impact | Priority |
|-------|--------|----------|
| Critical | Blocks access | Fix immediately |
| Serious | Significant barrier | Fix before release |
| Moderate | Some difficulty | Fix in sprint |
| Minor | Inconvenience | Backlog |
