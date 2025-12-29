---
name: build
description: "Build, compile, and package projects - delegates to devops skill"
argument-hint: "[target] [--type dev|prod|test] [--clean] [--optimize]"
delegates-to: devops
operation: build
---

# build - Project Building

Invokes the `devops` skill with the `build` operation.

## Usage
```
build [target] [--type dev|prod|test] [--clean] [--optimize]
```

## What This Does

This command delegates to the devops skill for build operations:

1. **Analyze**: Project structure, build configurations, dependencies
2. **Validate**: Build environment and toolchain
3. **Execute**: Build process with error detection
4. **Optimize**: Artifacts and bundle sizes
5. **Report**: Build metrics and recommendations

## Examples

```bash
build                          # Default project build
build --type prod --clean      # Clean production build
build frontend --optimize      # Build specific target with optimization
```

## Full Documentation

See `skills/devops/SKILL.md` for complete build methodology.

## Boundaries

**Will:**
- Execute builds using project's existing configuration
- Provide error analysis and optimization recommendations
- Generate deployment-ready artifacts

**Will Not:**
- Modify build configuration without authorization
- Install missing dependencies automatically
- Execute deployment operations
