# GTM Skill — Examples

Realistic worked examples showing how to use the GTM skill for container audits, consent mode setup, tag firing debug, and server-side GTM advisory.

---

## 1. Full Container Audit

**User Request:**
> "Audit our GTM container. We think some tags are not firing correctly and we are not sure our consent setup is right. We have GA4, Google Ads, and Meta Pixel running."

**Analysis Steps:**
1. Request the container export (JSON) or a screenshot of the tag/trigger/variable lists
2. Build tag inventory table — name, type, status, trigger, firing options
3. Build trigger inventory — name, type, conditions, which tags use it
4. Check variable list for undefined DLVs and missing constant patterns
5. Check for consent mode tags and their trigger assignments
6. Cross-reference tag types against trigger types to identify scoping issues
7. Compile findings by severity and produce prioritized recommendations

**Sample Output:**

### Container Overview

| Metric | Value |
|--------|-------|
| Total tags | 18 |
| Enabled | 15 |
| Paused | 3 |
| Total triggers | 14 |
| Total variables | 22 |
| Workspaces | 2 active (Default Workspace + "agency-meta") |
| Last published | 6 weeks ago |
| Last publisher | agency@partner.com |

### Tag Inventory

| Tag Name | Type | Status | Firing Trigger | Firing Options | Issue |
|----------|------|--------|---------------|---------------|-------|
| Google Analytics - Universal Analytics | UA legacy | Enabled | All Pages | Unlimited | UA sunsetted July 2024 — dead tag |
| GA4 - Pageview | GA4 Config (gaawc) | Enabled | All Pages | Unlimited | Hardcoded measurement ID |
| GA4 - Pageview v2 | GA4 Config (gaawc) | Enabled | All Pages | Unlimited | Duplicate config tag |
| GA4 - Purchase | GA4 Event (gaawe) | Enabled | CE -- purchase | Once per event | Config tag refs duplicate (v2) |
| GA4 - Add to Cart | GA4 Event (gaawe) | Enabled | CE -- add_to_cart | Unlimited | OK |
| GA4 - View Item | GA4 Event (gaawe) | Paused | CE -- view_item | Unlimited | Paused — why? |
| Google Ads - Purchase Conversion | Ads Conversion | Enabled | CE -- purchase | Unlimited | Missing deduplication tag ID |
| Google Ads - Remarketing | Ads Remarketing | Enabled | All Pages | Unlimited | All Pages on remarketing tag |
| Meta Pixel - Base | Custom HTML | Enabled | All Pages | Unlimited | Should use Template Gallery |
| Meta Pixel - Purchase | Custom HTML | Enabled | CE -- purchase | Unlimited | Should use Template Gallery |
| Meta Pixel - ViewContent | Custom HTML | Enabled | PV -- all-pages | Unlimited | Over-broad trigger for purchase intent event |
| HotJar | Custom HTML | Enabled | All Pages | Unlimited | Template Gallery alternative exists |
| LinkedIn Insight | Custom HTML | Paused | All Pages | Unlimited | Template exists; update and re-enable |
| Consent Default | — | Missing | — | — | No consent mode configured |
| CMP Template | — | Missing | — | — | No CMP template installed |

### Key Findings

**Finding 1 — No Consent Mode (Compliance Critical)**
No consent default tag exists. No CMP template installed. GA4 and Google Ads tags fire unconditionally for all visitors including EU/EEA users. This is a compliance failure for GDPR and Google's EU User Consent Policy. Google Ads conversion modeling is also unavailable without consent mode v2.

**Finding 2 — Duplicate GA4 Configuration Tags**
Two `gaawc` tags exist: "GA4 - Pageview" (older, hardcoded measurement ID) and "GA4 - Pageview v2" (same trigger). Duplicate config tags can cause double-counting of pageviews and session inflation. The purchase event tag references the newer one; other event tags may reference either. Remove the older tag and migrate all references to one config tag.

**Finding 3 — Dead Universal Analytics Tag**
"Google Analytics - Universal Analytics" is still enabled and firing on All Pages. UA was fully sunsetted July 2024 — this tag sends data to a dead property. It adds page load overhead with no benefit. Delete it.

**Finding 4 — Meta Pixel via Custom HTML (Three Tags)**
All Meta Pixel tags use Custom HTML. The Meta Pixel community template exists in the Template Gallery and is consent-mode aware. Custom HTML runs unsandboxed, creates CSP risk, and does not automatically respond to consent signals. Replace all three with the official Meta Pixel template.

**Finding 5 — Google Ads Remarketing on All Pages**
Remarketing tag fires on every page view. Recommended: add page type parameter to segment by funnel stage (home, category, product, cart, checkout, purchase). Firing on all pages with no segmentation limits audience list quality.

**Finding 6 — Hardcoded Measurement IDs**
GA4 config tag has the measurement ID hardcoded in the tag settings. Create a `Const -- GA4 Measurement ID` variable and reference it. Same pattern needed for Google Ads Conversion ID.

### Prioritized Recommendations

| Priority | Action | Impact | Effort |
|----------|--------|--------|--------|
| 1 | Implement consent mode v2 (consent default + CMP template) | Compliance risk eliminated; modeling enabled | Medium |
| 2 | Remove duplicate GA4 config tag and dead UA tag | Data accuracy; container hygiene | Low |
| 3 | Replace Custom HTML Meta Pixel tags with Template Gallery | Security; consent signal integration | Medium |
| 4 | Add deduplication tag ID to Google Ads conversion tag | Prevents duplicate conversion reporting | Low |
| 5 | Move measurement IDs to constant variables | Maintainability | Low |
| 6 | Scope Google Ads Remarketing trigger to page types | Audience quality improvement | Low |
| 7 | Investigate and re-enable paused View Item tag | Missing funnel data for add-to-cart optimization | Low |

---

## 2. Consent Mode v2 Setup

**User Request:**
> "We sell to EU customers and need consent mode set up in GTM. We use Cookiebot as our CMP. We have GA4 and Google Ads. Currently no consent mode is configured."

**Analysis Steps:**
1. Confirm current state — no consent default, no CMP template, tags fire unconditionally
2. Identify the Cookiebot community template in GTM Template Gallery
3. Define implementation sequence (consent default before everything)
4. Configure region-specific defaults for EU vs non-EU
5. Verify existing GA4 and Google Ads tags have built-in consent checks enabled
6. Provide verification steps using Preview mode Consent tab

**Current State**

No consent mode configured. GA4 and Google Ads tags fire on All Pages trigger with no consent checks. All EU/EEA visitors receive full tracking without a consent signal.

**Step-by-Step Implementation**

**Step 1: Create Consent Initialization trigger**
- Go to Triggers → New
- Trigger Type: Consent Initialization
- Name: `Consent -- init`
- No conditions (fires for all pages)

**Step 2: Create Consent Default tag**
- Go to Tags → New
- Tag Type: Custom HTML
- Name: `Consent -- Default`
- Firing Trigger: `Consent -- init` (from Step 1)

```html
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}

  // EU/EEA visitors: all denied by default
  gtag('consent', 'default', {
    'ad_storage': 'denied',
    'ad_user_data': 'denied',
    'ad_personalization': 'denied',
    'analytics_storage': 'denied',
    'wait_for_update': 500,
    'region': ['AT','BE','BG','CY','CZ','DE','DK','EE','ES','FI',
               'FR','GR','HR','HU','IE','IS','IT','LI','LT','LU',
               'LV','MT','NL','NO','PL','PT','RO','SE','SI','SK']
  });

  // All other regions: all granted by default
  gtag('consent', 'default', {
    'ad_storage': 'granted',
    'ad_user_data': 'granted',
    'ad_personalization': 'granted',
    'analytics_storage': 'granted'
  });

  // Preserve ad click data when ad_storage denied
  gtag('set', 'url_passthrough', true);
  gtag('set', 'ads_data_redaction', true);
</script>
```

**Step 3: Install Cookiebot CMP community template**
- Go to Templates → Search Gallery
- Search "Cookiebot"
- Click "Cookiebot CMP" (published by Cookiebot)
- Add to workspace

**Step 4: Create Cookiebot CMP tag**
- Go to Tags → New
- Tag Type: Cookiebot CMP (from gallery)
- Name: `CMP -- Cookiebot -- All Pages`
- Cookiebot Domain Group ID: `[your domain group ID from Cookiebot dashboard]`
- Mode: Automatic (recommended)
- Firing Trigger: Page View - All Pages

**Step 5: Verify existing GA4 and Google Ads tags**
- Open each GA4 and Google Ads tag
- Under Advanced Settings → Consent Settings
- Confirm "Require additional consent for tag to fire" is NOT set (built-in consent checks handle this automatically for GA4/Ads tags when consent mode is active)

**Step 6: Publish and verify in Preview mode**
1. Click Preview in GTM
2. Navigate to site in paired browser window
3. Click the "Consent" tab in Tag Assistant
4. Check consent state at each event

**Verification Checklist**

| Check | Pass Criteria |
|-------|--------------|
| Consent Default fires first | "Consent -- Default" appears before all other tags in event timeline |
| All four parameters present | `analytics_storage`, `ad_storage`, `ad_user_data`, `ad_personalization` all show in Consent tab |
| EU visitor — banner shown, deny | Consent tab shows all four parameters as `denied` |
| EU visitor — banner accepted | Consent tab shows all four parameters as `granted` |
| Non-EU visitor | Consent tab shows all four parameters as `granted` (no banner needed) |
| GA4 tag consent check | GA4 collect request shows `gcs=G100` on deny, `gcs=G111` on grant |
| CMP template fires | Cookiebot tag shows as Fired in Tags tab |

**Expected Behavior After Implementation**

| Visitor | Scenario | GA4 Data | Google Ads Modeling |
|---------|----------|----------|---------------------|
| EU visitor | Denies consent | Cookieless pings only (Advanced mode) — no personal data | Google models conversions from anonymous signals |
| EU visitor | Accepts consent | Full tracking | Full attribution |
| Non-EU visitor | No banner | Full tracking | Full attribution |
| EU visitor | Ignores banner (timeout) | `wait_for_update: 500ms` expires → denied defaults apply | Cookieless pings |

---

## 3. Tag Firing Debug — Undefined Purchase Value

**User Request:**
> "Our GA4 purchase event is firing but the transaction value shows as undefined in DebugView. The tag is definitely firing — I can see it in Preview mode. The purchase tag worked fine until two weeks ago."

**Analysis Steps:**
1. Ask diagnostic questions to narrow the scope
2. Walk through Preview mode systematically at the purchase event
3. Identify the variable path mismatch
4. Confirm fix and verify in Preview mode

**Diagnostic Questions**

Before debugging: clarify the environment.

- What platform is the site on? (Shopify, custom, headless)
- Is this a recent code change on the site two weeks ago?
- What does the Data Layer tab show for the purchase event in Preview mode?
- What is the Data Layer Variable path configured for the value parameter?

**Preview Mode Walkthrough**

**Step 1: Activate Preview mode**
- Click Preview in GTM (top right)
- Navigate to the store and complete a test purchase (or use order confirmation URL directly)

**Step 2: Find the purchase event in the timeline**
- Left panel — look for `purchase` custom event in the event list
- If not visible, check that the `dataLayer.push({ event: 'purchase', ... })` is firing on the page

**Step 3: Check the Data Layer tab at the purchase event**
- Click the `purchase` event in the left panel
- Click the Data Layer tab in the right panel
- Look for the `ecommerce` object

What you should see (GA4 format):
```
ecommerce: {
  transaction_id: "T12345",
  value: 89.99,
  currency: "USD",
  items: [...]
}
```

What may be present instead (UA legacy format):
```
ecommerce: {
  purchase: {
    actionField: {
      id: "T12345",
      revenue: "89.99"
    },
    products: [...]
  }
}
```

**Step 4: Check the Variables tab at the purchase event**
- Click Variables tab (same event selected)
- Find the DLV variable used in the GA4 purchase tag value parameter
- Read the value it resolved to

If it shows `undefined`, the variable path does not match the actual data layer structure.

**Step 5: Open the GA4 purchase tag and check the value parameter**
- Go to GA4 Purchase tag settings
- Check the value parameter — which variable is it referencing?
- Open that variable — what is the Data Layer Variable Name configured?

**Root Cause Identified**

The Data Layer Variable path is configured as `ecommerce.purchase.value` (Universal Analytics nested format). Two weeks ago, the development team updated the ecommerce data layer pushes to GA4 format. The GA4 format uses `ecommerce.value` (flat), not `ecommerce.purchase.value` (nested UA format).

The tag fires successfully — it just sends `undefined` for the value parameter because the variable path no longer matches the data layer structure.

**Fix**

1. Open the Data Layer Variable used for purchase value
2. Change the Data Layer Variable Name from:
   - `ecommerce.purchase.value` (old UA format)
3. To:
   - `ecommerce.value` (GA4 flat format)
4. Check the same issue for related variables:
   - `ecommerce.purchase.actionField.id` → `ecommerce.transaction_id`
   - `ecommerce.purchase.actionField.revenue` → `ecommerce.value`
   - `ecommerce.products` → `ecommerce.items`

**Verify the Fix**

1. Go back to Preview mode
2. Navigate to order confirmation page
3. Click `purchase` event in timeline
4. Variables tab — confirm the value DLV now shows a numeric value (not undefined)
5. Tags tab — confirm GA4 purchase tag fired
6. Network tab — find the GA4 collect request, confirm `epn.value` parameter has the correct value

**Prevention Note**

When the development team updates ecommerce data layer schema (UA → GA4 migration is common), GTM variable paths must be updated to match. Maintain a Solution Design Reference (SDR) document mapping every GTM variable to its data layer path — this makes migrations visible and auditable.

---

## 4. Server-Side GTM Advisory

**User Request:**
> "We are losing about 15-20% of our GA4 data to ad blockers and our Meta CAPI is not set up. Should we go server-side with GTM? We're a DTC brand on Shopify, about $2M annual revenue, two-person marketing team."

**Analysis Steps:**
1. Evaluate the decision criteria against their situation
2. Provide architecture recommendation
3. Clarify what moves server-side vs stays client-side
4. Explain consent state passing requirement
5. Outline implementation phases with effort estimate

**Decision Framework**

| Factor | Their Situation | Weight |
|--------|----------------|--------|
| Ad blocker loss | 15-20% of GA4 data — significant | High |
| Privacy requirements | Shopify DTC, EU traffic but not primary market | Medium |
| Meta CAPI need | Not set up — sGTM enables this | High |
| Budget | $2M revenue — $30-50/mo hosting is viable | Low concern |
| Technical capacity | 2-person marketing team — no dedicated engineer | Medium concern |
| Data enrichment needs | Standard DTC tracking — no special server signals | Low |

**Recommendation: Yes, go server-side — hybrid approach**

Server-side GTM is appropriate for this situation. The primary drivers are:
1. 15-20% ad blocker data loss is recoverable — sGTM requests come from a server IP, not the browser, so ad blockers cannot intercept them
2. Meta CAPI requires server-to-server calls — sGTM's server container handles this natively without custom API code
3. Shopify DTC at $2M revenue can absorb the $30-50/month hosting cost with meaningful ROI from improved data quality

The 2-person team concern is real but manageable. Stape.io (managed sGTM hosting) removes infrastructure complexity and is worth the additional cost.

**Hybrid Architecture**

Not everything moves server-side. The recommended split:

| Stays Client-Side | Moves Server-Side |
|-----------------|-----------------|
| Consent mode default + CMP | GA4 event forwarding |
| GTM Preview/debug mode | Google Ads conversion tracking |
| Any tag needing DOM access | Meta CAPI (Conversions API) |
| Core Web Vitals tags | Server-side data enrichment (if needed later) |
| First-party cookie reads | |

**Architecture Diagram**

```
Browser (Shopify storefront)
  |
  +-- Client-side GTM container (web)
        |
        +-- Consent default + Cookiebot CMP
        |
        +-- GA4 measurement (sends to sGTM endpoint)
        |
        +-- sGTM forwarding tag (sends events to sGTM)
              |
              +-- sGTM Endpoint (Stape.io or GCP)
                    |
                    +-- GA4 Client (receives events)
                    |
                    +-- Server container
                          |
                          +-- GA4 tag → GA4 property
                          +-- Google Ads tag → Google Ads
                          +-- Meta CAPI tag → Meta Events API
```

**Critical: Consent State Passing**

The server container has no automatic access to the user's consent choice. It must be explicitly passed.

Required: Include consent state parameters in the request from the client-side container to the sGTM endpoint. The sGTM GA4 Client forwards consent state from the incoming request. Verify that the data stream configuration in GA4 has consent mode integration enabled.

Without this, the server container fires tags for users who have denied consent — a compliance failure.

**Implementation Phases**

| Phase | Work | Effort |
|-------|------|--------|
| 1 | Set up sGTM container in Stape.io, configure GCP connection | 2-3 hours |
| 2 | Add sGTM forwarding tag to client-side container, test in Preview | 2-3 hours |
| 3 | Configure GA4 client in server container, verify GA4 data flows | 2-3 hours |
| 4 | Set up Meta CAPI server tag — Pixel ID + access token, event deduplication | 3-4 hours |
| 5 | Configure Google Ads server tag, deduplication from client-side | 2 hours |
| 6 | QA: compare client-side vs server-side hit counts, verify consent passing | 2-3 hours |

**Total estimated setup: 13-18 hours one-time, best split across 2-3 sessions**

**Cost Estimate**

| Option | Monthly Cost | Notes |
|--------|-------------|-------|
| Stape.io Starter | $9/mo | Limited to 300K events/mo — suitable for lower-volume DTC |
| Stape.io Pro | $49/mo | 3M events/mo — suitable for most DTC at $2M revenue |
| GCP App Engine (self-managed) | ~$30-50/mo | 3 instances; requires GCP setup comfort |

**Expected Outcome After Implementation**

- GA4 data loss from ad blockers: 15-20% → approximately 2-5% (some browsers block even first-party endpoints)
- Meta CAPI event match quality: new baseline — typically 70-85% match rate vs 40-60% pixel-only
- Google Ads conversion modeling: improved signal quality with server-side deduplication
- Data quality improvement generally worth the setup cost within the first quarter
