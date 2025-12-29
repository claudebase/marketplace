#!/bin/bash
# Validates that all agents have required frontmatter fields
# Required: name, description, tools, model
# Usage: ./scripts/validate-agent-fields.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_DIR="$(dirname "$SCRIPT_DIR")"
AGENTS_DIR="$PLUGIN_DIR/agents"

REQUIRED_FIELDS=("name" "description" "tools" "model")
VALID_MODELS=("sonnet" "opus" "haiku")

errors=0
warnings=0
checked=0

echo "Validating agent required fields..."
echo ""

for agent_file in "$AGENTS_DIR"/*.md; do
    if [ ! -f "$agent_file" ]; then
        continue
    fi

    agent_name=$(basename "$agent_file" .md)
    checked=$((checked + 1))

    # Extract frontmatter (between first two ---)
    frontmatter=$(sed -n '/^---$/,/^---$/p' "$agent_file" | head -15)

    # Check required fields
    for field in "${REQUIRED_FIELDS[@]}"; do
        if ! echo "$frontmatter" | grep -q "^$field:"; then
            echo "ERROR: $agent_name - Missing required field '$field'"
            errors=$((errors + 1))
        fi
    done

    # Validate model value if present
    model_line=$(echo "$frontmatter" | grep "^model:" || true)
    if [ -n "$model_line" ]; then
        model_value=$(echo "$model_line" | cut -d: -f2 | tr -d ' ')

        valid=false
        for valid_model in "${VALID_MODELS[@]}"; do
            if [ "$model_value" = "$valid_model" ]; then
                valid=true
                break
            fi
        done

        if [ "$valid" = false ]; then
            echo "WARNING: $agent_name - Invalid model '$model_value' (expected: sonnet, opus, or haiku)"
            warnings=$((warnings + 1))
        fi
    fi

    # Check for tools field format (should be comma-separated)
    tools_line=$(echo "$frontmatter" | grep "^tools:" || true)
    if [ -n "$tools_line" ]; then
        tools_value=$(echo "$tools_line" | cut -d: -f2-)
        if [ -z "$(echo "$tools_value" | tr -d ' ')" ]; then
            echo "WARNING: $agent_name - Empty tools field"
            warnings=$((warnings + 1))
        fi
    fi
done

echo ""
echo "================================================"
echo "Checked $checked agents"
echo "Errors: $errors"
echo "Warnings: $warnings"
echo "================================================"

if [ $errors -gt 0 ]; then
    echo ""
    echo "FAILED: $errors error(s) found"
    exit 1
fi

if [ $warnings -gt 0 ]; then
    echo ""
    echo "PASSED with $warnings warning(s)"
else
    echo ""
    echo "PASSED: All agent fields valid!"
fi

exit 0
