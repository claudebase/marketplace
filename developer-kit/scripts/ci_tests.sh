#!/bin/bash
# ci_tests.sh - CI-specific tests for Developer Kit
#
# Usage:
#     bash scripts/ci_tests.sh --platform    # Test platform info
#     bash scripts/ci_tests.sh --counts      # Test component counts
#     bash scripts/ci_tests.sh --hooks       # Test hooks configuration
#     bash scripts/ci_tests.sh --all         # Run all tests (default)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_DIR="$(dirname "$SCRIPT_DIR")"

# Track results
declare -a TEST_NAMES=()
declare -a TEST_RESULTS=()

test_platform_info() {
    echo "=================================================="
    echo "Testing platform info..."
    echo "=================================================="

    echo "Platform: $(uname -s)"
    echo "Kernel: $(uname -r)"
    echo "Shell: $SHELL"
    echo "Bash version: ${BASH_VERSION:-unknown}"

    # Check for required tools
    local missing=""
    for tool in jq grep sed find; do
        if ! command -v "$tool" &>/dev/null; then
            missing="$missing $tool"
        fi
    done

    if [[ -n "$missing" ]]; then
        echo "ERROR: Missing required tools:$missing"
        return 1
    fi

    echo "Required tools: all present"
    echo "Platform info: OK"
    return 0
}

test_component_counts() {
    echo "=================================================="
    echo "Testing component counts..."
    echo "=================================================="

    local skills=$(find "$PLUGIN_DIR/skills" -name "SKILL.md" 2>/dev/null | wc -l | tr -d ' ')
    local agents=$(find "$PLUGIN_DIR/agents" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
    local commands=$(find "$PLUGIN_DIR/commands" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
    local refs=$(find "$PLUGIN_DIR" -path "*/references/*.md" 2>/dev/null | wc -l | tr -d ' ')

    echo "Skills: $skills"
    echo "Agents: $agents"
    echo "Commands: $commands"
    echo "Reference files: $refs"

    # Load plugin version
    local plugin_json="$PLUGIN_DIR/.claude-plugin/plugin.json"
    if [[ -f "$plugin_json" ]]; then
        local version=$(jq -r '.version' "$plugin_json")
        echo "Plugin version: $version"
    fi

    # Validate minimum counts
    local errors=0

    if [[ $skills -lt 20 ]]; then
        echo "ERROR: Expected at least 20 skills, got $skills"
        ((errors++))
    fi

    if [[ $agents -lt 10 ]]; then
        echo "ERROR: Expected at least 10 agents, got $agents"
        ((errors++))
    fi

    if [[ $commands -lt 15 ]]; then
        echo "ERROR: Expected at least 15 commands, got $commands"
        ((errors++))
    fi

    if [[ $errors -gt 0 ]]; then
        return 1
    fi

    echo "Component counts: OK"
    return 0
}

test_hooks_configuration() {
    echo "=================================================="
    echo "Testing hooks configuration..."
    echo "=================================================="

    local hooks_json="$PLUGIN_DIR/hooks/hooks.json"

    if [[ ! -f "$hooks_json" ]]; then
        echo "ERROR: hooks.json not found"
        return 1
    fi

    # Validate JSON
    if ! jq empty "$hooks_json" 2>/dev/null; then
        echo "ERROR: hooks.json is not valid JSON"
        return 1
    fi

    echo "hooks.json: valid JSON"

    # Check that all referenced scripts exist
    local scripts=$(jq -r '.. | .command? // empty' "$hooks_json" | grep -oE '[^"]+\.sh' || true)

    for script in $scripts; do
        script_name=$(basename "$script")
        script_path="$PLUGIN_DIR/hooks/$script_name"

        if [[ ! -f "$script_path" ]]; then
            echo "ERROR: Referenced script not found: $script_name"
            return 1
        fi

        if [[ ! -x "$script_path" ]]; then
            echo "WARNING: Script not executable: $script_name"
        fi

        echo "Hook script exists: $script_name"
    done

    echo "Hooks configuration: OK"
    return 0
}

# Parse arguments
RUN_ALL=false
RUN_PLATFORM=false
RUN_COUNTS=false
RUN_HOOKS=false

if [[ $# -eq 0 ]]; then
    RUN_ALL=true
else
    while [[ $# -gt 0 ]]; do
        case $1 in
            --all|-a) RUN_ALL=true ;;
            --platform) RUN_PLATFORM=true ;;
            --counts) RUN_COUNTS=true ;;
            --hooks) RUN_HOOKS=true ;;
            *) echo "Unknown option: $1"; exit 1 ;;
        esac
        shift
    done
fi

# Default to all if no specific option
if ! $RUN_PLATFORM && ! $RUN_COUNTS && ! $RUN_HOOKS; then
    RUN_ALL=true
fi

# Run tests
if $RUN_ALL || $RUN_PLATFORM; then
    if test_platform_info; then
        TEST_NAMES+=("Platform Info")
        TEST_RESULTS+=(0)
    else
        TEST_NAMES+=("Platform Info")
        TEST_RESULTS+=(1)
    fi
    echo ""
fi

if $RUN_ALL || $RUN_COUNTS; then
    if test_component_counts; then
        TEST_NAMES+=("Component Counts")
        TEST_RESULTS+=(0)
    else
        TEST_NAMES+=("Component Counts")
        TEST_RESULTS+=(1)
    fi
    echo ""
fi

if $RUN_ALL || $RUN_HOOKS; then
    if test_hooks_configuration; then
        TEST_NAMES+=("Hooks Configuration")
        TEST_RESULTS+=(0)
    else
        TEST_NAMES+=("Hooks Configuration")
        TEST_RESULTS+=(1)
    fi
    echo ""
fi

# Summary
echo "=================================================="
echo "  CI Test Summary"
echo "=================================================="

passed=0
failed=0

for i in "${!TEST_NAMES[@]}"; do
    name="${TEST_NAMES[$i]}"
    result="${TEST_RESULTS[$i]}"

    if [[ $result -eq 0 ]]; then
        echo "  PASS: $name"
        ((passed++))
    else
        echo "  FAIL: $name"
        ((failed++))
    fi
done

echo ""
echo "  Passed: $passed/${#TEST_NAMES[@]}"

if [[ $failed -gt 0 ]]; then
    echo ""
    echo "FAILED: $failed test(s) failed"
    exit 1
else
    echo ""
    echo "All CI tests passed!"
    exit 0
fi
