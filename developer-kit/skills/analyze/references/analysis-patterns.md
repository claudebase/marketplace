# Code Quality Analysis Patterns

## Code Smells to Detect

### Complexity Issues
- **Long Methods**: Functions >50 lines indicate need for extraction
- **Deep Nesting**: >3 levels of nesting suggests refactoring needed
- **Large Classes**: Classes with >10 methods may violate SRP
- **Long Parameter Lists**: >4 parameters suggest object encapsulation

### Duplication Patterns
- **Copy-Paste Code**: Identical or near-identical code blocks
- **Similar Logic**: Repeated conditional structures
- **Magic Numbers**: Unexplained numeric literals

### Naming Issues
- **Misleading Names**: Names that don't match behavior
- **Single-Letter Variables**: Outside loop counters
- **Inconsistent Conventions**: Mixed camelCase/snake_case

### Structure Issues
- **Dead Code**: Unreachable or unused code
- **God Objects**: Classes that do too much
- **Feature Envy**: Methods using other class's data excessively
- **Data Clumps**: Repeated groups of data items

## Anti-Patterns by Language

### JavaScript/TypeScript
- Callback hell (use async/await)
- Any type abuse
- Missing null checks
- Prototype pollution risks
- Unhandled promise rejections

### Python
- Mutable default arguments
- Bare except clauses
- Global state mutation
- Missing type hints (Python 3.5+)
- Import side effects

### React/Vue
- Prop drilling (use context/state management)
- Missing key props in lists
- Direct state mutation
- Inline function definitions in render
- Missing dependency arrays in hooks

## Severity Classification

| Severity | Criteria | Action |
|----------|----------|--------|
| Critical | Security risk, data loss potential | Immediate fix |
| High | Bug likely, significant maintainability | Fix this sprint |
| Medium | Code smell, minor issues | Plan for fix |
| Low | Style, optimization opportunity | Backlog |

## Quality Metrics

### Cyclomatic Complexity
- 1-10: Low risk
- 11-20: Moderate risk
- 21-50: High risk
- 50+: Untestable

### Maintainability Index
- 85-100: Highly maintainable
- 65-84: Moderately maintainable
- 0-64: Difficult to maintain
