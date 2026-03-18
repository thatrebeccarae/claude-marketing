# content-workflow


# Content Workflow

End-to-end content creation pipeline: research, draft, review, distribute.

## Pipeline Stages

### Stage 1: Research

Gather raw material for the content piece.

1. **Topic research** — web search, RSS feeds, industry sources
2. **Source assessment** — credibility, recency, relevance
3. **Data extraction** — key statistics, quotes, data points
4. **Counter-arguments** — opposing views, nuance, caveats
5. **Angle development** — what makes this piece unique

**Output:** Research brief with sources, data points, and recommended angle.

### Stage 2: Draft & Edit

Create and refine the content.

1. **Draft** — write following the content type framework and brand voice
2. **Editorial review** against quality criteria:
   - Voice consistency
   - Structural quality (hook → body → CTA)
   - SEO optimization (if applicable)
   - Factual accuracy (all claims sourced)
   - Readability (appropriate level for audience)
3. **Revision** — apply specific feedback
4. **Final review** — verify all issues addressed

**Output:** Polished draft ready for approval.

### Stage 3: Distribute

Adapt the finished piece for cross-platform distribution.

1. **LinkedIn post** — hook, body, CTA, hashtags
2. **Twitter/X thread** — numbered tweets, hooks per tweet
3. **Email subject lines** — 3 options with preview text
4. **Pull quotes** — 3-5 shareable excerpts for social

**Output:** Distribution pack with platform-specific adaptations.

## Usage Modes

### Full Pipeline

```
/content-workflow [topic]
```

Runs all 3 stages: research → draft → review → distribute.

### Start from Draft

```
/content-workflow --from-draft [file path]
```

Skips research. Takes an existing draft through editorial review and distribution.

### Distribution Only

```
/content-workflow --distribute [file path]
```

Takes a finished, approved piece and creates the social distribution pack.

## Content Types

| Type | Research Depth | Draft Length | Distribution |
|------|---------------|-------------|--------------|
| Blog post | Deep (5+ sources) | 1,500-2,500 words | LinkedIn + Twitter + Email |
| LinkedIn post | Light (2-3 sources) | 150-300 words | Twitter adaptation only |
| Twitter thread | Light (1-2 sources) | 5-12 tweets | LinkedIn adaptation only |
| Newsletter | Medium (3-5 sources) | 500-1,000 words | Twitter + LinkedIn teasers |
| Essay | Deep (8+ sources) | 2,000-4,000 words | Full distribution pack |

## Status Tracking

Content moves through these statuses:

```
stub → draft → reviewed → approved → published → measured
                                   ↘ rejected (terminal)
```

- **stub:** Topic identified, no content yet
- **draft:** First draft complete
- **reviewed:** Editorial review complete
- **approved:** Human approval gate passed
- **published:** Live on platform
- **measured:** Performance data collected
- **rejected:** Did not pass review, will not publish

## Key Principles

1. **Research before writing.** Even short posts benefit from 10 minutes of source gathering.
2. **One piece, many platforms.** Write once, adapt to each platform's format.
3. **Human approval gate.** Never publish without explicit approval.
4. **Measure everything.** Track performance to inform future content decisions.

For editorial review criteria and platform templates, see [REFERENCE.md](REFERENCE.md).

---

# Content Workflow — Reference

## Editorial Review Criteria

### Voice Consistency (Score 1-5)

| Score | Description |
|-------|-------------|
| 5 | Indistinguishable from the brand voice guide — reads as one unified voice |
| 4 | Consistent with minor deviations in 1-2 sentences |
| 3 | Generally on-brand but noticeable tonal shifts |
| 2 | Inconsistent — shifts between formal/casual or multiple personalities |
| 1 | Does not match the defined brand voice |

### Structural Quality (Score 1-5)

| Score | Description |
|-------|-------------|
| 5 | Hook grabs attention, body delivers value, CTA is clear and natural |
| 4 | Strong structure with one weak section |
| 3 | Serviceable but predictable — no memorable hook or weak ending |
| 2 | Disorganized — hard to follow the narrative thread |
| 1 | No discernible structure |

**Structural checklist:**
- [ ] Hook in first 2 sentences (not a generic intro)
- [ ] Clear thesis or promise early
- [ ] Body paragraphs each make one point
- [ ] Transitions between sections
- [ ] CTA aligned with content goal
- [ ] Appropriate length for format

### SEO Quality (Score 1-5, if applicable)

- [ ] Primary keyword in title and H1
- [ ] Primary keyword in first 100 words
- [ ] Secondary keywords in H2 headings
- [ ] Meta description written (150-160 chars)
- [ ] Internal links included
- [ ] Header hierarchy logical

### Factual Accuracy

- [ ] All statistics have sources
- [ ] Sources are credible and recent (<2 years)
- [ ] No unsupported claims
- [ ] Counter-arguments or caveats acknowledged
- [ ] Quotes are attributed

### Readability

- [ ] Appropriate reading level for audience
- [ ] Paragraphs 2-4 sentences
- [ ] Active voice dominant (>80%)
- [ ] No jargon without explanation
- [ ] Scannable (headers, bullets, bold)

## Quality Scoring Rubric

| Total Score | Decision |
|-------------|----------|
| 20-25 | **Pass** — approve for publishing |
| 15-19 | **Revise** — specific edits needed, list them |
| 10-14 | **Major revision** — structural or voice issues require rewrite |
| <10 | **Reject** — start over with new approach |

## Platform Adaptation Templates

### LinkedIn Post Template

```
[Hook — bold statement, surprising stat, or contrarian take]

[Paragraph 1 — expand on the hook with context]

[Paragraph 2 — the insight or framework]

[Paragraph 3 — practical takeaway or personal experience]

[CTA — specific question or invitation]

#hashtag1 #hashtag2 #hashtag3
```

**Rules:**
- First 2-3 lines appear before "see more" — make them count
- Use line breaks between paragraphs (LinkedIn collapses dense text)
- 3-5 hashtags, mix of broad (#marketing) and niche (#klaviyotips)
- 150-300 words optimal

### Twitter/X Thread Template

```
Tweet 1 (Hook):
[Standalone insight that makes people want more. End with "A thread:" or similar]

Tweet 2-N (Body):
[One idea per tweet. Each should be valuable on its own if retweeted.]

Final Tweet (CTA):
[Summary + call to action. "Follow @handle for more on [topic]" or "Bookmark this thread for later."]
```

**Rules:**
- Hook tweet must work as a standalone post
- Number tweets (1/, 2/, etc.) for readability
- Each tweet: one idea, one example, or one stat
- 5-12 tweets optimal
- Quote-tweet the first tweet with a summary for engagement

### Email Subject Lines

```
Option A (Number + Benefit): [X] Ways to [Achieve Result]
Option B (Question): Is Your [Thing] [Underperforming/Costing You]?
Option C (How-to): How to [Achieve Result] Without [Pain Point]
```

**Preview text (40-90 chars):**
```
[Expand on the subject line — add context or urgency]
```

### Pull Quote Format

```
"[2-3 sentence excerpt that stands alone as an insight]"
— From: [Article Title]
```

Select quotes that:
- Contain a specific stat or bold claim
- Work without surrounding context
- Are under 280 characters (tweetable)

## Follow-Up Cadence

After publishing:

| Timeframe | Action |
|-----------|--------|
| Day 0 | Publish primary piece + distribute social pack |
| Day 1 | Engage with comments/replies on all platforms |
| Day 3 | Share pull quote as a standalone social post |
| Day 7 | Repurpose as a different format (e.g., blog → thread) |
| Day 14 | Measure performance, note learnings |
| Day 30 | Evaluate for evergreen update or sequel |
