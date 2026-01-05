#!/bin/bash
# validate_delegation.sh - Validate delegation compliance for commands and agents
#
# Checks:
# 1. All commands with delegates-to have delegation directives
# 2. All delegation targets exist (skill or agent)
# 3. All agents with skills have composition sections

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_DIR="$(dirname "$SCRIPT_DIR")"

# Get all skills
get_all_skills() {
    for skill_dir in "$PLUGIN_DIR/skills"/*/; do
        if [[ -d "$skill_dir" ]] && [[ -f "$skill_dir/SKILL.md" ]]; then
            basename "$skill_dir"
        fi
    done
}

# Get all agent names from frontmatter (only from YAML header, not body)
get_all_agents() {
    for agent_file in "$PLUGIN_DIR/agents"/*.md; do
        [[ ! -f "$agent_file" ]] && continue
        # Extract only the frontmatter section (between first two ---) and get name
        sed -n '1,/^---$/p' "$agent_file" | grep "^name:" 2>/dev/null | head -1 | sed 's/^name:[[:space:]]*//' | tr -d ' '
    done
}

# Collect skills and agents
SKILLS=$(get_all_skills | tr '\n' ' ')
AGENTS=$(get_all_agents | tr '\n' ' ')

SKILL_COUNT=$(echo "$SKILLS" | wc -w | tr -d ' ')
AGENT_COUNT=$(echo "$AGENTS" | wc -w | tr -d ' ')

echo "Found $SKILL_COUNT skills and $AGENT_COUNT agents"
echo ""

# Counters
CRITICAL_ERRORS=()
PHASE2_ERRORS=()
PHASE3_ERRORS=()
CMD_COUNT=0
AGENT_FILE_COUNT=0

# Validate commands
echo "Validating command delegation..."
while IFS= read -r -d '' cmd_file; do
    ((CMD_COUNT++)) || true

    content=$(cat "$cmd_file")
    relative_path="${cmd_file#$PLUGIN_DIR/}"

    # Check for delegates-to
    delegates_to=$(echo "$content" | grep "^delegates-to:" | sed 's/^delegates-to:[[:space:]]*//' | tr -d ' ')

    if [[ -z "$delegates_to" ]]; then
        continue  # No delegation, nothing to check
    fi

    # Check if target exists in skills or agents
    target_found=false
    for skill in $SKILLS; do
        if [[ "$skill" == "$delegates_to" ]]; then
            target_found=true
            break
        fi
    done

    if ! $target_found; then
        for agent in $AGENTS; do
            if [[ "$agent" == "$delegates_to" ]]; then
                target_found=true
                break
            fi
        done
    fi

    if ! $target_found; then
        CRITICAL_ERRORS+=("$relative_path: delegates-to '$delegates_to' not found in skills or agents")
    fi

    # Check for delegation directive
    if ! echo "$content" | grep -qE "DELEGATION DIRECTIVE"; then
        PHASE2_ERRORS+=("$relative_path: Missing delegation directive for '$delegates_to' (Phase 2 requirement)")
    fi
done < <(find "$PLUGIN_DIR/commands" -name "*.md" -print0)

# Validate agents
echo "Validating agent skill composition..."
for agent_file in "$PLUGIN_DIR/agents"/*.md; do
    [[ ! -f "$agent_file" ]] && continue
    ((AGENT_FILE_COUNT++)) || true

    content=$(cat "$agent_file")
    relative_path="${agent_file#$PLUGIN_DIR/}"

    # Check for skills field
    skills_line=$(echo "$content" | grep "^skills:" || true)

    if [[ -z "$skills_line" ]]; then
        continue  # No skills, nothing to check
    fi

    # Parse skills list
    skills_list=$(echo "$skills_line" | sed 's/^skills:[[:space:]]*//' | tr ',' '\n' | tr -d ' ')

    # Check all referenced skills exist
    for skill in $skills_list; do
        [[ -z "$skill" ]] && continue

        skill_found=false
        for s in $SKILLS; do
            if [[ "$s" == "$skill" ]]; then
                skill_found=true
                break
            fi
        done

        if ! $skill_found; then
            CRITICAL_ERRORS+=("$relative_path: references unknown skill '$skill'")
        fi
    done

    # Check for skill composition section
    if ! echo "$content" | grep -qE "## Skill Composition|## Skills|### Skill Invocation"; then
        PHASE3_ERRORS+=("$relative_path: Missing skill composition section (Phase 3 requirement)")
    fi
done

# Report results
echo ""
echo "Validation Summary:"
echo "  Commands scanned: $CMD_COUNT"
echo "  Agents scanned: $AGENT_FILE_COUNT"

if [[ ${#CRITICAL_ERRORS[@]} -gt 0 ]]; then
    echo ""
    echo "${#CRITICAL_ERRORS[@]} CRITICAL errors (must fix):"
    for error in "${CRITICAL_ERRORS[@]}"; do
        echo "  - $error"
    done
fi

if [[ ${#PHASE2_ERRORS[@]} -gt 0 ]]; then
    echo ""
    echo "${#PHASE2_ERRORS[@]} Phase 2 pending (command directives):"
    count=0
    for error in "${PHASE2_ERRORS[@]}"; do
        ((count++)) || true
        [[ $count -gt 5 ]] && break
        echo "  - $error"
    done
    if [[ ${#PHASE2_ERRORS[@]} -gt 5 ]]; then
        echo "  ... and $((${#PHASE2_ERRORS[@]} - 5)) more"
    fi
fi

if [[ ${#PHASE3_ERRORS[@]} -gt 0 ]]; then
    echo ""
    echo "${#PHASE3_ERRORS[@]} Phase 3 pending (agent composition):"
    count=0
    for error in "${PHASE3_ERRORS[@]}"; do
        ((count++)) || true
        [[ $count -gt 5 ]] && break
        echo "  - $error"
    done
    if [[ ${#PHASE3_ERRORS[@]} -gt 5 ]]; then
        echo "  ... and $((${#PHASE3_ERRORS[@]} - 5)) more"
    fi
fi

if [[ ${#CRITICAL_ERRORS[@]} -gt 0 ]]; then
    echo ""
    echo "[FAIL] Validation FAILED: ${#CRITICAL_ERRORS[@]} critical errors"
    exit 1
fi

if [[ ${#PHASE2_ERRORS[@]} -gt 0 ]] || [[ ${#PHASE3_ERRORS[@]} -gt 0 ]]; then
    echo ""
    echo "[WARN] Phase 1 complete. Pending: Phase 2 (${#PHASE2_ERRORS[@]}), Phase 3 (${#PHASE3_ERRORS[@]})"
    exit 0
fi

echo ""
echo "[PASS] All delegation checks passed!"
exit 0
