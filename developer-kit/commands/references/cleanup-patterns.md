# Cleanup Command - Reference Patterns

## Language-Specific Cleanup

### JavaScript/TypeScript

```javascript
// BEFORE: Multiple unused imports and dead code
import React, { useState, useEffect, useCallback } from 'react';
import { unusedHelper, usedHelper } from './utils';
import type { UnusedType, UsedType } from './types';

const UNUSED_CONSTANT = 'never used';

function unusedFunction() {
  return 'dead code';
}

export function Component({ data }: { data: UsedType }) {
  const [count, setCount] = useState(0);
  if (false) {
    console.log('never executed');
  }
  return <div>{usedHelper(data)}</div>;
}
```

```javascript
// AFTER: Clean imports and code
import React, { useState } from 'react';
import { usedHelper } from './utils';
import type { UsedType } from './types';

export function Component({ data }: { data: UsedType }) {
  const [count, setCount] = useState(0);
  return <div>{usedHelper(data)}</div>;
}
```

### Python

```python
# BEFORE
import os, sys
from typing import List, Dict, Optional, Union  # Union unused
from utils import helper, unused_helper

def unused_function():
    return "dead code"

def used_function(items: List[str]) -> Dict[str, int]:
    return {item: helper(item) for item in items}
```

```python
# AFTER
from typing import List, Dict
from utils import helper

def used_function(items: List[str]) -> Dict[str, int]:
    return {item: helper(item) for item in items}
```

### Go

```go
// BEFORE
package main
import (
    "fmt"
    "os"      // unused
    "strings" // unused
)

const unusedConstant = "never used"

func unusedFunction() string { return "dead code" }

func main() {
    message := "Hello"
    unused := "never read"
    fmt.Println(message)
}
```

```go
// AFTER
package main
import "fmt"

func main() {
    message := "Hello"
    fmt.Println(message)
}
```

### C# / .NET

Roslyn analyzer codes:

```
IDE0051: Remove unused private members
IDE0052: Remove unread private members
CS0169: Field is never used
CS8019: Unnecessary using directive
```

### Java

SpotBugs/PMD warnings:

```
UPM_UNCALLED_PRIVATE_METHOD: Uncalled private method
URF_UNREAD_FIELD: Unread field
DLS_DEAD_LOCAL_STORE: Dead store to local variable
```

## Detection Tools

### ESLint (JavaScript/TypeScript)

```json
{
  "rules": {
    "no-unused-vars": "error",
    "no-unreachable": "error",
    "@typescript-eslint/no-unused-vars": "error"
  }
}
```

### Pylint/Flake8 (Python)

```ini
[flake8]
select = F401,F841,W503
# F401: imported but unused
# F841: local variable assigned but never used
```

### Go Vet

```bash
go vet ./...
go build  # Compilation fails on unused imports
```

### Rust

```bash
cargo clippy -- -D dead_code
```

### C# (Roslyn Analyzers)

```bash
dotnet build /p:TreatWarningsAsErrors=true
dotnet format analyzers --diagnostics IDE0051 IDE0052
```

## Framework Preservation

### React

```javascript
// Preserved: Lifecycle methods and hooks
useEffect(() => {}, []);
useMemo(() => value, [deps]);
useCallback(() => {}, []);

// Preserved: Event handlers (dynamic reference)
const handleClick = () => {}; // Used in JSX

// Preserved: Context and refs
const MyContext = createContext();
const ref = useRef();
```

### Angular

```typescript
// Preserved: Decorator-referenced
@Component({...})
export class MyComponent {
  @Input() data: string;
  @Output() change = new EventEmitter();
  ngOnInit() {}
  ngOnDestroy() {}
}
```

### Vue

```javascript
// Preserved: Options API
export default {
  data() {
    return {};
  },
  computed: {},
  methods: {},
  mounted() {},
};

// Preserved: Composition API
const state = reactive({});
const computed = computed(() => {});
```

### Express/Koa

```javascript
// Preserved: Route handlers
app.get("/api", handler);
app.use(middleware);
app.use((err, req, res, next) => {}); // Error middleware
```

## Configuration

### .cleanuprc

```yaml
exclude:
  - "**/*.test.ts"
  - "**/*.spec.ts"
  - "**/fixtures/**"
  - "src/generated/**"

preserve:
  - "**/__mocks__/**"
  - "**/test-utils/**"

ignore_patterns:
  - "@preserve"
  - "@keep"
  - "istanbul ignore"
```

### Inline Preservation

```javascript
// @preserve - Keep this function
export function publicHelper() {}

/* @keep - Used by reflection */
const META_KEY = Symbol("meta");

// eslint-disable-next-line no-unused-vars
const DEBUG = process.env.DEBUG;
```

## Output Examples

### Dry Run Preview

```
Cleanup Preview: my-project (Dry Run)
Mode: Safe | Target: src/

Unused Imports (23 found)
  src/components/Button.tsx:2
    - import { useCallback } from 'react';
  ... and 20 more

Dead Code (8 found)
  src/utils/legacy.ts:15-28
    Function 'oldHelper' has no references

Files to Remove (3 found)
  src/components/deprecated/Modal.tsx (0 references)
  src/utils/legacy.ts (0 references)

Summary: 23 imports, 8 dead blocks, 3 files (~1,240 lines)
```

### Successful Cleanup

```
Cleanup Complete: my-project
Mode: Safe | Backup: .cleanup-backup-20250115/

Changes Applied:
  Removed 23 unused imports across 12 files
  Deleted 8 dead code blocks (312 lines)
  Removed 3 obsolete files

Validation:
  TypeScript compilation: passed
  Test suite: 142 passing

Metrics:
  Lines removed: 1,240 | Files cleaned: 12 | Files deleted: 3
```

## Rollback

```bash
# From backup
cp -r .cleanup-backup-20250115/* .

# Git-based
git checkout -- .
git clean -fd
```

## Error Handling

| Issue          | Cause          | Solution                |
| -------------- | -------------- | ----------------------- |
| False positive | Dynamic import | Add to exclude list     |
| Build failure  | Removed needed | Rollback, add @preserve |
| Test failure   | Removed util   | Exclude test dirs       |

## CI Integration

```yaml
# .github/workflows/cleanup.yml
name: Code Cleanup Check
on: [pull_request]

jobs:
  cleanup-check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Check for dead code
        run: npx ts-prune --error
      - name: Check unused imports
        run: npx eslint . --rule 'no-unused-vars: error'
```
