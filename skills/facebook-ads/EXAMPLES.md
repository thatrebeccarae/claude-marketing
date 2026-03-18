# Meta Ads Skill — Examples

Realistic examples showing how this skill handles common Meta Ads analysis requests.

---

## 1. Full Account Audit

**User Request**: "Audit my Meta Ads account. We're spending $45K/month across 12 campaigns and ROAS has dropped from 4.2x to 2.8x over the past 6 weeks."

**Analysis Steps**:
1. Pull account-level metrics for the trailing 90 days — segment by campaign, week, and placement to isolate when and where ROAS declined.
2. Check pixel and CAPI health: event match quality scores, deduplication status, and AEM priority configuration.
3. Evaluate account structure for campaign overlap, audience fragmentation, and budget distribution across funnel stages.
4. Assess creative performance: identify fatigue signals (rising frequency + declining CTR), format mix, and testing velocity.
5. Review attribution settings and cross-reference Meta-reported conversions against GA4 to quantify any attribution gap.

**Sample Output**:

### Account Health Summary

| Metric | 6 Weeks Ago | Current | Trend |
|--------|-------------|---------|-------|
| Monthly Spend | $44,200 | $46,100 | +4.3% |
| ROAS | 4.2x | 2.8x | -33% |
| CPM | $11.40 | $16.80 | +47% |
| CTR (Link) | 2.1% | 1.3% | -38% |
| Frequency (Prospecting) | 1.8 | 3.6 | +100% |
| Purchases | 1,854 | 1,290 | -30% |

### Critical Findings

**P0 — Audience Saturation (Impact: High)**
Prospecting frequency has doubled to 3.6. Three campaigns target overlapping interest stacks with no exclusions. Estimated audience overlap: 40-55%. Consolidate into one prospecting campaign with broad targeting and exclude past purchasers (180 days).

**P1 — Creative Fatigue (Impact: High)**
Top 4 ads have been running 8+ weeks with no new variants. CTR has declined 38%. Only 2 new ads introduced in 6 weeks vs. recommended 4-6 per cycle. Immediate creative refresh needed — prioritize UGC and new hook angles.

**P2 — CPM Inflation from Competition (Impact: Medium)**
CPMs rose 47%, consistent with seasonal auction pressure. However, the frequency issue is compounding this — narrower exhausted audiences cost more to reach. Broadening targeting will partially offset.

**P3 — CAPI Gaps (Impact: Medium)**
Event match quality is 5.2/10 — missing fbc/fbp cookie passthrough on 60% of server events. Fix deduplication (event_id not set on 3 of 8 standard events). Estimated 15-20% of conversions are being lost in attribution.

### Recommended Action Plan
1. **This week**: Consolidate 5 prospecting campaigns into 1 broad campaign (CBO). Add purchaser exclusions.
2. **This week**: Launch 4 new creative concepts (2 UGC, 1 testimonial carousel, 1 product demo video).
3. **Next week**: Fix CAPI implementation — add fbc/fbp passthrough and event_id deduplication.
4. **Next week**: Reprioritize AEM events — move Subscribe below Purchase/InitiateCheckout.
5. **Ongoing**: Establish 2-week creative testing cadence with 3-4 new ads per cycle.

---

## 2. Creative Fatigue Diagnosis

**User Request**: "Our Facebook ads CTR keeps dropping. We refresh creative every month but performance still declines by week 3. What's going on?"

**Analysis Steps**:
1. Pull ad-level metrics by week for the trailing 60 days — CTR, frequency, impressions, and spend per ad.
2. Identify fatigue inflection points: the week where CTR begins declining and frequency begins rising for each ad.
3. Analyze creative diversity — how many distinct concepts vs. minor variations are in rotation.
4. Check audience size relative to budget to calculate expected saturation rate.

**Sample Output**:

### Creative Fatigue Analysis

| Ad Name | Week 1 CTR | Week 2 CTR | Week 3 CTR | Week 4 CTR | Frequency at Week 3 |
|---------|-----------|-----------|-----------|-----------|---------------------|
| Spring_Sale_Static_v1 | 2.4% | 2.1% | 1.4% | 0.9% | 3.2 |
| Spring_Sale_Static_v2 | 2.2% | 1.9% | 1.2% | 0.8% | 3.4 |
| Spring_Sale_Video_v1 | 3.1% | 2.8% | 2.0% | 1.3% | 2.9 |
| Spring_Sale_Carousel_v1 | 1.8% | 1.6% | 1.1% | 0.7% | 3.5 |

### Diagnosis

The problem is not refresh cadence — it is creative diversity. All four ads share the same concept (spring sale, discount-forward messaging) with only format differences. Meta's algorithm treats these as one "idea" and your audience sees the same message repeatedly regardless of which ad is served.

**Audience saturation math**: Your prospecting audience is ~1.2M with $800/day spend and $14 CPM. That is ~57K impressions/day across 1.2M people = frequency of 1.0 every 3 weeks. With 4 same-concept ads, effective frequency feels much higher because the message is identical.

### Recommendations

1. **Concept diversity over format diversity**: Each refresh cycle should include 3+ distinct angles (e.g., testimonial, problem-agitation, lifestyle aspiration, product demo, founder story) — not just the same pitch in image vs. video.
2. **Stagger launches**: Instead of replacing all ads on day 1 of the month, introduce 2 new ads every 2 weeks so there is always something fresh in the mix.
3. **Increase audience size**: Move from interest stacks (1.2M) to broad or 1-5% Lookalike (5-10M). Larger pool slows frequency buildup.
4. **Add UGC**: UGC typically maintains CTR 30-50% longer than studio creative because it reads as organic content in-feed.
5. **Kill threshold**: Pause any ad where CTR drops below 1.0% AND frequency exceeds 3.0. Do not wait for end-of-month.

---

## 3. CAPI & Pixel Health Check

**User Request**: "We set up Conversions API through our Shopify integration 3 months ago but I'm not sure it's working correctly. Our event match quality score is 4.8. Can you help diagnose?"

**Analysis Steps**:
1. Check Events Manager for CAPI event delivery — verify which events are sending via browser pixel only, CAPI only, or both (redundant setup).
2. Evaluate event match quality parameters: which user data fields are being passed and which are missing.
3. Verify deduplication is working — check for event_id consistency between pixel and CAPI events.
4. Review AEM configuration and event priority ranking.

**Sample Output**:

### CAPI Health Dashboard

| Event | Pixel | CAPI | Deduplicated | EMQ Score |
|-------|-------|------|-------------|-----------|
| PageView | Yes | No | N/A | — |
| ViewContent | Yes | Yes | No | 4.2 |
| AddToCart | Yes | Yes | No | 4.5 |
| InitiateCheckout | Yes | Yes | Yes | 5.8 |
| Purchase | Yes | Yes | Yes | 6.1 |
| Lead | Yes | No | N/A | — |
| Search | Yes | No | N/A | — |
| CompleteRegistration | Yes | No | N/A | — |

### Issues Found

**Issue 1: Incomplete CAPI Coverage**
Only 4 of 8 events are sending via CAPI. PageView, Lead, Search, and CompleteRegistration are browser-pixel-only, which means iOS 14.5+ users blocking the pixel will not have these events tracked at all.

**Issue 2: Missing Deduplication on ViewContent and AddToCart**
These events fire via both pixel and CAPI but without matching event_id values. Meta cannot deduplicate them, so you are likely seeing inflated ViewContent and AddToCart counts (estimated 15-30% over-count). This distorts funnel metrics and can confuse the optimization algorithm.

**Issue 3: Low User Data Parameters**
Your CAPI events are passing email and phone (hashed), but missing:
- `fbc` cookie (the `_fbc` URL parameter / cookie) — this is the single highest-impact parameter for match quality
- `fbp` cookie (the `_fbp` first-party cookie)
- `client_ip_address` — not being forwarded from Shopify
- `external_id` — Shopify customer ID not mapped

### EMQ Improvement Plan

| Action | Current EMQ Impact | Estimated New EMQ |
|--------|-------------------|-------------------|
| Add fbc cookie passthrough | +1.5-2.0 points | 6.3-6.8 |
| Add fbp cookie passthrough | +0.5-1.0 points | 6.8-7.8 |
| Add client IP address | +0.5 points | 7.3-8.3 |
| Add external_id (Shopify customer ID) | +0.3 points | 7.6-8.6 |
| Fix deduplication on ViewContent/AddToCart | Accuracy improvement | — |

**Target**: EMQ of 8.0+ across all CAPI events.

### Implementation Steps
1. In Shopify admin, go to Settings > Customer Events > Meta pixel. Verify "Use Conversions API" is enabled with "Maximum" data sharing.
2. If using a custom CAPI integration, update server-side code to read `_fbc` and `_fbp` cookies from the request and pass them in the `UserData` object.
3. Add `event_id` to both pixel and CAPI calls for ViewContent and AddToCart events — use the same unique ID (e.g., `{event}_{timestamp}_{product_id}`).
4. Map Shopify customer ID to `external_id` in the CAPI UserData payload.
5. After changes, monitor Events Manager > Test Events for 48 hours to verify deduplication and parameter delivery.

---

## 4. Audience Overlap Analysis

**User Request**: "We're running 6 prospecting campaigns with different audiences but performance has been declining across all of them. Could they be competing against each other?"

**Analysis Steps**:
1. List all active prospecting campaigns with their audience definitions, sizes, and spend.
2. Use the Audience Overlap tool (or manual analysis) to estimate overlap percentages between each pair.
3. Calculate the effective unique reach vs. total combined audience size.
4. Design a consolidation plan that preserves audience signals while eliminating internal competition.

**Sample Output**:

### Campaign Inventory

| Campaign | Audience | Est. Size | Daily Budget | CPA (Last 14d) |
|----------|----------|-----------|-------------|----------------|
| Prospecting - Fitness Interest | Fitness & Wellness interests | 2.1M | $150 | $38.20 |
| Prospecting - Yoga Interest | Yoga, Pilates, Meditation | 1.4M | $120 | $41.50 |
| Prospecting - Health Food | Organic food, Clean eating | 1.8M | $100 | $44.10 |
| Prospecting - LAL Purchase 1% | 1% Lookalike of purchasers | 2.3M | $200 | $29.40 |
| Prospecting - LAL ATC 3% | 3% Lookalike of add-to-cart | 6.9M | $150 | $35.80 |
| Prospecting - LAL Email 1% | 1% Lookalike of email list | 2.3M | $100 | $42.90 |

### Overlap Matrix

| | Fitness | Yoga | Health Food | LAL Purch | LAL ATC | LAL Email |
|---|---------|------|-------------|-----------|---------|-----------|
| **Fitness** | — | 62% | 48% | 35% | 28% | 33% |
| **Yoga** | 62% | — | 41% | 30% | 22% | 28% |
| **Health Food** | 48% | 41% | — | 27% | 21% | 25% |
| **LAL Purch** | 35% | 30% | 27% | — | 55% | 68% |
| **LAL ATC** | 28% | 22% | 21% | 55% | — | 45% |
| **LAL Email** | 33% | 28% | 25% | 68% | 45% | — |

### Key Finding

You are bidding against yourself in Meta's auction. The three interest campaigns overlap 41-62% with each other, and the three Lookalike campaigns overlap 45-68%. Combined unique reach is approximately 8.2M — not the 16.8M implied by adding all audience sizes.

With $820/day across 6 campaigns, Meta is serving the same users ads from multiple campaigns and your CPAs are inflated by 20-35% due to internal auction competition.

### Consolidation Plan

**New Structure (3 campaigns down from 6)**:

| Campaign | Audience | Budget | Rationale |
|----------|----------|--------|-----------|
| Prospecting - Broad | No targeting constraints, Advantage+ Audience with interest suggestions | $450/day | Combines all interest signals. Meta's ML finds the best users from the full pool. |
| Prospecting - Value LAL | 1% Lookalike of purchasers (value-based) | $250/day | Highest-performing audience. Keep isolated for budget control. |
| Prospecting - Scale LAL | 3-5% Lookalike of purchasers | $120/day | Broader reach when primary LAL saturates. |

**Exclusions to add**: Purchasers (180 days), website visitors (30 days), all retargeting Custom Audiences.

**Expected impact**: CPA reduction of 15-25% within 2 weeks as auction competition resolves. Combined unique reach increases because Meta can optimize across the full addressable audience.

---

## 5. Advantage+ Shopping Evaluation

**User Request**: "We're an ecommerce brand doing $200K/month on Meta. Should we move to Advantage+ Shopping campaigns? We're currently using manual campaigns with Lookalike audiences."

**Analysis Steps**:
1. Assess readiness criteria: pixel data maturity, creative volume, catalog setup, and conversion volume.
2. Review current manual campaign performance as a baseline.
3. Design a migration plan with a testing phase before full cutover.
4. Define guardrails — existing customer budget cap, minimum creative requirements.

**Sample Output**:

### Readiness Assessment

| Criteria | Status | Notes |
|----------|--------|-------|
| Monthly conversions (Purchase) | 320/month | Above 100/month threshold — good |
| Pixel maturity | 18 months of data | Strong signal for Meta's ML |
| CAPI implemented | Yes, EMQ 7.4 | Good data quality |
| Product catalog | 240 SKUs, feed via Shopify | Clean feed, no disapprovals |
| Creative assets | 8 active ads | Minimum 10-15 recommended — need more |
| Existing customer % of revenue | ~35% | Need budget cap to protect prospecting |

**Verdict**: Ready for Advantage+ Shopping with minor preparation.

### Current Performance Baseline

| Metric | Manual Campaigns (Last 30d) |
|--------|----------------------------|
| Spend | $48,200 |
| Revenue (Meta-attributed) | $196,400 |
| ROAS | 4.07x |
| Purchases | 412 |
| CPA | $117.00 |
| CPM | $13.20 |

### Migration Plan

**Phase 1 — Preparation (Week 1)**
- Create 6-8 additional creative assets (UGC, lifestyle, product close-up, carousel) to reach 15+ total
- Set up product sets for top sellers vs. full catalog
- Verify catalog feed quality — titles, descriptions, images, pricing all current

**Phase 2 — Test (Weeks 2-3)**
- Launch Advantage+ Shopping campaign at 20% of prospecting budget ($200/day)
- Set existing customer budget cap at 15% (prevents ASC from just retargeting past buyers)
- Run alongside manual campaigns — do not pause them yet
- Creative: load all 15+ ads into the single ASC campaign (Meta mixes and matches)

**Phase 3 — Evaluate (Week 4)**
- Compare ASC vs. manual on: ROAS, CPA, incremental reach, new customer %
- If ASC ROAS is within 80% of manual at higher spend efficiency, begin shifting budget

**Phase 4 — Scale (Weeks 5-8)**
- Increase ASC to 50%, then 70% of prospecting budget
- Maintain 1 manual retargeting campaign for cart abandoners (ASC does not handle retargeting segmentation well)
- Keep 1 manual prospecting campaign at reduced budget as a control

### Guardrails
- **Existing customer budget cap**: Start at 15%, adjust based on new vs. returning customer split
- **Creative refresh**: ASC burns through creative faster — plan for 4-6 new assets every 2 weeks
- **Do not**: Put all budget into ASC on day 1. The algorithm needs 1-2 weeks to learn.

---

## 6. iOS 14.5+ Attribution Review

**User Request**: "Meta says we did $380K in purchases last month but GA4 only shows $290K attributed to Facebook. Which number is right and how do we reconcile?"

**Analysis Steps**:
1. Compare attribution models: Meta's default (7-day click, 1-day view) vs. GA4's last-click model.
2. Quantify the expected gap from view-through attribution, cross-device conversions, and iOS modeled data.
3. Check CAPI and pixel event consistency to rule out tracking gaps.
4. Build a reconciliation framework for ongoing reporting.

**Sample Output**:

### Attribution Gap Analysis

| Source | Attributed Revenue | Purchases | Avg. Order Value |
|--------|-------------------|-----------|-----------------|
| Meta Ads Manager (7d click, 1d view) | $380,400 | 1,268 | $300 |
| Meta Ads Manager (1d click only) | $312,600 | 1,042 | $300 |
| GA4 (last-click, facebook/paid) | $290,200 | 967 | $300 |
| GA4 (first-click, facebook/paid) | $318,400 | 1,061 | $300 |

### Where the $90K Gap Comes From

| Factor | Estimated Revenue Impact | Explanation |
|--------|------------------------|-------------|
| View-through conversions (1-day) | $67,800 | Meta credits purchases within 1 day of ad view even without a click. GA4 does not track view-through at all. |
| Cross-device conversions | $22,400 | User clicks ad on mobile, purchases on desktop. Meta's people-based tracking connects these; GA4 sees two separate sessions. |
| iOS modeled conversions | $18,200 | ~30% of iOS conversions are statistically modeled by Meta due to ATT opt-outs. These may not have corresponding GA4 sessions. |
| UTM parameter loss | $8,600 | Redirect chains, app-to-browser handoffs, and Safari ITP strip UTM parameters. GA4 attributes these to direct/organic. |
| **Subtotal (over-count factors)** | **$117,000** | |
| GA4 under-attribution (cookie loss) | -$26,800 | 7-day ITP cookie expiry means GA4 loses attribution on delayed purchases. Meta's server-side data retains this. |
| **Net expected gap** | **$90,200** | Matches observed $90,200 gap |

### Reconciliation Framework

Neither number is "right" — they measure different things. Use this framework:

| Reporting Context | Use This Number | Source |
|-------------------|-----------------|--------|
| Media efficiency / ROAS optimization | Meta 7d click, 1d view | Meta Ads Manager |
| Conservative revenue attribution | Meta 1d click only | Meta Ads Manager |
| Cross-channel comparison (apples-to-apples) | GA4 last-click | GA4 |
| Incrementality / true contribution | Conversion lift study | Meta Experiments |
| Board / finance reporting | Blended: GA4 last-click + 20-30% uplift factor | Calculated |

### Recommendations

1. **Add 1-day click column** to your Meta dashboard as a secondary reference — it is closer to GA4's model and useful for conservative planning.
2. **Run a conversion lift study** ($5K-10K test budget, 2-4 weeks) to measure true incremental impact. This resolves the "which number is real" question definitively.
3. **Fix UTM tracking**: Ensure all ads use consistent `utm_source=facebook&utm_medium=paid&utm_campaign={campaign_name}` parameters. Check for redirect chains that strip parameters.
4. **Monitor the gap ratio monthly**: A $90K gap on $380K (24%) is within normal range for a 7d-click/1d-view window. If the gap exceeds 35%, investigate CAPI or pixel issues.

---

## 7. Full-Funnel Campaign Design

**User Request**: "We're a DTC skincare brand launching on Meta Ads for the first time. Budget is $15K/month. Design a full-funnel campaign structure."

**Analysis Steps**:
1. Determine funnel stages needed based on brand maturity (new brand = heavier top-of-funnel).
2. Allocate budget across prospecting, retargeting, and retention based on a new-brand ratio.
3. Define audience strategy for each stage — broad prospecting for new brands with limited pixel data.
4. Recommend creative types and volume for launch.
5. Set KPI targets for each funnel stage.

**Sample Output**:

### Budget Allocation

| Funnel Stage | Budget | % of Total | Objective |
|-------------|--------|-----------|-----------|
| Prospecting (Cold) | $10,500/mo | 70% | Sales — Purchases |
| Retargeting (Warm) | $3,000/mo | 20% | Sales — Purchases |
| Retention (Hot) | $1,500/mo | 10% | Sales — Repeat Purchase |

### Campaign Structure

```
Ad Account: [Brand] Skincare
│
├── Campaign: Prospecting - Broad (CBO, $350/day)
│   ├── Ad Set: Broad - Women 25-54 (no interests, Advantage+ Audience)
│   │   ├── Ad: UGC testimonial video (15s, 9:16 + 1:1)
│   │   ├── Ad: Before/after carousel (4 cards)
│   │   ├── Ad: Founder story video (30s)
│   │   ├── Ad: Product close-up static (key ingredient focus)
│   │   ├── Ad: Problem-agitation static ("Tired of...")
│   │   └── Ad: Social proof static (reviews + star rating)
│   │
│   └── Ad Set: LAL 1% - Email Subscribers (if 1,000+ list)
│       └── [Same 6 ads]
│
├── Campaign: Retargeting - Warm (ABO, $100/day)
│   ├── Ad Set: Website Visitors 1-30 days (excl. purchasers)  — $50/day
│   │   ├── Ad: Testimonial carousel (different from prospecting)
│   │   ├── Ad: Limited-time offer static
│   │   └── Ad: "Still thinking about it?" dynamic product ad
│   │
│   └── Ad Set: Engaged 1-60 days (IG/FB interaction, video viewers) — $50/day
│       ├── Ad: Ingredient deep-dive carousel
│       ├── Ad: UGC "my routine" video
│       └── Ad: Free shipping offer static
│
└── Campaign: Retention - Repeat Purchase (ABO, $50/day)
    └── Ad Set: Past Purchasers 30-180 days — $50/day
        ├── Ad: New product launch announcement
        ├── Ad: Bundle/subscription offer
        └── Ad: Loyalty reward / referral
```

### KPI Targets (First 90 Days)

| Stage | Primary KPI | Target | Secondary KPI | Target |
|-------|-------------|--------|---------------|--------|
| Prospecting | CPA (Purchase) | <$45 | CTR | >1.5% |
| Prospecting | ROAS | >2.5x | CPM | <$15 |
| Retargeting | CPA (Purchase) | <$25 | ROAS | >5x |
| Retargeting | Frequency | <6 | CTR | >2.5% |
| Retention | CPA (Repeat Purchase) | <$20 | ROAS | >6x |

### Launch Checklist

- [ ] Pixel installed on all pages with standard events (ViewContent, AddToCart, InitiateCheckout, Purchase)
- [ ] CAPI configured via platform integration (Shopify, WooCommerce, etc.)
- [ ] AEM events prioritized: Purchase > InitiateCheckout > AddToCart > ViewContent > Lead > CompleteRegistration > Subscribe > PageView
- [ ] UTM parameters on all ads: `utm_source=facebook&utm_medium=paid&utm_campaign={campaign_name}&utm_content={ad_name}`
- [ ] Exclusion audiences created: Purchasers (180d), Website Visitors (30d)
- [ ] Creative assets ready: minimum 6 for prospecting, 3 for retargeting, 2 for retention
- [ ] Advantage+ Placements enabled (all placements, let Meta optimize)
- [ ] Attribution window: 7-day click, 1-day view (default)
- [ ] Domain verified in Business Settings
- [ ] GA4 configured as secondary attribution source

### Month 1-3 Roadmap

**Month 1**: Launch structure above. Focus on creative testing — identify winning concepts. Expect ROAS of 1.5-2.5x as pixel learns.

**Month 2**: Scale winning creative. Introduce 4-6 new ad variants based on Month 1 learnings. Pixel data matures — ROAS should improve to 2.5-3.5x. Consider Advantage+ Shopping test at 20% of prospecting budget.

**Month 3**: Full optimization. Kill underperformers, scale winners, test new audiences (LALs from purchaser data). Target ROAS of 3-4x. Evaluate budget increase if CPA targets are hit.

---

## Common Analysis Patterns

### Pattern: Performance Drop Diagnosis
```
1. Identify WHEN the drop started (weekly trend analysis)
2. Check WHAT changed: creative, audience, budget, attribution, external factors
3. Isolate WHERE: which campaigns/ad sets/ads declined vs. held
4. Determine WHY: fatigue, overlap, tracking, competition, seasonality
5. Recommend fixes prioritized by impact and effort
```

### Pattern: Creative Testing Audit
```
1. Inventory all active and recent ads by concept, format, and age
2. Plot CTR and CPA by ad age (days since launch)
3. Identify fatigue threshold (when metrics degrade)
4. Assess concept diversity vs. variation diversity
5. Recommend testing cadence, kill criteria, and concept pipeline
```

### Pattern: Tracking & Attribution Validation
```
1. Map all events: pixel-only, CAPI-only, both (deduplicated?)
2. Check EMQ scores per event
3. Verify AEM priority ranking matches business value
4. Compare Meta vs. GA4 numbers to quantify attribution gap
5. Build reconciliation framework for stakeholder reporting
```

### Pattern: Budget Reallocation
```
1. Rank campaigns/ad sets by marginal ROAS or CPA
2. Identify diminishing returns (spend vs. CPA curve)
3. Find underfunded high-performers and overfunded low-performers
4. Model reallocation scenarios with expected outcomes
5. Implement gradually (20% shifts per week, not overnight)
```

---

## Pro Tips

Instead of asking **"How are my Facebook ads doing?"** ask **"My prospecting CPA rose from $28 to $41 in the last 3 weeks — what should I investigate first?"** Specific metrics and timeframes yield actionable analysis.

Instead of asking **"Should I use broad targeting?"** ask **"We have 14 months of pixel data and 200+ purchases/month. Is our account mature enough for broad targeting to outperform our 1% Lookalikes?"** Context about data maturity changes the recommendation.

Instead of asking **"How do I fix my ROAS?"** ask **"ROAS is 2.1x on prospecting and 6.8x on retargeting, but retargeting frequency is at 9. Should I shift budget from retargeting to prospecting even though prospecting ROAS is lower?"** This reveals the real tradeoff between efficiency and scale.

Instead of asking **"Set up CAPI for me"** ask **"We're on Shopify Plus with a headless Hydrogen frontend. What's the best CAPI implementation path — platform integration, partner integration, or custom Gateway API?"** Platform details determine the right approach.

Instead of asking **"What's a good CTR?"** ask **"Our Feed CTR is 1.8% but Stories CTR is 0.6%. Is the Stories CTR concerning or is that expected given placement behavior differences?"** Benchmarks vary dramatically by placement, objective, and industry.

---

## 8. Scored Account Audit (Health Score)

**User Request:**
> "Score my Meta Ads account health and tell me what to fix first."

**Analysis Steps:**
1. Load `skills/shared/scoring-system.md` for scoring algorithm and `CHECKS.md` for the 46-check audit
2. Evaluate each applicable check as PASS, WARNING, or FAIL based on account data
3. Calculate category scores using severity multipliers and category weights
4. Identify Quick Wins (Critical/High severity, ≤15 min fix time)
5. Produce health score, grade, and prioritized action plan

**Sample Output:**

## Account Health Score: 71/100 (Grade C — Needs Improvement)

### Quick Wins (fix in ≤15 min, high impact)
1. **[Critical]** Deploy CAPI via Gateway — M-PX2 (15 min)
2. **[High]** Verify domain in Business Manager — M-PX5 (5 min)
3. **[High]** Set attribution to 7-day click / 1-day view — M-PX9 (2 min)
4. **[High]** Exclude purchasers from prospecting — M-AU5 (10 min)
5. **[Critical]** Add video/carousel formats — M-CR1 (15 min)

### Category Breakdown

| Category | Weight | Score | Grade | Top Issue |
|----------|--------|-------|-------|-----------|
| Pixel / CAPI Health | 30% | 55 | D | No CAPI active, EMQ at 5.8 |
| Creative Diversity & Fatigue | 30% | 74 | C | Only static images, no video |
| Account Structure | 20% | 82 | B | 2 ad sets in Learning Limited |
| Audience & Targeting | 20% | 78 | B | No purchaser exclusions |

### Prioritized Action Plan

**Immediate (This Week)**
1. Deploy CAPI via Gateway and verify event deduplication
2. Verify domain in Business Manager
3. Set 7-day click / 1-day view attribution on all campaigns
4. Create purchaser Custom Audience and exclude from prospecting

**This Month**
5. Produce video creatives in 9:16 vertical for Reels/Stories
6. Add UGC content to creative mix (target ≥30%)
7. Test Advantage+ Audience vs manual targeting
8. Upload and refresh Customer Match list

**Next Quarter**
9. Test Advantage+ Shopping Campaign with product catalog
10. Build A/B testing cadence using Meta Experiments
