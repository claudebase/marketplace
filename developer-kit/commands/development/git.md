---
name: git
description: "Git operations with smart commit messages - delegates to devops skill"
argument-hint: "[operation] [args] [--smart-commit]"
delegates-to: devops
operation: git
---

# git - Git Operations

Invokes the `devops` skill with the `git` operation.

## Usage
```
git [operation] [args] [--smart-commit]
```

## What This Does

This command delegates to the devops skill for git operations:

1. **Analyze**: Repository state and working directory changes
2. **Validate**: Ensure operation is appropriate for context
3. **Execute**: Git command with intelligent automation
4. **Optimize**: Smart commit messages and workflow patterns
5. **Report**: Status and next steps guidance

## Examples

```bash
git status                     # Analyze repository state
git commit --smart-commit      # Generate conventional commit message
git push                       # Push with pre-push validation
```

## Full Documentation

See `skills/devops/SKILL.md` for complete git methodology.

## Boundaries

**Will:**
- Execute Git operations with intelligent automation
- Generate conventional commit messages from change analysis
- Provide workflow optimization guidance

**Will Not:**
- Modify repository configuration without authorization
- Execute destructive operations without confirmation
- Handle complex merges requiring manual intervention
