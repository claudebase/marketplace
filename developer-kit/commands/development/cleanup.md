---
name: cleanup
description: "Code cleanup and dead code removal - delegates to devops skill"
argument-hint: "[target] [--type code|imports|files|all] [--safe|--aggressive]"
delegates-to: devops
operation: cleanup
---

# cleanup - Code Cleanup

Invokes the `devops` skill with the `cleanup` operation.

## Usage
```
cleanup [target] [--type code|imports|files|all] [--safe|--aggressive]
```

## What This Does

This command delegates to the devops skill for cleanup operations:

1. **Analyze**: Cleanup opportunities and safety considerations
2. **Plan**: Choose cleanup approach based on scope and safety level
3. **Execute**: Systematic cleanup with dead code detection
4. **Validate**: Ensure no functionality loss
5. **Report**: Cleanup summary and maintenance recommendations

## Examples

```bash
cleanup src/ --type code --safe    # Conservative dead code removal
cleanup --type imports             # Unused import cleanup
cleanup --type all --aggressive    # Comprehensive cleanup
```

## Full Documentation

See `skills/devops/SKILL.md` for complete cleanup methodology.

## Boundaries

**Will:**
- Systematically clean code and remove dead code
- Provide safety validation with backup capabilities
- Apply intelligent cleanup with framework patterns

**Will Not:**
- Remove code without safety analysis
- Override project-specific exclusions
- Apply cleanup that compromises functionality
