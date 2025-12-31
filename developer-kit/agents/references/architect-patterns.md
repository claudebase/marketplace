# Architect Agent - Design Patterns

## C4 Model Diagrams

```
Context Diagram:
┌─────────────────────────────────────────────────────────────────┐
│                         [System Context]                        │
│  ┌──────────┐     ┌──────────────────┐     ┌──────────────────┐ │
│  │  User    │────▶│   Our System     │────▶│ External Service │ │
│  │  [Actor] │     │   [Container]    │     │ [External System]│ │
│  └──────────┘     └──────────────────┘     └──────────────────┘ │
└─────────────────────────────────────────────────────────────────┘

Container Diagram:
┌───────────────────────────────────────────────────────────────────────┐
│                        [System Containers]                            │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐               │
│  │   Web App   │───▶│   API       │───▶│  Database   │               │
│  │   [React]   │    │  [Node.js]  │    │ [PostgreSQL]│               │
│  └─────────────┘    └─────────────┘    └─────────────┘               │
│                           │                                           │
│                           ▼                                           │
│                     ┌─────────────┐                                   │
│                     │   Queue     │                                   │
│                     │  [Redis]    │                                   │
│                     └─────────────┘                                   │
└───────────────────────────────────────────────────────────────────────┘
```

## Architecture Decision Record (ADR) Template

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

What other options were evaluated and why were they rejected?
```

## Domain-Specific Patterns

### Code Architecture

```yaml
Component Design Example:
  ## UserService
  - **Path**: `src/services/UserService.ts`
  - **Responsibility**: User CRUD operations, authentication coordination
  - **Dependencies**: Database, AuthService, EmailService
  - **Interface**: IUserService

  ## Implementation Phases
  - [ ] Phase 1: Create base service with CRUD
  - [ ] Phase 2: Add authentication integration
  - [ ] Phase 3: Add email notification triggers
```

### Backend Architecture

```yaml
API Endpoint Design:
  | Method | Path              | Purpose                    |
  |--------|-------------------|----------------------------|
  | GET    | /api/v1/users     | List users with pagination |
  | POST   | /api/v1/users     | Create new user            |
  | GET    | /api/v1/users/:id | Get user by ID             |
  | PUT    | /api/v1/users/:id | Update user                |
  | DELETE | /api/v1/users/:id | Delete user                |

Error Handling:
  - RFC 7807 Problem Details format
  - Standard error codes: 400, 401, 403, 404, 500
```

### Frontend Architecture

```yaml
Directory Structure:
  src/
  ├── components/
  │   ├── ui/           # Base UI components (Button, Input)
  │   ├── features/     # Feature-specific components
  │   └── layouts/      # Page layouts
  ├── hooks/            # Custom React hooks
  ├── stores/           # Zustand stores
  └── lib/              # Utilities

State Management:
  - Global: Zustand for app-wide state
  - Server: TanStack Query for API data
  - Local: useState for component state
```

### DevOps Architecture

```yaml
CI/CD Pipeline Stages:
  1. **Build**: Compile, lint, type-check
  2. **Test**: Unit tests, integration tests
  3. **Security**: SAST, dependency scanning
  4. **Deploy Staging**: Auto-deploy to staging
  5. **Deploy Production**: Manual approval required

Deployment Strategy:
  - Strategy: Blue-Green with instant rollback
  - Health checks: Readiness + Liveness probes
  - Rollback: Automatic on failed health checks
```

## Scalability Patterns

### Horizontal Scaling

```yaml
Patterns:
  - Stateless services with external session storage
  - Database read replicas for read-heavy workloads
  - Queue-based load leveling for async processing
  - CDN for static assets and edge caching

Implementation:
  - Session: Redis Cluster for session storage
  - Database: PostgreSQL with read replicas
  - Queue: Redis Streams or RabbitMQ
  - Cache: Redis with consistent hashing
```

### Event-Driven Architecture

```yaml
Patterns:
  - Event sourcing for audit trails
  - CQRS for read/write optimization
  - Saga pattern for distributed transactions
  - Outbox pattern for reliable messaging

Implementation:
  - Events: Define event schema with versioning
  - Store: Append-only event log
  - Projections: Build read models from events
  - Handlers: Idempotent event processors
```

### Microservices Boundaries

```yaml
Decision Criteria:
  - Team autonomy requirements
  - Independent deployment needs
  - Different scaling requirements
  - Technology diversity needs
  - Data ownership boundaries

Decomposition Strategies:
  - Domain-Driven Design bounded contexts
  - Business capability alignment
  - Data ownership and consistency needs
  - Team structure (Conway's Law)

Communication Patterns:
  - Sync: REST/gRPC for queries
  - Async: Events for commands and notifications
  - Service mesh for cross-cutting concerns
```

## Technology Selection Framework

```yaml
Decision Process:
  1. Define quality attributes (scalability, reliability, security)
  2. Identify constraints (team, timeline, existing tech)
  3. Evaluate patterns against requirements
  4. Analyze trade-offs
  5. Make decisive recommendation
  6. Document rationale in ADR format
```

## Domain Selection Guide

| Domain       | Triggers                              | Primary Focus                    |
| ------------ | ------------------------------------- | -------------------------------- |
| **Code**     | "design feature", "code architecture" | Component design, implementation |
| **Backend**  | "API design", "database schema"       | Data integrity, security         |
| **Frontend** | "UI architecture", "accessibility"    | UX, WCAG, Core Web Vitals        |
| **System**   | "scalability", "technology selection" | 10x growth, patterns             |
| **DevOps**   | "CI/CD", "Kubernetes"                 | Automation, observability        |

## Research Workflow

```yaml
Phase 1 - Analyze Context:
  - Glob: src/**/*.ts to understand structure
  - Grep: "import.*from" to map dependencies
  - Read: package.json, ARCHITECTURE.md

Phase 2 - Research Best Practices:
  - mcp__context7__resolve-library-id for frameworks
  - mcp__github__search_code for patterns
  - mcp__tavily__tavily-search for best practices

Phase 3 - Design Architecture:
  - Use Sequential Thinking for complex decisions
  - Consider trade-offs across domains
  - Document in ADR format

Phase 4 - Deliver Blueprint:
  - Component design with file paths
  - Implementation phases as checklist
  - Operational considerations
```
