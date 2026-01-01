# Confidence Check - Examples

Real-world examples of confidence assessments.

## Example 1: High Confidence (Proceed)

**Task**: Add pagination to user list API

```
📋 Confidence Checks:
   ✅ No duplicate implementations found
      - Searched: pagination, paginate, limit offset
      - Result: No existing pagination in /api/users

   ✅ Uses existing tech stack
      - Framework: Next.js API routes (existing)
      - Database: Prisma (existing)
      - Pattern: Cursor-based pagination

   ✅ Official documentation verified
      - Prisma pagination: cursor vs offset
      - Reviewed: /prisma/docs "pagination"

   ✅ Working OSS implementation found
      - Reference: t3-app/examples/pagination
      - Pattern: Cursor with take/skip

   ✅ Root cause identified
      - Issue: Full user list causes timeout
      - Solution: Return 20 users per page

📊 Confidence: 1.00 (100%)
✅ High confidence - Proceeding to implementation
```

---

## Example 2: Medium Confidence (Clarify)

**Task**: Add real-time notifications

```
📋 Confidence Checks:
   ✅ No duplicate implementations found
      - Searched: notification, websocket, real-time
      - Result: No existing notification system

   ⚠️ Architecture decision needed
      - Options: WebSockets vs SSE vs Polling
      - No existing pattern in codebase
      - Need to decide on approach

   ✅ Official documentation verified
      - WebSocket: MDN docs reviewed
      - Socket.io: /socketio/socket.io docs

   ❌ No OSS implementation found
      - Searched for similar scale project
      - Most examples are chat apps (different use case)

   ✅ Root cause identified
      - Need: Users need instant updates
      - Current: Polling every 30s is too slow

📊 Confidence: 0.75 (75%)
⚠️ Medium confidence - Clarification needed before proceeding

Questions:
1. Should we use WebSockets or Server-Sent Events?
2. What's the expected message volume?
3. Do we need to support offline/reconnection?
```

---

## Example 3: Low Confidence (Stop)

**Task**: Fix "undefined" error in checkout

```
📋 Confidence Checks:
   ❌ Possible duplicate found
      - Similar fix attempted in commit abc123
      - That fix was reverted

   ⚠️ Architecture unclear
      - Checkout flow spans 5 services
      - Not sure which service owns the bug

   ❌ Documentation not found
      - No internal docs for checkout flow
      - Third-party payment API docs incomplete

   ❌ No OSS implementation found
      - Proprietary payment integration
      - No similar examples available

   ❌ Root cause uncertain
      - "undefined" could be from:
        - Missing user session
        - Failed API call
        - Race condition
      - Need to reproduce and trace

📊 Confidence: 0.35 (35%)
❌ Low confidence - Cannot proceed

Blockers:
1. Need to reproduce the error locally
2. Need checkout flow documentation
3. Need to trace which service fails
4. Previous fix attempt was reverted - why?

Next Steps:
1. Add logging to checkout flow
2. Get access to error monitoring
3. Review reverted commit for context
```

---

## Example 4: Partial Confidence (Investigate)

**Task**: Optimize slow dashboard query

```
📋 Confidence Checks:
   ✅ No duplicate implementations found
      - No existing optimization attempts

   ✅ Uses existing tech stack
      - PostgreSQL, Prisma

   ⚠️ Official documentation partially reviewed
      - Prisma query optimization: reviewed
      - PostgreSQL EXPLAIN: need to run

   ✅ Working OSS implementation found
      - Pattern: Materialized views for dashboards
      - Reference: Supabase analytics example

   ⚠️ Root cause partially identified
      - Slow query identified via logs
      - But haven't run EXPLAIN ANALYZE yet
      - Could be missing index or N+1

📊 Confidence: 0.80 (80%)
⚠️ Medium confidence - Need profiling data

Action:
Run EXPLAIN ANALYZE on the slow query to confirm root cause,
then proceed with appropriate optimization.
```
