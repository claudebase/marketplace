#!/bin/bash
# Migration Validation Script
# Validates skill-centric architecture compliance

set -e
cd "$(dirname "$0")/.." || exit 1

ERRORS=0
WARNINGS=0

echo "=== Migration Validation ==="
echo "Date: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""

# Test 1: All skills have required frontmatter
echo "[1/8] Checking skill frontmatter..."
for skill_dir in skills/*/; do
  skill_file="$skill_dir/SKILL.md"
  skill_name=$(basename "$skill_dir")
  if [ -f "$skill_file" ]; then
    if ! grep -q "^name:" "$skill_file"; then
      echo "  ERROR: Missing 'name' in $skill_file"
      ((ERRORS++))
    fi
    if ! grep -q "^description:" "$skill_file"; then
      echo "  ERROR: Missing 'description' in $skill_file"
      ((ERRORS++))
    fi
    if ! grep -q "^allowed-tools:" "$skill_file"; then
      echo "  ERROR: Missing 'allowed-tools' in $skill_file"
      ((ERRORS++))
    fi
    # New fields (warnings for now, will be errors after migration)
    if ! grep -q "^composable:" "$skill_file"; then
      echo "  WARNING: Missing 'composable' in $skill_file"
      ((WARNINGS++))
    fi
    if ! grep -q "^mode:" "$skill_file"; then
      echo "  WARNING: Missing 'mode' in $skill_file"
      ((WARNINGS++))
    fi
  fi
done
echo "  Skills checked: $(ls -d skills/*/ 2>/dev/null | wc -l | tr -d ' ')"

# Test 2: All agents have required frontmatter
echo ""
echo "[2/8] Checking agent frontmatter..."
for agent_file in agents/*.md; do
  if [ -f "$agent_file" ]; then
    agent_name=$(basename "$agent_file" .md)
    if ! grep -q "^name:" "$agent_file"; then
      echo "  ERROR: Missing 'name' in $agent_file"
      ((ERRORS++))
    fi
    if ! grep -q "^tools:" "$agent_file"; then
      echo "  ERROR: Missing 'tools' in $agent_file"
      ((ERRORS++))
    fi
    if ! grep -q "^model:" "$agent_file"; then
      echo "  ERROR: Missing 'model' in $agent_file"
      ((ERRORS++))
    fi
    # New fields (warnings for now)
    if ! grep -q "^skills:" "$agent_file"; then
      echo "  WARNING: Missing 'skills' in $agent_file"
      ((WARNINGS++))
    fi
    if ! grep -q "^expertise:" "$agent_file"; then
      echo "  WARNING: Missing 'expertise' in $agent_file"
      ((WARNINGS++))
    fi
  fi
done
echo "  Agents checked: $(ls agents/*.md 2>/dev/null | wc -l | tr -d ' ')"

# Test 3: All commands have required frontmatter
echo ""
echo "[3/8] Checking command frontmatter..."
for cmd_file in $(find commands -name "*.md"); do
  if [ -f "$cmd_file" ]; then
    if ! grep -q "^name:" "$cmd_file"; then
      echo "  ERROR: Missing 'name' in $cmd_file"
      ((ERRORS++))
    fi
    if ! grep -q "^delegates-to:" "$cmd_file"; then
      echo "  ERROR: Missing 'delegates-to' in $cmd_file"
      ((ERRORS++))
    fi
  fi
done
echo "  Commands checked: $(find commands -name "*.md" 2>/dev/null | wc -l | tr -d ' ')"

# Test 4: Command line limits
echo ""
echo "[4/8] Checking command line limits..."
over_limit=0
for cmd_file in $(find commands -name "*.md"); do
  lines=$(wc -l < "$cmd_file")
  if [ "$lines" -gt 100 ]; then
    echo "  WARNING: $cmd_file exceeds 100 lines ($lines lines)"
    ((WARNINGS++))
    ((over_limit++))
  fi
done
echo "  Commands over 100 lines: $over_limit"

# Test 5: Required shared references exist
echo ""
echo "[5/8] Checking shared references..."
required_refs=(
  "lib/shared-references/mcp-resources.md"
  "lib/shared-references/tool-integration-patterns.md"
)
optional_refs=(
  "lib/shared-references/review-patterns.md"
  "lib/shared-references/debugging-patterns.md"
  "lib/shared-references/frontend-patterns.md"
  "lib/shared-references/testing-patterns.md"
  "lib/shared-references/documentation-patterns.md"
  "lib/shared-references/research-patterns.md"
)
for ref in "${required_refs[@]}"; do
  if [ ! -f "$ref" ]; then
    echo "  ERROR: Missing required reference: $ref"
    ((ERRORS++))
  fi
done
for ref in "${optional_refs[@]}"; do
  if [ ! -f "$ref" ]; then
    echo "  INFO: Missing optional reference: $ref (will be created in Phase 1)"
  fi
done
echo "  Required references: ${#required_refs[@]} checked"

# Test 6: Plugin manifest valid
echo ""
echo "[6/8] Checking plugin manifest..."
if [ -f ".claude-plugin/plugin.json" ]; then
  if python3 -c "import json; json.load(open('.claude-plugin/plugin.json'))" 2>/dev/null; then
    echo "  Plugin manifest: valid JSON"
  else
    echo "  ERROR: Plugin manifest invalid JSON"
    ((ERRORS++))
  fi
else
  echo "  ERROR: Plugin manifest not found"
  ((ERRORS++))
fi

# Test 7: Check for broken internal links (basic check)
echo ""
echo "[7/8] Checking internal links..."
broken_count=0
for file in skills/*/SKILL.md agents/*.md; do
  if [ -f "$file" ]; then
    # Extract relative links and check if they exist
    while IFS= read -r link; do
      if [ -n "$link" ]; then
        dir=$(dirname "$file")
        target="$dir/$link"
        if [ ! -f "$target" ] && [ ! -d "$target" ]; then
          # Try from repo root
          if [ ! -f "$link" ] && [ ! -d "$link" ]; then
            # Only warn for .md files
            if [[ "$link" == *.md ]]; then
              echo "  WARNING: Potentially broken link in $file: $link"
              ((broken_count++))
            fi
          fi
        fi
      fi
    done < <(grep -oE '\[.*\]\(([^)]+)\)' "$file" 2>/dev/null | sed 's/.*(\([^)]*\))/\1/' | grep -E '^\.\./|^\./' | head -20)
  fi
done
echo "  Potential broken links: $broken_count"

# Test 8: Check for inline MCP patterns that should be in shared-references
echo ""
echo "[8/8] Checking for inline MCP patterns..."
inline_patterns=0
for file in skills/*/SKILL.md; do
  if [ -f "$file" ]; then
    # Count detailed MCP usage patterns (not just tool names in allowed-tools)
    count=$(grep -c "mcp__context7__\|mcp__github__\|mcp__tavily__" "$file" 2>/dev/null || echo 0)
    if [ "$count" -gt 5 ]; then
      echo "  INFO: $file has $count inline MCP references (consider extracting)"
      ((inline_patterns++))
    fi
  fi
done
echo "  Skills with many inline patterns: $inline_patterns"

# Summary
echo ""
echo "=== Validation Summary ==="
echo "Errors: $ERRORS"
echo "Warnings: $WARNINGS"
echo ""

if [ "$ERRORS" -eq 0 ]; then
  echo "PASSED: All critical checks passed"
  if [ "$WARNINGS" -gt 0 ]; then
    echo "Note: $WARNINGS warnings to address during migration"
  fi
  exit 0
else
  echo "FAILED: $ERRORS errors found"
  exit 1
fi
