---
name: cleanup
description: "Code cleanup and dead code removal - delegates to devops skill"
argument-hint: "[target] [--type code|imports|files|all] [--safe|--aggressive]"
delegates-to: devops
operation: cleanup
---

# cleanup - Code Cleanup and Dead Code Removal

Systematically clean code, remove unused imports, delete dead code, and eliminate obsolete files with safety validation.

## Usage

```bash
cleanup [target] [options]
```

## Arguments

| Argument | Description                                         |
| -------- | --------------------------------------------------- |
| `target` | Specific directory or file to clean (default: src/) |

## Options

| Option              | Default | Description                             |
| ------------------- | ------- | --------------------------------------- |
| `--type <type>`     | all     | Cleanup type: code, imports, files, all |
| `--safe`            | true    | Conservative cleanup with validation    |
| `--aggressive`      | false   | Aggressive cleanup (requires review)    |
| `--dry-run`         | false   | Preview changes without applying        |
| `--backup`          | true    | Create backup before cleanup            |
| `--exclude <paths>` | -       | Paths to exclude from cleanup           |
| `--report`          | false   | Generate detailed cleanup report        |

## What This Does

### 1. Dead Code Detection

```
Analyze codebase for unused code:
├── Unreachable code paths
├── Unused functions and methods
├── Dead variables and constants
├── Commented-out code blocks
└── Deprecated implementations
```

### 2. Import Analysis

```
Identify import issues:
├── Unused imports
├── Duplicate imports
├── Side-effect only imports (preserved)
├── Circular dependencies
└── Missing type imports
```

### 3. File Cleanup

```
Find obsolete files:
├── Empty or near-empty files
├── Orphaned test files
├── Stale configuration files
├── Backup and temp files
└── Unreferenced assets
```

### 4. Code Quality

```
Improve code hygiene:
├── Remove console.log/print statements
├── Clean TODO/FIXME without tickets
├── Remove debugging artifacts
├── Eliminate empty catch blocks
└── Fix trailing whitespace
```

## Cleanup Types

### Code Cleanup (--type code)

Remove dead and unreachable code.

```bash
cleanup src/ --type code --safe
```

**Targets:**

- Unused functions and methods
- Unreachable code after return/throw
- Dead conditional branches
- Unused class properties
- Obsolete type definitions

### Import Cleanup (--type imports)

Remove unused and duplicate imports.

```bash
cleanup --type imports
```

**Targets:**

- Unused named imports
- Unused default imports
- Duplicate import statements
- Redundant namespace imports
- Missing type-only imports

### File Cleanup (--type files)

Remove obsolete and orphaned files.

```bash
cleanup --type files --dry-run
```

**Targets:**

- Empty source files
- Orphaned test files (no corresponding source)
- Stale generated files
- Backup files (_.bak, _.orig)
- Temporary files

### Comprehensive Cleanup (--type all)

Perform all cleanup operations.

```bash
cleanup --type all --safe
```

## Safety Levels

### Safe Mode (Default)

Conservative cleanup with maximum safety.

```bash
cleanup --safe
```

**Behavior:**

- Only removes obviously unused code
- Preserves code with any potential references
- Skips files with `@preserve` or `@keep` comments
- Validates changes with type checking
- Creates automatic backup

**Preserved:**

- Exported functions (may be used externally)
- Public API surface
- Event handlers and callbacks
- Framework lifecycle methods
- Dynamic imports

### Aggressive Mode

Thorough cleanup with manual review.

```bash
cleanup --aggressive
```

**Behavior:**

- Removes code without direct references
- Cleans commented-out code blocks
- Removes console statements
- Cleans empty error handlers
- Requires explicit confirmation

**Review Required:**

- Exported but unused functions
- Potentially dynamic references
- Test-only utilities
- Debug helpers

## Language-Specific Patterns

> **Note**: The examples below are illustrative. This skill auto-detects your project type and adapts to **any language or framework** by analyzing project files, using Context7 for framework-specific patterns, and invoking appropriate tooling (Roslyn analyzers for C#, SpotBugs for Java, etc.).

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

  // Unreachable code
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
# BEFORE: Unused imports and dead code
import os
import sys
from typing import List, Dict, Optional, Union  # Union unused
from utils import helper, unused_helper
import deprecated_module  # Never used

UNUSED_CONSTANT = "never used"

def unused_function():
    """This function is never called."""
    return "dead code"

def used_function(items: List[str]) -> Dict[str, int]:
    result = {}
    for item in items:
        result[item] = helper(item)
    return result
```

```python
# AFTER: Clean imports and code
from typing import List, Dict
from utils import helper

def used_function(items: List[str]) -> Dict[str, int]:
    result = {}
    for item in items:
        result[item] = helper(item)
    return result
```

### Go

```go
// BEFORE: Unused imports and variables
package main

import (
    "fmt"
    "os"      // unused
    "strings" // unused
)

const unusedConstant = "never used"

func unusedFunction() string {
    return "dead code"
}

func main() {
    message := "Hello"
    unused := "never read" // unused variable
    fmt.Println(message)
}
```

```go
// AFTER: Clean code
package main

import "fmt"

func main() {
    message := "Hello"
    fmt.Println(message)
}
```

### C# / .NET

```csharp
// BEFORE: Unused imports and dead code
using System;
using System.Collections.Generic;
using System.Linq;           // unused
using System.Threading.Tasks; // unused
using Newtonsoft.Json;        // unused

namespace MyApp
{
    public class UserService
    {
        private readonly string _unusedField = "never read";
        private readonly ILogger _logger;

        private void UnusedMethod()
        {
            Console.WriteLine("dead code");
        }

        public User GetUser(int id)
        {
            return _repository.Find(id);
        }
    }
}
```

```csharp
// AFTER: Clean code
using System;
using System.Collections.Generic;

namespace MyApp
{
    public class UserService
    {
        private readonly ILogger _logger;

        public User GetUser(int id)
        {
            return _repository.Find(id);
        }
    }
}
```

Roslyn analyzer codes:

```
IDE0051: Remove unused private members
IDE0052: Remove unread private members
CS0169: Field is never used
CS0414: Field assigned but never used
CS8019: Unnecessary using directive
```

### Java

```java
// BEFORE: Unused imports and dead code
import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;     // unused
import java.util.stream.*;    // unused
import org.apache.commons.lang3.StringUtils; // unused

public class UserService {
    private static final String UNUSED_CONSTANT = "never used";
    private String unusedField;

    private void unusedMethod() {
        System.out.println("dead code");
    }

    public User getUser(int id) {
        return repository.findById(id);
    }
}
```

```java
// AFTER: Clean code
import java.util.List;
import java.util.ArrayList;

public class UserService {
    public User getUser(int id) {
        return repository.findById(id);
    }
}
```

Common dead code warnings:

```
// IntelliJ IDEA / SpotBugs / PMD
UPM_UNCALLED_PRIVATE_METHOD: Uncalled private method
URF_UNREAD_FIELD: Unread field
DLS_DEAD_LOCAL_STORE: Dead store to local variable
UC_USELESS_CONDITION: Useless condition (always true/false)
```

### Ruby

```ruby
# BEFORE: Unused requires and dead code
require 'json'
require 'yaml'      # unused
require 'net/http'  # unused

UNUSED_CONSTANT = 'never used'.freeze

def unused_method
  puts 'dead code'
end

def fetch_user(id)
  User.find(id)
end
```

```ruby
# AFTER: Clean code
require 'json'

def fetch_user(id)
  User.find(id)
end
```

### PHP

```php
<?php
// BEFORE: Unused imports and dead code
use App\Models\User;
use App\Models\Order;      // unused
use Illuminate\Support\Str; // unused

class UserController
{
    private $unusedProperty;

    private function unusedMethod()
    {
        return 'dead code';
    }

    public function show($id)
    {
        return User::find($id);
    }
}
```

```php
<?php
// AFTER: Clean code
use App\Models\User;

class UserController
{
    public function show($id)
    {
        return User::find($id);
    }
}
```

## Detection Tools Integration

### ESLint (JavaScript/TypeScript)

```json
{
  "rules": {
    "no-unused-vars": "error",
    "no-unreachable": "error",
    "no-dead-code": "error",
    "@typescript-eslint/no-unused-vars": "error"
  }
}
```

### Pylint/Flake8 (Python)

```ini
# .flake8
[flake8]
select = F401,F841,W503
# F401: imported but unused
# F841: local variable assigned but never used
```

### Go Vet

```bash
# Built-in dead code detection
go vet ./...
go build  # Compilation fails on unused imports
```

### Rust

```toml
# Cargo.toml - warnings as errors
[profile.dev]
# Compiler warns about dead code by default
```

```bash
cargo clippy -- -D dead_code
```

### C# / .NET (Roslyn Analyzers)

```xml
<!-- .editorconfig -->
[*.cs]
dotnet_diagnostic.IDE0051.severity = error  # Unused private members
dotnet_diagnostic.IDE0052.severity = error  # Unread private members
dotnet_diagnostic.CS8019.severity = error   # Unnecessary using
```

```bash
# Run analyzers
dotnet build /p:TreatWarningsAsErrors=true

# Use dotnet-format for auto-cleanup
dotnet format analyzers --diagnostics IDE0051 IDE0052
```

### Java (SpotBugs / PMD)

```xml
<!-- pom.xml - SpotBugs plugin -->
<plugin>
  <groupId>com.github.spotbugs</groupId>
  <artifactId>spotbugs-maven-plugin</artifactId>
  <version>4.8.0</version>
  <configuration>
    <effort>Max</effort>
    <threshold>Low</threshold>
  </configuration>
</plugin>
```

```bash
# Run SpotBugs
mvn spotbugs:check

# Run PMD
mvn pmd:check
```

## Output Examples

### Dry Run Preview

```
══════════════════════════════════════════════════════════
  Cleanup Preview: my-project (Dry Run)
══════════════════════════════════════════════════════════

Mode: Safe
Target: src/

──────────────────────────────────────────────────────────
  Unused Imports (23 found)
──────────────────────────────────────────────────────────

  src/components/Button.tsx:2
    - import { useCallback } from 'react';

  src/components/Card.tsx:3
    - import { motion } from 'framer-motion';

  src/utils/helpers.ts:1
    - import lodash from 'lodash';

  ... and 20 more

──────────────────────────────────────────────────────────
  Dead Code (8 found)
──────────────────────────────────────────────────────────

  src/utils/legacy.ts:15-28
    ✗ Function 'oldHelper' has no references

  src/components/deprecated/Modal.tsx:1-45
    ✗ Entire file unreferenced

  src/constants.ts:12
    ✗ Constant 'OLD_API_URL' unused

──────────────────────────────────────────────────────────
  Files to Remove (3 found)
──────────────────────────────────────────────────────────

  src/components/deprecated/Modal.tsx     (0 references)
  src/utils/legacy.ts                      (0 references)
  src/__tests__/legacy.test.ts            (orphaned test)

──────────────────────────────────────────────────────────
  Summary
──────────────────────────────────────────────────────────

  Imports to remove:    23
  Dead code blocks:     8
  Files to delete:      3
  Estimated reduction:  ~1,240 lines

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Run without --dry-run to apply changes
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Successful Cleanup

```
══════════════════════════════════════════════════════════
  Cleanup Complete: my-project
══════════════════════════════════════════════════════════

Mode: Safe
Target: src/
Backup: .cleanup-backup-20250115-143022/

──────────────────────────────────────────────────────────
  Changes Applied
──────────────────────────────────────────────────────────

  ✓ Removed 23 unused imports across 12 files
  ✓ Deleted 8 dead code blocks (312 lines)
  ✓ Removed 3 obsolete files

──────────────────────────────────────────────────────────
  Files Modified
──────────────────────────────────────────────────────────

  src/components/Button.tsx        -3 lines
  src/components/Card.tsx          -5 lines
  src/components/Form.tsx          -2 lines
  src/utils/helpers.ts             -45 lines
  src/constants.ts                 -8 lines
  ... and 7 more files

──────────────────────────────────────────────────────────
  Files Deleted
──────────────────────────────────────────────────────────

  src/components/deprecated/Modal.tsx
  src/utils/legacy.ts
  src/__tests__/legacy.test.ts

──────────────────────────────────────────────────────────
  Validation
──────────────────────────────────────────────────────────

  ✓ TypeScript compilation: passed
  ✓ Test suite: 142 passing
  ✓ No runtime errors detected

──────────────────────────────────────────────────────────
  Metrics
──────────────────────────────────────────────────────────

  Lines removed:    1,240
  Files cleaned:    12
  Files deleted:    3
  Bundle reduction: ~8 KB (estimated)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Cleanup successful. Backup saved for rollback.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Cleanup Report (--report)

```
══════════════════════════════════════════════════════════
  Cleanup Report: my-project
══════════════════════════════════════════════════════════

Generated: 2025-01-15 14:30:22

──────────────────────────────────────────────────────────
  Dead Code Analysis
──────────────────────────────────────────────────────────

  By Type:
  ├── Unused functions:     12 (245 lines)
  ├── Unused variables:     34 (89 lines)
  ├── Unused imports:       23 (23 lines)
  ├── Unreachable code:     5 (67 lines)
  └── Commented code:       8 (156 lines)

  By Directory:
  ├── src/components/       18 items (312 lines)
  ├── src/utils/            9 items (156 lines)
  ├── src/services/         4 items (89 lines)
  └── src/hooks/            2 items (23 lines)

──────────────────────────────────────────────────────────
  Code Quality Issues
──────────────────────────────────────────────────────────

  Console Statements:       15
  Empty Catch Blocks:       3
  TODO/FIXME:               8 (no ticket reference)
  Debug Artifacts:          2

──────────────────────────────────────────────────────────
  Recommendations
──────────────────────────────────────────────────────────

  1. Enable no-unused-vars ESLint rule
  2. Add pre-commit hook for import cleanup
  3. Review src/utils/legacy.ts for removal
  4. Consider deprecation warnings for oldHelper()

──────────────────────────────────────────────────────────
  Skipped (Review Required)
──────────────────────────────────────────────────────────

  src/api/handlers.ts:45
    ⚠ Function 'legacyEndpoint' - exported, may be used

  src/components/Widget.tsx:12
    ⚠ Variable 'DEBUG_MODE' - used in development only

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Framework-Specific Preservation

### React

```javascript
// Preserved: Lifecycle methods and hooks
useEffect(() => {}, []); // Side effect
useMemo(() => value, [deps]); // Memoization
useCallback(() => {}, []); // Callback reference

// Preserved: Event handlers (dynamic reference)
const handleClick = () => {}; // Used in JSX

// Preserved: Context and refs
const MyContext = createContext(); // Provider usage
const ref = useRef(); // DOM reference
```

### Angular

```typescript
// Preserved: Decorator-referenced
@Component({...})
export class MyComponent {
  @Input() data: string;           // Template binding
  @Output() change = new EventEmitter();

  ngOnInit() {}                    // Lifecycle hook
  ngOnDestroy() {}                 // Lifecycle hook
}
```

### Vue

```javascript
// Preserved: Options API
export default {
  data() {
    return {};
  }, // Reactive data
  computed: {}, // Computed properties
  methods: {}, // Template methods
  mounted() {}, // Lifecycle hook
};

// Preserved: Composition API
const state = reactive({}); // Reactive state
const computed = computed(() => {}); // Computed
```

### Express/Koa

```javascript
// Preserved: Route handlers
app.get("/api", handler); // Registered route
app.use(middleware); // Middleware chain

// Preserved: Error handlers
app.use((err, req, res, next) => {}); // Error middleware
```

## Exclusion Patterns

### Configuration File (.cleanuprc)

```yaml
# .cleanuprc
exclude:
  - "**/*.test.ts"
  - "**/*.spec.ts"
  - "**/fixtures/**"
  - "**/mocks/**"
  - "src/generated/**"

preserve:
  - "**/__mocks__/**"
  - "**/test-utils/**"

ignore_patterns:
  - "@preserve"
  - "@keep"
  - "istanbul ignore"
  - "c8 ignore"

skip_rules:
  - console_statements # Keep console in this project
```

### Inline Preservation

```javascript
// @preserve - Keep this function for external API
export function publicHelper() {}

/* @keep - Used by reflection */
const META_KEY = Symbol("meta");

// eslint-disable-next-line no-unused-vars
const DEBUG = process.env.DEBUG;
```

## Rollback Procedures

### Automatic Backup

```bash
# Backups stored in .cleanup-backup-{timestamp}/
ls .cleanup-backup-20250115-143022/

# Restore from backup
cp -r .cleanup-backup-20250115-143022/* .
```

### Git-Based Rollback

```bash
# If committed after cleanup
git revert HEAD

# If not committed
git checkout -- .
git clean -fd
```

## Error Handling

### Common Issues

| Issue          | Cause                | Solution                 |
| -------------- | -------------------- | ------------------------ |
| False positive | Dynamic import       | Add to exclude list      |
| Build failure  | Removed needed code  | Rollback, add @preserve  |
| Test failure   | Removed test utility | Exclude test directories |
| Type errors    | Removed type export  | Check downstream usage   |

### Validation Failures

```
══════════════════════════════════════════════════════════
  Cleanup Aborted: Validation Failed
══════════════════════════════════════════════════════════

──────────────────────────────────────────────────────────
  Errors
──────────────────────────────────────────────────────────

  TypeScript Error (after cleanup):
    src/components/Button.tsx:15:5
    Cannot find name 'removedHelper'.

  Test Failure:
    src/__tests__/utils.test.ts
    ReferenceError: deletedFunction is not defined

──────────────────────────────────────────────────────────
  Rollback Applied
──────────────────────────────────────────────────────────

  ✓ Restored from backup
  ✓ Original state preserved

──────────────────────────────────────────────────────────
  Recommendations
──────────────────────────────────────────────────────────

  1. Add 'removedHelper' to preserve list
  2. Check dynamic references in utils.ts
  3. Re-run with --dry-run first

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Workflow Integration

```
analyze              # Identify cleanup opportunities
    ↓
cleanup --dry-run    # Preview changes
    ↓
cleanup --safe       # Apply conservative cleanup
    ↓
check                # Validate build and tests
    ↓
cleanup --aggressive # Optional: deeper cleanup
    ↓
git commit           # Commit changes
```

## Automation

### Pre-Commit Hook

```bash
#!/bin/bash
# .husky/pre-commit

# Auto-fix unused imports on commit
npx eslint --fix --rule 'no-unused-vars: error' .
```

### CI Integration

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
        run: |
          npx ts-prune --error

      - name: Check unused imports
        run: |
          npx eslint . --rule 'no-unused-vars: error'
```

## Boundaries

**Will:**

- Remove obviously unused imports and code
- Detect and flag dead code blocks
- Identify orphaned files
- Preserve framework-specific patterns
- Create backups before modifications
- Validate changes with build/test

**Will Not:**

- Remove exported functions without confirmation
- Delete files with potential dynamic references
- Modify code marked with @preserve comments
- Apply changes that break tests
- Cleanup without analysis phase

## Related Commands

- `analyze` - Identify cleanup opportunities
- `check` - Validate after cleanup
- `git` - Commit cleanup changes
- `build` - Verify build after cleanup
