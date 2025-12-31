# Design Skill - Detailed Guide

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

## Phase 1: ANALYZE

Understand requirements before designing:

1. **Read existing code** - Identify current architecture, patterns, constraints
2. **Determine stakeholders** - Who consumes this? What are their needs?
3. **Define quality attributes** - Scalability, reliability, maintainability, security
4. **Identify constraints** - Technology stack, team skills, timeline, budget

**Tools**: Read, Grep, Glob

## Phase 2: RESEARCH

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

## Phase 3: DESIGN

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

## Phase 4: SPECIFY

Create concrete design artifacts:

1. **Architecture diagrams** - C4 model (Context, Container, Component)
2. **API specifications** - OpenAPI/Swagger, GraphQL SDL
3. **Data models** - ERD, schema definitions
4. **Interface contracts** - TypeScript interfaces, JSON schemas
5. **Decision records** - ADRs with rationale

## Phase 5: VALIDATE

Review and verify design:

```
# Visual validation of API documentation
mcp__playwright__browser_navigate("http://localhost:3000/api-docs")
mcp__playwright__browser_snapshot()
```

## MCP Integration

### Context7 (Official Documentation)

**Available Resources:**

| Resource     | Library ID                           | Snippets |
| ------------ | ------------------------------------ | -------- |
| OpenAPI 3.0  | `/websites/swagger_io_specification` | 243      |
| OpenAPI Spec | `/oai/openapi-specification`         | 2,230    |
| GraphQL      | `/graphql/graphql.github.io`         | 1,196    |
| C4 Model     | `/websites/c4model`                  | 100      |
| tRPC         | `/trpc/trpc`                         | 1,616    |
| Hono         | `/honojs/website`                    | 1,360    |

### GitHub MCP (Pattern Research)

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
