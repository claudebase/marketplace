# Hooks Guide

Hooks are event-driven automation that execute in response to Claude Code events. The Developer Kit uses hooks for code formatting, security reminders, and session management.

---

## How Hooks Work

1. **Event Trigger**: Claude Code emits an event (e.g., file written)
2. **Matcher Evaluation**: Hook matchers filter which hooks run
3. **Hook Execution**: Matching hooks execute (command, prompt, or agent)
4. **Result Processing**: Exit codes determine success/blocking

---

## Current Hooks

The Developer Kit configures these hooks in `hooks/hooks.json`:

### PostToolUse Hooks

**Trigger**: After successful tool execution

**Configured Hooks**:

| Matcher | Hook | Purpose |
|---------|------|---------|
| `Write\|Edit\|MultiEdit` | `format-file.sh` | Auto-format written files |
| `Write\|Edit\|MultiEdit` | `security_reminder_hook.py` | Security pattern warnings |

```json
{
  "PostToolUse": [
    {
      "matcher": "Write|Edit|MultiEdit",
      "hooks": [
        {
          "type": "command",
          "command": "${CLAUDE_PLUGIN_ROOT}/scripts/format-file.sh",
          "timeout": 15
        },
        {
          "type": "command",
          "command": "python3 ${CLAUDE_PLUGIN_ROOT}/hooks/security_reminder_hook.py"
        }
      ]
    }
  ]
}
```

### PreToolUse Hooks

**Trigger**: Before tool execution

**Configured Hooks**:

| Matcher | Hook | Purpose |
|---------|------|---------|
| `Bash` | `validate-bash-command.sh` | Block dangerous commands |

```json
{
  "PreToolUse": [
    {
      "matcher": "Bash",
      "hooks": [
        {
          "type": "command",
          "command": "${CLAUDE_PLUGIN_ROOT}/scripts/validate-bash-command.sh",
          "timeout": 5
        }
      ]
    }
  ]
}
```

**Blocked Commands**:
- `rm -rf /`
- `rm -rf ~`
- `rm -rf *`
- Other destructive patterns

### SessionStart Hooks

**Trigger**: When session begins (startup or resume)

**Configured Hooks**:

| Matcher | Hook | Purpose |
|---------|------|---------|
| `startup\|resume` | Echo message | Display welcome |
| `startup\|resume` | `restore-session-context.sh` | Restore context |

```json
{
  "SessionStart": [
    {
      "matcher": "startup|resume",
      "hooks": [
        {
          "type": "command",
          "command": "echo 'Developer Kit v4.0.0 | Skills: 24 | Agents: 14 | Commands: 21'",
          "timeout": 5
        },
        {
          "type": "command",
          "command": "${CLAUDE_PLUGIN_ROOT}/scripts/restore-session-context.sh",
          "timeout": 5
        }
      ]
    }
  ]
}
```

### Stop Hooks

**Trigger**: When Claude attempts to stop

**Configured Hooks**:

| Hook | Purpose |
|------|---------|
| `save-session-state.sh` | Persist session state |

```json
{
  "Stop": [
    {
      "hooks": [
        {
          "type": "command",
          "command": "${CLAUDE_PLUGIN_ROOT}/scripts/save-session-state.sh",
          "timeout": 10
        }
      ]
    }
  ]
}
```

---

## Hook Events Reference

| Event | Matcher Support | Input Data |
|-------|-----------------|------------|
| `PreToolUse` | Yes | tool_name, tool_input |
| `PostToolUse` | Yes | tool_name, tool_input, tool_response |
| `PostToolUseFailure` | Yes | tool_name, tool_input, error |
| `PermissionRequest` | Yes | tool_name |
| `UserPromptSubmit` | No | prompt, session_id |
| `Notification` | Yes | message, notification_type |
| `Stop` | No | stop_hook_active |
| `SubagentStop` | No | stop_hook_active |
| `SessionStart` | Yes | source (startup/resume/clear/compact) |
| `SessionEnd` | No | reason (clear/logout/other) |
| `PreCompact` | Yes | trigger (manual/auto) |

---

## Matcher Patterns

Matchers use regex patterns to filter events:

```json
// Exact match
"matcher": "Write"

// Multiple tools (OR)
"matcher": "Write|Edit|MultiEdit"

// Regex pattern
"matcher": "Bash.*"

// MCP tools
"matcher": "mcp__github__.*"

// All events (empty or omitted)
"matcher": ""
```

---

## Hook Types

### Command Hooks

Execute shell commands:

```json
{
  "type": "command",
  "command": "${CLAUDE_PLUGIN_ROOT}/scripts/my-script.sh",
  "timeout": 15
}
```

**Environment Variables**:
- `${CLAUDE_PLUGIN_ROOT}` - Plugin directory path

### Prompt Hooks

LLM-based decision making:

```json
{
  "type": "prompt",
  "prompt": "Evaluate if this change is safe: $ARGUMENTS",
  "timeout": 30
}
```

### Agent Hooks

Invoke an agent for verification:

```json
{
  "type": "agent",
  "agent": "verification-agent",
  "timeout": 60
}
```

---

## Hook Input (stdin)

Hooks receive JSON via stdin:

```json
{
  "session_id": "abc123",
  "transcript_path": "/path/to/session.jsonl",
  "cwd": "/current/working/dir",
  "permission_mode": "default",
  "hook_event_name": "PostToolUse",
  "tool_name": "Write",
  "tool_input": {
    "file_path": "/path/to/file.ts",
    "content": "..."
  },
  "tool_response": "File written successfully"
}
```

---

## Hook Output (Exit Codes)

| Exit Code | Meaning | Effect |
|-----------|---------|--------|
| 0 | Success | Continue normally |
| 2 | Blocking error | Block the action |
| Other | Non-blocking error | Log warning, continue |

### JSON Output Format

Hooks should return JSON for rich feedback:

```json
{
  "status": "success",
  "message": "File formatted successfully",
  "details": {
    "file": "src/api/users.ts",
    "changes": 3
  }
}
```

---

## Writing Custom Hooks

### Shell Script Hook

```bash
#!/bin/bash
# hooks/my-hook.sh

# Read JSON input
INPUT=$(cat)

# Parse with jq
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name')
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# Your logic here
if [[ "$FILE_PATH" == *".env"* ]]; then
    echo '{"status": "blocked", "message": "Cannot modify .env files"}'
    exit 2
fi

echo '{"status": "success"}'
exit 0
```

### Python Hook

```python
#!/usr/bin/env python3
# hooks/my-hook.py

import sys
import json

def main():
    # Read JSON input
    input_data = json.load(sys.stdin)

    tool_name = input_data.get('tool_name', '')
    tool_input = input_data.get('tool_input', {})

    # Your logic here
    if 'password' in str(tool_input).lower():
        print(json.dumps({
            "status": "warning",
            "message": "Detected potential password in code"
        }))
        return 0  # Warning, don't block

    print(json.dumps({"status": "success"}))
    return 0

if __name__ == '__main__':
    sys.exit(main())
```

---

## Hook Configuration

### Adding a New Hook

1. Create hook script in `hooks/` or `scripts/`:

```bash
# scripts/my-custom-hook.sh
#!/bin/bash
INPUT=$(cat)
# ... your logic
echo '{"status": "success"}'
exit 0
```

2. Make executable:
```bash
chmod +x scripts/my-custom-hook.sh
```

3. Add to `hooks/hooks.json`:
```json
{
  "PostToolUse": [
    {
      "matcher": "Write",
      "hooks": [
        {
          "type": "command",
          "command": "${CLAUDE_PLUGIN_ROOT}/scripts/my-custom-hook.sh",
          "timeout": 10
        }
      ]
    }
  ]
}
```

### Modifying Existing Hooks

Edit `hooks/hooks.json`:

```json
{
  "PostToolUse": [
    {
      "matcher": "Write|Edit|MultiEdit",
      "hooks": [
        // Existing hooks...
        {
          "type": "command",
          "command": "${CLAUDE_PLUGIN_ROOT}/scripts/new-hook.sh",
          "timeout": 10
        }
      ]
    }
  ]
}
```

### Disabling a Hook

Remove or comment out in `hooks/hooks.json`:

```json
{
  "PostToolUse": [
    {
      "matcher": "Write|Edit|MultiEdit",
      "hooks": [
        // Disabled: format-file.sh
        // {
        //   "type": "command",
        //   "command": "${CLAUDE_PLUGIN_ROOT}/scripts/format-file.sh"
        // },
        {
          "type": "command",
          "command": "python3 ${CLAUDE_PLUGIN_ROOT}/hooks/security_reminder_hook.py"
        }
      ]
    }
  ]
}
```

---

## Included Hook Scripts

### format-file.sh

**Location**: `scripts/format-file.sh`
**Purpose**: Auto-format files after write operations

**Supported Formatters**:
- Prettier (JS/TS/JSON/CSS/HTML)
- Black (Python)
- rustfmt (Rust)
- gofmt (Go)

### security_reminder_hook.py

**Location**: `hooks/security_reminder_hook.py`
**Purpose**: Warn about security-sensitive patterns

**Detected Patterns**:
- Hardcoded secrets
- SQL string concatenation
- eval() usage
- Unsafe deserialization

### validate-bash-command.sh

**Location**: `scripts/validate-bash-command.sh`
**Purpose**: Block dangerous shell commands

**Blocked Patterns**:
- `rm -rf /`
- `rm -rf ~`
- `:(){ :|:& };:` (fork bomb)
- `> /dev/sda`

### restore-session-context.sh

**Location**: `scripts/restore-session-context.sh`
**Purpose**: Restore session context on startup

**Reads**: `docs/session/current-context.md`

### save-session-state.sh

**Location**: `scripts/save-session-state.sh`
**Purpose**: Save session state on stop

**Writes**: `docs/session/last-session.md`

---

## Testing Hooks

### Test Hook Script Directly

```bash
# Test with sample input
echo '{"tool_name": "Write", "tool_input": {"file_path": "test.ts"}}' | \
  ./scripts/format-file.sh
```

### Verify Hook Loading

```bash
# Check JSON syntax
cat hooks/hooks.json | jq .

# Start Claude with debug
claude --debug
```

### Check Hook Execution

Hooks log to Claude Code's debug output:
```
[hook] PostToolUse: format-file.sh executed (exit: 0)
[hook] PostToolUse: security_reminder_hook.py executed (exit: 0)
```

---

## Troubleshooting

### Hook Not Executing

1. Check matcher pattern matches event
2. Verify script is executable (`chmod +x`)
3. Check timeout isn't too short
4. Verify JSON syntax in hooks.json

### Hook Blocking Unexpectedly

1. Check exit code (2 = block)
2. Review script logic
3. Test script manually with sample input

### Hook Timeout

Increase timeout in hooks.json:
```json
{
  "type": "command",
  "command": "...",
  "timeout": 30  // Increase from default
}
```

---

## Best Practices

1. **Keep hooks fast** - Long hooks slow down Claude
2. **Use appropriate timeouts** - Default is 60s, adjust as needed
3. **Return JSON** - Structured output is easier to process
4. **Handle errors gracefully** - Don't crash on unexpected input
5. **Use exit codes correctly** - 0=success, 2=block, other=warning
6. **Log for debugging** - Write to stderr for debug info
7. **Test independently** - Test scripts before adding to hooks.json
