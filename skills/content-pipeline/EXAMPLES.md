# Content Pipeline — Examples

## Example 1: Full Pipeline from Topic

### Prompt

> /content-pipeline "Why email deliverability matters more than open rates"

### What happens

1. **Stage 1 — Research**: Spawns research-analyst agent
   - Searches for recent data on email deliverability vs open rate metrics
   - Finds industry reports, expert opinions, and case studies
   - Outputs: `./research-briefs/2026-03-18-email-deliverability-vs-open-rates.md`
   - User reviews brief and approves direction

2. **Stage 2 — Editorial Review**: Spawns editor-in-chief agent
   - Reviews the draft for voice consistency, argument strength, and SEO
   - Checks keyword integration for "email deliverability"
   - Outputs: `./content/2026/2026-03-18-SS-email-deliverability.md-review.md`
   - Decision: REVISE (suggests stronger opening hook and more data points)

3. **Stage 3 — Social Distribution**: After revisions, spawns social-amplifier
   - Generates 2 LinkedIn post variants (story-led and data-led)
   - Creates 6-tweet Twitter thread
   - Produces 3 email subject line options
   - Outputs: `./content/2026/2026-03-18-SS-email-deliverability.md-social-pack.md`

---

## Example 2: Review Existing Draft

### Prompt

> /content-pipeline review ./drafts/email-deliverability.md

### What happens

Skips Stage 1 (research) and goes directly to editorial review:

1. **Stage 2 — Editorial Review**: Reads the draft at the specified path
   - Assesses voice: "Conversational but authoritative — matches target"
   - Checks structure: "Missing a counter-argument section"
   - SEO check: "Primary keyword appears in title and H2s, missing from meta description"
   - Provides 5 line-level suggestions
   - Offers 3 alternative titles
   - Decision: PASS (with minor revisions noted)

2. **Stage 3 — Social Distribution**: Proceeds automatically after PASS
   - Generates full social distribution pack

---

## Example 3: Generate Social Pack from Published Article

### Prompt

> /content-pipeline distribute ./content/2026/2026-03-15-SS-mcp-future-of-apis.md

### What happens

Skips Stages 1 and 2, goes directly to distribution:

1. **Stage 3 — Social Distribution**: Reads the published article
   - LinkedIn Variant A (story-led): Opens with a personal anecdote about API integration pain
   - LinkedIn Variant B (data-led): Opens with "73% of developers say API integration is their biggest time sink"
   - Twitter thread: 7 tweets distilling the key argument
   - Email subjects: "The API is dead. Long live MCP.", "Why I stopped building API wrappers", "MCP changed how I think about integrations"
   - Pull quotes: 2 quotable passages for social sharing
   - Hashtags: LinkedIn set (#MCP #APIs #DevTools) and Twitter set (#buildinpublic #devtools)
