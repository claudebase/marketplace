#!/bin/bash
# validate.sh - Developer Kit Validation Script
#
# Unified validation script for all plugin components.
#
# Usage:
#     bash scripts/validate.sh              # Run all validations
#     bash scripts/validate.sh --skills     # Validate skill descriptions
#     bash scripts/validate.sh --agents     # Validate agent fields
#     bash scripts/validate.sh --refs       # Validate references
#     bash scripts/validate.sh --frontmatter # Validate frontmatter
#     bash scripts/validate.sh --json       # Validate JSON configs

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_DIR="$(dirname "$SCRIPT_DIR")"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Counters
TOTAL_ERRORS=0
TOTAL_WARNINGS=0

print_error() {
    echo -e "${RED}ERROR${NC}: $1"
}

print_warning() {
    echo -e "${YELLOW}WARNING${NC}: $1"
}

print_ok() {
    echo -e "${GREEN}OK${NC}: $1"
}

validate_skill_descriptions() {
    echo "=================================================="
    echo "Validating skill descriptions..."
    echo "=================================================="

    local errors=0
    local warnings=0
    local checked=0

    for skill_dir in "$PLUGIN_DIR/skills"/*/; do
        [[ ! -d "$skill_dir" ]] && continue

        skill_file="$skill_dir/SKILL.md"
        [[ ! -f "$skill_file" ]] && continue

        skill_name=$(basename "$skill_dir")
        ((checked++))

        content=$(cat "$skill_file")

        # Extract frontmatter
        frontmatter=$(echo "$content" | sed -n '/^---$/,/^---$/p' | sed '1d;$d')

        # Check for name field
        if ! echo "$frontmatter" | grep -q "^name:"; then
            print_error "$skill_name - Missing 'name' field"
            ((errors++))
        fi

        # Check for description field
        if ! echo "$frontmatter" | grep -q "^description:"; then
            print_error "$skill_name - Missing 'description' field"
            ((errors++))
            continue
        fi

        # Check for trigger phrases
        content_lower=$(echo "$content" | tr '[:upper:]' '[:lower:]')
        if ! echo "$content_lower" | grep -qE "activates for:|triggers on|use when"; then
            print_warning "$skill_name - Missing trigger phrases (Activates for/Triggers on/Use when)"
            ((warnings++))
        else
            print_ok "$skill_name"
        fi
    done

    echo ""
    echo "Checked $checked skills | Errors: $errors | Warnings: $warnings"

    TOTAL_ERRORS=$((TOTAL_ERRORS + errors))
    TOTAL_WARNINGS=$((TOTAL_WARNINGS + warnings))
}

validate_agent_fields() {
    echo "=================================================="
    echo "Validating agent fields..."
    echo "=================================================="

    local errors=0
    local warnings=0
    local checked=0
    local valid_models="sonnet opus haiku"

    for agent_file in "$PLUGIN_DIR/agents"/*.md; do
        [[ ! -f "$agent_file" ]] && continue

        agent_name=$(basename "$agent_file" .md)
        ((checked++))

        content=$(cat "$agent_file")
        frontmatter=$(echo "$content" | sed -n '/^---$/,/^---$/p' | sed '1d;$d')

        local agent_errors=0
        local agent_warnings=0

        # Check required fields
        for field in name description tools model; do
            if ! echo "$frontmatter" | grep -q "^$field:"; then
                print_error "$agent_name - Missing required field '$field'"
                ((agent_errors++))
            fi
        done

        # Validate model value
        model_value=$(echo "$frontmatter" | grep "^model:" | sed 's/^model:[[:space:]]*//' | tr -d ' ')
        if [[ -n "$model_value" ]]; then
            if ! echo "$valid_models" | grep -qw "$model_value"; then
                print_warning "$agent_name - Invalid model '$model_value' (expected: sonnet, opus, haiku)"
                ((agent_warnings++))
            fi
        fi

        if [[ $agent_errors -eq 0 ]] && [[ $agent_warnings -eq 0 ]]; then
            print_ok "$agent_name"
        fi

        errors=$((errors + agent_errors))
        warnings=$((warnings + agent_warnings))
    done

    echo ""
    echo "Checked $checked agents | Errors: $errors | Warnings: $warnings"

    TOTAL_ERRORS=$((TOTAL_ERRORS + errors))
    TOTAL_WARNINGS=$((TOTAL_WARNINGS + warnings))
}

validate_references() {
    echo "=================================================="
    echo "Validating skill references..."
    echo "=================================================="

    local errors=0
    local refs_checked=0
    local skills_checked=0

    for skill_dir in "$PLUGIN_DIR/skills"/*/; do
        [[ ! -d "$skill_dir" ]] && continue

        skill_file="$skill_dir/SKILL.md"
        [[ ! -f "$skill_file" ]] && continue

        skill_name=$(basename "$skill_dir")
        ((skills_checked++))

        # Remove code blocks before checking refs (to avoid false positives)
        content=$(cat "$skill_file" | sed '/```/,/```/d')

        # Find markdown links to .md files
        refs=$(echo "$content" | grep -oE '\]\([^)]+\.md\)' | sed 's/\](\(.*\))/\1/' || true)

        local skill_errors=0
        local valid_refs=0

        for ref in $refs; do
            # Skip external URLs
            [[ "$ref" == http* ]] && continue

            ((refs_checked++))

            # Resolve path relative to skill directory
            ref_path="$skill_dir/$ref"

            if [[ ! -f "$ref_path" ]]; then
                print_error "$skill_name - Missing reference file: $ref"
                ((skill_errors++))
            else
                ((valid_refs++))
            fi
        done

        if [[ $skill_errors -eq 0 ]] && [[ $valid_refs -gt 0 ]]; then
            print_ok "$skill_name ($valid_refs references)"
        fi

        errors=$((errors + skill_errors))
    done

    echo ""
    echo "Checked $skills_checked skills | References: $refs_checked | Errors: $errors"

    TOTAL_ERRORS=$((TOTAL_ERRORS + errors))
}

validate_frontmatter() {
    echo "=================================================="
    echo "Validating frontmatter..."
    echo "=================================================="

    local errors=0
    local warnings=0

    # Validate skills
    echo ""
    echo "Checking skills..."
    for skill_dir in "$PLUGIN_DIR/skills"/*/; do
        [[ ! -d "$skill_dir" ]] && continue

        skill_file="$skill_dir/SKILL.md"
        [[ ! -f "$skill_file" ]] && continue

        skill_name=$(basename "$skill_dir")
        content=$(cat "$skill_file")

        if ! echo "$content" | head -1 | grep -q "^---$"; then
            print_error "skills/$skill_name/SKILL.md - Missing frontmatter"
            ((errors++))
            continue
        fi

        if ! echo "$content" | grep -q "^name:"; then
            print_error "skills/$skill_name - Missing 'name' field"
            ((errors++))
        fi

        if ! echo "$content" | grep -q "^description:"; then
            print_error "skills/$skill_name - Missing 'description' field"
            ((errors++))
        fi

        # Check for deprecated fields
        frontmatter=$(echo "$content" | sed -n '/^---$/,/^---$/p' | sed '1d;$d')
        for deprecated in when_to_use version languages; do
            if echo "$frontmatter" | grep -q "^$deprecated:"; then
                print_warning "skills/$skill_name - Has deprecated '$deprecated' field"
                ((warnings++))
            fi
        done
    done

    # Validate agents
    echo ""
    echo "Checking agents..."
    for agent_file in "$PLUGIN_DIR/agents"/*.md; do
        [[ ! -f "$agent_file" ]] && continue

        agent_name=$(basename "$agent_file" .md)
        content=$(cat "$agent_file")

        if ! echo "$content" | head -1 | grep -q "^---$"; then
            print_error "agents/$agent_name.md - Missing frontmatter"
            ((errors++))
            continue
        fi

        for field in name description; do
            if ! echo "$content" | grep -q "^$field:"; then
                print_error "agents/$agent_name - Missing '$field' field"
                ((errors++))
            fi
        done

        for field in tools model; do
            if ! echo "$content" | grep -q "^$field:"; then
                print_warning "agents/$agent_name - Missing '$field' field"
                ((warnings++))
            fi
        done
    done

    # Validate commands
    echo ""
    echo "Checking commands..."
    while IFS= read -r -d '' cmd_file; do
        cmd_name=$(basename "$cmd_file" .md)
        content=$(cat "$cmd_file")

        if ! echo "$content" | head -1 | grep -q "^---$"; then
            print_error "commands/$cmd_name.md - Missing frontmatter"
            ((errors++))
            continue
        fi

        if ! echo "$content" | grep -q "^description:"; then
            print_error "commands/$cmd_name - Missing 'description' field"
            ((errors++))
        fi
    done < <(find "$PLUGIN_DIR/commands" -name "*.md" -print0)

    echo ""
    echo "Errors: $errors | Warnings: $warnings"

    TOTAL_ERRORS=$((TOTAL_ERRORS + errors))
    TOTAL_WARNINGS=$((TOTAL_WARNINGS + warnings))
}

validate_json_configs() {
    echo "=================================================="
    echo "Validating JSON configuration files..."
    echo "=================================================="

    local errors=0
    local warnings=0

    declare -a json_files=(
        ".mcp.json:true"
        ".lsp.json:true"
        "hooks/hooks.json:true"
        ".claude-plugin/plugin.json:true"
    )

    for entry in "${json_files[@]}"; do
        json_path="${entry%%:*}"
        required="${entry##*:}"
        full_path="$PLUGIN_DIR/$json_path"

        if [[ ! -f "$full_path" ]]; then
            if [[ "$required" == "true" ]]; then
                print_error "$json_path not found"
                ((errors++))
            else
                print_warning "$json_path not found (optional)"
                ((warnings++))
            fi
            continue
        fi

        if jq empty "$full_path" 2>/dev/null; then
            print_ok "$json_path is valid JSON"
        else
            print_error "$json_path is invalid JSON"
            ((errors++))
        fi
    done

    # Check for hardcoded secrets in .mcp.json
    mcp_json="$PLUGIN_DIR/.mcp.json"
    if [[ -f "$mcp_json" ]]; then
        content=$(cat "$mcp_json")
        if echo "$content" | grep -q "tvly-"; then
            print_error ".mcp.json contains hardcoded Tavily API key"
            ((errors++))
        fi
        if echo "$content" | grep -qE "ghp_[a-zA-Z0-9]{36}"; then
            print_error ".mcp.json contains hardcoded GitHub token"
            ((errors++))
        fi
    fi

    echo ""
    echo "Errors: $errors | Warnings: $warnings"

    TOTAL_ERRORS=$((TOTAL_ERRORS + errors))
    TOTAL_WARNINGS=$((TOTAL_WARNINGS + warnings))
}

# Parse arguments
RUN_ALL=false
RUN_SKILLS=false
RUN_AGENTS=false
RUN_REFS=false
RUN_FRONTMATTER=false
RUN_JSON=false

if [[ $# -eq 0 ]]; then
    RUN_ALL=true
else
    while [[ $# -gt 0 ]]; do
        case $1 in
            --all|-a) RUN_ALL=true ;;
            --skills|-s) RUN_SKILLS=true ;;
            --agents|-g) RUN_AGENTS=true ;;
            --refs|-r) RUN_REFS=true ;;
            --frontmatter|-f) RUN_FRONTMATTER=true ;;
            --json|-j) RUN_JSON=true ;;
            --no-color) RED=""; GREEN=""; YELLOW=""; NC="" ;;
            *) echo "Unknown option: $1"; exit 1 ;;
        esac
        shift
    done
fi

# Default to all if no specific option selected
if ! $RUN_SKILLS && ! $RUN_AGENTS && ! $RUN_REFS && ! $RUN_FRONTMATTER && ! $RUN_JSON; then
    RUN_ALL=true
fi

# Run validations
if $RUN_ALL || $RUN_SKILLS; then
    validate_skill_descriptions
    echo ""
fi

if $RUN_ALL || $RUN_AGENTS; then
    validate_agent_fields
    echo ""
fi

if $RUN_ALL || $RUN_REFS; then
    validate_references
    echo ""
fi

if $RUN_ALL || $RUN_FRONTMATTER; then
    validate_frontmatter
    echo ""
fi

if $RUN_ALL || $RUN_JSON; then
    validate_json_configs
    echo ""
fi

# Summary
echo "=================================================="
echo "  Validation Summary"
echo "=================================================="
echo "  Total Errors:   $TOTAL_ERRORS"
echo "  Total Warnings: $TOTAL_WARNINGS"
echo ""

if [[ $TOTAL_ERRORS -gt 0 ]]; then
    echo -e "${RED}FAILED: $TOTAL_ERRORS error(s) found${NC}"
    exit 1
elif [[ $TOTAL_WARNINGS -gt 0 ]]; then
    echo -e "${YELLOW}PASSED with $TOTAL_WARNINGS warning(s)${NC}"
    exit 0
else
    echo -e "${GREEN}PASSED: All validations successful${NC}"
    exit 0
fi
