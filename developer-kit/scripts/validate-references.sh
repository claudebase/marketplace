#!/bin/bash
# Validates that all referenced files in skills actually exist
# Checks for patterns like: references/*.md, `references/*.md`
# Usage: ./scripts/validate-references.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_DIR="$(dirname "$SCRIPT_DIR")"
SKILLS_DIR="$PLUGIN_DIR/skills"

errors=0
checked=0
refs_checked=0

echo "Validating skill reference links..."
echo ""

for skill_dir in "$SKILLS_DIR"/*/; do
    skill_file="$skill_dir/SKILL.md"

    if [ ! -f "$skill_file" ]; then
        continue
    fi

    skill_name=$(basename "$skill_dir")
    checked=$((checked + 1))

    # Find all references to files (various patterns)
    # Pattern 1: references/filename.md (plain)
    # Pattern 2: `references/filename.md` (backticks)
    # Pattern 3: (references/filename.md) (parentheses)

    refs=$(grep -oE 'references/[a-zA-Z0-9_-]+\.md' "$skill_file" 2>/dev/null | sort -u || true)

    for ref in $refs; do
        if [ -z "$ref" ]; then
            continue
        fi

        refs_checked=$((refs_checked + 1))
        ref_path="$skill_dir$ref"

        if [ ! -f "$ref_path" ]; then
            echo "ERROR: $skill_name - Missing reference file: $ref"
            errors=$((errors + 1))
        fi
    done
done

echo ""
echo "================================================"
echo "Checked $checked skills"
echo "Reference links checked: $refs_checked"
echo "Errors: $errors"
echo "================================================"

if [ $errors -gt 0 ]; then
    echo ""
    echo "FAILED: $errors missing reference file(s)"
    exit 1
fi

echo ""
echo "PASSED: All reference links valid!"
exit 0
