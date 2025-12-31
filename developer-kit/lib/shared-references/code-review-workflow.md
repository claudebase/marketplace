# Code Review Workflow

## GitHub PR Review Process

```yaml
1. Parse PR Reference:
  - Extract owner, repo, pull_number from URL or reference
  - Example: github.com/org/repo/pull/123 → org, repo, 123

2. Fetch PR Context:
  - mcp__github__get_pull_request(owner, repo, pull_number)
  - Check: PR is open, not draft, not automated bot PR
  - Read: PR description, labels, linked issues

3. Get Changed Files:
  - mcp__github__get_pull_request_files(owner, repo, pull_number)
  - Group files by type/framework
  - Prioritize: source code > tests > config

4. Framework Detection:
  - Analyze file extensions and imports
  - mcp__context7__resolve-library-id for each framework
  - Fetch relevant best practices

5. Review Each File:
  - Read full file content
  - Focus on changed lines (additions and modifications)
  - Apply framework-specific checklist
  - Score issues with confidence levels

6. Compile Review:
  - Group issues by severity (Critical → Important → Minor)
  - Filter to ≥80% confidence (≥90% with --strict)
  - Generate actionable fix suggestions

7. Submit Review (if requested):
  - mcp__github__create_pull_request_review()
  - event: APPROVE if no issues, REQUEST_CHANGES if critical, COMMENT otherwise
  - Include inline comments with line numbers
```

## Local Diff Review Process

```yaml
1. Gather Context:
  - Find CLAUDE.md and project guidelines
  - Check .eslintrc, .prettierrc, tsconfig.json
  - Review package.json for framework detection
  - git log --oneline -10 for recent history

2. Get Changes:
  - git diff for unstaged changes
  - git diff --staged for staged changes
  - git diff HEAD~1 for last commit

3. Review Changes:
  - Focus only on modified lines
  - Apply framework-specific patterns
  - Score with confidence levels

4. Report Findings:
  - List issues with file:line references
  - Include fix suggestions
  - Provide verification commands
```

## Review Focus Modes

### Security (--focus security)

```yaml
Checks:
  - SQL/NoSQL injection vectors
  - XSS vulnerabilities (unescaped output)
  - CSRF protection
  - Authentication/authorization flaws
  - Sensitive data exposure
  - Insecure dependencies
```

### Performance (--focus performance)

```yaml
Checks:
  - N+1 query patterns
  - Unnecessary re-renders (React)
  - Missing memoization
  - Large bundle imports
  - Unoptimized loops
  - Memory leaks
```

### Accessibility (--focus a11y)

```yaml
Checks:
  - Missing alt text on images
  - Improper heading hierarchy
  - Missing ARIA attributes
  - Color contrast issues
  - Keyboard navigation support
  - Screen reader compatibility
```

## False Positive Prevention

**Do NOT flag:**

- Pre-existing issues (only review the diff)
- Issues linter/typechecker would catch
- Lines user didn't modify
- Pedantic nitpicks (unless --strict)
- Framework patterns that are valid alternatives

**Before flagging, ask:**

- Is this actually in the changed lines?
- Would this cause real problems in practice?
- Does Context7 confirm this is an anti-pattern?
- Am I above 80% confident?

## Receiving Feedback Protocol

When receiving review feedback on YOUR code:

```
READ → UNDERSTAND → VERIFY → EVALUATE → RESPOND → IMPLEMENT
```

- ❌ No performative agreement: "You're absolutely right!"
- ❌ No implementation before verification
- ✅ Restate requirement, ask questions, or push back with reasoning
- ✅ If unclear: STOP and ask for clarification first
