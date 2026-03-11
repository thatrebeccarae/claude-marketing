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
