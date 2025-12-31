# Skill Trigger Phrase Reference

Quick reference for skill activation. Skills use "This skill should be used when the user asks to..." patterns for reliable triggering.

## Triggering Mechanism

Skills are triggered via semantic matching against their YAML frontmatter descriptions. Strong descriptions use:

1. **Imperative Pattern**: `MUST USE for: '[trigger]'` - Forces action
2. **Trigger List Pattern**: `Triggers: 'phrase1', 'phrase2', ...` - Clear matching
3. **Negative Pattern**: `DO NOT use [tool] directly` - Prevents bypass
4. **Value Pattern**: `Provides X that direct tools cannot` - Explains why

## Analysis & Review

| Skill                | Trigger Phrases                                                                     |
| -------------------- | ----------------------------------------------------------------------------------- |
| **analyze**          | 'analyze this code', 'review for bugs', 'check code quality', 'assess architecture' |
| **security**         | 'check security', 'find vulnerabilities', 'security review', 'is this secure'       |
| **performance**      | 'why is this slow', 'find bottlenecks', 'profile performance', 'optimize speed'     |
| **quality**          | 'design tests for', 'create test strategy', 'improve coverage', 'what tests needed' |
| **verify**           | 'verify this works', 'check before commit', 'self-review', 'ready to commit'        |
| **confidence-check** | 'am I ready to implement', 'check my confidence', 'verify before coding'            |
| **a11y**             | 'accessibility', 'a11y', 'WCAG compliance', 'screen reader', 'keyboard navigation'  |

## Research & Discovery

| Skill          | Trigger Phrases                                                                                                     |
| -------------- | ------------------------------------------------------------------------------------------------------------------- |
| **research**   | 'find information', 'research', 'look up', 'search for', 'what is', 'tell me about', 'find docs', 'how does X work' |
| **brainstorm** | 'I want to build', 'thinking about', 'maybe we could', 'not sure how to' (auto)                                     |
| **explain**    | 'what does this do', 'how does this work', 'explain this', 'teach me about'                                         |

## Design & Implementation

| Skill         | Trigger Phrases                                                                       |
| ------------- | ------------------------------------------------------------------------------------- |
| **design**    | 'design a system', 'architect this', 'create API spec', 'design database'             |
| **implement** | 'implement', 'create', 'build', 'develop', 'code this', 'add functionality' (auto)    |
| **improve**   | 'improve this code', 'optimize this', 'refactor', 'make this better', 'clean up code' |
| **frontend**  | 'create component', 'build UI', 'design interface', 'React component', 'landing page' |

## Debugging & Testing

| Skill     | Trigger Phrases                                                                           |
| --------- | ----------------------------------------------------------------------------------------- |
| **debug** | 'fix this bug', 'debug this', 'why is this failing', 'troubleshoot', 'not working' (auto) |
| **test**  | 'run tests', 'test coverage', 'what tests are missing', 'test this', 'run test suite'     |

## Infrastructure & DevOps

| Skill             | Trigger Phrases                                                                      |
| ----------------- | ------------------------------------------------------------------------------------ |
| **database**      | 'design database schema', 'optimize query', 'create migration', 'SQL help'           |
| **containers**    | 'create Dockerfile', 'docker compose', 'containerize app', 'Kubernetes manifest'     |
| **observability** | 'add logging', 'setup monitoring', 'create alerts', 'add metrics', 'build dashboard' |
| **devops**        | 'build', 'run tests', 'commit', 'git status', 'cleanup', 'CI/CD'                     |
| **migration**     | 'migrate database', 'data migration', 'upgrade API', 'deprecate endpoint'            |

## Coordination & Documentation

| Skill                   | Trigger Phrases                                                                      |
| ----------------------- | ------------------------------------------------------------------------------------ |
| **orchestration**       | 'orchestrate', 'break down', 'coordinate', 'manage tasks', 'multi-step operations'   |
| **document**            | 'document this', 'create API docs', 'generate README', 'add documentation'           |
| **sequential-thinking** | 'think through this', 'step by step', 'break down problem', 'analyze systematically' |

## Usage Tips

1. **Natural language works**: Skills use semantic matching, not exact keywords
2. **Be direct**: "find information about X" triggers research skill automatically
3. **Override with skill name**: Say "use the [skill] skill" or "/[skill]" to explicitly invoke
4. **Auto-invoke skills**: Some skills (implement, debug, brainstorm) trigger proactively
5. **Strong descriptions**: Skills with MUST USE and DO NOT patterns trigger more reliably

## Skill Count

- **Total skills**: 24
- **Read-only skills**: analyze, security, performance, quality, verify, a11y, explain (marked READ-ONLY)
- **Write-enabled skills**: implement, improve, debug, design, document, database, containers, etc.
- **Proactive skills**: implement, debug, brainstorm (auto-invoke on matching patterns)
- **High-priority skills**: security (PROACTIVELY activates for security-related requests)
