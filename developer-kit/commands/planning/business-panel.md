---
name: business-panel
description: "**Use for business strategy analysis**. Multi-expert panel with Porter, Christensen, Drucker frameworks. Delegates to: brainstorm. Activates for: business analysis, strategic planning, market assessment."
argument-hint: '[document_path|content] [--mode discussion|debate|socratic] [--experts "name1,name2"]'
delegates-to: brainstorm
allowed-tools: Read, Grep, Glob, Write, Task, WebSearch, TodoWrite
---

# business-panel - Business Panel Analysis System

## Overview

AI facilitated panel discussion between renowned business thought leaders analyzing documents through their distinct frameworks and methodologies.

## Expert Panel

### Available Experts

- **Clayton Christensen**: Disruption Theory, Jobs-to-be-Done
- **Michael Porter**: Competitive Strategy, Five Forces
- **Peter Drucker**: Management Philosophy, MBO
- **Seth Godin**: Marketing Innovation, Tribe Building
- **W. Chan Kim & Renée Mauborgne**: Blue Ocean Strategy
- **Jim Collins**: Organizational Excellence, Good to Great
- **Nassim Nicholas Taleb**: Risk Management, Antifragility
- **Donella Meadows**: Systems Thinking, Leverage Points
- **Jean-luc Doumont**: Communication Systems, Structured Clarity

## Analysis Modes

### Phase 1: DISCUSSION (Default)

Collaborative analysis where experts build upon each other's insights through their frameworks.

### Phase 2: DEBATE

Adversarial analysis activated when experts disagree or for controversial topics.

### Phase 3: SOCRATIC INQUIRY

Question-driven exploration for deep learning and strategic thinking development.

## Usage

### Basic Usage

```bash
business-panel [document_path_or_content]
```

### Advanced Options

```bash
business-panel [content] --experts "porter,christensen,meadows"
business-panel [content] --mode debate
business-panel [content] --focus "competitive-analysis"
business-panel [content] --synthesis-only
```

### Mode Commands

- `--mode discussion` - Collaborative analysis (default)
- `--mode debate` - Challenge and stress-test ideas
- `--mode socratic` - Question-driven exploration
- `--mode adaptive` - System selects based on content

### Expert Selection

- `--experts "name1,name2,name3"` - Select specific experts
- `--focus domain` - Auto-select experts for domain
- `--all-experts` - Include all 9 experts

### Output Options

- `--synthesis-only` - Skip detailed analysis, show synthesis
- `--structured` - Use symbol system for efficiency
- `--verbose` - Full detailed analysis
- `--questions` - Focus on strategic questions

## Tool Coordination

- **Read**: Document and context analysis
- **Grep/Glob**: Pattern and file discovery
- **Write**: Report and synthesis generation
- **Task**: Multi-expert coordination
- **WebSearch**: Market and competitive research
- **TodoWrite**: Analysis progress tracking

## Boundaries

**Will:**

- Analyze documents through multiple expert frameworks
- Facilitate discussion, debate, or Socratic inquiry
- Generate synthesis with prioritized recommendations
- Support iterative analysis cycles

**Will Not:**

- Replace human judgment in critical business decisions
- Generate strategies without analyzing provided content
- Make financial or legal guarantees

## Integration Notes

- Compatible with all thinking flags (--think, --think-hard, --ultrathink)
- Supports comprehensive business analysis workflows
- Integrates with analysis and research skills
