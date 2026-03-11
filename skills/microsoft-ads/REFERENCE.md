# Microsoft Ads Reference

## Account Hierarchy

```
Customer (MCC)
└── Account
    └── Campaign
        └── Ad Group
            ├── Keywords (Search)
            ├── Product Groups (Shopping)
            ├── Ads (RSA, Dynamic, Product)
            └── Audiences (targeting/observation)
```

## Campaign Types & Settings

### Search Campaigns
- **Networks**: Bing, AOL, Yahoo, DuckDuckGo, partner sites
- **Ad Format**: Responsive Search Ads (RSA) — up to 15 headlines, 4 descriptions
- **Match Types**: Broad, Phrase, Exact (same syntax as Google: keyword, "keyword", [keyword])
- **Ad Extensions**: Sitelinks, callouts, structured snippets, call, location, price, image, action, flyer

### Shopping Campaigns
- **Feed Source**: Microsoft Merchant Center (separate from Google Merchant Center)
- **Product Groups**: Subdivide by category, brand, condition, product type, custom label, item ID
- **Priority Levels**: Low (0), Medium (1), High (2) — higher priority campaigns match first
- **Local Inventory Ads**: Show in-store availability

### Audience Campaigns (Microsoft Audience Network)
- Native ads on MSN, Outlook.com, Microsoft Edge, Microsoft Start
- Image and video ad formats
- Audience targeting required (in-market, custom, remarketing)
- Automated bidding recommended

### Performance Max
- Cross-network automation (Search, Shopping, Audience, Display)
- Asset groups with text, image, video assets
- Audience signals (suggestions, not hard constraints)
- URL expansion settings

### Dynamic Search Ads (DSA)
- Auto-generated ads from website content
- Target by: all webpages, specific categories, or URL rules
- Good for long-tail keyword coverage

## Keyword Reference

### Match Type Behavior
| Type | Syntax | Matches |
|------|--------|---------|
| Broad | running shoes | running shoes, jogging sneakers, athletic footwear |
| Phrase | "running shoes" | best running shoes, running shoes near me |
| Exact | [running shoes] | running shoes, running shoe |

### Negative Keywords
- Apply at campaign or ad group level
- Shared negative keyword lists across campaigns
- Match types: broad negative, phrase negative, exact negative
- Broad negative: blocks if ALL words present (any order)

### Quality Score Components
- **Expected CTR** — How likely your ad gets clicked (Above/Average/Below)
- **Ad Relevance** — How well your ad matches the keyword intent
- **Landing Page Experience** — Quality, relevance, load speed of landing page
- Score: 1-10 (aim for 7+)

## Audience Types

### LinkedIn Profile Targeting (Microsoft Exclusive)
```
Targeting options:
├── Company — Target by company name (100+ employees)
├── Industry — Company industry vertical
└── Job Function — User's job function category
```
- Available for Search, Shopping, and Audience campaigns
- Layer on top of keyword targeting for B2B refinement
- Bid adjustments: -90% to +900%

### Other Audience Types
| Audience | Description |
|----------|-------------|
| In-market | Users actively researching/comparing products |
| Custom | Created from keywords, URLs, or app names |
| Remarketing | Website visitors (UET), customer lists, app activity |
| Similar | Lookalike audiences based on remarketing lists |
| Combined | AND/OR logic across multiple audiences |
| Customer Match | Email/phone list upload for matching |
| Dynamic Remarketing | Product-specific retargeting from feed |

## UET (Universal Event Tracking)

### Tag Installation
```html
<!-- UET Base Tag -->
<script>
(function(w,d,t,r,u){
  var f,n,i;
  w[u]=w[u]||[];
  f=function(){
    var o={ti:"YOUR_TAG_ID",enableAutoSpa498:true};
    o.q=w[u];
    w[u]=new UET(o);
    w[u].push("pageLoad");
  };
  n=d.createElement(t);
  n.src=r;
  n.async=1;
  n.onload=n.onreadystatechange=function(){
    var s=this.readyState;
    s&&s!=="loaded"&&s!=="complete"||(f(),n.onload=n.onreadystatechange=null);
  };
  i=d.getElementsByTagName(t)[0];
  i.parentNode.insertBefore(n,i);
})(window,document,"script","//bat.bing.com/bat.js","uetq");
</script>
```

### Conversion Goals
| Type | Description |
|------|-------------|
| URL | Page visit (e.g., /thank-you) |
| Event | Custom event firing |
| Duration | Session longer than X seconds |
| Pages Per Visit | More than X pages viewed |
| App Install | Mobile app installation |

### Custom Event Tracking
```javascript
// Track a conversion event
window.uetq = window.uetq || [];
window.uetq.push('event', 'purchase', {
  'revenue_value': 99.99,
  'currency': 'USD',
  'transaction_id': 'TXN-12345'
});

// Track a custom event
window.uetq.push('event', 'add_to_cart', {
  'ecomm_prodid': 'SKU123',
  'ecomm_pagetype': 'product',
  'revenue_value': 49.99
});
```

### Offline Conversion Import
```csv
# Required columns
Microsoft Click ID,Conversion Name,Conversion Time,Conversion Value,Conversion Currency
CjwKCAjw...,Purchase,2024-01-15 10:30:00,99.99,USD
```
- Upload via Microsoft Ads UI or API
- GCLID (Microsoft Click ID) captured from ad click URL parameter `msclkid`
- Import within 90 days of click

## Bid Strategies

| Strategy | Description | Best For |
|----------|-------------|----------|
| Manual CPC | Set bids manually per keyword | Control, testing |
| Enhanced CPC | Manual + auto-adjustments (up to 30%) | Moderate automation |
| Maximize Clicks | Auto-bid for most clicks within budget | Traffic goals |
| Maximize Conversions | Auto-bid for most conversions | Volume goals |
| Target CPA | Auto-bid targeting specific cost per conversion | Efficiency goals |
| Target ROAS | Auto-bid targeting specific return on ad spend | Revenue goals |
| Target Impression Share | Auto-bid for ad position | Visibility goals |

### Bid Adjustments
| Dimension | Range |
|-----------|-------|
| Device | -100% to +900% |
| Location | -90% to +900% |
| Ad Schedule | -90% to +900% |
| Age | -90% to +900% |
| Gender | -90% to +900% |
| Audience (LinkedIn, etc.) | -90% to +900% |
| Network (Search Partners) | -100% to +900% |

## Google Ads Import

### What Imports
- Campaign structure, settings, budgets
- Ad groups, keywords, negative keywords
- Responsive Search Ads, Dynamic Search Ads
- Sitelinks, callouts, structured snippets
- Audiences and bid adjustments
- Shopping campaigns (requires separate Merchant Center)

### What Doesn't Import (or Needs Adjustment)
- Performance Max (limited import support)
- Display campaigns (different network)
- Discovery/Demand Gen campaigns
- App campaigns
- Some automated bid strategies may reset
- Merchant Center feed (must set up separately)

### Post-Import Optimization
1. Review bid strategies — may need to reset learning period
2. Check all extensions imported correctly
3. Add LinkedIn Profile Targeting (Microsoft-exclusive)
4. Review search partner settings
5. Adjust budgets — Microsoft typically needs lower budgets for similar impression share
6. Check negative keyword lists transferred
7. Set up UET conversion tracking (separate from Google Tag)

## API Reference (Bing Ads API)

### Base URL
```
https://bingads.microsoft.com/CampaignManagement/v13/
```

### Authentication
- OAuth 2.0 with Microsoft Account
- Developer Token required
- Client ID and Client Secret from Azure AD app

### Key Service Operations

#### Campaign Management
```
AddCampaigns, UpdateCampaigns, DeleteCampaigns, GetCampaignsByAccountId
AddAdGroups, UpdateAdGroups, GetAdGroupsByIds
AddKeywords, UpdateKeywords, GetKeywordsByAdGroupId
AddAds, UpdateAds, GetAdsByAdGroupId
```

#### Reporting
```
SubmitGenerateReport — Async report generation
PollGenerateReport — Check report status
Available reports: KeywordPerformance, SearchQuery, AudiencePerformance, ShareOfVoice
```

#### Bulk Operations
```
DownloadCampaignsByAccountIds — Full account download
GetBulkUploadUrl — Upload changes in bulk
```

### Reporting Dimensions & Metrics
| Dimension | Description |
|-----------|-------------|
| TimePeriod | Date aggregation (Day, Week, Month) |
| CampaignName | Campaign level |
| AdGroupName | Ad group level |
| Keyword | Keyword level |
| DeviceType | Computer, Smartphone, Tablet |
| Network | Bing and Yahoo, Syndicated |

| Metric | Description |
|--------|-------------|
| Impressions | Times ad shown |
| Clicks | Times ad clicked |
| Spend | Total cost |
| Conversions | Conversion count |
| Revenue | Conversion value |
| QualityScore | 1-10 score |
| ImpressionSharePercent | % of available impressions won |

## Microsoft Clarity Integration

Microsoft Clarity (free analytics) can be linked to Microsoft Ads:
- Session recordings for ad landing pages
- Heatmaps showing click and scroll behavior
- Rage clicks and dead clicks identification
- Smart sessions filtering by campaign/ad group
- No sampling, unlimited traffic, free

### Setup
```html
<script type="text/javascript">
(function(c,l,a,r,i,t,y){
  c[a]=c[a]||function(){(c[a].q=c[a].q||[]).push(arguments)};
  t=l.createElement(r);t.async=1;t.src="https://www.clarity.ms/tag/"+i;
  y=l.getElementsByTagName(r)[0];y.parentNode.insertBefore(t,y);
})(window,document,"clarity","script","YOUR_PROJECT_ID");
</script>
```
