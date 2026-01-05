# Agents Guide

Agents are the **orchestration layer** in Developer Kit's skill-centric architecture. They are specialized domain experts (200-300 lines each) that compose skills and handle complex tasks requiring deep expertise.

> **Architecture**: Agents provide domain expertise and orchestrate multiple skills. Skills contain the core business logic; Agents coordinate their use.

The Developer Kit includes 14 agents.

---

## How Agents Work

1. **Orchestration Layer**: Agents compose and coordinate multiple skills
2. **Domain Expertise**: Each agent brings specialized knowledge to complex tasks
3. **Delegation**: Claude delegates to agents for domain-specific tasks
4. **Separate Context**: Agents run with their own tool access and context
5. **Skill Composition**: Agents reference skills for specialized capabilities
6. **Model Selection**: Each agent specifies its preferred model (sonnet, opus, haiku)

### When Agents Activate

```
User: "Design a microservices architecture for an e-commerce platform"

Claude thinks:
- Complex architecture task
- Requires domain expertise
- Delegates to: architect agent
- Agent uses: design, analyze, security skills
```

### Explicit Invocation

```
"Use the security-expert agent to fix this vulnerability"
```

---

## Agent Categories

| Category                               | Agents | Focus                           |
| -------------------------------------- | ------ | ------------------------------- |
| [Architecture](#architecture-agents)   | 2      | System design, code exploration |
| [Development](#development-agents)     | 3      | Code review, Python, security   |
| [Data & Ops](#data--ops-agents)        | 2      | Database, observability         |
| [Documentation](#documentation-agents) | 3      | Writing, requirements, indexing |
| [Learning](#learning-agents)           | 2      | Teaching, mentoring             |
| [Business](#business-agents)           | 2      | Strategy, session management    |

---

## Architecture Agents

### architect

**Purpose**: Unified architecture agent with domain expertise across code, backend, frontend, system, and devops.

**Domain Modes**:

| Mode     | Triggers                                     | Focus                                 |
| -------- | -------------------------------------------- | ------------------------------------- |
| Code     | "design feature", "implementation blueprint" | Codebase patterns, component design   |
| Backend  | "API design", "database schema"              | Data integrity, security, reliability |
| Frontend | "UI architecture", "component design"        | UX, accessibility, Core Web Vitals    |
| System   | "system architecture", "scalability"         | Component boundaries, 10x growth      |
| DevOps   | "CI/CD", "infrastructure"                    | Automation, observability             |

**Process**:

1. Analyze context (existing patterns, tech stack)
2. Design architecture (decisive choices, trade-offs)
3. Deliver blueprint (components, phases, operations)

**Output Format**:

```markdown
## Architecture Blueprint

### Context Analysis

- Existing patterns found
- Technology stack and constraints

### Architecture Decision

- Chosen approach with rationale
- Trade-offs accepted

### Component Design

- File paths and locations
- Responsibilities and interfaces

### Implementation Plan

- [ ] Phase 1: Foundation
- [ ] Phase 2: Core implementation
- [ ] Phase 3: Integration
```

**Tools**: Read, Grep, Glob, Write, Bash, Task, Sequential Thinking, Context7, Playwright

**Skills**: design, analyze, security, devops, implement

---

### code-explorer

**Purpose**: Deep analysis of existing codebase features.

**Capabilities**:

- Execution path tracing
- Architecture layer mapping
- Pattern and abstraction identification
- Dependency documentation

**When to Use**:

- Understanding unfamiliar codebases
- Tracing feature implementations
- Mapping component relationships
- Preparing for modifications

**Example**:

```
"Explore how the authentication system works in this codebase"
```

**Tools**: Glob, Grep, LS, Read, NotebookRead, WebFetch, TodoWrite, WebSearch

---

## Development Agents

### code-reviewer

**Purpose**: Comprehensive code review with confidence-based filtering.

**Key Feature**: Only reports issues with **≥80% confidence** to minimize false positives.

**Review Scope**:

- Default: `git diff` (unstaged changes)
- Options: PR URL, specific files, `--strict` (90% threshold)

**Confidence Scoring**:

| Score  | Meaning               |
| ------ | --------------------- |
| 0-25   | Likely false positive |
| 26-50  | Real but minor        |
| 51-75  | Important issue       |
| 76-100 | Critical, verified    |

**What It Checks**:

- Project guidelines compliance
- Logic errors and bugs
- Security vulnerabilities
- Code quality issues
- Test coverage

**Output Format**:

```markdown
### Code Review

Found 2 issues:

1. **SQL Injection Risk** (Confidence: 95%)
   - File: `src/api/search.ts:42`
   - Guideline: CLAUDE.md says "Use parameterized queries"
   - Fix: Replace string concatenation with prepared statement

2. **Missing Error Handling** (Confidence: 82%)
   - File: `src/api/users.ts:88`
   - Bug: API call has no try/catch
   - Fix: Add error handling with appropriate status codes
```

**Tools**: Glob, Grep, Read, Bash, WebFetch, TodoWrite, WebSearch

---

### python-expert

**Purpose**: Production-ready Python development following SOLID principles.

**Expertise**:

- Modern Python best practices
- Type annotations and validation
- Testing strategies (pytest)
- Performance optimization
- Security considerations

**When to Use**:

- Python-specific implementation
- Code review for Python projects
- Performance optimization
- Best practice guidance

**Tools**: Read, Grep, Glob, Write, Edit, Bash, Sequential Thinking, Context7, Playwright

---

### security-expert

**Purpose**: Security implementation and hardening. **CAN modify code** (unlike security skill).

**Capabilities**:

- Implement security fixes
- Add authentication/authorization
- Harden configurations
- Address OWASP concerns
- Secrets management

**Difference from Security Skill**:

| Component               | Can Modify Code | Use For                  |
| ----------------------- | --------------- | ------------------------ |
| `security` skill        | No (read-only)  | Auditing, finding issues |
| `security-expert` agent | **Yes**         | Fixing vulnerabilities   |

**When to Use**:

```
# First: Audit with skill
"security audit the authentication module"

# Then: Fix with agent
"use security-expert to fix the SQL injection vulnerability"
```

**Tools**: Read, Grep, Glob, Write, Edit, Bash, Task, Sequential Thinking

---

## Data & Ops Agents

### database-admin

**Purpose**: Expert database administration for schema design, query optimization, and operations.

**Expertise**:

- Schema design patterns
- Query optimization
- Index strategies
- Migration planning
- Performance tuning

**Database Support**:

- PostgreSQL
- MySQL
- MongoDB
- Redis
- SQLite

**When to Use**:

- Complex schema design
- Query performance issues
- Migration planning
- Database architecture decisions

**Tools**: Read, Grep, Glob, Write, Edit, Bash, Task, Sequential Thinking

---

### observability-engineer

**Purpose**: Logging, monitoring, alerting, and distributed tracing.

**Expertise**:

- Structured logging
- Metrics collection
- Alert rule design
- Dashboard creation
- Distributed tracing

**Stack Knowledge**:

- Prometheus/Grafana
- ELK Stack
- OpenTelemetry
- Datadog
- CloudWatch

**When to Use**:

- Setting up monitoring
- Creating dashboards
- Designing alert strategies
- Implementing tracing

**Tools**: Read, Grep, Glob, Write, Edit, Bash, Task, Sequential Thinking

---

## Documentation Agents

### technical-writer

**Purpose**: Clear, comprehensive technical documentation.

**Document Types**:

- API documentation
- User guides
- Technical specifications
- README files
- Architecture docs

**Approach**:

- Audience-focused writing
- Clear structure
- Practical examples
- Accessibility considerations

**When to Use**:

- Creating new documentation
- Improving existing docs
- API documentation
- User-facing guides

**Tools**: Read, Grep, Glob, Write, Sequential Thinking, Context7

---

### requirements-analyst

**Purpose**: Transform ambiguous ideas into concrete specifications.

**Capabilities**:

- Requirements gathering
- Specification writing
- Scope definition
- Stakeholder analysis
- PRD creation

**Output**:

- Product Requirements Documents
- User stories
- Acceptance criteria
- Scope definitions

**When to Use**:

- Starting new projects
- Defining features
- Clarifying requirements
- Writing specifications

**Tools**: Read, Grep, Glob, Write, Sequential Thinking

---

### repo-index

**Purpose**: Repository indexing and codebase briefing.

**Capabilities**:

- Project structure analysis
- Codebase exploration
- Index generation
- Component cataloging

**Output**:

- Project structure overview
- Component relationships
- Entry point identification
- Technology stack summary

**When to Use**:

- Onboarding to new codebase
- Creating project documentation
- Understanding large codebases

**Tools**: Read, Grep, Glob, Write

---

## Learning Agents

### socratic-mentor

**Purpose**: Educational guidance through Socratic questioning.

**Approach**:

- Strategic questioning
- Discovery learning
- Guided exploration
- No direct answers (leads to understanding)

**When to Use**:

- Learning new concepts
- Understanding code deeply
- Developing problem-solving skills
- Mentored exploration

**Tools**: Read, Grep, Glob, Write, Sequential Thinking, Context7

---

### learning-guide

**Purpose**: Teaching programming concepts with focus on understanding.

**Capabilities**:

- Tutorial creation
- Concept explanations
- Learning path design
- Practical examples

**Approach**:

- Progressive complexity
- Hands-on examples
- Clear explanations
- Practice exercises

**When to Use**:

- Learning new technologies
- Understanding concepts
- Skill development
- Educational content creation

**Tools**: Read, Grep, Glob, Write, Sequential Thinking, Context7

---

## Business Agents

### business-panel-experts

**Purpose**: Multi-expert business strategy panel.

**Expert Perspectives**:

| Expert              | Framework                 |
| ------------------- | ------------------------- |
| Clayton Christensen | Disruptive Innovation     |
| Michael Porter      | Competitive Strategy      |
| Peter Drucker       | Management Principles     |
| Seth Godin          | Marketing & Remarkability |
| Kim & Mauborgne     | Blue Ocean Strategy       |
| Jim Collins         | Good to Great             |
| Nassim Taleb        | Antifragility             |
| Donella Meadows     | Systems Thinking          |
| Jean-luc Doumont    | Communication Clarity     |

**Modes**:

- Discussion: Multiple perspectives
- Debate: Contrasting viewpoints
- Socratic: Guided inquiry

**When to Use**:

- Strategic planning
- Market analysis
- Business model evaluation
- Competitive analysis

**Tools**: Read, Grep, Glob, Write, Task, WebSearch, Sequential Thinking, Tavily

---

### pm-agent

**Purpose**: Session management and knowledge base maintenance.

**Capabilities**:

- Session tracking
- Learning capture
- Progress documentation
- PDCA workflow execution

**Features**:

- Cross-session memory (via Memory MCP)
- Pattern retention
- Decision logging
- Progress tracking

**When to Use**:

- Long-running projects
- Knowledge management
- Session continuity
- Learning documentation

**Tools**: Read, Grep, Glob, Write, Edit, TodoWrite, Sequential Thinking, Context7, Memory MCP

---

## Agent Comparison

### By Capability

| Agent            | Can Write Code    | Domain        |
| ---------------- | ----------------- | ------------- |
| architect        | Yes               | Architecture  |
| code-reviewer    | No (reviews only) | Quality       |
| security-expert  | **Yes**           | Security      |
| database-admin   | Yes               | Data          |
| python-expert    | Yes               | Python        |
| technical-writer | Yes (docs)        | Documentation |
| code-explorer    | No (analysis)     | Understanding |

### By Use Case

| Need                         | Agent                  |
| ---------------------------- | ---------------------- |
| Design system architecture   | architect              |
| Review code changes          | code-reviewer          |
| Fix security vulnerabilities | security-expert        |
| Optimize database queries    | database-admin         |
| Write Python code            | python-expert          |
| Create documentation         | technical-writer       |
| Understand codebase          | code-explorer          |
| Learn new concepts           | learning-guide         |
| Strategic analysis           | business-panel-experts |

---

## Adding New Agents

1. Create `agents/my-agent.md`:

```yaml
---
name: my-agent
description: "What this agent does and when to invoke it"
tools: Read, Grep, Glob, Write, Edit, Bash
model: sonnet
---
# My Agent

Agent instructions and methodology...
```

2. Required frontmatter:
   - `name`: Unique identifier
   - `description`: Purpose and triggers
   - `tools`: Comma-separated tool list

3. Optional frontmatter:
   - `model`: sonnet (default), opus, haiku
   - `permissionMode`: default, plan, acceptEdits
   - `skills`: Comma-separated skill names

4. Validate:

```bash
./scripts/validate.sh
```

---

## Agent vs Skill vs Command

| Component   | Invocation | Context  | Best For          |
| ----------- | ---------- | -------- | ----------------- |
| **Skill**   | Automatic  | Shared   | Core capabilities |
| **Agent**   | Delegated  | Separate | Domain expertise  |
| **Command** | Explicit   | Shared   | Quick workflows   |
