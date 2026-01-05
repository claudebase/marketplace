#!/bin/bash
# validate_bash_command.sh
# PreToolUse hook - validates bash commands for safety
#
# Blocks dangerous commands that could cause catastrophic damage.
# Prompts for confirmation on commands using elevated privileges.

set -euo pipefail

# Read JSON input from stdin
INPUT=$(cat)

# Extract command using jq (required dependency)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // ""' 2>/dev/null || echo "")

# If no command provided, allow by default
if [[ -z "$COMMAND" ]]; then
    echo '{}'
    exit 0
fi

# Normalize command for pattern matching (lowercase)
NORMALIZED=$(echo "$COMMAND" | tr '[:upper:]' '[:lower:]')

# Dangerous patterns that should be blocked
DANGEROUS_PATTERNS=(
    "rm -rf /"
    "rm -rf /*"
    "rm -rf ~"
    "rm -rf ~/"
    'rm -rf $home'
    "> /dev/sda"
    "> /dev/nvme"
    "mkfs."
    "dd if=/dev/zero of=/dev"
    "dd if=/dev/random of=/dev"
    ":(){:|:&};:"
    "chmod -r 777 /"
    "chown -r"
    "mv /* "
    "mv / "
    "git clean -fdx /"
)

# Check for dangerous patterns
for pattern in "${DANGEROUS_PATTERNS[@]}"; do
    if [[ "$NORMALIZED" == *"$pattern"* ]]; then
        cat << EOF
{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Potentially dangerous command pattern detected: '$pattern'. This command could cause catastrophic system damage."}}
EOF
        exit 0
    fi
done

# Patterns that require confirmation (elevated privileges)
if [[ "$NORMALIZED" == sudo\ * ]] || [[ "$NORMALIZED" == *" sudo "* ]] || \
   [[ "$NORMALIZED" == doas\ * ]] || [[ "$NORMALIZED" == pkexec\ * ]]; then
    cat << EOF
{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"ask","permissionDecisionReason":"Command uses elevated privileges (sudo/doas/pkexec). Please confirm you want to run with elevated privileges."}}
EOF
    exit 0
fi

# Allow command to proceed (empty object uses default permission behavior)
echo '{}'
