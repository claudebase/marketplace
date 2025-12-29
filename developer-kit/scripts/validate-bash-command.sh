#!/bin/bash
# PreToolUse hook to validate bash commands for safety
# Receives JSON input via stdin per Claude Code specification
# Output uses hookSpecificOutput.permissionDecision format for PreToolUse

# Read JSON from stdin
INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# If no command provided, allow by default
if [ -z "$COMMAND" ]; then
  echo '{}'
  exit 0
fi

# Define dangerous patterns that should be blocked
# These patterns could cause catastrophic data loss or system damage
DANGEROUS_PATTERNS=(
  "rm -rf /"
  "rm -rf /*"
  "rm -rf ~"
  "rm -rf ~/"
  "> /dev/sda"
  "> /dev/nvme"
  "mkfs\."
  "dd if=/dev/zero of=/dev"
  "dd if=/dev/random of=/dev"
  ":(){:|:&};:"
  "chmod -R 777 /"
  "chown -R .* /"
  "mv /* "
  "mv / "
)

# Check command against dangerous patterns
for pattern in "${DANGEROUS_PATTERNS[@]}"; do
  if [[ "$COMMAND" == *"$pattern"* ]]; then
    # Use correct PreToolUse output format with hookSpecificOutput
    cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "deny",
    "permissionDecisionReason": "Potentially dangerous command pattern detected: $pattern. This command could cause catastrophic system damage."
  }
}
EOF
    exit 0
  fi
done

# Warn about sudo usage (but don't block)
if [[ "$COMMAND" == *"sudo"* ]]; then
  cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "ask",
    "permissionDecisionReason": "Command uses sudo. Please confirm you want to run with elevated privileges."
  }
}
EOF
  exit 0
fi

# Allow command to proceed (empty object uses default permission behavior)
echo '{}'
exit 0
