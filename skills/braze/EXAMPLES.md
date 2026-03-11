# Braze Skill — Examples

## Example 1: Full Workspace Audit

**User Request**: "Audit our Braze workspace. We have about 2M users, running email and push but feel like we're not using the platform fully."

**Analysis Steps**:
1. Inventory all active Canvases and campaigns — map lifecycle coverage against the Essential Canvas Checklist
2. Assess channel coverage — identify which channels (email, push, SMS, in-app, Content Cards) are active vs. available but unused
3. Review segmentation strategy — check for segment overlap, stale segments, and missing behavioral segments
4. Audit data architecture — evaluate custom event naming consistency, attribute usage, and data freshness (last updated timestamps)
5. Pull performance metrics by channel and benchmark against industry standards

**Sample Output**:

### Canvas & Campaign Inventory

| Canvas/Campaign | Type | Status | Channel(s) | 30d Sends | Open Rate | Click Rate |
|----------------|------|--------|-------------|-----------|-----------|------------|
| Welcome Series | Onboarding | Active | Email | 45,200 | 34.2% | 5.1% |
| Weekly Digest | Promotional | Active | Email | 812,000 | 18.7% | 2.3% |
| Cart Abandonment | Trigger | Active | Email | 22,100 | 28.9% | 4.7% |
| Feature Update Q1 | Announcement | Paused | Push | 0 | — | — |

### Lifecycle Coverage Gaps

| Canvas Type | Status | Impact |
|------------|--------|--------|
| Onboarding | Exists (email only) | Missing push opt-in step and in-app tutorial |
| Activation | Missing | No first-7-day feature adoption flow |
| Re-engagement | Missing | No lapsed user targeting |
| Winback | Missing | No long-term dormant recovery |
| Sunset | Missing | Unengaged users dragging down deliverability |

### Channel Utilization

| Channel | Status | Users Reachable | Currently Used |
|---------|--------|----------------|----------------|
| Email | Active | 1.82M (91%) | Yes |
| Push (iOS) | Active | 640K (32%) | Sporadic |
| Push (Android) | Active | 480K (24%) | Sporadic |
| SMS | Provisioned | 310K (15.5%) | No |
| In-App | SDK enabled | 1.1M (55%) | No |
| Content Cards | SDK enabled | 1.1M (55%) | No |

### Prioritized Recommendations

| # | Recommendation | Impact | Effort | Priority |
|---|---------------|--------|--------|----------|
| 1 | Build re-engagement Canvas (7d/14d/30d tiers) | High — recover ~8% of lapsed users | Medium | Quick Win |
| 2 | Add push opt-in prompt to onboarding Canvas | High — increase push reachability from 32% to 50%+ | Low | Quick Win |
| 3 | Launch in-app messaging for feature announcements | Medium — 55% of users reachable via SDK | Low | Quick Win |
| 4 | Build sunset Canvas to suppress 90d+ unengaged | High — protect email deliverability | Medium | Medium |
| 5 | Implement Content Cards for persistent offers | Medium — reduce email fatigue | Medium | Medium |
| 6 | Activate SMS for transactional + high-intent triggers | High — 98% open rates | Large | Large |

---

## Example 2: Onboarding Canvas Design

**User Request**: "Design an onboarding Canvas for our mobile app. We want to drive push opt-in, send a welcome email, and guide users through key features with in-app messages."

**Analysis Steps**:
1. Define entry criteria and schedule — action-based on `account_created` event
2. Map the multi-channel journey — push opt-in prompt, email welcome, in-app tutorial sequence
3. Design Action Paths for branching based on user behavior (opted in vs. not, completed tutorial vs. not)
4. Set timing delays and Intelligent Timing windows
5. Define exception events and exit criteria (e.g., completed all onboarding milestones)

**Sample Output**:

### Canvas Flow

```
Entry: Action-Based → account_created event
│
├─ [Delay: 2 minutes]
│
├─ [Message: In-App] Push opt-in primer
│   "Enable notifications to get personalized updates"
│   (Educate before system prompt)
│
├─ [Delay: 1 hour]
│
├─ [Action Paths — 24h window]
│   ├── Push Opted In → Path A
│   └── Everyone Else → Path B
│
│   Path A (Push + Email):
│   ├─ [Message: Push] "Welcome! Here's your first tip..."
│   ├─ [Delay: 4 hours]
│   ├─ [Message: Email] Welcome email with 3 key features
│   ├─ [Delay: 1 day]
│   ├─ [Action Paths — 48h window]
│   │   ├── Completed Feature 1 → Feature 2 nudge (push)
│   │   └── Everyone Else → Feature 1 reminder (push + in-app)
│   └─ ...
│
│   Path B (Email + In-App only):
│   ├─ [Message: Email] Welcome email with push opt-in CTA
│   ├─ [Delay: 1 day]
│   ├─ [Message: In-App] Feature 1 tutorial
│   ├─ [Delay: 2 days]
│   └─ [Message: In-App] Push opt-in re-prompt
│
└─ [Exception Event: completed_onboarding] → Exit Canvas
```

### Expected Performance

| Step | Channel | Est. Delivery | Est. Engagement |
|------|---------|--------------|-----------------|
| Push opt-in primer | In-App | 68% of DAU | 35% tap-through |
| Push opt-in conversion | System prompt | 45% of prompted | — |
| Welcome push | Push | 92% delivery | 8.2% open |
| Welcome email | Email | 97% delivery | 42% open, 6.8% click |
| Feature tutorial (in-app) | In-App | 55% impression | 28% completion |

### Settings
- **Re-eligibility**: No (one-time onboarding)
- **Rate limiting**: None (time-sensitive)
- **Exception event**: `completed_onboarding` custom event
- **Quiet hours**: 10 PM - 8 AM user local time
- **Entry limit**: None

---

## Example 3: Re-engagement Canvas

**User Request**: "Build a re-engagement Canvas. We're losing users after the first month and need to bring them back with tiered urgency."

**Analysis Steps**:
1. Define inactivity tiers — 7-day, 14-day, and 30-day since last session
2. Design channel preferences per tier — lighter touch early, more aggressive later
3. Implement Experiment Paths to test messaging approaches (incentive vs. value reminder vs. social proof)
4. Set exception events for users who return mid-Canvas
5. Define sunset criteria for users who don't respond after all tiers

**Sample Output**:

### Canvas Flow

```
Entry: Scheduled (daily at 10 AM UTC)
Audience: Last Session > 7 days ago AND Last Session < 60 days ago
│
├─ [Audience Paths]
│   ├── 7-13 days inactive → Tier 1 (Gentle Nudge)
│   ├── 14-29 days inactive → Tier 2 (Value Reminder)
│   └── 30-59 days inactive → Tier 3 (Last Chance)
│
│   Tier 1 — Gentle Nudge:
│   ├─ [Decision Split: Push Opted In?]
│   │   ├── Yes → [Message: Push] "We miss you! Here's what's new..."
│   │   └── No → [Message: Email] "Here's what you've been missing"
│   ├─ [Delay: 3 days]
│   ├─ [Action Paths — 72h]
│   │   ├── Session Started → [User Update] Set re_engaged = true → Exit
│   │   └── Everyone Else → Continue to Tier 2
│   └─ ...
│
│   Tier 2 — Value Reminder:
│   ├─ [Experiment Paths]
│   │   ├── Variant A (40%): Personalized content recap email
│   │   ├── Variant B (40%): Social proof ("12K users loved this feature")
│   │   └── Holdout (20%): No message
│   ├─ [Delay: 5 days]
│   ├─ [Message: In-App] (queued for next session) Feature highlight
│   └─ [Action Paths — 7 days]
│       ├── Session Started → Exit
│       └── Everyone Else → Continue to Tier 3
│
│   Tier 3 — Last Chance:
│   ├─ [Message: Email] "Before you go..." with incentive
│   ├─ [Delay: 3 days]
│   ├─ [Message: Push] Final nudge with urgency
│   ├─ [Delay: 7 days]
│   └─ [User Update] Set lifecycle_stage = "dormant" → Exit
│
└─ [Exception Event: session_start] → Exit Canvas at any point
```

### Experiment Path Configuration (Tier 2)

| Variant | Approach | 30d Results | Conversion Rate |
|---------|----------|-------------|-----------------|
| A: Content Recap | Personalized "what you missed" | 4,200 sessions | 12.4% |
| B: Social Proof | "12K users loved this" | 3,800 sessions | 11.2% |
| Holdout | No message | 1,400 sessions | 4.1% |

**Winner**: Variant A (content recap) at 95% confidence. Incremental lift: +8.3pp over holdout.

### Expected Overall Impact

| Tier | Users Entering/Month | Return Rate | Revenue Impact |
|------|---------------------|-------------|----------------|
| Tier 1 (7d) | 85,000 | 22% | +$4.20 ARPU |
| Tier 2 (14d) | 48,000 | 14% | +$3.10 ARPU |
| Tier 3 (30d) | 31,000 | 6% | +$1.80 ARPU |

---

## Example 4: Data Architecture Review

**User Request**: "Review our Braze data architecture. We have 47 custom events and 83 custom attributes and I think it's gotten messy. Help us clean it up."

**Analysis Steps**:
1. Export the custom event and attribute list — categorize by domain (user profile, behavior, transaction, engagement)
2. Identify naming inconsistencies (camelCase vs. snake_case, abbreviations, duplicates)
3. Assess event property coverage — are properties being passed consistently?
4. Check data freshness — when were attributes last updated? Are any stale?
5. Recommend a normalized schema with naming conventions and deprecation plan

**Sample Output**:

### Naming Consistency Audit

| Issue | Examples | Count |
|-------|----------|-------|
| Mixed casing | `addToCart` vs. `add_to_cart` vs. `AddToCart` | 12 events |
| Duplicate semantics | `purchase_complete` and `order_placed` (same trigger) | 3 pairs |
| Ambiguous names | `action_1`, `flag_2`, `temp_attr` | 8 attributes |
| Missing namespace | `clicked` (clicked what?) vs. `product_card_clicked` | 6 events |
| Unused attributes | Last updated >180 days ago, 0 segment usage | 14 attributes |

### Event Schema Assessment

| Category | Events | Avg. Properties | Consistency Score |
|----------|--------|----------------|-------------------|
| Commerce | 11 | 4.2 | 72% (missing `currency` on 3 events) |
| Content | 8 | 2.8 | 85% |
| Account | 6 | 3.1 | 91% |
| Feature Usage | 14 | 1.4 | 48% (most missing properties) |
| Marketing | 8 | 2.0 | 65% |

### Data Freshness

| Attribute Category | Total | Updated <30d | Updated 30-90d | Stale (>90d) |
|-------------------|-------|-------------|----------------|--------------|
| User Profile | 22 | 18 | 3 | 1 |
| Preferences | 15 | 8 | 4 | 3 |
| Behavioral Scores | 12 | 12 | 0 | 0 |
| Legacy/Migration | 34 | 2 | 5 | 27 |

### Recommended Schema (Normalized)

**Naming Convention**: `snake_case`, `{domain}_{action}_{object}`

| Current | Recommended | Action |
|---------|-------------|--------|
| `addToCart` | `cart_item_added` | Rename + migrate |
| `add_to_cart` | `cart_item_added` | Merge with above |
| `purchase_complete` | `order_completed` | Rename |
| `order_placed` | `order_completed` | Merge (duplicate) |
| `action_1` | Deprecate | Remove after 30d monitoring |
| `clicked` | `product_card_clicked` | Rename + add properties |

### Prioritized Recommendations

| # | Action | Impact | Effort |
|---|--------|--------|--------|
| 1 | Merge 3 duplicate event pairs | High — reduces confusion, fixes analytics | Low |
| 2 | Add required properties to 14 feature events | High — enables property-based segmentation | Medium |
| 3 | Deprecate 14 unused attributes | Medium — cleaner workspace, faster queries | Low |
| 4 | Standardize all events to snake_case | Medium — developer experience | Large |
| 5 | Archive 27 stale legacy attributes | Low — cosmetic cleanup | Low |

---

## Example 5: Push Notification Strategy

**User Request**: "Our push opt-in rate is 28% on iOS and we know it should be higher. Help us design an opt-in optimization strategy."

**Analysis Steps**:
1. Benchmark current opt-in rate against industry averages (iOS median: 42-50%)
2. Audit the current opt-in flow — when is the system prompt triggered? Is there a primer?
3. Design a provisional authorization strategy (iOS 12+) to capture quiet push first
4. Plan a multi-touchpoint opt-in strategy across the user journey
5. Define measurement framework for tracking opt-in lift

**Sample Output**:

### Current State Assessment

| Metric | Your Rate | Industry Median | Gap |
|--------|-----------|----------------|-----|
| iOS Opt-In Rate | 28% | 45% | -17pp |
| Android Opt-In Rate | 62% | 68% | -6pp |
| Push Token Freshness | 74% valid | 85% valid | -11pp |
| Opt-In Prompt Timing | Immediate (app launch) | After value moment | Poor |

### Root Cause Analysis
1. **System prompt fires on first launch** — Users haven't experienced value yet, default to "Don't Allow"
2. **No pre-permission primer** — No in-app screen explaining push value before iOS system dialog
3. **No re-prompting** — Users who initially decline are never re-asked
4. **No provisional authorization** — Missing the "quiet push" fallback for iOS 12+

### Recommended Opt-In Flow

```
First Session:
├─ [iOS 12+] Enable Provisional Authorization (quiet push)
│   User automatically receives quiet notifications in Notification Center
│   No prompt needed — builds habit before explicit opt-in
│
├─ [After Value Moment — e.g., first purchase, first saved item]
│   Show in-app primer screen:
│   "Get notified when your saved items go on sale"
│   [Enable Notifications] → trigger system prompt
│   [Not Now] → flag for re-prompt later
│
├─ [7 days later, if still provisional/declined]
│   In-app message: "You have 3 unread updates"
│   Contextual CTA to enable full notifications
│
└─ [30 days later, if still declined]
    Settings deep-link prompt during high-intent moment
```

### Rich Push Best Practices

| Element | Recommendation | Impact |
|---------|---------------|--------|
| Images | 2:1 ratio, <1MB, product-specific | +15-25% open rate |
| Action buttons | 2 buttons max for clarity | +8-12% engagement |
| Notification grouping | Group by category (orders, social, promos) | -30% dismissals |
| Time-sensitive | Use for flash sales, delivery updates | Bypasses Focus modes |

### Projected Impact

| Phase | Timeline | Projected iOS Opt-In | Incremental Users |
|-------|----------|---------------------|-------------------|
| Provisional auth | Week 1 | 28% → 28% (quiet) + 65% provisional | +148K reachable |
| Pre-permission primer | Week 2-3 | 28% → 38% | +40K opted-in |
| Re-prompting flow | Month 2 | 38% → 44% | +24K opted-in |
| Contextual triggers | Month 3 | 44% → 48% | +16K opted-in |

---

## Example 6: Klaviyo to Braze Migration Plan

**User Request**: "We're migrating from Klaviyo to Braze. We have 500K profiles, 12 Flows, and heavy Shopify integration. Help me plan the migration."

**Analysis Steps**:
1. Map Klaviyo data model to Braze — profiles, events, lists/segments, Flows to Canvases
2. Design the event schema translation — Klaviyo's Shopify events to Braze custom events
3. Plan the channel migration sequence — which channels cut over first?
4. Build the parallel-run timeline — both platforms active during transition
5. Define rollback criteria and success metrics

**Sample Output**:

### Data Model Mapping

| Klaviyo Concept | Braze Equivalent | Migration Notes |
|----------------|-----------------|-----------------|
| Profile | User Profile | Map `$email` to `email`, custom props to custom attributes |
| List | Segment (static) | Recreate as segments or import via API |
| Segment | Segment (dynamic) | Rebuild with Braze filter syntax |
| Flow | Canvas | Redesign — Canvas Flow is more powerful |
| Campaign | Campaign | 1:1 mapping, rebuild templates |
| Metric (event) | Custom Event | Rename to Braze conventions |
| Catalog | Catalog | Direct import via CSV or API |

### Event Schema Translation

| Klaviyo Event | Braze Event | Properties to Map |
|--------------|-------------|-------------------|
| `Placed Order` | `order_completed` | order_id, total, items[], currency |
| `Ordered Product` | (nested in order_completed) | product_id, name, price, quantity |
| `Started Checkout` | `checkout_started` | cart_value, item_count |
| `Added to Cart` | `cart_item_added` | product_id, name, price, variant |
| `Viewed Product` | `product_viewed` | product_id, name, category, price |
| `Active on Site` | `session_start` (SDK) | Handled automatically by Braze SDK |

### Flow-to-Canvas Migration

| Klaviyo Flow | Braze Canvas | Key Differences |
|-------------|-------------|-----------------|
| Welcome Series (3 emails) | Onboarding Canvas | Add push opt-in step, in-app tutorial |
| Abandoned Cart (2 emails) | Cart Abandonment Canvas | Add push channel, exception event on purchase |
| Post-Purchase (3 emails) | Post-Purchase Canvas | Add review request via in-app, Content Card |
| Winback (2 emails) | Re-engagement Canvas | Add 3 inactivity tiers, Experiment Paths |
| Browse Abandonment | Browse Abandonment Canvas | Add push for opted-in users |

### Migration Timeline

| Week | Activity | Risk Level |
|------|----------|------------|
| 1-2 | SDK integration, data pipeline setup, event validation | Low |
| 3-4 | Historical data import (profiles + attributes via `/users/track`) | Medium |
| 5-6 | Rebuild segments, build Canvases in draft mode | Low |
| 7 | IP warming begins (email channel) — see Example 7 | Medium |
| 8-9 | Parallel run: both platforms sending, monitor deliverability | High |
| 10 | Cut over transactional email to Braze | Medium |
| 11 | Cut over marketing email + activate push/in-app | Medium |
| 12 | Klaviyo sunset, final data export, decommission | Low |

### Parallel Run Rules
- **Never send the same user the same message from both platforms** — use suppression segments
- Braze sends to new users (signed up after SDK integration)
- Klaviyo sends to existing users until Canvas equivalents are validated
- Monitor: delivery rates, open rates, and spam complaints on both platforms daily

### Rollback Criteria
- Email delivery rate drops below 95% on Braze
- Spam complaint rate exceeds 0.1%
- Revenue per email drops >20% compared to Klaviyo baseline

---

## Example 7: Deliverability & IP Warming

**User Request**: "We just set up a new Braze workspace with dedicated IPs. We have 800K email subscribers. Plan our IP warming schedule and monitoring framework."

**Analysis Steps**:
1. Assess email list health — engagement recency, hard bounces, spam traps
2. Build a tiered warming schedule — start with most engaged, gradually expand
3. Design the monitoring dashboard — key metrics to watch daily
4. Plan fallback strategy if deliverability drops during warming
5. Set up authentication (SPF, DKIM, DMARC) verification checklist

**Sample Output**:

### Pre-Warming Checklist

| Item | Status | Action Required |
|------|--------|----------------|
| SPF record | Verify | Add Braze SPF include to DNS |
| DKIM signing | Verify | Upload Braze DKIM keys to DNS |
| DMARC policy | Verify | Set `p=none` during warming, move to `p=quarantine` after |
| Return-Path | Configure | Set custom return-path domain |
| List hygiene | Required | Remove hard bounces, 12mo+ unengaged, known spam traps |
| Seed list | Required | Set up inbox placement monitoring (250ok, GlockApps) |

### List Segmentation for Warming

| Tier | Criteria | Size | Send Order |
|------|----------|------|------------|
| Tier 1 | Opened email in last 30 days | 142K | Week 1-2 |
| Tier 2 | Opened email in last 60 days | 98K | Week 2-3 |
| Tier 3 | Opened email in last 90 days | 124K | Week 3-4 |
| Tier 4 | Opened email in last 180 days | 186K | Week 4-5 |
| Tier 5 | Clicked but not opened 180d+ | 72K | Week 5-6 |
| Suppress | No engagement 180d+ | 178K | Do not send — sunset Canvas |

### IP Warming Schedule

| Day | Volume | Audience | Content |
|-----|--------|----------|---------|
| 1 | 5,000 | Tier 1 (most engaged) | High-value content (not promotional) |
| 2 | 5,000 | Tier 1 | — |
| 3 | 10,000 | Tier 1 | — |
| 5 | 15,000 | Tier 1 | — |
| 7 | 25,000 | Tier 1 | — |
| 10 | 40,000 | Tier 1 + 2 | — |
| 14 | 75,000 | Tier 1 + 2 | — |
| 18 | 120,000 | Tier 1 + 2 + 3 | — |
| 22 | 200,000 | Tier 1-3 | — |
| 28 | 350,000 | Tier 1-4 | — |
| 35 | 550,000 | Tier 1-4 + 5 | — |
| 42 | Full volume | All active tiers | Full cadence |

### Daily Monitoring Dashboard

| Metric | Green | Yellow | Red (Pause Warming) |
|--------|-------|--------|---------------------|
| Delivery Rate | >97% | 95-97% | <95% |
| Bounce Rate | <2% | 2-3% | >3% |
| Spam Complaint | <0.05% | 0.05-0.08% | >0.08% |
| Open Rate | >25% | 15-25% | <15% |
| Unsubscribe Rate | <0.2% | 0.2-0.3% | >0.3% |
| Gmail Postmaster reputation | High | Medium | Low/Bad |

### ISP-Specific Notes

| ISP | Volume Share | Key Considerations |
|-----|------------|-------------------|
| Gmail | ~38% | Postmaster Tools required, engagement-based filtering, tabbed inbox |
| Microsoft (Outlook/Hotmail) | ~22% | SNDS monitoring, aggressive spam filtering, slow to build reputation |
| Yahoo/AOL | ~14% | CFL monitoring, IP reputation builds slowly |
| Apple Mail (iCloud) | ~8% | Privacy Protection hides opens — track clicks instead |
| Corporate (Exchange) | ~18% | Varies by org — IT policies may block new IPs |

### Fallback Protocol
If any RED metric triggers:
1. **Immediately** reduce volume to last-known-good level
2. **Investigate** — check for spam trap hits, content issues, authentication failures
3. **Wait 48 hours** at reduced volume before attempting to scale again
4. **If persistent** — contact Braze deliverability team and ISP postmaster support

---

## Common Analysis Patterns

### Pattern: Canvas Performance Review
```
For each active Canvas:
1. Pull 30-day performance by step
2. Identify drop-off points (>50% exit between steps)
3. Compare variant performance (if Experiment Paths exist)
4. Check exception event trigger rate
5. Benchmark against channel-level KPIs
```

### Pattern: Segment Health Check
```
For each active segment:
1. Current size and 30-day growth trend
2. Overlap with other segments (>60% overlap = consolidation candidate)
3. Filter complexity (>5 filters = review for Segment Extension)
4. Usage count (which Canvases/campaigns reference this segment?)
5. Reachability by channel (what % of segment is push/email/SMS reachable?)
```

### Pattern: Channel Mix Optimization
```
1. Map reachability: % of users reachable per channel
2. Calculate channel-level conversion rates
3. Identify channel preference by segment (which channel drives action?)
4. Model frequency caps per channel
5. Recommend optimal channel sequence for key Canvases
```

### Pattern: Data Quality Audit
```
1. List all custom events — check naming convention consistency
2. List all custom attributes — check for stale (>90d since update) and unused
3. Verify event properties are passed consistently (no missing required fields)
4. Check for PII in custom attributes that shouldn't be there
5. Validate external_id coverage (% of profiles with external_id vs. anonymous)
```

---

## Pro Tips

| Instead of... | Ask... |
|--------------|--------|
| "Set up a welcome email" | "Design an onboarding Canvas with push opt-in, welcome email, and in-app tutorial with Action Paths based on user behavior" |
| "Send a push notification" | "Build a push strategy with provisional authorization, rich push templates, and optimal timing by user timezone" |
| "Create a segment for inactive users" | "Design a tiered re-engagement Canvas with 7d/14d/30d inactivity segments, Experiment Paths, and channel preference routing" |
| "Fix our email deliverability" | "Audit our email reputation, build an IP warming plan segmented by engagement recency, and set up ISP-level monitoring" |
| "Migrate from Klaviyo" | "Plan a 12-week Klaviyo-to-Braze migration with data model mapping, event schema translation, parallel-run rules, and rollback criteria" |
