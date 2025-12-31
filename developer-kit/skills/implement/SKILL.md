---
name: implement
description: "Feature and code implementation with framework-specific best practices. Use for building components, APIs, services, or complete features. Activates for: implement, create, build feature, add functionality, code this, make a, develop."
allowed-tools:
  # Core Analysis
  - Read
  - Grep
  - Glob
  - Bash
  # Implementation
  - Edit
  - Write
  - TodoWrite
  - Task
  # Framework Documentation
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  # Pattern Research
  - mcp__github__search_code
  - mcp__github__get_file_contents
  # Best Practices Research
  - mcp__tavily__tavily-search
  - mcp__tavily__tavily-extract
  # UI Components
  - mcp__shadcn__search_items_in_registries
  - mcp__shadcn__view_items_in_registries
  - mcp__shadcn__get_item_examples_from_registries
  - mcp__shadcn__get_add_command_for_items
  # Implementation Validation
  - mcp__playwright__browser_navigate
  - mcp__playwright__browser_snapshot
  - mcp__playwright__browser_click
  - mcp__playwright__browser_type
  - mcp__playwright__browser_fill_form
  # Structured Planning
  - mcp__sequential-thinking__sequentialthinking
---

# Implement Skill

Feature and code implementation with framework-specific best practices using official documentation from Context7 and real-world patterns from production codebases.

**Core Principle**: "Implement features that follow framework conventions, are type-safe, and integrate cleanly with existing code."

**Key Enhancement**: Research official framework documentation and find real patterns before implementing features.

**Key Distinction**: This skill IMPLEMENTS features. For complex multi-domain operations, use the `orchestration` skill. For code analysis, use the `analyze` skill.

## Activation Triggers

- Feature implementation ("implement", "create", "build feature")
- Component creation ("add component", "create component")
- API development ("build API", "create endpoint")
- Service implementation ("implement service", "create service")
- Full-stack features ("add functionality", "develop feature")

## Do NOT Activate When

- Complex multi-domain orchestration → use `orchestration` skill
- Code analysis or review → use `analyze` skill
- Bug fixing → use `debug` skill
- Test strategy design → use `quality` skill
- Architecture design only → use `design` skill

**Boundary Clarification:**
This skill implements features following framework best practices. For complex multi-step operations requiring coordination, use the `orchestration` skill. For analyzing existing code, use the `analyze` skill.

## Behavioral Flow

```
┌──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
│   ANALYZE    │   RESEARCH   │    PLAN      │  IMPLEMENT   │   VALIDATE   │
├──────────────┼──────────────┼──────────────┼──────────────┼──────────────┤
│ Examine      │ Lookup       │ Design       │ Generate     │ Test and     │
│ requirements │ framework    │ implementation│ code with   │ verify       │
│ and context  │ patterns     │ approach     │ best practices│ functionality│
│              │              │              │              │              │
│ Detect       │ Find         │ Choose       │ Apply        │ Validate     │
│ technology   │ official     │ appropriate  │ framework    │ with         │
│ stack        │ documentation│ patterns     │ conventions  │ Playwright   │
│              │              │              │              │              │
│ Review       │ Research     │ Consider     │ Add proper   │ Check        │
│ existing     │ real-world   │ security     │ types and    │ edge cases   │
│ patterns     │ examples     │ implications │ validation   │              │
└──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘
     Read           Context7      Sequential      Write          Playwright
     Grep           GitHub        Thinking        Edit           Bash
     Glob           Tavily                        Shadcn
```

### Phase 1: ANALYZE

Understand the implementation requirements and technology context:

1. **Examine requirements** - What feature needs to be built?
2. **Detect technology** - What frameworks and libraries are in use?
3. **Review existing patterns** - How are similar features implemented?
4. **Identify dependencies** - What existing code will this integrate with?

```bash
# Detect framework from package files
Read - package.json, requirements.txt, go.mod, Cargo.toml

# Find existing patterns
Grep - Similar component/API patterns in codebase

# Check project structure
Glob - Find related files and conventions
```

**Tools**: Read, Grep, Glob

### Phase 2: RESEARCH

Gather framework documentation and implementation patterns:

```
# Lookup React patterns
mcp__context7__resolve-library-id → "/reactjs/react.dev"
mcp__context7__query-docs("hooks useState useEffect patterns")

# Lookup Vue patterns
mcp__context7__resolve-library-id → "/vuejs/docs"
mcp__context7__query-docs("composition API reactive refs")

# Lookup Next.js patterns
mcp__context7__resolve-library-id → "/websites/nextjs_app"
mcp__context7__query-docs("server components app router")

# Lookup NestJS patterns
mcp__context7__resolve-library-id → "/websites/nestjs"
mcp__context7__query-docs("controller service dependency injection")

# Lookup FastAPI patterns
mcp__context7__resolve-library-id → "/websites/fastapi_tiangolo"
mcp__context7__query-docs("endpoints Pydantic validation")

# Find real-world examples
mcp__github__search_code("useEffect cleanup return filename:.tsx stars:>500")

# Research current best practices
mcp__tavily__tavily-search("React component best practices 2024")
```

**Tools**: Context7, GitHub MCP, Tavily

### Phase 3: PLAN

Design the implementation approach:

```
mcp__sequential-thinking__sequentialthinking
- What is the component/feature structure?
- What props/parameters are needed?
- What state management is required?
- What edge cases need handling?
- What security considerations apply?
- What tests should be added?
```

**Implementation Approaches:**

| Type         | Focus            | Key Considerations                |
| ------------ | ---------------- | --------------------------------- |
| Component    | UI + State       | Props, hooks, accessibility       |
| API Endpoint | Request/Response | Validation, auth, error handling  |
| Service      | Business Logic   | Dependency injection, testability |
| Full-Stack   | End-to-End       | Data flow, type safety            |

**Tools**: Sequential Thinking

### Phase 4: IMPLEMENT

Generate code following framework best practices:

```
# For UI components, search shadcn registry
mcp__shadcn__search_items_in_registries(["@shadcn"], "button dialog")
mcp__shadcn__get_item_examples_from_registries(["@shadcn"], "button-demo")
mcp__shadcn__get_add_command_for_items(["@shadcn/button"])

# Write implementation
Write - Create new files
Edit - Modify existing files

# Track progress
TodoWrite - Update implementation status
```

**Tools**: Write, Edit, Shadcn MCP, TodoWrite

### Phase 5: VALIDATE

Test and verify the implementation:

```
# Navigate to the feature
mcp__playwright__browser_navigate("http://localhost:3000/feature")

# Take snapshot to verify UI
mcp__playwright__browser_snapshot()

# Test interactions
mcp__playwright__browser_click(element, ref)
mcp__playwright__browser_type(element, ref, "test input")
mcp__playwright__browser_fill_form(fields)

# Run tests
Bash - npm test, pytest, etc.
```

**Tools**: Playwright MCP, Bash

## MCP Integration

### Context7 (Framework Documentation)

**Primary source for framework-specific implementation patterns:**

```
mcp__context7__resolve-library-id - Resolve framework IDs
mcp__context7__query-docs - Get official documentation
```

**Frontend Frameworks:**

| Resource           | Library ID                 | Snippets | Use Case                    |
| ------------------ | -------------------------- | -------- | --------------------------- |
| React              | `/reactjs/react.dev`       | 3,742    | Hooks, components, patterns |
| Vue 3              | `/vuejs/docs`              | 1,178    | Composition API, reactivity |
| Next.js App Router | `/websites/nextjs_app`     | 2,664    | Server components, routing  |
| Svelte             | `/websites/svelte_dev`     | 5,523    | Reactive stores, components |
| Tailwind CSS       | `/websites/v3_tailwindcss` | 2,691    | Utility classes, styling    |

**Backend Frameworks:**

| Resource   | Library ID                       | Snippets | Use Case                  |
| ---------- | -------------------------------- | -------- | ------------------------- |
| Express.js | `/websites/expressjs_en`         | 1,433    | Routes, middleware        |
| NestJS     | `/websites/nestjs`               | 4,362    | Controllers, services, DI |
| FastAPI    | `/websites/fastapi_tiangolo`     | 31,710   | Endpoints, Pydantic       |
| Django     | `/websites/djangoproject_en_6_0` | 10,667   | Models, views, ORM        |

**Data & Validation:**

| Resource   | Library ID                 | Snippets | Use Case             |
| ---------- | -------------------------- | -------- | -------------------- |
| Prisma     | `/prisma/docs`             | 4,691    | ORM, schema, queries |
| TypeScript | `/websites/typescriptlang` | 2,391    | Types, generics      |
| Zod        | `/websites/v3_zod_dev`     | 8,255    | Schema validation    |

**Query patterns:**

- "hooks useState useEffect patterns" (React)
- "composition API reactive refs computed" (Vue)
- "server components app router data fetching" (Next.js)
- "controller service dependency injection" (NestJS)
- "endpoints Pydantic validation dependencies" (FastAPI)
- "schema model relations queries" (Prisma)

### GitHub MCP (Pattern Research)

**Find implementation patterns in production codebases:**

```
mcp__github__search_code - Find implementation patterns
mcp__github__get_file_contents - Get specific implementations
```

**Search patterns:**

```
# Find React hook patterns
"useState" "useEffect" "cleanup" filename:.tsx stars:>500

# Find API endpoint patterns
"@Controller" "@Get" "@Post" filename:.ts stars:>100

# Find validation patterns
"z.object" "z.string" "parse" filename:.ts

# Find component patterns
"export function" "props" "return" filename:.tsx stars:>500

# Find service patterns
"@Injectable" "constructor" "async" filename:.ts
```

**Use cases:**

- Find how popular projects implement features
- Research hook and component patterns
- Get validation and error handling examples
- Study API endpoint structures

### Tavily (Best Practices Research)

**Research current implementation methodologies:**

```
mcp__tavily__tavily-search - Research implementation practices
mcp__tavily__tavily-extract - Extract from tutorials
```

**Use cases:**

- "React component best practices 2024"
- "Next.js server components patterns"
- "NestJS dependency injection best practices"
- "FastAPI async patterns"
- "TypeScript strict mode patterns"
- "Tailwind CSS component design"

### Shadcn MCP (UI Components)

**Access pre-built UI components:**

```
mcp__shadcn__search_items_in_registries - Search for components
mcp__shadcn__view_items_in_registries - View component details
mcp__shadcn__get_item_examples_from_registries - Get usage examples
mcp__shadcn__get_add_command_for_items - Get install command
```

**Use cases:**

- Find button, dialog, form components
- Get component implementation examples
- Install components via CLI
- View component APIs and props

### Playwright MCP (Implementation Validation)

**Validate implemented features in real browser:**

```
mcp__playwright__browser_navigate - Navigate to feature
mcp__playwright__browser_snapshot - Capture UI state
mcp__playwright__browser_click - Test interactions
mcp__playwright__browser_type - Test input fields
mcp__playwright__browser_fill_form - Test forms
```

**Use cases:**

- Verify UI renders correctly
- Test interactive elements work
- Validate form submissions
- Check responsive behavior

### Sequential Thinking (Structured Planning)

**Systematic implementation planning:**

```
mcp__sequential-thinking__sequentialthinking - Multi-step planning
```

**Use for:**

- Component structure design
- API endpoint planning
- State management decisions
- Edge case identification
- Security consideration analysis

## Implementation Patterns

### React Component

```typescript
// 1. Research: Look up React patterns via Context7
// mcp__context7__query-docs("/reactjs/react.dev", "hooks patterns")

// 2. Implement with proper hooks usage
import { useState, useEffect, useCallback } from 'react';

interface Props {
  initialValue: string;
  onSubmit: (value: string) => Promise<void>;
}

export function SearchInput({ initialValue, onSubmit }: Props) {
  // ✅ Hooks at top level, unconditionally
  const [value, setValue] = useState(initialValue);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // ✅ useCallback for stable function reference
  const handleSubmit = useCallback(async () => {
    setIsLoading(true);
    setError(null);
    try {
      await onSubmit(value);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Unknown error');
    } finally {
      setIsLoading(false);
    }
  }, [value, onSubmit]);

  // ✅ useEffect with proper cleanup
  useEffect(() => {
    const handler = (e: KeyboardEvent) => {
      if (e.key === 'Enter') handleSubmit();
    };
    window.addEventListener('keydown', handler);
    return () => window.removeEventListener('keydown', handler);
  }, [handleSubmit]);

  return (
    <div>
      <input
        value={value}
        onChange={(e) => setValue(e.target.value)}
        disabled={isLoading}
        aria-label="Search"
      />
      {error && <p role="alert">{error}</p>}
    </div>
  );
}
```

### NestJS Controller + Service

```typescript
// 1. Research: Look up NestJS patterns via Context7
// mcp__context7__query-docs("/websites/nestjs", "controller service DI")

// 2. Implement with proper DI pattern

// dto/create-item.dto.ts
import { IsString, IsNumber, IsOptional, Min } from "class-validator";

export class CreateItemDto {
  @IsString()
  name: string;

  @IsNumber()
  @Min(0)
  price: number;

  @IsString()
  @IsOptional()
  description?: string;
}

// items.service.ts
import { Injectable, NotFoundException } from "@nestjs/common";
import { CreateItemDto } from "./dto/create-item.dto";

@Injectable()
export class ItemsService {
  private items: Item[] = [];

  create(dto: CreateItemDto): Item {
    const item = { id: Date.now(), ...dto };
    this.items.push(item);
    return item;
  }

  findAll(): Item[] {
    return this.items;
  }

  findOne(id: number): Item {
    const item = this.items.find((i) => i.id === id);
    if (!item) throw new NotFoundException(`Item ${id} not found`);
    return item;
  }
}

// items.controller.ts
import {
  Controller,
  Get,
  Post,
  Param,
  Body,
  ParseIntPipe,
} from "@nestjs/common";
import { ItemsService } from "./items.service";
import { CreateItemDto } from "./dto/create-item.dto";

@Controller("items")
export class ItemsController {
  constructor(private readonly itemsService: ItemsService) {}

  @Post()
  create(@Body() dto: CreateItemDto) {
    return this.itemsService.create(dto);
  }

  @Get()
  findAll() {
    return this.itemsService.findAll();
  }

  @Get(":id")
  findOne(@Param("id", ParseIntPipe) id: number) {
    return this.itemsService.findOne(id);
  }
}
```

### FastAPI Endpoint

```python
# 1. Research: Look up FastAPI patterns via Context7
# mcp__context7__query-docs("/websites/fastapi_tiangolo", "endpoints Pydantic")

# 2. Implement with proper validation
from typing import Annotated
from fastapi import APIRouter, Depends, HTTPException, status
from pydantic import BaseModel, Field

router = APIRouter(prefix="/items", tags=["items"])

# Pydantic models for validation
class ItemCreate(BaseModel):
    name: str = Field(..., min_length=1, max_length=100)
    price: float = Field(..., gt=0, description="Price must be positive")
    description: str | None = Field(None, max_length=500)

class ItemResponse(BaseModel):
    id: int
    name: str
    price: float
    description: str | None

# Dependency injection
async def get_db():
    # Database connection logic
    yield db

@router.post("/", response_model=ItemResponse, status_code=status.HTTP_201_CREATED)
async def create_item(
    item: ItemCreate,
    db: Annotated[Database, Depends(get_db)]
):
    """Create a new item with validation."""
    new_item = await db.items.create(item.model_dump())
    return new_item

@router.get("/{item_id}", response_model=ItemResponse)
async def get_item(
    item_id: int,
    db: Annotated[Database, Depends(get_db)]
):
    """Get item by ID or raise 404."""
    item = await db.items.find_one(item_id)
    if not item:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Item {item_id} not found"
        )
    return item
```

### Vue 3 Composition API

```vue
<!-- 1. Research: Look up Vue patterns via Context7 -->
<!-- mcp__context7__query-docs("/vuejs/docs", "composition API reactive") -->

<script setup lang="ts">
import { ref, computed, watch, onMounted, onUnmounted } from "vue";

// Props with TypeScript
interface Props {
  initialCount?: number;
  max?: number;
}

const props = withDefaults(defineProps<Props>(), {
  initialCount: 0,
  max: 100,
});

// Emits with TypeScript
const emit = defineEmits<{
  (e: "update", value: number): void;
  (e: "maxReached"): void;
}>();

// Reactive state
const count = ref(props.initialCount);
const isLoading = ref(false);

// Computed property
const isAtMax = computed(() => count.value >= props.max);
const percentage = computed(() => (count.value / props.max) * 100);

// Watch for changes
watch(count, (newValue) => {
  emit("update", newValue);
  if (newValue >= props.max) {
    emit("maxReached");
  }
});

// Methods
function increment() {
  if (!isAtMax.value) {
    count.value++;
  }
}

function decrement() {
  if (count.value > 0) {
    count.value--;
  }
}

// Lifecycle
onMounted(() => {
  console.log("Counter mounted");
});

onUnmounted(() => {
  console.log("Counter unmounted");
});
</script>

<template>
  <div class="counter">
    <button @click="decrement" :disabled="count === 0">-</button>
    <span>{{ count }} / {{ max }}</span>
    <button @click="increment" :disabled="isAtMax">+</button>
    <div class="progress" :style="{ width: `${percentage}%` }" />
  </div>
</template>
```

### Full-Stack Feature (Next.js App Router)

```typescript
// 1. Research: Look up Next.js patterns via Context7
// mcp__context7__query-docs("/websites/nextjs_app", "server components actions")

// app/items/page.tsx - Server Component
import { getItems } from '@/lib/items';
import { ItemList } from './item-list';
import { CreateItemForm } from './create-item-form';

export default async function ItemsPage() {
  // Data fetching in Server Component
  const items = await getItems();

  return (
    <div>
      <h1>Items</h1>
      <CreateItemForm />
      <ItemList items={items} />
    </div>
  );
}

// app/items/actions.ts - Server Actions
'use server';

import { revalidatePath } from 'next/cache';
import { z } from 'zod';
import { db } from '@/lib/db';

const createItemSchema = z.object({
  name: z.string().min(1).max(100),
  price: z.number().positive(),
});

export async function createItem(formData: FormData) {
  const parsed = createItemSchema.safeParse({
    name: formData.get('name'),
    price: Number(formData.get('price')),
  });

  if (!parsed.success) {
    return { error: parsed.error.flatten() };
  }

  await db.item.create({ data: parsed.data });
  revalidatePath('/items');
  return { success: true };
}

// app/items/create-item-form.tsx - Client Component
'use client';

import { useFormState } from 'react-dom';
import { createItem } from './actions';

export function CreateItemForm() {
  const [state, formAction] = useFormState(createItem, null);

  return (
    <form action={formAction}>
      <input name="name" placeholder="Item name" required />
      <input name="price" type="number" step="0.01" required />
      <button type="submit">Create</button>
      {state?.error && <p>{JSON.stringify(state.error)}</p>}
    </form>
  );
}
```

## Technology Detection

| File                               | Framework | Implementation Focus          |
| ---------------------------------- | --------- | ----------------------------- |
| `package.json` with `react`        | React     | Hooks, components, JSX        |
| `package.json` with `vue`          | Vue       | Composition API, SFC          |
| `package.json` with `next`         | Next.js   | App Router, Server Components |
| `package.json` with `svelte`       | Svelte    | Reactive stores, components   |
| `package.json` with `@nestjs/core` | NestJS    | Controllers, services, DI     |
| `requirements.txt` with `fastapi`  | FastAPI   | Endpoints, Pydantic           |
| `requirements.txt` with `django`   | Django    | Views, models, ORM            |
| `package.json` with `express`      | Express   | Routes, middleware            |
| `go.mod`                           | Go        | Handlers, services            |
| `Cargo.toml`                       | Rust      | Handlers, traits              |

## Output Format

```markdown
## Implementation Summary

### Feature Implemented

[Description of what was built]

### Research Applied

- Framework docs: [Context7 sources used]
- Real examples: [GitHub patterns referenced]
- Best practices: [Tavily research applied]

### Files Created/Modified

| File                         | Action  | Purpose          |
| ---------------------------- | ------- | ---------------- |
| `src/components/Feature.tsx` | Created | Main component   |
| `src/api/feature.ts`         | Created | API endpoint     |
| `src/types/feature.ts`       | Created | TypeScript types |

### Implementation Details

- Pattern used: [Component/API/Service pattern]
- Framework conventions: [Conventions followed]
- Validation: [Zod/class-validator/Pydantic]
- Error handling: [Approach used]

### Validation Results

- [ ] UI renders correctly (Playwright snapshot)
- [ ] Interactions work (Playwright click/type)
- [ ] API responds correctly (curl/test)
- [ ] Types are correct (tsc)
- [ ] Tests pass (npm test)

### Security Considerations

- Input validation: [How inputs are validated]
- Authentication: [Auth requirements]
- Authorization: [Permission checks]

### Next Steps

1. [Suggested improvements]
2. [Additional tests needed]
3. [Documentation updates]
```

## Reference Files

For detailed implementation patterns, see:

- `references/implementation-patterns.md` - Framework-specific patterns
- `references/component-patterns.md` - UI component best practices
- `references/api-patterns.md` - API endpoint structures
- `references/validation-patterns.md` - Input validation approaches

## Handoffs

| Scenario                   | Hand off to           |
| -------------------------- | --------------------- |
| Need complex orchestration | `orchestration` skill |
| Need code analysis         | `analyze` skill       |
| Need bug fixing            | `debug` skill         |
| Need test strategy         | `quality` skill       |
| Need architecture design   | `design` skill        |
| Need documentation         | `document` skill      |

## Boundaries

**Will:**

- Implement features following framework best practices
- Research official documentation via Context7
- Find real-world patterns via GitHub MCP
- Use shadcn components for UI implementation
- Validate implementations with Playwright
- Apply proper TypeScript types and validation
- Follow security best practices

**Will Not:**

- Make architectural decisions without proper analysis
- Implement features conflicting with security policies
- Override user-specified safety constraints
- Skip validation and error handling
- Ignore existing codebase conventions
