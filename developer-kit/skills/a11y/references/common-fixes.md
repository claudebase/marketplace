# Common Accessibility Fixes

Quick reference for fixing common accessibility issues.

## Images

### Missing Alt Text

```html
<!-- Bad -->
<img src="product.jpg">

<!-- Good: Informative -->
<img src="product.jpg" alt="Blue wireless headphones with noise cancellation">

<!-- Good: Decorative -->
<img src="divider.png" alt="" role="presentation">

<!-- Good: Complex with description -->
<figure>
  <img src="chart.png" alt="Q3 sales chart showing 25% growth">
  <figcaption>Detailed: Sales increased from $1M to $1.25M...</figcaption>
</figure>
```

### Background Images with Content

```html
<!-- Bad: Important info in CSS background -->
<div class="hero" style="background-image: url(sale.jpg)"></div>

<!-- Good: Use real image or provide text alternative -->
<div class="hero">
  <img src="sale.jpg" alt="50% off summer sale">
</div>

<!-- Or with CSS background + hidden text -->
<div class="hero" role="img" aria-label="50% off summer sale"></div>
```

## Forms

### Missing Labels

```html
<!-- Bad -->
<input type="email" placeholder="Email">

<!-- Good: Visible label -->
<label for="email">Email address</label>
<input type="email" id="email" name="email">

<!-- Good: Hidden label (when design requires) -->
<label for="search" class="visually-hidden">Search</label>
<input type="search" id="search" placeholder="Search...">
```

### Visually Hidden Class

```css
.visually-hidden {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border: 0;
}
```

### Error Messages

```html
<!-- Bad -->
<input type="email" class="error">
<span class="error-text">Invalid email</span>

<!-- Good: Associated error -->
<input
  type="email"
  id="email"
  aria-invalid="true"
  aria-describedby="email-error"
>
<span id="email-error" role="alert">
  Please enter a valid email address
</span>
```

### Required Fields

```html
<!-- Bad: Visual only -->
<label>Name *</label>
<input type="text">

<!-- Good: Programmatically indicated -->
<label for="name">
  Name <span aria-hidden="true">*</span>
  <span class="visually-hidden">(required)</span>
</label>
<input type="text" id="name" required aria-required="true">
```

## Buttons and Links

### Non-semantic Buttons

```html
<!-- Bad -->
<div onclick="submit()">Submit</div>
<span class="btn" onclick="save()">Save</span>

<!-- Good -->
<button type="submit">Submit</button>
<button type="button" onclick="save()">Save</button>
```

### Links Without Href

```html
<!-- Bad -->
<a onclick="navigate()">Go to page</a>

<!-- Good: Real link -->
<a href="/page">Go to page</a>

<!-- Good: If must be JavaScript -->
<a href="/page" onclick="navigate(event)">Go to page</a>
```

### Icon-only Buttons

```html
<!-- Bad -->
<button><svg>...</svg></button>

<!-- Good: With aria-label -->
<button aria-label="Close dialog">
  <svg aria-hidden="true">...</svg>
</button>

<!-- Good: With visually hidden text -->
<button>
  <svg aria-hidden="true">...</svg>
  <span class="visually-hidden">Close dialog</span>
</button>
```

### Ambiguous Link Text

```html
<!-- Bad -->
<a href="/doc.pdf">Click here</a>
<a href="/products">Read more</a>

<!-- Good: Descriptive -->
<a href="/doc.pdf">Download annual report (PDF)</a>
<a href="/products">View all products</a>

<!-- Good: Context with aria-label -->
<a href="/products" aria-label="Read more about our products">Read more</a>
```

## Focus Management

### Missing Focus Indicator

```css
/* Bad: Removing focus */
*:focus {
  outline: none;
}

/* Good: Custom focus indicator */
*:focus {
  outline: 2px solid #0066cc;
  outline-offset: 2px;
}

/* Good: Focus-visible for mouse users */
*:focus:not(:focus-visible) {
  outline: none;
}
*:focus-visible {
  outline: 2px solid #0066cc;
  outline-offset: 2px;
}
```

### Modal Focus Trap

```javascript
// Trap focus in modal
function trapFocus(modal) {
  const focusable = modal.querySelectorAll(
    'button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])'
  );
  const first = focusable[0];
  const last = focusable[focusable.length - 1];

  modal.addEventListener('keydown', (e) => {
    if (e.key === 'Tab') {
      if (e.shiftKey && document.activeElement === first) {
        e.preventDefault();
        last.focus();
      } else if (!e.shiftKey && document.activeElement === last) {
        e.preventDefault();
        first.focus();
      }
    }
    if (e.key === 'Escape') {
      closeModal();
    }
  });

  first.focus();
}
```

## Color Contrast

### Low Contrast Text

```css
/* Bad: 2.5:1 ratio */
.text {
  color: #999999;
  background: #ffffff;
}

/* Good: 7:1 ratio */
.text {
  color: #595959;
  background: #ffffff;
}
```

### Links in Text

```css
/* Bad: Only color difference */
a {
  color: #0066cc;
}

/* Good: Color + underline */
a {
  color: #0066cc;
  text-decoration: underline;
}

/* Good: Color + other indicator */
a {
  color: #0066cc;
  font-weight: bold;
}
a:hover, a:focus {
  text-decoration: underline;
}
```

## Headings and Structure

### Skipped Heading Levels

```html
<!-- Bad -->
<h1>Page Title</h1>
<h3>Section</h3>

<!-- Good -->
<h1>Page Title</h1>
<h2>Section</h2>
<h3>Subsection</h3>
```

### Missing Skip Link

```html
<!-- Add at top of page -->
<a href="#main" class="skip-link">Skip to main content</a>

<!-- Style to show on focus -->
<style>
.skip-link {
  position: absolute;
  top: -40px;
  left: 0;
  padding: 8px;
  background: #000;
  color: #fff;
  z-index: 100;
}
.skip-link:focus {
  top: 0;
}
</style>

<!-- Main content target -->
<main id="main" tabindex="-1">
  <!-- Page content -->
</main>
```

## ARIA Patterns

### Tabs

```html
<div role="tablist" aria-label="Settings">
  <button
    role="tab"
    aria-selected="true"
    aria-controls="panel-1"
    id="tab-1"
  >
    General
  </button>
  <button
    role="tab"
    aria-selected="false"
    aria-controls="panel-2"
    id="tab-2"
    tabindex="-1"
  >
    Security
  </button>
</div>

<div
  role="tabpanel"
  id="panel-1"
  aria-labelledby="tab-1"
>
  General settings content
</div>

<div
  role="tabpanel"
  id="panel-2"
  aria-labelledby="tab-2"
  hidden
>
  Security settings content
</div>
```

### Accordion

```html
<div class="accordion">
  <h3>
    <button
      aria-expanded="true"
      aria-controls="section-1"
    >
      Section 1
    </button>
  </h3>
  <div id="section-1">
    Section 1 content
  </div>

  <h3>
    <button
      aria-expanded="false"
      aria-controls="section-2"
    >
      Section 2
    </button>
  </h3>
  <div id="section-2" hidden>
    Section 2 content
  </div>
</div>
```

### Live Regions

```html
<!-- Polite announcements (wait for pause) -->
<div role="status" aria-live="polite">
  Settings saved successfully
</div>

<!-- Assertive announcements (interrupt) -->
<div role="alert" aria-live="assertive">
  Error: Connection lost
</div>

<!-- Dynamic content loading -->
<div aria-busy="true" aria-live="polite">
  Loading...
</div>
```
