# Content Creator — Examples

## Example 1: Brand Voice Development

### Prompt

> Analyze these 5 blog posts and create a brand voice guide for our company.

### What the skill does

1. Runs `scripts/brand_voice_analyzer.py` on each post
2. Aggregates voice profiles: formality (3.2/5), tone (confident but approachable), perspective (first-person plural)
3. Identifies inconsistencies across posts (voice shifts, jargon handling)
4. Produces a brand voice guide with archetypes, tone attributes, and do/don't guidelines

---

## Example 2: Monthly Content Calendar

### Prompt

> Create a content calendar for March with 3 posts per week across LinkedIn, blog, and newsletter. Theme: AI in marketing. Target: marketing directors at mid-market SaaS.

### What the skill does

1. Plans 4 weeks following 40/25/25/10 pillar ratio
2. Maps topics to platforms based on REFERENCE.md specs
3. Suggests optimal posting times
4. Creates structured calendar with repurposing notes

---

## Example 3: Blog-to-Social Repurposing

### Prompt

> Take this blog post about email segmentation and create platform-optimized versions for LinkedIn, Twitter, and Instagram.

### What the skill does

1. Analyzes blog structure: key insight, supporting data, story element, practical takeaway
2. Creates LinkedIn post (1,400 chars, story-led hook, bullet framework, engagement question)
3. Creates Twitter thread (6 tweets, case study hook, one step per tweet, CTA)
4. Creates Instagram carousel concept (7 slides with bold stats and framework steps)
5. Runs SEO optimizer on original: `python scripts/seo_optimizer.py blog-post.md "email segmentation"` (Score: 82/100)
