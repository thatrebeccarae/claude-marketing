# AEO/GEO Optimizer — Reference

## AI Platform Citation Behaviors

### ChatGPT (OpenAI)
- **Browsing mode**: Cites sources with links when browsing is enabled
- **Training cutoff**: Knowledge up to training date; browsing supplements
- **Citation style**: Inline links with source titles
- **Preferences**: Authoritative domains, recent content, structured data
- **Crawler**: GPTBot (respect robots.txt)

### Perplexity
- **Always cites**: Every response includes numbered source citations
- **Real-time search**: Fetches current web results for every query
- **Citation style**: Numbered footnotes with full URLs
- **Preferences**: Content that directly answers the query, recent publications
- **Crawler**: PerplexityBot

### Google AI Overviews
- **Integrated into SERPs**: Appears above organic results
- **Citation style**: Source cards with site name and favicon
- **Preferences**: E-E-A-T signals, schema markup, topical authority
- **Trigger**: Informational and "how-to" queries
- **Crawler**: Googlebot + Google-Extended for AI features

### Claude (Anthropic)
- **Tool use**: Can browse web when tools are available
- **Citation style**: Inline references to source content
- **Preferences**: Well-structured, authoritative, factual content
- **Crawler**: anthropic-ai, ClaudeBot

## Schema Markup for AI Visibility

### Priority Schema Types for AEO

| Content Type | Schema | AI Benefit |
|-------------|--------|-----------|
| Articles | Article, NewsArticle | Author credibility, publish date |
| How-tos | HowTo | Step extraction for procedural queries |
| FAQs | FAQPage | Direct Q&A matching |
| Products | Product | Feature/price comparison queries |
| Reviews | Review, AggregateRating | Trust signals |
| Data/Stats | Dataset | Factual citation preference |
| People | Person | Author expertise signals |
| Organizations | Organization | Brand authority |

### Recommended Schema Combinations

**Blog Post**: Article + Person (author) + BreadcrumbList + FAQPage (if FAQ section)

**Product Page**: Product + AggregateRating + FAQPage + BreadcrumbList

**How-To Guide**: HowTo + Article + Person + BreadcrumbList

## Content Optimization Checklists

### Article Optimization for AI Citation

- [ ] H1 contains the primary question/topic
- [ ] First paragraph directly answers the core question
- [ ] All statistics include source and year
- [ ] Author byline with credentials/expertise
- [ ] Published date and last-updated date visible
- [ ] FAQ section with 3-5 related questions
- [ ] Comparison table (if applicable)
- [ ] Key Takeaways / TL;DR section
- [ ] Article schema markup implemented
- [ ] Internal links to related authoritative content

### Page-Level AEO Checklist

- [ ] Title tag includes target question/topic (50-60 chars)
- [ ] Meta description answers the query concisely (150-160 chars)
- [ ] H2 headings use question format where natural
- [ ] Content is scannable (short paragraphs, lists, tables)
- [ ] Images have descriptive alt text
- [ ] Page loads in under 2.5 seconds (LCP)
- [ ] Mobile-responsive layout
- [ ] Canonical URL set correctly
- [ ] AI crawlers allowed in robots.txt

## Query Intent Mapping

| Intent Type | AI Behavior | Content Strategy |
|------------|-------------|-----------------|
| **Definitional** ("What is X?") | Extracts first clear definition | Lead H2 with definition, keep under 2 sentences |
| **Procedural** ("How to X") | Extracts numbered steps | Use HowTo schema, number every step |
| **Comparative** ("X vs Y") | Synthesizes from comparison content | Comparison tables, explicit pros/cons |
| **Statistical** ("How many X?") | Extracts specific numbers | Bold key stats, cite sources inline |
| **Evaluative** ("Best X for Y") | Aggregates recommendations | Clear criteria, ranked recommendations |
| **Explanatory** ("Why does X?") | Extracts causal reasoning | Direct cause-effect in first paragraph |

## Measurement Framework

### Tracking AI Citations

**Manual Process (Monthly):**
1. Compile your top 20 target queries
2. Ask each AI platform (ChatGPT, Perplexity, Google AI Overview)
3. Record: Was your content cited? Which competitor was cited instead?
4. Track month-over-month citation rate

**Automated Signals:**
- GA4 referral traffic from: `chat.openai.com`, `perplexity.ai`, `you.com`
- Server logs: crawl frequency from GPTBot, PerplexityBot, ClaudeBot
- Search Console: AI Overview impressions (where available)
- Brand monitoring: mentions in AI-generated content

### KPIs

| Metric | How to Measure | Target |
|--------|---------------|--------|
| AI citation rate | Manual query testing | >30% of target queries |
| AI referral traffic | GA4 referral report | Month-over-month growth |
| Crawl frequency | Server log analysis | Weekly crawls from AI bots |
| Schema coverage | Rich Results Test | 100% of eligible pages |
| Content score | AEO Scorecard (above) | >32/40 on key pages |
