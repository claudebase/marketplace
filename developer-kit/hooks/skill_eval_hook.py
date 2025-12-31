#!/usr/bin/env python3
"""
Skill Evaluation Hook

Forces Claude to explicitly evaluate available skills before proceeding.
Based on research showing 84% activation rate with forced evaluation vs 20% without.

This hook runs on UserPromptSubmit and injects a reminder for Claude to consider
which developer-kit skills are relevant before responding.

Cross-platform compatible: works on Windows, macOS, and Linux.
"""

import json
import os
import sys

# Add lib directory to path for cross-platform utilities
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "lib"))


def main():
    """Generate skill evaluation reminder for user prompts."""

    # Read hook input from stdin
    try:
        raw_input = sys.stdin.read()
        hook_input = json.loads(raw_input)
    except json.JSONDecodeError:
        print(json.dumps({"continue": True}))
        return

    # Get the user message
    message = hook_input.get("message", "")

    # Skip for very short messages (greetings, confirmations, simple yes/no)
    if len(message) < 20:
        print(json.dumps({"continue": True}))
        return

    # Skip if user explicitly mentions a skill name (they know what they want)
    skill_names = [
        "analyze",
        "implement",
        "debug",
        "security",
        "improve",
        "verify",
        "test",
        "explain",
        "database",
        "frontend",
        "containers",
        "devops",
        "observability",
        "migration",
        "design",
        "quality",
        "performance",
        "research",
        "document",
        "brainstorm",
        "orchestration",
        "a11y",
        "confidence-check",
        "sequential-thinking",
    ]

    message_lower = message.lower()

    # Skip if user explicitly invokes a skill
    if any(
        f"use {name}" in message_lower or f"/{name}" in message_lower
        for name in skill_names
    ):
        print(json.dumps({"continue": True}))
        return

    # Skip for simple conversational phrases
    skip_phrases = [
        "yes",
        "no",
        "ok",
        "okay",
        "thanks",
        "thank you",
        "got it",
        "sure",
        "continue",
        "proceed",
        "go ahead",
        "next",
    ]
    if message_lower.strip() in skip_phrases:
        print(json.dumps({"continue": True}))
        return

    # Inject skill evaluation reminder as a system message
    reminder = """<skill-evaluation-required>
Before responding, evaluate which developer-kit skills are relevant to this request.

For each potentially relevant skill, determine:
1. Does the user's request match this skill's trigger phrases?
2. Would this skill provide specialized value?

If a skill matches, invoke it via the Skill tool BEFORE generating your response.

Priority skills to consider:
- analyze: code review, quality assessment, architecture review
- implement: building features, creating components, coding
- debug: fixing bugs, troubleshooting, error resolution
- security: security audits, vulnerability checks, OWASP
- improve: refactoring, optimization, code cleanup
- test: running tests, coverage analysis, test strategy
- explain: understanding code, teaching concepts
- research: web research, documentation lookup
</skill-evaluation-required>"""

    result = {"continue": True, "message": f"{message}\n\n{reminder}"}

    print(json.dumps(result))


if __name__ == "__main__":
    main()
