#!/bin/bash
# PostToolUse hook for auto-formatting files after Write/Edit operations
# Receives JSON input via stdin per Claude Code specification
# Returns JSON response per Claude Code hook spec

# Read JSON from stdin
INPUT=$(cat)

# Extract file path from tool_input
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.path // empty')

# Return JSON if no file path provided
if [ -z "$FILE_PATH" ]; then
  echo '{"continue": true, "suppressOutput": true}'
  exit 0
fi

# Return JSON if file doesn't exist (might have been deleted)
if [ ! -f "$FILE_PATH" ]; then
  echo '{"continue": true, "suppressOutput": true}'
  exit 0
fi

FORMATTED=false
FORMATTER_USED=""

# Format if prettier is available and file type is supported
if command -v prettier &> /dev/null; then
  if [[ "$FILE_PATH" =~ \.(js|ts|jsx|tsx|json|css|scss|less|md|yaml|yml|html|vue|svelte)$ ]]; then
    if prettier --write "$FILE_PATH" 2>/dev/null; then
      FORMATTED=true
      FORMATTER_USED="prettier"
    fi
  fi
fi

# Format Python files with black if available
if [ "$FORMATTED" = false ] && command -v black &> /dev/null; then
  if [[ "$FILE_PATH" =~ \.py$ ]]; then
    if black --quiet "$FILE_PATH" 2>/dev/null; then
      FORMATTED=true
      FORMATTER_USED="black"
    fi
  fi
fi

# Format Go files with gofmt if available
if [ "$FORMATTED" = false ] && command -v gofmt &> /dev/null; then
  if [[ "$FILE_PATH" =~ \.go$ ]]; then
    if gofmt -w "$FILE_PATH" 2>/dev/null; then
      FORMATTED=true
      FORMATTER_USED="gofmt"
    fi
  fi
fi

# Format Rust files with rustfmt if available
if [ "$FORMATTED" = false ] && command -v rustfmt &> /dev/null; then
  if [[ "$FILE_PATH" =~ \.rs$ ]]; then
    if rustfmt "$FILE_PATH" 2>/dev/null; then
      FORMATTED=true
      FORMATTER_USED="rustfmt"
    fi
  fi
fi

# Return JSON response
if [ "$FORMATTED" = true ]; then
  BASENAME=$(basename "$FILE_PATH")
  echo "{\"continue\": true, \"systemMessage\": \"Formatted $BASENAME with $FORMATTER_USED\"}"
else
  echo '{"continue": true, "suppressOutput": true}'
fi

exit 0
