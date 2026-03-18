# technical-seo-audit


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

#### Performance Checklist
- [ ] Images: WebP/AVIF format, responsive srcset, lazy loading below fold
- [ ] CSS: Critical CSS inlined, non-critical deferred
- [ ] JavaScript: Deferred or async loading, code splitting
- [ ] Fonts: Preloaded, font-display set, subset if possible
- [ ] Server: HTTP/2 or HTTP/3, compression (Brotli > gzip), CDN
- [ ] Caching: Proper cache-control headers, service worker for repeat visits

### Phase 4: On-Page Technical Elements

#### Meta Tags
- Title tags: unique, 50-60 characters, primary keyword near start
- Meta descriptions: unique, 150-160 characters, include CTA
- Viewport meta tag present
- Charset declaration (UTF-8)
- No conflicting meta robots directives

#### Canonical Tags
- Every page has a canonical tag (self-referencing or pointing to canonical version)
- Canonical tags are absolute URLs (not relative)
- No canonical chains (A -> B -> C)
- Canonicals consistent with internal links, sitemaps, and hreflang
- HTTP pages canonical to HTTPS versions

#### Heading Hierarchy
- Single H1 per page
- Logical H1 > H2 > H3 nesting (no skipped levels)
- H1 contains primary keyword
- Headings are descriptive (not "Introduction" or "Section 1")

#### Structured Data
- Validate with Google Rich Results Test
- Check for errors/warnings in Search Console
- Verify required fields per schema type
- Cross-reference with aeo-geo-optimizer and schema-markup-generator skills

### Phase 5: HTTPS & Security

- SSL certificate valid and not expiring soon
- All resources loaded over HTTPS (no mixed content)
- HTTP to HTTPS redirect chain (single 301, not chain)
- HSTS header present
- Security headers (X-Content-Type-Options, X-Frame-Options, CSP)

### Phase 6: International & Multi-Language (if applicable)

- Hreflang implementation (correct language/region codes)
- Hreflang reciprocal links (A points to B, B points to A)
- X-default tag for fallback
- Language-specific sitemaps
- Content localization quality (not just translation)

### Phase 7: Mobile Optimization

- Mobile-first indexing readiness (same content on mobile and desktop)
- Touch targets sized appropriately (48x48px minimum)
- No horizontal scrolling
- Readable font sizes without zooming (16px base minimum)
- Mobile page speed (test on 3G connection profile)

## Audit Report Structure

### Executive Summary
- Overall technical health score (0-100)
- Critical issues count (blocking indexation/ranking)
- High-priority issues count (impacting performance)
- Quick wins count (easy fixes, high impact)

### Issue Classification

| Severity | Definition | Response Time |
|----------|-----------|---------------|
| Critical | Blocking crawling, indexation, or rendering | Immediate |
| High | Significantly impacting rankings or UX | Within 1 week |
| Medium | Impacting performance or best practices | Within 1 month |
| Low | Minor optimizations or future-proofing | Backlog |

### Per-Issue Format

```
**Issue:** [What is wrong]
**Impact:** [How it affects SEO performance]
**Pages Affected:** [Count or list]
**Fix:** [Specific remediation steps]
**Validation:** [How to verify the fix worked]
```

## Common Tools & Commands

```bash
# Check robots.txt
curl -s https://example.com/robots.txt

# Check HTTP headers
curl -I https://example.com

# Check redirect chain
curl -sIL https://example.com 2>&1 | grep -E "HTTP/|Location:"

# Validate sitemap
curl -s https://example.com/sitemap.xml | head -20

# Check page speed (via PageSpeed Insights API)
curl "https://www.googleapis.com/pagespeedonline/v5/runPagespeed?url=https://example.com&strategy=mobile"

# Check DNS resolution
dig example.com +short

# Check SSL certificate
echo | openssl s_client -servername example.com -connect example.com:443 2>/dev/null | openssl x509 -noout -dates
```

## Benchmarks

| Metric | Good | Needs Work | Poor |
|--------|------|------------|------|
| LCP | <2.5s | 2.5-4.0s | >4.0s |
| INP | <200ms | 200-500ms | >500ms |
| CLS | <0.1 | 0.1-0.25 | >0.25 |
| TTFB | <800ms | 800ms-1.8s | >1.8s |
| Page size | <1.5MB | 1.5-3MB | >3MB |
| Requests | <50 | 50-100 | >100 |
| Crawl depth | <=3 clicks | 4-5 clicks | >5 clicks |

## Integration with Other Skills

- **aeo-geo-optimizer** — Layer AI search optimization after technical foundation is solid
- **schema-markup-generator** — Generate structured data identified as missing during audit
- **google-analytics** — Correlate technical issues with traffic impact
- **pro-report-builder** — Generate professional audit deliverable from findings

---

# Technical SEO Audit — Reference

## HTTP Status Code Guide

| Code | Meaning | SEO Impact | Action |
|------|---------|-----------|--------|
| 200 | OK | Good | None |
| 301 | Permanent redirect | Passes ~90-99% link equity | Minimize chains |
| 302 | Temporary redirect | Does not consolidate equity | Change to 301 if permanent |
| 304 | Not modified | Good (caching working) | None |
| 403 | Forbidden | Page not indexed | Intentional? Check config |
| 404 | Not found | Loses link equity, poor UX | Fix or redirect |
| 410 | Gone | Faster deindexing than 404 | Use for intentionally removed content |
| 500 | Server error | Blocks crawling, deindexing risk | Fix immediately |
| 503 | Service unavailable | Temporary — safe if brief | Use for maintenance windows |

## robots.txt Syntax Reference

```
# Block a directory
User-agent: *
Disallow: /admin/
Disallow: /private/
Disallow: /search?   # Block search result pages

# Allow a specific file in a blocked directory
User-agent: *
Disallow: /images/
Allow: /images/logo.png

# Block specific crawlers
User-agent: AhrefsBot
Disallow: /

# Sitemap declaration
Sitemap: https://example.com/sitemap.xml
```

## Canonical Tag Patterns

### Correct Implementations

```html
<!-- Self-referencing canonical (every page should have one) -->
<link rel="canonical" href="https://example.com/blog/article-title" />

<!-- Cross-domain canonical -->
<link rel="canonical" href="https://original.com/article" />

<!-- HTTP to HTTPS canonical -->
<link rel="canonical" href="https://example.com/page" />
```

### Common Mistakes

| Mistake | Problem | Fix |
|---------|---------|-----|
| Relative URL | Ambiguous resolution | Use absolute URLs |
| Canonical to 404 | Signals to deindex | Point to live URL |
| Canonical chains (A->B->C) | Diluted signal | Point directly to final URL |
| Canonical + noindex | Conflicting signals | Choose one |
| Paginated canonical to page 1 | Loses paginated content | Self-reference each page |

## Core Web Vitals Diagnostic Patterns

### LCP Diagnosis

```
LCP > 2.5s
  └─ Is TTFB > 800ms?
      ├─ Yes → Server/hosting issue (CDN, caching, server capacity)
      └─ No → Client-side issue
           └─ Is LCP element an image?
               ├─ Yes → Check: format (WebP?), compression, dimensions, preload
               └─ No → Check: render-blocking CSS/JS, font loading
```

### CLS Diagnosis

```
CLS > 0.1
  └─ Check above-the-fold content for:
      ├─ Images/videos without width/height attributes
      ├─ Ads/embeds injecting without reserved space
      ├─ Web fonts causing FOIT/FOUT
      ├─ Dynamic content injected after load (banners, popups)
      └─ CSS animations affecting layout (transform is safe; width/height are not)
```

## Structured Data Quick Reference

### Article Schema (Minimum)

```json
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "Article Title",
  "author": {
    "@type": "Person",
    "name": "Author Name",
    "url": "https://example.com/author"
  },
  "datePublished": "2026-03-18",
  "dateModified": "2026-03-18",
  "publisher": {
    "@type": "Organization",
    "name": "Company Name",
    "logo": {
      "@type": "ImageObject",
      "url": "https://example.com/logo.png"
    }
  }
}
```

### BreadcrumbList Schema

```json
{
  "@context": "https://schema.org",
  "@type": "BreadcrumbList",
  "itemListElement": [
    {"@type": "ListItem", "position": 1, "name": "Home", "item": "https://example.com"},
    {"@type": "ListItem", "position": 2, "name": "Blog", "item": "https://example.com/blog"},
    {"@type": "ListItem", "position": 3, "name": "Article Title"}
  ]
}
```

## Server Response Header Checklist

| Header | Expected Value | Purpose |
|--------|---------------|---------|
| Content-Type | text/html; charset=UTF-8 | Correct MIME type |
| X-Robots-Tag | index, follow (or absent) | Crawl directive |
| Cache-Control | max-age=3600 (or appropriate) | Caching policy |
| Content-Encoding | br (Brotli) or gzip | Compression |
| Strict-Transport-Security | max-age=31536000 | HTTPS enforcement |
| X-Content-Type-Options | nosniff | Security |

## Crawl Budget Waste Indicators

| Pattern | Symptom | Fix |
|---------|---------|-----|
| Faceted navigation | Thousands of parameter URLs crawled | noindex, canonical to base, or robots block |
| Calendar pages | Infinite future/past date URLs | robots.txt Disallow |
| Search result pages | Internal search generating crawlable URLs | noindex, robots block |
| Session ID URLs | Same content with different session params | Canonical to clean URL |
| Soft 404s | 200 status but thin/empty content | Return proper 404 or add content |
| Redirect chains | 3+ hops before final destination | Shorten to single redirect |
