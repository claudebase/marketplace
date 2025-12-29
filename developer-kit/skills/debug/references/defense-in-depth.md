# Defense-in-Depth Validation

After finding and fixing the root cause, add validation at EVERY layer data passes through. Make the bug structurally impossible.

## Why Multiple Layers

Single validation: "We fixed the bug"
Multiple layers: "We made the bug impossible"

Different layers catch different cases:
- Entry validation catches most bugs
- Business logic catches edge cases
- Environment guards prevent context-specific dangers
- Debug logging helps when other layers fail

## The Four Validation Layers

### Layer 1: Entry Point Validation

**Purpose:** Reject obviously invalid input at API boundary

```typescript
function createProject(name: string, workingDirectory: string) {
  if (!workingDirectory || workingDirectory.trim() === '') {
    throw new Error('workingDirectory cannot be empty');
  }
  if (!existsSync(workingDirectory)) {
    throw new Error(`workingDirectory does not exist: ${workingDirectory}`);
  }
  if (!statSync(workingDirectory).isDirectory()) {
    throw new Error(`workingDirectory is not a directory: ${workingDirectory}`);
  }
  // ... proceed
}
```

**Key checks:**
- Null/undefined/empty values
- Type validation
- Existence validation
- Format validation

### Layer 2: Business Logic Validation

**Purpose:** Ensure data makes sense for this operation

```typescript
function initializeWorkspace(projectDir: string, sessionId: string) {
  if (!projectDir) {
    throw new Error('projectDir required for workspace initialization');
  }
  if (!sessionId || sessionId.length < 8) {
    throw new Error('Valid sessionId required');
  }
  // ... proceed
}
```

**Key checks:**
- Required fields present
- Values within expected ranges
- Relationships between values make sense
- State prerequisites met

### Layer 3: Environment Guards

**Purpose:** Prevent dangerous operations in specific contexts

```typescript
async function gitInit(directory: string) {
  // In tests, refuse git init outside temp directories
  if (process.env.NODE_ENV === 'test') {
    const normalized = normalize(resolve(directory));
    const tmpDir = normalize(resolve(tmpdir()));

    if (!normalized.startsWith(tmpDir)) {
      throw new Error(
        `Refusing git init outside temp dir during tests: ${directory}`
      );
    }
  }
  // ... proceed
}
```

**Key checks:**
- Production vs development vs test behavior
- Dangerous operations blocked in certain contexts
- Resource limits enforced per environment
- Safety fallbacks for unexpected environments

### Layer 4: Debug Instrumentation

**Purpose:** Capture context for forensics

```typescript
async function gitInit(directory: string) {
  const stack = new Error().stack;
  logger.debug('About to git init', {
    directory,
    cwd: process.cwd(),
    nodeEnv: process.env.NODE_ENV,
    stack,
  });
  // ... proceed
}
```

**Key elements:**
- Input values
- Current state (cwd, env vars)
- Stack trace for call chain
- Timestamps for timing issues

## Applying Defense-in-Depth

When you fix a bug:

1. **Trace the data flow** - Where does bad value originate? Where is it used?
2. **Map all checkpoints** - List every point data passes through
3. **Add validation at each layer** - Entry, business, environment, debug
4. **Test each layer** - Try to bypass layer 1, verify layer 2 catches it

**Don't stop at one validation point.** Add checks at every layer.

## Example: Complete Defense-in-Depth

For a bug where empty `projectDir` caused git init in wrong directory:

```typescript
// Layer 1: Entry Point (API)
export function createProject(name: string, projectDir: string) {
  // Validate immediately at entry
  if (!projectDir || projectDir.trim() === '') {
    throw new Error('projectDir cannot be empty');
  }
  // ...
}

// Layer 2: Business Logic (Service)
class ProjectService {
  async initializeWorkspace(projectDir: string) {
    // Validate again at service boundary
    if (!projectDir) {
      throw new Error('projectDir required for workspace initialization');
    }
    // ...
  }
}

// Layer 3: Environment Guard (Operation)
async function gitInit(directory: string) {
  // Protect against test pollution
  if (process.env.NODE_ENV === 'test') {
    const normalized = normalize(resolve(directory));
    const tmpDir = normalize(resolve(tmpdir()));
    if (!normalized.startsWith(tmpDir)) {
      throw new Error(`Refusing git init outside temp: ${directory}`);
    }
  }
  // ...
}

// Layer 4: Debug Instrumentation
async function gitInit(directory: string) {
  logger.debug('gitInit called', {
    directory,
    cwd: process.cwd(),
    stack: new Error().stack,
  });
  // ...
}
```

## Validation Checklist

When adding defense-in-depth after a fix:

- [ ] Layer 1: Entry point validates all inputs
- [ ] Layer 2: Business logic validates preconditions
- [ ] Layer 3: Environment guards prevent dangerous operations
- [ ] Layer 4: Debug logging captures context
- [ ] Each layer tested independently
- [ ] Bypass of one layer caught by another

## Common Validation Patterns

### String Validation
```typescript
function validatePath(path: string): void {
  if (!path) throw new Error('Path required');
  if (path.trim() === '') throw new Error('Path cannot be empty');
  if (!isAbsolute(path)) throw new Error('Path must be absolute');
  if (!existsSync(path)) throw new Error(`Path does not exist: ${path}`);
}
```

### Object Validation
```typescript
function validateConfig(config: Config): void {
  if (!config) throw new Error('Config required');
  if (!config.apiKey) throw new Error('Config.apiKey required');
  if (!config.endpoint) throw new Error('Config.endpoint required');
  if (!config.endpoint.startsWith('https://')) {
    throw new Error('Config.endpoint must use HTTPS');
  }
}
```

### State Validation
```typescript
function validateState(state: State): void {
  if (state.status === 'completed' && !state.result) {
    throw new Error('Completed state must have result');
  }
  if (state.status === 'error' && !state.error) {
    throw new Error('Error state must have error details');
  }
}
```

## Remember

**Single validation = Fixed the bug**
**Multiple layers = Made the bug impossible**

Always add defense-in-depth after Tier 2+ debugging.
