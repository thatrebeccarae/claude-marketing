# AEO/GEO Optimizer — Examples

## Example 1: Full AEO/GEO Audit

### Prompt

> Audit our marketing blog for AI search visibility. We publish 3 articles per week about email marketing and want to appear in ChatGPT and Perplexity answers.

### What the skill does

1. **Assess current visibility**: Tests 10 target queries across ChatGPT, Perplexity, and Google AI Overviews. Documents which queries cite the blog vs competitors.

2. **Crawlability check**: Reviews robots.txt for AI crawler access. Finds GPTBot and PerplexityBot are blocked — flags as critical issue.

3. **Content scorecard**: Scores the 5 most recent articles using the AEO scoring rubric:
   - Article 1: 18/40 — no dates, no author byline, no schema
   - Article 2: 24/40 — has dates but answers buried in paragraph 3
   - Article 3: 21/40 — good structure but no statistics cited

4. **Produces prioritized recommendations**:
   - Critical: Unblock AI crawlers in robots.txt
   - High: Add Article + Person schema to all blog posts
   - High: Restructure content to lead with direct answers
   - Medium: Add FAQ sections with related questions
   - Medium: Date-stamp all statistics with sources

---

## Example 2: Optimize Existing Article for AI Citation

### Prompt

> Optimize this article about email deliverability best practices so it gets cited by AI search engines.

### What the skill does

1. **Scores current state**: Runs the Content Scorecard — scores 22/40
2. **Identifies specific issues**:
   - No direct answer in first paragraph (starts with background)
   - Statistics without sources ("studies show" instead of named studies)
   - No FAQ schema markup
   - H2 headings are topic-based, not question-based

3. **Rewrites key sections** following AEO patterns:
   - Adds "What is email deliverability?" H2 with one-sentence definition
   - Restructures "Best Practices" into numbered steps for HowTo schema
   - Adds comparison table: Good vs Poor deliverability signals
   - Creates FAQ section with 5 questions
   - Adds specific statistics with sources and dates

4. **Generates schema markup** (references schema-markup-generator skill)

---

## Example 3: Competitive AI Visibility Analysis

### Prompt

> Our competitor keeps getting cited in ChatGPT for email marketing questions. What are they doing that we are not?

### What the skill does

1. Queries 15 email marketing questions in ChatGPT and Perplexity
2. Documents which sources are cited for each query
3. Analyzes competitor content structure vs yours:
   - Competitor uses question-format H2s — you use topic-format
   - Competitor includes specific benchmarks with sources — you use general statements
   - Competitor has FAQ schema on every page — you have none
   - Competitor content is updated quarterly with fresh dates — yours has no update dates
4. Produces a gap analysis with specific remediation steps for each finding
