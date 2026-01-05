#!/bin/bash
# restore_session_context.sh
# SessionStart hook - restore previous session context
#
# Displays:
# - Current git branch
# - Current goal from context file
# - Progress (completed/pending tasks)
# - Last session date if available

set -euo pipefail

# Get project directory (use CLAUDE_PROJECT_DIR if set, otherwise pwd)
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"

CONTEXT_FILE="$PROJECT_DIR/docs/session/current-context.md"
LAST_SESSION="$PROJECT_DIR/docs/session/last-session.md"

OUTPUT_PARTS=()

# Get current git branch
if [[ -d "$PROJECT_DIR/.git" ]]; then
    BRANCH=$(git -C "$PROJECT_DIR" branch --show-current 2>/dev/null || echo "")
    if [[ -n "$BRANCH" ]]; then
        OUTPUT_PARTS+=("Branch: $BRANCH")
    fi
fi

# Check for current context file
if [[ -f "$CONTEXT_FILE" ]]; then
    CONTENT=$(cat "$CONTEXT_FILE" 2>/dev/null || echo "")

    # Extract goal (line after ## Goal)
    GOAL=$(echo "$CONTENT" | grep -A1 "^## Goal" 2>/dev/null | tail -1 | sed 's/^[[:space:]]*//' || echo "")
    if [[ -n "$GOAL" ]] && [[ "$GOAL" != "## Goal" ]] && [[ "$GOAL" != "[To be defined"* ]]; then
        # Count checkboxes
        COMPLETED=$(echo "$CONTENT" | grep -c "^- \[x\]" 2>/dev/null || echo "0")
        PENDING=$(echo "$CONTENT" | grep -c "^- \[ \]" 2>/dev/null || echo "0")

        # Truncate goal if too long
        if [[ ${#GOAL} -gt 80 ]]; then
            GOAL="${GOAL:0:77}..."
        fi

        OUTPUT_PARTS+=("Goal: $GOAL | Progress: $COMPLETED done, $PENDING pending")
    else
        # Just show progress if no goal
        COMPLETED=$(echo "$CONTENT" | grep -c "^- \[x\]" 2>/dev/null || echo "0")
        PENDING=$(echo "$CONTENT" | grep -c "^- \[ \]" 2>/dev/null || echo "0")
        if [[ "$COMPLETED" -gt 0 ]] || [[ "$PENDING" -gt 0 ]]; then
            OUTPUT_PARTS+=("Progress: $COMPLETED done, $PENDING pending")
        fi
    fi
fi

# Check for last session file
if [[ -f "$LAST_SESSION" ]]; then
    LAST_DATE=$(grep "^\*\*Date\*\*:" "$LAST_SESSION" 2>/dev/null | sed 's/\*\*Date\*\*:[[:space:]]*//' || echo "")
    if [[ -n "$LAST_DATE" ]]; then
        OUTPUT_PARTS+=("Last session: $LAST_DATE")
    fi
fi

# Build and output response
if [[ ${#OUTPUT_PARTS[@]} -gt 0 ]]; then
    # Join array with " | "
    MESSAGE="Session restored: $(IFS=" | "; echo "${OUTPUT_PARTS[*]}")"
    # Escape for JSON
    MESSAGE=$(echo "$MESSAGE" | sed 's/"/\\"/g')
    echo "{\"continue\":true,\"systemMessage\":\"$MESSAGE\"}"
else
    echo '{"continue":true,"suppressOutput":true}'
fi
