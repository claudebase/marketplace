# Implement Skill - Detailed Guide

Feature and code implementation with framework-specific best practices using official documentation and real-world patterns.

**Core Principle**: "Implement features that follow framework conventions, are type-safe, and integrate cleanly."

---

## Behavioral Flow

```
┌──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
│  UNDERSTAND  │   RESEARCH   │     PLAN     │  IMPLEMENT   │    VERIFY    │
├──────────────┼──────────────┼──────────────┼──────────────┼──────────────┤
│ Read existing│ Query        │ Break down   │ Write code   │ Test and     │
│ code and     │ Context7 for │ into tasks   │ following    │ validate     │
│ patterns     │ framework    │ using        │ framework    │ implementation│
│              │ docs         │ sequential   │ conventions  │              │
│ Identify     │ Search       │ thinking     │ Use shadcn   │ Run tests    │
│ conventions  │ GitHub for   │              │ for UI       │ Check UI     │
│              │ examples     │              │ components   │ with Playwright│
└──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘
     Read           Context7      Sequential      Write         Bash
     Grep           GitHub        Thinking        Edit          Playwright
                    shadcn
```

---

## Phase Details

### Phase 1: UNDERSTAND

Analyze existing codebase patterns:

1. **Read project structure** - Identify folder conventions, naming patterns
2. **Find similar implementations** - Search for related components/functions
3. **Identify tech stack** - Framework, libraries, styling approach
4. **Note conventions** - Coding style, error handling patterns

**Tools**: Read, Grep, Glob

### Phase 2: RESEARCH

Gather implementation guidance:

```
# Query framework documentation
mcp__context7__resolve-library-id → Get library ID
mcp__context7__query-docs → Get implementation patterns

# Find real-world examples
mcp__github__search_code("pattern filename:.tsx")

# For UI components
mcp__shadcn__search_items_in_registries → Find components
mcp__shadcn__view_items_in_registries → Get component details
```

**Tools**: Context7, GitHub MCP, shadcn MCP

### Phase 3: PLAN

Break down implementation:

```
mcp__sequential-thinking__sequentialthinking
- What components/functions are needed?
- What's the implementation order?
- What dependencies exist between parts?
- What edge cases should be handled?
```

**Tools**: Sequential Thinking, TodoWrite

### Phase 4: IMPLEMENT

Write code following patterns:

1. **Create files** - Use Write for new files
2. **Edit existing** - Use Edit for modifications
3. **Follow conventions** - Match existing code style
4. **Add types** - Ensure type safety
5. **Handle errors** - Add appropriate error handling

**Tools**: Write, Edit, Bash

### Phase 5: VERIFY

Validate implementation:

```
# Run tests
npm test / pytest / go test

# Check UI with Playwright
mcp__playwright__browser_navigate
mcp__playwright__browser_snapshot
```

**Tools**: Bash, Playwright

---

## MCP Tool Integration

### Context7 (Documentation)

**Primary source for framework patterns:**

| Resource | Library ID                   | Use Case         |
| -------- | ---------------------------- | ---------------- |
| React    | `/facebook/react`            | UI components    |
| Next.js  | `/vercel/next.js`            | Full-stack React |
| FastAPI  | `/websites/fastapi_tiangolo` | Python APIs      |
| Express  | `/expressjs/express`         | Node.js APIs     |
| Vue      | `/vuejs/core`                | Vue components   |

### shadcn MCP (UI Components)

**For React/Next.js UI implementation:**

```
mcp__shadcn__search_items_in_registries - Find components
mcp__shadcn__view_items_in_registries - View component code
mcp__shadcn__get_add_command_for_items - Get install command
```

### GitHub MCP (Examples)

**Find real implementations:**

```
mcp__github__search_code - Find patterns
mcp__github__get_file_contents - Get full files
```

---

## Implementation Patterns

### React Component

```typescript
// 1. Import dependencies
import { useState } from 'react'
import { Button } from '@/components/ui/button'

// 2. Define types
interface Props {
  title: string
  onSubmit: (data: FormData) => void
}

// 3. Implement component
export function MyComponent({ title, onSubmit }: Props) {
  const [state, setState] = useState(initialState)

  // 4. Handle events
  const handleSubmit = () => {
    onSubmit(state)
  }

  // 5. Return JSX
  return (
    <div>
      <h1>{title}</h1>
      <Button onClick={handleSubmit}>Submit</Button>
    </div>
  )
}
```

### API Endpoint (Next.js)

```typescript
// app/api/items/route.ts
import { NextResponse } from "next/server";

export async function GET() {
  const items = await db.items.findMany();
  return NextResponse.json(items);
}

export async function POST(request: Request) {
  const body = await request.json();
  const item = await db.items.create({ data: body });
  return NextResponse.json(item, { status: 201 });
}
```

---

## Handoffs

| Scenario           | Hand off to           |
| ------------------ | --------------------- |
| Need code analysis | `analyze` skill       |
| Multi-domain task  | `orchestration` skill |
| Performance issues | `performance` skill   |
| Bug found          | `debug` skill         |
| Need tests         | `test` skill          |

---

## Related Reference Files

- [implementation-patterns.md](implementation-patterns.md) - Framework-specific patterns
