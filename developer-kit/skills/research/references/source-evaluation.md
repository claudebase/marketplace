# Source Credibility Evaluation

## Credibility Assessment Framework

### Tier 1: Highly Authoritative (Trust)
- Official documentation (React, Python, etc.)
- Primary sources (original research, official announcements)
- Recognized institutions (universities, standards bodies)
- Established publications (ACM, IEEE, major tech blogs)
- Official GitHub repositories

### Tier 2: Generally Reliable (Verify)
- Well-known tech blogs (CSS-Tricks, Smashing Magazine)
- High-reputation Stack Overflow answers (>100 votes)
- Personal blogs of recognized experts
- Conference talks and presentations
- Popular tutorials with community validation

### Tier 3: Use With Caution (Cross-check)
- Medium articles (quality varies widely)
- Random blog posts
- Low-vote Stack Overflow answers
- Forum discussions
- Social media posts

### Tier 4: Avoid or Heavy Verify
- Content farms
- Outdated documentation
- Anonymous sources
- Sites with excessive ads
- Scraped/duplicated content

## Evaluation Criteria

### Authority
| Question | High | Low |
|----------|------|-----|
| Who wrote it? | Named expert | Anonymous |
| Organization? | Established | Unknown |
| Credentials? | Verifiable | None stated |
| Citations? | Links to sources | No references |

### Currency
| Question | Good | Bad |
|----------|------|-----|
| Publication date? | Recent | Old/None |
| Last updated? | Within year | Years ago |
| Version mentioned? | Current | Outdated |
| Links working? | Yes | Broken |

### Accuracy
| Question | Good | Bad |
|----------|------|-----|
| Can verify claims? | Yes | No |
| Consistent with other sources? | Yes | Contradicts |
| Technical accuracy? | Correct | Errors |
| Code examples work? | Yes | Broken |

### Purpose
| Question | Good | Bad |
|----------|------|-----|
| Educational intent? | Yes | Promotional |
| Objective tone? | Yes | Biased |
| Clear and complete? | Yes | Vague |
| Acknowledges limitations? | Yes | Oversells |

## Quick Credibility Checklist

```markdown
## Source: [URL]

### Basic Checks
- [ ] Author identified and credible
- [ ] Publication date visible and recent
- [ ] Organization is recognized
- [ ] No excessive ads or popups

### Content Quality
- [ ] Well-written and organized
- [ ] Technical claims are accurate
- [ ] Code examples are testable
- [ ] References provided for claims

### Cross-Verification
- [ ] Key claims found in other sources
- [ ] Consistent with official documentation
- [ ] No major contradictions found

### Credibility Score: [High/Medium/Low]
```

## Domain-Specific Trust

### Official Documentation
```
docs.python.org        → Trust
reactjs.org            → Trust
developer.mozilla.org  → Trust
docs.microsoft.com     → Trust
cloud.google.com/docs  → Trust
```

### Community Resources
```
stackoverflow.com      → Verify (check votes)
github.com            → Verify (check stars/activity)
dev.to                → Verify (check author)
medium.com            → Careful (quality varies)
```

### Educational
```
.edu domains          → Generally trust
coursera.org          → Trust
freecodecamp.org      → Trust
w3schools.com         → Caution (sometimes outdated)
```

## Red Flags

### Content Red Flags
- No publication date
- No author attribution
- Broken code examples
- Outdated version references
- Excessive promotional content
- Grammar/spelling errors
- Vague or incomplete information

### Site Red Flags
- Excessive advertisements
- Pop-ups and overlays
- No HTTPS
- Copied content from other sites
- Domain looks suspicious
- No contact information

### Technical Red Flags
- Deprecated APIs mentioned as current
- Security anti-patterns shown as best practices
- Code that wouldn't compile/run
- Incorrect technical terminology
- Mixing unrelated technologies

## Source Documentation Template

```markdown
| Field | Value |
|-------|-------|
| URL | [URL] |
| Title | [Title] |
| Author | [Name/Organization] |
| Date | [Publication date] |
| Type | [Doc/Blog/Forum/etc] |
| Credibility | [High/Medium/Low] |
| Notes | [Any caveats] |
```

## Conflict Resolution

When sources disagree:

1. **Check recency** - Newer often more accurate
2. **Check authority** - Official docs win
3. **Check specificity** - Specific beats general
4. **Check consensus** - Majority view matters
5. **Note the conflict** - Report both views if unresolved

```markdown
⚠️ **Conflicting Information**

Source A ([URL]): Claims X
Source B ([URL]): Claims Y

Resolution: [Which to trust and why, or "unresolved"]
```
