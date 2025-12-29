# Architecture Patterns Reference

## Architectural Styles

### Monolithic
```
┌─────────────────────────────────────┐
│           Application               │
│  ┌─────────┬─────────┬─────────┐   │
│  │   UI    │ Business│  Data   │   │
│  │  Layer  │  Logic  │  Layer  │   │
│  └─────────┴─────────┴─────────┘   │
└─────────────────────────────────────┘
```
**When to use**: Simple apps, small teams, quick iteration needed
**Avoid when**: Multiple teams, independent scaling needed

### Microservices
```
┌─────────┐ ┌─────────┐ ┌─────────┐
│Service A│ │Service B│ │Service C│
└────┬────┘ └────┬────┘ └────┬────┘
     │           │           │
     └───────────┼───────────┘
                 │
          ┌──────┴──────┐
          │  API Gateway │
          └─────────────┘
```
**When to use**: Large teams, independent deployment, different tech stacks
**Avoid when**: Small team, simple domain, shared data model

### Event-Driven
```
┌─────────┐     ┌─────────────┐     ┌─────────┐
│Producer │────▶│ Event Bus   │────▶│Consumer │
└─────────┘     │(Kafka/SQS)  │     └─────────┘
                └─────────────┘
```
**When to use**: Async processing, decoupled systems, audit trails
**Avoid when**: Simple CRUD, strong consistency needed

### Serverless
```
┌─────────┐     ┌─────────┐     ┌─────────┐
│ Client  │────▶│API GW   │────▶│ Lambda  │
└─────────┘     └─────────┘     └────┬────┘
                                     │
                               ┌─────┴─────┐
                               │ DynamoDB  │
                               └───────────┘
```
**When to use**: Variable load, pay-per-use, rapid development
**Avoid when**: Long-running processes, low latency needed

## Common Patterns

### API Gateway
```
                 ┌──────────────┐
   Clients ─────▶│  API Gateway │
                 ├──────────────┤
                 │ • Auth       │
                 │ • Rate Limit │
                 │ • Routing    │
                 └──────┬───────┘
            ┌──────────┼──────────┐
            ▼          ▼          ▼
        Service A  Service B  Service C
```

### CQRS (Command Query Responsibility Segregation)
```
┌─────────┐                    ┌─────────┐
│ Command │───▶ Write Model ───▶│Write DB │
└─────────┘                    └─────────┘
                                    │
                                    ▼ (sync)
┌─────────┐                    ┌─────────┐
│  Query  │◀─── Read Model ◀───│ Read DB │
└─────────┘                    └─────────┘
```

### Saga Pattern (Distributed Transactions)
```
Order Service          Payment Service        Inventory Service
     │                       │                       │
     │ 1. Create Order       │                       │
     │──────────────────────▶│ 2. Reserve Payment   │
     │                       │──────────────────────▶│
     │                       │                       │ 3. Reserve Stock
     │                       │◀──────────────────────│
     │ 4. Confirm            │                       │
     │◀──────────────────────│                       │
```

### Circuit Breaker
```
        ┌─────────────────────────────────┐
        │         Circuit Breaker         │
        ├─────────┬─────────┬─────────────┤
        │ CLOSED  │ OPEN    │ HALF-OPEN   │
        │(normal) │(failing)│ (testing)   │
        └─────────┴─────────┴─────────────┘
                      │
        Failure ──────┘ ────▶ Timeout ────▶ Try again
```

## Database Patterns

### Single Database
```
┌─────────────┐
│ Application │
└──────┬──────┘
       │
┌──────┴──────┐
│  Database   │
└─────────────┘
```

### Database per Service
```
┌─────────┐  ┌─────────┐  ┌─────────┐
│Service A│  │Service B│  │Service C│
└────┬────┘  └────┬────┘  └────┬────┘
     │            │            │
┌────┴────┐  ┌────┴────┐  ┌────┴────┐
│  DB A   │  │  DB B   │  │  DB C   │
└─────────┘  └─────────┘  └─────────┘
```

### Read Replicas
```
        ┌─────────────┐
Writes ─▶│   Primary   │
        └──────┬──────┘
               │ replication
      ┌────────┼────────┐
      ▼        ▼        ▼
┌─────────┐┌─────────┐┌─────────┐
│Replica 1││Replica 2││Replica 3│◀─ Reads
└─────────┘└─────────┘└─────────┘
```

## Scalability Patterns

### Horizontal Scaling
```
                Load Balancer
                     │
        ┌────────────┼────────────┐
        ▼            ▼            ▼
    Instance 1   Instance 2   Instance 3
```

### Caching Layer
```
Client ──▶ Cache ──miss──▶ Database
              │
              └──hit──▶ Response
```

### CDN Pattern
```
User ──▶ CDN Edge ──cache miss──▶ Origin Server
             │
             └──cache hit──▶ Response
```

## Decision Matrix

| Pattern | Complexity | Scalability | Team Size | Use Case |
|---------|------------|-------------|-----------|----------|
| Monolith | Low | Limited | Small | MVP, startups |
| Microservices | High | High | Large | Enterprise |
| Serverless | Medium | Auto | Any | Event-driven |
| Event-Driven | Medium | High | Medium | Async processing |
