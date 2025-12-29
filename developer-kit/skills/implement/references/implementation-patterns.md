# Implementation Patterns

## React Component Implementation

### Standard Pattern
```typescript
// 1. Component structure
interface ComponentProps {
  // Define props with TypeScript
}

export function Component({ prop1, prop2 }: ComponentProps) {
  // 2. Hooks at top
  const [state, setState] = useState();

  // 3. Event handlers
  const handleEvent = () => {};

  // 4. Render
  return (
    <div>
      {/* Accessible markup */}
    </div>
  );
}
```

### Best Practices
- Use TypeScript for type safety
- Implement accessibility (ARIA labels, keyboard navigation)
- Follow existing component patterns in codebase
- Add unit tests for logic, integration tests for interactions

## API Implementation

### Express/Node Pattern
```typescript
// 1. Route handler
router.post('/resource', validateRequest, async (req, res) => {
  try {
    // 2. Input validation
    const validated = schema.parse(req.body);

    // 3. Business logic
    const result = await service.create(validated);

    // 4. Response
    res.status(201).json(result);
  } catch (error) {
    // 5. Error handling
    next(error);
  }
});
```

### Best Practices
- Validate all inputs
- Use proper HTTP status codes
- Implement error handling middleware
- Add request/response logging
- Include rate limiting for public endpoints

## Service Layer Implementation

### Pattern
```typescript
class UserService {
  constructor(private repository: UserRepository) {}

  async createUser(data: CreateUserDTO): Promise<User> {
    // 1. Business validation
    await this.validateUnique(data.email);

    // 2. Transform data
    const user = this.mapToEntity(data);

    // 3. Persist
    return this.repository.save(user);
  }
}
```

### Best Practices
- Keep services focused (single responsibility)
- Use dependency injection
- Separate business logic from data access
- Write unit tests with mocked dependencies

## Database Implementation

### Migration Pattern
```sql
-- Up migration
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email VARCHAR(255) UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_users_email ON users(email);

-- Down migration
DROP TABLE users;
```

### Best Practices
- Always include both up and down migrations
- Add indexes for frequently queried columns
- Use transactions for data migrations
- Test migrations on staging before production

## Full-Stack Feature Implementation

### Workflow
1. **Database**: Create migrations and models
2. **Backend**: Implement API endpoints and services
3. **Frontend**: Build UI components and state management
4. **Integration**: Connect frontend to backend
5. **Testing**: Add E2E tests for critical flows

### Checklist
- [ ] Database schema designed
- [ ] API endpoints implemented
- [ ] Input validation in place
- [ ] Error handling implemented
- [ ] Frontend components created
- [ ] State management configured
- [ ] E2E tests written
- [ ] Documentation updated

## Security Considerations

### Authentication Implementation
- Use established libraries (Passport, NextAuth, etc.)
- Store passwords with bcrypt (cost factor 12+)
- Implement rate limiting on auth endpoints
- Use secure session management

### Authorization Implementation
- Implement role-based access control (RBAC)
- Check permissions at API layer
- Never trust client-side authorization
- Log authorization failures

### Data Protection
- Validate and sanitize all inputs
- Use parameterized queries (prevent SQL injection)
- Escape output (prevent XSS)
- Implement CSRF protection for forms
