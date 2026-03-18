---
name: gtm
description: Google Tag Manager expertise. Audit GTM containers, design tag and trigger architecture, debug firing issues, implement consent mode v2, and advise on server-side tagging. Use when the user asks about GTM, tag management, container audits, consent mode, server-side tagging, or tracking implementation.
license: MIT
origin: custom
author: Rebecca Rae Barton
author_url: https://github.com/thatrebeccarae
metadata:
  version: 1.0.0
  category: dev-tools
  domain: google-tag-manager
  updated: 2026-03-18
  tested: 2026-03-18
  tested_with: "Claude Code v2.1"
---

# Google Tag Manager

Expert-level guidance for Google Tag Manager — auditing containers, designing tag and trigger architecture, debugging firing issues, implementing consent mode v2, and advising on server-side tagging.

## Install

```bash
git clone https://github.com/thatrebeccarae/claude-marketing.git && cp -r claude-marketing/skills/gtm ~/.claude/skills/
```

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

- `analytics_storage` — GA4, Google Analytics
- `ad_storage` — Google Ads cookie storage
- `ad_user_data` — sending user data to Google Ads for matching
- `ad_personalization` — remarketing and personalization features

**Advanced mode** (recommended for DTC): Tags fire cookieless on deny, enabling Google's conversion modeling. Requires `wait_for_update` so the CMP has time to resolve user choice before tags fire.

Implementation sequence is order-sensitive — default consent must fire before any measurement tags load. See REFERENCE.md Consent Mode v2 section for full implementation details.

### Server-Side GTM

Server-side GTM moves tag processing from the browser to a server container (GCP or alternative), improving data quality, blocking ad blocker impact, and enabling server enrichment. Key decision factors: ad blocker loss rate, privacy requirements, Meta CAPI needs, budget for hosting (~$30-50/mo on GCP), and technical capacity for setup.

The server container has no automatic access to browser consent state — consent must be explicitly passed from the browser in the request to the sGTM endpoint.

### Debugging

- **Preview mode** — activates the GTM debugger in a paired browser tab. Left panel shows event timeline; right panel shows tag firing status, variable values, and data layer state at each event.
- **Tag Assistant** — integrated with GTM Preview. Consent tab shows consent parameter state at each event.
- **Browser console** — `window.dataLayer` inspection, filter by event name
- **Network tab** — GA4 collect requests, verify parameters, check `gcs` parameter for consent state

## Workflow: Full Container Audit

When asked to audit a GTM container:

1. **Conversion Tracking Verification** — Confirm GA4 config tag exists, measurement ID stored in a constant variable (not hardcoded), enhanced conversions enabled, Google Ads conversion tags present and correctly configured.

2. **Tag Inventory** — List all tags: name, type, status (paused/enabled), firing trigger, tag firing options (unlimited/once per page/once per event). Flag unused, paused, or duplicate tags.

3. **Trigger Review** — List all triggers with conditions. Flag any conversion or remarketing tag attached to an All Pages trigger. Check trigger conditions for URL specificity on conversion triggers.

4. **Variable Audit** — Confirm recommended built-in variables are enabled (Page URL, Page Path, Click Classes, Click ID, Form ID). Check all user-defined variables — are any returning undefined? Verify data layer variable paths match actual dataLayer push structure.

5. **Organization Check** — Is there a folder structure? Are workspaces named descriptively or all in "Default Workspace"? Review publish history — how many versions, how often, are descriptions informative?

6. **Naming Convention Assessment** — Do tag/trigger/variable names follow a consistent framework? Can a new team member understand the container? Flag inconsistency as a maintenance risk.

7. **Consent Mode Check** — Does a consent default tag exist firing on Consent Initialization? Is it configured with all four parameters? Does a CMP template exist? Is TCF v2.3 compatible? Verify in Preview mode Consent tab.

8. **Prioritized Recommendations** — Compile all findings. Rank by impact (revenue/data quality/compliance risk) and effort (Low/Medium/High). Lead with quick wins.

## Hard Rules

Non-negotiable constraints in every recommendation:

1. **Never recommend DOM scraping when data layer is available.** CSS selector or JS variable sniffing is fragile. Data layer is the contract between dev and analytics.
2. **Never recommend All Pages trigger for conversion tags.** Conversion and remarketing tags on All Pages inflate costs and corrupt attribution.
3. **Never recommend Custom HTML when a community template exists.** Community templates are sandboxed and vetted. Custom HTML runs unsandboxed and creates CSP/security risk.
4. **Always verify consent mode default fires before measurement tags load.** Wrong initialization order means consent is not applied — a compliance failure.
5. **Always recommend constant variables for measurement IDs.** Never hardcode a measurement ID, conversion ID, or API key directly in a tag. One update should propagate everywhere.
6. **Always flag deprecated Universal Analytics tags for removal.** UA was fully sunsetted July 2024. Dead tags in a container are clutter and a warning sign about overall maintenance.
7. **Always clear previous ecommerce data before a new ecommerce push.** `dataLayer.push({ ecommerce: null })` before each push prevents data from a prior event contaminating the next.
8. **Never skip workspace isolation.** One change set per workspace. Never work in Default Workspace. Named workspaces with descriptive names are the expert standard.

## Related Tools

- **`google-analytics` skill** — For GA4 data analysis after GTM implementation. GTM configures the tags; the google-analytics skill covers metrics, dimensions, reports, and attribution analysis on the data those tags collect.
- **`gtm-implementer` agent** — For writing GTM changes via the GTM API. Handles workspace preflight, rate-limited variable/trigger/tag creation, and payload construction. The gtm skill is the analysis layer; the gtm-implementer agent is the execution layer. When a user asks to *implement* GTM changes (not just audit or advise), point them to the agent.

## How to Use This Skill

Ask questions like:

- "Audit our GTM container — we think some tags are not firing correctly"
- "Set up consent mode v2 in GTM with Cookiebot. We sell to EU customers."
- "Our GA4 purchase event is firing but transaction value shows as undefined in DebugView"
- "Should we go server-side with GTM? We are losing about 15% of data to ad blockers"
- "Review our naming conventions and tell me what needs to change"
- "Our conversion tags are firing on every page — help me scope them correctly"
- "What triggers should we use for a Shopify store with GA4, Google Ads, and Meta Pixel?"
- "Debug why our Add to Cart event stopped firing"

For complete tag type reference, trigger taxonomy, variable types, consent mode v2 parameters, sGTM architecture details, naming conventions, and anti-patterns, see [REFERENCE.md](REFERENCE.md).

For worked examples of container audits, consent mode setup, tag firing debug, and sGTM advisory, see [EXAMPLES.md](EXAMPLES.md).
