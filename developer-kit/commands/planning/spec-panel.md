---
name: spec-panel
description: "Multi-expert specification review and improvement using renowned specification and software engineering experts. Use for spec review, requirements validation, and documentation quality improvement."
argument-hint: "[specification_content|@file] [--mode discussion|critique|socratic] [--experts \"name1,name2\"]"
allowed-tools: Read, Grep, Glob, Write, TodoWrite
---

# spec-panel - Expert Specification Review Panel

## Triggers
- Specification quality review and improvement requests
- Technical documentation validation and enhancement needs
- Requirements analysis and completeness verification
- Professional specification writing guidance and mentoring

## Usage
```
spec-panel [specification_content|@file] [--mode discussion|critique|socratic] [--experts "name1,name2"] [--focus requirements|architecture|testing|compliance] [--iterations N] [--format standard|structured|detailed]
```

## Behavioral Flow
1. **Analyze**: Parse specification content and identify key components, gaps, and quality issues
2. **Assemble**: Select appropriate expert panel based on specification type and focus area
3. **Review**: Multi-expert analysis using distinct methodologies and quality frameworks
4. **Collaborate**: Expert interaction through discussion, critique, or socratic questioning
5. **Synthesize**: Generate consolidated findings with prioritized recommendations
6. **Improve**: Create enhanced specification incorporating expert feedback and best practices

Key behaviors:
- Multi-expert perspective analysis with distinct methodologies and quality frameworks
- Intelligent expert selection based on specification domain and focus requirements
- Structured review process with evidence-based recommendations and improvement guidance
- Iterative improvement cycles with quality validation and progress tracking

## MCP Integration
- **Sequential MCP**: Primary engine for expert panel coordination, structured analysis, and iterative improvement
- **Context7 MCP**: Auto-activated for specification patterns, documentation standards, and industry best practices
- **Technical Writer Persona**: Activated for professional specification writing and documentation quality
- **System Architect Persona**: Activated for architectural analysis and system design validation
- **Quality Engineer Persona**: Activated for quality assessment and testing strategy validation

## Tool Coordination
- **Read**: Specification content analysis and parsing
- **Sequential**: Expert panel coordination and iterative analysis
- **Context7**: Specification patterns and industry best practices
- **Grep**: Cross-reference validation and consistency checking
- **Write**: Improved specification generation and report creation
- **MultiEdit**: Collaborative specification enhancement and refinement

## Quality Assurance Features

### Specification Quality Metrics
- **Clarity Score**: Language precision and understandability (0-10)
- **Completeness Score**: Coverage of essential specification elements (0-10)
- **Testability Score**: Measurability and validation capability (0-10)
- **Consistency Score**: Internal coherence and contradiction detection (0-10)

### Expert Validation
- Cross-expert consistency checking and validation
- Methodology alignment and best practice verification
- Quality metric calculation and progress tracking
- Recommendation prioritization and impact assessment

## References
- `references/expert-panel.md` - Expert definitions and methodologies
- `references/review-process.md` - Analysis modes, focus areas, and output formats

## Boundaries

**Will:**
- Provide expert-level specification review and improvement guidance
- Generate specific, actionable recommendations with priority rankings
- Support multiple analysis modes for different use cases and learning objectives
- Integrate with specification generation tools for comprehensive workflow support

**Will Not:**
- Replace human judgment and domain expertise in critical decisions
- Modify specifications without explicit user consent and validation
- Generate specifications from scratch without existing content or context
- Provide legal or regulatory compliance guarantees beyond analysis guidance
