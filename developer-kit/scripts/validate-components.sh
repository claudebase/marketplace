#!/bin/bash
# Developer Kit Component Validation Script
# Validates all plugin components against Claude Code specifications

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_DIR="$(dirname "$SCRIPT_DIR")"

echo "=== Developer Kit Validation ==="
echo "Plugin directory: $PLUGIN_DIR"
echo ""

ERRORS=0
WARNINGS=0

# Helper functions
error() {
  echo "ERROR: $1"
  ERRORS=$((ERRORS + 1))
}

warn() {
  echo "WARN: $1"
  WARNINGS=$((WARNINGS + 1))
}

ok() {
  echo "OK: $1"
}

# Test 1: Verify plugin.json exists and is valid JSON
echo "--- Test 1: Plugin Manifest ---"
if [ -f "$PLUGIN_DIR/.claude-plugin/plugin.json" ]; then
  if jq . "$PLUGIN_DIR/.claude-plugin/plugin.json" > /dev/null 2>&1; then
    ok "plugin.json is valid JSON"
  else
    error "plugin.json is invalid JSON"
  fi
else
  error "Missing .claude-plugin/plugin.json"
fi
echo ""

# Test 2: Verify all skills have SKILL.md (FLAT STRUCTURE)
echo "--- Test 2: Skills Structure (must be flat) ---"
skill_count=0
for dir in "$PLUGIN_DIR"/skills/*/; do
  if [ -d "$dir" ]; then
    skill_name=$(basename "$dir")
    if [ -f "${dir}SKILL.md" ]; then
      ok "skills/$skill_name/SKILL.md exists"
      skill_count=$((skill_count + 1))
    else
      error "Missing SKILL.md in skills/$skill_name/"
    fi
  fi
done
echo "Total skills: $skill_count"
echo ""

# Test 3: Verify no nested skill directories (CRITICAL)
echo "--- Test 3: No Nested Skills (critical check) ---"
nested_skills=$(find "$PLUGIN_DIR/skills" -mindepth 3 -name "SKILL.md" 2>/dev/null || true)
if [ -n "$nested_skills" ]; then
  error "Found nested SKILL.md files (Claude Code won't discover these):"
  echo "$nested_skills"
else
  ok "No nested skills found - all skills are flat"
fi
echo ""

# Test 4: Verify YAML frontmatter in skills
echo "--- Test 4: Skill Frontmatter ---"
for skill_file in "$PLUGIN_DIR"/skills/*/SKILL.md; do
  if [ -f "$skill_file" ]; then
    skill_name=$(basename "$(dirname "$skill_file")")
    if head -1 "$skill_file" | grep -q "^---$"; then
      # Check for required fields
      if grep -q "^name:" "$skill_file" && grep -q "^description:" "$skill_file"; then
        ok "skills/$skill_name has valid frontmatter"
      else
        warn "skills/$skill_name missing name or description in frontmatter"
      fi
    else
      error "skills/$skill_name/SKILL.md missing YAML frontmatter"
    fi
  fi
done
echo ""

# Test 5: Verify agents exist and have frontmatter
echo "--- Test 5: Agents ---"
agent_count=0
for agent_file in "$PLUGIN_DIR"/agents/*.md; do
  if [ -f "$agent_file" ]; then
    agent_name=$(basename "$agent_file" .md)
    if head -1 "$agent_file" | grep -q "^---$"; then
      ok "agents/$agent_name.md has frontmatter"
      agent_count=$((agent_count + 1))
    else
      error "agents/$agent_name.md missing YAML frontmatter"
    fi
  fi
done
echo "Total agents: $agent_count"
echo ""

# Test 6: Verify commands exist and have frontmatter
echo "--- Test 6: Commands ---"
command_count=0
for cmd_file in $(find "$PLUGIN_DIR/commands" -name "*.md" 2>/dev/null); do
  if [ -f "$cmd_file" ]; then
    cmd_rel_path="${cmd_file#$PLUGIN_DIR/}"
    if head -1 "$cmd_file" | grep -q "^---$"; then
      ok "$cmd_rel_path has frontmatter"
      command_count=$((command_count + 1))
    else
      error "$cmd_rel_path missing YAML frontmatter"
    fi
  fi
done
echo "Total commands: $command_count"
echo ""

# Test 7: Validate JSON configuration files
echo "--- Test 7: JSON Configuration Files ---"
for json_file in ".mcp.json" ".lsp.json" "hooks/hooks.json"; do
  full_path="$PLUGIN_DIR/$json_file"
  if [ -f "$full_path" ]; then
    if jq . "$full_path" > /dev/null 2>&1; then
      ok "$json_file is valid JSON"
    else
      error "$json_file is invalid JSON"
    fi
  else
    warn "$json_file not found (optional)"
  fi
done
echo ""

# Test 8: Check for required sections in skills
echo "--- Test 8: Skill Content Structure ---"
for skill_file in "$PLUGIN_DIR"/skills/*/SKILL.md; do
  if [ -f "$skill_file" ]; then
    skill_name=$(basename "$(dirname "$skill_file")")
    missing_sections=""

    if ! grep -qi "trigger\|activate" "$skill_file"; then
      missing_sections="$missing_sections Triggers"
    fi
    if ! grep -qi "boundaries\|will do\|will not" "$skill_file"; then
      missing_sections="$missing_sections Boundaries"
    fi

    if [ -n "$missing_sections" ]; then
      warn "skills/$skill_name missing sections:$missing_sections"
    fi
  fi
done
echo ""

# Test 9: Check for explicit trigger phrases (v3.1.0+)
echo "--- Test 9: Skill Trigger Phrases ---"
triggers_found=0
triggers_missing=0
for skill_file in "$PLUGIN_DIR"/skills/*/SKILL.md; do
  if [ -f "$skill_file" ]; then
    skill_name=$(basename "$(dirname "$skill_file")")
    if grep -q "Activates for:" "$skill_file"; then
      triggers_found=$((triggers_found + 1))
    else
      warn "skills/$skill_name missing 'Activates for:' in description"
      triggers_missing=$((triggers_missing + 1))
    fi
  fi
done
echo "Skills with explicit triggers: $triggers_found/$((triggers_found + triggers_missing))"
echo ""

# Test 10: Verify hook events (v3.1.0+)
echo "--- Test 10: Hook Events ---"
if [ -f "$PLUGIN_DIR/hooks/hooks.json" ]; then
  required_hooks="PostToolUse PreToolUse SessionStart Stop SubagentStop UserPromptSubmit"
  for hook in $required_hooks; do
    if jq -e ".hooks.$hook" "$PLUGIN_DIR/hooks/hooks.json" > /dev/null 2>&1; then
      ok "Hook event '$hook' configured"
    else
      warn "Hook event '$hook' not configured"
    fi
  done
  hook_count=$(jq '.hooks | keys | length' "$PLUGIN_DIR/hooks/hooks.json")
  echo "Total hook events: $hook_count"
else
  warn "hooks/hooks.json not found"
fi
echo ""

# Test 11: Version consistency check
echo "--- Test 11: Version Consistency ---"
if [ -f "$PLUGIN_DIR/.claude-plugin/plugin.json" ]; then
  plugin_version=$(jq -r '.version' "$PLUGIN_DIR/.claude-plugin/plugin.json")
  echo "plugin.json version: $plugin_version"

  if [ -f "$PLUGIN_DIR/hooks/hooks.json" ]; then
    if grep -q "v$plugin_version" "$PLUGIN_DIR/hooks/hooks.json"; then
      ok "SessionStart message matches plugin version"
    else
      warn "SessionStart message may not match plugin version $plugin_version"
    fi
  fi
fi
echo ""

# Test 12: Check for security issues
echo "--- Test 12: Security Checks ---"
if [ -f "$PLUGIN_DIR/.mcp.json" ]; then
  # Check for hardcoded API keys (not environment variable references)
  if grep -E '"[A-Za-z0-9_]+":\s*"[^$][^"]{20,}"' "$PLUGIN_DIR/.mcp.json" | grep -qi "key\|token\|secret"; then
    warn "Possible hardcoded secrets in .mcp.json (should use \${VAR} syntax)"
  else
    ok "No obvious hardcoded secrets in .mcp.json"
  fi
fi
echo ""

# Test 13: Check for stale references
echo "--- Test 13: Stale References ---"
stale_refs=$(grep -rl "docs-seeker" "$PLUGIN_DIR/skills" "$PLUGIN_DIR/commands" "$PLUGIN_DIR/agents" 2>/dev/null | grep -v ".archive" || true)
if [ -n "$stale_refs" ]; then
  warn "Found references to archived 'docs-seeker' skill:"
  echo "$stale_refs"
else
  ok "No stale references to archived components"
fi
echo ""

# Summary
echo "=== Validation Summary ==="
echo "Errors: $ERRORS"
echo "Warnings: $WARNINGS"
echo ""
echo "=== Component Counts ==="
echo "Skills: $skill_count"
echo "Agents: $agent_count"
echo "Commands: $command_count"
echo "Hook events: $(jq '.hooks | keys | length' "$PLUGIN_DIR/hooks/hooks.json" 2>/dev/null || echo 0)"
echo "Skills with triggers: $triggers_found/$((triggers_found + triggers_missing))"
echo ""

if [ $ERRORS -gt 0 ]; then
  echo "FAILED: $ERRORS error(s) found"
  exit 1
else
  echo "PASSED: All critical checks passed"
  if [ $WARNINGS -gt 0 ]; then
    echo "Note: $WARNINGS warning(s) should be reviewed"
  fi
  exit 0
fi
