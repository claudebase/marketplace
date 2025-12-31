# Framework-Specific Review Checklists

## React/Next.js

```yaml
Hooks:
  - [ ] useEffect has correct dependencies
  - [ ] useEffect cleanup function present when needed
  - [ ] useMemo/useCallback used appropriately (not over-memoizing)
  - [ ] useState not used for derived state
  - [ ] Custom hooks follow naming convention (use*)

Components:
  - [ ] Key prop present in list renders
  - [ ] Props destructured with defaults
  - [ ] Component size reasonable (<200 lines)
  - [ ] No inline function definitions in JSX (when avoidable)

Next.js Specific:
  - [ ] "use client" directive when needed
  - [ ] Server components don't import client-only code
  - [ ] Proper use of getServerSideProps/getStaticProps
  - [ ] Image component used for images
```

## Vue.js

```yaml
Composition API:
  - [ ] ref() vs reactive() used appropriately
  - [ ] Computed properties for derived state
  - [ ] Watch cleanup handlers present
  - [ ] toRef/toRefs used when destructuring reactive

Templates:
  - [ ] v-for has :key attribute
  - [ ] v-if/v-show used appropriately
  - [ ] Event handlers properly bound
  - [ ] No complex expressions in templates
```

## Express/Node.js

```yaml
Error Handling:
  - [ ] Async routes wrapped in try/catch or asyncHandler
  - [ ] Error middleware at end of chain
  - [ ] Proper error status codes
  - [ ] Errors don't leak stack traces in production

Security:
  - [ ] Input validation on all routes
  - [ ] SQL/NoSQL injection prevention
  - [ ] Rate limiting on sensitive endpoints
  - [ ] Helmet or security headers configured

Performance:
  - [ ] Database queries optimized (no N+1)
  - [ ] Proper caching headers
  - [ ] Large payloads paginated
```

## ASP.NET Core

```yaml
Dependency Injection:
  - [ ] Correct lifetime (Transient/Scoped/Singleton)
  - [ ] No service locator anti-pattern
  - [ ] Interfaces used for dependencies

Controllers:
  - [ ] Proper HTTP methods (GET/POST/PUT/DELETE)
  - [ ] Model validation with [Required], [StringLength], etc.
  - [ ] ActionResult return types
  - [ ] Async methods for I/O operations

Entity Framework:
  - [ ] No tracking for read-only queries
  - [ ] Eager loading where needed (Include)
  - [ ] Async database operations
```

## Go

```yaml
Error Handling:
  - [ ] Errors checked (not _ assigned)
  - [ ] Errors wrapped with context
  - [ ] Custom error types when appropriate

Concurrency:
  - [ ] Goroutines have proper lifecycle management
  - [ ] Channels closed by sender
  - [ ] Context propagation for cancellation
  - [ ] No goroutine leaks

Patterns:
  - [ ] Interfaces defined by consumer
  - [ ] Accept interfaces, return structs
  - [ ] Defer used for cleanup
```

## Python/FastAPI

```yaml
Async:
  - [ ] Async functions use await properly
  - [ ] No blocking calls in async context
  - [ ] Proper exception handling

Pydantic:
  - [ ] Models validate input
  - [ ] Field validators used appropriately
  - [ ] Config classes present

Security:
  - [ ] Dependencies inject authentication
  - [ ] Input sanitization
  - [ ] Rate limiting on sensitive endpoints
```

## Confidence Scoring

| Score  | Meaning                                    |
| ------ | ------------------------------------------ |
| 0-25   | Likely false positive, pre-existing issue  |
| 26-50  | Real but minor, might be nitpick           |
| 51-75  | Important issue, will impact functionality |
| 76-100 | Critical, verified issue that will happen  |

**Only report issues with confidence ≥80** (≥90 with --strict)
