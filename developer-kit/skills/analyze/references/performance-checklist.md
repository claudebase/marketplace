# Performance Analysis Checklist

## Algorithmic Issues

### Time Complexity Red Flags
- [ ] Nested loops over same data (O(n^2))
- [ ] Recursive functions without memoization
- [ ] Linear search in large datasets
- [ ] Repeated expensive calculations

### Space Complexity Issues
- [ ] Unbounded array growth
- [ ] Large object cloning
- [ ] Memory leaks in closures
- [ ] Retaining unnecessary references

## Database & Query Issues

### N+1 Query Pattern
```
# Bad: Query per item
for item in items:
    related = db.query(related_table).filter(id=item.id)

# Good: Batch query
related = db.query(related_table).filter(id__in=[i.id for i in items])
```

### Query Optimization
- [ ] Missing indexes on filtered columns
- [ ] SELECT * instead of specific columns
- [ ] No pagination on large datasets
- [ ] Unnecessary JOINs

## Frontend Performance

### React/Vue Specific
- [ ] Missing React.memo/useMemo for expensive renders
- [ ] Large component re-renders
- [ ] Missing virtualization for long lists
- [ ] Unoptimized images

### General Frontend
- [ ] Large bundle sizes
- [ ] Blocking scripts in head
- [ ] Excessive DOM manipulation
- [ ] Missing lazy loading

## Backend Performance

### API Issues
- [ ] No response caching
- [ ] Missing compression
- [ ] Synchronous blocking operations
- [ ] No connection pooling

### Resource Management
- [ ] Unclosed file handles
- [ ] Unclosed database connections
- [ ] Missing timeout configurations
- [ ] No rate limiting

## Severity Classification

| Issue | Severity | Impact |
|-------|----------|--------|
| N+1 queries | High | Exponential slowdown |
| Memory leaks | High | System degradation |
| Missing indexes | Medium | Query slowdown |
| Large bundles | Medium | Load time impact |
| Missing caching | Low | Repeated computation |

## Quick Wins

1. Add indexes to frequently queried columns
2. Implement response caching
3. Use pagination for list endpoints
4. Lazy load non-critical components
5. Enable compression (gzip/brotli)
