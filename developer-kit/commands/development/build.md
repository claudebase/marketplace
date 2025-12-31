---
name: dk:build
description: "Build, compile, and package projects - delegates to devops skill"
argument-hint: "[target] [--type dev|prod|test] [--clean] [--optimize] [--ci]"
delegates-to: devops
operation: build
---

# build - Project Building

Build, compile, and package projects with automatic build system detection.

## Usage

```bash
build [target] [options]
```

## Arguments

| Argument | Description                                           |
| -------- | ----------------------------------------------------- |
| `target` | Specific build target (e.g., frontend, backend, docs) |

## Options

| Option       | Default | Description                              |
| ------------ | ------- | ---------------------------------------- |
| `--type`     | dev     | Build type: dev, prod, test, staging     |
| `--clean`    | false   | Clean artifacts before building          |
| `--optimize` | false   | Enable production optimizations          |
| `--ci`       | false   | CI mode (non-interactive, strict errors) |
| `--cache`    | true    | Use build cache                          |
| `--parallel` | true    | Enable parallel builds                   |
| `--watch`    | false   | Watch mode for development               |
| `--analyze`  | false   | Generate bundle analysis report          |

## What This Does

1. **Build System Detection** - Auto-detects package.json, Cargo.toml, go.mod, etc.
2. **Environment Validation** - Checks required tools, dependencies, config
3. **Build Execution** - Installs deps, runs pre-build hooks, compiles, generates artifacts
4. **Optimization** - Tree shaking, minification, bundle analysis

## Build Types

| Type      | Command                | Features                            |
| --------- | ---------------------- | ----------------------------------- |
| `dev`     | `build --type dev`     | Source maps, no minification, HMR   |
| `prod`    | `build --type prod`    | Minification, tree shaking, hashing |
| `test`    | `build --type test`    | Coverage instrumentation, mocks     |
| `staging` | `build --type staging` | Production opts + staging config    |

## Examples

```bash
# Development build (default)
build

# Production build with optimizations
build --type prod --optimize

# Clean build
build --clean

# Watch mode for development
build --watch

# CI build (strict, non-interactive)
build --type prod --ci

# Generate bundle analysis
build --type prod --analyze
```

## Supported Build Systems

| File           | Runtime   | Command                 |
| -------------- | --------- | ----------------------- |
| package.json   | Node.js   | npm/yarn/pnpm run build |
| pyproject.toml | Python    | poetry build            |
| Cargo.toml     | Rust      | cargo build             |
| go.mod         | Go        | go build ./...          |
| _.csproj/_.sln | .NET      | dotnet build            |
| build.gradle   | Java      | ./gradlew build         |
| pom.xml        | Maven     | mvn compile             |
| Dockerfile     | Container | docker build            |

## References

- [Build Patterns](../../lib/shared-references/build-patterns.md) - Language examples, CI configs, output formats

## Boundaries

**Will:**

- Detect build system automatically
- Execute builds using project's configuration
- Provide detailed error analysis
- Generate build metrics and reports

**Will Not:**

- Modify build configuration without request
- Install global dependencies
- Execute deployment operations

## Related Commands

- `check` - Validate before building
- `test` - Run tests after build
- `ship` - Release after successful build
- `cleanup` - Remove build artifacts
