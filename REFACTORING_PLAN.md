# Developer Kit Refactoring Plan: Remove Multi-Platform Support

## Overview

This document provides a comprehensive step-by-step plan to:
1. **Remove all multi-platform support** (Windows, WSL detection and handling)
2. **Revert all Python scripts back to Bash** (hooks and validation scripts)
3. **Simplify the codebase** to target Unix/macOS only

**Target Platform**: macOS/Linux (Unix-like systems only)

---

## Table of Contents

1. [Current State Analysis](#current-state-analysis)
2. [Files to Remove](#files-to-remove)
3. [Files to Modify](#files-to-modify)
4. [Python to Bash Conversions](#python-to-bash-conversions)
5. [Step-by-Step Implementation](#step-by-step-implementation)
6. [Testing Checklist](#testing-checklist)
7. [Rollback Plan](#rollback-plan)

---

## Current State Analysis

### Multi-Platform Components

| Component | Location | Lines | Purpose |
|-----------|----------|-------|---------|
| Platform Utils Library | `lib/platform_utils.py` | 923 | Core cross-platform abstractions |
| Node.js Runner | `hooks/runner.js` | 74 | Cross-platform Python invoker |
| Platform Instructions Hook | `hooks/platform_instructions_hook.py` | 159 | Platform-specific session instructions |
| Windows Settings Template | `templates/settings/windows-settings.json` | - | Windows configuration |
| WSL Settings Template | `templates/settings/wsl-settings.json` | - | WSL configuration |

### Python Scripts (8 Hooks)

| Script | Lines | Function |
|--------|-------|----------|
| `platform_instructions_hook.py` | 159 | Session start platform detection |
| `validate_bash_command.py` | 143 | PreToolUse dangerous command blocking |
| `security_reminder_hook.py` | 332 | PostToolUse security warnings |
| `format_file_hook.py` | 169 | PostToolUse auto-formatting |
| `validate_env_vars.py` | 127 | Session start env validation |
| `restore_session_context.py` | 150 | Session start context restoration |
| `save_session_state.py` | 173 | Stop hook session persistence |

### Python Scripts (4 Validation Scripts)

| Script | Lines | Function |
|--------|-------|----------|
| `validate.py` | 501 | Unified validation script |
| `validate_delegation.py` | 217 | Delegation compliance validation |
| `ci_tests.py` | 184 | CI-specific tests |
| `test_components.py` | 623 | Comprehensive test suite |

---

## Files to Remove

### Complete Deletion (6 files)

```
developer-kit/
├── lib/
│   ├── __init__.py                    # DELETE
│   └── platform_utils.py              # DELETE (899 lines)
├── hooks/
│   └── runner.js                      # DELETE (74 lines)
└── templates/settings/
    ├── windows-settings.json          # DELETE
    └── wsl-settings.json              # DELETE
```

### Summary
- **Total files to delete**: 5
- **Total lines removed**: ~1,000+

---

## Files to Modify

### Documentation Updates (4 files)

| File | Changes Required |
|------|------------------|
| `/CLAUDE.md` | Remove "Multi-Platform Support" section |
| `/developer-kit/README.md` | Remove Windows/WSL references, platform table, troubleshooting |
| `/developer-kit/CHANGELOG.md` | Add entry for multi-platform removal |
| `/developer-kit/docs/*.md` | Remove Windows-specific instructions |

### Configuration Updates (2 files)

| File | Changes Required |
|------|------------------|
| `hooks/hooks.json` | Change from Node.js runner to direct bash execution |
| `.claude-plugin/plugin.json` | Remove Windows-specific notes (if any) |

---

## Python to Bash Conversions

### Phase 1: Hook Scripts (7 conversions)

Each Python hook must be converted to a Bash script with equivalent functionality.

#### 1. `platform_instructions_hook.py` -> `platform_instructions_hook.sh`

**Current Python Functionality:**
- Detects platform (Windows/macOS/Linux/WSL)
- Outputs platform-specific instructions
- Includes delegation protocol documentation

**Bash Equivalent:**
```bash
#!/bin/bash
# platform_instructions_hook.sh
# SessionStart hook - outputs session instructions

cat << 'EOF'
{"continue": true, "systemMessage": "## Developer Kit Session Instructions

### Platform Rules:
- Use `python3` for Python commands
- Use `pip3` for package management
- Config location: `~/.claude/settings.json`
- Full Unix command compatibility

---

## Command Delegation Protocol (CRITICAL)
[... delegation documentation ...]

### Validation Commands:
- Tests: `bash scripts/test_components.sh`
- Validate: `bash scripts/validate.sh`
"}
EOF
```

#### 2. `validate_bash_command.py` -> `validate_bash_command.sh`

**Current Python Functionality:**
- Reads JSON input from stdin
- Checks for dangerous command patterns (Unix + Windows)
- Outputs permission decisions

**Bash Equivalent:**
```bash
#!/bin/bash
# validate_bash_command.sh
# PreToolUse hook - validates bash commands for safety

# Read JSON input
INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // ""')

# Dangerous patterns (Unix only after refactor)
DANGEROUS_PATTERNS=(
    "rm -rf /"
    "rm -rf /*"
    "rm -rf ~"
    "> /dev/sda"
    "mkfs."
    "dd if=/dev/zero of=/dev"
    ":(){:|:&};:"
    "chmod -R 777 /"
)

# Check patterns
for pattern in "${DANGEROUS_PATTERNS[@]}"; do
    if [[ "$COMMAND" == *"$pattern"* ]]; then
        echo '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Dangerous command blocked"}}'
        exit 0
    fi
done

# Check for sudo
if [[ "$COMMAND" == sudo\ * ]] || [[ "$COMMAND" == *" sudo "* ]]; then
    echo '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"ask","permissionDecisionReason":"Command uses elevated privileges (sudo)"}}'
    exit 0
fi

# Allow by default
echo '{}'
```

#### 3. `security_reminder_hook.py` -> `security_reminder_hook.sh`

**Current Python Functionality:**
- PostToolUse hook for Write/Edit operations
- Checks for security anti-patterns
- Session-scoped warning state

**Bash Equivalent:**
```bash
#!/bin/bash
# security_reminder_hook.sh
# PostToolUse hook - security pattern detection

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.path // ""')

# Skip if no file
[[ -z "$FILE_PATH" ]] && echo '{"continue":true,"suppressOutput":true}' && exit 0

# Security patterns to check
PATTERNS=(
    "eval("
    "exec("
    "shell_exec"
    "os.system"
    "subprocess.call.*shell=True"
)

# Check file content for patterns
if [[ -f "$FILE_PATH" ]]; then
    for pattern in "${PATTERNS[@]}"; do
        if grep -q "$pattern" "$FILE_PATH" 2>/dev/null; then
            echo '{"continue":true,"systemMessage":"[Security] Detected potentially dangerous pattern in edited file"}'
            exit 0
        fi
    done
fi

echo '{"continue":true,"suppressOutput":true}'
```

#### 4. `format_file_hook.py` -> `format_file_hook.sh`

**Current Python Functionality:**
- Auto-formats files after Write/Edit
- Detects file type and uses appropriate formatter
- Supports prettier, black, gofmt, rustfmt

**Bash Equivalent:**
```bash
#!/bin/bash
# format_file_hook.sh
# PostToolUse hook - auto-format files

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.path // ""')

[[ -z "$FILE_PATH" ]] && echo '{"continue":true,"suppressOutput":true}' && exit 0
[[ ! -f "$FILE_PATH" ]] && echo '{"continue":true,"suppressOutput":true}' && exit 0

EXT="${FILE_PATH##*.}"
FORMATTED=""

case ".$EXT" in
    .js|.jsx|.ts|.tsx|.json|.css|.md|.yaml|.yml|.html)
        if command -v prettier &>/dev/null; then
            prettier --write "$FILE_PATH" 2>/dev/null && FORMATTED="prettier"
        elif command -v npx &>/dev/null; then
            npx prettier --write "$FILE_PATH" 2>/dev/null && FORMATTED="prettier"
        fi
        ;;
    .py|.pyi)
        if command -v black &>/dev/null; then
            black --quiet "$FILE_PATH" 2>/dev/null && FORMATTED="black"
        fi
        ;;
    .go)
        if command -v gofmt &>/dev/null; then
            gofmt -w "$FILE_PATH" 2>/dev/null && FORMATTED="gofmt"
        fi
        ;;
    .rs)
        if command -v rustfmt &>/dev/null; then
            rustfmt "$FILE_PATH" 2>/dev/null && FORMATTED="rustfmt"
        fi
        ;;
esac

if [[ -n "$FORMATTED" ]]; then
    echo "{\"continue\":true,\"systemMessage\":\"Formatted $(basename "$FILE_PATH") with $FORMATTED\"}"
else
    echo '{"continue":true,"suppressOutput":true}'
fi
```

#### 5. `validate_env_vars.py` -> `validate_env_vars.sh`

**Current Python Functionality:**
- SessionStart hook
- Checks for required MCP environment variables
- Reports missing keys

**Bash Equivalent:**
```bash
#!/bin/bash
# validate_env_vars.sh
# SessionStart hook - validate environment variables

MISSING=""
SETTINGS_FILE="$HOME/.claude/settings.json"

# Check for required env vars in settings
if [[ -f "$SETTINGS_FILE" ]]; then
    TAVILY=$(jq -r '.env.TAVILY_API_KEY // ""' "$SETTINGS_FILE" 2>/dev/null)
    if [[ -z "$TAVILY" ]] || [[ "$TAVILY" == "your-"* ]]; then
        MISSING="TAVILY_API_KEY"
    fi
fi

if [[ -n "$MISSING" ]]; then
    echo "{\"continue\":true,\"systemMessage\":\"[Warning] Missing API keys: $MISSING\"}"
else
    echo '{"continue":true,"suppressOutput":true}'
fi
```

#### 6. `restore_session_context.py` -> `restore_session_context.sh`

**Current Python Functionality:**
- SessionStart hook
- Reads session state files
- Provides context from previous session

**Bash Equivalent:**
```bash
#!/bin/bash
# restore_session_context.sh
# SessionStart hook - restore previous session context

SESSION_DIR="$HOME/.claude/sessions"
CONTEXT_FILE="$SESSION_DIR/last_context.json"

if [[ -f "$CONTEXT_FILE" ]]; then
    CONTEXT=$(cat "$CONTEXT_FILE" 2>/dev/null)
    if [[ -n "$CONTEXT" ]]; then
        echo "{\"continue\":true,\"systemMessage\":\"Previous session context restored\"}"
        exit 0
    fi
fi

echo '{"continue":true,"suppressOutput":true}'
```

#### 7. `save_session_state.py` -> `save_session_state.sh`

**Current Python Functionality:**
- Stop hook
- Saves session state for next session
- Creates session summary

**Bash Equivalent:**
```bash
#!/bin/bash
# save_session_state.sh
# Stop hook - save session state

SESSION_DIR="$HOME/.claude/sessions"
mkdir -p "$SESSION_DIR"

# Read any session data from stdin
INPUT=$(cat)

# Save basic session info
echo "{\"timestamp\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\"}" > "$SESSION_DIR/last_context.json"

echo '{"continue":true}'
```

### Phase 2: Validation Scripts (4 conversions)

#### 1. `validate.py` -> `validate.sh`

**Bash Equivalent Structure:**
```bash
#!/bin/bash
# validate.sh - Developer Kit validation script

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_DIR="$(dirname "$SCRIPT_DIR")"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

ERRORS=0
WARNINGS=0

# Validation functions
validate_skills() { ... }
validate_agents() { ... }
validate_references() { ... }
validate_frontmatter() { ... }
validate_json_configs() { ... }

# Main execution
main() {
    validate_skills
    validate_agents
    validate_references
    validate_frontmatter
    validate_json_configs

    echo "Errors: $ERRORS | Warnings: $WARNINGS"
    [[ $ERRORS -gt 0 ]] && exit 1
    exit 0
}

main "$@"
```

#### 2. `validate_delegation.py` -> `validate_delegation.sh`

#### 3. `ci_tests.py` -> `ci_tests.sh`

#### 4. `test_components.py` -> `test_components.sh`

---

## Step-by-Step Implementation

### Phase 1: Preparation (1 step)

- [ ] **Step 1.1**: Create backup branch
  ```bash
  git checkout -b backup/pre-refactor-multiplatform
  git push origin backup/pre-refactor-multiplatform
  git checkout main
  git checkout -b refactor/remove-multiplatform
  ```

### Phase 2: Remove Multi-Platform Infrastructure (4 steps)

- [ ] **Step 2.1**: Delete platform utilities library
  ```bash
  rm -rf developer-kit/lib/
  ```

- [ ] **Step 2.2**: Delete Node.js hook runner
  ```bash
  rm developer-kit/hooks/runner.js
  ```

- [ ] **Step 2.3**: Delete Windows/WSL settings templates
  ```bash
  rm developer-kit/templates/settings/windows-settings.json
  rm developer-kit/templates/settings/wsl-settings.json
  ```

- [ ] **Step 2.4**: Rename Unix settings to default
  ```bash
  mv developer-kit/templates/settings/unix-settings.json \
     developer-kit/templates/settings/settings.json
  ```

### Phase 3: Convert Hooks to Bash (7 steps)

- [ ] **Step 3.1**: Convert `platform_instructions_hook.py` to `.sh`
- [ ] **Step 3.2**: Convert `validate_bash_command.py` to `.sh`
- [ ] **Step 3.3**: Convert `security_reminder_hook.py` to `.sh`
- [ ] **Step 3.4**: Convert `format_file_hook.py` to `.sh`
- [ ] **Step 3.5**: Convert `validate_env_vars.py` to `.sh`
- [ ] **Step 3.6**: Convert `restore_session_context.py` to `.sh`
- [ ] **Step 3.7**: Convert `save_session_state.py` to `.sh`

### Phase 4: Update hooks.json (1 step)

- [ ] **Step 4.1**: Update `hooks/hooks.json` to call bash scripts directly
  ```json
  {
    "hooks": {
      "PostToolUse": [
        {
          "matcher": "Write|Edit|MultiEdit",
          "hooks": [
            {
              "type": "command",
              "command": "bash \"${CLAUDE_PLUGIN_ROOT}/hooks/format_file_hook.sh\"",
              "timeout": 15
            },
            {
              "type": "command",
              "command": "bash \"${CLAUDE_PLUGIN_ROOT}/hooks/security_reminder_hook.sh\""
            }
          ]
        }
      ],
      "PreToolUse": [
        {
          "matcher": "Bash",
          "hooks": [
            {
              "type": "command",
              "command": "bash \"${CLAUDE_PLUGIN_ROOT}/hooks/validate_bash_command.sh\"",
              "timeout": 5
            }
          ]
        }
      ],
      "SessionStart": [
        {
          "matcher": "startup|resume",
          "hooks": [
            {
              "type": "command",
              "command": "bash \"${CLAUDE_PLUGIN_ROOT}/hooks/session_instructions_hook.sh\"",
              "timeout": 5
            },
            {
              "type": "command",
              "command": "bash \"${CLAUDE_PLUGIN_ROOT}/hooks/validate_env_vars.sh\"",
              "timeout": 5
            },
            {
              "type": "command",
              "command": "bash \"${CLAUDE_PLUGIN_ROOT}/hooks/restore_session_context.sh\"",
              "timeout": 5
            }
          ]
        }
      ],
      "Stop": [
        {
          "hooks": [
            {
              "type": "command",
              "command": "bash \"${CLAUDE_PLUGIN_ROOT}/hooks/save_session_state.sh\"",
              "timeout": 10
            }
          ]
        }
      ]
    }
  }
  ```

### Phase 5: Convert Validation Scripts (4 steps)

- [ ] **Step 5.1**: Convert `validate.py` to `validate.sh`
- [ ] **Step 5.2**: Convert `validate_delegation.py` to `validate_delegation.sh`
- [ ] **Step 5.3**: Convert `ci_tests.py` to `ci_tests.sh`
- [ ] **Step 5.4**: Convert `test_components.py` to `test_components.sh`

### Phase 6: Update Documentation (4 steps)

- [ ] **Step 6.1**: Update `/CLAUDE.md`
  - Remove "Multi-Platform Support" section
  - Update hooks reference to mention bash

- [ ] **Step 6.2**: Update `/developer-kit/README.md`
  - Remove line 7: `**Multi-Platform Support**: Windows, macOS, Linux, WSL`
  - Remove platform settings table (lines 26-45)
  - Remove Windows PowerShell template instructions
  - Remove Windows-specific notes section (lines 71-77)
  - Remove Windows Troubleshooting section (lines 395-423)
  - Update validation commands to use bash
  - Update directory structure to remove `lib/` and show `.sh` extensions

- [ ] **Step 6.3**: Update `/developer-kit/CHANGELOG.md`
  - Add new version entry documenting the refactor

- [ ] **Step 6.4**: Update any other docs referencing Windows/WSL

### Phase 7: Cleanup Python Files (2 steps)

- [ ] **Step 7.1**: Delete all Python hook files
  ```bash
  rm developer-kit/hooks/*.py
  ```

- [ ] **Step 7.2**: Delete all Python validation scripts
  ```bash
  rm developer-kit/scripts/*.py
  ```

### Phase 8: Update CI/CD (1 step)

- [ ] **Step 8.1**: Update `.github/workflows/*.yml`
  - Remove Windows matrix entries
  - Update script calls from Python to Bash

### Phase 9: Final Testing (4 steps)

- [ ] **Step 9.1**: Run all bash validation scripts
- [ ] **Step 9.2**: Test all hooks fire correctly
- [ ] **Step 9.3**: Run Claude Code with plugin and verify behavior
- [ ] **Step 9.4**: Verify no Python references remain

---

## Testing Checklist

### Hook Testing

| Hook | Event | Test Method | Expected Behavior |
|------|-------|-------------|-------------------|
| `session_instructions_hook.sh` | SessionStart | Start new Claude session | Instructions displayed |
| `validate_bash_command.sh` | PreToolUse | Run `rm -rf /` | Command blocked |
| `validate_bash_command.sh` | PreToolUse | Run `sudo apt update` | Permission asked |
| `security_reminder_hook.sh` | PostToolUse | Edit file with `eval()` | Warning displayed |
| `format_file_hook.sh` | PostToolUse | Edit `.js` file | File formatted |
| `validate_env_vars.sh` | SessionStart | Remove TAVILY_API_KEY | Warning displayed |
| `restore_session_context.sh` | SessionStart | Start after previous session | Context restored |
| `save_session_state.sh` | Stop | End Claude session | State file created |

### Validation Script Testing

| Script | Command | Expected Result |
|--------|---------|-----------------|
| `validate.sh` | `bash scripts/validate.sh` | All validations pass |
| `validate.sh --skills` | `bash scripts/validate.sh --skills` | Skills validated |
| `validate_delegation.sh` | `bash scripts/validate_delegation.sh` | Delegation valid |
| `test_components.sh` | `bash scripts/test_components.sh` | 99+ tests pass |

### Integration Testing

- [ ] Start Claude Code with plugin installed
- [ ] Verify session instructions appear
- [ ] Edit a JavaScript file and confirm formatting
- [ ] Run a dangerous command and confirm blocking
- [ ] End session and verify state saved

---

## Rollback Plan

If issues are discovered after deployment:

```bash
# Restore from backup branch
git checkout backup/pre-refactor-multiplatform
git checkout -b hotfix/restore-multiplatform

# Or revert specific commits
git revert <commit-hash>
```

### Files Requiring Restoration

1. `lib/platform_utils.py`
2. `lib/__init__.py`
3. `hooks/runner.js`
4. `templates/settings/windows-settings.json`
5. `templates/settings/wsl-settings.json`
6. All `hooks/*.py` files
7. All `scripts/*.py` files
8. `hooks/hooks.json` (original version)
9. Documentation files (original versions)

---

## Summary Statistics

### Before Refactoring
- **Python files**: 12
- **Python lines**: ~3,500
- **Platforms supported**: 4 (Windows, macOS, Linux, WSL)
- **Node.js dependencies**: runner.js

### After Refactoring
- **Bash files**: 11
- **Bash lines**: ~800 (estimated)
- **Platforms supported**: 2 (macOS, Linux)
- **Node.js dependencies**: None

### Reduction
- **Lines of code**: ~2,700 fewer lines
- **Dependencies**: Node.js runner eliminated
- **Complexity**: Significantly reduced

---

## Notes

1. **jq Dependency**: Bash scripts require `jq` for JSON parsing. This is standard on macOS (via Homebrew) and most Linux distributions.

2. **Permissions**: All `.sh` files must be made executable:
   ```bash
   chmod +x developer-kit/hooks/*.sh
   chmod +x developer-kit/scripts/*.sh
   ```

3. **Shebang**: All bash scripts should use `#!/bin/bash` (not `#!/bin/sh`) for array support and other bash-specific features.

4. **Error Handling**: Bash scripts should use `set -euo pipefail` for safer execution.

---

**Document Version**: 1.0
**Created**: 2026-01-05
**Author**: Claude Code Refactoring Assistant
