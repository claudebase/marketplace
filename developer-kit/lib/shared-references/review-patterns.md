# Code Review Patterns

Centralized patterns for code review operations. Used by `analyze` skill and `code-reviewer` agent.

## Confidence Scoring

Rate each potential issue 0-100:

| Score  | Meaning                                    |
| ------ | ------------------------------------------ |
| 0-25   | Likely false positive, pre-existing issue  |
| 26-50  | Real but minor, might be nitpick           |
| 51-75  | Important issue, will impact functionality |
| 76-100 | Critical, verified issue that will happen  |

**Thresholds**:

- Standard review: Report issues with confidence ≥80%
- Strict review (`--strict`): Report issues with confidence ≥90%

## False Positive Prevention

**Do NOT flag:**

- Pre-existing issues (only review the diff)
- Issues linter/typechecker would catch
- Lines user didn't modify
- Pedantic nitpicks (unless --strict)
- Intentional functionality changes
- Framework patterns that are valid alternatives

**Before flagging, ask:**

- Is this actually in the changed lines?
- Would this cause real problems in practice?
- Is this explicitly mentioned in project guidelines?
- Does Context7 confirm this is an anti-pattern?
- Am I above 80% confident?

## Framework-Specific Checklists

### React/Next.js

```yaml
Hooks:
  - useEffect has correct dependencies
  - useEffect cleanup function present when needed
  - useMemo/useCallback used appropriately (not over-memoizing)
  - useState not used for derived state
  - Custom hooks follow naming convention (use*)

Components:
  - Key prop present in list renders
  - Props destructured with defaults
  - Component size reasonable (<200 lines)
  - No inline function definitions in JSX (when avoidable)

Next.js Specific:
  - "use client" directive when needed
  - Server components don't import client-only code
  - Proper use of getServerSideProps/getStaticProps
  - Image component used for images
```

### Vue.js

```yaml
Composition API:
  - ref() vs reactive() used appropriately
  - Computed properties for derived state
  - Watch cleanup handlers present
  - toRef/toRefs used when destructuring reactive

Templates:
  - v-for has :key attribute
  - v-if/v-show used appropriately
  - Event handlers properly bound
  - No complex expressions in templates
```

### Express/Node.js

```yaml
Error Handling:
  - Async routes wrapped in try/catch or asyncHandler
  - Error middleware at end of chain
  - Proper error status codes
  - Errors don't leak stack traces in production

Security:
  - Input validation on all routes
  - SQL/NoSQL injection prevention
  - Rate limiting on sensitive endpoints
  - Helmet or security headers configured

Performance:
  - Database queries optimized (no N+1)
  - Proper caching headers
  - Large payloads paginated
```

### ASP.NET Core

```yaml
Dependency Injection:
  - Correct lifetime (Transient/Scoped/Singleton)
  - No service locator anti-pattern
  - Interfaces used for dependencies

Controllers:
  - Proper HTTP methods (GET/POST/PUT/DELETE)
  - Model validation with [Required], [StringLength], etc.
  - ActionResult return types
  - Async methods for I/O operations
```

### Go

```yaml
Error Handling:
  - Errors checked (not _ assigned)
  - Errors wrapped with context
  - Custom error types when appropriate

Concurrency:
  - Goroutines have proper lifecycle management
  - Channels closed by sender
  - Context propagation for cancellation
  - No goroutine leaks
```

### Python/Django/FastAPI

```yaml
Django:
  - QuerySet optimization (select_related, prefetch_related)
  - Proper use of ORM vs raw SQL
  - Template context security

FastAPI:
  - Pydantic models for validation
  - Dependency injection patterns
  - Async patterns for I/O
```

## Review Output Format

**For issues found:**

```markdown
### Code Review

**Framework**: [Detected Framework]
**Files Reviewed**: [Count]
**Context7 Patterns Applied**: [List]

Found N issues:

1. **[Description]** (Confidence: X%)
   - File: `path/to/file.ts:42`
   - Pattern: [Context7 reference or CLAUDE.md guideline]
   - Issue: [Detailed explanation]
   - Fix: [Specific suggestion with code example]
```

**For clean code:**

```markdown
### Code Review

**Framework**: [Detected Framework]
**Files Reviewed**: [Count]

No high-confidence issues found. Checked for:

- CLAUDE.md compliance
- Framework best practices (via Context7)
- Obvious bugs
- Security vulnerabilities
- Performance anti-patterns
```

## Bug Detection Patterns

| Category    | Patterns to Check                      |
| ----------- | -------------------------------------- |
| Logic       | Off-by-one errors, boundary conditions |
| Null Safety | Null/undefined handling issues         |
| Async       | Race conditions, missing await         |
| Security    | Injection, XSS, auth bypass            |
| Memory      | Leaks, unclosed resources              |

## Context7 Integration

```yaml
Framework Detection: 1. Parse package.json, requirements.txt, *.csproj, etc.
  2. Identify primary framework
  3. Resolve library ID
  4. Fetch best practices and common mistakes
  5. Apply patterns to review
```

## Related

- [MCP Resources](./mcp-resources.md) - Context7 library IDs
- [Tool Integration](./tool-integration-patterns.md) - MCP patterns
- [Security Patterns](./security-patterns.md) - OWASP checklists
