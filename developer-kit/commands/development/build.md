---
name: build
description: "Build, compile, and package projects - delegates to devops skill"
argument-hint: "[target] [--type dev|prod|test] [--clean] [--optimize] [--ci]"
delegates-to: devops
operation: build
---

# build - Project Building

Build, compile, and package projects with automatic build system detection and CI/CD integration.

## Usage

```bash
build [target] [options]
```

## Arguments

| Argument | Description                                           |
| -------- | ----------------------------------------------------- |
| `target` | Specific build target (e.g., frontend, backend, docs) |

## Options

| Option          | Default | Description                              |
| --------------- | ------- | ---------------------------------------- |
| `--type <type>` | dev     | Build type: dev, prod, test, or staging  |
| `--clean`       | false   | Clean build artifacts before building    |
| `--optimize`    | false   | Enable production optimizations          |
| `--ci`          | false   | CI mode (non-interactive, strict errors) |
| `--cache`       | true    | Use build cache                          |
| `--parallel`    | true    | Enable parallel builds                   |
| `--watch`       | false   | Watch mode for development               |
| `--analyze`     | false   | Generate bundle analysis report          |

## What This Does

### 1. Build System Detection

```
Detect project type:
├── package.json      → Node.js (npm/yarn/pnpm)
├── pyproject.toml    → Python (poetry/pip)
├── Cargo.toml        → Rust (cargo)
├── go.mod            → Go (go build)
├── *.csproj          → C# / .NET (dotnet)
├── *.sln             → .NET Solution (dotnet/msbuild)
├── build.gradle      → Java/Kotlin (Gradle)
├── pom.xml           → Java (Maven)
├── Gemfile           → Ruby (bundler)
├── composer.json     → PHP (composer)
├── Makefile          → Make
└── Dockerfile        → Container build
```

> **Note**: The examples below are illustrative. This skill auto-detects your project type and adapts to **any language or framework** by analyzing project files, using Context7 for framework-specific patterns, and invoking appropriate tooling.

### 2. Environment Validation

```
Validate build environment:
├── Check required tools installed
├── Verify dependency versions
├── Validate configuration files
└── Check disk space and resources
```

### 3. Build Execution

```
Execute build pipeline:
├── Install/update dependencies
├── Run pre-build hooks
├── Compile source code
├── Run post-build hooks
└── Generate artifacts
```

### 4. Optimization & Analysis

```
Optimize and analyze:
├── Tree shaking (unused code removal)
├── Minification and compression
├── Bundle size analysis
└── Performance metrics
```

## Build Types

### Development (--type dev)

Fast builds for local development.

```bash
build --type dev
```

- Source maps enabled
- No minification
- Hot reload support
- Debug symbols included

### Production (--type prod)

Optimized builds for deployment.

```bash
build --type prod --optimize
```

- Full minification
- Tree shaking
- Asset hashing
- Source maps separate

### Test (--type test)

Builds for running tests.

```bash
build --type test
```

- Coverage instrumentation
- Test utilities included
- Mock dependencies

### Staging (--type staging)

Production-like builds for staging.

```bash
build --type staging
```

- Production optimizations
- Staging environment config
- Debug logging enabled

## Build System Examples

### Node.js / TypeScript

```bash
# Detected: package.json
build                           # npm run build
build --type prod              # npm run build:prod
build frontend --watch         # npm run build:frontend -- --watch
```

Build commands detected:

```json
{
  "scripts": {
    "build": "tsc && vite build",
    "build:prod": "NODE_ENV=production vite build",
    "build:frontend": "vite build --config vite.config.ts"
  }
}
```

### Python

```bash
# Detected: pyproject.toml
build                          # poetry build
build --type prod             # poetry build --format wheel
build docs                     # mkdocs build
```

### Rust

```bash
# Detected: Cargo.toml
build                          # cargo build
build --type prod --optimize   # cargo build --release
build --target wasm32          # cargo build --target wasm32-unknown-unknown
```

### Go

```bash
# Detected: go.mod
build                          # go build ./...
build --type prod             # CGO_ENABLED=0 go build -ldflags="-s -w" ./...
build cmd/server              # go build ./cmd/server
```

### Docker

```bash
# Detected: Dockerfile
build                          # docker build -t app:latest .
build --type prod             # docker build --target production -t app:prod .
build --ci                     # docker build --no-cache --pull .
```

### C# / .NET

```bash
# Detected: *.csproj or *.sln
build                          # dotnet build
build --type prod             # dotnet build -c Release
build --type prod --optimize   # dotnet publish -c Release -o ./publish
build backend                  # dotnet build ./src/Backend/Backend.csproj
```

Build configurations:

```xml
<!-- MyApp.csproj -->
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
    <OutputType>Exe</OutputType>
    <Nullable>enable</Nullable>
    <ImplicitUsings>enable</ImplicitUsings>
  </PropertyGroup>
</Project>
```

Common commands:

```bash
# Restore dependencies
dotnet restore

# Build specific configuration
dotnet build -c Debug
dotnet build -c Release

# Publish for deployment
dotnet publish -c Release -r win-x64 --self-contained
dotnet publish -c Release -r linux-x64 --self-contained

# Clean build artifacts
dotnet clean
```

### Java (Maven)

```bash
# Detected: pom.xml
build                          # mvn compile
build --type prod             # mvn package -DskipTests
build --type test              # mvn test-compile
build --clean                  # mvn clean compile
```

Build configuration:

```xml
<!-- pom.xml -->
<project>
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.example</groupId>
  <artifactId>my-app</artifactId>
  <version>1.0.0</version>
  <packaging>jar</packaging>

  <properties>
    <maven.compiler.source>21</maven.compiler.source>
    <maven.compiler.target>21</maven.compiler.target>
  </properties>

  <build>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-compiler-plugin</artifactId>
        <version>3.11.0</version>
      </plugin>
    </plugins>
  </build>
</project>
```

Common commands:

```bash
# Full build lifecycle
mvn clean install

# Skip tests for faster builds
mvn package -DskipTests

# Build specific module
mvn -pl module-name compile

# Generate executable JAR
mvn package shade:shade
```

### Java (Gradle)

```bash
# Detected: build.gradle or build.gradle.kts
build                          # ./gradlew build
build --type prod             # ./gradlew build -Pprofile=prod
build --type test              # ./gradlew testClasses
build --clean                  # ./gradlew clean build
```

Build configuration:

```kotlin
// build.gradle.kts
plugins {
    java
    application
}

java {
    toolchain {
        languageVersion.set(JavaLanguageVersion.of(21))
    }
}

application {
    mainClass.set("com.example.Main")
}

tasks.jar {
    manifest {
        attributes["Main-Class"] = "com.example.Main"
    }
}
```

Common commands:

```bash
# Build with Gradle wrapper
./gradlew build

# Continuous build (watch mode)
./gradlew build --continuous

# Build specific subproject
./gradlew :subproject:build

# Create distribution
./gradlew distZip
```

### Ruby

```bash
# Detected: Gemfile
build                          # bundle exec rake build
build --type prod             # RAILS_ENV=production bundle exec rake assets:precompile
build assets                   # bundle exec rake assets:compile
```

### PHP

```bash
# Detected: composer.json
build                          # composer install && npm run build
build --type prod             # composer install --no-dev --optimize-autoloader
build --clean                  # rm -rf vendor && composer install
```

## CI/CD Integration

### GitHub Actions

```yaml
# .github/workflows/build.yml
name: Build
on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: "20"
          cache: "npm"

      - name: Install dependencies
        run: npm ci

      - name: Build
        run: npm run build
        # Equivalent to: build --type prod --ci

      - name: Upload artifacts
        uses: actions/upload-artifact@v4
        with:
          name: build
          path: dist/
```

### GitLab CI

```yaml
# .gitlab-ci.yml
stages:
  - build

build:
  stage: build
  image: node:20
  cache:
    paths:
      - node_modules/
  script:
    - npm ci
    - npm run build
    # Equivalent to: build --type prod --ci
  artifacts:
    paths:
      - dist/
    expire_in: 1 week
```

### CircleCI

```yaml
# .circleci/config.yml
version: 2.1

jobs:
  build:
    docker:
      - image: cimg/node:20.0
    steps:
      - checkout
      - restore_cache:
          keys:
            - v1-deps-{{ checksum "package-lock.json" }}
      - run: npm ci
      - save_cache:
          paths:
            - node_modules
          key: v1-deps-{{ checksum "package-lock.json" }}
      - run: npm run build
      - persist_to_workspace:
          root: .
          paths:
            - dist

workflows:
  build-test-deploy:
    jobs:
      - build
```

### Jenkins

```groovy
// Jenkinsfile
pipeline {
    agent any

    stages {
        stage('Install') {
            steps {
                sh 'npm ci'
            }
        }

        stage('Build') {
            steps {
                sh 'npm run build'
                // Equivalent to: build --type prod --ci
            }
        }

        stage('Archive') {
            steps {
                archiveArtifacts artifacts: 'dist/**/*'
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
```

### Azure Pipelines

```yaml
# azure-pipelines.yml
trigger:
  - main

pool:
  vmImage: "ubuntu-latest"

steps:
  - task: NodeTool@0
    inputs:
      versionSpec: "20.x"
    displayName: "Install Node.js"

  - script: npm ci
    displayName: "Install dependencies"

  - script: npm run build
    displayName: "Build"
    # Equivalent to: build --type prod --ci

  - task: PublishBuildArtifacts@1
    inputs:
      pathToPublish: "dist"
      artifactName: "build"
```

## Output Examples

### Successful Build

```
══════════════════════════════════════════════════════════
  Build: my-project
══════════════════════════════════════════════════════════

Type: Production
Target: All

──────────────────────────────────────────────────────────
  Build Pipeline
──────────────────────────────────────────────────────────

[1/5] Cleaning previous artifacts...
      ✓ Removed dist/ (3.2 MB)

[2/5] Installing dependencies...
      ✓ npm ci completed (12.4s)
      ✓ 847 packages installed

[3/5] Running pre-build hooks...
      ✓ lint passed
      ✓ type-check passed

[4/5] Compiling...
      ✓ TypeScript compiled (4.2s)
      ✓ Vite bundled (8.1s)

[5/5] Post-build optimization...
      ✓ Minified JavaScript (-42%)
      ✓ Compressed assets (gzip)
      ✓ Generated source maps

──────────────────────────────────────────────────────────
  Build Artifacts
──────────────────────────────────────────────────────────

  dist/
  ├── index.html          2.4 KB
  ├── assets/
  │   ├── index-a1b2c3.js   142 KB (gzip: 45 KB)
  │   ├── vendor-d4e5f6.js  384 KB (gzip: 122 KB)
  │   └── style-g7h8i9.css   28 KB (gzip: 6 KB)
  └── Total: 556 KB (gzip: 173 KB)

──────────────────────────────────────────────────────────
  Build Metrics
──────────────────────────────────────────────────────────

  Duration:     24.7s
  Cache Hit:    78%
  Bundle Size:  556 KB (-12% from last build)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Build completed successfully
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Build with Errors

```
══════════════════════════════════════════════════════════
  Build: my-project
══════════════════════════════════════════════════════════

Type: Production
Target: All

──────────────────────────────────────────────────────────
  Build Pipeline
──────────────────────────────────────────────────────────

[1/5] Cleaning previous artifacts...
      ✓ Removed dist/

[2/5] Installing dependencies...
      ✓ npm ci completed

[3/5] Running pre-build hooks...
      ✓ lint passed
      ✗ type-check failed

──────────────────────────────────────────────────────────
  Errors
──────────────────────────────────────────────────────────

TypeScript Error (TS2322):
  src/components/Button.tsx:15:5
  Type 'string' is not assignable to type 'number'.

    14 |   const handleClick = () => {
  > 15 |     setCount("invalid");
       |     ^
    16 |   };

TypeScript Error (TS2304):
  src/utils/helpers.ts:8:10
  Cannot find name 'unknownFunction'.

──────────────────────────────────────────────────────────
  Recommendations
──────────────────────────────────────────────────────────

1. Fix type error in Button.tsx:15 - use number instead of string
2. Import or define 'unknownFunction' in helpers.ts
3. Run 'check --type' to validate all type errors

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Build failed with 2 errors
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Bundle Analysis (--analyze)

```
══════════════════════════════════════════════════════════
  Bundle Analysis: my-project
══════════════════════════════════════════════════════════

──────────────────────────────────────────────────────────
  Size Breakdown
──────────────────────────────────────────────────────────

  Total: 556 KB (gzip: 173 KB)

  By Category:
  ├── Application Code    142 KB  (25.5%)
  ├── node_modules        384 KB  (69.1%)
  ├── Styles               28 KB  (5.0%)
  └── Other                 2 KB  (0.4%)

──────────────────────────────────────────────────────────
  Largest Dependencies
──────────────────────────────────────────────────────────

  Package              Size      % of Bundle
  ───────────────────────────────────────────
  react-dom           128 KB    23.0%
  lodash               72 KB    12.9%
  moment               67 KB    12.1%
  axios                29 KB     5.2%
  react                 8 KB     1.4%

──────────────────────────────────────────────────────────
  Optimization Suggestions
──────────────────────────────────────────────────────────

  ⚠ Consider replacing 'moment' with 'date-fns' (-60 KB)
  ⚠ Import only needed lodash functions (-45 KB)
  ✓ Tree shaking is enabled
  ✓ Code splitting is configured

  Potential savings: ~105 KB (19%)
```

## Caching Strategies

### Local Cache

```bash
# Use build cache (default)
build

# Skip cache for clean build
build --clean --no-cache
```

### CI Cache Configuration

| CI Platform     | Cache Key Strategy                                               |
| --------------- | ---------------------------------------------------------------- |
| GitHub Actions  | `${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}` |
| GitLab CI       | `node_modules/` with TTL                                         |
| CircleCI        | `v1-deps-{{ checksum "package-lock.json" }}`                     |
| Azure Pipelines | Pipeline caching with key hash                                   |

## Error Handling

### Common Build Errors

| Error                        | Cause              | Solution                                                       |
| ---------------------------- | ------------------ | -------------------------------------------------------------- |
| `ENOENT: no such file`       | Missing dependency | Run `npm install` or `build --clean`                           |
| `TS2307: Cannot find module` | Missing types      | Install `@types/*` package                                     |
| `ENOMEM: not enough memory`  | Large bundle       | Increase Node memory: `NODE_OPTIONS=--max_old_space_size=4096` |
| `ENOSPC: no space left`      | Disk full          | Clean artifacts: `build --clean`                               |

### CI-Specific Issues

| Issue             | Platform       | Solution                                 |
| ----------------- | -------------- | ---------------------------------------- |
| Cache miss        | All            | Verify cache key includes lock file hash |
| Timeout           | GitHub Actions | Increase `timeout-minutes`               |
| Permission denied | Docker         | Check file ownership in Dockerfile       |
| Out of memory     | CI             | Use larger runner or optimize build      |

## Workflow Integration

```
check                # Validate before build
    ↓
build --type dev     # Development build
    ↓
test                 # Run tests
    ↓
build --type prod    # Production build
    ↓
ship                 # Release
```

## Boundaries

**Will:**

- Detect build system automatically
- Execute builds using project's configuration
- Provide detailed error analysis
- Generate build metrics and reports
- Support multiple build environments

**Will Not:**

- Modify build configuration without explicit request
- Install global dependencies
- Execute deployment operations
- Build without proper project configuration

## Related Commands

- `check` - Validate before building
- `test` - Run tests after build
- `ship` - Release after successful build
- `cleanup` - Remove build artifacts
