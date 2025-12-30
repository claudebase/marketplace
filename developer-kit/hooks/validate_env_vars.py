#!/usr/bin/env python3
"""
Validate required environment variables for Developer Kit MCP servers.

Runs on SessionStart to guide users through setup if variables are missing.
Cross-platform compatible: works on Windows, macOS, and Linux.
"""

import json
import os
import sys

# Add lib directory to path for cross-platform utilities
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "lib"))

try:
    from platform_utils import PlatformInfo

    HAS_PLATFORM_UTILS = True
except ImportError:
    HAS_PLATFORM_UTILS = False

REQUIRED_ENV_VARS = {
    "TAVILY_API_KEY": {
        "description": "Tavily API key for web search",
        "get_url": "https://tavily.com",
        "required": True,
    },
    "GITHUB_TOKEN": {
        "description": "GitHub personal access token",
        "get_url": "https://github.com/settings/tokens",
        "required": False,  # Optional but recommended
    },
}

SETTINGS_EXAMPLE = """{
  "enabledPlugins": {
    "developer-kit@claudebase": true
  },
  "env": {
    "TAVILY_API_KEY": "your-actual-tavily-api-key",
    "GITHUB_TOKEN": "your-actual-github-token"
  }
}"""


def get_settings_path() -> str:
    """Get the cross-platform settings.json path for display."""
    if HAS_PLATFORM_UTILS:
        config_dir = PlatformInfo.get_user_config_dir()
        return str(config_dir / "settings.json")
    else:
        # Fallback
        if sys.platform == "win32":
            return "%APPDATA%\\.claude\\settings.json"
        return "~/.claude/settings.json"


def check_env_vars():
    """Check which environment variables are missing."""
    missing_required = []
    missing_optional = []

    for var_name, config in REQUIRED_ENV_VARS.items():
        value = os.environ.get(var_name, "")
        # Check if unset or still has placeholder value
        if not value or value.startswith("your-") or value == "":
            if config["required"]:
                missing_required.append((var_name, config))
            else:
                missing_optional.append((var_name, config))

    return missing_required, missing_optional


def main():
    missing_required, missing_optional = check_env_vars()

    # If all required vars are set, just output success
    if not missing_required and not missing_optional:
        result = {
            "status": "success",
            "message": "All MCP server environment variables configured",
        }
        print(json.dumps(result))
        return 0

    # Build warning message
    lines = []
    settings_path = get_settings_path()

    if missing_required:
        lines.append("MISSING REQUIRED ENVIRONMENT VARIABLES")
        lines.append("")
        for var_name, config in missing_required:
            lines.append(f"  - {var_name}: {config['description']}")
            lines.append(f"    Get your key at: {config['get_url']}")
        lines.append("")

    if missing_optional:
        lines.append("OPTIONAL ENVIRONMENT VARIABLES (recommended)")
        lines.append("")
        for var_name, config in missing_optional:
            lines.append(f"  - {var_name}: {config['description']}")
            lines.append(f"    Get your key at: {config['get_url']}")
        lines.append("")

    if missing_required or missing_optional:
        lines.append(f"TO CONFIGURE: Add to {settings_path}:")
        lines.append("")
        for line in SETTINGS_EXAMPLE.split("\n"):
            lines.append(f"  {line}")
        lines.append("")
        lines.append("Then restart Claude Code to apply changes.")

    result = {
        "status": "warning" if missing_required else "info",
        "message": "\n".join(lines),
    }

    print(json.dumps(result))
    return 0


if __name__ == "__main__":
    sys.exit(main())
