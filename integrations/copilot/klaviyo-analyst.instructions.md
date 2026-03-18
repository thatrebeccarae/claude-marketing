Klaviyo marketing operations and analyst expertise. Audit flows, segments, campaigns, deliverability, and revenue attribution. Use when the user asks about Klaviyo marketing strategy, email/SMS automation, customer segmentation, flow optimization, or lifecycle marketing. For API integration, SDK, webhook, or developer questions, see the klaviyo-developer skill.


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


(Truncated. See full skill at github.com/thatrebeccarae/claude-marketing)
