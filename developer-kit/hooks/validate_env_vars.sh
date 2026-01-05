#!/bin/bash
# validate_env_vars.sh
# SessionStart hook - validate required environment variables for MCP servers
#
# Checks for required API keys and guides users through setup if missing.

set -euo pipefail

SETTINGS_FILE="$HOME/.claude/settings.json"
MISSING_REQUIRED=""
MISSING_OPTIONAL=""

# Check if settings file exists
if [[ -f "$SETTINGS_FILE" ]]; then
    # Check TAVILY_API_KEY (required)
    TAVILY=$(jq -r '.env.TAVILY_API_KEY // ""' "$SETTINGS_FILE" 2>/dev/null || echo "")
    if [[ -z "$TAVILY" ]] || [[ "$TAVILY" == "your-"* ]] || [[ "$TAVILY" == "null" ]]; then
        MISSING_REQUIRED="TAVILY_API_KEY"
    fi

    # Check GITHUB_TOKEN (optional)
    GITHUB=$(jq -r '.env.GITHUB_TOKEN // ""' "$SETTINGS_FILE" 2>/dev/null || echo "")
    if [[ -z "$GITHUB" ]] || [[ "$GITHUB" == "your-"* ]] || [[ "$GITHUB" == "null" ]]; then
        MISSING_OPTIONAL="GITHUB_TOKEN"
    fi
else
    MISSING_REQUIRED="TAVILY_API_KEY"
    MISSING_OPTIONAL="GITHUB_TOKEN"
fi

# If all required vars are set, output success silently
if [[ -z "$MISSING_REQUIRED" ]] && [[ -z "$MISSING_OPTIONAL" ]]; then
    echo '{"continue":true,"suppressOutput":true}'
    exit 0
fi

# Build warning message
MESSAGE=""

if [[ -n "$MISSING_REQUIRED" ]]; then
    MESSAGE="[Warning] Missing required API keys: $MISSING_REQUIRED (get at https://tavily.com)"
fi

if [[ -n "$MISSING_OPTIONAL" ]] && [[ -z "$MESSAGE" ]]; then
    MESSAGE="[Info] Optional API key not configured: $MISSING_OPTIONAL"
fi

if [[ -n "$MESSAGE" ]]; then
    # Escape for JSON
    MESSAGE=$(echo "$MESSAGE" | sed 's/"/\\"/g')
    echo "{\"continue\":true,\"systemMessage\":\"$MESSAGE\"}"
else
    echo '{"continue":true,"suppressOutput":true}'
fi
