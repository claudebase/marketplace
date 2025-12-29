# Task Breakdown Patterns

## Epic → Story → Task Decomposition

### Example: Authentication System

**Epic**: Implement User Authentication System

**Stories**:
1. User Registration
2. User Login
3. Password Reset
4. Session Management

**Tasks for "User Login" Story**:
1. Create login API endpoint
2. Implement password validation
3. Generate JWT tokens
4. Create login UI form
5. Handle login errors
6. Add rate limiting
7. Write tests

**Subtasks for "Create login API endpoint"**:
1. Define route handler
2. Validate request body
3. Query user from database
4. Compare passwords
5. Return response

## Decomposition Guidelines

### When to Break Down
- Task takes more than 2 hours
- Task involves multiple files/components
- Task has multiple distinct steps
- Task requires different skills/knowledge

### When NOT to Break Down
- Task is atomic (single action)
- Breaking down adds overhead
- Task is well-understood and simple

## Dependency Analysis

### Dependency Types

**Hard Dependencies** (must complete first):
```
Database Schema → API → Frontend
```

**Soft Dependencies** (preferred order):
```
Design Mockup → Implementation (can start without)
```

**No Dependencies** (parallel execution):
```
Unit Tests ∥ Documentation ∥ Linting
```

### Dependency Mapping
```
Task A ──────────────────────────►
       └──► Task B (depends on A) ►
Task C ──────────────────────────► (parallel with A)
```

## Common Breakdown Patterns

### Feature Implementation
```
1. Design/Architecture (first)
2. Database Changes (if needed)
3. Backend Implementation
4. Frontend Implementation (can parallel with some backend)
5. Integration
6. Testing (can start early for unit tests)
7. Documentation
```

### Bug Fix
```
1. Reproduce Issue
2. Identify Root Cause
3. Design Fix
4. Implement Fix
5. Add Regression Test
6. Verify Fix
```

### Refactoring
```
1. Add Tests (if missing)
2. Identify Scope
3. Extract/Rename/Move (small steps)
4. Verify Tests Pass
5. Repeat
```

## Estimation Guidelines

### T-Shirt Sizing
| Size | Time | Complexity |
|------|------|------------|
| XS | < 1 hour | Trivial change |
| S | 1-4 hours | Simple task |
| M | 4-8 hours | Moderate complexity |
| L | 1-3 days | Complex task |
| XL | 3-5 days | Very complex |

### Estimation Tips
- Add buffer for unknowns (20-50%)
- Break down XL tasks further
- Consider testing time
- Account for code review
