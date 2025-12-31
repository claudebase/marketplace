# Skill Trigger Phrase Reference

Quick reference for skill activation phrases. All skills use "Activates for:" triggers in their descriptions.

## Analysis & Review

| Skill                | Primary Triggers                                                                                                                                                                                           |
| -------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **analyze**          | "analyze this code", "code analysis", "review for bugs", "check code quality", "assess architecture", "what's wrong with this code"                                                                        |
| **security**         | "security audit", "find vulnerabilities", "OWASP check", "threat model", "security review", "is this secure"                                                                                               |
| **performance**      | "why is this slow", "find bottlenecks", "profile performance", "optimize speed", "improve response time"                                                                                                   |
| **quality**          | "design tests for", "test strategy", "improve coverage", "what tests needed", "how should I test"                                                                                                          |
| **verify**           | "verify this works", "prove it's fixed", "show me evidence", "confirm implementation", "test before commit", "review my changes", "check before commit", "self-review", "ready to commit", "check my work" |
| **confidence-check** | "am I ready to implement", "check my confidence", "verify before coding", "pre-implementation check"                                                                                                       |

## Research & Discovery

| Skill          | Primary Triggers                                                                                                         |
| -------------- | ------------------------------------------------------------------------------------------------------------------------ |
| **research**   | "research [topic]", "find information about", "look up", "search for", "what's the latest on", "find docs for [library]" |
| **brainstorm** | "I want to build", "thinking about", "maybe we could", "not sure how to", "explore ideas", "help me figure out"          |
| **explain**    | "what does this do", "how does this work", "explain this code", "teach me about", "help me understand"                   |

## Design & Implementation

| Skill         | Primary Triggers                                                                                                    |
| ------------- | ------------------------------------------------------------------------------------------------------------------- |
| **design**    | "design a system", "architect this", "create API spec", "design database", "component design", "plan architecture"  |
| **implement** | "implement", "create", "build feature", "add functionality", "code this", "make a", "develop"                       |
| **improve**   | "improve this code", "optimize this", "refactor", "make this better", "enhance performance", "clean up code"        |
| **frontend**  | "create component", "build UI", "design interface", "React component", "Vue component", "landing page", "dashboard" |

## Debugging & Troubleshooting

| Skill     | Primary Triggers                                                                                                                                                                                                                                                     |
| --------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **debug** | "fix this bug", "debug this", "why is this crashing", "build failing", "resolve error", "not working", "deep debugging", "complex bug", "hard to find bug", "thorough investigation", "bug keeps coming back", "why does this keep happening", "find the root cause" |

## Infrastructure & DevOps

| Skill             | Primary Triggers                                                                                                 |
| ----------------- | ---------------------------------------------------------------------------------------------------------------- |
| **database**      | "design database schema", "optimize query", "create migration", "SQL help", "PostgreSQL", "MySQL", "MongoDB"     |
| **containers**    | "create Dockerfile", "docker compose", "containerize app", "Kubernetes manifest", "k8s deployment", "Helm chart" |
| **observability** | "add logging", "setup monitoring", "create alerts", "add metrics", "distributed tracing", "build dashboard"      |
| **devops**        | "build", "test", "run tests", "commit", "git status", "cleanup", "CI/CD"                                         |
| **migration**     | "migrate database", "data migration", "upgrade API", "deprecate endpoint", "breaking change", "zero-downtime"    |

## Coordination & Documentation

| Skill                   | Primary Triggers                                                                                               |
| ----------------------- | -------------------------------------------------------------------------------------------------------------- |
| **orchestration**       | "spawn", "orchestrate", "break down", "coordinate", "manage tasks", "multi-step operations"                    |
| **document**            | "document this", "create API docs", "generate README", "add documentation", "write JSDoc", "create user guide" |
| **sequential-thinking** | "think through this", "step by step", "break down problem", "analyze systematically", "complex reasoning"      |

## Usage Tips

1. **Be specific**: "security audit this code" is clearer than just "check this"
2. **Use keywords**: Include trigger words in your request
3. **Combine skills**: Some tasks may activate multiple skills
4. **Override with skill name**: Say "use the [skill] skill" to explicitly invoke

## Skill Count

- **Total skills**: 24
- **Read-only skills**: analyze, security, performance, quality, verify (marked READ-ONLY)
- **Write-enabled skills**: implement, improve, debug, design, document, database, containers, etc.
