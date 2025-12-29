# E2E Testing Patterns

Patterns for end-to-end testing with Playwright MCP integration.

## Playwright MCP Tools

### Available Tools

| Tool | Purpose |
|------|---------|
| `mcp__playwright__browser_navigate` | Navigate to URL |
| `mcp__playwright__browser_snapshot` | Capture page state |
| `mcp__playwright__browser_click` | Click elements |
| `mcp__playwright__browser_type` | Enter text |
| `mcp__playwright__browser_select_option` | Select dropdown |
| `mcp__playwright__browser_wait` | Wait for conditions |

## Common E2E Patterns

### 1. Page Navigation Pattern

```
1. Navigate to page
2. Wait for load complete
3. Take snapshot to verify state
```

Example workflow:
```
→ mcp__playwright__browser_navigate("https://app.example.com/login")
→ mcp__playwright__browser_snapshot()
→ Verify: Login form visible
```

### 2. Form Submission Pattern

```
1. Navigate to form page
2. Fill form fields
3. Submit form
4. Verify success state
```

Example workflow:
```
→ mcp__playwright__browser_navigate("/register")
→ mcp__playwright__browser_type("[name=email]", "user@example.com")
→ mcp__playwright__browser_type("[name=password]", "SecurePass123!")
→ mcp__playwright__browser_click("[type=submit]")
→ mcp__playwright__browser_snapshot()
→ Verify: Success message or redirect
```

### 3. Authentication Flow Pattern

```
1. Navigate to login
2. Enter credentials
3. Submit
4. Verify authenticated state
5. Navigate protected page
6. Verify access
```

### 4. CRUD Operations Pattern

```
CREATE:
1. Navigate to create page
2. Fill form
3. Submit
4. Verify item created

READ:
1. Navigate to list
2. Verify item visible
3. Click to view details
4. Verify details page

UPDATE:
1. Navigate to edit
2. Modify fields
3. Submit
4. Verify changes saved

DELETE:
1. Navigate to item
2. Click delete
3. Confirm deletion
4. Verify item removed
```

### 5. Multi-Step Wizard Pattern

```
1. Start wizard
2. Complete step 1 → Next
3. Complete step 2 → Next
4. Complete step 3 → Submit
5. Verify completion
```

## Selector Strategies

### Priority Order (Best to Worst)

1. **Data attributes** (most stable)
   ```
   [data-testid="submit-button"]
   [data-cy="login-form"]
   ```

2. **ARIA roles/labels** (accessible)
   ```
   role=button[name="Submit"]
   [aria-label="Close dialog"]
   ```

3. **Text content** (readable)
   ```
   text="Sign In"
   button:has-text("Submit")
   ```

4. **CSS selectors** (common)
   ```
   .login-button
   #submit-form
   ```

5. **XPath** (last resort)
   ```
   //button[@type="submit"]
   ```

## Wait Strategies

### Implicit Waits
```
Wait for element visible
Wait for network idle
Wait for navigation complete
```

### Explicit Waits
```
Wait for specific selector
Wait for text content
Wait for URL change
Wait for response
```

## Error Handling

### Common Failure Modes

| Failure | Cause | Solution |
|---------|-------|----------|
| Element not found | Dynamic content | Wait for element |
| Timeout | Slow network | Increase timeout |
| Stale element | Page rerender | Re-query element |
| Click intercepted | Overlay/modal | Wait for overlay to close |

### Retry Strategy

```
1. Attempt action
2. If fails, wait briefly
3. Retry up to N times
4. Report detailed failure
```

## Test Organization

### Page Object Pattern

```
LoginPage:
  - navigate()
  - enterEmail(email)
  - enterPassword(password)
  - clickSubmit()
  - getErrorMessage()

DashboardPage:
  - navigate()
  - getUserName()
  - clickLogout()
```

### Test Structure

```
describe("User Authentication")
  it("should login with valid credentials")
  it("should show error for invalid password")
  it("should redirect to dashboard after login")
  it("should logout successfully")
```

## Visual Testing

### Snapshot Comparison

```
1. Take baseline snapshot
2. Run tests
3. Take new snapshot
4. Compare for differences
5. Flag visual regressions
```

### Critical Visual Elements

- Layout consistency
- Color/theme accuracy
- Responsive breakpoints
- Loading states
- Error states

## Performance Considerations

### Test Speed Optimization

1. **Parallel execution** - Run independent tests concurrently
2. **State seeding** - Pre-populate test data
3. **API shortcuts** - Use API for setup, UI for test
4. **Selective testing** - Run affected tests only

### Resource Management

```
- Reuse browser context when possible
- Clean up test data after runs
- Close unused pages
- Monitor memory usage
```

## CI/CD Integration

### Headless Mode

```bash
# Run in headless mode for CI
npx playwright test --headed=false
```

### Artifact Collection

```yaml
# Collect screenshots and traces on failure
- name: Upload test artifacts
  uses: actions/upload-artifact@v3
  if: failure()
  with:
    name: playwright-report
    path: playwright-report/
```
