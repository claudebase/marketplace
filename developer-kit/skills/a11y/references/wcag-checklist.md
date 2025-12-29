# WCAG 2.1 AA Checklist

Complete checklist for Web Content Accessibility Guidelines 2.1 Level AA.

## Principle 1: Perceivable

### 1.1 Text Alternatives

#### 1.1.1 Non-text Content (Level A)
- [ ] All images have appropriate alt text
- [ ] Decorative images have empty alt (`alt=""`)
- [ ] Complex images have extended descriptions
- [ ] Form inputs have text labels
- [ ] Audio/video has text alternatives

```html
<!-- Informative image -->
<img src="chart.png" alt="Sales increased 25% in Q3">

<!-- Decorative image -->
<img src="divider.png" alt="" role="presentation">

<!-- Complex image with description -->
<figure>
  <img src="diagram.png" alt="System architecture overview">
  <figcaption>Detailed description of the system...</figcaption>
</figure>
```

### 1.2 Time-based Media

#### 1.2.1 Audio-only and Video-only (Level A)
- [ ] Audio has transcript
- [ ] Video has audio description or transcript

#### 1.2.2 Captions (Level A)
- [ ] Videos have synchronized captions

#### 1.2.3 Audio Description (Level A)
- [ ] Videos have audio description track

#### 1.2.5 Audio Description (Level AA)
- [ ] Pre-recorded video has audio description

### 1.3 Adaptable

#### 1.3.1 Info and Relationships (Level A)
- [ ] Headings use proper h1-h6 hierarchy
- [ ] Lists use ul, ol, dl elements
- [ ] Tables have proper headers
- [ ] Form fields have labels
- [ ] Required fields are indicated

```html
<!-- Proper heading structure -->
<h1>Page Title</h1>
  <h2>Section</h2>
    <h3>Subsection</h3>

<!-- Proper table structure -->
<table>
  <thead>
    <tr><th scope="col">Name</th><th scope="col">Role</th></tr>
  </thead>
  <tbody>
    <tr><td>Alice</td><td>Developer</td></tr>
  </tbody>
</table>
```

#### 1.3.2 Meaningful Sequence (Level A)
- [ ] Content order makes sense when linearized
- [ ] CSS order doesn't change meaning

#### 1.3.3 Sensory Characteristics (Level A)
- [ ] Instructions don't rely solely on shape, size, location
- [ ] Color is not only means of conveying info

#### 1.3.4 Orientation (Level AA)
- [ ] Content works in portrait and landscape

#### 1.3.5 Identify Input Purpose (Level AA)
- [ ] Input fields have autocomplete attributes

```html
<input type="email" name="email" autocomplete="email">
<input type="tel" name="phone" autocomplete="tel">
```

### 1.4 Distinguishable

#### 1.4.1 Use of Color (Level A)
- [ ] Color not sole means of conveying information
- [ ] Links distinguishable without color

#### 1.4.2 Audio Control (Level A)
- [ ] Auto-playing audio can be paused/stopped

#### 1.4.3 Contrast (Minimum) (Level AA)
- [ ] Text contrast ratio ≥ 4.5:1
- [ ] Large text contrast ratio ≥ 3:1

#### 1.4.4 Resize Text (Level AA)
- [ ] Text can resize to 200% without loss

#### 1.4.5 Images of Text (Level AA)
- [ ] Real text used instead of images of text

#### 1.4.10 Reflow (Level AA)
- [ ] Content reflows at 320px width
- [ ] No horizontal scrolling at 400% zoom

#### 1.4.11 Non-text Contrast (Level AA)
- [ ] UI components have 3:1 contrast ratio
- [ ] Graphics have 3:1 contrast ratio

#### 1.4.12 Text Spacing (Level AA)
- [ ] Content adapts to custom text spacing

#### 1.4.13 Content on Hover/Focus (Level AA)
- [ ] Hover/focus content is dismissible
- [ ] Hover/focus content is hoverable
- [ ] Hover/focus content is persistent

## Principle 2: Operable

### 2.1 Keyboard Accessible

#### 2.1.1 Keyboard (Level A)
- [ ] All functionality available via keyboard
- [ ] No keyboard shortcuts override browser/AT

#### 2.1.2 No Keyboard Trap (Level A)
- [ ] Focus can move away from all components
- [ ] Instructions provided if non-standard keys needed

#### 2.1.4 Character Key Shortcuts (Level A)
- [ ] Single character shortcuts can be turned off/remapped

### 2.2 Enough Time

#### 2.2.1 Timing Adjustable (Level A)
- [ ] Time limits can be adjusted/extended
- [ ] Users warned before timeout

#### 2.2.2 Pause, Stop, Hide (Level A)
- [ ] Moving content can be paused
- [ ] Auto-updating content can be paused

### 2.3 Seizures and Physical Reactions

#### 2.3.1 Three Flashes or Below (Level A)
- [ ] Nothing flashes more than 3 times/second

### 2.4 Navigable

#### 2.4.1 Bypass Blocks (Level A)
- [ ] Skip to main content link provided

```html
<a href="#main" class="skip-link">Skip to main content</a>
```

#### 2.4.2 Page Titled (Level A)
- [ ] Pages have descriptive titles

#### 2.4.3 Focus Order (Level A)
- [ ] Focus order is logical and intuitive

#### 2.4.4 Link Purpose (In Context) (Level A)
- [ ] Link text describes destination

#### 2.4.5 Multiple Ways (Level AA)
- [ ] Multiple ways to find pages (nav, search, sitemap)

#### 2.4.6 Headings and Labels (Level AA)
- [ ] Headings and labels are descriptive

#### 2.4.7 Focus Visible (Level AA)
- [ ] Focus indicator is visible

```css
:focus {
  outline: 2px solid #0066cc;
  outline-offset: 2px;
}
```

### 2.5 Input Modalities

#### 2.5.1 Pointer Gestures (Level A)
- [ ] Multi-point gestures have single-point alternatives

#### 2.5.2 Pointer Cancellation (Level A)
- [ ] Actions can be cancelled/undone

#### 2.5.3 Label in Name (Level A)
- [ ] Visible label matches accessible name

#### 2.5.4 Motion Actuation (Level A)
- [ ] Motion-triggered functions can be disabled

## Principle 3: Understandable

### 3.1 Readable

#### 3.1.1 Language of Page (Level A)
- [ ] Page language is declared

```html
<html lang="en">
```

#### 3.1.2 Language of Parts (Level AA)
- [ ] Language changes are marked

```html
<p>The French word <span lang="fr">bonjour</span> means hello.</p>
```

### 3.2 Predictable

#### 3.2.1 On Focus (Level A)
- [ ] Focus doesn't trigger context change

#### 3.2.2 On Input (Level A)
- [ ] Input doesn't auto-submit without warning

#### 3.2.3 Consistent Navigation (Level AA)
- [ ] Navigation is consistent across pages

#### 3.2.4 Consistent Identification (Level AA)
- [ ] Components with same function identified consistently

### 3.3 Input Assistance

#### 3.3.1 Error Identification (Level A)
- [ ] Errors are identified and described

#### 3.3.2 Labels or Instructions (Level A)
- [ ] Form inputs have labels/instructions

#### 3.3.3 Error Suggestion (Level AA)
- [ ] Error corrections are suggested

#### 3.3.4 Error Prevention (Level AA)
- [ ] Legal/financial submissions are reversible/confirmable

## Principle 4: Robust

### 4.1 Compatible

#### 4.1.1 Parsing (Level A)
- [ ] HTML is valid (no duplicate IDs)

#### 4.1.2 Name, Role, Value (Level A)
- [ ] Custom components have proper ARIA

```html
<!-- Custom button -->
<div role="button" tabindex="0" aria-pressed="false">
  Toggle
</div>

<!-- Custom checkbox -->
<div role="checkbox" tabindex="0" aria-checked="true">
  Option
</div>
```

#### 4.1.3 Status Messages (Level AA)
- [ ] Status messages use ARIA live regions

```html
<div role="status" aria-live="polite">
  Form submitted successfully
</div>

<div role="alert" aria-live="assertive">
  Error: Please fix the following issues
</div>
```
