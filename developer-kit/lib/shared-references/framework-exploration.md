# Framework-Specific Exploration Guide

Patterns and key areas for exploring codebases by framework.

## React/Next.js

```yaml
Key Areas:
  - app/ or pages/ for routing
  - components/ for UI components
  - hooks/ for custom hooks
  - lib/ or utils/ for utilities
  - api/ for API routes

Patterns to Look For:
  - Server vs Client components ("use client")
  - Data fetching patterns (RSC, SWR, React Query)
  - State management (Context, Zustand, Redux)
  - Styling approach (Tailwind, CSS Modules, styled-components)

Context7 Queries:
  - mcp__context7__query-docs("/vercel/next.js", "app router patterns")
  - mcp__context7__query-docs("/vercel/next.js", "server components")
```

## Express/Node.js

```yaml
Key Areas:
  - routes/ or api/ for endpoints
  - middleware/ for request processing
  - controllers/ for request handlers
  - services/ for business logic
  - models/ for data models

Patterns to Look For:
  - Router organization
  - Middleware chain order
  - Error handling approach
  - Database connection management

Context7 Queries:
  - mcp__context7__query-docs("/expressjs/express", "middleware patterns")
  - mcp__context7__query-docs("/expressjs/express", "error handling")
```

## ASP.NET Core

```yaml
Key Areas:
  - Controllers/ for API endpoints
  - Services/ for business logic
  - Models/ or Entities/ for data models
  - Data/ for DbContext and repositories
  - Middleware/ for request pipeline

Patterns to Look For:
  - Dependency injection configuration
  - Controller inheritance patterns
  - Entity Framework usage
  - Authentication/Authorization setup

Context7 Queries:
  - mcp__context7__resolve-library-id("aspnetcore")
  - Look for Startup.cs or Program.cs configuration
```

## Go

```yaml
Key Areas:
  - cmd/ for entry points
  - internal/ for private packages
  - pkg/ for public packages
  - api/ for API definitions

Patterns to Look For:
  - Handler → Service → Repository layers
  - Interface-based design
  - Error handling patterns
  - Context propagation

Search Strategies:
  - Grep for "func main()" to find entry points
  - Grep for "interface" to find abstractions
  - Grep for "http.Handler" for web handlers
```

## Django/Python

```yaml
Key Areas:
  - apps/ for Django applications
  - views.py for request handlers
  - models.py for ORM models
  - urls.py for routing
  - serializers.py for API serialization

Patterns to Look For:
  - Class-based vs function-based views
  - Model relationships
  - Signal usage
  - Middleware configuration

Context7 Queries:
  - mcp__context7__query-docs("/django/django", "class based views")
  - mcp__context7__query-docs("/django/django", "model patterns")
```

## FastAPI

```yaml
Key Areas:
  - routers/ for API endpoints
  - models/ for Pydantic models
  - services/ for business logic
  - dependencies/ for DI

Patterns to Look For:
  - Dependency injection usage
  - Pydantic validation patterns
  - Async/await patterns
  - OpenAPI documentation

Context7 Queries:
  - mcp__context7__query-docs("/tiangolo/fastapi", "dependency injection")
  - mcp__context7__query-docs("/tiangolo/fastapi", "pydantic models")
```

## Vue.js

```yaml
Key Areas:
  - components/ for Vue components
  - views/ or pages/ for routes
  - composables/ for composition functions
  - stores/ for Pinia/Vuex stores

Patterns to Look For:
  - Composition API vs Options API
  - Reactivity patterns (ref, reactive)
  - Component communication
  - Router configuration

Context7 Queries:
  - mcp__context7__query-docs("/vuejs/core", "composition API")
  - mcp__context7__query-docs("/vuejs/pinia", "store patterns")
```

## Rust

```yaml
Key Areas:
  - src/main.rs for entry point
  - src/lib.rs for library root
  - src/bin/ for multiple binaries
  - src/models/ or src/domain/ for types

Patterns to Look For:
  - Error handling (Result, anyhow, thiserror)
  - Async runtime (tokio, async-std)
  - Trait-based abstractions
  - Module organization

Search Strategies:
  - Grep for "fn main" for entry points
  - Grep for "impl" for trait implementations
  - Grep for "pub trait" for abstractions
```
