# Repository Indexing Reference

Templates and strategies for repository indexing.

## PROJECT_INDEX.md Template

```markdown
# Project Index: [Project Name]

> Generated: [Date] | Framework: [Name] | Language: [Lang]

## Quick Reference

| Metric        | Value  |
| ------------- | ------ |
| Total Files   | X      |
| Code Files    | X      |
| Test Coverage | X%     |
| Last Commit   | [Date] |

## Directory Structure

project-root/
├── src/ # Source code
│ ├── app/ # Next.js app router
│ ├── components/ # React components
│ ├── lib/ # Utilities
│ └── services/ # Business logic
├── tests/ # Test files
├── docs/ # Documentation
└── config/ # Configuration

## Entry Points

| Entry Point | File               | Purpose        |
| ----------- | ------------------ | -------------- |
| Main App    | `src/app/page.tsx` | Homepage       |
| API Routes  | `src/app/api/`     | REST endpoints |
| Middleware  | `middleware.ts`    | Auth, logging  |

## Key Modules

| Module   | Path                 | Files | Responsibility |
| -------- | -------------------- | ----- | -------------- |
| Auth     | `src/lib/auth/`      | 5     | Authentication |
| Database | `src/lib/db/`        | 3     | Data access    |
| UI       | `src/components/ui/` | 24    | UI components  |

## Configuration

| File                 | Purpose          | Environment |
| -------------------- | ---------------- | ----------- |
| `.env`               | Environment vars | All         |
| `next.config.js`     | Next.js config   | Build       |
| `tailwind.config.js` | Styling          | Build       |

## Dependencies (Key)

| Package | Version | Purpose    |
| ------- | ------- | ---------- |
| next    | 14.x    | Framework  |
| prisma  | 5.x     | ORM        |
| zod     | 3.x     | Validation |

## Recent Changes (Last 7 Days)

| Area              | Changes    | Risk Level |
| ----------------- | ---------- | ---------- |
| `src/services/`   | 8 commits  | Medium     |
| `src/components/` | 12 commits | Low        |

## Documentation

| Document     | Path                   | Status         |
| ------------ | ---------------------- | -------------- |
| README       | `README.md`            | ✓ Current      |
| API Docs     | `docs/api.md`          | ⚠ Needs update |
| Architecture | `docs/architecture.md` | ✓ Current      |
```

## PROJECT_INDEX.json Schema

```json
{
  "$schema": "project-index-v1",
  "name": "project-name",
  "framework": {
    "name": "next.js",
    "version": "14.0.0"
  },
  "language": {
    "primary": "typescript",
    "version": "5.x"
  },
  "indexed_at": "2025-01-15T10:00:00Z",
  "structure": {
    "src": ["app", "components", "lib", "services"],
    "tests": ["__tests__", "e2e"],
    "docs": ["api", "architecture"],
    "config": [".env", "next.config.js"]
  },
  "entry_points": [
    { "name": "main", "path": "src/app/page.tsx", "type": "page" },
    { "name": "api", "path": "src/app/api/", "type": "api" }
  ],
  "modules": [
    { "name": "auth", "path": "src/lib/auth/", "files": 5 },
    { "name": "db", "path": "src/lib/db/", "files": 3 }
  ],
  "stats": {
    "total_files": 142,
    "code_files": 98,
    "test_files": 28,
    "doc_files": 16,
    "config_files": 8
  },
  "recent_changes": [
    { "path": "src/services/", "commits": 8, "risk": "medium" }
  ]
}
```

## Indexing Strategies

### Quick Index (Small Projects < 50 files)

```yaml
Time: < 30 seconds

Steps: 1. Single Glob for all files
  2. Quick framework detection
  3. Generate minimal index
  4. Skip detailed module analysis

Output: Compact PROJECT_INDEX.md
```

### Full Index (Medium Projects 50-500 files)

```yaml
Time: 1-2 minutes

Steps: 1. Parallel scans for each area
  2. Framework + pattern detection via Context7
  3. Module boundary analysis
  4. Generate full index + JSON

Output: Complete PROJECT_INDEX.md + PROJECT_INDEX.json
```

### Incremental Index (Large Projects > 500 files)

```yaml
Time: Varies

Steps: 1. Check existing index freshness
  2. Scan only changed directories (git diff)
  3. Update affected sections only
  4. Preserve unchanged sections

Output: Updated index with change markers
```

### Monorepo Index

```yaml
Time: 2-5 minutes

Steps: 1. Identify workspace structure (lerna, nx, turbo)
  2. Index each package separately
  3. Map inter-package dependencies
  4. Generate root index + package indexes

Output: ROOT_INDEX.md + packages/*/PROJECT_INDEX.md
```

## Framework Detection Patterns

```yaml
Node.js:
  - package.json exists
  - Check: react, next, express, fastify, nest

Python:
  - requirements.txt or pyproject.toml
  - Check: django, fastapi, flask

.NET:
  - *.csproj or *.sln
  - Check: Microsoft.AspNetCore.*

Go:
  - go.mod exists
  - Check: gin, echo, fiber

Rust:
  - Cargo.toml exists
  - Check: actix, axum, rocket
```

## Framework Structure Patterns

```yaml
Next.js:
  Expected: app/, pages/, components/, lib/, public/
  Entry: app/layout.tsx, app/page.tsx
  Config: next.config.js, tailwind.config.js

Express:
  Expected: routes/, middleware/, controllers/, models/
  Entry: app.js, server.js, index.js
  Config: .env, config/

Django:
  Expected: apps/, templates/, static/, manage.py
  Entry: manage.py, wsgi.py
  Config: settings.py, urls.py

ASP.NET Core:
  Expected: Controllers/, Services/, Models/, Views/
  Entry: Program.cs
  Config: appsettings.json, launchSettings.json

Go:
  Expected: cmd/, internal/, pkg/, api/
  Entry: cmd/*/main.go
  Config: go.mod, Makefile
```
