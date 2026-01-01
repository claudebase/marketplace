#!/usr/bin/env python3
"""
PostToolUse hook for auto-formatting files after Write/Edit operations.

Receives JSON input via stdin per Claude Code specification.
Returns JSON response per Claude Code hook spec.

Supports formatting for multiple languages using their standard formatters:
- JavaScript/TypeScript: prettier
- Python: black
- Go: gofmt
- Rust: rustfmt
"""

import os
import sys
from pathlib import Path
from typing import Optional, Tuple

# Add lib directory to path for cross-platform utilities
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "lib"))

from platform_utils import HookIO, CommandRunner

# File extensions and their formatters
# Format: extension -> (formatter_name, base_command)
FORMATTERS = {
    # JavaScript/TypeScript family (prettier)
    ".js": ("prettier", ["prettier", "--write"]),
    ".jsx": ("prettier", ["prettier", "--write"]),
    ".ts": ("prettier", ["prettier", "--write"]),
    ".tsx": ("prettier", ["prettier", "--write"]),
    ".mjs": ("prettier", ["prettier", "--write"]),
    ".cjs": ("prettier", ["prettier", "--write"]),
    ".json": ("prettier", ["prettier", "--write"]),
    ".css": ("prettier", ["prettier", "--write"]),
    ".scss": ("prettier", ["prettier", "--write"]),
    ".less": ("prettier", ["prettier", "--write"]),
    ".md": ("prettier", ["prettier", "--write"]),
    ".yaml": ("prettier", ["prettier", "--write"]),
    ".yml": ("prettier", ["prettier", "--write"]),
    ".html": ("prettier", ["prettier", "--write"]),
    ".vue": ("prettier", ["prettier", "--write"]),
    ".svelte": ("prettier", ["prettier", "--write"]),
    ".graphql": ("prettier", ["prettier", "--write"]),
    ".gql": ("prettier", ["prettier", "--write"]),
    # Python (black)
    ".py": ("black", ["black", "--quiet"]),
    ".pyi": ("black", ["black", "--quiet"]),
    # Go (gofmt)
    ".go": ("gofmt", ["gofmt", "-w"]),
    # Rust (rustfmt)
    ".rs": ("rustfmt", ["rustfmt"]),
}

# Alternative commands to try if primary fails
FALLBACK_COMMANDS = {
    "prettier": [
        ["npx", "prettier", "--write"],
        ["yarn", "prettier", "--write"],
        ["pnpm", "prettier", "--write"],
    ],
    "black": [
        ["python3", "-m", "black", "--quiet"],
        ["python", "-m", "black", "--quiet"],
    ],
}


def get_formatter_command(formatter_name: str, base_cmd: list) -> Optional[list]:
    """
    Get the working formatter command.

    Tries the base command first, then falls back to alternatives.

    Args:
        formatter_name: Name of the formatter.
        base_cmd: Base command to try first.

    Returns:
        Working command list, or None if no formatter available.
    """
    # Try base command
    if CommandRunner.check_command_exists(base_cmd[0]):
        return base_cmd

    # Try fallback commands
    fallbacks = FALLBACK_COMMANDS.get(formatter_name, [])
    for fallback in fallbacks:
        # For npx/yarn/pnpm, check if the package manager exists
        if CommandRunner.check_command_exists(fallback[0]):
            return fallback

    return None


def format_file(file_path: Path) -> Tuple[bool, str]:
    """
    Format a file using the appropriate formatter.

    Args:
        file_path: Path to the file to format.

    Returns:
        Tuple of (success, formatter_name).
    """
    suffix = file_path.suffix.lower()

    if suffix not in FORMATTERS:
        return False, ""

    formatter_name, base_cmd = FORMATTERS[suffix]

    # Get working formatter command
    cmd = get_formatter_command(formatter_name, base_cmd)
    if cmd is None:
        return False, ""

    # Build full command with file path
    full_cmd = cmd + [str(file_path)]

    # Run formatter
    returncode, stdout, stderr = CommandRunner.run_command(
        full_cmd,
        timeout=30,
        cwd=file_path.parent,
    )

    return returncode == 0, formatter_name


def main():
    """Main hook function."""
    input_data = HookIO.read_input()

    # Extract file path from tool_input
    file_path_str = HookIO.get_file_path(input_data)

    if not file_path_str:
        HookIO.allow_continue(suppress=True)
        return

    file_path = Path(file_path_str)

    # Check if file exists (might have been deleted)
    if not file_path.exists():
        HookIO.allow_continue(suppress=True)
        return

    # Check if it's a file (not a directory)
    if not file_path.is_file():
        HookIO.allow_continue(suppress=True)
        return

    # Try to format the file
    success, formatter_name = format_file(file_path)

    if success:
        HookIO.allow_continue(
            message=f"Formatted {file_path.name} with {formatter_name}"
        )
    else:
        # Silently continue if no formatter available or formatting failed
        HookIO.allow_continue(suppress=True)


if __name__ == "__main__":
    main()
