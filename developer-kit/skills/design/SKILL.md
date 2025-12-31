---
name: design
description: "Design system architecture, APIs, database schemas, and component interfaces with concrete specifications. Use for architecture design, API specs, database schemas, or interface definitions. Activates for: design a system, architect this, create API spec, design database, component design, plan architecture."
allowed-tools:
  # Core Analysis
  - Read
  - Grep
  - Glob
  # Implementation
  - Write
  - Edit
  - Task
  # Design Documentation
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  # Pattern Research
  - mcp__github__search_code
  - mcp__github__get_file_contents
  # Best Practices Research
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  # Visual Validation
  - mcp__playwright__browser_navigate
  - mcp__playwright__browser_snapshot
  # Complex Design Planning
  - mcp__sequential-thinking__sequentialthinking
---

# System Design Skill

Create comprehensive design specifications for systems, APIs, databases, and components with official documentation, industry best practices, and real-world patterns.

**Key Principle**: Design with intent. Every decision should be justified with rationale.

**Key Distinction**: This skill produces CONCRETE design specs. For exploratory ideation, use `brainstorm` skill first. For implementation, use `implement` skill after design.

## Activation Triggers

- System architecture ("design a system", "architect this", "system design")
- API design ("create API spec", "design endpoints", "OpenAPI schema")
- Database design ("database schema", "data model", "ERD")
- Component design ("interface definition", "component API", "props design")
- Integration design ("service integration", "event-driven architecture")

## Do NOT Activate When

- User is still exploring ideas → use `brainstorm` skill
- User wants to implement code → use `implement` skill
- User wants documentation for existing code → use `document` skill
- User needs database queries/optimization → use `database` skill
- User needs infrastructure provisioning → use `devops` skill

## Behavioral Flow

```
┌──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
│   ANALYZE    │   RESEARCH   │    DESIGN    │   SPECIFY    │   VALIDATE   │
├──────────────┼──────────────┼──────────────┼──────────────┼──────────────┤
│ Understand   │ Lookup       │ Make         │ Create       │ Review       │
│ requirements │ official     │ architectural│ concrete     │ design       │
│ & constraints│ specs        │ decisions    │ specs        │ artifacts    │
│              │              │              │              │              │
│ Identify     │ Find         │ Apply        │ Generate     │ Validate     │
│ stakeholders │ patterns     │ design       │ diagrams     │ against      │
│ & use cases  │              │ patterns     │ & schemas    │ requirements │
│              │              │              │              │              │
│ Define       │ Research     │ Consider     │ Document     │ Ensure       │
│ quality      │ best         │ trade-offs   │ decisions    │ completeness │
│ attributes   │ practices    │              │              │              │
└──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘
     Read           Context7      Sequential      Write          Playwright
     Grep           GitHub        Thinking        Edit           (visual)
                    Tavily
```

### Phase 1: ANALYZE

Understand requirements before designing:

1. **Read existing code** - Identify current architecture, patterns, constraints
2. **Determine stakeholders** - Who consumes this? What are their needs?
3. **Define quality attributes** - Scalability, reliability, maintainability, security
4. **Identify constraints** - Technology stack, team skills, timeline, budget

**Tools**: Read, Grep, Glob

### Phase 2: RESEARCH

Gather official documentation and industry patterns:

```
# Lookup OpenAPI specification
mcp__context7__resolve-library-id → "/websites/swagger_io_specification"
mcp__context7__query-docs("OpenAPI 3.0 request body examples")

# Lookup GraphQL schema design
mcp__context7__resolve-library-id → "/graphql/graphql.github.io"
mcp__context7__query-docs("GraphQL schema design best practices")

# Lookup C4 model for architecture diagrams
mcp__context7__resolve-library-id → "/websites/c4model"
mcp__context7__query-docs("C4 context diagram components")

# Find real-world API design patterns
mcp__github__search_code("openapi paths components schemas filename:openapi.yaml")

# Research current best practices
mcp__tavily__tavily-search("API versioning strategies 2024 best practices")
```

**Tools**: Context7, GitHub MCP, Tavily

### Phase 3: DESIGN

Make architectural decisions with structured reasoning:

```
mcp__sequential-thinking__sequentialthinking
- Evaluate architectural patterns (monolith, microservices, serverless)
- Choose communication patterns (sync REST, async events, GraphQL)
- Define data ownership and boundaries
- Consider failure modes and recovery
- Plan for scalability and evolution
```

**Design Decisions Framework:**

- **Architecture Style**: Monolith vs Microservices vs Serverless
- **Communication**: REST vs GraphQL vs tRPC vs gRPC
- **Data Strategy**: SQL vs NoSQL vs Event Sourcing
- **Integration**: Sync vs Async vs Hybrid

**Tools**: Sequential Thinking

### Phase 4: SPECIFY

Create concrete design artifacts:

1. **Architecture diagrams** - C4 model (Context, Container, Component)
2. **API specifications** - OpenAPI/Swagger, GraphQL SDL
3. **Data models** - ERD, schema definitions
4. **Interface contracts** - TypeScript interfaces, JSON schemas
5. **Decision records** - ADRs with rationale

**Tools**: Write, Edit

### Phase 5: VALIDATE

Review and verify design:

```
# Visual validation of API documentation
mcp__playwright__browser_navigate("http://localhost:3000/api-docs")
mcp__playwright__browser_snapshot()

# Check against requirements checklist
# Verify completeness of specifications
# Review with stakeholders
```

**Tools**: Playwright

## MCP Integration

### Context7 (Official Documentation)

**Primary source for design specifications and standards:**

```
mcp__context7__resolve-library-id - Resolve OpenAPI, GraphQL, C4 model IDs
mcp__context7__query-docs - Get official documentation
```

**Available Resources:**

| Resource     | Library ID                           | Snippets |
| ------------ | ------------------------------------ | -------- |
| OpenAPI 3.0  | `/websites/swagger_io_specification` | 243      |
| OpenAPI Spec | `/oai/openapi-specification`         | 2,230    |
| GraphQL      | `/graphql/graphql.github.io`         | 1,196    |
| C4 Model     | `/websites/c4model`                  | 100      |
| tRPC         | `/trpc/trpc`                         | 1,616    |
| Hono         | `/honojs/website`                    | 1,360    |

**Use cases:**

- "OpenAPI 3.0 components and schemas"
- "GraphQL schema design patterns"
- "C4 model container diagram notation"
- "tRPC router and procedure definitions"
- "Hono OpenAPI integration"

### GitHub MCP (Pattern Research)

**Find real-world design patterns in production codebases:**

```
mcp__github__search_code - Find API specs, architecture patterns
mcp__github__get_file_contents - Get specific design files
```

**Search patterns:**

```
# Find OpenAPI specifications
"openapi: 3" "paths:" "components:" filename:openapi.yaml

# Find GraphQL schemas
"type Query" "type Mutation" "extend type" filename:schema.graphql

# Find C4 architecture documentation
"c4model" "Context" "Container" filename:.puml

# Find tRPC router patterns
"createTRPCRouter" "publicProcedure" filename:.ts

# Find API versioning patterns
"api/v1" "api/v2" "x-api-version" filename:.yaml
```

**Use cases:**

- Find how large projects structure OpenAPI specs
- Research GraphQL schema organization patterns
- Get real-world C4 architecture examples
- Study API versioning implementations

### Tavily (Best Practices Research)

**Research current design trends and best practices:**

```
mcp__tavily__tavily-search - Research design patterns, comparisons
mcp__tavily__tavily-extract - Extract from articles/docs
```

**Use cases:**

- "REST vs GraphQL vs tRPC comparison 2024"
- "API versioning strategies best practices"
- "Microservices vs modular monolith decision guide"
- "Event-driven architecture patterns"
- "Domain-driven design bounded contexts"

### Playwright (Visual Validation)

**Validate API documentation and diagrams:**

```
mcp__playwright__browser_navigate - Load Swagger UI, Redoc, etc.
mcp__playwright__browser_snapshot - Capture rendered documentation
```

**Use for:**

- Verify OpenAPI documentation renders correctly
- Test interactive API explorers
- Validate architecture diagrams in browsers
- Screenshot design artifacts for review

### Sequential Thinking (Complex Design)

**Structured reasoning for architectural decisions:**

```
mcp__sequential-thinking__sequentialthinking - Multi-step design reasoning
```

**Use for:**

- Evaluating architectural trade-offs
- Technology selection decisions
- Complex system decomposition
- Risk analysis and mitigation planning
- Design pattern selection

## Design Types

### 1. System Architecture

**Deliverables:**

- C4 Context Diagram (system and external actors)
- C4 Container Diagram (applications and data stores)
- C4 Component Diagram (internal structure)
- Deployment Diagram (infrastructure view)

```
# C4 Context Diagram (ASCII)
┌─────────────────────────────────────────────────────────────────┐
│                         [System Context]                        │
│  ┌──────────┐     ┌──────────────────┐     ┌──────────────────┐ │
│  │  User    │────▶│   Our System     │────▶│ External Service │ │
│  │  [Actor] │     │   [Container]    │     │ [External System]│ │
│  └──────────┘     └──────────────────┘     └──────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
```

### 2. API Design

**Deliverables:**

- OpenAPI 3.0 specification
- Request/response schemas
- Authentication flow
- Error handling patterns
- Rate limiting strategy

```yaml
# OpenAPI Specification
openapi: 3.0.3
info:
  title: API Name
  version: 1.0.0
paths:
  /users:
    get:
      summary: List users
      parameters:
        - name: limit
          in: query
          schema:
            type: integer
            default: 20
      responses:
        "200":
          description: User list
          content:
            application/json:
              schema:
                $ref: "#/components/schemas/UserList"
```

### 3. Database Design

**Deliverables:**

- Entity-Relationship Diagram
- Table schemas with constraints
- Index strategy
- Migration plan

```sql
-- Database Schema
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_users_email ON users(email);
```

### 4. Component Design

**Deliverables:**

- TypeScript interfaces
- Props specification
- State management approach
- Event contracts

```typescript
// Component Interface
interface DataTableProps<T> {
  data: T[];
  columns: ColumnDef<T>[];
  onRowClick?: (row: T) => void;
  pagination?: PaginationConfig;
  sorting?: SortingConfig;
}
```

## Design Principles

### Architecture

- **Separation of concerns** - Clear boundaries between components
- **Single responsibility** - Each component has one reason to change
- **Loose coupling** - Components interact through contracts
- **High cohesion** - Related functionality grouped together
- **Design for change** - Anticipate evolution, not just current needs

### API Design

- **RESTful conventions** - Proper resource naming and HTTP methods
- **Consistent naming** - Plural nouns for collections, clear verbs
- **Proper HTTP methods** - GET, POST, PUT, PATCH, DELETE semantics
- **Clear error responses** - Problem Details RFC 7807 format
- **Pagination for lists** - Cursor-based for large datasets

### Data Modeling

- **Appropriate normalization** - 3NF for OLTP, denormalized for OLAP
- **Explicit relationships** - Foreign keys with clear cardinality
- **Audit trails** - Created/updated timestamps, soft deletes
- **Version control** - Optimistic locking where needed

## Architecture Decision Records (ADR)

**Template for documenting design decisions:**

```markdown
# ADR-001: [Decision Title]

## Status

Proposed | Accepted | Deprecated | Superseded

## Context

What is the issue that we're seeing that is motivating this decision?

## Decision

What is the change that we're proposing?

## Consequences

What becomes easier or more difficult because of this change?

## Alternatives Considered

What other options were evaluated?
```

## Reference Files

For detailed patterns and templates, see:

- `references/architecture-patterns.md` - Common architecture patterns
- `references/api-design-guide.md` - API design best practices
- `references/event-sourcing.md` - Event sourcing, CQRS, and aggregate patterns

## Handoffs

| Scenario                   | Hand off to       |
| -------------------------- | ----------------- |
| Need implementation        | `implement` skill |
| Need database optimization | `database` skill  |
| Need security review       | `security` skill  |
| Need infrastructure setup  | `devops` skill    |
| Need frontend components   | `frontend` skill  |
| Need data migration        | `migration` skill |

## Boundaries

**Will:**

- Create system architecture diagrams (C4 model)
- Design API specifications (OpenAPI, GraphQL SDL)
- Define database schemas and relationships
- Specify component interfaces and contracts
- Document architectural decisions (ADRs)
- Research design patterns via MCP tools
- Validate designs against requirements

**Will Not:**

- Implement the designed systems (use `implement` skill)
- Optimize database queries (use `database` skill)
- Set up infrastructure (use `devops` skill)
- Make security decisions without review (use `security` skill)
- Execute migrations (use `migration` skill)
- Build UI components (use `frontend` skill)
