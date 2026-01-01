---
name: check
description: "**Run before commits and PRs**. Comprehensive validation: lint, type-check, test, security scan. Delegates to: devops. Activates for: validate, check code, pre-commit."
argument-hint: "[--fix] [--quick] [--strict]"
delegates-to: devops
operation: validate
---

# check - Unified Validation Command

Run comprehensive validation on the current project.

## Usage

```
check [--fix] [--quick] [--strict]
```

## Options

| Option     | Description                                       |
| ---------- | ------------------------------------------------- |
| `--fix`    | Auto-fix issues where possible (lint, format)     |
| `--quick`  | Skip slow checks (full test suite, security scan) |
| `--strict` | Fail on warnings, not just errors                 |

## What This Does

This command delegates to the devops skill for validation operations:

1. **Code Formatting** - Check/fix code formatting (prettier, black, gofmt)
2. **Linting** - Run project linters (eslint, flake8, golint)
3. **Type Checking** - Static type analysis (tsc, mypy, pyright)
4. **Test Suite** - Run automated tests with coverage
5. **Security Scan** - Dependency audit and secret detection (unless --quick)

## Validation Pipeline

```
┌─────────────────────────────────────────────────────────────┐
│  check Validation Pipeline                              │
├─────────────────────────────────────────────────────────────┤
│  [1/5] Formatting      prettier/black/gofmt                 │
│  [2/5] Linting         eslint/flake8/golint                 │
│  [3/5] Type Check      tsc/mypy/pyright                     │
│  [4/5] Tests           jest/pytest/go test                  │
│  [5/5] Security        npm audit/pip-audit (unless --quick) │
└─────────────────────────────────────────────────────────────┘
```

## Examples

```bash
check                    # Full validation
check --fix              # Auto-fix formatting and lint issues
check --quick            # Skip security scan and run fast tests only
check --strict           # Treat warnings as errors
check --fix --quick      # Quick validation with auto-fix
```

## Output Format

```
╔══════════════════════════════════════════════════════════════╗
║  check Results                                            ║
╠══════════════════════════════════════════════════════════════╣
║  ✓ Formatting      PASS                                       ║
║  ✓ Linting         PASS (2 warnings)                          ║
║  ✓ Type Check      PASS                                       ║
║  ✓ Tests           PASS (47/47, 98% coverage)                 ║
║  ✓ Security        PASS                                       ║
╠══════════════════════════════════════════════════════════════╣
║  Status: READY FOR PR                                         ║
╚══════════════════════════════════════════════════════════════╝
```

## Integration

Use before creating pull requests:

```bash
check --fix           # Validate and fix issues
prep-pr               # Then prepare PR
```

## Full Documentation

See `skills/devops/SKILL.md` for complete validation methodology.

## Boundaries

**Will:**

- Run all validation tools configured for the project
- Auto-fix issues when --fix is specified
- Report detailed findings with severity levels
- Detect project type and run appropriate tools

**Will Not:**

- Install missing validation tools automatically
- Modify code beyond auto-fixable formatting/lint issues
- Skip failing tests to produce clean output
