#!/usr/bin/env python3
"""
Validate delegation compliance for all commands and agents.

Cross-platform compatible: works on Windows, macOS, and Linux.

Checks:
1. All commands with delegates-to have delegation directives
2. All delegation targets exist (skill or agent)
3. All agents with skills have composition sections
"""

import os
import re
import sys
from pathlib import Path


def get_plugin_root() -> Path:
    """Get the plugin root directory."""
    return Path(__file__).parent.parent


def get_all_skills() -> list:
    """Get list of all skill names."""
    skills_dir = get_plugin_root() / "skills"
    skills = []
    for d in skills_dir.iterdir():
        if d.is_dir() and (d / "SKILL.md").exists():
            skills.append(d.name)
    return skills


def get_all_agents() -> list:
    """Get list of all agent names from frontmatter."""
    agents_dir = get_plugin_root() / "agents"
    agents = []
    for f in agents_dir.glob("*.md"):
        try:
            content = f.read_text(encoding="utf-8")
            match = re.search(r"^name:\s*(\S+)", content, re.MULTILINE)
            if match:
                agents.append(match.group(1))
        except Exception as e:
            print(f"Warning: Could not read {f.name}: {e}")
    return agents


def validate_command(cmd_path: Path, skills: list, agents: list) -> list:
    """Validate a single command file."""
    errors = []

    try:
        content = cmd_path.read_text(encoding="utf-8")
    except Exception as e:
        errors.append(f"{cmd_path.name}: Could not read file - {e}")
        return errors

    # Check for delegates-to
    delegates_match = re.search(r"^delegates-to:\s*(\S+)", content, re.MULTILINE)
    if not delegates_match:
        return errors  # No delegation, nothing to check

    target = delegates_match.group(1)
    relative_path = cmd_path.relative_to(get_plugin_root())

    # Check delegation target exists
    if target not in skills and target not in agents:
        errors.append(
            f"{relative_path}: delegates-to '{target}' not found in skills or agents"
        )

    # Check for delegation directive (Phase 2 requirement)
    # This will fail until Phase 2 is implemented - that's expected
    has_directive = (
        "DELEGATION DIRECTIVE" in content or "⚡ DELEGATION DIRECTIVE ⚡" in content
    )

    if not has_directive:
        errors.append(
            f"{relative_path}: Missing delegation directive for '{target}' "
            f"(Phase 2 requirement)"
        )

    return errors


def validate_agent(agent_path: Path, skills: list) -> list:
    """Validate a single agent file."""
    errors = []

    try:
        content = agent_path.read_text(encoding="utf-8")
    except Exception as e:
        errors.append(f"{agent_path.name}: Could not read file - {e}")
        return errors

    # Check for skills field
    skills_match = re.search(r"^skills:\s*(.+)$", content, re.MULTILINE)
    if not skills_match:
        return errors  # No skills, nothing to check

    relative_path = agent_path.relative_to(get_plugin_root())
    skills_list = [s.strip() for s in skills_match.group(1).split(",")]

    # Check all referenced skills exist
    for skill in skills_list:
        if skill and skill not in skills:
            errors.append(f"{relative_path}: references unknown skill '{skill}'")

    # Check for skill composition section (Phase 3 requirement)
    has_composition = (
        "## Skill Composition" in content
        or "## Skills" in content
        or "### Skill Invocation" in content
    )

    if not has_composition:
        errors.append(
            f"{relative_path}: Missing skill composition section (Phase 3 requirement)"
        )

    return errors


def main() -> int:
    """Run validation checks."""
    plugin_root = get_plugin_root()
    commands_dir = plugin_root / "commands"
    agents_dir = plugin_root / "agents"

    if not commands_dir.exists():
        print(f"Error: Commands directory not found: {commands_dir}")
        return 1

    if not agents_dir.exists():
        print(f"Error: Agents directory not found: {agents_dir}")
        return 1

    skills = get_all_skills()
    agents = get_all_agents()

    print(f"Found {len(skills)} skills and {len(agents)} agents\n")

    all_errors = []
    phase2_errors = []
    phase3_errors = []
    critical_errors = []

    # Validate commands
    print("Validating command delegation...")
    cmd_count = 0
    for cmd_file in commands_dir.rglob("*.md"):
        cmd_count += 1
        errors = validate_command(cmd_file, skills, agents)
        for error in errors:
            if "Phase 2" in error:
                phase2_errors.append(error)
            else:
                critical_errors.append(error)
        all_errors.extend(errors)

    # Validate agents
    print("Validating agent skill composition...")
    agent_count = 0
    for agent_file in agents_dir.glob("*.md"):
        agent_count += 1
        errors = validate_agent(agent_file, skills)
        for error in errors:
            if "Phase 3" in error:
                phase3_errors.append(error)
            elif "unknown skill" in error:
                critical_errors.append(error)
            else:
                all_errors.append(error)

    # Report results
    print(f"\nValidation Summary:")
    print(f"  Commands scanned: {cmd_count}")
    print(f"  Agents scanned: {agent_count}")

    if critical_errors:
        print(f"\n{len(critical_errors)} CRITICAL errors (must fix):")
        for error in critical_errors:
            print(f"  - {error}")

    if phase2_errors:
        print(f"\n{len(phase2_errors)} Phase 2 pending (command directives):")
        for error in phase2_errors[:5]:  # Show first 5
            print(f"  - {error}")
        if len(phase2_errors) > 5:
            print(f"  ... and {len(phase2_errors) - 5} more")

    if phase3_errors:
        print(f"\n{len(phase3_errors)} Phase 3 pending (agent composition):")
        for error in phase3_errors[:5]:  # Show first 5
            print(f"  - {error}")
        if len(phase3_errors) > 5:
            print(f"  ... and {len(phase3_errors) - 5} more")

    if critical_errors:
        print(f"\n\u274c Validation FAILED: {len(critical_errors)} critical errors")
        return 1

    if phase2_errors or phase3_errors:
        print(
            f"\n\u26a0\ufe0f Phase 1 complete. Pending: Phase 2 ({len(phase2_errors)}), Phase 3 ({len(phase3_errors)})"
        )
        return 0  # Not a failure, just pending work

    print(f"\n\u2705 All delegation checks passed!")
    return 0


if __name__ == "__main__":
    sys.exit(main())
