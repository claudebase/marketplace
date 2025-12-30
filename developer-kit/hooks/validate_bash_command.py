#!/usr/bin/env python3
"""
PreToolUse hook to validate bash commands for safety.

Receives JSON input via stdin per Claude Code specification.
Output uses hookSpecificOutput.permissionDecision format for PreToolUse.

This hook blocks dangerous commands that could cause catastrophic damage,
and prompts for confirmation on commands using elevated privileges.
"""

import os
import sys

# Add lib directory to path for cross-platform utilities
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "lib"))

from platform_utils import HookIO, PlatformInfo

# Dangerous patterns that should be blocked - both Unix and Windows
DANGEROUS_PATTERNS = [
    # Unix dangerous patterns
    "rm -rf /",
    "rm -rf /*",
    "rm -rf ~",
    "rm -rf ~/",
    "rm -rf $HOME",
    "> /dev/sda",
    "> /dev/nvme",
    "mkfs.",
    "dd if=/dev/zero of=/dev",
    "dd if=/dev/random of=/dev",
    ":(){:|:&};:",  # Fork bomb
    "chmod -R 777 /",
    "chown -R",
    "mv /* ",
    "mv / ",
    # Windows dangerous patterns
    "format c:",
    "format d:",
    "del /f /s /q c:\\",
    "del /f /s /q c:/",
    "rd /s /q c:\\",
    "rd /s /q c:/",
    "rmdir /s /q c:\\",
    "rmdir /s /q c:/",
    # PowerShell dangerous patterns
    "remove-item -recurse -force c:",
    "remove-item -r -fo c:",
    "rm -r -fo c:",
    "del -r -fo c:",
    # Git dangerous patterns (that could affect system)
    "git clean -fdx /",
]

# Patterns that require confirmation (elevated privileges)
ELEVATED_PATTERNS = [
    "sudo ",
    "sudo\t",
    "doas ",
    "runas ",
    "pkexec ",
    "run as administrator",
    # PowerShell elevation
    "start-process.*-verb runas",
]


def normalize_command(command: str) -> str:
    """Normalize command for pattern matching."""
    return command.lower().strip()


def check_dangerous_patterns(command: str) -> tuple[bool, str]:
    """
    Check if command matches any dangerous patterns.

    Returns:
        Tuple of (is_dangerous, matched_pattern)
    """
    normalized = normalize_command(command)

    for pattern in DANGEROUS_PATTERNS:
        if pattern.lower() in normalized:
            return True, pattern

    return False, ""


def check_elevated_patterns(command: str) -> tuple[bool, str]:
    """
    Check if command requires elevated privileges.

    Returns:
        Tuple of (requires_elevation, matched_pattern)
    """
    normalized = normalize_command(command)

    for pattern in ELEVATED_PATTERNS:
        if pattern.lower() in normalized:
            return True, pattern

    return False, ""


def main():
    """Main hook function."""
    input_data = HookIO.read_input()

    # Extract command from tool input
    tool_input = HookIO.get_tool_input(input_data)
    command = tool_input.get("command", "")

    # If no command provided, allow by default
    if not command:
        HookIO.output_response({})
        return

    # Check for dangerous patterns
    is_dangerous, dangerous_pattern = check_dangerous_patterns(command)
    if is_dangerous:
        HookIO.deny_permission(
            f"Potentially dangerous command pattern detected: '{dangerous_pattern}'. "
            "This command could cause catastrophic system damage."
        )
        return

    # Check for elevated privilege patterns
    requires_elevation, elevated_pattern = check_elevated_patterns(command)
    if requires_elevation:
        HookIO.ask_permission(
            f"Command uses elevated privileges ({elevated_pattern.strip()}). "
            "Please confirm you want to run with elevated privileges."
        )
        return

    # Allow command to proceed (empty object uses default permission behavior)
    HookIO.output_response({})


if __name__ == "__main__":
    main()
