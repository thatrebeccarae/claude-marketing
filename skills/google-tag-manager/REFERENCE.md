# GTM Reference

## Container Hierarchy

```
Account
+-- Container (Web / Server / iOS / Android / AMP)
    +-- Workspace (max 3 on free, unlimited on 360)
        |-- Tags
        |-- Triggers
        |-- Variables
        +-- Folders
```

- **Account**: Organization-level (tied to a Google account)
- **Container**: A deployable GTM unit for a specific platform. One container snippet per site.
- **Workspace**: A draft environment for making changes before publishing. Free accounts: 3 max. 360: unlimited.
- **Published Version**: A snapshot of the container at the time of publish. Every publish creates a numbered version.

---

## Tag Types

### GA4 Configuration (`gaawc`)

| Field | Value |
|-------|-------|
| GTM type code | `gaawc` |
| Display name | Google Tag / GA4 Configuration |
| Purpose | Holds GA4 measurement ID, shared config settings, enhanced conversions toggle |
| Required config | Measurement ID (always via constant variable), tag ID |
| Common mistakes | Duplicate config tags (one per domain max), hardcoded measurement ID, missing enhanced conversions |
| Notes | All GA4 event tags must reference this as Configuration Tag. Introduced as "Google tag" in 2023. |

### GA4 Event (`gaawe`)

| Field | Value |
|-------|-------|
| GTM type code | `gaawe` |
| Display name | GA4 Event |
| Purpose | Fires individual GA4 events with parameters |
| Required config | Event name, Configuration Tag reference (points to `gaawc`), event parameters |
| Common mistakes | Missing Configuration Tag reference, event parameters pulling from wrong variable path, sending UA-style parameters |
| Notes | Event name should match GA4 recommended event names (purchase, add_to_cart, view_item, etc.) where applicable |

### Google Ads Conversion Tracking

| Field | Value |
|-------|-------|
| GTM type code | `awct` |
| Display name | Google Ads Conversion Tracking |
| Purpose | Records conversions for bidding optimization and reporting |
| Required config | Conversion ID, Conversion Label, Conversion Value, Currency, Conversion Deduplication Tag ID |
| Common mistakes | Firing on All Pages (inflates conversions), hardcoded value instead of data layer variable, missing deduplication |
| Notes | Enhanced conversions requires first-party data fields (email, phone, name). Deduplication ID prevents duplicate conversions from same transaction. |

### Google Ads Remarketing

| Field | Value |
|-------|-------|
| GTM type code | `sp` |
| Display name | Google Ads Remarketing |
| Purpose | Builds remarketing audiences, sends custom parameters for smart bidding signals |
| Required config | Conversion ID, custom parameters (page type, product IDs, value) |
| Common mistakes | Missing ecommerce custom parameters, firing on All Pages without page type parameter |
| Notes | Dynamic remarketing requires product IDs from merchant center feed |

### Meta Pixel

| Field | Value |
|-------|-------|
| GTM type code | Community template (preferred) or Custom HTML |
| Display name | Meta Pixel / Facebook Pixel |
| Purpose | Base code + standard events for Meta advertising attribution and audience building |
| Required config | Pixel ID, standard event name (PageView, ViewContent, AddToCart, InitiateCheckout, Purchase), event parameters |
| Common mistakes | Custom HTML instead of community template, missing deduplication with server-side CAPI, sending PII without hashing |
| Notes | Use the official Meta Pixel community template from Template Gallery. Combine with Meta CAPI via sGTM for deduplication. |

### Custom HTML

| Field | Value |
|-------|-------|
| GTM type code | `html` |
| Display name | Custom HTML |
| Purpose | Runs arbitrary unsandboxed JavaScript — for tags with no Template Gallery equivalent |
| Required config | HTML/JavaScript code, Support document.write option (legacy, avoid) |
| Common mistakes | Using Custom HTML when a template exists, injecting PII, bypassing CSP, no error handling |
| Notes | AVOID: runs unsandboxed, CSP violations, security audit failures. Always check Template Gallery first. |

### Custom Image

| Field | Value |
|-------|-------|
| GTM type code | `img` |
| Display name | Custom Image |
| Purpose | 1x1 pixel tracking — for ad network pixels without a JavaScript tag |
| Required config | Image URL (with query parameters for data passing) |
| Common mistakes | Using for modern platforms that have JS tags, missing consent controls |
| Notes | Legacy pattern. Most modern ad platforms have JS tags or sGTM clients. |

### Community Templates

Templates from the GTM Template Gallery, sandboxed and vetted by Google. Preferred over Custom HTML for any third-party tool.

| Common Templates | Use Case |
|----------------|----------|
| Cookiebot CMP | Consent mode v2 with Cookiebot integration |
| OneTrust | Consent mode v2 with OneTrust integration |
| TrustCommander | Consent mode v2 with Commanders Act |
| LinkedIn Insight Tag | LinkedIn audience tracking |
| Meta Pixel (official) | Meta advertising and audiences |
| HotJar | Session recording and heatmaps |
| Clarity | Microsoft Clarity session recording |
| Pinterest Tag | Pinterest audience tracking |
| Snapchat Pixel | Snapchat advertising |

---

## Trigger Types

### Page Load Triggers

| Trigger | Fires When | Common Use Case | Scoping Tips |
|---------|-----------|----------------|-------------|
| **Consent Initialization** | Before any other trigger, including Page View | Consent mode default tag, CMP initialization | Must fire first — use only for consent setup |
| **Initialization** | Before all other triggers, after Consent Initialization | GA4 global config, linker initialization | Rarely needed; prefer Page View for most cases |
| **Page View** | GTM container finishes loading | GA4 pageview, basic analytics | Scope by Page URL contains/matches for conversion pages |
| **DOM Ready** | DOM fully parsed, before images load | Tags that query DOM elements | Use instead of Page View when tag needs DOM access |
| **Window Loaded** | All page resources loaded (images, scripts) | Chat widgets, lazy-loaded content, scroll tracking setup | Slowest; only when needed |

### Click Triggers

| Trigger | Fires When | Common Use Case | Scoping Tips |
|---------|-----------|----------------|-------------|
| **All Elements** | Any click on any element | Button clicks, icon clicks, non-link elements | Scope with Click Classes, Click ID, or Click Element |
| **Just Links** | Click on `<a>` link elements | External link tracking, download tracking | Enable built-in Click URL variable; scope by Click URL |

### User Engagement Triggers

| Trigger | Fires When | Common Use Case | Scoping Tips |
|---------|-----------|----------------|-------------|
| **Element Visibility** | Specified element enters/exits viewport | Above-fold measurement, CTA visibility, lazy content | Use CSS selector, set threshold %; fire once per element |
| **Form Submission** | Form submit event | Lead form tracking, newsletter signup | Enable built-in Form ID variable; scope by Form ID |
| **Scroll Depth** | User scrolls to specified % or pixel depth | Engagement scoring, content read depth | Set % thresholds (25/50/75/90); once per page |
| **YouTube Video** | YT video starts, pauses, completes, reaches % | Video engagement tracking | Requires YouTube JS API support on embedded video |

### Other Triggers

| Trigger | Fires When | Common Use Case | Scoping Tips |
|---------|-----------|----------------|-------------|
| **Custom Event** | `dataLayer.push({ event: 'event-name' })` | Ecommerce events, user interactions, SPA navigation | Exact match (preferred) or regex on event name |
| **History Change** | Browser history state changes | Single-page application (SPA) pageview tracking | Use for React/Vue/Angular SPAs |
| **JavaScript Error** | Uncaught JS error on page | Error monitoring, developer debugging | Filter by error message; be careful about volume |
| **Timer** | After specified interval | Content engagement timing, survey triggers | Set interval + limit; creates many events if misused |

---

## Variable Types

### Built-In Variables

Enable in Variables > Configure. Enable only what you need — each active variable adds overhead.

| Variable | What It Returns | When to Enable |
|----------|----------------|----------------|
| **Page URL** | Full page URL including query string | URL-based triggers, UTM capture |
| **Page Hostname** | Domain only (example.com) | Cross-domain filtering |
| **Page Path** | Path portion (/products/slug) | Page-specific trigger conditions |
| **Referrer** | Previous page URL | Attribution debugging |
| **Click Element** | DOM element that was clicked | Click trigger conditions |
| **Click Classes** | CSS classes of clicked element | Scope click triggers by class name |
| **Click ID** | ID attribute of clicked element | Scope click triggers by element ID |
| **Click Target** | Target attribute (\_blank etc.) | External link detection |
| **Click URL** | href of clicked link | Link click destination |
| **Click Text** | Text content of clicked element | Text-based click conditions |
| **Form Element** | DOM form element | Form trigger conditions |
| **Form Classes** | CSS classes of form | Form scope by class |
| **Form ID** | ID attribute of form | Form scope by ID |
| **Form Target** | Form target attribute | Form conditions |
| **Form Text** | Form submit button text | Form conditions |
| **Form URL** | Form action URL | Form destination |
| **Scroll Depth Threshold** | Scroll % or px value at trigger time | Scroll depth event parameters |
| **Scroll Depth Units** | `percent` or `pixels` | Scroll event parameters |
| **Video Current Time** | Video playback position (seconds) | YouTube event parameters |
| **Video Duration** | Total video length (seconds) | YouTube event parameters |
| **Video Percent** | Playback % at trigger time | YouTube event parameters |
| **Video Provider** | Provider name (youtube) | YouTube event conditions |
| **Video Status** | playing, paused, ended | YouTube event parameters |
| **Video Title** | YouTube video title | YouTube event parameters |
| **Video URL** | YouTube video URL | YouTube event parameters |
| **Video Visible** | Boolean — video in viewport | Visibility conditions |
| **Environment Name** | live, staging, etc. | Environment-based conditions |

### Data Layer Variables (v2)

Access values pushed to `window.dataLayer` via dot-notation paths.

| Config | Notes |
|--------|-------|
| Data Layer Variable Name | Path to value: `ecommerce.value`, `user.email`, `product.category` |
| Version | Always use Version 2. Version 1 does not support nested object access. |
| Default Value | Set to prevent `undefined` in tag parameters — use empty string or 0 |

Common DLV paths for ecommerce:

```
ecommerce.transaction_id   → purchase transaction ID
ecommerce.value            → order value
ecommerce.currency         → currency code (USD, EUR)
ecommerce.items            → items array (pass to GA4 items parameter)
ecommerce.coupon           → coupon code
```

Note: GA4 ecommerce schema uses flat `ecommerce.value` (NOT `ecommerce.purchase.value` — that is the old UA format).

### URL Variables

| Component | Returns | Example |
|-----------|---------|---------|
| `protocol` | https | `https` |
| `host` | Hostname | `www.example.com` |
| `port` | Port number | `443` |
| `path` | URL path | `/products/widget` |
| `query` | Query string | `utm_source=google&gclid=...` |
| `fragment` | Hash fragment | `section-2` |
| `query key` | Specific query param value | URL variable with key `utm_source` |

### DOM Element Variable

Reads a DOM attribute from a CSS-selected element.

| Field | Notes |
|-------|-------|
| Element Selector | CSS selector (e.g., `#product-price`) |
| Attribute Name | `innerText`, `value`, `data-price`, or any HTML attribute |
| Warning | Fragile — DOM structure changes break the variable. Prefer data layer. |

### JavaScript Variable

Returns the value of a global JavaScript variable on the page.

| Field | Notes |
|-------|-------|
| Global Variable Name | Dot-notation supported: `shopify.order.total` |
| Warning | Only works if the variable exists on `window`. Race conditions if variable set async. |

### Custom JavaScript Variable

A sandboxed JavaScript function that returns a value.

| Sandbox Limitations | Notes |
|--------------------|-------|
| No DOM access | Cannot use `document.querySelector` |
| No `window` or `location` | Limited browser API access |
| No async / fetch | Synchronous execution only |
| Return value required | Must `return` a value |

### Constant Variable

Single static value. Best practice for all IDs and shared config.

```
Const - GA4 Measurement ID    → G-XXXXXXXX
Const - Google Ads Conv ID    → AW-XXXXXXXXX
Const - Meta Pixel ID         → 1234567890
Const - GTM Container ID      → GTM-XXXXXX
```

### Lookup Table Variable

Maps an input variable value to an output value.

| Use Case | Example |
|----------|---------|
| Page type mapping | Page Path `/checkout` → "checkout", `/thank-you` → "purchase" |
| Category mapping | Internal category name → GA4 item_category value |
| Language mapping | Browser language → regional configuration |

### Regex Table Variable

Pattern-based version of Lookup Table. Input is matched against regexes.

| Use Case | Example |
|----------|---------|
| URL pattern → page type | `/products/.*` → "product detail page" |
| Multiple URL patterns | `/(cart|checkout)` → "purchase funnel" |

### Event Settings Variable

Reusable set of GA4 event parameters shared across multiple GA4 event tags.

| Use Case | Notes |
|----------|-------|
| Shared parameters | user_id, session_id, currency shared across all events |
| Reduces duplication | Define once, reference in N event tags |
| Merge behavior | Tag-level parameters override Event Settings values |

### Google Tag Configuration Variable

Shared Google tag configuration (measurement ID, ads optimization settings) that can be referenced by multiple Google tags.

---

## Consent Mode v2 Reference

### Four Consent Parameters

| Parameter | Controls | Default Recommendation |
|-----------|---------|----------------------|
| `analytics_storage` | GA4, Google Analytics cookies and measurement | `denied` (EU), `granted` (others) |
| `ad_storage` | Google Ads cookie storage for click attribution | `denied` (EU), `granted` (others) |
| `ad_user_data` | Sending user data to Google for ad matching | `denied` (EU), `granted` (others) |
| `ad_personalization` | Remarketing and personalized advertising | `denied` (EU), `granted` (others) |

### Basic vs Advanced Mode

| | Basic Mode | Advanced Mode |
|--|-----------|--------------|
| On user deny | Tags do NOT fire | Tags fire cookieless (no identifiers sent) |
| Conversion modeling | Not available | Available — Google models missing conversions |
| Cookieless pings | No | Yes — anonymous signals when consent denied |
| EU traffic impact | Complete data loss for deniers | Partial recovery via modeling |
| Recommended for DTC | No | **Yes** — preserves modeling capability |

### Implementation Sequence (Order-Sensitive)

The order of these steps is critical. Consent default MUST fire before measurement tags load.

```
1. Consent Initialization trigger → Consent Default tag
   (fires before all other triggers)

2. GTM container loads and fires remaining tags:
   → CMP template tag (loads Cookiebot, OneTrust, etc.)
   → CMP reads browser storage / asks user

3. User makes choice (accept / decline / customize)
   → CMP calls gtag('consent', 'update', {...})
   → GA4, Ads tags receive updated consent state
```

### Consent Default Tag Configuration

```javascript
// Fires on: Consent Initialization trigger
// This tag runs BEFORE everything else

gtag('consent', 'default', {
  'ad_storage': 'denied',
  'ad_user_data': 'denied',
  'ad_personalization': 'denied',
  'analytics_storage': 'denied',
  'wait_for_update': 500  // ms — time for CMP to call update
});
```

### Region-Specific Defaults

```javascript
// Stricter defaults for EU/EEA; permissive for others
gtag('consent', 'default', {
  'analytics_storage': 'denied',
  'ad_storage': 'denied',
  'ad_user_data': 'denied',
  'ad_personalization': 'denied',
  'region': ['AT','BE','BG','CY','CZ','DE','DK','EE','ES','FI',
              'FR','GR','HR','HU','IE','IS','IT','LI','LT','LU',
              'LV','MT','NL','NO','PL','PT','RO','SE','SI','SK']
});

gtag('consent', 'default', {
  'analytics_storage': 'granted',
  'ad_storage': 'granted',
  'ad_user_data': 'granted',
  'ad_personalization': 'granted'
  // No region = applies to all other regions
});
```

### URL Passthrough and Ads Data Redaction

```javascript
// Preserves ad click data in URLs when ad_storage is denied
gtag('set', 'url_passthrough', true);

// Redacts ads-related data from requests when ad_storage is denied
gtag('set', 'ads_data_redaction', true);
```

### TCF Compliance

- **TCF v2.3** is current as of February 28, 2026 (replaced v2.2)
- Verify CMP template in GTM is TCF v2.3 compatible
- Flag any CMP still on v2.2 as a compliance risk

### Consent State in Network Requests

The `gcs` parameter in GA4 collect requests shows consent state:

| gcs Value | Meaning |
|-----------|---------|
| `G100` | analytics_storage: denied, ad_storage: denied |
| `G110` | analytics_storage: denied, ad_storage: granted |
| `G101` | analytics_storage: granted, ad_storage: denied |
| `G111` | analytics_storage: granted, ad_storage: granted |

---

## Server-Side GTM Architecture

### Architecture Overview

```
Browser
  |
  +-- Client-side GTM container
        |
        +-- Sends HTTP request to sGTM endpoint
              |
              +-- Server Container
                    |
                    +-- Clients (normalize incoming request)
                    |     |-- GA4 Client (handles GA4/gtag requests)
                    |     +-- Measurement Protocol Client
                    |
                    +-- Triggers (event-based processing)
                    |
                    +-- Variables (read from event data)
                    |
                    +-- Tags (forward to destinations)
                          |-- GA4 Measurement Protocol
                          |-- Google Ads Conversion Tracking
                          |-- Meta CAPI (Conversions API)
                          +-- Custom HTTP requests
```

### Clients

Clients are adapters that receive incoming requests and normalize them into events the server container can process.

| Client | What It Handles |
|--------|----------------|
| **GA4 Client** | Requests from GA4/gtag.js — the primary client for most implementations |
| **Measurement Protocol Client** | Server-to-server requests using Measurement Protocol v2 |
| **Custom Client** | Process any custom HTTP request format (Shopify webhooks, etc.) |

### Server Container vs Client-Side Container

| Capability | Client-Side | Server-Side |
|-----------|-------------|-------------|
| DOM access | Yes | No |
| Browser APIs (cookies, storage) | Yes | No — server only sees request data |
| Ad blocker bypass | No | Yes — request from server IP |
| Consent visibility | Automatic | Must be passed explicitly in request |
| Tag Templates | Full library | Subset; growing |
| Hosting | Free (browser) | ~$30–50/mo on GCP |
| Data enrichment | Limited to browser data | Can add server-side signals (CRM lookup, etc.) |

### Consent State in sGTM

**Critical:** The server has no automatic access to the user's consent choice. Consent lives in the browser.

Required pattern:
1. Browser reads consent state from CMP
2. Browser includes consent state in request to sGTM endpoint (as request parameter or event data field)
3. sGTM Client reads consent parameter from incoming request
4. Server-side variable reads consent state
5. Server-side tag trigger conditions check consent state before firing

### Hosting Options

| Option | Cost (est.) | Managed | Best For |
|--------|------------|---------|----------|
| GCP App Engine | ~$30–50/mo (3 instances) | Partially | Most implementations; Google-recommended |
| Stape.io | $9–79/mo | Fully | Agencies, teams without GCP expertise |
| AWS (official pattern) | Variable | Partially | AWS-first infrastructure |
| Self-hosted Docker | Infrastructure cost only | No | Advanced teams with existing infra |

### What Moves Server-Side vs Stays Client-Side

| Stay Client-Side | Move Server-Side |
|-----------------|-----------------|
| Consent mode default/update | GA4 event forwarding |
| CMP template tag | Google Ads conversion tracking |
| GTM Preview/debug tags | Meta CAPI |
| Tags requiring DOM access | Any server enrichment |
| Core Web Vitals tags | Data warehouse forwarding |

---

## Naming Convention Framework

Consistent naming makes containers readable and maintainable by anyone.

### Tag Naming

Pattern: `{Type} -- {Event/Purpose} -- {Location}`

```
GA4 -- PageView -- All Pages
GA4 -- Purchase -- Order Confirmation
GA4 -- AddToCart -- PDP
GA4 -- Config -- All Pages
Google Ads -- Conversion Purchase -- Order Confirmation
Google Ads -- Remarketing -- All Pages
Meta Pixel -- Purchase -- Order Confirmation
Meta Pixel -- ViewContent -- PDP
LinkedIn -- PageView -- All Pages
HotJar -- Init -- All Pages
```

### Trigger Naming

Pattern: `{TriggerType} -- {Location/Condition}`

```
CE -- purchase                    (Custom Event, event name: purchase)
CE -- add_to_cart                 (Custom Event, event name: add_to_cart)
CE -- view_item                   (Custom Event, event name: view_item)
PV -- order-confirmation          (Page View, URL: /order-confirmation)
PV -- all-pages                   (Page View, no conditions)
PV -- pdp                         (Page View, URL matches /products/*)
Click -- add-to-cart-button       (Click, element: .add-to-cart)
Form -- newsletter-signup         (Form, form ID: newsletter-form)
Scroll -- 50pct                   (Scroll Depth, threshold: 50%)
Visibility -- above-fold          (Element Visibility, element: .hero)
Consent -- init                   (Consent Initialization, no conditions)
```

### Variable Naming

Pattern: `{Type} -- {Name}`

```
DLV -- ecommerce.value            (Data Layer Variable)
DLV -- ecommerce.transaction_id
DLV -- ecommerce.currency
DLV -- ecommerce.items
DLV -- user.email
Const -- GA4 Measurement ID       (Constant)
Const -- Google Ads Conv ID
Const -- Meta Pixel ID
URL -- Page Path                  (URL Variable)
URL -- Page Hostname
JS -- User Login State            (Custom JavaScript)
LT -- Page Type                   (Lookup Table)
RT -- URL Category                (Regex Table)
DOM -- Product Price              (DOM Element — use sparingly)
```

### Workspace Naming

Pattern: `{owner-initials}-{change-description}`

```
rr-ga4-aug2026
agency-consent-mode-setup
dev-enhanced-conversions
claude-audit-fixes-2026
```

---

## Anti-Patterns

### 1. DOM Scraping Instead of Data Layer

**What:** Using DOM Element variables or Custom JS to read values from the page HTML (prices, product names, category).

**Why it fails:** DOM structure changes with design updates. CSS selectors break silently. Race conditions if the element isn't rendered when the tag fires.

**Do instead:** Push the values to `window.dataLayer` in the page source or via ecommerce events. Data layer is the stable contract between engineering and analytics.

---

### 2. All Pages Trigger on Conversion Tags

**What:** A conversion tag (Google Ads conversion, Meta Pixel purchase event) attached to an All Pages trigger or a Page View trigger without URL conditions.

**Why it fails:** Fires on every page load. Conversion counts massively exceed actual transactions. Bidding algorithms optimize toward phantom conversions. ROAS looks artificially high.

**Do instead:** Scope conversion tags to the specific confirmation page URL. Use Custom Event trigger matching the purchase event name pushed from the site.

---

### 3. Custom HTML When a Template Exists

**What:** Building a Custom HTML tag for a third-party tool (Meta Pixel, HotJar, LinkedIn) when the GTM Template Gallery has an official or community template.

**Why it fails:** Custom HTML runs unsandboxed. Content Security Policy violations. No security review. Harder to maintain. Templates handle consent signal integration automatically.

**Do instead:** Search Template Gallery first. 95% of common tools have a template. Install from gallery — sandboxed, maintainable, often consent-mode aware.

---

### 4. Missing or Late Consent Defaults

**What:** No consent default tag, or the consent default fires after the GA4/Ads tags load.

**Why it fails:** Without a default, Google tags assume all consent granted — a compliance violation in EU/EEA. If the default fires after measurement tags, the measurement data was collected before consent was applied.

**Do instead:** Create a tag on the Consent Initialization trigger (fires before everything else) setting all four parameters to `denied` with `wait_for_update: 500`. Verify in Preview mode Consent tab.

---

### 5. Hardcoded Measurement IDs

**What:** Typing the GA4 measurement ID (`G-XXXXXXXX`), Google Ads conversion ID, or other IDs directly into each tag that needs them.

**Why it fails:** When an ID changes, every tag must be updated individually. Errors are common. One tag with the old ID breaks attribution.

**Do instead:** Create a Constant variable (`Const -- GA4 Measurement ID`). Reference the variable in all tags. One update propagates everywhere.

---

### 6. Single Shared Workspace

**What:** All team members (and agencies) working directly in Default Workspace, publishing over each other.

**Why it fails:** GTM has no conflict resolution. Whoever publishes last wins. Changes disappear. No audit trail per change set.

**Do instead:** Name workspaces by owner and change set (`agency-consent-setup`, `dev-ecomm-events`). GTM free accounts allow 3 workspaces. After publishing, delete the workspace to free a slot.

---

### 7. Missing GA4 Configuration Tag Reference

**What:** GA4 event tags created without setting a Configuration Tag reference, or referencing nothing (standalone).

**Why it fails:** GA4 event tags without a configuration parent do not send correctly. The measurement ID and shared settings from the config tag are not applied.

**Do instead:** Every GA4 event tag must have Configuration Tag set to the `gaawc` GA4 Config tag. Verify in tag settings.

---

### 8. dataLayer Version 1

**What:** Using Data Layer Variable configured as Version 1, or the legacy `dataLayer` push format from pre-2014 implementations.

**Why it fails:** Version 1 does not support nested object access. `ecommerce.purchase.value` returns undefined. Version 2 (default since 2014) handles nested objects correctly.

**Do instead:** Always configure Data Layer Variables as Version 2. Verify by opening the variable settings and confirming Version field is set to 2.

---

### 9. Not Clearing Ecommerce Data

**What:** Pushing a new ecommerce event without first clearing the previous ecommerce object.

**Why it fails:** GTM's data layer model is cumulative. If a `view_item` push set `ecommerce.items` to Product A, and then the `add_to_cart` push sets `ecommerce.items` to Product B, GTM may see both. Purchase events carry stale line items from earlier in the session.

**Do instead:**
```javascript
window.dataLayer.push({ ecommerce: null }); // Clear
window.dataLayer.push({
  event: 'purchase',
  ecommerce: { ... }
});
```

---

## Data Layer Design Reference

### Initialization

```javascript
// Initialize before GTM snippet (or in GTM snippet config)
window.dataLayer = window.dataLayer || [];
```

### Push Convention

```javascript
// Every meaningful push has an event key for Custom Event triggers
window.dataLayer.push({
  event: 'event-name',   // Required for Custom Event triggers
  key: 'value',
  nestedObject: {
    property: 'value'
  }
});
```

### GA4 Ecommerce Schema (v2 Flat Format)

```javascript
// Clear first
window.dataLayer.push({ ecommerce: null });

// Purchase event
window.dataLayer.push({
  event: 'purchase',
  ecommerce: {
    transaction_id: 'T12345',
    value: 99.99,
    tax: 8.50,
    shipping: 5.99,
    currency: 'USD',
    coupon: 'SAVE10',
    items: [
      {
        item_id: 'SKU_001',
        item_name: 'Widget Pro',
        item_brand: 'Acme',
        item_category: 'Widgets',
        item_category2: 'Pro Series',
        price: 99.99,
        quantity: 1,
        coupon: 'SAVE10',
        discount: 10.00
      }
    ]
  }
});
```

Other recommended events use same `ecommerce` wrapper:
- `view_item` — product detail page
- `add_to_cart` — cart addition
- `remove_from_cart` — cart removal
- `begin_checkout` — checkout start
- `add_payment_info` — payment step
- `add_shipping_info` — shipping step

Note: GA4 format uses `ecommerce.value` directly. Do NOT use `ecommerce.purchase.value` — that is the old Universal Analytics format.

### Timing Rule

Push to `dataLayer` BEFORE the event you want to fire triggers. Server-rendered pages can push in `<head>`. SPAs must push before calling `gtag` or triggering the Custom Event.

---

## Debugging Reference

### Preview Mode

Activate by clicking Preview in GTM. Opens Tag Assistant in a new tab. Navigate to site URL in a paired browser window.

**Left panel — Event Timeline:**
- Lists every event in session (Page View, DOM Ready, Window Loaded, Custom Events)
- Click an event to see state at that moment

**Right panel — Three tabs at each event:**
- **Tags** — which tags fired (green check), which did not fire (grey), which fired with errors (red)
- **Variables** — all variable values at this event. Check here when debugging undefined values.
- **Data Layer** — the full data layer model state at this event. Shows cumulative pushes.

**Consent tab** — shows consent parameter state (granted/denied) at each event. Available in Tag Assistant.

### Common Preview Mode Checks

| Problem | Where to Look | What to Check |
|---------|--------------|---------------|
| Tag not firing | Tags tab → Not Fired section | Which trigger conditions failed? |
| Undefined parameter value | Variables tab | What is the DLV returning? Is the path correct? |
| Wrong trigger timing | Event Timeline | Did the event fire before or after the push? |
| Consent blocking | Consent tab | Are parameters set correctly? Is default firing first? |
| Duplicate tag fires | Tags tab → Fired section | Is tag using Once Per Page? Multiple triggers attached? |

### Browser Console Inspection

```javascript
// View entire data layer
console.log(JSON.stringify(window.dataLayer, null, 2));

// Filter to specific events
window.dataLayer.filter(d => d.event === 'purchase');

// Check current DL model state (GTM internal — only with Preview active)
// Not available without Preview mode
```

### Network Tab — GA4 Request Inspection

Filter requests by `collect?v=2` or `gtm/` to find GA4 hits.

Key parameters to verify:

| Parameter | Meaning |
|-----------|---------|
| `en` | Event name |
| `epn.transaction_id` | Event parameter — transaction ID |
| `epn.value` | Event parameter — value |
| `gcs` | Consent state (see consent gcs table above) |
| `tid` | Measurement ID (verify it's the right property) |
| `dh` | Document hostname |

### Diagnosing Common Scenarios

**Scenario: Tag shows Fired but event missing in GA4 DebugView**
1. Check Network tab — is there a collect request?
2. If yes: check `tid` matches correct property
3. Check `epn.` parameters — are values present or empty?
4. Check `gcs` — is analytics_storage granted?

**Scenario: Tag shows Not Fired**
1. Click event in timeline where tag should fire
2. Go to Tags tab → Not Fired section → click the tag
3. Read trigger conditions — which condition is false?
4. Go to Variables tab — what value does the condition variable return?

**Scenario: Consent blocking data**
1. Go to Consent tab in Tag Assistant
2. Check `analytics_storage` state at the Page View event
3. If denied: is the CMP update call firing? Did user consent?
4. Check network for `gcs=G100` — both denied
