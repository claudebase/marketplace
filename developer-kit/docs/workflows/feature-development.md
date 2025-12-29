# Feature Development Workflow

Complete guide for developing new features from ideation to deployment.

## Overview

```
start → brainstorm → design → implement → check → prep-pr → ship
```

## Phase 1: Initialization

### Start the Feature

```bash
start user-notifications
```

This command:
- Creates branch: `feature/user-notifications`
- Initializes `docs/session/current-context.md`
- Sets up TodoWrite with standard tasks
- Activates PM Agent for tracking

## Phase 2: Requirements (brainstorm skill)

### Gather Requirements

Ask Claude to brainstorm:
```
I want to add user notifications to the app
```

The `brainstorm` skill activates and:
- Asks clarifying questions (Socratic method)
- Explores notification types (push, email, in-app)
- Identifies constraints and dependencies
- Outputs clear requirements document

### Output Example
```markdown
## Requirements: User Notifications

### Functional
- Email notifications for account events
- Push notifications for real-time alerts
- In-app notification center

### Non-Functional
- Delivery within 30 seconds
- Support for notification preferences
- Unsubscribe capability
```

## Phase 3: Planning (design skill)

### Design the Solution

```
Design the notification system architecture
```

The `design` skill activates and creates:
- System architecture diagram
- API specification
- Database schema changes
- Component interface design

### Estimate Complexity

```bash
estimate
```

Provides:
- Task breakdown
- Complexity assessment
- Risk identification

## Phase 4: Confidence Check

Before implementation, the `confidence-check` skill validates:

```
□ Requirements understood (≥90%)
□ Architecture validated
□ Dependencies identified
□ Test strategy defined
□ No blockers
```

Only proceed if confidence ≥90%.

## Phase 5: Implementation (implement skill)

### Build the Feature

```
Implement the notification service
```

The `implement` skill:
- Uses Context7 for framework patterns
- Builds component by component
- Writes tests alongside code
- Updates documentation

### Hooks Auto-Trigger
- `format-file.sh` - Formats code after edits
- `security_reminder_hook.py` - Checks for security issues

## Phase 6: Validation

### Run Full Check

```bash
check --fix
```

Validates:
1. Formatting - Auto-fixed if needed
2. Linting - Code quality
3. Type checking - Static analysis
4. Tests - All passing
5. Security - No vulnerabilities

## Phase 7: Verification (verify skill)

### Final Verification

```
Verify this feature is complete
```

The `verify --complete` mode checks:
- All tests passing
- No type errors
- Security checks passed
- Documentation updated
- Code reviewed

## Phase 8: PR Preparation

### Prepare Pull Request

```bash
prep-pr --create
```

This:
1. Runs `check`
2. Performs code review
3. Generates PR description
4. Creates PR via GitHub CLI

## Phase 9: Release

After PR is merged:

```bash
ship minor
```

This:
1. Validates everything
2. Bumps version
3. Updates changelog
4. Creates git tag
5. Pushes release

## Complete Example

```bash
# Day 1: Start
start user-notifications
> "I want to add notifications to the app"
> "Design the notification architecture"

# Day 2: Build
> "Implement the notification service"
> "Add email notification support"
> "Add push notification support"

# Day 3: Validate
check --fix
> "Verify this feature is complete"

# Day 4: Ship
prep-pr --create
# After review approval
ship minor
```

## Tips

1. **Start small** - Break features into smaller deliverables
2. **Test early** - Write tests as you implement
3. **Document as you go** - Don't leave docs for last
4. **Use confidence checks** - Prevent wrong-direction work
5. **Let tools help** - Use `check` frequently
