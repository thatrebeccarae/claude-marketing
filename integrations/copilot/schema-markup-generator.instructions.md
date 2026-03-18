Generate structured data markup (JSON-LD) for rich results, AI search visibility, and enhanced SERP features. Supports Article, FAQ, HowTo, Product, Review, LocalBusiness, Event, BreadcrumbList, Person, Organization, and more. Use when the user needs schema markup, structured data, rich snippets, JSON-LD, or wants to improve search appearance.


# Schema Markup Generator

Generate JSON-LD structured data for rich results, AI citations, and enhanced search visibility.

## When to Use

- Adding structured data to new or existing pages
- Generating JSON-LD for specific schema types
- Auditing existing schema for errors or missing fields
- Improving AI search visibility (pairs with aeo-geo-optimizer)
- Enabling rich results (FAQ dropdowns, star ratings, how-to steps)

## Workflow

### Step 1: Identify Content Type

| Content | Primary Schema | Rich Result |
|---------|---------------|------------|
| Blog post | Article | Enhanced listing with author, date |
| FAQ section | FAQPage | Expandable Q&A in SERPs |
| Tutorial | HowTo | Step-by-step with images/time |
| Product page | Product | Price, availability, ratings |
| Review | Review + Rating | Star ratings in SERPs |
| Recipe | Recipe | Cooking time, ingredients, ratings |
| Event | Event | Date, location, ticket info |
| Local business | LocalBusiness | Maps, hours, contact |
| Person/author | Person | Knowledge panel |
| Breadcrumbs | BreadcrumbList | Breadcrumb trail in SERPs |
| Video | VideoObject | Video carousel, thumbnails |
| Software | SoftwareApplication | App info in SERPs |
| Course | Course | Course info in SERPs |
| Dataset | Dataset | Dataset search results |

### Step 2: Generate JSON-LD

Generate a `<script type="application/ld+json">` block with all required and recommended fields for the schema type. Always use JSON-LD format (not Microdata or RDFa).

### Step 3: Validate

- Google Rich Results Test: https://search.google.com/test/rich-results
- Schema.org Validator: https://validator.schema.org/
- Check Google Search Console for structured data errors

## Schema Templates

### Article

```json
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "Article Title (max 110 chars)",
  "description": "Brief description of the article",
  "author": {
    "@type": "Person",
    "name": "Author Name",
    "url": "https://example.com/author/name",
    "jobTitle": "Author Title",
    "sameAs": ["https://linkedin.com/in/author", "https://twitter.com/author"]
  },
  "publisher": {
    "@type": "Organization",
    "name": "Publisher Name",
    "logo": {"@type": "ImageObject", "url": "https://example.com/logo.png"}
  },
  "datePublished": "2026-03-18T00:00:00Z",
  "dateModified": "2026-03-18T00:00:00Z",
  "image": "https://example.com/article-image.jpg",
  "mainEntityOfPage": {"@type": "WebPage", "@id": "https://example.com/article-url"}
}
```

### FAQPage

```json
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [
    {
      "@type": "Question",
      "name": "What is the question?",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "The complete answer text. Can include <a href=url>HTML links</a>."
      }
    }
  ]
}
```

### HowTo


(Truncated. See full skill at github.com/thatrebeccarae/claude-marketing)
