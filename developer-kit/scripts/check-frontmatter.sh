#!/bin/bash
# Validate frontmatter in all component files
# See docs/FRONTMATTER-SPEC.md for field requirements

set -e

ERRORS=0
WARNINGS=0
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

echo "=== Frontmatter Validation ==="
echo ""

# Validate skills
echo "Checking skills..."
SKILL_COUNT=0
for skill in "$ROOT_DIR"/skills/*/SKILL.md; do
  if [ -f "$skill" ]; then
    SKILL_COUNT=$((SKILL_COUNT + 1))
    name=$(grep "^name:" "$skill" | head -1)
    desc=$(grep "^description:" "$skill" | head -1)

    if [ -z "$name" ]; then
      echo "ERROR: $skill missing 'name' field"
      ERRORS=$((ERRORS + 1))
    fi

    if [ -z "$desc" ]; then
      echo "ERROR: $skill missing 'description' field"
      ERRORS=$((ERRORS + 1))
    fi

    # Extract frontmatter and check for deprecated fields
    frontmatter=$(sed -n '1,/^---$/p' "$skill" | tail -n +2)
    if echo "$frontmatter" | grep -q "^when_to_use:"; then
      echo "WARNING: $skill has deprecated 'when_to_use' field"
      WARNINGS=$((WARNINGS + 1))
    fi
    if echo "$frontmatter" | grep -q "^version:"; then
      echo "WARNING: $skill has deprecated 'version' field"
      WARNINGS=$((WARNINGS + 1))
    fi
    if echo "$frontmatter" | grep -q "^languages:"; then
      echo "WARNING: $skill has deprecated 'languages' field"
      WARNINGS=$((WARNINGS + 1))
    fi
  fi
done
echo "  Found $SKILL_COUNT skills"

# Validate agents
echo "Checking agents..."
AGENT_COUNT=0
for agent in "$ROOT_DIR"/agents/*.md; do
  if [ -f "$agent" ]; then
    AGENT_COUNT=$((AGENT_COUNT + 1))
    name=$(grep "^name:" "$agent" | head -1)
    desc=$(grep "^description:" "$agent" | head -1)
    tools=$(grep "^tools:" "$agent" | head -1)
    model=$(grep "^model:" "$agent" | head -1)

    if [ -z "$name" ]; then
      echo "ERROR: $agent missing 'name' field"
      ERRORS=$((ERRORS + 1))
    fi

    if [ -z "$desc" ]; then
      echo "ERROR: $agent missing 'description' field"
      ERRORS=$((ERRORS + 1))
    fi

    if [ -z "$tools" ]; then
      echo "WARNING: $agent missing 'tools' field"
      WARNINGS=$((WARNINGS + 1))
    fi

    if [ -z "$model" ]; then
      echo "WARNING: $agent missing 'model' field"
      WARNINGS=$((WARNINGS + 1))
    fi
  fi
done
echo "  Found $AGENT_COUNT agents"

# Validate commands
echo "Checking commands..."
CMD_COUNT=0
for cmd in "$ROOT_DIR"/commands/dk/*/*.md; do
  if [ -f "$cmd" ]; then
    CMD_COUNT=$((CMD_COUNT + 1))
    name=$(grep "^name:" "$cmd" | head -1)
    desc=$(grep "^description:" "$cmd" | head -1)

    if [ -z "$name" ]; then
      echo "ERROR: $cmd missing 'name' field"
      ERRORS=$((ERRORS + 1))
    fi

    if [ -z "$desc" ]; then
      echo "ERROR: $cmd missing 'description' field"
      ERRORS=$((ERRORS + 1))
    fi
  fi
done
echo "  Found $CMD_COUNT commands"

echo ""
echo "=== Summary ==="
echo "Skills:   $SKILL_COUNT"
echo "Agents:   $AGENT_COUNT"
echo "Commands: $CMD_COUNT"
echo "Errors:   $ERRORS"
echo "Warnings: $WARNINGS"
echo ""

if [ $ERRORS -gt 0 ]; then
  echo "FAILED: $ERRORS errors found"
  exit 1
else
  if [ $WARNINGS -gt 0 ]; then
    echo "PASSED with $WARNINGS warnings"
  else
    echo "PASSED: All frontmatter valid"
  fi
  exit 0
fi
