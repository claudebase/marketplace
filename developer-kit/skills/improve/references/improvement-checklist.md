# Improvement Checklists

## Quality Improvement Checklist

### Code Clarity

```markdown
## Clarity Checks

### Naming
- [ ] Variables describe what they hold
- [ ] Functions describe what they do
- [ ] Classes describe what they represent
- [ ] No abbreviations (except widely known: URL, ID, etc.)
- [ ] Consistent naming conventions

### Structure
- [ ] Functions do one thing
- [ ] Functions are under 20-30 lines
- [ ] Classes have single responsibility
- [ ] Clear separation of concerns
- [ ] Logical file organization

### Readability
- [ ] Code is self-documenting
- [ ] Complex logic has comments explaining WHY
- [ ] No magic numbers/strings
- [ ] Consistent formatting
- [ ] Imports are organized
```

### Code Duplication

```markdown
## Duplication Checks

### Detection
- [ ] No copy-pasted code blocks
- [ ] Similar functions consolidated
- [ ] Shared logic extracted to utilities
- [ ] Common patterns abstracted

### Resolution
- [ ] Extract shared functions
- [ ] Create reusable components
- [ ] Use composition over repetition
- [ ] Implement DRY without over-engineering
```

### Complexity Reduction

```markdown
## Complexity Checks

### Cyclomatic Complexity
- [ ] No deeply nested conditionals (max 3 levels)
- [ ] Switch statements consider polymorphism
- [ ] Guard clauses for early returns
- [ ] Complex conditions extracted to functions

### Cognitive Complexity
- [ ] Easy to follow control flow
- [ ] No "clever" code
- [ ] State changes are obvious
- [ ] Side effects are explicit
```

## Performance Improvement Checklist

### Algorithm Efficiency

```markdown
## Algorithm Checks

### Time Complexity
- [ ] Appropriate data structures used
- [ ] Avoid O(n²) when O(n) possible
- [ ] Early termination implemented
- [ ] Caching for expensive operations

### Space Complexity
- [ ] No unnecessary data copies
- [ ] Memory-efficient data structures
- [ ] Cleanup of unused references
- [ ] Stream processing for large data
```

### Resource Efficiency

```markdown
## Resource Checks

### Memory
- [ ] No memory leaks
- [ ] Event listeners cleaned up
- [ ] Large objects released when done
- [ ] Weak references where appropriate

### Network
- [ ] Requests batched when possible
- [ ] Appropriate caching headers
- [ ] Compression enabled
- [ ] Lazy loading implemented

### Rendering (Frontend)
- [ ] Minimal re-renders
- [ ] Memoization for expensive computations
- [ ] Virtual scrolling for long lists
- [ ] Image optimization
```

### Caching Strategies

```markdown
## Caching Checks

### Implementation
- [ ] Cache expensive computations
- [ ] Appropriate cache invalidation
- [ ] Cache key design is correct
- [ ] TTL set appropriately

### Patterns
- [ ] Memoization for pure functions
- [ ] Request deduplication
- [ ] Optimistic updates where safe
- [ ] Background refresh for stale data
```

## Maintainability Improvement Checklist

### Modularity

```markdown
## Modularity Checks

### Coupling
- [ ] Modules have minimal dependencies
- [ ] Dependencies are explicit
- [ ] No circular dependencies
- [ ] Interface-based communication

### Cohesion
- [ ] Related code stays together
- [ ] Each module has clear purpose
- [ ] No "util" dumping grounds
- [ ] Logical grouping of functionality
```

### Extensibility

```markdown
## Extensibility Checks

### Design Patterns
- [ ] Open/Closed principle followed
- [ ] Extension points identified
- [ ] Plugins/hooks system where needed
- [ ] Configuration over code changes

### Future-Proofing
- [ ] Abstractions at boundaries
- [ ] Dependency injection
- [ ] Feature flags for experiments
- [ ] Versioned interfaces
```

### Testability

```markdown
## Testability Checks

### Unit Testing
- [ ] Functions are pure where possible
- [ ] Dependencies are injectable
- [ ] Side effects are isolated
- [ ] Small, focused functions

### Integration Testing
- [ ] Clear boundaries for mocking
- [ ] Test data factories
- [ ] Deterministic tests
- [ ] Isolated test environments
```

## Security Improvement Checklist

### Input Handling

```markdown
## Input Security

### Validation
- [ ] All user input validated
- [ ] Type checking enforced
- [ ] Length limits applied
- [ ] Format validation (email, URL, etc.)

### Sanitization
- [ ] HTML escaped for display
- [ ] SQL parameterized
- [ ] Command arguments escaped
- [ ] Path traversal prevented
```

### Authentication & Authorization

```markdown
## Auth Security

### Authentication
- [ ] Secure password storage (bcrypt/argon2)
- [ ] Session management secure
- [ ] Token expiration implemented
- [ ] MFA available for sensitive ops

### Authorization
- [ ] Principle of least privilege
- [ ] Role-based access control
- [ ] Resource ownership verified
- [ ] Authorization on every request
```

### Data Protection

```markdown
## Data Security

### In Transit
- [ ] HTTPS everywhere
- [ ] Secure cookies (httpOnly, secure, sameSite)
- [ ] API keys not in URLs
- [ ] Sensitive data encrypted

### At Rest
- [ ] Passwords hashed
- [ ] PII encrypted
- [ ] Logs sanitized
- [ ] Backups encrypted
```

## Improvement Priority Matrix

```
Impact
  High │ Quick Wins   │ Major Projects │
       │ (Do First)   │ (Plan Carefully)│
       │              │                │
Medium │ Fill-ins     │ Plan & Do      │
       │              │                │
   Low │ Maybe Later  │ Probably Never │
       └──────────────┴────────────────┘
         Low Effort     High Effort
```

### Priority by Type

| Type | Typical Priority | Reason |
|------|-----------------|--------|
| Security Fixes | Critical | Risk mitigation |
| Performance (user-facing) | High | User experience |
| Code Quality | Medium | Maintainability |
| Technical Debt | Medium | Long-term velocity |
| Style/Formatting | Low | Tooling handles this |

## Improvement Documentation

### Template

```markdown
## Improvement: [Title]

### Before
[Code/pattern before improvement]

### After
[Code/pattern after improvement]

### Benefit
- [Specific measurable improvement]

### Verification
- [ ] Tests pass
- [ ] No regressions
- [ ] Metrics improved

### Related Work
- [Additional improvements enabled by this change]
```
