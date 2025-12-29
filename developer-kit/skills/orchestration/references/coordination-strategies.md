# Coordination Strategies

## Strategy Selection

### Sequential Strategy
**Use when:**
- Tasks have dependencies
- Order matters for correctness
- Resources are limited

**Example:**
```
1. Create database migration
2. Run migration
3. Update API to use new schema
4. Update frontend to use new API
```

### Parallel Strategy
**Use when:**
- Tasks are independent
- Speed is critical
- Resources are available

**Example:**
```
Parallel execution:
├── Write unit tests
├── Write documentation
├── Create UI mockups
└── Set up CI pipeline
```

### Adaptive Strategy
**Use when:**
- Mix of dependent and independent tasks
- Complex operations
- Dynamic requirements

**Example:**
```
Phase 1 (Parallel):
├── Design API
└── Design Database

Phase 2 (Sequential, depends on Phase 1):
└── Implement API

Phase 3 (Parallel, depends on Phase 2):
├── Write tests
└── Write documentation
```

## Execution Patterns

### Waterfall
```
Design → Implement → Test → Deploy
```
- Simple and predictable
- High risk if requirements change
- Best for well-defined projects

### Iterative
```
Sprint 1: MVP
Sprint 2: Feature A
Sprint 3: Feature B
...
```
- Flexible to changes
- Regular deliverables
- Best for evolving requirements

### Event-Driven
```
On file change → Run tests
On test pass → Deploy staging
On approval → Deploy production
```
- Automated coordination
- Reactive execution
- Best for CI/CD pipelines

## Progress Tracking

### Status States
| State | Meaning |
|-------|---------|
| Pending | Not started |
| In Progress | Currently working |
| Blocked | Waiting on dependency |
| Review | Ready for review |
| Done | Completed |

### Progress Reporting
```markdown
## Sprint Progress

### Completed (3)
- [x] Create user model
- [x] Add validation
- [x] Write unit tests

### In Progress (1)
- [ ] Create API endpoint (80%)

### Blocked (1)
- [ ] Deploy to staging (waiting on DevOps)

### Pending (2)
- [ ] Integration tests
- [ ] Documentation
```

## Quality Gates

### Definition of Done
- [ ] Code complete
- [ ] Tests passing
- [ ] Code reviewed
- [ ] Documentation updated
- [ ] No critical issues

### Phase Gates
```
Development Complete → Code Review → QA → Staging → Production
                    ↑            ↑      ↑         ↑
                  Gate 1      Gate 2  Gate 3    Gate 4
```

## Error Handling

### Failure Recovery
1. **Identify**: Which task failed?
2. **Analyze**: Why did it fail?
3. **Decide**: Retry, skip, or abort?
4. **Execute**: Recovery action
5. **Continue**: Resume orchestration

### Rollback Strategy
```
On failure:
1. Stop dependent tasks
2. Revert completed changes
3. Report failure
4. Await instructions
```
