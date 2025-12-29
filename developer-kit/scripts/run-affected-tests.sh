#!/bin/bash
# run-affected-tests.sh - PostToolUse hook to run tests for modified files
# Returns JSON response per Claude Code hook specification
#
# NOTE: This hook is optional and can be resource-intensive for large projects.
# Enable by adding to hooks.json if desired.

set -e

# Read input from stdin
INPUT=$(cat)

# Extract file path from tool input
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.path // empty' 2>/dev/null)

# Exit early if no file path
if [ -z "$FILE_PATH" ]; then
    echo '{"continue": true, "suppressOutput": true}'
    exit 0
fi

# Skip non-source files
EXTENSION="${FILE_PATH##*.}"
case "$EXTENSION" in
    md|json|yml|yaml|txt|env|gitignore|lock)
        echo '{"continue": true, "suppressOutput": true}'
        exit 0
        ;;
esac

# Get directory and basename
DIR=$(dirname "$FILE_PATH")
BASENAME=$(basename "$FILE_PATH" ".$EXTENSION")

# Common test file patterns by language
TEST_PATTERNS=()

case "$EXTENSION" in
    js|jsx|ts|tsx)
        TEST_PATTERNS=(
            "${DIR}/${BASENAME}.test.${EXTENSION}"
            "${DIR}/${BASENAME}.spec.${EXTENSION}"
            "${DIR}/__tests__/${BASENAME}.test.${EXTENSION}"
            "${DIR}/__tests__/${BASENAME}.spec.${EXTENSION}"
        )
        ;;
    py)
        TEST_PATTERNS=(
            "${DIR}/test_${BASENAME}.py"
            "${DIR}/${BASENAME}_test.py"
            "${DIR}/../tests/test_${BASENAME}.py"
            "${DIR}/tests/test_${BASENAME}.py"
        )
        ;;
    go)
        TEST_PATTERNS=(
            "${DIR}/${BASENAME}_test.go"
        )
        ;;
    rs)
        # Rust tests are typically in the same file
        TEST_PATTERNS=(
            "$FILE_PATH"
        )
        ;;
    rb)
        TEST_PATTERNS=(
            "${DIR}/../spec/${BASENAME}_spec.rb"
            "${DIR}/spec/${BASENAME}_spec.rb"
        )
        ;;
esac

# Function to run tests and capture result
run_test() {
    local test_file="$1"
    local result=""

    case "$EXTENSION" in
        js|jsx|ts|tsx)
            # Try Jest first, then npm test
            if command -v npx &> /dev/null; then
                if npx jest --passWithNoTests --findRelatedTests "$FILE_PATH" 2>/dev/null; then
                    result="passed"
                else
                    result="failed"
                fi
            fi
            ;;
        py)
            if command -v pytest &> /dev/null; then
                if pytest "$test_file" -v --tb=short 2>/dev/null; then
                    result="passed"
                else
                    result="failed"
                fi
            fi
            ;;
        go)
            if command -v go &> /dev/null; then
                local pkg_dir=$(dirname "$FILE_PATH")
                if go test -v "$pkg_dir" 2>/dev/null; then
                    result="passed"
                else
                    result="failed"
                fi
            fi
            ;;
        rs)
            if command -v cargo &> /dev/null; then
                if cargo test 2>/dev/null; then
                    result="passed"
                else
                    result="failed"
                fi
            fi
            ;;
        rb)
            if command -v bundle &> /dev/null; then
                if bundle exec rspec "$test_file" 2>/dev/null; then
                    result="passed"
                else
                    result="failed"
                fi
            fi
            ;;
    esac

    echo "$result"
}

# Find and run matching test
for pattern in "${TEST_PATTERNS[@]}"; do
    if [ -f "$pattern" ]; then
        TEST_RESULT=$(run_test "$pattern")

        BASENAME_DISPLAY=$(basename "$FILE_PATH")

        if [ "$TEST_RESULT" = "passed" ]; then
            echo "{\"continue\": true, \"systemMessage\": \"Tests passed for $BASENAME_DISPLAY\"}"
        elif [ "$TEST_RESULT" = "failed" ]; then
            echo "{\"continue\": true, \"systemMessage\": \"Tests FAILED for $BASENAME_DISPLAY - review needed\"}"
        else
            # Test runner not available
            echo '{"continue": true, "suppressOutput": true}'
        fi
        exit 0
    fi
done

# No test file found
echo '{"continue": true, "suppressOutput": true}'
exit 0
