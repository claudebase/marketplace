#!/usr/bin/env python3
"""
SessionStart hook for context restoration.

Returns JSON response per Claude Code hook specification.

This hook restores session context by:
- Displaying the current git branch
- Showing the current goal from context file
- Displaying progress (completed/pending tasks)
- Showing last session date if available
"""

import os
import re
import sys
from pathlib import Path
from typing import Tuple

# Add lib directory to path for cross-platform utilities
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "lib"))

from platform_utils import HookIO, CommandRunner, PlatformInfo, FileUtils


def get_current_branch(project_dir: Path) -> str:
    """
    Get current git branch name.

    Args:
        project_dir: Project directory path.

    Returns:
        Branch name or empty string if not a git repo.
    """
    git_dir = project_dir / ".git"
    if not git_dir.exists():
        return ""

    returncode, stdout, stderr = CommandRunner.run_git_command(
        ["branch", "--show-current"],
        cwd=project_dir,
        timeout=5,
    )

    return stdout.strip() if returncode == 0 else ""


def extract_goal(content: str) -> str:
    """
    Extract goal from context file content.

    Looks for the line following '## Goal' heading.

    Args:
        content: File content.

    Returns:
        Goal text or empty string.
    """
    # Look for ## Goal section and get the line after it
    match = re.search(r"^## Goal\s*\n(.+)", content, re.MULTILINE)
    if match:
        goal = match.group(1).strip()
        # Filter out placeholder text
        if goal and not goal.startswith("[To be defined"):
            return goal
    return ""


def count_checkboxes(content: str) -> Tuple[int, int]:
    """
    Count completed and pending checkboxes in content.

    Args:
        content: File content.

    Returns:
        Tuple of (completed_count, pending_count).
    """
    completed = len(re.findall(r"^- \[x\]", content, re.MULTILINE | re.IGNORECASE))
    pending = len(re.findall(r"^- \[ \]", content, re.MULTILINE))
    return completed, pending


def extract_last_date(content: str) -> str:
    """
    Extract date from last session file.

    Args:
        content: File content.

    Returns:
        Date string or empty string.
    """
    match = re.search(r"\*\*Date\*\*:\s*(.+)", content)
    return match.group(1).strip() if match else ""


def main():
    """Main hook function."""
    project_dir = PlatformInfo.get_project_dir()
    context_file = project_dir / "docs" / "session" / "current-context.md"
    last_session = project_dir / "docs" / "session" / "last-session.md"

    output_parts = []

    # Get current git branch
    branch = get_current_branch(project_dir)
    if branch:
        output_parts.append(f"Branch: {branch}")

    # Check for current context file
    if context_file.exists():
        try:
            content = FileUtils.read_text(context_file)

            goal = extract_goal(content)
            completed, pending = count_checkboxes(content)

            if goal:
                output_parts.append(
                    f"Goal: {goal} | Progress: {completed} done, {pending} pending"
                )
            elif completed > 0 or pending > 0:
                output_parts.append(f"Progress: {completed} done, {pending} pending")
        except Exception:
            pass  # Silently ignore read errors

    # Check for last session file
    if last_session.exists():
        try:
            content = FileUtils.read_text(last_session)
            last_date = extract_last_date(content)
            if last_date:
                output_parts.append(f"Last session: {last_date}")
        except Exception:
            pass  # Silently ignore read errors

    # Build and output response
    if output_parts:
        message = "Session restored: " + " | ".join(output_parts)
        HookIO.allow_continue(message=message)
    else:
        HookIO.allow_continue(suppress=True)


if __name__ == "__main__":
    main()
