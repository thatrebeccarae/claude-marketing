Deep technical SEO auditing covering crawlability, indexation, Core Web Vitals, site architecture, canonicalization, structured data validation, and performance optimization. Use when the user asks about technical SEO, site audits, crawl issues, indexation problems, Core Web Vitals, page speed, or site architecture optimization. For content-focused SEO, see the seo-content-writer skill.


# Technical SEO Audit

Deep technical SEO analysis: crawlability, indexation, Core Web Vitals, site architecture, and performance.

## Audit Framework

### Phase 1: Crawlability & Indexation

#### robots.txt Analysis
- Verify file exists at `/robots.txt`
- Check for unintentional blocks (`Disallow: /` on production)
- Validate sitemap reference
- Review AI crawler directives (GPTBot, ClaudeBot, PerplexityBot)

#### XML Sitemap Audit
- Validate sitemap format (XML schema compliance)
- Check for 404, 301, or 5xx URLs in sitemap
- Verify lastmod dates are accurate (not all the same date)
- Confirm sitemap is referenced in robots.txt
- Check sitemap size (under 50MB / 50,000 URLs per file)
- For large sites: verify sitemap index file structure

#### Indexation Health
- Compare indexed pages (site:domain.com) vs expected pages
- Identify index bloat (thin, duplicate, or low-value pages indexed)
- Check for noindex tags on important pages
- Review Google Search Console coverage report patterns
- Identify orphan pages (in sitemap but no internal links)

#### Crawl Budget Optimization
- Identify crawl traps (infinite pagination, calendar URLs, faceted navigation)
- Check crawl depth (critical pages should be within 3 clicks)
- Review log files for crawler behavior patterns
- Identify wasted crawl budget on low-value URLs

### Phase 2: Site Architecture & Internal Linking

#### URL Structure
- Consistent URL patterns (lowercase, hyphens, no trailing slashes OR consistent trailing slashes)
- Logical hierarchy reflecting content taxonomy
- No URL parameters where clean URLs are possible
- Proper handling of pagination (rel=next/prev or load-more)

#### Internal Link Analysis
- PageRank flow: are high-authority pages linking to important content?
- Orphan page detection (pages with zero internal links)
- Broken internal links (404s)
- Anchor text distribution (relevant, varied, not over-optimized)
- Link depth audit (pages more than 3 clicks from homepage)

#### Navigation & Hierarchy
- Breadcrumb implementation (with BreadcrumbList schema)
- Navigation depth (flatten deep hierarchies)
- Footer link optimization
- Faceted navigation handling (noindex, canonical, or robots)

### Phase 3: Core Web Vitals & Performance

#### Largest Contentful Paint (LCP) — Target: <2.5s
- Identify LCP element (usually hero image or H1)
- Check image optimization (format, compression, dimensions)
- Verify preload for LCP resources
- Check server response time (TTFB)
- Review render-blocking resources

#### Interaction to Next Paint (INP) — Target: <200ms
- Identify long tasks blocking the main thread
- Review JavaScript execution time
- Check event handler performance
- Evaluate third-party script impact

#### Cumulative Layout Shift (CLS) — Target: <0.1
- Check for images/embeds without dimensions
- Review dynamic content injection above the fold
- Verify font loading strategy (font-display: swap or optional)
- Check ad slot reservations


(Truncated. See full skill at github.com/thatrebeccarae/claude-marketing)
