# braze


# Braze Customer Engagement Platform

Expert-level guidance for Braze — auditing, building, and optimizing Canvases, campaigns, segments, data architecture, and cross-channel messaging.

## Core Capabilities

### Canvas Auditing & Design
- Audit existing Canvases for logic errors, timing issues, and missed opportunities
- Design multi-step, multi-channel Canvases (email, push, SMS, in-app, Content Cards, webhook)
- Implement Canvas Flow features: Action Paths, Audience Paths, Experiment Paths, Decision Splits
- Review entry schedules, exception events, re-eligibility, and rate limiting

### Segmentation & Targeting
- Build segments using Braze's filter system (user attributes, custom events, purchase behavior, engagement)
- Design segment extensions for complex queries (event property filters, nested AND/OR logic)
- Implement predictive audiences (Predictive Churn, Predictive Purchases)
- Connected Audience sync from external CDPs (Segment, mParticle, Amplitude)

### Campaign Strategy
- Plan cross-channel campaigns: email, push, SMS, in-app messages, Content Cards, webhooks
- A/B and multivariate testing with Intelligent Selection
- Personalization with Liquid templating, Connected Content, and Catalogs
- Frequency capping and Intelligent Timing optimization

### Data Architecture
- Design custom event and attribute schemas
- Implement Currents data export (to Snowflake, BigQuery, S3, Mixpanel)
- Plan data migration from other platforms (Klaviyo, Iterable, Salesforce MC)
- API integration patterns (REST API, SDK implementation)

### Deliverability & Compliance
- Email: SPF, DKIM, DMARC, IP warming schedules
- Push: Token management, provisional authorization, opt-in strategies
- SMS: Short code vs long code, compliance (TCPA, CTIA), opt-in management
- GDPR/CCPA data handling and consent management

## Key Benchmarks

| Metric | Good | Great | Warning |
|--------|------|-------|---------|
| Email Open Rate | 20-25% | 30%+ | <15% |
| Email Click Rate | 2-3% | 4%+ | <1.5% |
| Push Open Rate (iOS) | 3-5% | 7%+ | <2% |
| Push Open Rate (Android) | 5-8% | 12%+ | <3% |
| In-App Click Rate | 15-20% | 25%+ | <10% |
| Content Card Click Rate | 10-15% | 20%+ | <5% |
| SMS Click Rate | 8-12% | 15%+ | <5% |
| Unsubscribe Rate (email) | <0.3% | <0.1% | >0.5% |

## Essential Canvas Checklist

1. **Onboarding** — Multi-step cross-channel (push opt-in prompt, email welcome, in-app tutorial)
2. **Activation** — Drive key actions in first 7 days (feature adoption, profile completion)
3. **Re-engagement** — Target lapsed users (7d, 14d, 30d inactivity tiers)
4. **Transactional** — Order confirmations, shipping updates, receipts (use Transactional API)
5. **Promotional** — Scheduled campaigns with audience targeting and frequency caps
6. **Abandoned Cart / Browse** — Trigger-based with exception events for conversion
7. **Winback** — Long-term lapsed users (60d, 90d, 120d)
8. **Feature Announcement** — Targeted by segment, channel preference, and platform
9. **NPS / Feedback** — Post-interaction surveys via in-app or email
10. **Sunset** — Suppress unengaged to protect deliverability

## Workflow: Full Braze Audit

When asked to audit a Braze workspace:

1. **Canvas & Campaign Inventory** — List all active Canvases and campaigns, identify gaps
2. **Channel Coverage** — Map which channels are active (email, push, SMS, in-app, Content Cards)
3. **Segmentation Review** — Evaluate segment definitions, overlap, and growth
4. **Data Architecture** — Custom events, attributes, schema consistency, data freshness
5. **Personalization** — Liquid usage, Connected Content calls, Catalog implementation
6. **Performance Metrics** — Channel-level KPIs, Canvas step conversion rates, variant performance
7. **Deliverability** — Email reputation, push token health, SMS compliance
8. **Frequency & Fatigue** — Global frequency caps, quiet hours, Intelligent Timing usage
9. **Integration Health** — SDK version, Currents export, CDP sync, webhook reliability
10. **Recommendations** — Prioritized by impact with estimated effort (Quick Win / Medium / Large)

## Braze vs Klaviyo Context

When working with teams migrating or comparing:
- **Braze** excels at: Cross-channel orchestration, mobile-first (push, in-app), enterprise scale, real-time event streaming
- **Klaviyo** excels at: E-commerce focus, simpler setup, Shopify-native, strong email/SMS for DTC
- Key migration consideration: Braze's event/attribute model is more flexible but requires upfront schema design

## How to Use This Skill

Ask me questions like:
- "Audit my Braze Canvases and identify gaps"
- "Design an onboarding Canvas for a mobile app"
- "Help me plan a migration from Klaviyo to Braze"
- "What's the best data architecture for a SaaS product in Braze?"
- "My push opt-in rates are low — help me design an opt-in strategy"
- "Build a re-engagement Canvas with Experiment Paths"
- "Plan IP warming for a new Braze workspace"

For detailed Braze data model, Liquid reference, API endpoints, and Canvas patterns, see [REFERENCE.md](REFERENCE.md).

---

# Braze Reference

## Data Model

### Users (Profiles)
- **external_id** — Primary identifier (from your system)
- **braze_id** — Braze-assigned internal ID
- **email** — Email address (for email channel)
- **phone** — Phone number with country code (for SMS/WhatsApp)
- **push_tokens** — Device tokens for push notifications
- **Standard Attributes** — first_name, last_name, email, phone, gender, dob, country, city, language, time_zone
- **Custom Attributes** — Any key-value pair (string, number, boolean, array, date, object)
- **Custom Events** — Timestamped actions with optional properties

### Events & Attributes

#### Standard Events
- `Purchase` — With product_id, currency, price, quantity
- `Session Start` / `Session End` — App session tracking
- `Push Notification Open` — Push engagement
- `Email Open` / `Email Click` — Email engagement

#### Custom Events
```json
{
  "name": "added_to_cart",
  "time": "2024-01-15T10:30:00Z",
  "properties": {
    "product_id": "SKU123",
    "product_name": "Widget Pro",
    "price": 49.99,
    "category": "electronics"
  }
}
```

### Subscription States
- **Email**: opted_in, subscribed (default), unsubscribed
- **Push**: opted_in, subscribed, unsubscribed
- **SMS**: subscribed, unsubscribed (requires explicit opt-in)
- **Subscription Groups** — Granular topic-based preferences

## Canvas Flow Reference

### Entry Schedule Types
| Type | Description | Use Case |
|------|-------------|----------|
| Scheduled | Recurring or one-time | Daily digest, weekly recap |
| Action-Based | Triggered by event | Abandoned cart, purchase |
| API-Triggered | Via REST API | Transactional, external trigger |

### Canvas Steps

#### Message Step
- Send email, push, SMS, in-app, Content Card, or webhook
- Supports Intelligent Timing, rate limiting, quiet hours
- A/B testing within step (up to 8 variants)

#### Action Paths
Branch users based on actions taken within a time window:
```
Action Paths
├── Purchased (within 3 days) → Thank you path
├── Added to Cart (within 3 days) → Nudge path
└── Everyone Else → Re-engage path
```

#### Audience Paths
Branch by user attributes/segments at a point in time:
```
Audience Paths
├── VIP Customers → Premium offer
├── New Customers → Welcome discount
└── Everyone Else → Standard message
```

#### Experiment Paths
A/B/n testing with statistical significance tracking:
- Winner auto-selection based on open rate, click rate, conversion, or revenue
- Configurable confidence level and holdout group

#### Decision Split
Binary yes/no filter on user attributes or behaviors

#### Delay
- Fixed time delay (hours, days)
- Until specific day/time
- Intelligent Timing (per-user optimal time)

#### User Update
Modify user attributes or subscription status within Canvas

### Canvas Settings
- **Re-eligibility** — Can users re-enter? After how long?
- **Rate limiting** — Max messages per minute
- **Frequency capping** — Max messages per channel per time period (global setting)
- **Exception events** — Exit Canvas early if event occurs (e.g., user converts)
- **Entry limits** — Max users entering per schedule

## Segmentation Reference

### Filter Categories
- **User Profile** — Standard and custom attributes
- **Engagement** — Email/push/SMS interactions, session recency
- **Purchase** — Purchase history, product, total spend
- **Custom Events** — Event occurrence, count, property values
- **Retargeting** — Clicked card, received campaign, in Canvas step
- **Technology** — App version, device model, OS, carrier
- **Location** — Country, city, most recent location
- **Testing** — A/B test membership, random bucket number

### Segment Extensions (Advanced)
For complex queries beyond standard filters:
- Event property filtering (e.g., "purchased product where category = electronics")
- Nested AND/OR logic
- Time-windowed event counts
- Regex matching on string properties

### Predictive Suite
- **Predictive Churn** — Likelihood to churn score (0-100)
- **Predictive Purchases** — Likelihood to purchase score (0-100)
- Both require 30+ days of data and sufficient user base

## Liquid Templating Reference

### Basic Variables
```liquid
{{${first_name} | default: "there"}}
{{${email}}}
{{custom_attribute.${loyalty_tier}}}
```

### Conditional Logic
```liquid
{% if ${first_name} != blank %}
  Hi {{${first_name}}},
{% else %}
  Hi there,
{% endif %}
```

### Connected Content (Dynamic API Calls)
```liquid
{% connected_content https://api.example.com/recommendations?user={{${user_id}}} :save recs %}
{% if recs.products.size > 0 %}
  Check out: {{recs.products[0].name}}
{% endif %}
```

### Catalogs (Built-in Product Data)
```liquid
{% catalog_items your_catalog_name {{custom_attribute.${favorite_product_id}}} %}
{{items[0].name}} - {{items[0].price}}
```

### Aborting Messages
```liquid
{% if ${email_subscribe} == "unsubscribed" %}
  {% abort_message("User unsubscribed") %}
{% endif %}
```

### Date Formatting
```liquid
{{${date_of_birth} | date: "%B %d"}}
{{ "now" | date: "%Y-%m-%d" }}
```

## API Reference

### Base URLs
```
REST API:  https://rest.iad-01.braze.com  (US-01)
           https://rest.iad-02.braze.com  (US-02)
           https://rest.fra-01.braze.eu   (EU-01)
SDK:       sdk.iad-01.braze.com (varies by instance)
```

### Authentication
```
Authorization: Bearer {REST_API_KEY}
```

### Key Endpoints

#### User Data
```
POST /users/track          # Send events, attributes, purchases
POST /users/identify       # Alias to external_id
POST /users/delete         # Delete users (GDPR)
POST /users/export/ids     # Export user data
POST /users/export/segment # Export segment
```

#### Messaging
```
POST /messages/send              # Immediate send
POST /messages/schedule/create   # Scheduled send
POST /campaigns/trigger/send     # API-triggered campaign
POST /canvas/trigger/send        # API-triggered Canvas
```

#### Catalogs
```
POST /catalogs                    # Create catalog
POST /catalogs/{name}/items       # Add items
PUT  /catalogs/{name}/items/{id}  # Update item
```

#### Subscription Groups
```
POST /subscription/status/set     # Update subscription
GET  /subscription/status/get     # Check subscription
```

### /users/track Example
```json
{
  "attributes": [{
    "external_id": "user123",
    "first_name": "Jane",
    "custom_attribute_key": "custom_value"
  }],
  "events": [{
    "external_id": "user123",
    "name": "viewed_product",
    "time": "2024-01-15T10:30:00Z",
    "properties": {"product_id": "SKU123"}
  }],
  "purchases": [{
    "external_id": "user123",
    "product_id": "SKU123",
    "currency": "USD",
    "price": 49.99,
    "time": "2024-01-15T10:35:00Z"
  }]
}
```

## Currents (Data Export)

### Supported Destinations
- Amazon S3, Google Cloud Storage, Azure Blob
- Snowflake, BigQuery, Databricks
- Mixpanel, Amplitude, Segment
- Custom webhook

### Event Types Exported
- Message engagement (sends, deliveries, opens, clicks, bounces)
- User behavior (sessions, custom events, purchases)
- Subscription changes
- Campaign/Canvas enrollment and conversion

### Data Format
- Avro format (default)
- JSON lines (configurable)
- Partitioned by event type and date

## Channel-Specific Reference

### Push Notifications
- **iOS**: Requires APNs certificate/key, provisional authorization available (iOS 12+)
- **Android**: FCM server key required
- **Web**: Service worker + VAPID keys
- Rich push: Images (2:1 ratio), action buttons (up to 4), custom sounds
- TTL (Time to Live): Default 30 days, configurable per message

### In-App Messages
- **Types**: Slideup, modal, full-screen, custom HTML
- **Triggers**: Session start, custom event, push click
- **Priority**: Can stack, configure display priority
- **Dark mode**: Automatic support with color tokens

### Content Cards
- **Types**: Banner, captioned image, classic (icon + text)
- **Persistence**: Stay in feed until dismissed or expired
- **Personalization**: Liquid + Connected Content supported
- **Analytics**: Impressions, clicks, dismissals

### Email
- Drag-and-drop editor or custom HTML
- Dynamic content with Liquid/Connected Content
- AMP for Email support
- Link aliasing for click tracking
- Preference center (built-in or custom)

### SMS/MMS
- Short code, long code, or alphanumeric sender ID
- Keyword processing (STOP, HELP, custom)
- Link shortening with tracking
- MMS: Images, GIFs, vCards

## IP Warming Schedule

| Week | Daily Volume | Target Audience |
|------|-------------|-----------------|
| 1 | 5,000-10,000 | Most engaged (opened in 30 days) |
| 2 | 20,000-40,000 | Engaged (opened in 60 days) |
| 3 | 50,000-100,000 | Active (opened in 90 days) |
| 4 | 200,000+ | Broader audience |
| 5+ | Full volume | Full list with sunset |

Monitor: Delivery rate >97%, bounce rate <3%, spam complaint <0.08%.
