#!/usr/bin/env python3
"""
CI-specific tests for Developer Kit.

These tests are extracted from inline Python in GitHub Actions
to avoid cross-platform string parsing issues with PowerShell.

Usage:
    python scripts/ci_tests.py --platform    # Test platform detection
    python scripts/ci_tests.py --hook-io     # Test HookIO JSON parsing
    python scripts/ci_tests.py --counts      # Test component counts
    python scripts/ci_tests.py --all         # Run all tests (default)
"""

import argparse
import json
import sys
from pathlib import Path

# Add lib directory to path
SCRIPT_DIR = Path(__file__).parent.resolve()
PLUGIN_DIR = SCRIPT_DIR.parent
sys.path.insert(0, str(PLUGIN_DIR / "lib"))


def test_platform_detection():
    """Test platform detection utilities."""
    print("=" * 50)
    print("Testing platform detection...")
    print("=" * 50)

    from platform_utils import PlatformInfo

    print(f"Platform: {sys.platform}")
    print(f"is_windows: {PlatformInfo.is_windows()}")
    print(f"is_macos: {PlatformInfo.is_macos()}")
    print(f"is_linux: {PlatformInfo.is_linux()}")
    print(f"is_wsl: {PlatformInfo.is_wsl()}")
    print(f"python_cmd: {PlatformInfo.get_python_command()}")
    print(f"temp_dir: {PlatformInfo.get_temp_dir()}")
    print(f"config_dir: {PlatformInfo.get_user_config_dir()}")

    # Validate that exactly one main platform is detected
    platforms = [
        PlatformInfo.is_windows(),
        PlatformInfo.is_macos(),
        PlatformInfo.is_linux(),
    ]
    # WSL can be True alongside Linux
    if not any(platforms):
        print("ERROR: No platform detected!")
        return False

    print("Platform detection: OK")
    return True


def test_hook_io():
    """Test HookIO JSON parsing."""
    print("=" * 50)
    print("Testing HookIO JSON parsing...")
    print("=" * 50)

    import io

    from platform_utils import HookIO

    # Test JSON parsing with simulated stdin
    test_input = '{"tool_name": "Bash", "tool_input": {"command": "echo hello"}}'
    original_stdin = sys.stdin
    sys.stdin = io.StringIO(test_input)

    try:
        data = HookIO.read_input()
        assert data["tool_name"] == "Bash", "Tool name parsing failed"
        assert (
            data["tool_input"]["command"] == "echo hello"
        ), "Tool input parsing failed"
        print("HookIO JSON parsing: OK")
        return True
    except Exception as e:
        print(f"ERROR: HookIO parsing failed: {e}")
        return False
    finally:
        sys.stdin = original_stdin


def test_component_counts():
    """Test component counts match expectations."""
    print("=" * 50)
    print("Testing component counts...")
    print("=" * 50)

    skills = len(list((PLUGIN_DIR / "skills").glob("*/SKILL.md")))
    agents = len(list((PLUGIN_DIR / "agents").glob("*.md")))
    commands = len(list((PLUGIN_DIR / "commands").rglob("*.md")))
    refs = len(list(PLUGIN_DIR.rglob("references/*.md")))

    print(f"Skills: {skills}")
    print(f"Agents: {agents}")
    print(f"Commands: {commands}")
    print(f"Reference files: {refs}")

    # Load plugin version
    plugin_json = PLUGIN_DIR / ".claude-plugin" / "plugin.json"
    with open(plugin_json) as f:
        version = json.load(f)["version"]
    print(f"Plugin version: {version}")

    # Validate minimum counts
    errors = []
    if skills < 20:
        errors.append(f"Expected at least 20 skills, got {skills}")
    if agents < 10:
        errors.append(f"Expected at least 10 agents, got {agents}")
    if commands < 15:
        errors.append(f"Expected at least 15 commands, got {commands}")

    if errors:
        for error in errors:
            print(f"ERROR: {error}")
        return False

    print("Component counts: OK")
    return True


def main():
    parser = argparse.ArgumentParser(description="Developer Kit CI Tests")
    parser.add_argument(
        "--platform", action="store_true", help="Test platform detection"
    )
    parser.add_argument(
        "--hook-io", action="store_true", help="Test HookIO JSON parsing"
    )
    parser.add_argument("--counts", action="store_true", help="Test component counts")
    parser.add_argument(
        "--all", "-a", action="store_true", help="Run all tests (default)"
    )
    args = parser.parse_args()

    # Default to running all tests
    run_all = args.all or not any([args.platform, args.hook_io, args.counts])

    results = []

    if run_all or args.platform:
        results.append(("Platform Detection", test_platform_detection()))
        print()

    if run_all or args.hook_io:
        results.append(("HookIO Parsing", test_hook_io()))
        print()

    if run_all or args.counts:
        results.append(("Component Counts", test_component_counts()))
        print()

    # Summary
    print("=" * 50)
    print("  CI Test Summary")
    print("=" * 50)

    passed = sum(1 for _, ok in results if ok)
    failed = sum(1 for _, ok in results if not ok)

    for name, ok in results:
        status = "PASS" if ok else "FAIL"
        print(f"  {status}: {name}")

    print()
    print(f"  Passed: {passed}/{len(results)}")

    if failed > 0:
        print(f"\nFAILED: {failed} test(s) failed")
        sys.exit(1)
    else:
        print("\nAll CI tests passed!")
        sys.exit(0)


if __name__ == "__main__":
    main()
