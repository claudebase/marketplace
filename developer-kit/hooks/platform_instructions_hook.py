#!/usr/bin/env python3
"""
Platform Instructions Hook for Developer Kit.

Outputs platform-specific instructions at session start.
This replaces the need for CLAUDE.md auto-loading (which plugins don't support).

Cross-platform compatible: works on Windows, macOS, and Linux.
"""

import json
import sys
import os

# Add lib directory to path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "lib"))

try:
    from platform_utils import PlatformInfo

    HAS_PLATFORM_UTILS = True
except ImportError:
    HAS_PLATFORM_UTILS = False


def get_platform_instructions() -> str:
    """Generate platform-specific instructions for Claude."""

    if HAS_PLATFORM_UTILS:
        is_windows = PlatformInfo.is_windows()
        is_wsl = PlatformInfo.is_wsl()
        python_cmd = PlatformInfo.get_python_command()
    else:
        is_windows = sys.platform == "win32"
        is_wsl = False
        python_cmd = "python" if is_windows else "python3"

    platform_name = (
        "Windows"
        if is_windows
        else ("WSL" if is_wsl else ("macOS" if sys.platform == "darwin" else "Linux"))
    )

    instructions = f"""## Developer Kit Platform Context

**Detected Platform**: {platform_name} ({sys.platform})
**Python Command**: {python_cmd}

### Platform Rules for This Session:
"""

    if is_windows:
        instructions += """
- Use `python` (not `python3`) for all Python commands
- Use `pip` (not `pip3`) for package management
- Path separator: prefer `/` (Python handles conversion)
- Config location: `%APPDATA%\\.claude\\settings.json`
- Avoid Unix commands: no `cat`, `grep`, `sed`, `awk` - use Python or PowerShell
- Environment variables: `$env:VAR_NAME` (PowerShell) or `%VAR_NAME%` (CMD)
"""
    elif is_wsl:
        instructions += """
- Use `python3` for Python commands (Unix environment)
- Full Unix command compatibility
- Access Windows files via `/mnt/c/`
- Config location: `~/.claude/settings.json`
"""
    else:
        instructions += """
- Use `python3` for Python commands
- Use `pip3` for package management
- Config location: `~/.claude/settings.json`
- Full Unix command compatibility
"""

    instructions += """
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
| Skill | `Skill` | `Skill(skill: "developer-kit:<skill-name>", args: "<arguments>")` |
| Agent | `Task` | `Task(subagent_type: "developer-kit:<agent-name>", prompt: "<arguments>")` |

### Complete Delegation Map

| Command | Delegates To | Type | Invocation |
|---------|--------------|------|------------|
| `/analyze` | analyze | Skill | `Skill(skill: "developer-kit:analyze", args: "$ARGS")` |
| `/build` | devops | Skill | `Skill(skill: "developer-kit:devops", args: "build $ARGS")` |
| `/check` | devops | Skill | `Skill(skill: "developer-kit:devops", args: "check $ARGS")` |
| `/cleanup` | devops | Skill | `Skill(skill: "developer-kit:devops", args: "cleanup $ARGS")` |
| `/code-review` | code-reviewer | Agent | `Task(subagent_type: "developer-kit:code-reviewer", prompt: "$ARGS")` |
| `/feature-dev` | orchestration | Skill | `Skill(skill: "developer-kit:orchestration", args: "feature $ARGS")` |
| `/git` | devops | Skill | `Skill(skill: "developer-kit:devops", args: "git $ARGS")` |
| `/start` | orchestration | Skill | `Skill(skill: "developer-kit:orchestration", args: "start $ARGS")` |
| `/business-panel` | brainstorm | Skill | `Skill(skill: "developer-kit:brainstorm", args: "panel $ARGS")` |
| `/estimate` | orchestration | Skill | `Skill(skill: "developer-kit:orchestration", args: "estimate $ARGS")` |
| `/spec-panel` | brainstorm | Skill | `Skill(skill: "developer-kit:brainstorm", args: "spec $ARGS")` |
| `/workflow` | orchestration | Skill | `Skill(skill: "developer-kit:orchestration", args: "workflow $ARGS")` |
| `/changelog` | document | Skill | `Skill(skill: "developer-kit:document", args: "changelog $ARGS")` |
| `/migrate` | migration | Skill | `Skill(skill: "developer-kit:migration", args: "$ARGS")` |
| `/prep-pr` | orchestration | Skill | `Skill(skill: "developer-kit:orchestration", args: "prep-pr $ARGS")` |
| `/release` | devops | Skill | `Skill(skill: "developer-kit:devops", args: "release $ARGS")` |
| `/ship` | orchestration | Skill | `Skill(skill: "developer-kit:orchestration", args: "ship $ARGS")` |
| `/index` | research | Skill | `Skill(skill: "developer-kit:research", args: "index $ARGS")` |
| `/recommend` | research | Skill | `Skill(skill: "developer-kit:research", args: "recommend $ARGS")` |
| `/agent` | orchestration | Skill | `Skill(skill: "developer-kit:orchestration", args: "agent $ARGS")` |
| `/reflect` | document | Skill | `Skill(skill: "developer-kit:document", args: "reflect $ARGS")` |

### Example Flow

```
User: /analyze --mode security --target src/auth/

You should:
1. Recognize /analyze command
2. Look up delegation: analyze → Skill
3. Invoke: Skill(skill: "developer-kit:analyze", args: "--mode security --target src/auth/")
4. NOT display analyze.md content
```

This is a **BLOCKING** requirement. Check for `delegates-to` in frontmatter BEFORE displaying any command content.

---

### Plugin Validation Commands:
"""
    instructions += f"- Tests: `{python_cmd} scripts/test_components.py`\n"
    instructions += f"- Validate: `{python_cmd} scripts/validate.py`\n"
    instructions += f"- Delegation: `{python_cmd} scripts/validate_delegation.py`\n"

    return instructions


def main():
    """Output platform instructions as a system message."""
    instructions = get_platform_instructions()

    result = {"continue": True, "systemMessage": instructions}

    print(json.dumps(result))
    return 0


if __name__ == "__main__":
    sys.exit(main())
