#!/bin/bash
# Developer Kit v3.5.0 Component Test Suite
# Comprehensive validation for all plugin components

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
TESTS_PASSED=0
TESTS_FAILED=0
TESTS_WARNED=0

# Test functions
pass() {
    echo -e "${GREEN}PASS${NC}: $1"
    TESTS_PASSED=$((TESTS_PASSED + 1))
}

fail() {
    echo -e "${RED}FAIL${NC}: $1"
    TESTS_FAILED=$((TESTS_FAILED + 1))
}

warn() {
    echo -e "${YELLOW}WARN${NC}: $1"
    TESTS_WARNED=$((TESTS_WARNED + 1))
}

info() {
    echo -e "${BLUE}INFO${NC}: $1"
}

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_DIR="$(dirname "$SCRIPT_DIR")"

cd "$PLUGIN_DIR"

echo "=============================================="
echo "  Developer Kit v3.5.0 Test Suite"
echo "=============================================="
echo ""
echo "Plugin directory: $PLUGIN_DIR"
echo ""

# ============================================
# Test Suite 1: Structure Validation
# ============================================
echo "--- Test Suite 1: Structure Validation ---"

# Test 1.1: Plugin manifest
if [ -f ".claude-plugin/plugin.json" ]; then
    if jq -e . .claude-plugin/plugin.json > /dev/null 2>&1; then
        VERSION=$(jq -r '.version' .claude-plugin/plugin.json)
        if [ "$VERSION" = "3.5.0" ]; then
            pass "plugin.json version is 3.5.0"
        else
            warn "plugin.json version is $VERSION (expected 3.5.0)"
        fi
    else
        fail "plugin.json is not valid JSON"
    fi
else
    fail "plugin.json not found"
fi

# Test 1.2: Required directories
for dir in skills agents commands hooks scripts templates; do
    if [ -d "$dir" ]; then
        pass "Directory exists: $dir/"
    else
        fail "Missing directory: $dir/"
    fi
done

# Test 1.3: Required config files
for file in .mcp.json .lsp.json hooks/hooks.json; do
    if [ -f "$file" ]; then
        pass "Config file exists: $file"
    else
        fail "Missing config file: $file"
    fi
done

# ============================================
# Test Suite 2: Skills Validation (22 expected)
# ============================================
echo ""
echo "--- Test Suite 2: Skills Validation ---"

SKILL_COUNT=0
EXPECTED_SKILLS=24

for skill_dir in skills/*/; do
    skill_name=$(basename "$skill_dir")
    skill_file="${skill_dir}SKILL.md"

    if [ -f "$skill_file" ]; then
        SKILL_COUNT=$((SKILL_COUNT + 1))

        # Check frontmatter
        if head -1 "$skill_file" | grep -q "^---$"; then
            # Check for name field
            if grep -q "^name:" "$skill_file"; then
                # Check for description
                if grep -q "^description:" "$skill_file"; then
                    # Check for allowed-tools (YAML list format)
                    if grep -q "^allowed-tools:" "$skill_file"; then
                        pass "Skill valid: $skill_name"
                    else
                        warn "Skill missing allowed-tools: $skill_name"
                    fi
                else
                    fail "Skill missing description: $skill_name"
                fi
            else
                fail "Skill missing name: $skill_name"
            fi
        else
            fail "Skill missing frontmatter: $skill_name"
        fi

        # Check for references directory
        if [ -d "${skill_dir}references" ]; then
            ref_count=$(find "${skill_dir}references" -name "*.md" | wc -l | tr -d ' ')
            info "  └── $ref_count reference file(s) in $skill_name"
        fi
    else
        fail "Missing SKILL.md in $skill_dir"
    fi
done

if [ "$SKILL_COUNT" -eq "$EXPECTED_SKILLS" ]; then
    pass "Skill count: $SKILL_COUNT (expected $EXPECTED_SKILLS)"
else
    fail "Skill count: $SKILL_COUNT (expected $EXPECTED_SKILLS)"
fi

# Test for nested skills (CRITICAL)
nested=$(find skills -mindepth 3 -name "SKILL.md" 2>/dev/null | wc -l | tr -d ' ')
if [ "$nested" -eq 0 ]; then
    pass "No nested skills found (flat structure maintained)"
else
    fail "Found $nested nested SKILL.md files (breaks discovery!)"
fi

# ============================================
# Test Suite 3: Agents Validation (14 expected)
# ============================================
echo ""
echo "--- Test Suite 3: Agents Validation ---"

AGENT_COUNT=0
EXPECTED_AGENTS=14

for agent_file in agents/*.md; do
    if [ -f "$agent_file" ]; then
        agent_name=$(basename "$agent_file" .md)
        AGENT_COUNT=$((AGENT_COUNT + 1))

        # Check frontmatter
        if head -1 "$agent_file" | grep -q "^---$"; then
            # Check for required fields
            if grep -q "^name:" "$agent_file" && \
               grep -q "^description:" "$agent_file" && \
               grep -q "^tools:" "$agent_file"; then
                pass "Agent valid: $agent_name"
            else
                warn "Agent missing required fields: $agent_name"
            fi
        else
            fail "Agent missing frontmatter: $agent_name"
        fi
    fi
done

if [ "$AGENT_COUNT" -eq "$EXPECTED_AGENTS" ]; then
    pass "Agent count: $AGENT_COUNT (expected $EXPECTED_AGENTS)"
else
    fail "Agent count: $AGENT_COUNT (expected $EXPECTED_AGENTS)"
fi

# Test for flat structure
nested_agents=$(find agents -mindepth 2 -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
if [ "$nested_agents" -eq 0 ]; then
    pass "Agents are flat (no subdirectories)"
else
    fail "Found $nested_agents agents in subdirectories"
fi

# ============================================
# Test Suite 4: Commands Validation (16 expected)
# ============================================
echo ""
echo "--- Test Suite 4: Commands Validation ---"

COMMAND_COUNT=0
EXPECTED_COMMANDS=21

for cmd_file in $(find commands -name "*.md" -type f); do
    cmd_name=$(basename "$cmd_file" .md)
    COMMAND_COUNT=$((COMMAND_COUNT + 1))

    # Check frontmatter
    if head -1 "$cmd_file" | grep -q "^---$"; then
        # Commands should NOT have name: field (name from filename)
        if grep -q "^name:" "$cmd_file"; then
            warn "Command has 'name:' field (should use filename): $cmd_name"
        fi

        # Check for description
        if grep -q "^description:" "$cmd_file"; then
            pass "Command valid: $cmd_name"
        else
            fail "Command missing description: $cmd_name"
        fi
    else
        fail "Command missing frontmatter: $cmd_name"
    fi
done

if [ "$COMMAND_COUNT" -eq "$EXPECTED_COMMANDS" ]; then
    pass "Command count: $COMMAND_COUNT (expected $EXPECTED_COMMANDS)"
else
    fail "Command count: $COMMAND_COUNT (expected $EXPECTED_COMMANDS)"
fi

# ============================================
# Test Suite 5: Templates Validation
# ============================================
echo ""
echo "--- Test Suite 5: Templates Validation ---"

TEMPLATE_COUNT=0

# GitHub Actions templates
for tpl in templates/ci-cd/github-actions/*.yml; do
    if [ -f "$tpl" ]; then
        TEMPLATE_COUNT=$((TEMPLATE_COUNT + 1))
        pass "Template exists: $(basename "$tpl")"
    fi
done

# Docker templates
for tpl in templates/docker/*; do
    if [ -f "$tpl" ]; then
        TEMPLATE_COUNT=$((TEMPLATE_COUNT + 1))
        pass "Template exists: docker/$(basename "$tpl")"
    fi
done

# Kubernetes templates
for tpl in templates/kubernetes/*.yaml; do
    if [ -f "$tpl" ]; then
        TEMPLATE_COUNT=$((TEMPLATE_COUNT + 1))
        pass "Template exists: kubernetes/$(basename "$tpl")"
    fi
done

# ADR templates
for tpl in templates/adr/*.md; do
    if [ -f "$tpl" ]; then
        TEMPLATE_COUNT=$((TEMPLATE_COUNT + 1))
        pass "Template exists: adr/$(basename "$tpl")"
    fi
done

info "Total templates: $TEMPLATE_COUNT"

# ============================================
# Test Suite 6: Configuration Validation
# ============================================
echo ""
echo "--- Test Suite 6: Configuration Validation ---"

# Test .mcp.json
if jq -e . .mcp.json > /dev/null 2>&1; then
    # Check for environment variable usage (no hardcoded secrets)
    if grep -q 'tvly-' .mcp.json; then
        fail ".mcp.json contains hardcoded API key"
    else
        pass ".mcp.json uses environment variables for secrets"
    fi
else
    fail ".mcp.json is not valid JSON"
fi

# Test .lsp.json
if jq -e . .lsp.json > /dev/null 2>&1; then
    # Check for required language servers
    for lang in typescript python json; do
        if jq -e ".$lang" .lsp.json > /dev/null 2>&1; then
            pass ".lsp.json has $lang configuration"
        else
            warn ".lsp.json missing $lang configuration"
        fi
    done
else
    fail ".lsp.json is not valid JSON"
fi

# Test hooks.json
if jq -e . hooks/hooks.json > /dev/null 2>&1; then
    # Check for hook types
    for hook_type in PostToolUse PreToolUse SessionStart; do
        if jq -e ".hooks.$hook_type" hooks/hooks.json > /dev/null 2>&1; then
            pass "hooks.json has $hook_type configuration"
        else
            warn "hooks.json missing $hook_type configuration"
        fi
    done
else
    fail "hooks/hooks.json is not valid JSON"
fi

# ============================================
# Test Suite 7: Reference Files Count
# ============================================
echo ""
echo "--- Test Suite 7: Reference Files ---"

TOTAL_REFS=$(find skills -path "*/references/*.md" -type f | wc -l | tr -d ' ')
info "Total reference files across all skills: $TOTAL_REFS"

if [ "$TOTAL_REFS" -ge 25 ]; then
    pass "Reference file count meets target (25+)"
else
    warn "Reference file count below target: $TOTAL_REFS (expected 25+)"
fi

# ============================================
# Test Suite 8: Script Executability
# ============================================
echo ""
echo "--- Test Suite 8: Script Validation ---"

for script in scripts/*.sh; do
    if [ -f "$script" ]; then
        if [ -x "$script" ]; then
            pass "Script is executable: $(basename "$script")"
        else
            warn "Script not executable: $(basename "$script")"
        fi
    fi
done

# ============================================
# Summary
# ============================================
echo ""
echo "=============================================="
echo "  Test Summary"
echo "=============================================="
echo -e "  ${GREEN}Passed${NC}:  $TESTS_PASSED"
echo -e "  ${RED}Failed${NC}:  $TESTS_FAILED"
echo -e "  ${YELLOW}Warned${NC}:  $TESTS_WARNED"
echo ""

if [ "$TESTS_FAILED" -eq 0 ]; then
    echo -e "${GREEN}=============================================="
    echo "  ALL TESTS PASSED"
    echo -e "==============================================${NC}"
    exit 0
else
    echo -e "${RED}=============================================="
    echo "  $TESTS_FAILED TEST(S) FAILED"
    echo -e "==============================================${NC}"
    exit 1
fi
