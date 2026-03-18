# google-ads


# Google Ads

Expert-level guidance for Google Ads — auditing, building, and optimizing search, shopping, display, video, Performance Max, and demand gen campaigns.

## Core Capabilities

### Campaign Auditing & Optimization
- Full account audit covering structure, settings, bidding, keywords, ads, and tracking
- Quality Score optimization (expected CTR, ad relevance, landing page experience)
- Search term analysis and negative keyword management
- Budget allocation and pacing optimization
- Wasted spend identification and elimination

### Campaign Types
- **Search** — Text ads on Google Search and Search Partners
- **Shopping** — Product Listing Ads from Google Merchant Center
- **Performance Max** — AI-driven cross-channel (Search, Shopping, Display, YouTube, Discover, Gmail, Maps)
- **Display** — Banner/responsive ads across Google Display Network (3M+ sites)
- **Video** — YouTube ads (in-stream, bumper, discovery, shorts)
- **Demand Gen** — Visual-first ads on YouTube, Discover, Gmail
- **App** — App install and engagement campaigns

### Bidding Strategies
- **Manual CPC / Enhanced CPC** — Direct control, good for learning phases
- **Target CPA** — Optimize for cost per conversion
- **Target ROAS** — Optimize for return on ad spend
- **Maximize Conversions / Maximize Conversion Value** — Spend full budget optimally
- **Target Impression Share** — Competitive visibility
- Portfolio bid strategies for cross-campaign optimization

### Audience Strategy
- First-party data: Customer Match, website visitors, app users
- Google audiences: In-market, affinity, detailed demographics, life events
- Custom audiences (by keywords, URLs, apps)
- Remarketing lists for Search Ads (RLSA)
- Optimized targeting vs observation mode
- Audience signals for Performance Max

### Tracking & Measurement
- Google Tag (gtag.js) / Google Tag Manager implementation
- Conversion actions: website, phone calls, app, import, store visits
- Enhanced conversions (first-party data matching)
- Offline conversion import (GCLID / enhanced conversions for leads)
- Google Ads Data Hub and GA4 integration
- Attribution models: data-driven (default), last-click, cross-channel

## Key Benchmarks

| Metric | Good | Great | Warning |
|--------|------|-------|---------|
| Search CTR | 4-6% | 8%+ | <3% |
| Search CPC | Industry dependent | Below industry avg | Rising trend |
| Search Conv Rate | 3-5% | 7%+ | <2% |
| Quality Score | 7-8 | 9-10 | <6 |
| Impression Share (Brand) | 90%+ | 95%+ | <80% |
| Impression Share (Non-Brand) | 40-60% | 70%+ | <30% |
| PMax ROAS | 3-4x | 6x+ | <2x |
| Display CTR | 0.5-1% | 1.5%+ | <0.3% |
| YouTube View Rate | 15-25% | 30%+ | <10% |

## Account Structure Best Practices

```
Account
├── Brand Search (Exact + Phrase match)
│   ├── Pure Brand
│   └── Brand + Product/Service modifiers
├── Non-Brand Search (by theme/intent)
│   ├── High-Intent / Bottom-Funnel keywords
│   ├── Mid-Funnel / Consideration keywords
│   └── Category / Broad keywords
├── Competitor Search (optional)
│   └── Competitor brand terms
├── Shopping (Standard)
│   ├── Top Performers (high priority)
│   ├── Category groups (medium priority)
│   └── Catch-All (low priority)
├── Performance Max
│   ├── Asset Groups by product category or audience theme
│   └── Audience signals per group
├── Display (if separate from PMax)
│   ├── Remarketing
│   └── Prospecting (in-market / custom)
├── YouTube / Video
│   ├── Brand awareness (bumper, in-stream)
│   └── Action / conversions (in-feed, in-stream)
└── Demand Gen
    └── Visual-first prospecting
```

## Workflow: Full Account Audit

When asked to audit a Google Ads account:

1. **Conversion Tracking** — Verify Google Tag, conversion actions, enhanced conversions, attribution model
2. **Account Structure** — Campaign organization, naming conventions, settings consistency
3. **Budget & Bidding** — Allocation across campaigns, bid strategy alignment with goals, target efficiency
4. **Keyword Strategy** — Match types, Quality Scores, search term relevance, negative keyword lists
5. **Ad Copy** — RSA asset quality (headlines, descriptions), pin usage, ad strength, extensions
6. **Shopping / Merchant Center** — Feed quality, disapprovals, competitive metrics, listing groups
7. **Performance Max** — Asset group quality, audience signals, URL expansion settings, cannibalizing Search
8. **Audiences** — First-party lists, remarketing, Customer Match, observation vs targeting
9. **Landing Pages** — Load speed, message match, conversion rate by landing page
10. **Competitive Landscape** — Auction insights, impression share losses (budget vs rank)
11. **Recommendations** — Prioritized by expected revenue impact with effort estimate

## Performance Max Guidance

PMax-specific audit checklist:
- Asset group organization (themes, not catch-all)
- All asset types provided (text, image, video, logo)
- Audience signals configured (not left empty)
- URL expansion settings reviewed (exclude irrelevant pages)
- Search themes added for intent signals
- Brand exclusions applied
- Not cannibalizing high-performing standard Shopping/Search campaigns
- Conversion goals aligned (avoid mixing lead gen and ecommerce)

## How to Use This Skill

Ask me questions like:
- "Audit my Google Ads account and find wasted spend"
- "My Quality Scores are low — help me diagnose and fix"
- "Design a Performance Max campaign structure for my ecommerce store"
- "Should I use Target CPA or Target ROAS?"
- "Help me build a negative keyword strategy"
- "My CPA is increasing — what should I investigate?"
- "Plan a YouTube advertising strategy for brand awareness"
- "Review my Google Merchant Center feed for issues"

For detailed Google Ads API reference, script templates, and advanced configurations, see [REFERENCE.md](REFERENCE.md).

## Hard Rules

These constraints must never be violated in recommendations:

1. **Never recommend Broad Match without Smart Bidding.** Broad Match + Manual CPC = uncontrolled spend.
2. **3x Kill Rule:** Flag any campaign/ad group with CPA >3x target for immediate pause or restructuring.
3. **Enhanced Conversions must be recommended** if not already active. Foundation for data quality.
4. **Consent Mode v2 required** for any account serving EU/EEA traffic.
5. **Negative keyword lists required** — minimum 3 themed lists (Competitor, Jobs, Free, Irrelevant).
6. **Never recommend edits during active learning phase** — wait for learning to complete or reset intentionally.
7. **Brand and non-brand must be separated** into distinct campaigns with independent budgets and bidding.
8. **PMax must have brand exclusions** when a brand Search campaign exists.

## Scored Audit

When performing an account audit, load `skills/shared/scoring-system.md` for the weighted scoring algorithm and `CHECKS.md` for the 74-check Google Ads audit checklist. Produce a health score (0-100, grade A-F) with Quick Wins and a prioritized action plan.

---

# Google Ads Reference

## Account Hierarchy

```
MCC (Manager Account)
└── Account (Client)
    └── Campaign
        └── Ad Group
            ├── Keywords (Search)
            ├── Product Groups (Shopping)
            ├── Asset Groups (Performance Max)
            ├── Ads (RSA, Display, Video)
            └── Audiences (targeting/observation)
```

## Campaign Types & Settings

### Search Campaigns
- **Networks**: Google Search, Search Partners (opt-in/out)
- **Ad Format**: Responsive Search Ads (RSA) — up to 15 headlines (30 chars), 4 descriptions (90 chars)
- **Match Types**: Broad, Phrase, Exact
- **Extensions/Assets**: Sitelinks, callouts, structured snippets, call, location, price, image, lead form, business name/logo

### Shopping Campaigns (Standard)
- **Feed Source**: Google Merchant Center
- **Product Groups**: Category, brand, item ID, condition, product type, channel, custom labels (0-4)
- **Priority**: Low, Medium, High (for multi-campaign strategies)
- **Showcase Shopping Ads**: Collection-style ads (broad queries)

### Performance Max
- **Asset Groups**: Group assets by product category or theme
- **Assets**: Headlines (max 5), long headlines (max 5), descriptions (max 5), images (max 20), logos (max 5), videos (max 5)
- **Audience Signals**: Custom segments, your data (remarketing), interests, demographics
- **Search Themes**: Keyword-like signals (max 25 per asset group)
- **URL Expansion**: On by default — excludes URLs via Page Feeds or final URL expansion settings
- **Listing Groups**: Product feed segmentation (like Shopping product groups)

### Display Campaigns
- **Targeting**: Keywords, placements, topics, audiences, demographics
- **Ad Formats**: Responsive display ads (auto-generated from assets), uploaded image ads
- **Optimized Targeting**: Expands beyond your targeting to find converters

### Video Campaigns (YouTube)
- **Skippable in-stream**: Plays before/during/after videos, skippable after 5s
- **Non-skippable in-stream**: 15-second forced view
- **Bumper**: 6-second non-skippable
- **In-feed (Discovery)**: Thumbnail + text, clicks to watch
- **Shorts**: Vertical video ads in YouTube Shorts feed
- **Bidding**: CPV (views), CPM (impressions), Target CPA (conversions)

### Demand Gen Campaigns
- Visual-first ads on YouTube (in-feed, Shorts), Discover, Gmail
- Product feeds supported for e-commerce
- Lookalike segments from first-party lists
- A/B creative experiments built-in

## Keyword Reference

### Match Type Behavior (Current)
| Type | Syntax | What It Matches |
|------|--------|-----------------|
| Broad | running shoes | Related queries, synonyms, implied intent |
| Phrase | "running shoes" | Queries that include the meaning of your keyword |
| Exact | [running shoes] | Queries with same meaning/intent |

Note: All match types now use intent matching. Broad match is significantly broader than legacy behavior and works best with Smart Bidding.

### Negative Keywords
| Type | Syntax | Blocks |
|------|--------|--------|
| Broad negative | running shoes | Queries containing ALL negative terms (any order) |
| Phrase negative | "running shoes" | Queries containing phrase in order |
| Exact negative | [running shoes] | Only that exact query |

### Quality Score (1-10)
- **Expected CTR**: Historical CTR of your ad for this keyword
- **Ad Relevance**: How well your ad matches keyword intent
- **Landing Page Experience**: Relevance, load speed, mobile-friendliness, trustworthiness
- Impact: Higher QS = lower CPC, better positions

## Bidding Strategies

### Portfolio & Standard Strategies
| Strategy | Goal | When to Use |
|----------|------|-------------|
| Manual CPC | Full control | Testing, low data |
| Enhanced CPC (eCPC) | Semi-automated | Transitioning to automation |
| Maximize Clicks | Most clicks | Traffic, awareness |
| Maximize Conversions | Most conversions | Volume goal, uncapped budget |
| Maximize Conv. Value | Most revenue | Revenue goal, uncapped budget |
| Target CPA | Specific CPA | Efficiency with volume |
| Target ROAS | Specific ROAS | Revenue efficiency |
| Target Impression Share | Visibility | Brand defense, competitive |

### Smart Bidding Signals Used
- Device, location, time of day, day of week
- Remarketing list membership
- Browser, OS, language
- Ad characteristics
- Search query (broad match + Smart Bidding is powerful)
- Actual search query (not just keyword)

### Learning Period
- ~7 days after bid strategy change
- Need 30+ conversions in last 30 days for Target CPA
- Need 50+ conversions for Target ROAS
- Avoid making changes during learning period

## Audience Types

### Your Data (First-Party)
| Audience | Source | Min Size |
|----------|--------|----------|
| Website visitors | Google Tag | 1,000 (Search), 100 (Display) |
| App users | Firebase/SDK | 1,000 |
| Customer Match | Email/phone/address upload | 1,000 |
| YouTube users | Channel interactions | 1,000 |

### Google Audiences
| Type | Description |
|------|-------------|
| In-market | Actively researching/comparing products |
| Affinity | Long-term interests and lifestyles |
| Detailed Demographics | Parental status, marital, education, homeowner |
| Life Events | Recently married, moved, graduated, started business |
| Custom Segments | Your keywords + URLs + apps = custom intent |
| Similar Segments | Deprecated (replaced by optimized targeting) |

### Targeting vs Observation
- **Targeting**: Only show ads to this audience (restricts reach)
- **Observation**: Show to everyone, add bid adjustments for audience (monitor performance)
- RLSA: Remarketing lists for Search Ads — bid higher for returning visitors in Search

## Conversion Tracking

### Google Tag (gtag.js)
```html
<!-- Global site tag -->
<script async src="https://www.googletagmanager.com/gtag/js?id=AW-CONVERSION_ID"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'AW-CONVERSION_ID');
</script>

<!-- Conversion event -->
<script>
  gtag('event', 'conversion', {
    'send_to': 'AW-CONVERSION_ID/CONVERSION_LABEL',
    'value': 99.99,
    'currency': 'USD',
    'transaction_id': 'TXN-12345'
  });
</script>
```

### Enhanced Conversions
```html
<!-- Enhanced conversion data (hashed automatically) -->
<script>
  gtag('set', 'user_data', {
    'email': 'customer@example.com',
    'phone_number': '+11234567890',
    'address': {
      'first_name': 'Jane',
      'last_name': 'Doe',
      'street': '123 Main St',
      'city': 'Austin',
      'region': 'TX',
      'postal_code': '78701',
      'country': 'US'
    }
  });
</script>
```

### Offline Conversion Import
```csv
# GCLID-based import
Google Click ID,Conversion Name,Conversion Time,Conversion Value,Conversion Currency
CjwKCAjw...,Purchase,2024-01-15 10:30:00+0000,99.99,USD
```
- Import via Google Ads UI, API, or Google Sheets linked
- GCLID valid for 90 days
- Enhanced conversions for leads: use user-provided data instead of GCLID

### Attribution Models
| Model | Description | Default? |
|-------|-------------|----------|
| Data-Driven | ML-based, distributes credit across touchpoints | Yes (default) |
| Last Click | 100% credit to last-clicked ad | Legacy option |
| Cross-Channel | Data-driven across Google properties | Newer |

## Google Merchant Center Reference

### Required Feed Attributes
| Attribute | Description | Requirements |
|-----------|-------------|--------------|
| id | Unique product identifier | Max 50 chars, stable |
| title | Product title | Max 150 chars (first 70 matter most) |
| description | Product description | Max 5000 chars |
| link | Product landing page URL | Must match website |
| image_link | Main product image | Min 100x100px, no watermarks |
| price | Product price | Include currency, match landing page |
| availability | Stock status | in_stock, out_of_stock, preorder |
| brand | Product brand | Required for most categories |
| gtin | Global Trade Item Number | Required when available |
| condition | new, refurbished, used | Required |

### Feed Optimization Tips
- **Title formula**: Brand + Product Type + Key Attributes (color, size, material)
- **Custom Labels (0-4)**: Use for campaign segmentation (margin tier, best seller, seasonal, new)
- **Product Type**: Your own categorization (more specific than google_product_category)
- **Supplemental feeds**: Add data without modifying primary feed

### Common Disapproval Reasons
- Price mismatch between feed and landing page
- Missing GTIN (required for branded products)
- Image doesn't meet requirements (size, watermarks, promotional overlays)
- Policy violations (prohibited content, misleading claims)
- Shipping/tax information missing
- Automatic item updates can fix some mismatches

## Scripts & Automation

### Google Ads Scripts (JavaScript)
```javascript
// Example: Pause keywords with Quality Score < 4
function main() {
  var keywordIterator = AdsApp.keywords()
    .withCondition("QualityScore < 4")
    .withCondition("Status = ENABLED")
    .get();

  while (keywordIterator.hasNext()) {
    var keyword = keywordIterator.next();
    Logger.log("Pausing: " + keyword.getText() + " (QS: " + keyword.getQualityScore() + ")");
    keyword.pause();
  }
}
```

### Google Ads API (REST)
```
Base URL: https://googleads.googleapis.com/v16/

# Authentication: OAuth 2.0 + Developer Token
Headers:
  Authorization: Bearer {access_token}
  developer-token: {developer_token}
  login-customer-id: {mcc_id}

# GAQL (Google Ads Query Language)
POST /customers/{customer_id}/googleAds:searchStream
{
  "query": "SELECT campaign.name, metrics.impressions, metrics.clicks, metrics.cost_micros FROM campaign WHERE segments.date DURING LAST_30_DAYS ORDER BY metrics.impressions DESC"
}
```

### Common GAQL Queries
```sql
-- Campaign performance
SELECT campaign.name, campaign.status, metrics.impressions, metrics.clicks,
       metrics.conversions, metrics.cost_micros, metrics.conversions_value
FROM campaign
WHERE segments.date DURING LAST_30_DAYS
  AND campaign.status = 'ENABLED'
ORDER BY metrics.cost_micros DESC

-- Search term report
SELECT search_term_view.search_term, search_term_view.status,
       metrics.impressions, metrics.clicks, metrics.conversions, metrics.cost_micros
FROM search_term_view
WHERE segments.date DURING LAST_7_DAYS
ORDER BY metrics.impressions DESC
LIMIT 100

-- Quality Score analysis
SELECT ad_group_criterion.keyword.text,
       ad_group_criterion.quality_info.quality_score,
       ad_group_criterion.quality_info.creative_quality_score,
       ad_group_criterion.quality_info.post_click_quality_score,
       ad_group_criterion.quality_info.search_predicted_ctr
FROM keyword_view
WHERE ad_group_criterion.status = 'ENABLED'
ORDER BY ad_group_criterion.quality_info.quality_score ASC
```

## Key Metrics Glossary

| Metric | Formula / Definition |
|--------|---------------------|
| CTR | Clicks / Impressions |
| CPC | Cost / Clicks |
| CPA | Cost / Conversions |
| ROAS | Conversion Value / Cost |
| Conv. Rate | Conversions / Clicks |
| Impression Share | Impressions / Total Eligible Impressions |
| Lost IS (Budget) | % lost due to budget |
| Lost IS (Rank) | % lost due to Ad Rank |
| Search Top IS | Impressions in top positions / eligible |
| Absolute Top IS | Impressions in #1 position / eligible |
