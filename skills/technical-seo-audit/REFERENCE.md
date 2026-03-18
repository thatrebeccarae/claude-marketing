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
