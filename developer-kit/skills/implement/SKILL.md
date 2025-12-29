---
name: implement
description: "Feature and code implementation with framework-specific best practices. Use for building components, APIs, services, or complete features. Activates for: implement, create, build feature, add functionality, code this, make a, develop."
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - Edit
  - Write
  - TodoWrite
  - Task
  - mcp__context7__resolve-library-id
  - mcp__context7__get-library-docs
  - mcp__sequential-thinking__sequentialthinking
  - mcp__playwright__browser_navigate
  - mcp__playwright__browser_snapshot
  - mcp__playwright__browser_click
---

# Implement Skill

## Activation Triggers
- Feature development requests for components, APIs, or complete functionality
- Code implementation needs with framework-specific requirements
- Multi-domain development requiring coordinated expertise
- Implementation projects requiring testing and validation integration

## Behavioral Flow

1. **Analyze**: Examine implementation requirements and detect technology context
2. **Plan**: Choose approach based on framework and complexity
3. **Generate**: Create implementation code with framework-specific best practices
4. **Validate**: Apply security and quality validation throughout
5. **Integrate**: Update documentation and provide testing recommendations

## Key Behaviors

- Context-based approach selection (frontend, backend, full-stack)
- Framework-specific implementation via Context7 documentation lookup
- Systematic multi-component coordination for complex features
- Testing integration via Playwright for validation

## MCP Integration

**Use Context7 for framework-specific implementation patterns:**
```
mcp__context7__resolve-library-id - Resolve library names first
mcp__context7__get-library-docs - Fetch official patterns (React, Vue, Express, etc.)
```
Context7 ensures implementations follow official framework conventions.

**Use Sequential Thinking for complex feature planning:**
```
mcp__sequential-thinking__sequentialthinking - Use for multi-step implementation reasoning
```
Sequential Thinking helps plan complex features with proper dependency ordering.

**Use Playwright for implementation validation:**
```
mcp__playwright__browser_navigate - Navigate to test the feature
mcp__playwright__browser_snapshot - Validate UI implementations
mcp__playwright__browser_click - Test interactive elements
```
Playwright enables real-time validation of implemented features.

## Implementation Patterns

### Component Implementation
```
1. Analyze existing patterns in codebase
2. Look up framework best practices via Context7
3. Generate component with proper structure
4. Add tests and documentation
```

### API Implementation
```
1. Review existing API patterns
2. Design endpoint structure
3. Implement with security considerations
4. Add validation and error handling
```

### Full-Stack Feature
```
1. Break down into frontend/backend tasks
2. Implement backend API first
3. Create frontend components
4. Integrate and test end-to-end
```

## References
- `references/implementation-patterns.md` - Detailed patterns for different implementation types

## Boundaries

**Will:**
- Implement features with framework-specific best practices
- Apply security and quality validation throughout development
- Provide comprehensive implementation with testing integration

**Will Not:**
- Make architectural decisions without proper analysis
- Implement features conflicting with security policies
- Override user-specified safety constraints
