# Git Patterns

## Conventional Commits

### Format
```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

### Types
| Type | Description |
|------|-------------|
| feat | New feature |
| fix | Bug fix |
| docs | Documentation |
| style | Formatting |
| refactor | Code restructuring |
| test | Adding tests |
| chore | Maintenance |

### Examples
```bash
feat(auth): add OAuth2 login support
fix(api): handle null response from external service
docs(readme): update installation instructions
refactor(user): extract validation logic to separate module
```

## Branch Naming

### Convention
```
<type>/<ticket-id>-<short-description>
```

### Examples
```
feature/AUTH-123-oauth-login
bugfix/API-456-null-response
hotfix/PROD-789-memory-leak
```

## Common Workflows

### Feature Development
```bash
# 1. Create feature branch
git checkout -b feature/AUTH-123-oauth-login

# 2. Make changes and commit
git add .
git commit -m "feat(auth): implement OAuth2 flow"

# 3. Push and create PR
git push -u origin feature/AUTH-123-oauth-login
```

### Bug Fix
```bash
# 1. Create bugfix branch from main
git checkout main
git pull
git checkout -b bugfix/API-456-null-response

# 2. Fix and commit
git add .
git commit -m "fix(api): handle null response gracefully"

# 3. Push
git push -u origin bugfix/API-456-null-response
```

### Sync with Main
```bash
# Rebase approach (cleaner history)
git fetch origin
git rebase origin/main

# Merge approach (preserves history)
git fetch origin
git merge origin/main
```

## Useful Commands

### Status and Diff
```bash
git status              # Working directory status
git diff                # Unstaged changes
git diff --staged       # Staged changes
git log --oneline -10   # Recent commits
```

### Undo Operations
```bash
git checkout -- <file>  # Discard file changes
git reset HEAD <file>   # Unstage file
git reset --soft HEAD~1 # Undo last commit (keep changes)
git reset --hard HEAD~1 # Undo last commit (discard changes)
```

### Stash
```bash
git stash               # Stash changes
git stash pop           # Apply and remove stash
git stash list          # List stashes
```

## Safety Rules

1. **Never force push to main/master**
2. **Always pull before pushing**
3. **Review changes before committing**
4. **Use meaningful commit messages**
5. **Keep commits atomic (one change per commit)**
