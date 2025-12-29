# Multi-Hop Reasoning Patterns

## Core Concept

Multi-hop reasoning follows chains of information across multiple sources to build comprehensive understanding. Each "hop" moves from one piece of information to related information.

```
Query → Hop 1 → Hop 2 → Hop 3 → Hop 4 → Hop 5
  ↓       ↓       ↓       ↓       ↓       ↓
Start  Initial  Deeper   More   Expert  Complete
       finding  context  detail  insight  picture
```

## Pattern Types

### 1. Entity Expansion

Start with an entity, expand to related entities:

```
Person
├── Current role → Organization → Industry
├── Previous work → Projects → Impact
├── Publications → Citations → Influence
├── Collaborators → Their work → Connections
└── Awards/Recognition → Criteria → Significance

Company
├── Products/Services → Market → Competitors
├── Leadership → Background → Vision
├── Technology → Architecture → Innovations
├── Funding → Investors → Valuation
└── Customers → Use cases → Success stories

Technology
├── Core concepts → Implementation → Variants
├── Use cases → Examples → Limitations
├── Alternatives → Comparisons → Trade-offs
├── Community → Contributors → Roadmap
└── Adoption → Case studies → Best practices
```

### 2. Temporal Progression

Follow information through time:

```
Past → Present → Future

Historical Context
├── Origin → Why created → Original problem
├── Evolution → Key changes → Driving factors
├── Milestones → Versions → Breaking changes
└── Lessons learned → Mistakes → Improvements

Current State
├── Current version → Features → Capabilities
├── Adoption → Usage stats → Market share
├── Ecosystem → Tools → Integrations
└── Community → Activity → Health

Future Direction
├── Roadmap → Planned features → Timeline
├── Trends → Industry direction → Predictions
├── Challenges → Risks → Mitigations
└── Opportunities → Growth areas → Possibilities
```

### 3. Conceptual Deepening

Go from surface to depth:

```
Overview → Details → Expertise

Level 1: What is it?
├── Definition
├── Purpose
└── Basic examples

Level 2: How does it work?
├── Architecture
├── Components
└── Interactions

Level 3: How to use it?
├── Getting started
├── Common patterns
└── Best practices

Level 4: Advanced usage
├── Complex scenarios
├── Edge cases
└── Optimization

Level 5: Mastery
├── Internals
├── Extensions
└── Innovation
```

### 4. Causal Chains

Follow cause and effect:

```
Observation → Cause → Root Cause

Problem Analysis
├── Symptom → Immediate cause → Contributing factors
├── Impact → Affected areas → Severity
├── History → When started → What changed
└── Similar cases → Patterns → Known solutions

Solution Development
├── Options → Trade-offs → Recommendation
├── Implementation → Steps → Dependencies
├── Risks → Mitigations → Fallbacks
└── Validation → Success criteria → Monitoring
```

### 5. Comparative Analysis

Explore through comparison:

```
Option A ←→ Option B

Direct Comparison
├── Features → What each offers → Gaps
├── Performance → Benchmarks → Conditions
├── Ease of use → Learning curve → Documentation
├── Community → Size → Activity
└── Cost → Licensing → Total ownership

Use Case Matching
├── Best for A → Scenarios → Examples
├── Best for B → Scenarios → Examples
├── Either works → When to choose → Factors
└── Neither works → Alternatives → Hybrid approaches
```

## Hop Execution Strategy

### Hop 1: Initial Discovery
- Broad search on main topic
- Identify key entities and concepts
- Find authoritative sources
- Map the information landscape

### Hop 2: Context Building
- Follow references from Hop 1
- Understand relationships
- Fill basic knowledge gaps
- Identify deeper questions

### Hop 3: Detail Exploration
- Deep dive into specifics
- Verify key claims
- Find expert opinions
- Gather evidence

### Hop 4: Synthesis Preparation
- Cross-reference findings
- Resolve contradictions
- Identify patterns
- Note gaps

### Hop 5: Completion
- Final verification
- Fill remaining gaps
- Expert validation
- Complete picture

## Tracking Hops

### Hop Genealogy
```markdown
## Research Trail: [Topic]

### Hop 1: [Query]
- Source: [URL]
- Found: [Key information]
- Led to: [Next queries]

### Hop 2: [Query from Hop 1]
- Source: [URL]
- Found: [Key information]
- Led to: [Next queries]

### Hop 3: [Query from Hop 2]
...
```

### Information Flow Diagram
```
[Initial Query]
      ↓
[Hop 1: Basic facts]
      ↓
   ┌──┴──┐
   ↓     ↓
[Hop 2a] [Hop 2b]
   ↓     ↓
   └──┬──┘
      ↓
[Hop 3: Synthesis]
      ↓
[Hop 4: Verification]
      ↓
[Hop 5: Completion]
```

## Parallel Hop Execution

When hops are independent, run in parallel:

```
Hop 1: [Main query]
      ↓
   ┌──┼──┬──┐
   ↓  ↓  ↓  ↓
[2a][2b][2c][2d]  ← All run in parallel
   ↓  ↓  ↓  ↓
   └──┼──┴──┘
      ↓
[Hop 3: Merge results]
```

## Stop Conditions

### When to Stop Hopping
1. **Sufficient coverage** - Core questions answered
2. **Diminishing returns** - No new significant info
3. **Circular references** - Sources citing each other
4. **Authority reached** - Found primary source
5. **Depth limit** - 5 hops reached

### When to Continue
1. **Critical gaps** - Key questions unanswered
2. **Contradictions** - Need resolution
3. **Single source** - Need verification
4. **Uncertainty** - Confidence too low
5. **User request** - Explicit depth requirement
