#!/usr/bin/env python3
"""
Developer Kit Validation Script

Unified validation script that replaces multiple shell validation scripts.
Cross-platform compatible: works on Windows, macOS, and Linux.

Usage:
    python scripts/validate.py              # Run all validations
    python scripts/validate.py --skills     # Validate skill descriptions
    python scripts/validate.py --agents     # Validate agent fields
    python scripts/validate.py --refs       # Validate references
    python scripts/validate.py --frontmatter # Validate frontmatter
    python scripts/validate.py --json       # Validate JSON configs
"""

import argparse
import re
import sys
from pathlib import Path
from typing import Tuple

# Add lib directory to path for cross-platform utilities
SCRIPT_DIR = Path(__file__).parent.resolve()
PLUGIN_DIR = SCRIPT_DIR.parent
sys.path.insert(0, str(PLUGIN_DIR / "lib"))

from platform_utils import FileUtils


class Colors:
    """ANSI color codes for terminal output."""

    RED = "\033[0;31m"
    GREEN = "\033[0;32m"
    YELLOW = "\033[1;33m"
    NC = "\033[0m"

    @classmethod
    def disable(cls):
        cls.RED = cls.GREEN = cls.YELLOW = cls.NC = ""


def print_error(msg: str):
    print(f"{Colors.RED}ERROR{Colors.NC}: {msg}")


def print_warning(msg: str):
    print(f"{Colors.YELLOW}WARNING{Colors.NC}: {msg}")


def print_ok(msg: str):
    print(f"{Colors.GREEN}OK{Colors.NC}: {msg}")


def validate_skill_descriptions(plugin_dir: Path) -> Tuple[int, int]:
    """
    Validate skill descriptions have required fields and trigger phrases.

    Returns:
        Tuple of (error_count, warning_count).
    """
    print("=" * 50)
    print("Validating skill descriptions...")
    print("=" * 50)

    skills_dir = plugin_dir / "skills"
    errors = 0
    warnings = 0
    checked = 0

    for skill_dir in sorted(skills_dir.iterdir()):
        if not skill_dir.is_dir():
            continue

        skill_file = skill_dir / "SKILL.md"
        if not skill_file.exists():
            continue

        skill_name = skill_dir.name
        checked += 1
        content = FileUtils.read_text(skill_file)

        # Extract frontmatter
        frontmatter_match = re.search(r"^---\n(.*?)\n---", content, re.DOTALL)
        frontmatter = frontmatter_match.group(1) if frontmatter_match else ""

        # Check for name field
        if not re.search(r"^name:", frontmatter, re.MULTILINE):
            print_error(f"{skill_name} - Missing 'name' field")
            errors += 1

        # Check for description field
        if not re.search(r"^description:", frontmatter, re.MULTILINE):
            print_error(f"{skill_name} - Missing 'description' field")
            errors += 1
            continue

        # Check for trigger phrases in description (accepts multiple formats)
        has_triggers = (
            "activates for:" in content.lower()
            or "triggers on" in content.lower()
            or "use when" in content.lower()
        )
        if not has_triggers:
            print_warning(
                f"{skill_name} - Missing trigger phrases (Activates for/Triggers on/Use when)"
            )
            warnings += 1
        else:
            print_ok(f"{skill_name}")

    print()
    print(f"Checked {checked} skills | Errors: {errors} | Warnings: {warnings}")
    return errors, warnings


def validate_agent_fields(plugin_dir: Path) -> Tuple[int, int]:
    """
    Validate agent files have required fields.

    Returns:
        Tuple of (error_count, warning_count).
    """
    print("=" * 50)
    print("Validating agent fields...")
    print("=" * 50)

    agents_dir = plugin_dir / "agents"
    required_fields = ["name", "description", "tools", "model"]
    valid_models = ["sonnet", "opus", "haiku"]
    errors = 0
    warnings = 0
    checked = 0

    for agent_file in sorted(agents_dir.glob("*.md")):
        agent_name = agent_file.stem
        checked += 1
        content = FileUtils.read_text(agent_file)

        # Extract frontmatter
        frontmatter_match = re.search(r"^---\n(.*?)\n---", content, re.DOTALL)
        frontmatter = frontmatter_match.group(1) if frontmatter_match else ""

        agent_errors = 0
        agent_warnings = 0

        # Check required fields
        for field in required_fields:
            if not re.search(rf"^{field}:", frontmatter, re.MULTILINE):
                print_error(f"{agent_name} - Missing required field '{field}'")
                agent_errors += 1

        # Validate model value
        model_match = re.search(r"^model:\s*(\S+)", frontmatter, re.MULTILINE)
        if model_match:
            model_value = model_match.group(1)
            if model_value not in valid_models:
                print_warning(
                    f"{agent_name} - Invalid model '{model_value}' "
                    f"(expected: {', '.join(valid_models)})"
                )
                agent_warnings += 1

        if agent_errors == 0 and agent_warnings == 0:
            print_ok(agent_name)

        errors += agent_errors
        warnings += agent_warnings

    print()
    print(f"Checked {checked} agents | Errors: {errors} | Warnings: {warnings}")
    return errors, warnings


def _remove_code_blocks(content: str) -> str:
    """Remove fenced code blocks from markdown content."""
    # Remove fenced code blocks (```...```)
    return re.sub(r"```[\s\S]*?```", "", content)


def validate_references(plugin_dir: Path) -> Tuple[int, int]:
    """
    Validate that referenced files exist.

    Handles both local references (references/file.md) and relative paths
    (../../lib/shared-references/file.md). Ignores links inside code blocks.

    Returns:
        Tuple of (error_count, warning_count).
    """
    print("=" * 50)
    print("Validating skill references...")
    print("=" * 50)

    skills_dir = plugin_dir / "skills"
    errors = 0
    refs_checked = 0
    skills_checked = 0

    for skill_dir in sorted(skills_dir.iterdir()):
        if not skill_dir.is_dir():
            continue

        skill_file = skill_dir / "SKILL.md"
        if not skill_file.exists():
            continue

        content = FileUtils.read_text(skill_file)
        # Remove code blocks to avoid false positives from example templates
        content_no_code = _remove_code_blocks(content)
        skill_name = skill_dir.name
        skills_checked += 1

        # Find markdown links to .md files: [text](path/to/file.md)
        # This captures the full relative path including ../ prefixes
        refs = re.findall(r"\]\(([^)]+\.md)\)", content_no_code)
        skill_errors = 0
        valid_refs = 0

        for ref in set(refs):
            # Skip external URLs
            if ref.startswith("http://") or ref.startswith("https://"):
                continue

            refs_checked += 1

            # Resolve the path relative to the skill directory
            ref_path = (skill_dir / ref).resolve()

            if not ref_path.exists():
                print_error(f"{skill_name} - Missing reference file: {ref}")
                skill_errors += 1
            else:
                valid_refs += 1

        if skill_errors == 0 and valid_refs > 0:
            print_ok(f"{skill_name} ({valid_refs} references)")

        errors += skill_errors

    print()
    print(
        f"Checked {skills_checked} skills | References: {refs_checked} | Errors: {errors}"
    )
    return errors, 0


def validate_frontmatter(plugin_dir: Path) -> Tuple[int, int]:
    """
    Validate frontmatter in all component files.

    Returns:
        Tuple of (error_count, warning_count).
    """
    print("=" * 50)
    print("Validating frontmatter...")
    print("=" * 50)

    errors = 0
    warnings = 0

    # Validate skills
    print("\nChecking skills...")
    skills_dir = plugin_dir / "skills"
    for skill_dir in sorted(skills_dir.iterdir()):
        if not skill_dir.is_dir():
            continue

        skill_file = skill_dir / "SKILL.md"
        if not skill_file.exists():
            continue

        skill_name = skill_dir.name
        content = FileUtils.read_text(skill_file)

        if not content.startswith("---"):
            print_error(f"skills/{skill_name}/SKILL.md - Missing frontmatter")
            errors += 1
            continue

        if not re.search(r"^name:", content, re.MULTILINE):
            print_error(f"skills/{skill_name} - Missing 'name' field")
            errors += 1

        if not re.search(r"^description:", content, re.MULTILINE):
            print_error(f"skills/{skill_name} - Missing 'description' field")
            errors += 1

        # Check for deprecated fields
        frontmatter_match = re.search(r"^---\n(.*?)\n---", content, re.DOTALL)
        if frontmatter_match:
            fm = frontmatter_match.group(1)
            for deprecated in ["when_to_use", "version", "languages"]:
                if re.search(rf"^{deprecated}:", fm, re.MULTILINE):
                    print_warning(
                        f"skills/{skill_name} - Has deprecated '{deprecated}' field"
                    )
                    warnings += 1

    # Validate agents
    print("\nChecking agents...")
    agents_dir = plugin_dir / "agents"
    for agent_file in sorted(agents_dir.glob("*.md")):
        agent_name = agent_file.stem
        content = FileUtils.read_text(agent_file)

        if not content.startswith("---"):
            print_error(f"agents/{agent_name}.md - Missing frontmatter")
            errors += 1
            continue

        for field in ["name", "description"]:
            if not re.search(rf"^{field}:", content, re.MULTILINE):
                print_error(f"agents/{agent_name} - Missing '{field}' field")
                errors += 1

        for field in ["tools", "model"]:
            if not re.search(rf"^{field}:", content, re.MULTILINE):
                print_warning(f"agents/{agent_name} - Missing '{field}' field")
                warnings += 1

    # Validate commands
    print("\nChecking commands...")
    commands_dir = plugin_dir / "commands"
    for cmd_file in sorted(commands_dir.rglob("*.md")):
        cmd_name = cmd_file.stem
        content = FileUtils.read_text(cmd_file)

        if not content.startswith("---"):
            print_error(f"commands/{cmd_name}.md - Missing frontmatter")
            errors += 1
            continue

        if not re.search(r"^description:", content, re.MULTILINE):
            print_error(f"commands/{cmd_name} - Missing 'description' field")
            errors += 1

    print()
    print(f"Errors: {errors} | Warnings: {warnings}")
    return errors, warnings


def validate_json_configs(plugin_dir: Path) -> Tuple[int, int]:
    """
    Validate JSON configuration files.

    Returns:
        Tuple of (error_count, warning_count).
    """
    print("=" * 50)
    print("Validating JSON configuration files...")
    print("=" * 50)

    errors = 0
    warnings = 0

    json_files = [
        (".mcp.json", True),
        (".lsp.json", True),
        ("hooks/hooks.json", True),
        (".claude-plugin/plugin.json", True),
    ]

    for json_path, required in json_files:
        full_path = plugin_dir / json_path
        if not full_path.exists():
            if required:
                print_error(f"{json_path} not found")
                errors += 1
            else:
                print_warning(f"{json_path} not found (optional)")
                warnings += 1
            continue

        try:
            FileUtils.read_json(full_path)
            print_ok(f"{json_path} is valid JSON")
        except Exception as e:
            print_error(f"{json_path} is invalid JSON: {e}")
            errors += 1

    # Check for hardcoded secrets in .mcp.json
    mcp_json = plugin_dir / ".mcp.json"
    if mcp_json.exists():
        content = FileUtils.read_text(mcp_json)
        if "tvly-" in content:
            print_error(".mcp.json contains hardcoded Tavily API key")
            errors += 1
        if re.search(r"ghp_[a-zA-Z0-9]{36}", content):
            print_error(".mcp.json contains hardcoded GitHub token")
            errors += 1

    print()
    print(f"Errors: {errors} | Warnings: {warnings}")
    return errors, warnings


def main():
    parser = argparse.ArgumentParser(
        description="Developer Kit Validation Script",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python scripts/validate.py              # Run all validations
  python scripts/validate.py --skills     # Validate skill descriptions
  python scripts/validate.py --agents     # Validate agent fields
  python scripts/validate.py --refs       # Validate references
  python scripts/validate.py --frontmatter # Validate frontmatter
  python scripts/validate.py --json       # Validate JSON configs
        """,
    )
    parser.add_argument(
        "--all", "-a", action="store_true", help="Run all validations (default)"
    )
    parser.add_argument(
        "--skills", "-s", action="store_true", help="Validate skill descriptions"
    )
    parser.add_argument(
        "--agents", "-g", action="store_true", help="Validate agent fields"
    )
    parser.add_argument("--refs", "-r", action="store_true", help="Validate references")
    parser.add_argument(
        "--frontmatter", "-f", action="store_true", help="Validate frontmatter"
    )
    parser.add_argument(
        "--json", "-j", action="store_true", help="Validate JSON configs"
    )
    parser.add_argument(
        "--no-color", action="store_true", help="Disable colored output"
    )
    args = parser.parse_args()

    # Disable colors if requested or not a TTY
    if args.no_color or not sys.stdout.isatty():
        Colors.disable()

    # Get plugin directory
    script_dir = Path(__file__).parent.resolve()
    plugin_dir = script_dir.parent

    # Determine which validations to run
    run_all = args.all or not any(
        [args.skills, args.agents, args.refs, args.frontmatter, args.json]
    )

    total_errors = 0
    total_warnings = 0

    if run_all or args.skills:
        e, w = validate_skill_descriptions(plugin_dir)
        total_errors += e
        total_warnings += w
        print()

    if run_all or args.agents:
        e, w = validate_agent_fields(plugin_dir)
        total_errors += e
        total_warnings += w
        print()

    if run_all or args.refs:
        e, w = validate_references(plugin_dir)
        total_errors += e
        total_warnings += w
        print()

    if run_all or args.frontmatter:
        e, w = validate_frontmatter(plugin_dir)
        total_errors += e
        total_warnings += w
        print()

    if run_all or args.json:
        e, w = validate_json_configs(plugin_dir)
        total_errors += e
        total_warnings += w
        print()

    # Summary
    print("=" * 50)
    print("  Validation Summary")
    print("=" * 50)
    print(f"  Total Errors:   {total_errors}")
    print(f"  Total Warnings: {total_warnings}")
    print()

    if total_errors > 0:
        print(f"{Colors.RED}FAILED: {total_errors} error(s) found{Colors.NC}")
        sys.exit(1)
    elif total_warnings > 0:
        print(f"{Colors.YELLOW}PASSED with {total_warnings} warning(s){Colors.NC}")
        sys.exit(0)
    else:
        print(f"{Colors.GREEN}PASSED: All validations successful{Colors.NC}")
        sys.exit(0)


if __name__ == "__main__":
    main()
