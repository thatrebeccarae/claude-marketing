# facebook-ads


# Meta Ads (Facebook & Instagram)

Expert-level guidance for Meta Ads — auditing, building, and optimizing campaigns across Facebook, Instagram, Messenger, and the Audience Network.

## Core Capabilities

### Campaign Auditing & Optimization
- Full account audit: structure, objectives, audiences, creative, tracking, attribution
- Identify creative fatigue, audience overlap, and budget inefficiencies
- Diagnose performance drops (iOS privacy, audience saturation, creative burnout)
- Advantage+ Shopping and Advantage+ Audience recommendations

### Campaign Objectives (Outcome-Based)
- **Awareness** — Reach, brand awareness, video views
- **Traffic** — Link clicks, landing page views
- **Engagement** — Post engagement, messages, conversions on-platform
- **Leads** — Instant Forms, Messenger, website lead gen
- **App Promotion** — App installs, app events
- **Sales** — Website conversions, catalog sales, Advantage+ Shopping

### Audience Strategy
- **Core Audiences** — Demographics, interests, behaviors, location
- **Custom Audiences** — Website (pixel/CAPI), customer list, app activity, video viewers, engagement
- **Lookalike Audiences** — 1-10% based on custom audience seed (value-based LALs preferred)
- **Advantage+ Audience** — Meta's AI-driven targeting (audience suggestions as signals, not constraints)
- **Broad targeting** — No interests/LAL, rely on creative + pixel data + Meta's ML

### Creative Strategy
- Ad format selection: single image, carousel, video, collection, Instant Experience
- Creative testing frameworks: concept testing vs iterative testing
- UGC (user-generated content) integration and creator whitelisting
- Dynamic Creative Optimization (DCO) vs manual A/B testing
- Creative fatigue signals and refresh cadence
- Platform-specific creative (Feed, Stories, Reels, Explore)

### Tracking & Attribution
- **Meta Pixel** — Standard events, custom events, microdata, aggregated event measurement
- **Conversions API (CAPI)** — Server-side tracking for privacy resilience
- **Aggregated Event Measurement (AEM)** — iOS 14.5+ handling, 8-event prioritization
- Attribution settings: 7-day click + 1-day view (default), 1-day click, 28-day click
- UTM parameter strategy for GA4 cross-reference
- Conversion lift studies and incrementality testing

## Key Benchmarks

| Metric | Good | Great | Warning |
|--------|------|-------|---------|
| CTR (Link Clicks) | 1-2% | 3%+ | <0.8% |
| CPC (Link Click) | $0.50-$1.50 | <$0.50 | >$2.00 |
| CPM | $8-$15 | <$8 | >$20 |
| Conversion Rate (Landing Page) | 3-5% | 8%+ | <2% |
| ROAS (ecommerce) | 3-4x | 6x+ | <2x |
| Cost Per Lead | Industry dependent | Below industry avg | Rising trend |
| Frequency (prospecting) | 1.5-2.5 | 1-1.5 | >3.5 |
| Frequency (retargeting) | 3-6 | 2-3 | >10 |
| Thumb-Stop Rate (video) | 25-35% | 40%+ | <20% |
| Hook Rate (3s video views %) | 30-40% | 50%+ | <25% |

## Campaign Structure (Modern Best Practice)

```
Ad Account
├── Advantage+ Shopping Campaign (ecommerce)
│   ├── Broad targeting (Meta AI optimizes)
│   ├── Existing customer budget cap (10-20%)
│   └── Mixed creative (image, video, UGC, carousel)
├── Prospecting Campaign (Conversions/Sales)
│   ├── Ad Set: Broad (no targeting, trust the pixel)
│   ├── Ad Set: Lookalike 1-3% (value-based)
│   └── Ad Set: Interest stacks (if needed)
├── Retargeting Campaign (Conversions/Sales)
│   ├── Ad Set: Website visitors 1-30 days
│   ├── Ad Set: Engaged (video viewers, IG/FB engaged)
│   └── Ad Set: Cart abandoners
├── Lead Gen Campaign (if applicable)
│   ├── Ad Set: Lookalikes of converters
│   └── Ad Set: Interest-based
└── Brand / Top-of-Funnel (optional)
    ├── Video Views (awareness content)
    └── Traffic (blog, resources)
```

**Modern trend**: Consolidate ad sets. Meta's algorithm performs better with fewer, broader ad sets and more creative diversity within each.

## Workflow: Full Account Audit

When asked to audit a Meta Ads account:

1. **Pixel & CAPI Health** — Event tracking, CAPI coverage, event match quality score, AEM config
2. **Account Structure** — Campaign consolidation, objective alignment, naming conventions
3. **Audience Strategy** — Overlap analysis, LAL seeds, audience size, Advantage+ adoption
4. **Creative Analysis** — Format mix, creative fatigue (frequency + declining CTR), testing velocity
5. **Budget & Bidding** — CBO vs ABO, budget allocation, bid strategy (lowest cost vs cost cap vs bid cap)
6. **Funnel Coverage** — Prospecting vs retargeting balance, exclusions between funnels
7. **Attribution** — Window settings, cross-platform reconciliation (vs GA4), CAPI deduplication
8. **Placement Optimization** — Advantage+ placements vs manual, creative per placement
9. **Shopping / Catalog** — Feed quality, product sets, dynamic ads setup
10. **Recommendations** — Prioritized with expected impact and creative direction

## Post-iOS 14.5 Best Practices

- Implement CAPI alongside pixel (aim for 90%+ event match quality)
- Prioritize 8 conversion events per domain in Events Manager
- Use value optimization when possible (Purchase over Add to Cart)
- Broader audiences outperform narrow (give Meta's ML room to optimize)
- UTM tracking + GA4 as secondary attribution source
- Creative is the new targeting — invest in creative testing over audience testing

## How to Use This Skill

Ask me questions like:
- "Audit my Facebook Ads account performance"
- "My ROAS is declining — what should I investigate?"
- "Help me set up Conversions API (CAPI)"
- "Design a creative testing framework for my brand"
- "Should I use Advantage+ Shopping or manual campaigns?"
- "Build a full-funnel campaign structure for my DTC brand"
- "My frequency is too high — how do I manage audience fatigue?"
- "Plan a lead gen campaign for B2B on Facebook/Instagram"

For detailed Meta Ads API reference, pixel implementation, and advanced configurations, see [REFERENCE.md](REFERENCE.md).

## Hard Rules

These constraints must never be violated in recommendations:

1. **Pixel + CAPI both required.** Post-iOS 14.5, browser-only tracking loses 30-40% of conversion data.
2. **Event deduplication must be active** (event_id matching) — without it, conversions are double-counted.
3. **Event Match Quality ≥8.0** for Purchase event. Below 6.0 is critical.
4. **Budget must be ≥5x target CPA per ad set** — below this, the algorithm cannot exit learning phase.
5. **Never recommend edits during active learning phase** — wait for ~50 conversions/week or intentional reset.
6. **Creative fatigue = action required.** CTR decline >20% over 14 days with frequency >3 = replace creative immediately.
7. **<30% of ad sets in Learning Limited** — above this threshold, consolidation is mandatory.
8. **Purchasers/converters must be excluded** from prospecting campaigns.
9. **Special Ad Categories must be declared** before campaign creation for Housing, Employment, Credit, and Financial Products.

## Scored Audit

When performing an account audit, load `skills/shared/scoring-system.md` for the weighted scoring algorithm and `CHECKS.md` for the 46-check Meta Ads audit checklist. Produce a health score (0-100, grade A-F) with Quick Wins and a prioritized action plan.

---

# Meta Ads Reference

## Account Hierarchy

```
Business Manager
└── Ad Account
    └── Campaign (Objective)
        └── Ad Set (Targeting, Budget, Schedule)
            └── Ad (Creative, Copy, CTA)
```

## Campaign Objectives (Current)

| Objective | Optimization Goals | Best For |
|-----------|-------------------|----------|
| Awareness | Reach, Brand Awareness, Video Views, Store Location Awareness | Top-of-funnel brand building |
| Traffic | Link Clicks, Landing Page Views | Driving website visits |
| Engagement | Messenger, Instagram, WhatsApp, Video Views, Post Engagement | On-platform interaction |
| Leads | Instant Forms, Messenger, Conversions, Calls | Lead generation |
| App Promotion | App Installs, App Events | Mobile app marketing |
| Sales | Conversions, Catalog Sales, Messenger, Calls | Revenue / ROAS |

## Ad Set Settings

### Budget Types
- **Campaign Budget Optimization (CBO)**: Budget set at campaign level, auto-distributed
- **Ad Set Budget (ABO)**: Budget set per ad set, manual control
- **Daily Budget**: Average daily spend
- **Lifetime Budget**: Total budget for campaign duration

### Bid Strategies
| Strategy | Description | Use Case |
|----------|-------------|----------|
| Lowest Cost | Get most results for budget (no cap) | Default, volume-focused |
| Cost Per Result Goal | Target average CPA | Efficiency control |
| Bid Cap | Max bid per auction | Strict cost control |
| ROAS Goal | Target return on ad spend | Revenue optimization |
| Highest Value | Maximize purchase value | High-value customer acquisition |

### Placement Options
| Placement | Formats |
|-----------|---------|
| Facebook Feed | Image, Video, Carousel, Collection |
| Facebook Marketplace | Image, Video |
| Facebook Video Feeds | Video |
| Facebook Right Column | Image |
| Facebook Stories | Image, Video (9:16) |
| Facebook Reels | Video (9:16) |
| Instagram Feed | Image, Video, Carousel, Collection |
| Instagram Stories | Image, Video (9:16) |
| Instagram Reels | Video (9:16) |
| Instagram Explore | Image, Video |
| Messenger Inbox | Image |
| Messenger Stories | Image, Video |
| Audience Network | Image, Video, Native |

Recommendation: Use Advantage+ Placements (all placements) and let Meta optimize. Create assets for each format.

## Audience Reference

### Core Audiences (Interest/Demographic)
```
Demographics:
├── Age (13-65+)
├── Gender
├── Location (country, state, city, zip, radius)
├── Language
├── Education level
├── Relationship status
├── Job title / industry
└── Household income (US only, limited)

Interests:
├── Business & Industry
├── Entertainment (movies, music, TV)
├── Family & Relationships
├── Fitness & Wellness
├── Food & Drink
├── Hobbies & Activities
├── Shopping & Fashion
└── Technology

Behaviors:
├── Digital activities
├── Purchase behavior
├── Travel
├── Device usage
└── Expat/traveler status
```

### Custom Audiences
| Source | Lookback | Min Size |
|--------|----------|----------|
| Website (Pixel/CAPI) | Up to 180 days | 100 |
| Customer List | Upload CSV/sync | 100 (match rate varies) |
| App Activity | Up to 180 days | 100 |
| Video Views | Up to 365 days | 100 |
| Lead Form | Up to 90 days | 100 |
| Instagram Account | Up to 365 days | 100 |
| Facebook Page | Up to 365 days | 100 |
| Shopping (Catalog) | Up to 180 days | 100 |

### Lookalike Audiences
- **Seed**: Any Custom Audience (value-based preferred for Purchase LALs)
- **Percentage**: 1-10% of country population
- **Best practice**: Test 1% (most similar), 1-3% (broader), 3-5% (scale)
- **Value-based LALs**: Uses purchase value for better quality matching
- **Country**: Must select target country(ies)

### Advantage+ Audience
- Meta's AI-driven targeting
- You provide "suggestions" (interests, Custom Audiences) as signals
- Algorithm can go beyond suggestions to find converters
- Replacing traditional detailed targeting for many advertisers
- Works best with strong pixel data and good creative

## Meta Pixel & CAPI Reference

### Pixel Base Code
```html
<script>
!function(f,b,e,v,n,t,s)
{if(f.fbq)return;n=f.fbq=function(){n.callMethod?
n.callMethod.apply(n,arguments):n.queue.push(arguments)};
if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
n.queue=[];t=b.createElement(e);t.async=!0;
t.src=v;s=b.getElementsByTagName(e)[0];
s.parentNode.insertBefore(t,s)}(window, document,'script',
'https://connect.facebook.net/en_US/fbevents.js');
fbq('init', 'YOUR_PIXEL_ID');
fbq('track', 'PageView');
</script>
```

### Standard Events
| Event | Parameters | When |
|-------|-----------|------|
| PageView | — | Every page load |
| ViewContent | content_ids, content_type, value, currency | Product/content pages |
| AddToCart | content_ids, content_type, value, currency | Add to cart action |
| InitiateCheckout | content_ids, value, currency, num_items | Checkout start |
| AddPaymentInfo | content_category, value, currency | Payment info entered |
| Purchase | content_ids, value, currency, content_type | Order complete |
| Lead | value, currency, content_name | Form submission |
| CompleteRegistration | value, currency, content_name | Signup complete |
| Search | search_string, content_category | Site search |
| Subscribe | value, currency, predicted_ltv | Subscription start |

### Pixel Event Code
```javascript
// Standard event
fbq('track', 'Purchase', {
  content_ids: ['SKU123', 'SKU456'],
  content_type: 'product',
  value: 99.99,
  currency: 'USD',
  num_items: 2
});

// Custom event
fbq('trackCustom', 'FreeTrial', {
  trial_type: 'premium',
  duration: 14
});
```

### Conversions API (CAPI)
Server-side event sending for privacy resilience.

```python
# Python example using Facebook Business SDK
from facebook_business.adobjects.serverside.event import Event
from facebook_business.adobjects.serverside.event_request import EventRequest
from facebook_business.adobjects.serverside.user_data import UserData
from facebook_business.adobjects.serverside.custom_data import CustomData
from facebook_business.api import FacebookAdsApi
import time, hashlib

FacebookAdsApi.init(access_token='YOUR_ACCESS_TOKEN')

user_data = UserData(
    emails=[hashlib.sha256('customer@example.com'.encode()).hexdigest()],
    phones=[hashlib.sha256('+11234567890'.encode()).hexdigest()],
    client_ip_address='1.2.3.4',
    client_user_agent='Mozilla/5.0...',
    fbc='fb.1.1234567890.AbCdEfG',  # _fbc cookie
    fbp='fb.1.1234567890.1234567890' # _fbp cookie
)

custom_data = CustomData(
    value=99.99,
    currency='USD',
    content_ids=['SKU123'],
    content_type='product'
)

event = Event(
    event_name='Purchase',
    event_time=int(time.time()),
    user_data=user_data,
    custom_data=custom_data,
    event_source_url='https://example.com/checkout/success',
    action_source='website'
)

request = EventRequest(pixel_id='YOUR_PIXEL_ID', events=[event])
response = request.execute()
```

### Event Match Quality (EMQ)
Score 1-10 measuring how well your CAPI events can be matched to Meta users.

| Score | Quality | Action |
|-------|---------|--------|
| 8-10 | Great | Maintain current setup |
| 6-7 | Good | Add more user data parameters |
| 4-5 | Fair | Implement fbc/fbp cookies, add email/phone |
| 1-3 | Poor | Review CAPI implementation, check hashing |

Key parameters for high EMQ: email, phone, fbc cookie, fbp cookie, client IP, user agent, external ID.

### Aggregated Event Measurement (AEM)
iOS 14.5+ privacy handling:
- **8-event limit** per domain (priority-ranked)
- **Prioritization**: Highest-value event wins attribution (e.g., Purchase > AddToCart)
- **Delayed reporting**: Up to 72 hours for iOS conversions
- **Modeled conversions**: Statistical modeling fills attribution gaps

Recommended priority order:
1. Purchase
2. InitiateCheckout
3. AddToCart
4. ViewContent
5. Lead
6. CompleteRegistration
7. Subscribe
8. PageView

## Creative Specifications

### Image Ads
| Placement | Ratio | Size |
|-----------|-------|------|
| Feed (FB/IG) | 1:1 | 1080x1080px |
| Stories/Reels | 9:16 | 1080x1920px |
| Right Column | 1.91:1 | 1200x628px |
| Marketplace | 1:1 | 1080x1080px |

### Video Ads
| Placement | Ratio | Duration |
|-----------|-------|----------|
| Feed | 1:1 or 4:5 | 15-60s (15s optimal) |
| Stories/Reels | 9:16 | 15-30s |
| In-stream | 16:9 | 5-15s |

### Text Limits
| Element | Character Limit | Recommended |
|---------|----------------|-------------|
| Primary Text | 125 chars (before "See more") | Under 125 |
| Headline | 40 chars | Under 40 |
| Description | 30 chars | Under 30 |
| CTA Button | Preset options | Match intent |

## Creative Testing Framework

### Concept Testing (Big Swings)
Test fundamentally different approaches:
- UGC vs studio-produced
- Testimonial vs product demo
- Problem-agitation vs aspiration
- Static image vs video
- Different value propositions/angles

### Iterative Testing (Optimization)
Refine winning concepts:
- Hook variations (first 3 seconds of video)
- Headline/copy variations
- CTA variations
- Color/visual treatment
- Format (carousel vs single vs video)

### Testing Structure
```
Campaign: Creative Testing
├── Ad Set: Broad targeting (consistent audience)
│   ├── Ad 1: Concept A - Variation 1
│   ├── Ad 2: Concept A - Variation 2
│   ├── Ad 3: Concept B - Variation 1
│   └── Ad 4: Concept B - Variation 2
```
- Use DCO (Dynamic Creative) for element-level testing
- Or separate ads for concept-level testing
- Statistical significance: Wait for 50+ conversions per variant

## Reporting & Attribution

### Attribution Windows
| Window | Description | Default? |
|--------|-------------|----------|
| 7-day click, 1-day view | Credit conversions within 7d of click OR 1d of view | Yes |
| 1-day click | Only credit within 1 day of click | Conservative |
| 7-day click | Credit within 7 days of click only (no view-through) | — |
| 28-day click | Extended click window | — |

### Key Metrics
| Metric | Definition |
|--------|-----------|
| CPM | Cost per 1,000 impressions |
| CPC (Link Click) | Cost per link click |
| CTR (Link Click) | Link clicks / impressions |
| CPA | Cost per conversion action |
| ROAS | Purchase conversion value / spend |
| Frequency | Average times ad shown per person |
| Reach | Unique people who saw the ad |
| ThruPlay Rate | Video views to completion (or 15s) / impressions |
| Hook Rate | 3-second video views / impressions |
| Hold Rate | ThruPlays / 3-second video views |

### Reporting Breakdowns
- **Delivery**: Age, gender, country, region, platform, placement, device, time of day
- **Action**: Conversion device, carousel card, destination, product ID
- **Dynamic Creative**: Image, headline, text, CTA, description

## API Reference (Marketing API)

### Base URL
```
https://graph.facebook.com/v19.0/
```

### Authentication
```
Access Token: User token or System User token
Required permissions: ads_management, ads_read, business_management
```

### Key Endpoints
```
# Account
GET /{ad_account_id}/campaigns
GET /{ad_account_id}/adsets
GET /{ad_account_id}/ads

# Insights (Reporting)
GET /{ad_account_id}/insights?fields=impressions,clicks,spend,actions
GET /{campaign_id}/insights
GET /{adset_id}/insights
GET /{ad_id}/insights

# Audiences
POST /{ad_account_id}/customaudiences
GET /{custom_audience_id}

# Conversions API
POST /{pixel_id}/events

# Catalog
GET /{product_catalog_id}/products
POST /{product_catalog_id}/items_batch
```
