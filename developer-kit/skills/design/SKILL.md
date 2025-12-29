---
name: design
description: "Design system architecture, APIs, database schemas, and component interfaces with concrete specifications. Use for architecture design, API specs, database schemas, or interface definitions. Activates for: design a system, architect this, create API spec, design database, component design, plan architecture."
allowed-tools:
  - Read
  - Grep
  - Glob
  - Write
  - mcp__sequential-thinking__sequentialthinking
---

# System Design Skill

## Purpose

Create comprehensive design specifications for systems, APIs, databases, and components. Produce concrete, actionable design artifacts.

**Key Principle**: Design with intent. Every decision should be justified.

**Key Distinction**: This skill produces CONCRETE design specs. For exploratory ideation, use `brainstorm` skill first. For implementation, use `implement` skill after design.

## When to Use

**Activate When:**
- User asks to "design" or "architect" something
- User needs API specifications
- User wants database schema design
- User needs component interface definitions
- Requirements are clear and design is needed

**Do NOT Activate When:**
- User is still exploring ideas → use `brainstorm` skill
- User wants to implement code → use `implement` skill
- User wants documentation for existing code → use `document` skill

## Design Types

### 1. System Architecture
- Component diagrams
- Service boundaries
- Data flow
- Integration points
- Scalability considerations

### 2. API Design
- Endpoint specifications
- Request/response schemas
- Authentication/authorization
- Error handling patterns
- Versioning strategy

### 3. Database Design
- Entity-relationship diagrams
- Table schemas
- Indexes and constraints
- Migration strategy
- Performance considerations

### 4. Component Design
- Interface definitions
- Props/parameters
- State management
- Event handling
- Composition patterns

## Methodology

1. **Analyze**: Understand requirements and constraints
2. **Plan**: Define design approach and structure
3. **Design**: Create specifications with best practices
4. **Validate**: Ensure design meets requirements
5. **Document**: Generate clear design artifacts

## Output Formats

### Architecture Diagram (ASCII)
```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Client    │────▶│   API GW    │────▶│   Service   │
└─────────────┘     └─────────────┘     └─────────────┘
                           │                    │
                           ▼                    ▼
                    ┌─────────────┐     ┌─────────────┐
                    │    Auth     │     │  Database   │
                    └─────────────┘     └─────────────┘
```

### API Specification
```yaml
openapi: 3.0.0
paths:
  /users:
    get:
      summary: List users
      responses:
        '200':
          description: User list
```

### Database Schema
```sql
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);
```

### Component Interface
```typescript
interface ButtonProps {
  variant: 'primary' | 'secondary';
  size: 'sm' | 'md' | 'lg';
  onClick: () => void;
  disabled?: boolean;
  children: React.ReactNode;
}
```

## Design Principles

### Architecture
- Separation of concerns
- Single responsibility
- Loose coupling
- High cohesion
- Scalability by design

### API
- RESTful conventions
- Consistent naming
- Proper HTTP methods
- Clear error responses
- Pagination for lists

### Database
- Normalization (appropriate level)
- Index strategy
- Referential integrity
- Soft deletes when needed
- Audit trails for sensitive data

## MCP Integration

**Use Sequential Thinking for complex design decisions:**
```
mcp__sequential-thinking__sequentialthinking - Use for structured architectural reasoning
```
Sequential Thinking helps work through trade-offs and design alternatives methodically.

## Reference Files

For detailed patterns and templates, see:
- `references/architecture-patterns.md` - Common architecture patterns
- `references/api-design-guide.md` - API design best practices
- `references/event-sourcing.md` - Event sourcing, CQRS, and aggregate patterns
