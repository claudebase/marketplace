# Build Command - Reference Patterns

## Build System Detection

| File               | Runtime         | Build Command           |
| ------------------ | --------------- | ----------------------- |
| package.json       | Node.js         | npm/yarn/pnpm run build |
| pyproject.toml     | Python (poetry) | poetry build            |
| Cargo.toml         | Rust            | cargo build             |
| go.mod             | Go              | go build ./...          |
| \*.csproj/\*.sln   | .NET            | dotnet build            |
| build.gradle(.kts) | Java/Kotlin     | ./gradlew build         |
| pom.xml            | Java (Maven)    | mvn compile             |
| Gemfile            | Ruby            | bundle exec rake build  |
| composer.json      | PHP             | composer install        |
| Makefile           | Make            | make                    |
| Dockerfile         | Container       | docker build            |

## Build Type Examples

### Node.js / TypeScript

```bash
build                    # npm run build
build --type prod       # npm run build:prod
build frontend --watch  # npm run build:frontend -- --watch
```

### Python

```bash
build                   # poetry build
build --type prod      # poetry build --format wheel
build docs             # mkdocs build
```

### Rust

```bash
build                          # cargo build
build --type prod --optimize  # cargo build --release
```

### Go

```bash
build                   # go build ./...
build --type prod      # CGO_ENABLED=0 go build -ldflags="-s -w"
```

### C# / .NET

```bash
build                   # dotnet build
build --type prod      # dotnet build -c Release
build --optimize       # dotnet publish -c Release -o ./publish
```

```bash
# Common commands
dotnet restore
dotnet build -c Debug
dotnet build -c Release
dotnet publish -c Release -r linux-x64 --self-contained
dotnet clean
```

### Java (Maven)

```bash
build                   # mvn compile
build --type prod      # mvn package -DskipTests
build --clean          # mvn clean compile
```

```bash
# Common commands
mvn clean install
mvn package -DskipTests
mvn -pl module-name compile
```

### Java (Gradle)

```bash
build                   # ./gradlew build
build --type prod      # ./gradlew build -Pprofile=prod
build --clean          # ./gradlew clean build
```

```bash
# Common commands
./gradlew build --continuous
./gradlew :subproject:build
./gradlew distZip
```

### Docker

```bash
build                   # docker build -t app:latest .
build --type prod      # docker build --target production -t app:prod .
build --ci             # docker build --no-cache --pull .
```

## CI/CD Integration

### GitHub Actions

```yaml
name: Build
on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: "20"
          cache: "npm"
      - run: npm ci
      - run: npm run build
      - uses: actions/upload-artifact@v4
        with:
          name: build
          path: dist/
```

### GitLab CI

```yaml
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
  artifacts:
    paths:
      - dist/
    expire_in: 1 week
```

### CircleCI

```yaml
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
      - run: npm run build
      - persist_to_workspace:
          root: .
          paths:
            - dist
```

### Jenkins

```groovy
pipeline {
    agent any
    stages {
        stage('Install') {
            steps { sh 'npm ci' }
        }
        stage('Build') {
            steps { sh 'npm run build' }
        }
        stage('Archive') {
            steps { archiveArtifacts artifacts: 'dist/**/*' }
        }
    }
}
```

### Azure Pipelines

```yaml
trigger:
  - main

pool:
  vmImage: "ubuntu-latest"

steps:
  - task: NodeTool@0
    inputs:
      versionSpec: "20.x"
  - script: npm ci
  - script: npm run build
  - task: PublishBuildArtifacts@1
    inputs:
      pathToPublish: "dist"
      artifactName: "build"
```

## Output Examples

### Successful Build

```
Build: my-project
Type: Production | Target: All

Build Pipeline:
[1/5] Cleaning previous artifacts... done
[2/5] Installing dependencies... done (12.4s)
[3/5] Running pre-build hooks... lint passed, type-check passed
[4/5] Compiling... TypeScript (4.2s), Vite bundled (8.1s)
[5/5] Post-build optimization... minified, compressed, source maps

Build Artifacts:
  dist/
  ├── index.html          2.4 KB
  ├── assets/
  │   ├── index-a1b2c3.js   142 KB (gzip: 45 KB)
  │   └── style-g7h8i9.css   28 KB (gzip: 6 KB)
  └── Total: 556 KB (gzip: 173 KB)

Metrics: Duration 24.7s | Cache Hit 78% | Bundle -12%
```

### Build with Errors

```
Build: my-project
Type: Production

Build Pipeline:
[1/5] Cleaning... done
[2/5] Installing... done
[3/5] Pre-build hooks... lint passed, type-check FAILED

Errors:
  src/components/Button.tsx:15:5
  Type 'string' is not assignable to type 'number'.

Recommendations:
  1. Fix type error in Button.tsx:15
  2. Run 'check --type' to validate all type errors
```

### Bundle Analysis

```
Bundle Analysis: my-project
Total: 556 KB (gzip: 173 KB)

By Category:
  Application Code    142 KB (25.5%)
  node_modules        384 KB (69.1%)
  Styles               28 KB (5.0%)

Largest Dependencies:
  react-dom   128 KB (23.0%)
  lodash       72 KB (12.9%)
  moment       67 KB (12.1%)

Suggestions:
  - Replace 'moment' with 'date-fns' (-60 KB)
  - Import only needed lodash functions (-45 KB)
```

## Caching

### CI Cache Keys

| Platform       | Key Strategy                                 |
| -------------- | -------------------------------------------- |
| GitHub Actions | `${{ hashFiles('**/package-lock.json') }}`   |
| GitLab CI      | `node_modules/` with TTL                     |
| CircleCI       | `v1-deps-{{ checksum "package-lock.json" }}` |

## Error Handling

| Error                        | Cause              | Solution                                 |
| ---------------------------- | ------------------ | ---------------------------------------- |
| `ENOENT: no such file`       | Missing dependency | `npm install` or `build --clean`         |
| `TS2307: Cannot find module` | Missing types      | Install `@types/*` package               |
| `ENOMEM: not enough memory`  | Large bundle       | `NODE_OPTIONS=--max_old_space_size=4096` |
| `ENOSPC: no space left`      | Disk full          | `build --clean`                          |
