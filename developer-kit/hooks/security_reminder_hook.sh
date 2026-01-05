#!/bin/bash
# security_reminder_hook.sh
# PostToolUse hook - security pattern detection for Write/Edit/MultiEdit
#
# Checks for security anti-patterns in edited files and warns about potential vulnerabilities.

set -euo pipefail

# Read JSON input from stdin
INPUT=$(cat)

# Extract file path and tool info
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.path // ""' 2>/dev/null || echo "")
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // ""' 2>/dev/null || echo "")
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // "default"' 2>/dev/null || echo "default")

# Skip if no file path
if [[ -z "$FILE_PATH" ]]; then
    echo '{"continue":true,"suppressOutput":true}'
    exit 0
fi

# Check if security reminders are disabled
if [[ "${ENABLE_SECURITY_REMINDER:-1}" == "0" ]]; then
    echo '{"continue":true,"suppressOutput":true}'
    exit 0
fi

# State file for tracking shown warnings (session-scoped)
STATE_DIR="$HOME/.claude"
STATE_FILE="$STATE_DIR/security_warnings_state_${SESSION_ID}.json"

# Extract content to check based on tool type
CONTENT=""
case "$TOOL_NAME" in
    Write)
        CONTENT=$(echo "$INPUT" | jq -r '.tool_input.content // ""' 2>/dev/null || echo "")
        ;;
    Edit)
        CONTENT=$(echo "$INPUT" | jq -r '.tool_input.new_string // ""' 2>/dev/null || echo "")
        ;;
    MultiEdit)
        CONTENT=$(echo "$INPUT" | jq -r '.tool_input.edits[]?.new_string // ""' 2>/dev/null | tr '\n' ' ' || echo "")
        ;;
esac

# Security patterns to check
declare -A SECURITY_RULES
SECURITY_RULES["child_process_exec"]="child_process.exec|exec(|execSync("
SECURITY_RULES["new_function_injection"]="new Function"
SECURITY_RULES["eval_injection"]="eval("
SECURITY_RULES["react_dangerously_set_html"]="dangerouslySetInnerHTML"
SECURITY_RULES["document_write_xss"]="document.write"
SECURITY_RULES["innerHTML_xss"]=".innerHTML ="
SECURITY_RULES["pickle_deserialization"]="pickle"
SECURITY_RULES["os_system_injection"]="os.system"

# Check for GitHub Actions workflow files
if [[ "$FILE_PATH" == *".github/workflows/"* ]] && [[ "$FILE_PATH" == *.yml || "$FILE_PATH" == *.yaml ]]; then
    WARNING_KEY="${FILE_PATH}-github_actions_workflow"

    # Check if already warned this session
    if [[ -f "$STATE_FILE" ]] && grep -q "$WARNING_KEY" "$STATE_FILE" 2>/dev/null; then
        echo '{"continue":true,"suppressOutput":true}'
        exit 0
    fi

    # Record warning
    mkdir -p "$STATE_DIR"
    echo "$WARNING_KEY" >> "$STATE_FILE"

    echo '{"continue":true,"systemMessage":"Security Warning (github_actions_workflow): You are editing a GitHub Actions workflow file. Be aware of command injection risks with untrusted input."}'
    exit 0
fi

# Check content-based patterns
for RULE_NAME in "${!SECURITY_RULES[@]}"; do
    PATTERN="${SECURITY_RULES[$RULE_NAME]}"

    # Check if pattern exists in content (using grep with extended regex)
    if echo "$CONTENT" | grep -qE "$PATTERN" 2>/dev/null; then
        WARNING_KEY="${FILE_PATH}-${RULE_NAME}"

        # Check if already warned this session
        if [[ -f "$STATE_FILE" ]] && grep -q "$WARNING_KEY" "$STATE_FILE" 2>/dev/null; then
            continue
        fi

        # Record warning
        mkdir -p "$STATE_DIR"
        echo "$WARNING_KEY" >> "$STATE_FILE"

        echo "{\"continue\":true,\"systemMessage\":\"Security Warning (${RULE_NAME}): Detected potentially dangerous pattern in edited file.\"}"
        exit 0
    fi
done

# No security issues found
echo '{"continue":true,"suppressOutput":true}'
