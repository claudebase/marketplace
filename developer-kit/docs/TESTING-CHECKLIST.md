# Developer Kit v7.0.0 Testing Checklist

Manual verification checklist for v7.0.0 release.

## Skills Testing

### Research Skill
- [ ] `research [topic]` activates research skill
- [ ] `--docs` mode: `find docs for React` triggers documentation mode
- [ ] `--web` mode works for general web research
- [ ] Context7 integration works for library docs

### Analysis Skills
- [ ] `analyze this code` activates analyze skill
- [ ] `security audit` activates security skill
- [ ] `optimize this` activates performance skill
- [ ] `improve test coverage` activates quality skill

### Development Skills
- [ ] `implement [feature]` activates implement skill
- [ ] `refactor this` activates improve skill
- [ ] `debug this` activates debug skill

### Infrastructure Skills
- [ ] `docker` triggers containers skill
- [ ] `database schema` triggers database skill
- [ ] `CI/CD pipeline` triggers devops skill
- [ ] `logging setup` triggers observability skill

## Commands Testing

### Delegating Commands
- [ ] `code-review` invokes code-reviewer agent
- [ ] `estimate` delegates to orchestration skill
- [ ] `changelog` delegates to document skill
- [ ] `index` delegates to research skill
- [ ] `recommend` delegates to research skill
- [ ] `feature-dev` delegates to orchestration skill
- [ ] `migrate` delegates to migration skill
- [ ] `reflect` delegates to document skill

### Non-Delegating Commands
- [ ] `agent` starts guided session
- [ ] `build` executes build workflow
- [ ] `git` provides git assistance
- [ ] `release` handles release workflow
- [ ] `ship` completes release workflow
- [ ] `start` initializes feature development
- [ ] `check` runs validation suite
- [ ] `prep-pr` prepares pull request

## Hooks Testing

### SessionStart
- [ ] `session_instructions_hook.sh` executes without error
- [ ] `validate_env_vars.sh` checks for required API keys
- [ ] `restore_session_context.sh` restores context

### PostToolUse
- [ ] `format_file_hook.sh` auto-formats code after Write/Edit
- [ ] `security_reminder_hook.sh` warns about sensitive patterns

### PreToolUse
- [ ] `validate_bash_command.sh` blocks dangerous commands (rm -rf /, etc.)

### Stop
- [ ] `save_session_state.sh` saves session state

## Agents Testing

### Architect Agent
- [ ] Activates on "design system architecture"
- [ ] Provides multi-domain coverage (code, backend, frontend, system, devops)

### Code Reviewer Agent
- [ ] Activates on "review this PR"
- [ ] Uses confidence-based filtering (>=80%)

### Security Expert Agent
- [ ] Activates on "security review"
- [ ] Can modify code (unlike read-only security skill)

## Integration Testing

### Skill + Command Integration
- [ ] `code-review` uses code-reviewer agent methodology
- [ ] `feature-dev` orchestrates multiple skills/agents

### Agent Integration
- [ ] Architect agent has access to design skill
- [ ] Code reviewer agent performs comprehensive reviews

## Validation Results

Run `bash scripts/test_components.sh` and verify:

- [ ] All 84+ tests pass
- [ ] Skills: 24
- [ ] Agents: 14
- [ ] Commands: 21
- [ ] Hooks: 7 (all executable)

Run `bash scripts/validate.sh` and verify:

- [ ] 0 errors
- [ ] 0 warnings

## Sign-off

| Tester | Date | Result |
|--------|------|--------|
| | | |

---

*Updated for v7.0.0 release validation*
