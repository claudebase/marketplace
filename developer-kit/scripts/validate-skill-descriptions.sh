#!/bin/bash
# Validates that all skills have proper frontmatter fields
# - Required: name, description
# - Recommended: "Activates for:" trigger phrases in description
# Usage: ./scripts/validate-skill-descriptions.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_DIR="$(dirname "$SCRIPT_DIR")"
SKILLS_DIR="$PLUGIN_DIR/skills"

errors=0
warnings=0
checked=0

echo "Validating skill descriptions..."
echo ""

for skill_dir in "$SKILLS_DIR"/*/; do
    skill_file="$skill_dir/SKILL.md"

    if [ ! -f "$skill_file" ]; then
        continue
    fi

    skill_name=$(basename "$skill_dir")
    checked=$((checked + 1))

    # Extract frontmatter (between first two ---)
    frontmatter=$(sed -n '/^---$/,/^---$/p' "$skill_file" | head -20)

    # Check for name field
    if ! echo "$frontmatter" | grep -q "^name:"; then
        echo "ERROR: $skill_name - Missing 'name' field"
        errors=$((errors + 1))
    fi

    # Check for description field
    if ! echo "$frontmatter" | grep -q "^description:"; then
        echo "ERROR: $skill_name - Missing 'description' field"
        errors=$((errors + 1))
        continue
    fi

    # Check for "Activates for:" in description (warning only)
    # Read the full description which may span multiple lines
    description=$(sed -n '/^---$/,/^---$/p' "$skill_file" | grep -A10 "^description:" | head -11)
    if ! echo "$description" | grep -qi "activates for:"; then
        echo "WARNING: $skill_name - Missing 'Activates for:' trigger phrases in description"
        warnings=$((warnings + 1))
    fi
done

echo ""
echo "================================================"
echo "Checked $checked skills"
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
    echo "PASSED: All skill descriptions valid!"
fi

exit 0
