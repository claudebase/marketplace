# Cleanup Patterns

## Dead Code Detection

### Unused Exports
```bash
# Find unused exports with ts-prune
npx ts-prune

# Or use ESLint
# eslint-plugin-unused-imports
```

### Unused Dependencies
```bash
# Find unused npm packages
npx depcheck

# Output example:
# Unused dependencies: lodash, moment
# Missing dependencies: uuid
```

### Unused Files
```bash
# Find files not imported anywhere
npx unimported
```

## Import Cleanup

### Before
```javascript
import { useState, useEffect, useCallback, useMemo } from 'react';
import lodash from 'lodash';
import moment from 'moment';

function Component() {
  const [count, setCount] = useState(0);
  return <div>{count}</div>;
}
```

### After
```javascript
import { useState } from 'react';

function Component() {
  const [count, setCount] = useState(0);
  return <div>{count}</div>;
}
```

## Safe Cleanup Process

### Step 1: Identify
```bash
# Run analysis tools
npm run lint
npx ts-prune
npx depcheck
```

### Step 2: Verify Usage
```bash
# Search for references
grep -r "functionName" src/
git log -p -S "functionName"  # Historical usage
```

### Step 3: Remove Safely
```bash
# Create backup branch
git checkout -b cleanup/dead-code

# Make changes incrementally
# Test after each change
npm test
```

### Step 4: Validate
```bash
# Run full test suite
npm test

# Build to catch compile errors
npm run build

# Manual smoke test critical paths
```

## Common Cleanup Tasks

### Remove Console Logs
```javascript
// ESLint rule
"no-console": "error"

// Or use babel plugin
// babel-plugin-transform-remove-console
```

### Remove Commented Code
```javascript
// BAD - Don't keep commented code
// const oldFunction = () => { ... };

// GOOD - Delete it, git has history
```

### Simplify Complex Conditions
```javascript
// Before
if (user !== null && user !== undefined && user.isActive === true) {}

// After
if (user?.isActive) {}
```

### Extract Magic Numbers
```javascript
// Before
if (retryCount > 3) {}

// After
const MAX_RETRIES = 3;
if (retryCount > MAX_RETRIES) {}
```

## Cleanup Checklist

- [ ] Remove unused imports
- [ ] Remove unused variables
- [ ] Remove unused functions/methods
- [ ] Remove unused files
- [ ] Remove unused dependencies
- [ ] Remove console.log statements
- [ ] Remove commented code
- [ ] Run linter and fix issues
- [ ] Run tests to verify no breakage
- [ ] Build to verify compilation
