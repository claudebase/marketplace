#!/bin/bash
# test_components.sh - Developer Kit Component Test Suite
#
# Comprehensive validation for all plugin components.
#
# Usage:
#     bash scripts/test_components.sh
#     bash scripts/test_components.sh --verbose
#     bash scripts/test_components.sh --no-color

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_DIR="$(dirname "$SCRIPT_DIR")"

# Expected counts
EXPECTED_SKILLS=24
EXPECTED_AGENTS=14
EXPECTED_COMMANDS=21
EXPECTED_VERSION="7.0.0"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Counters
TESTS_PASSED=0
TESTS_FAILED=0
TESTS_WARNED=0

VERBOSE=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --verbose|-v) VERBOSE=true ;;
        --no-color) RED=""; GREEN=""; YELLOW=""; BLUE=""; CYAN=""; NC="" ;;
        *) echo "Unknown option: $1"; exit 1 ;;
    esac
    shift
done

pass_test() {
    echo -e "${GREEN}PASS${NC}: $1"
    ((++TESTS_PASSED)) || true
}

fail_test() {
    echo -e "${RED}FAIL${NC}: $1"
    ((++TESTS_FAILED)) || true
}

warn_test() {
    echo -e "${YELLOW}WARN${NC}: $1"
    ((++TESTS_WARNED)) || true
}

info() {
    echo -e "${BLUE}INFO${NC}: $1"
}

debug() {
    if $VERBOSE; then
        echo -e "${CYAN}DEBUG${NC}: $1"
    fi
}

# Test Suite 1: Structure Validation
test_structure() {
    echo "--- Test Suite 1: Structure Validation ---"

    # Test 1.1: Plugin manifest
    local plugin_json="$PLUGIN_DIR/.claude-plugin/plugin.json"
    if [[ -f "$plugin_json" ]]; then
        if jq empty "$plugin_json" 2>/dev/null; then
            local version=$(jq -r '.version' "$plugin_json")
            if [[ "$version" == "$EXPECTED_VERSION" ]]; then
                pass_test "plugin.json version is $EXPECTED_VERSION"
            else
                warn_test "plugin.json version is $version (expected $EXPECTED_VERSION)"
            fi
        else
            fail_test "plugin.json is not valid JSON"
        fi
    else
        fail_test "plugin.json not found"
    fi

    # Test 1.2: Required directories
    for dir_name in skills agents commands hooks scripts templates; do
        local dir_path="$PLUGIN_DIR/$dir_name"
        if [[ -d "$dir_path" ]]; then
            pass_test "Directory exists: $dir_name/"
        else
            fail_test "Missing directory: $dir_name/"
        fi
    done

    # Test 1.3: Required config files
    for file_path in .mcp.json .lsp.json hooks/hooks.json; do
        local full_path="$PLUGIN_DIR/$file_path"
        if [[ -f "$full_path" ]]; then
            pass_test "Config file exists: $file_path"
        else
            fail_test "Missing config file: $file_path"
        fi
    done
}

# Test Suite 2: Skills Validation
test_skills() {
    echo ""
    echo "--- Test Suite 2: Skills Validation ---"

    local skill_count=0

    for skill_dir in "$PLUGIN_DIR/skills"/*/; do
        [[ ! -d "$skill_dir" ]] && continue

        local skill_file="$skill_dir/SKILL.md"
        local skill_name=$(basename "$skill_dir")

        if [[ -f "$skill_file" ]]; then
            ((++skill_count)) || true
            local content=$(cat "$skill_file")

            # Check frontmatter
            if echo "$content" | head -1 | grep -q "^---$"; then
                local has_name=$(echo "$content" | grep -c "^name:" || echo "0")
                local has_desc=$(echo "$content" | grep -c "^description:" || echo "0")
                local has_tools=$(echo "$content" | grep -c "^allowed-tools:" || echo "0")

                if [[ $has_name -gt 0 ]] && [[ $has_desc -gt 0 ]] && [[ $has_tools -gt 0 ]]; then
                    pass_test "Skill valid: $skill_name"
                elif [[ $has_name -gt 0 ]] && [[ $has_desc -gt 0 ]]; then
                    warn_test "Skill missing allowed-tools: $skill_name"
                elif [[ $has_desc -eq 0 ]]; then
                    fail_test "Skill missing description: $skill_name"
                else
                    fail_test "Skill missing name: $skill_name"
                fi
            else
                fail_test "Skill missing frontmatter: $skill_name"
            fi

            # Check for references directory
            local refs_dir="$skill_dir/references"
            if [[ -d "$refs_dir" ]]; then
                local ref_count=$(find "$refs_dir" -name "*.md" | wc -l | tr -d ' ')
                debug "  +-- $ref_count reference file(s) in $skill_name"
            fi
        else
            fail_test "Missing SKILL.md in $(basename "$skill_dir")/"
        fi
    done

    if [[ $skill_count -eq $EXPECTED_SKILLS ]]; then
        pass_test "Skill count: $skill_count (expected $EXPECTED_SKILLS)"
    else
        fail_test "Skill count: $skill_count (expected $EXPECTED_SKILLS)"
    fi

    # Test for nested skills
    local nested=$(find "$PLUGIN_DIR/skills" -mindepth 3 -name "SKILL.md" 2>/dev/null | wc -l | tr -d ' ')
    if [[ $nested -eq 0 ]]; then
        pass_test "No nested skills found (flat structure maintained)"
    else
        fail_test "Found $nested nested skills (should be flat)"
    fi
}

# Test Suite 3: Agents Validation
test_agents() {
    echo ""
    echo "--- Test Suite 3: Agents Validation ---"

    local agent_count=0
    local valid_models="sonnet opus haiku"

    for agent_file in "$PLUGIN_DIR/agents"/*.md; do
        [[ ! -f "$agent_file" ]] && continue
        ((++agent_count)) || true

        local agent_name=$(basename "$agent_file" .md)
        local content=$(cat "$agent_file")

        # Check frontmatter
        if echo "$content" | head -1 | grep -q "^---$"; then
            local has_name=$(echo "$content" | grep -c "^name:" || echo "0")
            local has_desc=$(echo "$content" | grep -c "^description:" || echo "0")
            local has_tools=$(echo "$content" | grep -c "^tools:" || echo "0")
            local has_model=$(echo "$content" | grep -c "^model:" || echo "0")

            if [[ $has_name -gt 0 ]] && [[ $has_desc -gt 0 ]] && [[ $has_tools -gt 0 ]] && [[ $has_model -gt 0 ]]; then
                pass_test "Agent valid: $agent_name"
            else
                local missing=""
                [[ $has_name -eq 0 ]] && missing="$missing name"
                [[ $has_desc -eq 0 ]] && missing="$missing description"
                [[ $has_tools -eq 0 ]] && missing="$missing tools"
                [[ $has_model -eq 0 ]] && missing="$missing model"
                fail_test "Agent $agent_name missing:$missing"
            fi
        else
            fail_test "Agent missing frontmatter: $agent_name"
        fi
    done

    if [[ $agent_count -eq $EXPECTED_AGENTS ]]; then
        pass_test "Agent count: $agent_count (expected $EXPECTED_AGENTS)"
    else
        fail_test "Agent count: $agent_count (expected $EXPECTED_AGENTS)"
    fi
}

# Test Suite 4: Commands Validation
test_commands() {
    echo ""
    echo "--- Test Suite 4: Commands Validation ---"

    local cmd_count=0

    while IFS= read -r -d '' cmd_file; do
        ((++cmd_count)) || true
        local cmd_name=$(basename "$cmd_file" .md)
        local content=$(cat "$cmd_file")

        if echo "$content" | head -1 | grep -q "^---$"; then
            if echo "$content" | grep -q "^description:"; then
                pass_test "Command valid: $cmd_name"
            else
                fail_test "Command missing description: $cmd_name"
            fi
        else
            fail_test "Command missing frontmatter: $cmd_name"
        fi
    done < <(find "$PLUGIN_DIR/commands" -name "*.md" -print0)

    if [[ $cmd_count -eq $EXPECTED_COMMANDS ]]; then
        pass_test "Command count: $cmd_count (expected $EXPECTED_COMMANDS)"
    else
        fail_test "Command count: $cmd_count (expected $EXPECTED_COMMANDS)"
    fi
}

# Test Suite 5: Hooks Validation
test_hooks() {
    echo ""
    echo "--- Test Suite 5: Hooks Validation ---"

    local hooks_json="$PLUGIN_DIR/hooks/hooks.json"

    if [[ -f "$hooks_json" ]]; then
        if jq empty "$hooks_json" 2>/dev/null; then
            pass_test "hooks.json is valid JSON"
        else
            fail_test "hooks.json is not valid JSON"
        fi
    else
        fail_test "hooks.json not found"
    fi

    # Check all .sh hook files are executable
    for hook_script in "$PLUGIN_DIR/hooks"/*.sh; do
        [[ ! -f "$hook_script" ]] && continue
        local script_name=$(basename "$hook_script")

        if [[ -x "$hook_script" ]]; then
            pass_test "Hook executable: $script_name"
        else
            warn_test "Hook not executable: $script_name"
        fi
    done
}

# Test Suite 6: JSON Configs
test_json_configs() {
    echo ""
    echo "--- Test Suite 6: JSON Configs ---"

    for json_file in .mcp.json .lsp.json .claude-plugin/plugin.json; do
        local full_path="$PLUGIN_DIR/$json_file"
        if [[ -f "$full_path" ]]; then
            if jq empty "$full_path" 2>/dev/null; then
                pass_test "$json_file is valid JSON"
            else
                fail_test "$json_file is not valid JSON"
            fi
        fi
    done
}

# Run all test suites
echo "Developer Kit Component Test Suite"
echo "==================================="
echo ""

test_structure
test_skills
test_agents
test_commands
test_hooks
test_json_configs

# Summary
echo ""
echo "==================================="
echo "  Test Summary"
echo "==================================="
echo "  Passed:   $TESTS_PASSED"
echo "  Failed:   $TESTS_FAILED"
echo "  Warnings: $TESTS_WARNED"
echo ""

TOTAL=$((TESTS_PASSED + TESTS_FAILED))

if [[ $TESTS_FAILED -gt 0 ]]; then
    echo -e "${RED}FAILED: $TESTS_FAILED of $TOTAL tests failed${NC}"
    exit 1
elif [[ $TESTS_WARNED -gt 0 ]]; then
    echo -e "${YELLOW}PASSED with $TESTS_WARNED warning(s)${NC}"
    exit 0
else
    echo -e "${GREEN}PASSED: All $TOTAL tests passed${NC}"
    exit 0
fi
