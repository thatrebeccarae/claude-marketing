# Technical SEO Audit — Examples

## Example 1: Full Site Technical Audit

### Prompt

> Run a full technical SEO audit on our e-commerce site. We have about 5,000 pages and have noticed a decline in organic traffic over the last 3 months.

### What the skill does

1. **Crawlability check**: Reviews robots.txt, XML sitemap (finds 2,300 URLs returning 404), checks crawl depth (product pages are 5+ clicks deep)
2. **Indexation analysis**: Compares 5,000 expected pages vs 3,200 indexed — finds 1,800 pages with noindex tags from a staging migration
3. **Core Web Vitals**: LCP at 4.2s (poor) due to unoptimized hero images, CLS at 0.18 (needs work) from ads without reserved space
4. **Architecture**: Identifies 340 orphan product pages with zero internal links
5. **Produces audit report** with 3 critical, 8 high, 12 medium issues and prioritized fix timeline

---

## Example 2: Core Web Vitals Fix

### Prompt

> Our LCP is 4.8 seconds on mobile. Help me diagnose and fix it.

### What the skill does

1. Checks TTFB (620ms — acceptable)
2. Identifies LCP element: 2.4MB uncompressed PNG hero image
3. Finds 3 render-blocking CSS files and 2 synchronous JS bundles
4. Prescribes fixes: convert hero to WebP (saves 1.8MB), add preload hint, defer non-critical CSS, async JS loading
5. Estimates improvement: LCP from 4.8s to ~1.8s

---

## Example 3: Post-Migration Audit

### Prompt

> We just migrated from WordPress to Next.js. Check that nothing is broken from an SEO perspective.

### What the skill does

1. Compares old URL structure vs new — identifies 230 URLs that changed without 301 redirects
2. Checks canonical tags on new site — finds 45 pages with canonicals pointing to old WordPress URLs
3. Validates structured data survived migration — finds Product schema was lost on all product pages
4. Checks robots.txt — finds staging robots.txt was deployed to production (Disallow: /)
5. Produces critical migration fix list with priority order
