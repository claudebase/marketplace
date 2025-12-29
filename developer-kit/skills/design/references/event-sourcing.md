# Event Sourcing Reference

## Core Concepts

### What is Event Sourcing?

Instead of storing current state, store a sequence of events that led to that state.

```
Traditional: User { balance: 150 }

Event Sourcing:
  1. AccountCreated { userId: 1, initialBalance: 100 }
  2. MoneyDeposited { userId: 1, amount: 100 }
  3. MoneyWithdrawn { userId: 1, amount: 50 }
  → Computed balance: 150
```

### Benefits

- **Complete audit trail** - Every change is recorded
- **Temporal queries** - Reconstruct state at any point in time
- **Event replay** - Rebuild projections, fix bugs
- **Debugging** - Understand exactly what happened
- **Decoupling** - Producers don't know about consumers

### When to Use

| Use Case | Event Sourcing? |
|----------|-----------------|
| Audit requirements | ✅ Yes |
| Complex domain logic | ✅ Yes |
| Event-driven architecture | ✅ Yes |
| Simple CRUD | ❌ Overkill |
| High-frequency updates | ⚠️ Consider carefully |

## Event Structure

### Event Format

```typescript
interface DomainEvent {
  // Identity
  eventId: string;           // Unique event ID
  aggregateId: string;       // ID of the entity
  aggregateType: string;     // Type of entity

  // Event details
  eventType: string;         // What happened
  eventData: object;         // Event payload
  metadata: object;          // Context (user, timestamp, etc.)

  // Ordering
  version: number;           // Aggregate version
  timestamp: Date;           // When it happened
}
```

### Example Events

```typescript
// Order aggregate events
interface OrderCreated {
  eventType: 'OrderCreated';
  eventData: {
    orderId: string;
    customerId: string;
    items: Array<{ productId: string; quantity: number; price: number }>;
  };
}

interface OrderItemAdded {
  eventType: 'OrderItemAdded';
  eventData: {
    orderId: string;
    productId: string;
    quantity: number;
    price: number;
  };
}

interface OrderSubmitted {
  eventType: 'OrderSubmitted';
  eventData: {
    orderId: string;
    submittedAt: Date;
    totalAmount: number;
  };
}

interface OrderCancelled {
  eventType: 'OrderCancelled';
  eventData: {
    orderId: string;
    reason: string;
    cancelledAt: Date;
  };
}
```

## Aggregates

### Aggregate Pattern

```typescript
class Order {
  private id: string;
  private status: OrderStatus;
  private items: OrderItem[] = [];
  private uncommittedEvents: DomainEvent[] = [];

  // Reconstruct from events
  static fromEvents(events: DomainEvent[]): Order {
    const order = new Order();
    events.forEach(event => order.apply(event));
    return order;
  }

  // Command: Add item
  addItem(productId: string, quantity: number, price: number): void {
    if (this.status !== 'draft') {
      throw new Error('Cannot modify submitted order');
    }

    // Emit event instead of mutating directly
    this.emit({
      eventType: 'OrderItemAdded',
      eventData: { orderId: this.id, productId, quantity, price }
    });
  }

  // Command: Submit order
  submit(): void {
    if (this.items.length === 0) {
      throw new Error('Cannot submit empty order');
    }

    this.emit({
      eventType: 'OrderSubmitted',
      eventData: {
        orderId: this.id,
        submittedAt: new Date(),
        totalAmount: this.calculateTotal()
      }
    });
  }

  // Apply event to update state
  private apply(event: DomainEvent): void {
    switch (event.eventType) {
      case 'OrderCreated':
        this.id = event.eventData.orderId;
        this.status = 'draft';
        break;
      case 'OrderItemAdded':
        this.items.push(event.eventData);
        break;
      case 'OrderSubmitted':
        this.status = 'submitted';
        break;
      case 'OrderCancelled':
        this.status = 'cancelled';
        break;
    }
  }

  private emit(event: Partial<DomainEvent>): void {
    const fullEvent = {
      ...event,
      eventId: uuid(),
      aggregateId: this.id,
      version: this.version + 1,
      timestamp: new Date()
    };
    this.apply(fullEvent);
    this.uncommittedEvents.push(fullEvent);
  }
}
```

## Event Store

### PostgreSQL Event Store

```sql
CREATE TABLE events (
  event_id UUID PRIMARY KEY,
  aggregate_id UUID NOT NULL,
  aggregate_type VARCHAR(100) NOT NULL,
  event_type VARCHAR(100) NOT NULL,
  event_data JSONB NOT NULL,
  metadata JSONB DEFAULT '{}',
  version INT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),

  UNIQUE (aggregate_id, version)
);

CREATE INDEX idx_events_aggregate ON events(aggregate_id, version);
CREATE INDEX idx_events_type ON events(event_type);
CREATE INDEX idx_events_created ON events(created_at);
```

### Event Store Operations

```typescript
class EventStore {
  // Append events with optimistic concurrency
  async append(
    aggregateId: string,
    events: DomainEvent[],
    expectedVersion: number
  ): Promise<void> {
    await db.transaction(async (trx) => {
      // Check version (optimistic locking)
      const currentVersion = await trx('events')
        .where({ aggregate_id: aggregateId })
        .max('version as version')
        .first();

      if (currentVersion?.version !== expectedVersion) {
        throw new ConcurrencyError('Aggregate was modified');
      }

      // Insert events
      await trx('events').insert(
        events.map((e, i) => ({
          event_id: e.eventId,
          aggregate_id: aggregateId,
          aggregate_type: e.aggregateType,
          event_type: e.eventType,
          event_data: e.eventData,
          metadata: e.metadata,
          version: expectedVersion + i + 1
        }))
      );
    });
  }

  // Load aggregate events
  async getEvents(aggregateId: string): Promise<DomainEvent[]> {
    return db('events')
      .where({ aggregate_id: aggregateId })
      .orderBy('version', 'asc');
  }

  // Stream all events (for projections)
  async *streamAllEvents(fromPosition?: number): AsyncGenerator<DomainEvent> {
    let lastId = fromPosition || 0;
    const batchSize = 100;

    while (true) {
      const events = await db('events')
        .where('id', '>', lastId)
        .orderBy('id')
        .limit(batchSize);

      if (events.length === 0) break;

      for (const event of events) {
        yield event;
        lastId = event.id;
      }
    }
  }
}
```

## Projections (Read Models)

### Building Projections

```typescript
class OrderSummaryProjection {
  async handle(event: DomainEvent): Promise<void> {
    switch (event.eventType) {
      case 'OrderCreated':
        await db('order_summaries').insert({
          order_id: event.eventData.orderId,
          customer_id: event.eventData.customerId,
          status: 'draft',
          item_count: 0,
          total_amount: 0
        });
        break;

      case 'OrderItemAdded':
        await db('order_summaries')
          .where({ order_id: event.eventData.orderId })
          .increment('item_count', 1)
          .increment('total_amount', event.eventData.price * event.eventData.quantity);
        break;

      case 'OrderSubmitted':
        await db('order_summaries')
          .where({ order_id: event.eventData.orderId })
          .update({
            status: 'submitted',
            submitted_at: event.eventData.submittedAt
          });
        break;
    }
  }
}

// Projection runner
class ProjectionRunner {
  async run(projection: Projection): Promise<void> {
    const checkpoint = await this.getCheckpoint(projection.name);

    for await (const event of eventStore.streamAllEvents(checkpoint)) {
      await projection.handle(event);
      await this.saveCheckpoint(projection.name, event.id);
    }
  }
}
```

## CQRS (Command Query Responsibility Segregation)

### Architecture

```
Commands                           Queries
    │                                  │
    ▼                                  ▼
┌─────────┐                      ┌─────────┐
│ Command │                      │  Query  │
│ Handler │                      │ Handler │
└────┬────┘                      └────┬────┘
     │                                │
     ▼                                ▼
┌─────────┐                      ┌─────────┐
│  Event  │──── Events ────────▶│  Read   │
│  Store  │                      │  Model  │
└─────────┘                      └─────────┘
```

### Implementation

```typescript
// Command side
class CreateOrderHandler {
  async handle(command: CreateOrderCommand): Promise<void> {
    const order = Order.create(command);
    await eventStore.append(
      order.id,
      order.uncommittedEvents,
      0
    );
  }
}

// Query side (fast reads from optimized projections)
class OrderQueryService {
  async getOrderSummary(orderId: string): Promise<OrderSummary> {
    return db('order_summaries')
      .where({ order_id: orderId })
      .first();
  }

  async getCustomerOrders(customerId: string): Promise<OrderSummary[]> {
    return db('order_summaries')
      .where({ customer_id: customerId })
      .orderBy('created_at', 'desc');
  }
}
```

## Snapshots

For aggregates with many events, use snapshots:

```typescript
interface Snapshot {
  aggregateId: string;
  version: number;
  state: object;
  createdAt: Date;
}

class SnapshotStore {
  async save(aggregate: Aggregate): Promise<void> {
    await db('snapshots').insert({
      aggregate_id: aggregate.id,
      version: aggregate.version,
      state: aggregate.toSnapshot(),
      created_at: new Date()
    });
  }

  async load(aggregateId: string): Promise<Aggregate> {
    const snapshot = await db('snapshots')
      .where({ aggregate_id: aggregateId })
      .orderBy('version', 'desc')
      .first();

    const events = await eventStore.getEvents(
      aggregateId,
      snapshot?.version || 0
    );

    return Aggregate.fromSnapshot(snapshot, events);
  }
}
```

## Best Practices

1. **Events are immutable** - Never modify published events
2. **Events are past tense** - OrderCreated, not CreateOrder
3. **Events are domain-centric** - Business meaning, not technical
4. **Handle versioning** - Plan for event schema evolution
5. **Test event handlers** - Unit test state changes
6. **Monitor projections** - Track lag and errors
