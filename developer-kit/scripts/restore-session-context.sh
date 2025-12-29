#!/bin/bash
# restore-session-context.sh - SessionStart hook for context restoration
# Returns JSON response per Claude Code hook specification

# Determine project directory
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
CONTEXT_FILE="$PROJECT_DIR/docs/session/current-context.md"
LAST_SESSION="$PROJECT_DIR/docs/session/last-session.md"

# Initialize output parts
CONTEXT_INFO=""
SESSION_INFO=""
BRANCH_INFO=""

# Get current git branch
if command -v git &> /dev/null && [ -d "$PROJECT_DIR/.git" ]; then
    CURRENT_BRANCH=$(cd "$PROJECT_DIR" && git branch --show-current 2>/dev/null)
    if [ -n "$CURRENT_BRANCH" ]; then
        BRANCH_INFO="Branch: $CURRENT_BRANCH"
    fi
fi

# Check for current context file
if [ -f "$CONTEXT_FILE" ]; then
    # Extract goal (line after ## Goal)
    GOAL=$(grep -A1 "^## Goal" "$CONTEXT_FILE" 2>/dev/null | tail -1 | sed 's/^[[:space:]]*//')

    # Extract status items (checkboxes)
    COMPLETED=$(grep -c "^\- \[x\]" "$CONTEXT_FILE" 2>/dev/null || echo "0")
    PENDING=$(grep -c "^\- \[ \]" "$CONTEXT_FILE" 2>/dev/null || echo "0")

    if [ -n "$GOAL" ] && [ "$GOAL" != "## Goal" ] && [ "$GOAL" != "[To be defined" ]; then
        CONTEXT_INFO="Goal: $GOAL | Progress: $COMPLETED done, $PENDING pending"
    elif [ "$COMPLETED" != "0" ] || [ "$PENDING" != "0" ]; then
        CONTEXT_INFO="Progress: $COMPLETED done, $PENDING pending"
    fi
fi

# Check for last session file
if [ -f "$LAST_SESSION" ]; then
    # Get the date from last session
    LAST_DATE=$(grep -m1 "^\*\*Date\*\*:" "$LAST_SESSION" 2>/dev/null | sed 's/\*\*Date\*\*:[[:space:]]*//')
    if [ -n "$LAST_DATE" ]; then
        SESSION_INFO="Last session: $LAST_DATE"
    fi
fi

# Build output message
OUTPUT_PARTS=()
[ -n "$BRANCH_INFO" ] && OUTPUT_PARTS+=("$BRANCH_INFO")
[ -n "$CONTEXT_INFO" ] && OUTPUT_PARTS+=("$CONTEXT_INFO")
[ -n "$SESSION_INFO" ] && OUTPUT_PARTS+=("$SESSION_INFO")

if [ ${#OUTPUT_PARTS[@]} -gt 0 ]; then
    # Join parts with " | "
    OUTPUT=$(IFS=" | "; echo "${OUTPUT_PARTS[*]}")

    # Escape for JSON (basic escaping)
    OUTPUT=$(echo "$OUTPUT" | sed 's/"/\\"/g' | sed 's/\\/\\\\/g' | tr '\n' ' ')

    echo "{\"continue\": true, \"systemMessage\": \"Session restored: $OUTPUT\"}"
else
    # No context found - just show version
    echo '{"continue": true, "suppressOutput": true}'
fi

exit 0
