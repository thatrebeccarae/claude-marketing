# Schema Markup Generator — Examples

## Example 1: Blog Post with FAQ Schema

### Prompt

> Generate schema markup for my blog post about email deliverability. The post has an FAQ section with 4 questions. Author is Jane Smith, published today.

### Output

Two JSON-LD blocks: Article schema (with author Person, publisher Organization, dates) and FAQPage schema (4 Question/Answer pairs matching the visible FAQ content).

---

## Example 2: E-commerce Product Page

### Prompt

> Generate Product schema for our flagship widget. Price: $49.99, in stock, 4.7 stars from 312 reviews, SKU: WDG-PRO-001, brand: WidgetCo.

### Output

Product schema with nested Offer (price, currency, availability), AggregateRating (ratingValue, reviewCount), Brand, and image fields. Plus BreadcrumbList for navigation context.

---

## Example 3: Schema Audit and Fix

### Prompt

> Audit the structured data on our top 5 blog posts and fix any issues.

### What the skill does

1. Extracts existing JSON-LD from each page
2. Validates against schema.org requirements
3. Identifies: 2 posts missing dateModified, 1 post with invalid date format, 3 posts missing author.sameAs links, all posts missing publisher.logo
4. Generates corrected schema blocks for each page
