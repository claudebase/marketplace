#!/usr/bin/env python3
"""
Developer Kit Component Test Suite

Comprehensive validation for all plugin components.
Cross-platform compatible: works on Windows, macOS, and Linux.

Usage:
    python scripts/test_components.py
    python scripts/test_components.py --verbose
    python scripts/test_components.py --no-color
"""

import argparse
import io
import re
import sys
from pathlib import Path

# Fix Windows console encoding for Unicode characters
if sys.platform == "win32":
    # Force UTF-8 output on Windows
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
    sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding="utf-8", errors="replace")

# Add lib directory to path for cross-platform utilities
SCRIPT_DIR = Path(__file__).parent.resolve()
PLUGIN_DIR = SCRIPT_DIR.parent
sys.path.insert(0, str(PLUGIN_DIR / "lib"))

from platform_utils import FileUtils, PlatformInfo


class Colors:
    """ANSI color codes for terminal output."""

    RED = "\033[0;31m"
    GREEN = "\033[0;32m"
    YELLOW = "\033[1;33m"
    BLUE = "\033[0;34m"
    CYAN = "\033[0;36m"
    NC = "\033[0m"  # No Color

    @classmethod
    def disable(cls):
        """Disable colors for non-TTY output or when requested."""
        cls.RED = ""
        cls.GREEN = ""
        cls.YELLOW = ""
        cls.BLUE = ""
        cls.CYAN = ""
        cls.NC = ""


class TestRunner:
    """Test runner for Developer Kit components."""

    # Expected counts
    EXPECTED_SKILLS = 24
    EXPECTED_AGENTS = 14
    EXPECTED_COMMANDS = 21
    EXPECTED_VERSION = "4.0.0"

    def __init__(self, plugin_dir: Path, verbose: bool = False):
        self.plugin_dir = plugin_dir
        self.verbose = verbose
        self.tests_passed = 0
        self.tests_failed = 0
        self.tests_warned = 0

    def pass_test(self, message: str):
        """Record a passed test."""
        print(f"{Colors.GREEN}PASS{Colors.NC}: {message}")
        self.tests_passed += 1

    def fail_test(self, message: str):
        """Record a failed test."""
        print(f"{Colors.RED}FAIL{Colors.NC}: {message}")
        self.tests_failed += 1

    def warn_test(self, message: str):
        """Record a warning."""
        print(f"{Colors.YELLOW}WARN{Colors.NC}: {message}")
        self.tests_warned += 1

    def info(self, message: str):
        """Print informational message."""
        print(f"{Colors.BLUE}INFO{Colors.NC}: {message}")

    def debug(self, message: str):
        """Print debug message (only in verbose mode)."""
        if self.verbose:
            print(f"{Colors.CYAN}DEBUG{Colors.NC}: {message}")

    def test_structure(self):
        """Test Suite 1: Structure Validation."""
        print("--- Test Suite 1: Structure Validation ---")

        # Test 1.1: Plugin manifest
        plugin_json = self.plugin_dir / ".claude-plugin" / "plugin.json"
        if plugin_json.exists():
            try:
                data = FileUtils.read_json(plugin_json)
                version = data.get("version", "")
                if version == self.EXPECTED_VERSION:
                    self.pass_test(f"plugin.json version is {self.EXPECTED_VERSION}")
                else:
                    self.warn_test(
                        f"plugin.json version is {version} (expected {self.EXPECTED_VERSION})"
                    )
            except Exception as e:
                self.fail_test(f"plugin.json is not valid JSON: {e}")
        else:
            self.fail_test("plugin.json not found")

        # Test 1.2: Required directories
        for dir_name in [
            "skills",
            "agents",
            "commands",
            "hooks",
            "scripts",
            "templates",
            "lib",
        ]:
            dir_path = self.plugin_dir / dir_name
            if dir_path.is_dir():
                self.pass_test(f"Directory exists: {dir_name}/")
            else:
                if dir_name == "lib":
                    self.warn_test(f"Optional directory missing: {dir_name}/")
                else:
                    self.fail_test(f"Missing directory: {dir_name}/")

        # Test 1.3: Required config files
        for file_path in [".mcp.json", ".lsp.json", "hooks/hooks.json"]:
            full_path = self.plugin_dir / file_path
            if full_path.exists():
                self.pass_test(f"Config file exists: {file_path}")
            else:
                self.fail_test(f"Missing config file: {file_path}")

    def test_skills(self):
        """Test Suite 2: Skills Validation."""
        print("\n--- Test Suite 2: Skills Validation ---")

        skills_dir = self.plugin_dir / "skills"
        skill_count = 0

        for skill_dir in sorted(skills_dir.iterdir()):
            if not skill_dir.is_dir():
                continue

            skill_file = skill_dir / "SKILL.md"
            skill_name = skill_dir.name

            if skill_file.exists():
                skill_count += 1
                content = FileUtils.read_text(skill_file)

                # Check frontmatter
                if content.startswith("---"):
                    has_name = bool(re.search(r"^name:", content, re.MULTILINE))
                    has_desc = bool(re.search(r"^description:", content, re.MULTILINE))
                    has_tools = bool(
                        re.search(r"^allowed-tools:", content, re.MULTILINE)
                    )

                    if has_name and has_desc and has_tools:
                        self.pass_test(f"Skill valid: {skill_name}")
                    elif has_name and has_desc:
                        self.warn_test(f"Skill missing allowed-tools: {skill_name}")
                    elif not has_desc:
                        self.fail_test(f"Skill missing description: {skill_name}")
                    else:
                        self.fail_test(f"Skill missing name: {skill_name}")
                else:
                    self.fail_test(f"Skill missing frontmatter: {skill_name}")

                # Check for references directory
                refs_dir = skill_dir / "references"
                if refs_dir.is_dir():
                    ref_count = len(list(refs_dir.glob("*.md")))
                    self.debug(f"  +-- {ref_count} reference file(s) in {skill_name}")
            else:
                self.fail_test(f"Missing SKILL.md in {skill_dir.name}/")

        if skill_count == self.EXPECTED_SKILLS:
            self.pass_test(
                f"Skill count: {skill_count} (expected {self.EXPECTED_SKILLS})"
            )
        else:
            self.fail_test(
                f"Skill count: {skill_count} (expected {self.EXPECTED_SKILLS})"
            )

        # Test for nested skills (CRITICAL)
        nested = list(skills_dir.rglob("*/*/SKILL.md"))
        if len(nested) == 0:
            self.pass_test("No nested skills found (flat structure maintained)")
        else:
            self.fail_test(
                f"Found {len(nested)} nested SKILL.md files (breaks discovery!)"
            )

    def test_agents(self):
        """Test Suite 3: Agents Validation."""
        print("\n--- Test Suite 3: Agents Validation ---")

        agents_dir = self.plugin_dir / "agents"
        agent_count = 0

        for agent_file in sorted(agents_dir.glob("*.md")):
            agent_name = agent_file.stem
            agent_count += 1

            content = FileUtils.read_text(agent_file)

            if content.startswith("---"):
                has_name = bool(re.search(r"^name:", content, re.MULTILINE))
                has_desc = bool(re.search(r"^description:", content, re.MULTILINE))
                has_tools = bool(re.search(r"^tools:", content, re.MULTILINE))
                has_model = bool(re.search(r"^model:", content, re.MULTILINE))

                if has_name and has_desc and has_tools and has_model:
                    self.pass_test(f"Agent valid: {agent_name}")
                elif has_name and has_desc and has_tools:
                    self.warn_test(f"Agent missing model: {agent_name}")
                else:
                    missing = []
                    if not has_name:
                        missing.append("name")
                    if not has_desc:
                        missing.append("description")
                    if not has_tools:
                        missing.append("tools")
                    self.fail_test(f"Agent missing {', '.join(missing)}: {agent_name}")
            else:
                self.fail_test(f"Agent missing frontmatter: {agent_name}")

        if agent_count == self.EXPECTED_AGENTS:
            self.pass_test(
                f"Agent count: {agent_count} (expected {self.EXPECTED_AGENTS})"
            )
        else:
            self.fail_test(
                f"Agent count: {agent_count} (expected {self.EXPECTED_AGENTS})"
            )

        # Test for flat structure
        nested = list(agents_dir.rglob("*/*.md"))
        if len(nested) == 0:
            self.pass_test("Agents are flat (no subdirectories)")
        else:
            self.fail_test(f"Found {len(nested)} agents in subdirectories")

    def test_commands(self):
        """Test Suite 4: Commands Validation."""
        print("\n--- Test Suite 4: Commands Validation ---")

        commands_dir = self.plugin_dir / "commands"
        command_count = 0

        for cmd_file in sorted(commands_dir.rglob("*.md")):
            cmd_name = cmd_file.stem
            command_count += 1

            content = FileUtils.read_text(cmd_file)

            if content.startswith("---"):
                # Commands should NOT have name field (name from filename)
                if re.search(r"^name:", content, re.MULTILINE):
                    self.warn_test(
                        f"Command has 'name:' field (should use filename): {cmd_name}"
                    )

                if re.search(r"^description:", content, re.MULTILINE):
                    self.pass_test(f"Command valid: {cmd_name}")
                else:
                    self.fail_test(f"Command missing description: {cmd_name}")
            else:
                self.fail_test(f"Command missing frontmatter: {cmd_name}")

        if command_count == self.EXPECTED_COMMANDS:
            self.pass_test(
                f"Command count: {command_count} (expected {self.EXPECTED_COMMANDS})"
            )
        else:
            self.fail_test(
                f"Command count: {command_count} (expected {self.EXPECTED_COMMANDS})"
            )

    def test_templates(self):
        """Test Suite 5: Templates Validation."""
        print("\n--- Test Suite 5: Templates Validation ---")

        templates_dir = self.plugin_dir / "templates"
        template_count = 0

        # GitHub Actions templates
        gh_actions_dir = templates_dir / "ci-cd" / "github-actions"
        if gh_actions_dir.exists():
            for tpl in gh_actions_dir.glob("*.yml"):
                template_count += 1
                self.pass_test(f"Template exists: ci-cd/github-actions/{tpl.name}")

        # Docker templates
        docker_dir = templates_dir / "docker"
        if docker_dir.exists():
            for tpl in docker_dir.iterdir():
                if tpl.is_file():
                    template_count += 1
                    self.pass_test(f"Template exists: docker/{tpl.name}")

        # Kubernetes templates
        k8s_dir = templates_dir / "kubernetes"
        if k8s_dir.exists():
            for tpl in k8s_dir.glob("*.yaml"):
                template_count += 1
                self.pass_test(f"Template exists: kubernetes/{tpl.name}")

        # ADR templates
        adr_dir = templates_dir / "adr"
        if adr_dir.exists():
            for tpl in adr_dir.glob("*.md"):
                template_count += 1
                self.pass_test(f"Template exists: adr/{tpl.name}")

        self.info(f"Total templates: {template_count}")

    def test_configuration(self):
        """Test Suite 6: Configuration Validation."""
        print("\n--- Test Suite 6: Configuration Validation ---")

        # Test .mcp.json
        mcp_json = self.plugin_dir / ".mcp.json"
        if mcp_json.exists():
            try:
                content = FileUtils.read_text(mcp_json)
                # Check for hardcoded API keys
                if "tvly-" in content:
                    self.fail_test(".mcp.json contains hardcoded Tavily API key")
                elif re.search(r"ghp_[a-zA-Z0-9]{36}", content):
                    self.fail_test(".mcp.json contains hardcoded GitHub token")
                else:
                    self.pass_test(".mcp.json uses environment variables for secrets")

                # Validate JSON
                FileUtils.read_json(mcp_json)
                self.pass_test(".mcp.json is valid JSON")
            except Exception as e:
                self.fail_test(f".mcp.json error: {e}")

        # Test .lsp.json
        lsp_json = self.plugin_dir / ".lsp.json"
        if lsp_json.exists():
            try:
                data = FileUtils.read_json(lsp_json)
                for lang in ["typescript", "python", "json"]:
                    if lang in data:
                        self.pass_test(f".lsp.json has {lang} configuration")
                    else:
                        self.warn_test(f".lsp.json missing {lang} configuration")
            except Exception as e:
                self.fail_test(f".lsp.json error: {e}")

        # Test hooks.json
        hooks_json = self.plugin_dir / "hooks" / "hooks.json"
        if hooks_json.exists():
            try:
                data = FileUtils.read_json(hooks_json)
                hooks = data.get("hooks", {})
                for hook_type in ["PostToolUse", "PreToolUse", "SessionStart"]:
                    if hook_type in hooks:
                        self.pass_test(f"hooks.json has {hook_type} configuration")
                    else:
                        self.warn_test(f"hooks.json missing {hook_type} configuration")
            except Exception as e:
                self.fail_test(f"hooks.json error: {e}")

    def test_references(self):
        """Test Suite 7: Reference Files."""
        print("\n--- Test Suite 7: Reference Files ---")

        skills_dir = self.plugin_dir / "skills"
        total_refs = len(list(skills_dir.rglob("references/*.md")))

        self.info(f"Total reference files across all skills: {total_refs}")

        if total_refs >= 25:
            self.pass_test("Reference file count meets target (25+)")
        else:
            self.warn_test(
                f"Reference file count below target: {total_refs} (expected 25+)"
            )

    def test_hooks(self):
        """Test Suite 8: Hook Scripts Validation."""
        print("\n--- Test Suite 8: Hook Scripts Validation ---")

        hooks_dir = self.plugin_dir / "hooks"
        expected_hooks = [
            "platform_instructions_hook.py",
            "validate_bash_command.py",
            "format_file_hook.py",
            "restore_session_context.py",
            "save_session_state.py",
            "security_reminder_hook.py",
            "validate_env_vars.py",
        ]

        for hook_name in expected_hooks:
            hook_file = hooks_dir / hook_name
            if hook_file.exists():
                self.pass_test(f"Hook script exists: {hook_name}")
            else:
                self.fail_test(f"Missing hook script: {hook_name}")

    def test_cross_platform(self):
        """Test Suite 9: Cross-Platform Compatibility."""
        print("\n--- Test Suite 9: Cross-Platform Compatibility ---")

        # Check that lib/platform_utils.py exists
        platform_utils = self.plugin_dir / "lib" / "platform_utils.py"
        if platform_utils.exists():
            self.pass_test("lib/platform_utils.py exists")
        else:
            self.fail_test(
                "lib/platform_utils.py missing (required for cross-platform)"
            )

        # Check hooks.json uses Python commands
        hooks_json = self.plugin_dir / "hooks" / "hooks.json"
        if hooks_json.exists():
            content = FileUtils.read_text(hooks_json)
            if ".sh" in content:
                self.fail_test(
                    "hooks.json still references .sh scripts (not cross-platform)"
                )
            elif "python" in content.lower():
                self.pass_test("hooks.json uses Python commands")
            else:
                self.warn_test("hooks.json command type unclear")

        # Report current platform
        self.info(f"Current platform: {PlatformInfo.get_platform()}")
        self.info(f"Python command: {PlatformInfo.get_python_command()}")

    def run_all(self) -> int:
        """Run all test suites."""
        print("=" * 50)
        print(f"  Developer Kit v{self.EXPECTED_VERSION} Test Suite")
        print("=" * 50)
        print(f"\nPlugin directory: {self.plugin_dir}")
        print(f"Platform: {PlatformInfo.get_platform()}")
        print()

        self.test_structure()
        self.test_skills()
        self.test_agents()
        self.test_commands()
        self.test_templates()
        self.test_configuration()
        self.test_references()
        self.test_hooks()
        self.test_cross_platform()

        # Summary
        print("\n" + "=" * 50)
        print("  Test Summary")
        print("=" * 50)
        print(f"  {Colors.GREEN}Passed{Colors.NC}:  {self.tests_passed}")
        print(f"  {Colors.RED}Failed{Colors.NC}:  {self.tests_failed}")
        print(f"  {Colors.YELLOW}Warned{Colors.NC}:  {self.tests_warned}")
        print()

        total = self.tests_passed + self.tests_failed + self.tests_warned
        print(f"  Total tests: {total}")
        print()

        if self.tests_failed == 0:
            print(f"{Colors.GREEN}{'=' * 50}")
            print("  ALL TESTS PASSED")
            print(f"{'=' * 50}{Colors.NC}")
            return 0
        else:
            print(f"{Colors.RED}{'=' * 50}")
            print(f"  {self.tests_failed} TEST(S) FAILED")
            print(f"{'=' * 50}{Colors.NC}")
            return 1


def main():
    parser = argparse.ArgumentParser(
        description="Developer Kit Component Test Suite",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python scripts/test_components.py
  python scripts/test_components.py --verbose
  python scripts/test_components.py --no-color
        """,
    )
    parser.add_argument(
        "--verbose", "-v", action="store_true", help="Enable verbose output"
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

    runner = TestRunner(plugin_dir, verbose=args.verbose)
    sys.exit(runner.run_all())


if __name__ == "__main__":
    main()
