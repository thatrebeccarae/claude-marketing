# content-pipeline


# Content Pipeline

Orchestrate the full content creation workflow from research brief to published-ready content with social distribution pack.

## What This Skill Does

Chains up to 3 agents in sequence:
1. **research-analyst** — Generates a research brief on the topic
2. **editor-in-chief** — Reviews the draft against voice, structure, SEO, and argument quality
3. **social-amplifier** — Creates platform-specific distribution pack (LinkedIn, Twitter/X, email)

Users can enter at any stage or run the full pipeline.

> **How this differs from content-workflow:** The content-workflow skill is a manual workflow guide with frameworks and checklists. This skill is the *orchestration layer* — it actually spawns subagents and manages the pipeline programmatically.

## How to Use

```
/content-pipeline [topic or file path]
```

### Full Pipeline (from scratch)
```
/content-pipeline "Why MCP is the new API"
```

### Start from Existing Draft
```
/content-pipeline review ./drafts/article-draft.md
```

### Social Pack Only
```
/content-pipeline distribute ./content/published-article.md
```

## Workflow Stages

### Stage 1: Research (optional — skip if draft exists)
- Spawn research-analyst agent with the topic
- Output: `./research-briefs/YYYY-MM-DD-topic-slug.md`
- User reviews brief, decides whether to proceed

### Stage 2: Editorial Review
- Spawn editor-in-chief agent pointing at the draft/brief
- Output: `[draft-path]-review.md` saved alongside the source
- Agent provides: voice assessment, structure feedback, SEO evaluation, line-level notes, title variants
- User decides: publish as-is, revise, or iterate

### Stage 3: Social Distribution
- Spawn social-amplifier agent pointing at the final content
- Output: `[content-path]-social-pack.md` saved alongside the source
- Generates: LinkedIn posts (2 variants), Twitter/X thread, email subject lines, pull quotes, hashtags

## Configuration

### Customizing Agents

The default agent chain uses Claude Code subagents with the Agent tool. To customize:

```
Pipeline Stage    | Default Agent Type    | Override With
Research          | research-analyst      | Any research/analysis agent
Editorial         | editor-in-chief       | Any editorial review agent
Distribution      | social-amplifier      | Any social content agent
```

### Output Paths

Configure where each stage saves its output:

| Stage | Default Output Path |
|-------|-------------------|
| Research | `./research-briefs/YYYY-MM-DD-topic-slug.md` |
| Draft | `./content/YYYY/YYYY-MM-DD-slug.md` |
| Review | `[draft-path]-review.md` (alongside draft) |
| Social Pack | `[content-path]-social-pack.md` (alongside content) |

### Publishing Cadence

Adapt the pipeline to your publishing schedule. Example cadence:
- **Research**: Monday/Tuesday
- **Draft**: Tuesday/Wednesday
- **Review**: Wednesday/Thursday
- **Publish**: Thursday/Friday

## Pipeline State Management

The pipeline tracks which stages are complete via file existence:
- Research brief exists → Stage 1 complete
- Review file exists → Stage 2 complete
- Social pack exists → Stage 3 complete

Resume from any stage by pointing to existing files.

## Integration with Other Skills

This skill composes well with:
- **seo-content-writer** — Run during Stage 2 for deep SEO optimization
- **content-creator** — Use for brand voice analysis before editorial review
- **research-digest** — Alternative to the built-in research stage for RSS-based research

## Quick Commands

- `/content-pipeline` — Start full pipeline with topic prompt
- `/content-pipeline review [path]` — Jump to editorial review
- `/content-pipeline distribute [path]` — Jump to social distribution
- `/content-pipeline status` — Show drafts in progress

---

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
