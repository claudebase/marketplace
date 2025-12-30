## Description

<!-- Provide a clear and concise description of what this PR does -->

## Type of Change

<!-- Mark the relevant option(s) with an [x] -->

- [ ] Bug fix (non-breaking change that fixes an issue)
- [ ] New feature (non-breaking change that adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update
- [ ] Refactoring (no functional changes)
- [ ] Performance improvement
- [ ] Test addition or update
- [ ] Chore (dependency updates, tooling, etc.)

## Component(s) Affected

<!-- Mark all that apply -->

- [ ] Skills
- [ ] Agents
- [ ] Commands
- [ ] Hooks
- [ ] MCP Servers
- [ ] Templates
- [ ] Scripts/Validation
- [ ] Documentation
- [ ] CI/CD
- [ ] Other: _____________

### Specific Components

<!-- List the specific skills, agents, or commands affected -->
<!-- Example: `implement` skill, `architect` agent, `/start` command -->

-

## Related Issues

<!-- Link related issues using keywords: Fixes #123, Closes #456, Related to #789 -->

Fixes #
Related to #

## Changes Made

<!-- Provide a detailed list of changes -->

### Added
-

### Changed
-

### Removed
-

### Fixed
-

## Testing

### Test Checklist

- [ ] All existing tests pass (`./developer-kit/scripts/test-components.sh`)
- [ ] Added new tests for new functionality
- [ ] Manually tested changes
- [ ] Tested with Claude Code CLI

### Test Results

```bash
# Paste test suite output here
```

### Manual Testing Steps

<!-- Describe how to manually test these changes -->

1.
2.
3.

## Documentation

- [ ] Updated relevant documentation in `developer-kit/docs/`
- [ ] Updated CHANGELOG.md (if applicable)
- [ ] Updated README.md (if applicable)
- [ ] Added/updated code comments
- [ ] Updated SKILLS.md / AGENTS.md / COMMANDS.md (if applicable)
- [ ] Added examples or usage guide

## Breaking Changes

<!-- If this PR introduces breaking changes, describe them here -->

- [ ] This PR includes breaking changes

**Breaking changes description:**
<!-- Describe what breaks and how users should migrate -->



## Version Impact

<!-- Does this PR require a version bump? -->

- [ ] Patch (4.0.x) - Bug fixes, minor improvements
- [ ] Minor (4.x.0) - New features, non-breaking changes
- [ ] Major (x.0.0) - Breaking changes

**Suggested version:** v

## Validation Checklist

<!-- Confirm you've completed these steps -->

### Code Quality
- [ ] Code follows the project's style guide
- [ ] No hardcoded secrets or API keys
- [ ] Used environment variable syntax (`${VAR}`) in configs
- [ ] Removed unused code and imports
- [ ] Added appropriate error handling

### Plugin-Specific
- [ ] Skills use flat structure (no nested SKILL.md files)
- [ ] Agents are flat files in `agents/` directory
- [ ] Skill descriptions include trigger phrases ("Activates for: ...")
- [ ] Frontmatter is valid YAML and includes required fields
- [ ] Reference files are properly linked (if applicable)

### CI/CD
- [ ] All GitHub Actions workflows pass
- [ ] No new linting errors introduced
- [ ] JSON/YAML files are valid

## Screenshots / Examples

<!-- If applicable, add screenshots or code examples -->

```bash
# Example usage
```

## Additional Context

<!-- Add any other context about the PR here -->

## Reviewer Notes

<!-- Any specific areas you'd like reviewers to focus on? -->

---

## Pre-submission Checklist

<!-- These are REQUIRED before submitting -->

- [ ] I have read the [CONTRIBUTING.md](../CONTRIBUTING.md) guidelines
- [ ] I have read the [CODE_OF_CONDUCT.md](../CODE_OF_CONDUCT.md)
- [ ] My code follows the project's coding standards
- [ ] I have performed a self-review of my code
- [ ] I have commented my code, particularly in hard-to-understand areas
- [ ] I have made corresponding changes to the documentation
- [ ] My changes generate no new warnings
- [ ] I have added tests that prove my fix is effective or that my feature works
- [ ] New and existing unit tests pass locally with my changes
- [ ] I have checked my code and corrected any misspellings
- [ ] I have verified that no sensitive information is included in this PR

## For Maintainers

<!-- Maintainers: Complete before merging -->

- [ ] PR title follows commit message format (`Type: Description`)
- [ ] Appropriate labels added
- [ ] Milestone assigned (if applicable)
- [ ] Version impact assessed
- [ ] Breaking changes documented
- [ ] CHANGELOG.md updated
