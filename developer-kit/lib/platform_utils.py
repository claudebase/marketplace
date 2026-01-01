#!/usr/bin/env python3
"""
Cross-platform utilities for Developer Kit.

Provides consistent behavior across Windows, macOS, and Linux for:
- Platform detection
- Command execution
- File operations
- Claude Code hook I/O

This module is designed to work with Python 3.9+ and has no external dependencies.
"""

import json
import os
import re
import subprocess
import sys
import tempfile
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple, Union


class PlatformInfo:
    """
    Platform detection and utilities.

    Provides methods to detect the current platform and get platform-specific
    values for paths, commands, and configurations.

    Example:
        >>> PlatformInfo.is_windows()
        False
        >>> PlatformInfo.get_python_command()
        'python3'
        >>> PlatformInfo.get_temp_dir()
        PosixPath('/tmp')
    """

    _cached_platform: Optional[Dict[str, Any]] = None

    @classmethod
    def _get_cached_info(cls) -> Dict[str, Any]:
        """Get or create cached platform information."""
        if cls._cached_platform is None:
            cls._cached_platform = {
                "is_windows": sys.platform == "win32" or os.name == "nt",
                "is_macos": sys.platform == "darwin",
                "is_linux": sys.platform.startswith("linux"),
                "platform": sys.platform,
            }
            # Check for WSL
            cls._cached_platform["is_wsl"] = cls._check_wsl()
        return cls._cached_platform

    @staticmethod
    def _check_wsl() -> bool:
        """Check if running in Windows Subsystem for Linux."""
        if not sys.platform.startswith("linux"):
            return False
        try:
            with open("/proc/version", "r") as f:
                version_info = f.read().lower()
                return "microsoft" in version_info or "wsl" in version_info
        except (FileNotFoundError, PermissionError, IOError):
            return False

    @classmethod
    def is_windows(cls) -> bool:
        """
        Check if running on Windows.

        Returns:
            True if running on Windows (native, not WSL), False otherwise.
        """
        return cls._get_cached_info()["is_windows"]

    @classmethod
    def is_macos(cls) -> bool:
        """
        Check if running on macOS.

        Returns:
            True if running on macOS, False otherwise.
        """
        return cls._get_cached_info()["is_macos"]

    @classmethod
    def is_linux(cls) -> bool:
        """
        Check if running on Linux (including WSL).

        Returns:
            True if running on Linux or WSL, False otherwise.
        """
        return cls._get_cached_info()["is_linux"]

    @classmethod
    def is_wsl(cls) -> bool:
        """
        Check if running in Windows Subsystem for Linux.

        Returns:
            True if running in WSL, False otherwise.
        """
        return cls._get_cached_info()["is_wsl"]

    @classmethod
    def is_unix(cls) -> bool:
        """
        Check if running on a Unix-like system (macOS, Linux, WSL).

        Returns:
            True if running on Unix-like system, False otherwise.
        """
        return cls.is_macos() or cls.is_linux()

    @classmethod
    def get_platform(cls) -> str:
        """
        Get the platform identifier.

        Returns:
            Platform string: 'win32', 'darwin', 'linux', etc.
        """
        return cls._get_cached_info()["platform"]

    @classmethod
    def get_python_command(cls) -> str:
        """
        Get the correct Python command for the current platform.

        On Windows, tries 'python', 'py', then 'python3'.
        On Unix systems, returns 'python3'.

        Returns:
            The Python command to use.
        """
        if cls.is_windows():
            # Try to find working Python command
            for cmd in ["python", "py", "python3"]:
                try:
                    result = subprocess.run(
                        [cmd, "--version"],
                        capture_output=True,
                        text=True,
                        timeout=5,
                    )
                    if result.returncode == 0 and "Python 3" in result.stdout:
                        return cmd
                except (FileNotFoundError, subprocess.TimeoutExpired):
                    continue
            return "python"  # Default fallback
        return "python3"

    @classmethod
    def get_temp_dir(cls) -> Path:
        """
        Get the cross-platform temporary directory.

        Returns:
            Path to the system temp directory.
        """
        return Path(tempfile.gettempdir())

    @classmethod
    def get_user_home(cls) -> Path:
        """
        Get the user's home directory.

        Returns:
            Path to the user's home directory.
        """
        return Path.home()

    @classmethod
    def get_user_config_dir(cls) -> Path:
        """
        Get the user config directory for Claude Code (~/.claude/ equivalent).

        On Windows, uses %APPDATA%/.claude or falls back to user home.
        On Unix, uses ~/.claude.

        Returns:
            Path to the Claude config directory.
        """
        if cls.is_windows():
            base = os.environ.get("APPDATA", str(Path.home()))
            return Path(base) / ".claude"
        return Path.home() / ".claude"

    @classmethod
    def get_project_dir(cls) -> Path:
        """
        Get the CLAUDE_PROJECT_DIR or fall back to current directory.

        Returns:
            Path to the project directory.
        """
        project_dir = os.environ.get("CLAUDE_PROJECT_DIR")
        if project_dir:
            return Path(project_dir)
        return Path.cwd()

    @classmethod
    def get_plugin_root(cls) -> Optional[Path]:
        """
        Get the CLAUDE_PLUGIN_ROOT if available.

        Returns:
            Path to the plugin root, or None if not set.
        """
        root = os.environ.get("CLAUDE_PLUGIN_ROOT")
        return Path(root) if root else None

    @classmethod
    def get_path_separator(cls) -> str:
        """
        Get the platform-specific path separator.

        Returns:
            '\\' on Windows, '/' on Unix.
        """
        return os.sep

    @classmethod
    def normalize_path(cls, path: Union[str, Path]) -> Path:
        """
        Normalize a path for the current platform.

        Args:
            path: Path string or Path object to normalize.

        Returns:
            Normalized Path object.
        """
        return Path(path).resolve()

    @classmethod
    def get_platform_info(cls) -> Dict[str, Any]:
        """
        Get comprehensive platform information.

        Returns:
            Dictionary with platform details.
        """
        info = cls._get_cached_info().copy()
        info.update(
            {
                "python_version": sys.version,
                "python_command": cls.get_python_command(),
                "temp_dir": str(cls.get_temp_dir()),
                "home_dir": str(cls.get_user_home()),
                "config_dir": str(cls.get_user_config_dir()),
                "path_separator": cls.get_path_separator(),
            }
        )
        return info


class CommandRunner:
    """
    Cross-platform command execution utilities.

    Provides methods to run commands consistently across Windows and Unix,
    with proper error handling and timeout support.
    """

    @staticmethod
    def run_command(
        cmd: List[str],
        cwd: Optional[Union[str, Path]] = None,
        timeout: int = 60,
        capture_output: bool = True,
        env: Optional[Dict[str, str]] = None,
        shell: bool = False,
    ) -> Tuple[int, str, str]:
        """
        Run a command cross-platform.

        Args:
            cmd: Command and arguments as a list.
            cwd: Working directory for the command.
            timeout: Timeout in seconds.
            capture_output: Whether to capture stdout/stderr.
            env: Additional environment variables.
            shell: Whether to run through shell (avoid if possible).

        Returns:
            Tuple of (return_code, stdout, stderr).
        """
        try:
            # Merge environment if provided
            run_env = os.environ.copy()
            if env:
                run_env.update(env)

            result = subprocess.run(
                cmd,
                cwd=str(cwd) if cwd else None,
                capture_output=capture_output,
                text=True,
                timeout=timeout,
                env=run_env,
                shell=shell,
            )
            return result.returncode, result.stdout or "", result.stderr or ""
        except subprocess.TimeoutExpired:
            return -1, "", f"Command timed out after {timeout} seconds"
        except FileNotFoundError:
            return -1, "", f"Command not found: {cmd[0]}"
        except PermissionError:
            return -1, "", f"Permission denied: {cmd[0]}"
        except Exception as e:
            return -1, "", f"Command execution error: {str(e)}"

    @staticmethod
    def check_command_exists(cmd: str) -> bool:
        """
        Check if a command exists on the system.

        Args:
            cmd: Command name to check.

        Returns:
            True if the command exists and is executable.
        """
        if PlatformInfo.is_windows():
            # Use 'where' on Windows
            check_cmd = ["where", cmd]
        else:
            # Use 'which' on Unix
            check_cmd = ["which", cmd]

        try:
            result = subprocess.run(
                check_cmd,
                capture_output=True,
                text=True,
                timeout=5,
            )
            return result.returncode == 0
        except (FileNotFoundError, subprocess.TimeoutExpired):
            return False

    @staticmethod
    def run_git_command(
        args: List[str],
        cwd: Optional[Union[str, Path]] = None,
        timeout: int = 30,
    ) -> Tuple[int, str, str]:
        """
        Run a git command.

        Args:
            args: Git subcommand and arguments.
            cwd: Working directory.
            timeout: Timeout in seconds.

        Returns:
            Tuple of (return_code, stdout, stderr).
        """
        return CommandRunner.run_command(["git"] + args, cwd=cwd, timeout=timeout)

    @staticmethod
    def run_npm_command(
        args: List[str],
        cwd: Optional[Union[str, Path]] = None,
        timeout: int = 120,
    ) -> Tuple[int, str, str]:
        """
        Run an npm command.

        Args:
            args: npm subcommand and arguments.
            cwd: Working directory.
            timeout: Timeout in seconds.

        Returns:
            Tuple of (return_code, stdout, stderr).
        """
        # On Windows, npm is actually npm.cmd
        npm_cmd = "npm.cmd" if PlatformInfo.is_windows() else "npm"
        return CommandRunner.run_command([npm_cmd] + args, cwd=cwd, timeout=timeout)

    @staticmethod
    def run_npx_command(
        args: List[str],
        cwd: Optional[Union[str, Path]] = None,
        timeout: int = 120,
    ) -> Tuple[int, str, str]:
        """
        Run an npx command.

        Args:
            args: npx arguments.
            cwd: Working directory.
            timeout: Timeout in seconds.

        Returns:
            Tuple of (return_code, stdout, stderr).
        """
        # On Windows, npx is actually npx.cmd
        npx_cmd = "npx.cmd" if PlatformInfo.is_windows() else "npx"
        return CommandRunner.run_command([npx_cmd] + args, cwd=cwd, timeout=timeout)


class FileUtils:
    """
    Cross-platform file utilities.

    Provides methods for common file operations that work consistently
    across Windows and Unix systems.
    """

    @staticmethod
    def read_json(path: Union[str, Path]) -> Dict[str, Any]:
        """
        Read and parse a JSON file.

        Args:
            path: Path to the JSON file.

        Returns:
            Parsed JSON data as a dictionary.

        Raises:
            FileNotFoundError: If file doesn't exist.
            json.JSONDecodeError: If file isn't valid JSON.
        """
        with open(path, "r", encoding="utf-8") as f:
            return json.load(f)

    @staticmethod
    def write_json(
        path: Union[str, Path],
        data: Dict[str, Any],
        indent: int = 2,
    ) -> None:
        """
        Write data to a JSON file.

        Creates parent directories if they don't exist.

        Args:
            path: Path to the JSON file.
            data: Data to write.
            indent: JSON indentation level.
        """
        path = Path(path)
        path.parent.mkdir(parents=True, exist_ok=True)
        with open(path, "w", encoding="utf-8") as f:
            json.dump(data, f, indent=indent, ensure_ascii=False)

    @staticmethod
    def read_text(path: Union[str, Path]) -> str:
        """
        Read a text file.

        Args:
            path: Path to the text file.

        Returns:
            File contents as a string.

        Raises:
            FileNotFoundError: If file doesn't exist.
        """
        with open(path, "r", encoding="utf-8") as f:
            return f.read()

    @staticmethod
    def write_text(path: Union[str, Path], content: str) -> None:
        """
        Write content to a text file.

        Creates parent directories if they don't exist.

        Args:
            path: Path to the text file.
            content: Content to write.
        """
        path = Path(path)
        path.parent.mkdir(parents=True, exist_ok=True)
        with open(path, "w", encoding="utf-8") as f:
            f.write(content)

    @staticmethod
    def read_lines(path: Union[str, Path]) -> List[str]:
        """
        Read a text file as lines.

        Args:
            path: Path to the text file.

        Returns:
            List of lines (without line endings).
        """
        with open(path, "r", encoding="utf-8") as f:
            return f.read().splitlines()

    @staticmethod
    def find_files(
        root: Union[str, Path],
        pattern: str,
        recursive: bool = True,
    ) -> List[Path]:
        """
        Find files matching a glob pattern.

        Args:
            root: Root directory to search.
            pattern: Glob pattern (e.g., '*.py', '**/*.md').
            recursive: Whether to search recursively.

        Returns:
            List of matching Path objects.
        """
        root = Path(root)
        if recursive:
            return sorted(root.rglob(pattern))
        return sorted(root.glob(pattern))

    @staticmethod
    def ensure_dir(path: Union[str, Path]) -> Path:
        """
        Ensure a directory exists, creating it if necessary.

        Args:
            path: Path to the directory.

        Returns:
            Path object for the directory.
        """
        path = Path(path)
        path.mkdir(parents=True, exist_ok=True)
        return path

    @staticmethod
    def file_exists(path: Union[str, Path]) -> bool:
        """
        Check if a file exists.

        Args:
            path: Path to check.

        Returns:
            True if file exists and is a file.
        """
        return Path(path).is_file()

    @staticmethod
    def dir_exists(path: Union[str, Path]) -> bool:
        """
        Check if a directory exists.

        Args:
            path: Path to check.

        Returns:
            True if path exists and is a directory.
        """
        return Path(path).is_dir()

    @staticmethod
    def get_file_extension(path: Union[str, Path]) -> str:
        """
        Get the file extension (lowercase, with dot).

        Args:
            path: Path to the file.

        Returns:
            Extension like '.py', '.js', or '' if no extension.
        """
        return Path(path).suffix.lower()

    @staticmethod
    def get_file_stem(path: Union[str, Path]) -> str:
        """
        Get the file name without extension.

        Args:
            path: Path to the file.

        Returns:
            File name without extension.
        """
        return Path(path).stem

    @staticmethod
    def get_relative_path(path: Union[str, Path], base: Union[str, Path]) -> Path:
        """
        Get path relative to a base directory.

        Args:
            path: Path to make relative.
            base: Base directory.

        Returns:
            Relative path.
        """
        return Path(path).relative_to(base)


class HookIO:
    """
    Utilities for Claude Code hook input/output.

    Provides methods for reading hook input from stdin and writing
    properly formatted JSON responses to stdout.
    """

    @staticmethod
    def read_input() -> Dict[str, Any]:
        """
        Read JSON input from stdin (for hooks).

        Returns:
            Parsed JSON data, or empty dict if no input or invalid JSON.
        """
        try:
            raw = sys.stdin.read()
            if not raw or not raw.strip():
                return {}
            return json.loads(raw)
        except json.JSONDecodeError:
            return {}
        except Exception:
            return {}

    @staticmethod
    def output_response(response: Dict[str, Any]) -> None:
        """
        Output JSON response to stdout and exit.

        Args:
            response: Response dictionary to output.
        """
        print(json.dumps(response, ensure_ascii=False))
        sys.exit(0)

    @staticmethod
    def allow_continue(
        message: Optional[str] = None,
        suppress: bool = False,
    ) -> None:
        """
        Output a continue response for PostToolUse hooks.

        Args:
            message: Optional system message to display.
            suppress: Whether to suppress output.
        """
        response: Dict[str, Any] = {"continue": True}
        if suppress:
            response["suppressOutput"] = True
        elif message:
            response["systemMessage"] = message
        HookIO.output_response(response)

    @staticmethod
    def deny_permission(
        reason: str,
        hook_event: str = "PreToolUse",
    ) -> None:
        """
        Output a deny permission response for PreToolUse hooks.

        Args:
            reason: Reason for denying permission.
            hook_event: Hook event name.
        """
        HookIO.output_response(
            {
                "hookSpecificOutput": {
                    "hookEventName": hook_event,
                    "permissionDecision": "deny",
                    "permissionDecisionReason": reason,
                }
            }
        )

    @staticmethod
    def ask_permission(
        reason: str,
        hook_event: str = "PreToolUse",
    ) -> None:
        """
        Output an ask permission response for PreToolUse hooks.

        Args:
            reason: Reason for asking permission.
            hook_event: Hook event name.
        """
        HookIO.output_response(
            {
                "hookSpecificOutput": {
                    "hookEventName": hook_event,
                    "permissionDecision": "ask",
                    "permissionDecisionReason": reason,
                }
            }
        )

    @staticmethod
    def block_with_message(
        message: str,
        hook_event: str = "PreToolUse",
    ) -> None:
        """
        Block the operation with a message.

        Args:
            message: Message to display.
            hook_event: Hook event name.
        """
        HookIO.output_response(
            {
                "hookSpecificOutput": {
                    "hookEventName": hook_event,
                    "permissionDecision": "block",
                    "permissionDecisionReason": message,
                }
            }
        )

    @staticmethod
    def get_tool_input(input_data: Dict[str, Any]) -> Dict[str, Any]:
        """
        Extract tool_input from hook input data.

        Args:
            input_data: Full hook input data.

        Returns:
            Tool input dictionary.
        """
        return input_data.get("tool_input", {})

    @staticmethod
    def get_tool_name(input_data: Dict[str, Any]) -> str:
        """
        Extract tool_name from hook input data.

        Args:
            input_data: Full hook input data.

        Returns:
            Tool name string.
        """
        return input_data.get("tool_name", "")

    @staticmethod
    def get_session_id(input_data: Dict[str, Any]) -> str:
        """
        Extract session_id from hook input data.

        Args:
            input_data: Full hook input data.

        Returns:
            Session ID string.
        """
        return input_data.get("session_id", "default")

    @staticmethod
    def get_file_path(input_data: Dict[str, Any]) -> Optional[str]:
        """
        Extract file_path from tool input.

        Checks both 'file_path' and 'path' keys.

        Args:
            input_data: Full hook input data.

        Returns:
            File path string or None.
        """
        tool_input = HookIO.get_tool_input(input_data)
        return tool_input.get("file_path") or tool_input.get("path")


class FrontmatterParser:
    """
    YAML frontmatter parser for skill/agent/command files.

    Parses the YAML frontmatter at the start of markdown files,
    handling the --- delimiters.
    """

    @staticmethod
    def parse(content: str) -> Tuple[Dict[str, Any], str]:
        """
        Parse frontmatter from markdown content.

        Args:
            content: Full markdown content.

        Returns:
            Tuple of (frontmatter_dict, remaining_content).
        """
        if not content.startswith("---"):
            return {}, content

        # Find the closing ---
        lines = content.split("\n")
        end_index = -1
        for i, line in enumerate(lines[1:], 1):
            if line.strip() == "---":
                end_index = i
                break

        if end_index == -1:
            return {}, content

        # Parse frontmatter (simple key: value parsing)
        frontmatter_lines = lines[1:end_index]
        frontmatter: Dict[str, Any] = {}

        current_key = None
        current_value: List[str] = []

        for line in frontmatter_lines:
            # Check for new key
            if re.match(r"^[a-zA-Z_-]+:", line):
                # Save previous key if exists
                if current_key:
                    value = "\n".join(current_value).strip()
                    frontmatter[current_key] = value

                # Parse new key
                parts = line.split(":", 1)
                current_key = parts[0].strip()
                current_value = [parts[1].strip()] if len(parts) > 1 else []
            elif current_key and line.strip():
                # Continuation of previous value
                current_value.append(line.strip())

        # Save last key
        if current_key:
            value = "\n".join(current_value).strip()
            frontmatter[current_key] = value

        # Get remaining content
        remaining = "\n".join(lines[end_index + 1 :])

        return frontmatter, remaining

    @staticmethod
    def has_field(content: str, field: str) -> bool:
        """
        Check if frontmatter has a specific field.

        Args:
            content: Full markdown content.
            field: Field name to check.

        Returns:
            True if field exists in frontmatter.
        """
        frontmatter, _ = FrontmatterParser.parse(content)
        return field in frontmatter

    @staticmethod
    def get_field(content: str, field: str, default: Any = None) -> Any:
        """
        Get a specific field from frontmatter.

        Args:
            content: Full markdown content.
            field: Field name to get.
            default: Default value if field not found.

        Returns:
            Field value or default.
        """
        frontmatter, _ = FrontmatterParser.parse(content)
        return frontmatter.get(field, default)


# Convenience function for quick platform check
def get_platform() -> str:
    """
    Quick function to get the current platform.

    Returns:
        'windows', 'macos', 'linux', or 'wsl'.
    """
    if PlatformInfo.is_wsl():
        return "wsl"
    if PlatformInfo.is_windows():
        return "windows"
    if PlatformInfo.is_macos():
        return "macos"
    if PlatformInfo.is_linux():
        return "linux"
    return "unknown"


if __name__ == "__main__":
    # Self-test when run directly
    print("Platform Utilities Self-Test")
    print("=" * 40)
    print(f"Platform: {get_platform()}")
    print(f"Is Windows: {PlatformInfo.is_windows()}")
    print(f"Is macOS: {PlatformInfo.is_macos()}")
    print(f"Is Linux: {PlatformInfo.is_linux()}")
    print(f"Is WSL: {PlatformInfo.is_wsl()}")
    print(f"Python command: {PlatformInfo.get_python_command()}")
    print(f"Temp dir: {PlatformInfo.get_temp_dir()}")
    print(f"Home dir: {PlatformInfo.get_user_home()}")
    print(f"Config dir: {PlatformInfo.get_user_config_dir()}")
    print(f"Project dir: {PlatformInfo.get_project_dir()}")
    print(f"Plugin root: {PlatformInfo.get_plugin_root()}")
    print()
    print("Command availability:")
    for cmd in ["git", "python", "python3", "node", "npm", "npx"]:
        exists = CommandRunner.check_command_exists(cmd)
        print(f"  {cmd}: {'available' if exists else 'not found'}")
    print()
    print("Self-test complete!")
