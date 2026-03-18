# Content Pipeline — Reference

## Agent Spawning Patterns

### Research Agent

```
Spawn a research-analyst agent with:
- Topic: [user-provided topic]
- Output format: structured research brief with sections for key findings, data points, expert perspectives, counter-arguments, and content angles
- Output path: ./research-briefs/YYYY-MM-DD-topic-slug.md
```

### Editorial Agent

```
Spawn an editor-in-chief agent with:
- Input: [path to draft or brief]
- Review criteria: voice consistency, argument structure, SEO optimization, factual accuracy, readability
- Output format: review document with inline comments, overall assessment, and revision suggestions
- Output path: [input-path]-review.md
```

### Social Amplification Agent

```
Spawn a social-amplifier agent with:
- Input: [path to final content]
- Output format: platform-specific distribution pack
- Output path: [input-path]-social-pack.md
```

## Output Format Specifications

### Research Brief Format

```markdown
# Research Brief: [Topic]

**Date:** YYYY-MM-DD
**Topic:** [Topic description]
**Sources:** [Number] sources consulted

## Key Findings
1. [Finding with source citation]
2. [Finding with source citation]

## Data Points
- [Statistic or metric with source]

## Expert Perspectives
- [Expert name/org]: [Key quote or position]

## Counter-Arguments
- [Opposing view and its strength]

## Content Angles
1. [Angle 1]: [Why it works]
2. [Angle 2]: [Why it works]

## Recommended Direction
[Which angle to pursue and why]
```

### Editorial Review Format

```markdown
# Editorial Review: [Title]

**Reviewed:** YYYY-MM-DD
**Source:** [Path to draft]
**Decision:** PASS | REVISE | ESCALATE

## Voice Assessment
- **Consistency:** [Score 1-5]
- **Notes:** [Specific feedback]

## Structure
- **Flow:** [Assessment]
- **Argument strength:** [Assessment]

## SEO Evaluation
- **Primary keyword:** [Keyword] — [Present/Missing]
- **Meta description:** [Assessment]
- **Heading hierarchy:** [Assessment]

## Line-Level Notes
- Line [N]: [Specific suggestion]

## Title Variants
1. [Alternative title 1]
2. [Alternative title 2]
3. [Alternative title 3]
```

### Social Distribution Pack Format

```markdown
# Social Distribution Pack: [Title]

**Generated:** YYYY-MM-DD
**Source:** [Path to content]

## LinkedIn Post (Variant A — Story-led)
[Full post text, 1200-1500 chars]

## LinkedIn Post (Variant B — Data-led)
[Full post text, 1200-1500 chars]

## Twitter/X Thread (5-7 tweets)
1/ [Tweet 1 — hook]
2/ [Tweet 2]
...

## Email Subject Lines
1. [Subject line 1]
2. [Subject line 2]
3. [Subject line 3]

## Pull Quotes
- "[Quote 1]"
- "[Quote 2]"

## Hashtags
[Platform-specific hashtag sets]
```

## Error Handling

### Stage Failures

| Error | Recovery |
|-------|----------|
| Research agent returns empty brief | Retry with refined topic, or skip to manual draft |
| Editorial review too harsh (all REVISE) | Ask user whether to iterate or override |
| Social pack misses platform | Regenerate for specific platform only |

### Retry Patterns

- Max 2 retries per stage before asking user for direction
- Each retry should include feedback from the failed attempt
- Never silently skip a stage — always inform the user
