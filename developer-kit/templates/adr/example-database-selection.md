# ADR-001: Primary Database Selection

## Status

**Status**: Accepted

**Date**: 2024-01-15

**Decision Makers**: Tech Lead, Backend Team, DevOps Lead

## Context

Our application requires a primary database for storing user data, transactions, and application state. We need to select a database that meets our performance, scalability, and operational requirements.

### Background

We are building a SaaS platform with the following characteristics:
- Expected 10,000 users in year 1, scaling to 100,000+ by year 3
- Mix of read-heavy (80%) and write (20%) operations
- Strong consistency requirements for financial transactions
- Need for complex queries and reporting
- Team has experience with SQL databases

### Requirements

- ACID compliance for transaction integrity
- Support for complex queries (joins, aggregations)
- Horizontal read scaling capability
- High availability (99.9% uptime SLA)
- Good tooling and monitoring support
- Active community and long-term viability

### Constraints

- Budget: Standard cloud pricing acceptable, avoid enterprise licenses
- Team expertise: Strong SQL skills, limited NoSQL experience
- Timeline: MVP in 3 months, must make decision within 2 weeks
- Infrastructure: Running on AWS, prefer managed services

## Decision

We will use **PostgreSQL** via **Amazon RDS** as our primary database.

### Chosen Option

PostgreSQL on Amazon RDS with read replicas for scaling.

### Rationale

PostgreSQL provides the best balance of our requirements:
1. Full ACID compliance for our transaction needs
2. Excellent query performance with advanced indexing
3. JSON/JSONB support for flexible data when needed
4. Strong AWS integration via RDS
5. Team already proficient in SQL
6. Active community and extensive documentation

## Options Considered

### Option 1: PostgreSQL (Amazon RDS)

**Description**: Open-source relational database with advanced features, managed via AWS RDS.

**Pros**:
- Full ACID compliance
- Advanced indexing (B-tree, GIN, GiST)
- JSONB for semi-structured data
- Excellent query planner
- Read replicas for scaling
- Mature, battle-tested

**Cons**:
- Vertical scaling has limits
- Complex sharding if needed later
- Higher memory usage than MySQL

**Estimated Effort**: Low (team expertise exists)

### Option 2: MySQL (Amazon RDS)

**Description**: Popular open-source relational database with wide adoption.

**Pros**:
- Simple and reliable
- Wide ecosystem support
- Lower resource usage
- Good read replica support

**Cons**:
- Less advanced query features
- Weaker JSON support
- Less sophisticated query planner
- InnoDB limitations for certain workloads

**Estimated Effort**: Low

### Option 3: MongoDB (Atlas)

**Description**: Document database with flexible schema.

**Pros**:
- Flexible schema for rapid iteration
- Built-in horizontal scaling
- Good for document-oriented data
- Native cloud offering (Atlas)

**Cons**:
- Eventual consistency by default
- No native JOINs (requires application-level joins)
- Team lacks NoSQL experience
- Less suitable for complex transactions

**Estimated Effort**: High (learning curve)

### Option 4: CockroachDB

**Description**: Distributed SQL database with PostgreSQL compatibility.

**Pros**:
- PostgreSQL compatible
- Built-in horizontal scaling
- Global distribution support
- Strong consistency

**Cons**:
- Higher operational complexity
- More expensive at scale
- Newer, less battle-tested
- Potential latency overhead

**Estimated Effort**: Medium

## Consequences

### Positive

- Team can leverage existing SQL expertise
- Strong consistency guarantees from day one
- Flexibility to add JSON data when needed
- Clear path to read scaling via replicas
- Managed service reduces operational burden

### Negative

- May need to consider sharding for extreme scale (100M+ records)
- RDS costs scale with instance size
- Locked into AWS (manageable risk)

### Risks

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Outgrow single-master | Medium | High | Design for read replicas, consider Citus extension |
| RDS outage | Low | High | Multi-AZ deployment, backup strategy |
| Cost escalation | Medium | Medium | Monitor usage, right-size instances, reserved capacity |

## Implementation

### Action Items

- [x] Create RDS PostgreSQL instance in staging
- [x] Configure Multi-AZ for production
- [x] Set up automated backups (7-day retention)
- [x] Create read replica for analytics queries
- [ ] Implement connection pooling (PgBouncer)
- [ ] Set up monitoring dashboards
- [ ] Document backup/restore procedures

### Timeline

- Week 1: Staging environment setup
- Week 2: Production provisioning and security review
- Week 3: Application migration and testing
- Week 4: Go-live with monitoring

### Success Metrics

- Query p99 latency < 100ms for standard operations
- 99.9% database availability
- Successful failover during Multi-AZ testing
- Backup restoration tested quarterly

## Related Decisions

- [ADR-002: Caching Strategy](./ADR-002-caching-strategy.md)
- [ADR-003: Database Connection Management](./ADR-003-connection-management.md)

## References

- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Amazon RDS for PostgreSQL](https://aws.amazon.com/rds/postgresql/)
- [Scaling PostgreSQL](https://www.citusdata.com/blog/scaling-postgres/)
- [Internal: Database Requirements Document](../docs/requirements/database.md)

---

## Notes

**2024-01-10 Meeting Summary**:
- Discussed all four options with team
- MongoDB ruled out due to consistency requirements
- CockroachDB considered overkill for current scale
- MySQL vs PostgreSQL was close, PostgreSQL won on features

**2024-01-12 Follow-up**:
- Confirmed RDS pricing with finance
- Approved Multi-AZ for production
- Decided to start with db.r6g.large, monitor and adjust
