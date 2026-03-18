# klaviyo-analyst


# Klaviyo Marketing Analyst

Expert-level guidance for Klaviyo email and SMS marketing from the **marketing operations and analyst perspective** — auditing, building, and optimizing flows, segments, campaigns, and integrations.

> For API integration, SDK usage, event tracking implementation, webhooks, and developer patterns, see the **klaviyo-developer** skill.

## Core Capabilities

### Flow Auditing & Optimization
- Audit existing flows against best practices (welcome series, abandoned cart, post-purchase, winback, browse abandonment, sunset)
- Identify revenue leakage from missing or underperforming flows
- Recommend split tests, timing adjustments, and conditional logic improvements
- Review flow filters and trigger conditions for accuracy

### Segmentation Strategy
- Build RFM-based segments (Recency, Frequency, Monetary)
- Design engagement tiers: Active (0-30d), Warm (31-90d), At-Risk (91-180d), Lapsed (180d+)
- Create predictive segments using Klaviyo's predictive analytics (CLV, churn risk, next order date)
- Suppress unengaged contacts to protect deliverability

### Campaign Strategy
- Plan campaign calendars balancing promotional and value content
- A/B testing frameworks for subject lines, send times, content blocks
- Dynamic content personalization using profile properties and catalog data
- SMS campaign compliance (TCPA, quiet hours, opt-in requirements)

### Deliverability Management
- Monitor and diagnose deliverability issues (bounce rates, spam complaints, inbox placement)
- Warm-up strategies for new sending domains/IPs
- Authentication setup: SPF, DKIM, DMARC
- List hygiene practices and sunset flow design

### Revenue Attribution & Reporting
- Interpret Klaviyo's attribution model (click-based, 5-day email / 24-hour SMS default windows)
- Build custom dashboards for flow revenue, campaign ROI, list growth
- Benchmark KPIs against industry standards

### Event Schema Auditing
- Inventory all tracked metrics by source (built-in integration, custom API, Klaviyo-internal, forms)
- Identify duplicate/redundant events, unused events, and missing standard events
- Assess event property structures for segmentation and personalization accessibility
- Diagnose nested object limitations blocking flow splits and segment conditions

### Integration Health Review
- Audit active integrations (e-commerce, review platforms, loyalty, ads)
- Identify stale/dead integrations and orphaned event sources
- Assess flow trigger architecture: direct metric triggers (robust) vs segment-entry triggers via API-synced properties (brittle)
- Evaluate catalog sync health: product coverage, variant handling, freshness

### Profile Data Utilization Analysis
- Map profile properties: what's collected vs what's used in segmentation/personalization
- Identify stale calculated properties (set once, never updated)
- Flag properties on events but not synced to profiles (limits segmentation)
- Recommend property flattening strategies for nested data accessibility

## Key Benchmarks

| Metric | Good | Great | Warning |
|--------|------|-------|---------|
| Open Rate (email) | 20-25% | 30%+ | <15% |
| Click Rate (email) | 2-3% | 4%+ | <1.5% |
| Unsubscribe Rate | <0.3% | <0.1% | >0.5% |
| Spam Complaint Rate | <0.05% | <0.02% | >0.1% |
| Flow Revenue % of Total | 30-40% | 50%+ | <20% |
| SMS Click Rate | 8-12% | 15%+ | <5% |
| List Growth Rate (monthly) | 3-5% | 8%+ | <1% |

## Essential Flows Checklist

1. **Welcome Series** (3-5 emails + optional SMS) — triggers on list subscribe
2. **Abandoned Cart** (2-3 emails + 1 SMS) — triggers on Started Checkout
3. **Browse Abandonment** (1-2 emails) — triggers on Viewed Product, exclude recent purchasers
4. **Post-Purchase** (2-4 emails) — triggers on Placed Order, split by first-time vs repeat
5. **Winback** (2-3 emails) — triggers on time since last purchase (60-90 days)
6. **Sunset/Re-engagement** (2 emails) — targets unengaged 90-180 days, then suppress
7. **Review Request** — triggers post-delivery, integrates with review platform
8. **Replenishment** (if applicable) — triggers based on expected repurchase cycle
9. **Birthday/Anniversary** — triggers on date property
10. **VIP/Loyalty** — triggers on high-CLV segment entry

## Workflow: Full Klaviyo Audit (4-Phase Deep Framework)

When asked to audit a Klaviyo account, follow this 4-phase framework:

### Phase 1: Status Inventory
1. **List/Segment/Flow/Campaign Inventory** — Count and categorize all objects by status (live, draft, inactive)
2. **Event Schema Inventory** — Pull all metrics, categorize by source (built-in, custom API, Klaviyo-internal, forms), flag zero-volume events
3. **Integration Inventory** — List all active integrations, identify stale connections
4. **Custom Profile Property Inventory** — Document all custom properties with types and usage

### Phase 2: Configuration Audit
5. **Per-Flow Configuration Teardown** — For each active flow:
   - Trigger type and conditions
   - Smart Send settings (on/off and implications)
   - Exclusion filters (segment membership, event conditions)
   - Timing between messages (compare to benchmarks)
   - Branching logic (conditional splits, A/B splits)
   - Flow duration (first message to last)
6. **Campaign Targeting Audit** — Segment exclusivity, frequency capping, send-time optimization
7. **A/B Testing Methodology Audit** — Univariate vs multivariate, KPI alignment, statistical significance practices
8. **Deliverability Configuration** — Authentication (SPF/DKIM/DMARC), dedicated IP, warmup status

### Phase 3: Data Structure Audit
9. **Event Schema Health** — Check for duplicates, missing standard events, nested objects blocking segmentation
10. **Profile Data Utilization** — What's collected vs what's used in segmentation/personalization
11. **Catalog Sync Health** — Product feed freshness, coverage, variant handling

### Phase 4: Strategic Recommendations
12. **Three-Tier Recommendations** — For each finding:
    - **Finding**: What's wrong + evidence from audit data
    - **Recommendation**: What to do (client-facing, plain language)
    - **Implementation Spec**: How to build it (internal SOW with triggers, filters, content brief, timing, testing plan)
13. **Sequential Testing Plans** — Univariate A/B tests with stat sig framework
14. **Quantified ROI** — Expected uplift % x current revenue baseline
15. **Implementation Roadmap** — Phased timeline with dependencies mapped

## Industry-Specific Benchmarks

### B2B / Wholesale E-Commerce

| Metric | Good | Great | Warning | Notes |
|--------|------|-------|---------|-------|
| Open Rate | 25-35% | 40%+ | <20% | Higher than DTC due to professional relevance |
| Click Rate | 3-5% | 6%+ | <2% | Product-focused CTAs perform well |
| CTOR | 10-15% | 18%+ | <8% | Key diagnostic — content relevance signal |
| Flow Revenue % | 25-35% | 40%+ | <15% | Reorder flows are high-value in B2B |
| Avg Order Value | Varies | — | — | Track by segment (industry, company size) |
| Reorder Rate | 60-70% | 80%+ | <50% | Critical for consumable categories |

### DTC (Direct-to-Consumer)

| Metric | Good | Great | Warning |
|--------|------|-------|---------|
| Open Rate | 20-25% | 30%+ | <15% |
| Click Rate | 2-3% | 4%+ | <1.5% |
| Flow Revenue % | 30-40% | 50%+ | <20% |
| Welcome Series Conv. | 3-5% | 8%+ | <2% |
| Cart Recovery Rate | 5-10% | 15%+ | <3% |

### Subscription / Recurring Revenue

| Metric | Good | Great | Warning |
|--------|------|-------|---------|
| Churn Rate (monthly) | <5% | <3% | >8% |
| Reactivation Rate | 5-10% | 15%+ | <3% |
| Replenishment Flow Conv. | 8-12% | 15%+ | <5% |
| Subscription Upgrade Rate | 3-5% | 8%+ | <1% |

## SMS Platform Comparison Framework

When evaluating Klaviyo SMS vs Attentive (common in audits):

| Capability | Klaviyo SMS | Attentive |
|------------|------------|-----------|
| Email + SMS unified | Yes (native) | No (separate platform) |
| Shared segments | Yes | Requires sync |
| Unified attribution | Yes | Separate reporting |
| Conversational SMS | Limited | Strong (two-way) |
| Sign-up units | Basic (popup, form) | Advanced (two-tap, link-based) |
| AI features | Predictive analytics, smart send time | AI journeys, smart sending |
| Compliance | Built-in TCPA, quiet hours | Built-in + compliance team |
| Cost | Included in Klaviyo plan (per SMS) | Separate platform fee + per SMS |
| Best for | Unified email+SMS, simplicity | SMS-first strategy, high volume SMS |

**Recommendation framework**: Use Klaviyo SMS when email is the primary channel and SMS is supplementary (most B2B and mid-market DTC). Consider Attentive when SMS is a primary revenue channel (high-frequency DTC, mobile-first brands).

## Repeatable Audit Workflow (MCP Tool Sequence)

When auditing an account via the Klaviyo MCP tools, follow this sequence:

1. `klaviyo_get_account_details` — Account config, timezone, integrations
2. `klaviyo_get_metrics` — Full event inventory (all metric names and IDs)
3. `klaviyo_get_flows` — All flows with status
4. `klaviyo_get_flow` (per flow) — Trigger details, actions, filters for each live flow
5. `klaviyo_get_campaigns` — Recent campaigns with send dates
6. `klaviyo_get_campaign_report` (per campaign) — Open/click/unsub/revenue metrics
7. `klaviyo_get_flow_report` (per flow) — Revenue, conversion, engagement per flow
8. `klaviyo_get_segments` + `klaviyo_get_segment` — Segment inventory and condition definitions
9. `klaviyo_get_lists` — List inventory
10. `klaviyo_get_catalog_items` — Catalog sync health check

After data pull, analyze using the 4-Phase Deep Framework above.

## Integration Context

### E-commerce Platforms
- **Shopify**: Native integration, syncs orders/products/customers automatically. Use Shopify-specific metrics (Placed Order, Started Checkout, Viewed Product).
- **WooCommerce / BigCommerce / Magento**: Similar event sync, may need plugin configuration.
- **Custom platforms**: Coordinate with developers using the **klaviyo-developer** skill for API event tracking and profile management.

### Common Integration Points
- Review platforms (Yotpo, Judge.me, Stamped) for post-purchase review flows
- Loyalty programs (Smile.io, LoyaltyLion) for points-based segmentation
- Subscription platforms (Recharge, Bold) for subscription lifecycle flows
- SMS: Built-in Klaviyo SMS or integration with Attentive/Postscript

## How to Use This Skill

Ask me questions like:
- "Audit my Klaviyo flows and identify gaps"
- "Design a welcome series for my DTC brand"
- "My open rates dropped — help me diagnose deliverability issues"
- "Build an RFM segmentation strategy"
- "What A/B tests should I run on my abandoned cart flow?"
- "Help me set up a sunset flow to clean my list"
- "Plan a Black Friday email/SMS campaign calendar"
- "Audit my event schema — are we tracking everything we need?"
- "Give me a three-tier recommendation for fixing our click rates"

## Analysis Examples

For complete analysis patterns, worked examples with sample output, and use cases, see [EXAMPLES.md](EXAMPLES.md).

## Scripts

The skill includes utility scripts for data fetching and analysis:

### Fetch Klaviyo Data
```bash
# List all flows
python scripts/klaviyo_client.py --resource flows

# List campaigns as table
python scripts/klaviyo_client.py --resource campaigns --format table

# Get flow performance report
python scripts/klaviyo_client.py --resource report --report-type flow --id FLOW_ID

# Export metrics to file
python scripts/klaviyo_client.py --resource metrics --output metrics.json
```

### Analyze and Generate Reports
```bash
# Full account audit
python scripts/analyze.py --analysis-type full-audit

# Flow gap analysis
python scripts/analyze.py --analysis-type flow-audit

# Segment health check
python scripts/analyze.py --analysis-type segment-health

# Campaign performance comparison
python scripts/analyze.py --analysis-type campaign-comparison --days 30

# Deliverability diagnostic
python scripts/analyze.py --analysis-type deliverability

# Revenue attribution
python scripts/analyze.py --analysis-type revenue-attribution
```

The scripts handle API authentication, data fetching, and analysis. I'll interpret the results and provide actionable recommendations.

## Troubleshooting

**Authentication Error**: Verify that:
- `KLAVIYO_API_KEY` is set as an environment variable or in a `.env` file
- The key starts with `pk_` (private API key, not public)
- The key has read scopes: `profiles:read`, `flows:read`, `campaigns:read`, `segments:read`, `lists:read`, `metrics:read`

**No Data Returned**: Check that:
- The API key is associated with the correct Klaviyo account
- The account has active flows, campaigns, or segments to analyze
- Filters are correctly formatted (e.g., `equals(status,"live")`)

**Rate Limit Errors**: The SDK handles retries automatically (up to 3 retries with 60s max delay). If you still hit limits:
- Reduce concurrent requests
- Add delays between sequential calls
- Check `RateLimit-Remaining` header

**Import Errors**: Install required packages:
```bash
pip install klaviyo-api python-dotenv pandas
```

## Security Notes

- **Never hardcode** API keys in code or commit them to version control
- Store keys in environment variables or `.env` files
- Add `.env` to `.gitignore`
- Use **read-only scopes** for analyst tasks — no write access needed
- Rotate API keys periodically in Klaviyo Settings

## Data Privacy

This skill accesses aggregated marketing data only. It does not:
- Access personally identifiable information (PII) beyond email/profile aggregates
- Store Klaviyo data persistently
- Share data with external services
- Modify your Klaviyo configuration (read-only operations)

All data is processed locally and used only to generate recommendations during the conversation.

For detailed Klaviyo data model, flow builder reference, segmentation conditions, deliverability, and SMS reference, see [REFERENCE.md](REFERENCE.md).

For API integration, SDK usage, and developer patterns, use the **klaviyo-developer** skill.

---

# Klaviyo Reference

## Data Model

### Profiles (Contacts)
- **Email** — Primary identifier
- **Phone Number** — For SMS, must include country code
- **Properties** — Custom profile fields (first name, city, loyalty tier, etc.)
- **Predictive Analytics** — CLV, churn risk, gender, next order date (auto-calculated by Klaviyo)
- **Consent** — Email subscription status, SMS consent, double opt-in status

### Events (Metrics)
Standard e-commerce events synced from integration:
- `Placed Order` — Order completed with line items, total, discount
- `Ordered Product` — Individual product from an order
- `Started Checkout` — Checkout initiated
- `Added to Cart` — Item added to cart
- `Viewed Product` — Product detail page viewed
- `Active on Site` — Web activity tracked
- `Received Email`, `Opened Email`, `Clicked Email` — Engagement events
- `Received SMS`, `Clicked SMS` — SMS engagement

### Lists vs Segments
- **Lists** — Static groups (opt-in forms, imports). Used for sending campaigns.
- **Segments** — Dynamic, condition-based. Auto-update as profiles match/unmatch criteria.
- Best practice: Use segments for targeting, lists for opt-in tracking.

## Flow Builder Reference

### Trigger Types
| Trigger | Description | Common Use |
|---------|-------------|------------|
| List | Profile added to a list | Welcome series |
| Segment | Profile enters a segment | VIP, winback |
| Metric | Event occurs | Abandoned cart, post-purchase |
| Date | Based on date property | Birthday, anniversary |
| Price Drop | Product price decreases | Price drop alerts |
| Back in Stock | Product becomes available | Restock notifications |

### Flow Actions
- **Email** — Send email with template
- **SMS** — Send SMS/MMS
- **Push Notification** — Mobile push
- **Webhook** — HTTP POST to external service
- **Update Profile Property** — Set/modify a profile field
- **Conditional Split** — IF/ELSE based on conditions
- **Trigger Split** — Branch based on event properties
- **A/B Split** — Random percentage split for testing

### Flow Filters
Applied at the flow level (not individual messages):
- Profile properties (e.g., has placed order = true)
- Segment membership (e.g., is in VIP segment)
- List membership
- Consent status
- Custom properties

### Time Delays
- **Time Delay** — Fixed wait (hours, days)
- **Smart Send Time** — Optimized per recipient
- **Wait until specific day/time** — e.g., next Tuesday at 10am

## Segmentation Conditions

### Behavioral
- Has/has not done [event] in [time period]
- [Event] count >/</= [number] in [time period]
- [Event] property matches [value]

### Profile
- Profile property is/is not/contains [value]
- Is in / not in [list]
- Is in / not in [segment]
- Consent status (subscribed, unsubscribed, never subscribed)

### Predictive (Klaviyo AI)
- Predicted CLV is above/below [value]
- Predicted churn risk is high/medium/low
- Predicted gender is male/female
- Predicted next order date is within [days]

### Engagement
- Has/has not opened email in [days]
- Has/has not clicked email in [days]
- Has/has not opened SMS in [days]

## API Reference (v2)

### Base URL
```
https://a.klaviyo.com/api/
```

### Authentication
```
Authorization: Klaviyo-API-Key {private-api-key}
```

### Key Endpoints

#### Profiles
```
GET    /profiles/                    # List profiles
POST   /profiles/                    # Create profile
GET    /profiles/{id}/               # Get profile
PATCH  /profiles/{id}/               # Update profile
POST   /profile-subscription-bulk-create-jobs/  # Subscribe profiles
```

#### Events (Metrics)
```
POST   /events/                      # Create event
GET    /events/                      # Query events
GET    /metrics/                     # List available metrics
POST   /metric-aggregates/           # Aggregate metric data
```

#### Lists & Segments
```
GET    /lists/                       # List all lists
POST   /lists/                       # Create list
GET    /segments/                    # List all segments
GET    /segments/{id}/profiles/      # Get segment members
```

#### Campaigns
```
GET    /campaigns/                   # List campaigns
POST   /campaigns/                   # Create campaign
POST   /campaign-send-jobs/          # Send campaign
```

#### Flows
```
GET    /flows/                       # List flows
GET    /flows/{id}/                  # Get flow details
PATCH  /flows/{id}/                  # Update flow status
```

#### Catalogs
```
POST   /catalog-items/              # Create catalog item
GET    /catalog-items/              # List catalog items
PATCH  /catalog-items/{id}/         # Update catalog item
```

### Webhooks
Klaviyo can send webhooks for:
- Profile subscribed/unsubscribed
- Email bounced/marked spam
- SMS consent changes
- Custom event triggers via flows

## Email Deliverability Reference

### Authentication Records
```
# SPF (add to your DNS)
v=spf1 include:_spf.klaviyo.com ~all

# DKIM (Klaviyo provides the records)
# Add CNAME records provided in Klaviyo Settings > Email > Domains

# DMARC (recommended)
v=DMARC1; p=quarantine; rua=mailto:dmarc@yourdomain.com
```

### Sending Domain Setup
1. Add your domain in Klaviyo Settings > Email > Domains
2. Add the 3 CNAME records (2 DKIM + 1 Return-Path) to your DNS
3. Verify in Klaviyo (can take up to 48 hours)
4. Dedicated sending domain recommended for high-volume senders

### IP Warming Schedule (Dedicated IP)
| Day | Daily Volume |
|-----|-------------|
| 1-2 | 500 |
| 3-4 | 1,000 |
| 5-6 | 2,500 |
| 7-8 | 5,000 |
| 9-10 | 10,000 |
| 11-14 | 25,000 |
| 15-21 | 50,000 |
| 22-28 | 100,000 |
| 29+ | Full volume |

During warm-up: Send only to most engaged contacts. Monitor bounce rates and spam complaints daily.

## SMS Reference

### Compliance Requirements
- **TCPA** — Express written consent required before sending
- **Quiet Hours** — Default: No SMS 9pm-9am recipient's local time
- **Opt-out** — Must honor STOP/UNSUBSCRIBE immediately
- **Identification** — Business name must be in first message
- **Frequency disclosure** — "Msg frequency varies. Msg & data rates may apply."
- **Short Code vs Toll-Free** — Short codes for high-volume, toll-free for smaller senders

### SMS Character Limits
- Standard SMS: 160 characters (GSM-7 encoding)
- With special characters/emoji: 70 characters (UCS-2 encoding)
- MMS: Up to 1600 characters + media (image/GIF)
- Klaviyo recommendation: Keep under 160 chars, include clear CTA and opt-out

## Integration Setup

### Shopify
- Install Klaviyo app from Shopify App Store
- Auto-syncs: customers, orders, products, carts
- Events synced: Placed Order, Started Checkout, Added to Cart, Viewed Product
- Catalog synced for dynamic product recommendations
- Discount codes auto-generated for flows

### WooCommerce
- Install Klaviyo plugin
- Syncs orders, customers, cart events
- Requires WooCommerce webhook configuration

### Custom (API)
```python
import requests

# Track an event
requests.post(
    "https://a.klaviyo.com/api/events/",
    headers={
        "Authorization": "Klaviyo-API-Key {YOUR_KEY}",
        "Content-Type": "application/json",
        "revision": "2024-10-15"
    },
    json={
        "data": {
            "type": "event",
            "attributes": {
                "metric": {"data": {"type": "metric", "attributes": {"name": "Placed Order"}}},
                "profile": {"data": {"type": "profile", "attributes": {"email": "customer@example.com"}}},
                "properties": {"OrderId": "12345", "value": 99.99}
            }
        }
    }
)
```

## Reporting Metrics Glossary

| Metric | Definition |
|--------|-----------|
| Revenue per Recipient (RPR) | Total attributed revenue / recipients |
| Attributed Revenue | Revenue within attribution window (default: 5-day email click, 24-hour SMS click) |
| Deliverability Rate | (Sent - Bounced) / Sent |
| Unique Open Rate | Unique opens / delivered (affected by Apple MPP) |
| Unique Click Rate | Unique clicks / delivered |
| Click-to-Open Rate (CTOR) | Unique clicks / unique opens |
| Unsubscribe Rate | Unsubscribes / delivered |
| Spam Complaint Rate | Spam complaints / delivered |
| Bounce Rate | (Hard + Soft bounces) / Sent |
| List Growth Rate | (New subscribers - Unsubscribes) / Total list size |

---

## Standard E-Commerce Event Property Schemas

Reference schemas for the standard e-commerce events. Use when auditing event tracking or verifying integration completeness.

### Placed Order
```json
{
  "$value": 149.99,
  "OrderId": "ORD-12345",
  "Categories": ["Hand Tools", "Safety"],
  "ItemNames": ["Torque Wrench 3/8in", "Safety Goggles (Pack/12)"],
  "Brands": ["Stanley", "3M"],
  "DiscountCode": "WELCOME10",
  "DiscountValue": 15.00,
  "Items": [
    {
      "ProductID": "PROD-001",
      "SKU": "STN-TW-38",
      "ProductName": "Torque Wrench 3/8in",
      "Quantity": 2,
      "ItemPrice": 24.99,
      "RowTotal": 49.98,
      "ProductURL": "https://...",
      "ImageURL": "https://...",
      "Categories": ["Hand Tools"],
      "Brand": "Stanley"
    }
  ],
  "ItemCount": 3,
  "ShippingCost": 0.00,
  "Tax": 12.00
}
```
**Critical**: `$value` = revenue property for attribution. `Categories` (top-level) needed for segmentation since `Items[].Categories` is nested and not accessible in segments.

### Started Checkout
```json
{
  "$value": 149.99,
  "CheckoutURL": "https://example.com/checkout/abc123",
  "ItemNames": ["Torque Wrench 3/8in", "Safety Goggles (Pack/12)"],
  "Items": [{ "ProductID": "...", "ProductName": "...", "Quantity": 1, "ItemPrice": 24.99, "ImageURL": "..." }],
  "ItemCount": 3
}
```
**Critical**: `CheckoutURL` required for abandoned cart email CTAs. `$value` enables cart value filters.

### Viewed Product
```json
{
  "ProductName": "Torque Wrench 3/8in",
  "ProductID": "PROD-001",
  "Categories": ["Hand Tools", "Automotive"],
  "Brand": "Stanley",
  "Price": 24.99,
  "CompareAtPrice": 29.99,
  "ImageURL": "https://...",
  "URL": "https://..."
}
```
**Critical**: No `$value` (not a revenue event). `URL` and `ImageURL` required for browse abandonment personalization. `Categories` at top level enables segment filters.

### Added to Cart
```json
{
  "$value": 24.99,
  "AddedItemProductName": "Torque Wrench 3/8in",
  "AddedItemProductID": "PROD-001",
  "AddedItemPrice": 24.99,
  "AddedItemQuantity": 2,
  "ItemNames": ["Torque Wrench 3/8in", "Safety Goggles (Pack/12)"],
  "Items": [{ "ProductID": "...", "ProductName": "...", "Quantity": 1, "ItemPrice": 24.99 }]
}
```
**Critical**: `$value` = added item price (not total cart). `AddedItem*` properties are top-level and segmentable. `Items[]` = full cart for template rendering.

---

## Flow Configuration Best Practices

### Smart Send Settings

| Setting | When to Enable | When to Disable |
|---------|---------------|-----------------|
| Smart Sending ON (16h window) | Promotional flows (browse abandonment, winback) | Time-sensitive flows (abandoned cart, transactional) |
| Smart Sending OFF | Abandoned cart, order confirmation, shipping | Never for promotional flows |
| Skip recently emailed ON | Browse abandonment, cross-sell | Welcome series (first impression), abandoned cart |

### Timing Benchmarks

| Flow | Email 1 | Email 2 | Email 3 | Email 4+ |
|------|---------|---------|---------|----------|
| Welcome Series | Immediate | 1 day | 3 days | 5-7 days |
| Abandoned Cart | 1 hour | 24 hours | 48-72 hours | — |
| Browse Abandonment | 2-4 hours | 24 hours | — | — |
| Post-Purchase | Immediate (confirmation) | 3 days (cross-sell) | 7 days (review) | 14+ days (replenish) |
| Winback | 60 days post-purchase | 75 days | 90 days (last chance) | — |
| Sunset | 90 days unengaged | 104 days | Suppress at 120 days | — |

### Exclusion Filter Patterns

| Flow | Must Exclude | Why |
|------|-------------|-----|
| Welcome | Existing customers (Placed Order ever) | Different messaging for buyers vs browsers |
| Abandoned Cart | Placed Order in last 4 hours | They already bought |
| Browse Abandonment | Started Checkout in last 1 hour, Placed Order in last 24 hours | Higher-intent flow takes priority |
| Winback | Placed Order in last 60 days | They're still active |
| Sunset | Placed Order in last 90 days | Buyers get different treatment |

---

## A/B Testing Framework

### Univariate Testing Rules
1. **Test ONE variable at a time** — Subject line OR send time OR content, never multiple
2. **Define the KPI before launching** — Open rate for subject lines, click rate for content, RPR for offers
3. **Run to statistical significance** — Minimum 95% confidence (p < 0.05)
4. **Equal random split** — 50/50 for flows, 10/10/80 for campaigns (test on 20%, send winner to 80%)

### Minimum Sample Sizes

| Baseline Rate | Detectable Lift | Min Sample (per variant) |
|--------------|-----------------|-------------------------|
| 20% open rate | 10% relative (to 22%) | 7,500 |
| 20% open rate | 20% relative (to 24%) | 2,000 |
| 3% click rate | 20% relative (to 3.6%) | 12,000 |
| 3% click rate | 30% relative (to 3.9%) | 5,500 |
| 1% conversion | 30% relative (to 1.3%) | 18,000 |

### Sequential Test Plan Template

```
Test 1 (Week 1-2): Subject Line
  Variable: Urgency vs Benefit-led
  KPI: Open rate
  Duration: 7 days or 5,000 recipients per variant
  Winner → Becomes default

Test 2 (Week 3-4): CTA Placement
  Variable: Above-fold button vs Below-content button
  KPI: Click rate
  Duration: 7 days or 5,000 recipients per variant
  Winner → Becomes default

Test 3 (Week 5-6): Offer Type
  Variable: % discount vs $ discount vs free shipping
  KPI: Revenue per recipient
  Duration: 14 days or 3,000 recipients per variant
  Winner → Becomes default
```

---

## Segment Architecture Patterns

### Mutually Exclusive Engagement Tiers

Build engagement tiers that don't overlap — each profile falls into exactly one tier:

| Tier | Condition | Sending Strategy |
|------|-----------|-----------------|
| **Active** (0-30d) | Opened OR clicked email in last 30 days | Full frequency (3-5x/week) |
| **Warm** (31-90d) | NOT Active AND (opened OR clicked in last 90 days) | Moderate (2x/week) |
| **At-Risk** (91-180d) | NOT Active AND NOT Warm AND (opened OR clicked in last 180 days) | Reduced (1x/week), re-engagement content |
| **Lapsed** (180d+) | NOT Active AND NOT Warm AND NOT At-Risk AND has received email | Sunset flow only, then suppress |
| **Never Engaged** | Has received email AND has never opened or clicked | Suppress immediately |

### RFM Segment Definitions

| Segment | Recency | Frequency | Monetary | Action |
|---------|---------|-----------|----------|--------|
| **Champions** | Ordered L30d | 4+ orders L12M | Top 20% AOV | VIP treatment, early access |
| **Loyal** | Ordered L60d | 3+ orders L12M | Above avg AOV | Reward programs, referral asks |
| **Promising** | Ordered L90d | 1-2 orders L12M | Any | Nurture to loyalty, product education |
| **At Risk** | No order L90d | 2+ orders ever | Above avg lifetime | Winback flow, incentives |
| **Lost** | No order L180d | Any | Any | Last-chance offer, then sunset |

### Predictive Segment Setup (Klaviyo AI)

| Segment | Condition | Use |
|---------|-----------|-----|
| High CLV | Predicted CLV > 75th percentile | VIP flow trigger, premium offers |
| Churn Risk - High | Predicted churn risk = High | Immediate re-engagement, incentive |
| Churn Risk - Medium | Predicted churn risk = Medium | Nurture content, value reminders |
| Next Order < 14 days | Predicted next order date within 14 days | Replenishment reminder timing |
| Gender - Female | Predicted gender = Female | Content personalization (if relevant) |

---

## SOW / PRD Template Structure

When producing implementation specs (SOWs) for audit recommendations:

```markdown
# [Title]

## Summary
- **Priority**: P1/P2/P3/P4
- **Estimated Impact**: $X-$Y/year or % improvement
- **Complexity**: Low/Medium/High
- **Timeline**: X days/weeks
- **Owner**: Client / Agency / Shared

## Problem Statement
[What's wrong, with evidence from audit data]

## Recommendation (Client-Facing)
[What to do and why, in plain language]

## Implementation Spec (Internal)

### Prerequisites
[What must be done first]

### Step-by-Step Build
[Detailed Klaviyo UI steps OR API/code steps]

### Trigger & Filter Configuration
[Exact trigger type, filter conditions, segment criteria]

### Content Brief
[Subject lines, email structure, CTA copy, dynamic content blocks]

### Timing & Logic
[Delays, conditional splits, Smart Send settings]

### Testing Plan
[A/B test variables, sample size, success criteria, stat sig threshold]

### Success Metrics
[KPIs to track, measurement period, benchmarks]

## Dependencies
[What other SOWs must complete first]
```
