Braze customer engagement platform expertise. Audit campaigns, Canvases, segments, messaging channels, and data architecture. Use when the user asks about Braze, customer engagement, push notifications, in-app messaging, cross-channel orchestration, or lifecycle marketing at scale.


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


(Truncated. See full skill at github.com/thatrebeccarae/claude-marketing)
