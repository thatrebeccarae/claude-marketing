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
