# Developer Kit v3.1.0 Testing Checklist

Manual verification checklist for v3.1.0 release.

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

## Hooks Testing

### SessionStart
- [ ] Displays "Developer Kit v3.1.0 initialized" message
- [ ] Shows skill and agent counts

### PostToolUse
- [ ] Auto-formats code after Write/Edit
- [ ] Security reminder appears for sensitive files

### PreToolUse
- [ ] Blocks dangerous bash commands (rm -rf /, etc.)

### UserPromptSubmit
- [ ] Hook executes without errors

## Agents Testing

### Architect Agent
- [ ] Activates on "design system architecture"
- [ ] Provides multi-domain coverage (code, backend, frontend, system, devops)

### Code Reviewer Agent
- [ ] Activates on "review this PR"
- [ ] Uses confidence-based filtering (≥80%)

### Security Expert Agent
- [ ] Activates on "security review"
- [ ] Uses security skill

## Integration Testing

### Skill + Command Integration
- [ ] `code-review` uses code-reviewer agent methodology
- [ ] `feature-dev` orchestrates multiple skills/agents

### Agent Integration
- [ ] Architect agent has access to design skill
- [ ] Code reviewer agent performs comprehensive reviews

## Validation Results

Run `./scripts/validate-components.sh` and verify:

- [ ] 0 errors
- [ ] Skills: 22
- [ ] Agents: 14
- [ ] Commands: 16
- [ ] Hook events: 4
- [ ] Skills with triggers: 22/22

## Sign-off

| Tester | Date | Result |
|--------|------|--------|
| | | |

---

*Created for v3.1.0 release validation*
