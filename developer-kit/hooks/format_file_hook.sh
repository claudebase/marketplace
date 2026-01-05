#!/bin/bash
# format_file_hook.sh
# PostToolUse hook - auto-format files after Write/Edit operations
#
# Supports formatting for multiple languages using their standard formatters:
# - JavaScript/TypeScript: prettier
# - Python: black
# - Go: gofmt
# - Rust: rustfmt

set -euo pipefail

# Read JSON input from stdin
INPUT=$(cat)

# Extract file path
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.path // ""' 2>/dev/null || echo "")

# Skip if no file path
if [[ -z "$FILE_PATH" ]]; then
    echo '{"continue":true,"suppressOutput":true}'
    exit 0
fi

# Skip if file doesn't exist
if [[ ! -f "$FILE_PATH" ]]; then
    echo '{"continue":true,"suppressOutput":true}'
    exit 0
fi

# Get file extension (lowercase)
EXT="${FILE_PATH##*.}"
EXT=$(echo "$EXT" | tr '[:upper:]' '[:lower:]')

FORMATTED=""
FORMATTER_NAME=""

# Format based on extension
case ".$EXT" in
    .js|.jsx|.ts|.tsx|.mjs|.cjs|.json|.css|.scss|.less|.md|.yaml|.yml|.html|.vue|.svelte|.graphql|.gql)
        # Try prettier
        if command -v prettier &>/dev/null; then
            if prettier --write "$FILE_PATH" 2>/dev/null; then
                FORMATTED="true"
                FORMATTER_NAME="prettier"
            fi
        elif command -v npx &>/dev/null; then
            if npx prettier --write "$FILE_PATH" 2>/dev/null; then
                FORMATTED="true"
                FORMATTER_NAME="prettier"
            fi
        fi
        ;;
    .py|.pyi)
        # Try black
        if command -v black &>/dev/null; then
            if black --quiet "$FILE_PATH" 2>/dev/null; then
                FORMATTED="true"
                FORMATTER_NAME="black"
            fi
        elif command -v python3 &>/dev/null; then
            if python3 -m black --quiet "$FILE_PATH" 2>/dev/null; then
                FORMATTED="true"
                FORMATTER_NAME="black"
            fi
        fi
        ;;
    .go)
        # Try gofmt
        if command -v gofmt &>/dev/null; then
            if gofmt -w "$FILE_PATH" 2>/dev/null; then
                FORMATTED="true"
                FORMATTER_NAME="gofmt"
            fi
        fi
        ;;
    .rs)
        # Try rustfmt
        if command -v rustfmt &>/dev/null; then
            if rustfmt "$FILE_PATH" 2>/dev/null; then
                FORMATTED="true"
                FORMATTER_NAME="rustfmt"
            fi
        fi
        ;;
esac

# Output result
if [[ -n "$FORMATTED" ]]; then
    FILENAME=$(basename "$FILE_PATH")
    echo "{\"continue\":true,\"systemMessage\":\"Formatted $FILENAME with $FORMATTER_NAME\"}"
else
    echo '{"continue":true,"suppressOutput":true}'
fi
