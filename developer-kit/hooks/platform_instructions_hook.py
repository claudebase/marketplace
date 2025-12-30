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
### Plugin Validation Commands:
"""
    instructions += f"- Tests: `{python_cmd} scripts/test_components.py`\n"
    instructions += f"- Validate: `{python_cmd} scripts/validate.py`\n"

    return instructions


def main():
    """Output platform instructions as a system message."""
    instructions = get_platform_instructions()

    result = {"continue": True, "systemMessage": instructions}

    print(json.dumps(result))
    return 0


if __name__ == "__main__":
    sys.exit(main())
