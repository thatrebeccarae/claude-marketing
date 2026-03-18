Google Tag Manager expertise. Audit GTM containers, design tag and trigger architecture, debug firing issues, implement consent mode v2, and advise on server-side tagging. Use when the user asks about GTM, tag management, container audits, consent mode, server-side tagging, or tracking implementation.


# Google Tag Manager

Expert-level guidance for Google Tag Manager — auditing containers, designing tag and trigger architecture, debugging firing issues, implementing consent mode v2, and advising on server-side tagging.

## Core Capabilities

### Container Auditing and Optimization

Full container audit covering the six core areas: overview stats, tag inventory, trigger review, variable audit, folder organization, and naming convention assessment. Identifies unused tags, duplicate GA4 config tags, over-broad triggers on conversion tags, undefined variable paths, and consent mode gaps. Produces prioritized recommendations ranked by impact and effort.

### Tag Architecture

Expert guidance on all common tag types:

- **GA4 Configuration (`gaawc`)** — one per domain, holds measurement ID (always via constant variable), enhanced conversions settings, and shared config. All GA4 event tags must reference this as their Configuration Tag.
- **GA4 Event (`gaawe`)** — fires individual events with parameters sourced from data layer variables. References the `gaawc` config tag.
- **Google Ads Conversion Tracking** — conversion ID + label, value and currency from data layer, deduplication tag ID for enhanced conversions.
- **Google Ads Remarketing** — conversion ID, custom parameters for audience building.
- **Meta Pixel** — base code + standard events (PageView, ViewContent, AddToCart, InitiateCheckout, Purchase). Use community template from Template Gallery rather than custom HTML.
- **Custom HTML** — unsandboxed JavaScript, creates CSP risk. Only use when no Template Gallery alternative exists.
- **Community Templates** — vetted third-party templates for Cookiebot, OneTrust, HotJar, Meta Pixel, LinkedIn Insight Tag, and more. Always prefer over Custom HTML.

### Trigger Design

Matching triggers to tags with correct scoping is the single biggest factor in data quality. See REFERENCE.md for the full trigger type taxonomy. Key principles:

- Page Load triggers (Page View, DOM Ready, Window Loaded) for analytics tags that need the DOM
- Custom Event triggers for data layer events — exact match on event name
- Element Visibility for scroll depth and above-the-fold measurement
- Consent Initialization trigger for consent defaults — must fire before all measurement tags
- Never use All Pages trigger for conversion or remarketing tags

### Variable Strategy

Data Layer Variables (v2) are the correct pattern for capturing tracking values. Key strategy:

- Use constant variables for all measurement IDs, API keys, and container IDs — one update propagates everywhere
- Data Layer Variables with dot-notation paths for nested ecommerce objects (`ecommerce.value`, `ecommerce.transaction_id`)
- Lookup Table variables for mapping internal category names to tracking values
- Custom JavaScript variables for derived values — note sandbox limitations (no DOM, no fetch, no async)
- Event Settings Variable to share a reusable set of GA4 event parameters across multiple event tags

### Consent Mode v2

Four consent parameters control how Google tags behave when users deny consent:


(Truncated. See full skill at github.com/thatrebeccarae/claude-marketing)
