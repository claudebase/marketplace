#!/bin/bash
# session_instructions_hook.sh
# SessionStart hook - outputs session instructions and delegation protocol
#
# This replaces platform_instructions_hook.py with a Unix-only bash version.

cat << 'INSTRUCTIONS_EOF'
{"continue": true, "systemMessage": "## Developer Kit Session Instructions

### Platform Rules:
- Use `python3` for Python commands
- Use `pip3` for package management
- Config location: `~/.claude/settings.json`
- Full Unix command compatibility

---

## Command Delegation Protocol (CRITICAL)

When a Developer Kit slash command is invoked that contains `delegates-to: <target>` in its frontmatter:

### ENFORCEMENT RULES (MUST FOLLOW)

1. **DO NOT** display the command markdown content to the user
2. **IMMEDIATELY** invoke the delegated component using the appropriate tool
3. **PASS THROUGH** all user-provided arguments exactly as given

### Delegation Types

| Delegation Type | Tool to Use | Invocation Pattern |
|-----------------|-------------|-------------------|
| Skill | `Skill` | `Skill(skill: \"developer-kit:<skill-name>\", args: \"<arguments>\")` |
| Agent | `Task` | `Task(subagent_type: \"developer-kit:<agent-name>\", prompt: \"<arguments>\")` |

### Complete Delegation Map

| Command | Delegates To | Type | Invocation |
|---------|--------------|------|------------|
| `/analyze` | analyze | Skill | `Skill(skill: \"developer-kit:analyze\", args: \"$ARGS\")` |
| `/build` | devops | Skill | `Skill(skill: \"developer-kit:devops\", args: \"build $ARGS\")` |
| `/check` | devops | Skill | `Skill(skill: \"developer-kit:devops\", args: \"check $ARGS\")` |
| `/cleanup` | devops | Skill | `Skill(skill: \"developer-kit:devops\", args: \"cleanup $ARGS\")` |
| `/code-review` | code-reviewer | Agent | `Task(subagent_type: \"developer-kit:code-reviewer\", prompt: \"$ARGS\")` |
| `/feature-dev` | orchestration | Skill | `Skill(skill: \"developer-kit:orchestration\", args: \"feature $ARGS\")` |
| `/git` | devops | Skill | `Skill(skill: \"developer-kit:devops\", args: \"git $ARGS\")` |
| `/start` | orchestration | Skill | `Skill(skill: \"developer-kit:orchestration\", args: \"start $ARGS\")` |
| `/business-panel` | brainstorm | Skill | `Skill(skill: \"developer-kit:brainstorm\", args: \"panel $ARGS\")` |
| `/estimate` | orchestration | Skill | `Skill(skill: \"developer-kit:orchestration\", args: \"estimate $ARGS\")` |
| `/spec-panel` | brainstorm | Skill | `Skill(skill: \"developer-kit:brainstorm\", args: \"spec $ARGS\")` |
| `/workflow` | orchestration | Skill | `Skill(skill: \"developer-kit:orchestration\", args: \"workflow $ARGS\")` |
| `/changelog` | document | Skill | `Skill(skill: \"developer-kit:document\", args: \"changelog $ARGS\")` |
| `/migrate` | migration | Skill | `Skill(skill: \"developer-kit:migration\", args: \"$ARGS\")` |
| `/prep-pr` | orchestration | Skill | `Skill(skill: \"developer-kit:orchestration\", args: \"prep-pr $ARGS\")` |
| `/release` | devops | Skill | `Skill(skill: \"developer-kit:devops\", args: \"release $ARGS\")` |
| `/ship` | orchestration | Skill | `Skill(skill: \"developer-kit:orchestration\", args: \"ship $ARGS\")` |
| `/index` | research | Skill | `Skill(skill: \"developer-kit:research\", args: \"index $ARGS\")` |
| `/recommend` | research | Skill | `Skill(skill: \"developer-kit:research\", args: \"recommend $ARGS\")` |
| `/agent` | orchestration | Skill | `Skill(skill: \"developer-kit:orchestration\", args: \"agent $ARGS\")` |
| `/reflect` | document | Skill | `Skill(skill: \"developer-kit:document\", args: \"reflect $ARGS\")` |

### Example Flow

```
User: /analyze --mode security --target src/auth/

You should:
1. Recognize /analyze command
2. Look up delegation: analyze -> Skill
3. Invoke: Skill(skill: \"developer-kit:analyze\", args: \"--mode security --target src/auth/\")
4. NOT display analyze.md content
```

This is a **BLOCKING** requirement. Check for `delegates-to` in frontmatter BEFORE displaying any command content.

---

### Validation Commands:
- Tests: `bash scripts/test_components.sh`
- Validate: `bash scripts/validate.sh`
- Delegation: `bash scripts/validate_delegation.sh`
"}
INSTRUCTIONS_EOF
