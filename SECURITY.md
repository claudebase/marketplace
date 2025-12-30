# Security Policy

## Supported Versions

We release patches for security vulnerabilities in the following versions:

| Version | Supported          |
| ------- | ------------------ |
| 4.x.x   | :white_check_mark: |
| < 4.0   | :x:                |

**Note**: We strongly recommend always using the latest version of the Developer Kit plugin to ensure you have the latest security patches and improvements.

## Reporting a Vulnerability

**Please do not report security vulnerabilities through public GitHub issues.**

Instead, please report them privately using one of the following methods:

### GitHub Security Advisories (Preferred)

1. Go to the [Security Advisories](https://github.com/claudebase/marketplace/security/advisories) page
2. Click "Report a vulnerability"
3. Fill out the form with details about the vulnerability

### Email

Alternatively, you can email security concerns to:
- **Email**: [Your security contact email - replace this]
- **Subject**: [SECURITY] Brief description of the vulnerability

### What to Include

Please include the following information in your report:

- **Type of vulnerability** (e.g., code injection, information disclosure, etc.)
- **Component affected** (e.g., specific skill, agent, hook, MCP server)
- **Step-by-step instructions** to reproduce the issue
- **Potential impact** of the vulnerability
- **Suggested fix** (if you have one)
- **Any proof-of-concept code** (if applicable)

## Response Timeline

- **Initial Response**: Within 48 hours
- **Status Update**: Within 7 days
- **Fix Timeline**: Depends on severity
  - Critical: 1-7 days
  - High: 7-14 days
  - Medium: 14-30 days
  - Low: 30-90 days

## Security Update Process

1. **Acknowledgment**: We'll acknowledge receipt of your vulnerability report
2. **Assessment**: We'll assess the severity and impact
3. **Fix Development**: We'll develop and test a fix
4. **Disclosure**: We'll coordinate disclosure with you
5. **Release**: We'll release a security update
6. **Credit**: We'll credit you in the security advisory (unless you prefer to remain anonymous)

## Security Best Practices for Users

### API Keys and Secrets

**Never commit API keys or secrets to the repository.**

The Developer Kit uses several MCP servers that may require API keys:

- **Tavily API** - For web search functionality
- **GitHub Token** - For GitHub integration
- **Other MCP servers** - May require additional credentials

**Recommended practices:**

1. Store API keys in environment variables
2. Use `.env` files (add to `.gitignore`)
3. Use the `${VAR}` syntax in `.mcp.json` configuration
4. Review `.mcp.json` before committing to ensure no hardcoded secrets

Example safe configuration:
```json
{
  "tavily": {
    "command": "uvx",
    "args": ["mcp-server-tavily"],
    "env": {
      "TAVILY_API_KEY": "${TAVILY_API_KEY}"
    }
  }
}
```

### Hook Security

Hooks execute Python scripts on various events. Be cautious when:

- Installing third-party plugins with custom hooks
- Modifying hook scripts from untrusted sources
- Granting hooks access to sensitive data

**Review hooks before enabling:**
```bash
# Check what hooks are configured
cat developer-kit/hooks/hooks.json

# Review hook scripts
cat developer-kit/hooks/security_reminder_hook.py
cat developer-kit/hooks/validate-env-vars.py
```

### MCP Server Security

MCP servers can execute code and access system resources. Only enable trusted MCP servers:

1. **Review the server code** before installation
2. **Limit permissions** where possible
3. **Monitor server activity** in logs
4. **Keep servers updated** to latest versions

### File Permissions

Ensure scripts have appropriate permissions:

```bash
# Validation scripts should be executable by owner only
chmod 700 developer-kit/scripts/*.sh

# Hook scripts should not be world-writable
chmod 600 developer-kit/hooks/*.py
```

## Scope

### In Scope

The following are considered security vulnerabilities:

- **Code Execution**: Arbitrary code execution through hooks, skills, or agents
- **Information Disclosure**: Unauthorized access to sensitive data
- **Privilege Escalation**: Gaining elevated permissions
- **Injection Attacks**: Command injection, script injection, etc.
- **Authentication/Authorization**: Bypass of security controls
- **Cryptographic Issues**: Weak encryption, insecure key storage
- **Supply Chain**: Malicious dependencies or MCP servers
- **Configuration Issues**: Insecure default configurations

### Out of Scope

The following are generally NOT considered security vulnerabilities:

- **Denial of Service**: Resource exhaustion (unless it leads to other security impact)
- **Social Engineering**: Issues requiring user interaction with malicious content
- **Theoretical Vulnerabilities**: Without practical exploitation path
- **Third-Party Issues**: Vulnerabilities in Claude Code, Python, Node.js, or other dependencies (report to respective projects)
- **User Misconfiguration**: Security issues from deliberately insecure configurations

## Known Security Considerations

### 1. Hook Execution

Hooks execute Python scripts with the permissions of the user running Claude Code. Be cautious when:
- Adding custom hooks
- Installing third-party plugins
- Running Claude Code with elevated privileges

### 2. MCP Server Risks

MCP servers can:
- Execute arbitrary commands
- Access the filesystem
- Make network requests
- Access environment variables

Only use MCP servers from trusted sources.

### 3. API Key Exposure

The `.mcp.json` file may reference API keys. Ensure:
- Keys are stored in environment variables
- `.mcp.json` uses `${VAR}` syntax
- Never commit actual keys to version control

### 4. Template Security

Templates (CI/CD, Docker, Kubernetes) may contain:
- Default credentials (change before use)
- Network configurations (review before deployment)
- Build settings (audit for security)

## Security Features

### Current Protections

1. **Environment Variable Validation Hook**: Prevents running with missing required variables
2. **Security Reminder Hook**: Reminds about security best practices
3. **No Hardcoded Secrets**: All example configurations use variable substitution
4. **Validation Scripts**: Automated checks for common security issues
5. **Read-Only Skills**: Many skills (analyze, security, verify) are read-only by design

### Planned Enhancements

- Secret scanning in CI/CD
- Automated dependency vulnerability scanning
- Hook sandboxing capabilities
- MCP server permission system

## Security Changelog

### Version 4.0.0
- Initial security policy
- Environment variable validation hook
- Security reminder hook
- Variable substitution in MCP configuration

## Contact

For non-security questions, please use:
- [GitHub Discussions](https://github.com/claudebase/marketplace/discussions)
- [GitHub Issues](https://github.com/claudebase/marketplace/issues)

For security concerns only:
- [Security Advisories](https://github.com/claudebase/marketplace/security/advisories)

## Acknowledgments

We appreciate the security research community's efforts in responsibly disclosing vulnerabilities. Contributors who report valid security issues will be acknowledged in our security advisories (unless they prefer anonymity).

Thank you for helping keep the Claude Code Plugin Marketplace and its users safe!
