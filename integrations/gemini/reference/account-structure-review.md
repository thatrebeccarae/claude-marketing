# account-structure-review


# Account Structure Review — Google + Meta

Expert-level guidance for evaluating paid media account structure against goals, budget, and conversion volume thresholds. Identifies structural anti-patterns that fragment data, starve budgets, or block algorithms from learning.

## Core Capabilities

### Structural Anti-Pattern Detection
- **Over-segmentation**: Too many campaigns/ad sets splitting data and budget below learning thresholds
- **Under-segmentation**: Everything in one campaign, can't isolate performance by intent or funnel stage
- **Budget fragmentation**: Daily budgets too low to exit learning phase or sustain delivery
- **Targeting overlap**: Multiple campaigns competing in same auctions, bidding against yourself
- **Objective mismatch**: Using Traffic when you need Conversions, mixing lead gen and ecommerce goals in one campaign

### Google-Specific Structure Auditing
- Campaign type separation (Search ≠ Display ≠ Shopping ≠ PMax)
- Ad group theme coherence (SKAGs are dead, STAGs with 5-15 keywords)
- Match type strategy alignment per campaign intent
- PMax cannibalizing branded Search
- Shared budgets causing cross-campaign interference
- Search Partners eating budget without conversions
- Automated bid strategies applied to low-volume campaigns

### Meta-Specific Structure Auditing
- CBO vs ABO alignment with goals and budget levels
- Advantage+ Shopping adoption readiness
- Prospecting vs retargeting separation
- Funnel exclusions (retargeting excludes purchasers, prospecting excludes retargeting audiences)
- Advantage+ Audience stability (broad targeting with signal-based constraints)
- Campaign duplication testing without isolation
- Multiple ad sets in prospecting CBO campaigns (common waste vector)

### Consolidation Decision Framework
- How to merge campaigns without losing historical data
- Campaign experiments for migration testing (Google) or 50/50 A/B tests (Meta)
- Incremental changes vs wholesale restructure
- Sequencing: What to consolidate first, what to defer

## Structure Health Criteria

### Google Ads: Minimum Conversion Volume Thresholds

| Bid Strategy | Minimum Monthly Conversions | Ideal Monthly Conversions | Warning Signs |
|--------------|----------------------------|--------------------------|---------------|
| Manual CPC | N/A (no learning required) | N/A | Using manual in 2026 means you're leaving performance on the table |
| Maximize Clicks | 0 (but why?) | N/A | You have conversion tracking — use it |
| Maximize Conversions | 15/month | 30+/month | <15/month = erratic, algorithm thrashing |
| Target CPA | 30/month | 50+/month | <30/month = CPA target won't be hit reliably |
| Target ROAS | 50/month | 100+/month | <50/month = ROAS variance too high, poor signal |

**Learning Phase**: Campaigns need ~50 conversions in 30 days to exit learning. Campaigns with <30 conversions/month perpetually re-enter learning with every creative refresh or bid change.

### Meta: Ad Set-Level Conversion Volume Thresholds

| Optimization Goal | Minimum Weekly Conversions | Ideal Weekly Conversions | Warning Signs |
|-------------------|----------------------------|--------------------------|---------------|
| Landing Page Views | N/A (top funnel) | N/A | Using this when you have purchase tracking = waste |
| Link Clicks | N/A (top funnel) | N/A | Same as above |
| Leads (Lead Gen) | 10/week per ad set | 20+/week | <10/week = unstable CPL |
| Add to Cart | 15/week per ad set | 30+/week | <15/week = algorithm can't optimize reliably |
| Initiate Checkout | 20/week per ad set | 40+/week | <20/week = CPA variance too high |
| Purchase | 50/week per ad set | 100+/week | <50/week = learning limited, poor delivery |
| Purchase (Advantage+) | 50/week per campaign | 150+/week | Advantage+ needs high volume, consolidate aggressively |

**Learning Phase**: Ad sets need ~50 conversions/week to exit learning. Ad sets with <50/week perpetually re-enter learning with every edit.

### Budget Fragmentation Thresholds

| Platform | Minimum Daily Budget | Ideal Daily Budget | Why |
|----------|---------------------|-------------------|-----|
| Google Search (tCPA) | $150/day | $300+/day | 10x target CPA minimum for stable delivery |
| Google PMax | $100/day | $300+/day | PMax needs volume to test assets across channels |
| Google Display | $50/day | $100+/day | Lower conversion rate = need more spend to gather signal |
| Meta CBO (Conversions) | $100/day | $300+/day | CBO needs budget to test ad sets before allocating |
| Meta ABO (Conversions) | $20/day per ad set | $50+/day per ad set | Ad sets under $20/day starve before learning completes |
| Meta Advantage+ | $200/day | $500+/day | Consolidated campaigns need higher budgets to sustain delivery |

**Critical Rule**: If your campaign can't sustain the minimum daily budget for 30 consecutive days without pausing, your account is over-segmented.

### Targeting Overlap Indicators (Meta)

| Overlap % | Status | Action Required |
|-----------|--------|-----------------|
| 0-10% | Healthy | No action |
| 11-25% | Moderate | Monitor, consider consolidation if both ad sets underperform |
| 26-50% | High | Consolidate or add exclusions immediately |
| 51%+ | Critical | You're bidding against yourself, merge now |

Check overlap in Meta Ads Manager > Tools > Audience Overlap. Run this monthly for all active prospecting campaigns.

### Google: Keyword Overlap Indicators

| Scenario | Status | Action Required |
|----------|--------|-----------------|
| Same keyword, different match types, same campaign | Healthy | This is fine, broad/phrase/exact in same ad group is valid |
| Same keyword, same match type, different campaigns | High Risk | Unless separated by geo/device/schedule, you're competing with yourself |
| Broad keyword in Campaign A matching exact keyword in Campaign B | Critical | Broad will steal traffic from exact unless you add exact as negative in Campaign A |
| PMax active + Brand Search campaign | Critical | PMax WILL cannibalize branded search. Add brand terms as negatives in PMax or pause PMax. |

Run Search Terms Report monthly and cross-reference against all campaigns to find cannibalization.

## Platform-Specific Structure Best Practices

### Google Ads: Campaign Hierarchy

**Search Campaigns** (Hierarchy: Campaign > Ad Group > Keywords > Ads)
- **One theme per campaign**: Brand, Competitor, Category, Product Line, Intent Stage
- **Ad groups**: 5-15 keywords per ad group, tightly themed (STAGs, not SKAGs)
- **Match types**: Use Phrase and Broad in most campaigns. Exact only for ultra-high-intent/high-value terms.
- **Negatives**: Aggressive negative keyword lists at campaign level to prevent overlap
- **Structure example**:
  - Campaign: Brand Search
    - Ad Group: Brand Exact (5 exact match brand terms)
    - Ad Group: Brand Misspellings (10 phrase match variants)
  - Campaign: Category - Running Shoes
    - Ad Group: Trail Running (8 phrase match keywords)
    - Ad Group: Road Running (10 phrase match keywords)
    - Ad Group: Racing Flats (5 phrase match keywords)

**Shopping Campaigns**
- Standard Shopping: One campaign per product category OR one campaign with ad groups by product type
- PMax: One campaign for entire catalog OR separate campaigns by margin/goal (e.g., high-margin PMax vs volume PMax)
- **Do NOT run PMax + Standard Shopping simultaneously** — PMax will dominate, Standard Shopping becomes a reporting shell

**Performance Max (PMax)**
- **When to use**: E-commerce with feed, lead gen with dynamic assets, omnichannel goals
- **Structure**: 1-3 campaigns max. PMax is designed to consolidate. Multiple PMax campaigns only if goals differ (ROAS target, audience strategy, geo)
- **Asset groups**: 3-5 per campaign, themed by product category or customer segment
- **Critical negative keywords**: Add brand terms if you want branded search to stay in Search campaigns

**Display Campaigns**
- Separate campaigns by goal: Prospecting vs Retargeting
- Prospecting: Use Responsive Display Ads (RDA) with demographic/interest targeting or Custom Audiences
- Retargeting: Website visitors, cart abandoners, customer lists. Lower bids, higher ROAS targets.

### Meta: Campaign Hierarchy

**Campaign** (Objective + Budget type)
- Choose objective: Awareness, Traffic, Engagement, Leads, App Promotion, Sales
- Choose budget: Campaign Budget Optimization (CBO) or Ad Set Budget Optimization (ABO)

**Ad Set** (Audience + Placement + Optimization)
- Define audience (Advantage+ Audience, Custom Audiences, Lookalikes)
- Choose placement (Advantage+ Placements or manual)
- Set optimization event (Purchase, Add to Cart, Lead, etc.)
- Set bid strategy (Lowest Cost, Cost Cap, Bid Cap)

**Ad** (Creative)
- Image, video, carousel, collection
- Primary text, headline, description, CTA

**CBO vs ABO Decision Tree**:
- **Use CBO when**:
  - Budget >$300/day
  - Testing multiple audiences against each other
  - Want Meta to auto-allocate budget to best performers
  - Have 2-5 ad sets per campaign
- **Use ABO when**:
  - Budget <$300/day
  - Need strict budget control per ad set (e.g., prospecting gets $100, retargeting gets $50)
  - Testing one audience or creative set in isolation
  - Running Advantage+ (CBO is required)

**Advantage+ Shopping Campaigns**
- Consolidates prospecting + retargeting into one campaign with one ad set
- Requires Conversions API (CAPI) + pixel
- Needs 50+ purchases/week to perform (ideally 150+/week)
- Best for brands spending $10K+/month on Meta with mature pixel
- **When NOT to use**: New pixels (<1000 events), low conversion volume, need granular audience control

**Prospecting vs Retargeting Separation**
- **Always separate** prospecting and retargeting into different campaigns
- **Prospecting**: Broad targeting (Advantage+ Audience with interest/demo signals), lookalikes, cold traffic
- **Retargeting**: Website visitors (180d), cart abandoners (30d), video viewers (30d), engaged users
- **Critical exclusions**:
  - Prospecting: Exclude website visitors 180d, customer lists
  - Retargeting: Exclude purchasers (unless running replenishment/upsell)

## Consolidation Decision Framework

### Step 1: Conversion Volume Audit
Pull last 30 days of data. For each campaign/ad set:
1. Count conversions
2. Compare to minimum threshold (see tables above)
3. Flag campaigns/ad sets below threshold as "Under-Volume"

### Step 2: Budget Fragmentation Audit
For each campaign:
1. Calculate average daily spend
2. Compare to minimum daily budget threshold
3. Flag campaigns below threshold as "Under-Budget"
4. Check: Does campaign run out of budget before end of day? If yes, flag "Budget-Constrained"

### Step 3: Targeting Overlap Audit
**Google**:
1. Run Search Terms Report for all Search campaigns
2. Cross-reference search terms against all other campaigns' keyword lists
3. Flag any search term appearing in 2+ campaigns

**Meta**:
1. Go to Ads Manager > Tools > Audience Overlap
2. Compare all active prospecting audiences
3. Flag any overlap >25%

### Step 4: Objective Mismatch Audit
For each campaign:
1. Check objective (Google: bid strategy; Meta: campaign objective)
2. Check conversion tracking setup
3. Flag mismatches:
   - Google: Manual CPC or Maximize Clicks when conversions are tracked
   - Meta: Traffic or Engagement objective when Purchase pixel fires
   - Mixing lead gen (form fills) and ecommerce (purchases) in same campaign

### Step 5: Consolidation Plan
For each flagged campaign, decide:
- **Merge**: Combine with similar campaign (same intent, same goal, compatible targeting)
- **Pause**: Discontinue if redundant or no clear goal
- **Restructure**: Keep separate but change targeting/budget/objective
- **Defer**: Flag for later (e.g., seasonal campaigns, test campaigns)

**Merge Rules**:
- **Google Search**: Merge campaigns with similar keyword themes and match types into one campaign with multiple ad groups
- **Google PMax**: Consolidate multiple PMax campaigns into one unless goals differ by >20% (e.g., tROAS of 300% vs 500%)
- **Meta Prospecting**: Merge lookalike audiences into one Advantage+ Audience campaign with signals
- **Meta Retargeting**: Merge retargeting ad sets into one campaign with CBO, separate ad sets by funnel stage (website visitors, cart abandoners, etc.)

### Step 6: Migration Plan
**Option A: Campaign Experiments (Google)**
1. Create experiment in original campaign
2. Build new consolidated structure in experiment arm
3. Split traffic 50/50 for 14-30 days
4. Compare performance, roll out winner

**Option B: Gradual Migration**
1. Launch new consolidated campaigns at 25% of total budget
2. Run for 7 days, compare performance
3. Increase to 50%, decrease old campaigns to 50%
4. Run for 7 days, compare again
5. If new campaigns outperform, shift 100% budget and pause old campaigns

**Option C: Immediate Cutover** (risky, only for emergencies)
1. Launch new campaigns
2. Pause old campaigns same day
3. Expect 7-14 day learning phase, performance dip

**Historical Data Preservation**:
- Do NOT delete old campaigns — pause them
- Export historical data to spreadsheet/dashboard before pausing
- Keep old campaigns paused for 90 days for reference, then archive

## Minimum Viable Structure by Budget Level

### $5K/month ($167/day)
**Google**:
- 2-4 campaigns max: Brand Search ($50/day), Category Search ($70/day), Display Retargeting ($30/day), Shopping or PMax ($17/day)
- Do NOT run PMax + Shopping simultaneously at this budget

**Meta**:
- 2 campaigns: Prospecting CBO ($100/day, 2 ad sets), Retargeting ABO ($67/day, 2 ad sets)
- If running Advantage+, go all-in: 1 Advantage+ campaign ($167/day)

### $20K/month ($667/day)
**Google**:
- 5-8 campaigns: Brand Search ($100/day), Competitor Search ($100/day), Category Search ($150/day), PMax ($200/day), Display Retargeting ($50/day), Display Prospecting ($67/day)
- Or: Consolidate into PMax ($400/day) + Brand Search ($100/day) + Display Retargeting ($167/day)

**Meta**:
- 3-4 campaigns: Prospecting CBO ($400/day, 3-5 ad sets), Retargeting CBO ($150/day, 3 ad sets), Testing Campaign ($117/day, 2 ad sets)
- Or: Advantage+ Shopping ($500/day) + Retargeting ($167/day)

### $100K/month ($3,333/day)
**Google**:
- 10-15 campaigns: Brand Search, Competitor Search, 3-5 Category Search campaigns, PMax, Display Prospecting (demographics), Display Prospecting (interests), Display Retargeting, YouTube Prospecting, YouTube Retargeting, Discovery
- Budget allocation: 40% PMax, 20% Search (Brand/Competitor/Category), 20% Display, 20% YouTube/Discovery

**Meta**:
- 6-10 campaigns: Advantage+ Shopping, Prospecting Lookalikes, Prospecting Interests, Prospecting Broad, Retargeting (Website), Retargeting (Engaged), Creative Testing, Offer Testing, New Market Testing
- Budget allocation: 50% Advantage+, 20% Prospecting (other), 15% Retargeting, 15% Testing

### $500K/month ($16,667/day)
**Google**:
- 15-25 campaigns: Separate by geo (US, CA, UK, etc.), product line, margin tier, funnel stage, device (if performance warrants), dayparting (if 24/7 doesn't work)
- Heavy investment in PMax ($8K/day), Brand ($2K/day), Category Search ($4K/day), YouTube ($2K/day)

**Meta**:
- 10-20 campaigns: Multiple Advantage+ campaigns by geo or product line, separate prospecting campaigns by demo or interest cluster, retargeting by funnel stage and recency, heavy creative testing budget
- Budget allocation: 60% Advantage+, 15% Prospecting, 10% Retargeting, 15% Testing

**Key principle**: Structure complexity should scale with budget and conversion volume, not with number of products or "just because."

## Output Format Template

When conducting an account structure review, provide output in this format:

```
# Account Structure Review — [Client Name] — [Date]

## Executive Summary
- Total monthly spend: $X
- Total campaigns: X (Google: X, Meta: X)
- Campaigns flagged: X (X% of total)
- Primary issues: [List top 3]
- Recommended consolidation: X campaigns → X campaigns
- Expected impact: [Estimated improvement in CPA, ROAS, or learning phase stability]

## Structural Health Score: X/100
- Conversion volume: X/30 (campaigns meeting minimum thresholds)
- Budget allocation: X/25 (campaigns with sufficient daily budgets)
- Targeting efficiency: X/25 (overlap score)
- Objective alignment: X/20 (campaigns using correct objectives for goals)

## Google Ads Findings

### Campaign Inventory
[Table: Campaign Name | Type | Daily Budget | Monthly Conversions | Status | Flag]

### Issues Identified
1. **[Issue Category]** (e.g., Over-Segmentation, Budget Fragmentation)
   - **Finding**: [Specific data point]
   - **Impact**: [Why this matters]
   - **Recommendation**: [What to do]

### Google Consolidation Plan
- Merge: [Campaign A + Campaign B] → [New Campaign Name]
- Pause: [Campaign C] (reason: redundant with PMax)
- Restructure: [Campaign D] (change from Maximize Clicks to tCPA)

## Meta Findings

### Campaign Inventory
[Table: Campaign Name | Objective | Budget Type | Daily Budget | Weekly Conversions | Status | Flag]

### Issues Identified
1. **[Issue Category]**
   - **Finding**: [Specific data point]
   - **Impact**: [Why this matters]
   - **Recommendation**: [What to do]

### Meta Consolidation Plan
- Merge: [Ad Set A + Ad Set B] → [New Campaign Name] (CBO)
- Migrate to Advantage+: [Campaign E] (conversion volume meets threshold)
- Pause: [Campaign F] (overlap with retargeting campaign)

## Migration Roadmap

### Phase 1 (Week 1-2): [Immediate Actions]
- Launch: [New Campaign X] at $X/day
- Reduce: [Old Campaign Y] to $X/day (from $X/day)
- Pause: [Campaign Z] (no conversions in 60 days)

### Phase 2 (Week 3-4): [Performance Validation]
- Monitor: [Campaigns] for learning phase completion
- Compare: [Old vs New] performance
- Decision: Roll out 100% or revert

### Phase 3 (Week 5-6): [Full Migration]
- Shift: 100% budget to new structure
- Pause: All old campaigns
- Archive: Export historical data

## Expected Outcomes
- **Learning phase stability**: [X campaigns] will exit learning phase with consolidated volume
- **Budget efficiency**: [X campaigns] will sustain delivery throughout day instead of exhausting budget early
- **Reporting clarity**: [Benefit of cleaner structure]
- **Algorithmic performance**: Expect CPA to improve [X%] as algorithms get more signal

## Risks & Mitigations
- **Risk**: Performance dip during learning phase
  - **Mitigation**: Gradual migration, keep 50% budget in proven campaigns during transition
- **Risk**: Loss of granular reporting
  - **Mitigation**: Use labels, UTM parameters, or asset groups (PMax) to maintain visibility

## Next Steps
1. [Action 1]
2. [Action 2]
3. [Action 3]
```

## Worked Example

**Scenario**: Mid-market DTC brand, $30K/month spend, Google + Meta

**Google Ads Audit**:
- 28 Search campaigns (Brand, Category, Product, Competitor)
- 22 campaigns have <20 conversions/month (below tCPA threshold)
- 15 campaigns have daily budgets <$20 (exhaust by 10am)
- PMax campaign active + Standard Shopping campaign active (PMax dominating, Standard Shopping getting <5% of budget)
- Shared budget across 8 campaigns causing unpredictable allocation

**Findings**:
1. **Over-Segmentation (Search)**: 28 campaigns should be 6-8 campaigns grouped by intent
2. **Budget Fragmentation**: 15 campaigns can't sustain delivery
3. **PMax Cannibalization**: Standard Shopping is redundant
4. **Shared Budget Chaos**: 8 campaigns competing for shared budget instead of predictable allocation

**Consolidation Plan**:
- **Merge Search campaigns**: 28 → 6 (Brand, Competitor, Category A, Category B, Category C, Generic)
- **Pause Standard Shopping**, increase PMax budget from $200/day to $400/day
- **Remove shared budgets**, assign fixed daily budgets to each campaign
- **Resulting structure**: 6 Search campaigns + 1 PMax + 1 Display Retargeting = 8 campaigns total

**Meta Audit**:
- 12 campaigns (10 prospecting, 2 retargeting)
- 10 prospecting campaigns have overlapping audiences (Lookalike 1%, Lookalike 2-3%, Interest: Fitness, Interest: Running, Broad, etc.)
- Audience overlap tool shows 35-60% overlap across all prospecting campaigns
- 6 campaigns have <30 purchases/week (below Conversions optimization threshold)
- Using ABO with $50/day per campaign

**Findings**:
1. **Targeting Overlap**: 10 prospecting campaigns bidding against each other
2. **Under-Volume**: 6 campaigns don't have enough conversions to optimize
3. **Budget Fragmentation**: $50/day per campaign is marginal for Conversions objective

**Consolidation Plan**:
- **Merge prospecting campaigns**: 10 → 2 (Advantage+ Shopping at $700/day, Lookalike Testing at $100/day)
- **Consolidate retargeting**: 2 campaigns → 1 CBO campaign with 3 ad sets (Website 7-30d, Cart Abandoners, Engaged Video Viewers) at $200/day
- **Resulting structure**: 3 campaigns total (Advantage+, Lookalike Testing, Retargeting)

**Expected Impact**:
- **Google**: Campaigns will have 40-60 conversions/month (vs 8-15 currently), tCPA will stabilize, learning phase will complete
- **Meta**: Advantage+ will have 120+ purchases/week (vs 20-30 per campaign currently), audience overlap eliminated, CBO will optimize budget allocation
- **Overall**: CPA expected to improve 15-25% within 30 days post-migration

## Guidelines

- **Never consolidate blindly**: Check conversion data, budget sustainability, and targeting logic before merging
- **Preserve historical data**: Pause, don't delete
- **Test migrations when possible**: Use experiments (Google) or gradual budget shifts (Meta)
- **Monitor learning phases**: Expect 7-14 days of instability after structural changes
- **Document everything**: Keep audit findings, consolidation plan, and migration steps in shared doc for team visibility
- **Revisit quarterly**: Account structure should evolve as budget, conversion volume, and goals change

## How to Use This Skill

Ask questions like:
- "Audit my Google Ads account structure and identify consolidation opportunities"
- "My Meta campaigns have low conversion volume — should I consolidate?"
- "I'm inheriting a messy account with 40+ campaigns — where do I start?"
- "What's the right campaign structure for a $50K/month budget on Google and Meta?"
- "My campaigns keep re-entering learning phase — is my structure the problem?"
- "Should I migrate to Advantage+ Shopping or keep my current prospecting setup?"
- "Create a consolidation plan for my Search campaigns — they're all under $30/day budget"

## Safety & Data Handling

- **Analysis only** — this skill produces recommendations, not live changes. Always review before implementing in any ad platform.
- **No PII** — do not paste customer emails, phone numbers, names, or order-level data. Use aggregated/anonymized exports only.
- **Projections are estimates** — financial forecasts are based on historical data and carry uncertainty. Label them as projections in client deliverables.
- **Confirm before acting** — never pause, delete, or modify live campaigns based solely on this analysis without human review.

---

# Account Structure Review — Reference Data

Quantitative thresholds and frameworks for evaluating paid media account structure on Google Ads and Meta Ads. All numbers reflect current platform behavior and algorithmic requirements.

---

## Conversion Volume Thresholds

### Google Ads — Campaign-Level Minimums by Bid Strategy

| Bid Strategy | Min Monthly Conversions | Ideal | Warning Signs |
|---|---|---|---|
| Manual CPC | N/A (no learning required) | N/A | Using manual CPC in 2026 means you're leaving performance on the table. Migrate to automated bidding. |
| Maximize Clicks | 0 (no conversion optimization) | N/A | If conversion tracking is active, you should be using a conversion-based strategy instead. |
| Maximize Conversions | 15/month | 30+/month | <15/month = erratic delivery, algorithm thrashing between exploration and exploitation. |
| Target CPA | 30/month | 50+/month | <30/month = CPA target won't be hit reliably. Algorithm needs consistent conversion signal. |
| Target ROAS | 50/month | 100+/month | <50/month = ROAS variance too high, algorithm can't predict revenue accurately. |

**Learning phase details**: Google campaigns need approximately 50 conversions within 30 days to fully exit learning. Campaigns with fewer than 30 conversions/month perpetually re-enter learning after any change — bid adjustments, creative refreshes, audience modifications, or budget changes all reset the clock. A campaign stuck in learning sees 20-40% higher CPAs than one that has exited.

### Meta Ads — Ad Set-Level Minimums by Optimization Goal

| Optimization Goal | Min Weekly Conversions | Ideal | Warning Signs |
|---|---|---|---|
| Landing Page Views | N/A (top funnel) | N/A | Using LPV optimization when purchase tracking is active wastes budget on low-intent traffic. |
| Link Clicks | N/A (top funnel) | N/A | Same as above — optimize for the event closest to revenue. |
| Leads | 10/week per ad set | 20+/week | <10/week = CPL fluctuates wildly, algorithm can't predict who will convert. |
| Add to Cart | 15/week per ad set | 30+/week | <15/week = insufficient signal for reliable optimization. ATC is a weaker signal than purchase. |
| Initiate Checkout | 20/week per ad set | 40+/week | <20/week = CPA variance makes planning impossible. Consider optimizing for ATC instead. |
| Purchase | 50/week per ad set | 100+/week | <50/week = learning limited status, poor delivery, erratic CPAs. |
| Purchase (Advantage+) | 50/week per campaign | 150+/week | Advantage+ needs high volume to test across its full creative/audience space. Below 50/week, it underperforms standard campaigns. |

**Learning phase details**: Meta ad sets need approximately 50 optimization events within 7 days to exit learning. Once in learning limited, the ad set may never recover — it's often better to kill it and launch fresh. Every edit to an ad set (budget >20% change, audience change, creative swap, optimization event change) resets the learning phase counter. Stacking 3-4 ads per ad set can help hit thresholds faster.

---

## Budget Fragmentation Thresholds

| Platform / Campaign Type | Min Daily Budget | Ideal | Why |
|---|---|---|---|
| Google Search (tCPA) | $150/day | $300+/day | Rule of thumb: 10x your target CPA as daily budget minimum. At $15 tCPA, $150/day gives enough headroom for 10 conversions/day, preventing budget exhaustion before noon. |
| Google PMax | $100/day | $300+/day | PMax distributes across Search, Shopping, Display, YouTube, Discover, Gmail. Below $100/day it can't test enough asset/channel combinations. |
| Google Display | $50/day | $100+/day | Display has lower conversion rates (0.5-1.5%). Need more impressions and spend to gather enough signal for optimization. |
| Meta CBO (Conversions) | $100/day | $300+/day | CBO needs enough budget to test across 2-5 ad sets before concentrating spend. Below $100/day, it starves lower-performing ad sets before they complete learning. |
| Meta ABO (Conversions) | $20/day per ad set | $50+/day per ad set | Individual ad sets below $20/day can't accumulate enough events to exit learning in 7 days, especially for purchase optimization. |
| Meta Advantage+ | $200/day | $500+/day | Advantage+ consolidates prospecting + retargeting into one campaign. It needs higher budgets to cover both audiences and test creative combinations. |

**Critical rule**: If a campaign can't sustain its minimum daily budget for 30 consecutive days without being paused, lowered, or shared — your account is over-segmented. Consolidate or increase total budget.

---

## Targeting Overlap Reference

### Meta — Audience Overlap Thresholds

| Overlap % | Status | Action |
|---|---|---|
| 0-10% | Healthy | No action needed. Audiences are sufficiently differentiated. |
| 11-25% | Moderate | Monitor weekly. If both ad sets are performing, leave alone. If one underperforms, consider merging into the stronger. |
| 26-50% | High | Consolidate immediately or add mutual exclusions. You're inflating your own CPMs by bidding against yourself in 26-50% of auctions. |
| 51%+ | Critical | These are effectively the same audience. Merge into one ad set immediately. Every dollar you spend in the overlap zone increases CPM for both ad sets. |

**How to check**: Meta Ads Manager > Tools > Audience Overlap. Select any two Custom Audiences and Meta shows the overlap percentage. Run this monthly for all active prospecting audiences.

**Common high-overlap pairs**:
- Lookalike 1% vs Lookalike 2-3% (typically 60-80% overlap)
- Interest: Fitness vs Interest: Running (typically 40-60% overlap)
- Lookalike 1% vs Broad/Advantage+ Audience (typically 50-70% overlap)

### Google — Keyword/Campaign Overlap Scenarios

| Scenario | Status | Action |
|---|---|---|
| Same keyword, different match types, same campaign | Healthy | Valid strategy. Broad/phrase/exact in the same ad group lets you control bids by match type while covering all query lengths. |
| Same keyword, same match type, different campaigns | High Risk | Unless campaigns are separated by geo, device, or schedule, you're competing with yourself in the auction. Google will enter both campaigns, inflating your CPC. |
| Broad keyword in Campaign A matching exact keyword in Campaign B | Critical | Broad will steal traffic from exact unless you add the exact term as a negative in Campaign A. Without negatives, traffic routes unpredictably. |
| PMax active + Brand Search campaign (no brand negatives in PMax) | Critical | PMax WILL cannibalize branded search. It prioritizes easy wins (branded queries) to hit its targets. Add brand terms as negatives in PMax, or accept that branded traffic shifts to PMax with less visibility/control. |
| PMax active + Standard Shopping campaign | High Risk | PMax takes priority in the Shopping auction. Standard Shopping becomes a reporting shell getting <5% of eligible impressions. Run one or the other, not both. |
| DSA campaign + Search campaign with overlapping landing pages | Moderate | DSA may match queries you're already targeting. Add your highest-performing exact keywords as negatives in DSA to prevent cannibalization. |

---

## Minimum Viable Structures by Budget Level

### Tier 1: $5K/month ($167/day)

**Google** (2-4 campaigns):
- Brand Search: $50/day (protect branded terms, typically lowest CPA)
- Category Search: $70/day (1-2 ad groups, 10-15 keywords, phrase + broad match)
- Display Retargeting: $30/day (website visitors 30d, cart abandoners 7d)
- Shopping OR PMax: $17/day (pick one — do NOT run both)

At this budget, PMax is marginal ($17/day is well below the $100 minimum). Standard Shopping with 1-2 product groups is more predictable. Skip Display Prospecting entirely.

**Meta** (2 campaigns):
- Prospecting CBO: $100/day (2 ad sets — Advantage+ Audience with interest signals, Lookalike 1-3%)
- Retargeting ABO: $67/day (2 ad sets — Website Visitors 180d, Engaged Users 30d)

Alternative: 1 Advantage+ Shopping campaign at $167/day if pixel has 1000+ purchase events and you're getting 50+ purchases/week. This consolidation is better for algorithmic learning but requires sufficient historical data.

### Tier 2: $20K/month ($667/day)

**Google** (5-8 campaigns):
- Brand Search: $100/day
- Competitor Search: $100/day
- Category Search: $150/day (3-5 ad groups by product category)
- PMax: $200/day (3-5 asset groups by product line)
- Display Retargeting: $50/day
- Display Prospecting: $67/day (Custom Audiences or in-market)

Consolidated alternative: PMax ($400/day) + Brand Search ($100/day) + Display Retargeting ($167/day) = 3 campaigns. Better for algorithmic learning if PMax is performing.

**Meta** (3-4 campaigns):
- Prospecting CBO: $400/day (3-5 ad sets — Advantage+ Audience, Lookalike 1%, Lookalike 3-5%, Interest-based)
- Retargeting CBO: $150/day (3 ad sets — Website 7-30d, Cart Abandoners 7d, Video Viewers 30d)
- Creative Testing: $117/day (2 ad sets, testing new creative before scaling)

Alternative: Advantage+ Shopping ($500/day) + Retargeting CBO ($167/day) = 2 campaigns. Requires 50+ purchases/week.

### Tier 3: $100K/month ($3,333/day)

**Google** (10-15 campaigns):
- Brand Search: $200/day
- Competitor Search: $200/day
- Category Search (3-5 campaigns by product line): $300/day each
- PMax: $800/day (5+ asset groups)
- Display Prospecting (demographics): $200/day
- Display Prospecting (interests/custom): $200/day
- Display Retargeting: $150/day
- YouTube Prospecting: $200/day
- YouTube Retargeting: $100/day
- Discovery/Demand Gen: $183/day

Budget allocation guideline: 40% PMax, 20% Search, 20% Display, 20% YouTube/Discovery.

**Meta** (6-10 campaigns):
- Advantage+ Shopping: $1,667/day
- Prospecting Lookalikes: $300/day
- Prospecting Interests: $200/day
- Prospecting Broad: $200/day
- Retargeting (Website): $200/day
- Retargeting (Engaged): $100/day
- Creative Testing: $300/day
- Offer/Promo Testing: $200/day
- New Market Testing: $166/day

Budget allocation guideline: 50% Advantage+, 20% Prospecting, 15% Retargeting, 15% Testing.

### Tier 4: $500K/month ($16,667/day)

**Google** (15-25 campaigns):
- Brand Search: $2,000/day
- Category Search (by product line, geo, or margin tier): $4,000/day total across 5-8 campaigns
- PMax (by geo or product line): $8,000/day total across 2-3 campaigns
- YouTube (prospecting + retargeting): $2,000/day
- Display/Discovery: $667/day

At this level, separate campaigns by geo (US, CA, UK), product line, or margin tier. Device-level separation only if performance data shows >30% CPA difference between mobile and desktop. Dayparting campaigns only if 24/7 delivery shows clear dead zones.

**Meta** (10-20 campaigns):
- Advantage+ (by geo or product line): $10,000/day across 3-5 campaigns
- Prospecting (by demo or interest cluster): $2,500/day across 3-5 campaigns
- Retargeting (by funnel stage and recency): $1,667/day across 3-4 campaigns
- Creative/Offer Testing: $2,500/day across 3-5 campaigns

Budget allocation guideline: 60% Advantage+, 15% Prospecting, 10% Retargeting, 15% Testing.

**Key principle**: Structure complexity scales with budget and conversion volume. A $500K account with 50 campaigns is fine. A $5K account with 50 campaigns is a disaster.

---

## Consolidation Decision Framework

### Step 1: Volume Audit
Pull the last 30 days of conversion data for every campaign and ad set.

1. For each Google campaign: count total conversions, compare to bid strategy minimums (see threshold table)
2. For each Meta ad set: count weekly conversions, compare to optimization goal minimums
3. Flag anything below minimum as **Under-Volume**
4. Calculate what percentage of campaigns are under-volume — if >50%, the account is structurally broken

### Step 2: Budget Audit
For each campaign:

1. Calculate average daily spend (not budget — actual spend)
2. Compare to minimum daily budget thresholds
3. Flag campaigns below minimum as **Under-Budget**
4. Check impression share (Google) or estimated daily reach (Meta) — if budget-limited IS share is >40%, flag as **Budget-Constrained**
5. Check if campaigns exhaust budget before 3 PM local time — if yes, delivery is front-loaded and algorithm can't optimize across the full day

### Step 3: Overlap Audit

**Google**:
1. Pull Search Terms Report for all Search campaigns (last 30 days)
2. Cross-reference search terms against keyword lists in all other campaigns
3. Flag any search term appearing in 2+ campaigns as cannibalization
4. Check PMax search terms (Insights tab) for branded query cannibalization
5. Quantify: what % of clicks are going to the "wrong" campaign?

**Meta**:
1. Run Audience Overlap tool for all active Custom Audiences
2. Document overlap % for every pair of prospecting audiences
3. Flag any pair with >25% overlap
4. Check if Advantage+ campaigns are overlapping with manual prospecting campaigns (they almost always are)

### Step 4: Objective Mismatch Audit
For each campaign:

1. Check the campaign objective (Google: bid strategy; Meta: campaign objective + optimization event)
2. Cross-reference with conversion tracking setup
3. Flag mismatches:
   - Google: Manual CPC or Maximize Clicks when conversion tracking is active
   - Google: Target ROAS on a campaign with <50 conversions/month
   - Meta: Traffic or Engagement objective when Purchase pixel is firing
   - Meta: Lead objective on an ecommerce account (unless explicitly running lead gen)
   - Mixed objectives: lead gen form fills and ecommerce purchases in the same campaign

### Step 5: Consolidation Plan
For each flagged campaign, assign one action:

- **Merge**: Combine with a similar campaign (same intent, same goal, compatible targeting). Preserve the campaign with more historical data as the surviving campaign.
- **Pause**: Discontinue if redundant, zero conversions in 60+ days, or no clear goal.
- **Restructure**: Keep separate but change bid strategy, budget, targeting, or objective to fix the specific issue.
- **Defer**: Flag for review next quarter (seasonal campaigns, test campaigns with defined end dates).

**Merge rules by platform**:
- Google Search: Merge campaigns with similar keyword themes into one campaign with multiple ad groups. Target: 5-15 keywords per ad group.
- Google PMax: Consolidate multiple PMax campaigns into one unless ROAS targets differ by >20%.
- Meta Prospecting: Merge overlapping audiences into one Advantage+ Audience campaign with interest/demo signals.
- Meta Retargeting: Merge retargeting ad sets into one CBO campaign with separate ad sets by funnel stage.

### Step 6: Migration Plan
Choose one of three approaches based on risk tolerance:

**Option A: Campaign Experiments (Google only)**
1. Create an experiment from the original campaign
2. Build the new consolidated structure in the experiment arm
3. Split traffic 50/50 for 14-30 days
4. Evaluate on primary KPI (CPA, ROAS) with statistical significance
5. Roll out the winner, archive the loser

Best for: High-spend campaigns where a 15-25% CPA swing has material business impact. Requires 100+ conversions in the test period for reliable results.

**Option B: Gradual Migration (Google + Meta)**
1. Launch new consolidated campaigns at 25% of total budget
2. Run for 7 days — compare CPA/ROAS to old campaigns
3. If within 15% of old performance: increase to 50%, decrease old to 50%
4. Run for 7 more days — compare again
5. If new campaigns match or outperform: shift 100%, pause old campaigns
6. Total migration time: 14-21 days

Best for: Mid-spend accounts where you need to maintain performance during transition. Most common approach.

**Option C: Immediate Cutover**
1. Launch new campaigns at full budget
2. Pause all old campaigns the same day
3. Accept 7-14 day learning phase with performance dip (expect 20-40% higher CPAs during learning)

Best for: Emergencies only — accounts that are actively wasting budget and every day of delay costs money. Or very low-spend accounts where the learning phase cost is negligible.

---

## Migration Best Practices

### Historical Data Preservation
- **Never delete old campaigns** — pause them. Deleted campaigns lose all historical data permanently.
- Export campaign-level data (impressions, clicks, conversions, cost, CPA, ROAS) to a spreadsheet before pausing.
- Keep paused campaigns for 90 days minimum as reference, then archive (move to a "z_Archive" label/folder).
- Document the mapping: "Old Campaign X merged into New Campaign Y on [date]" for future auditors.
- Google conversion history carries forward if you use the same conversion actions. Meta pixel history persists regardless of campaign structure.

### Learning Phase Expectations
- **Google**: 7-14 days for campaigns with sufficient volume. tCPA campaigns may see 30-50% CPA spikes in the first week. Do not make changes during learning — no bid adjustments, no budget changes, no keyword adds.
- **Meta**: 3-7 days per ad set with sufficient volume. During learning, delivery is unstable and costs are higher. Avoid making more than one edit per ad set per week.
- **Both platforms**: Performance typically normalizes by day 14-21. If still underperforming at day 30, the structure change may not be working — revert or iterate.

### Documentation Requirements
- **Audit findings**: Document every flagged campaign with the specific issue, supporting data, and recommended action.
- **Consolidation map**: Show which old campaigns map to which new campaigns (merge diagram).
- **Migration timeline**: Week-by-week plan with budget allocation percentages.
- **Success criteria**: Define what "working" looks like before migrating (e.g., "New campaigns must match old CPA within 15% by day 21").
- **Rollback plan**: Document how to revert if the new structure underperforms (typically: reactivate paused campaigns at original budgets).

---

## Health Score Methodology

The Structural Health Score is a 100-point scale evaluating four dimensions of account architecture.

### Conversion Volume (30 points)

Measures what percentage of campaigns/ad sets meet minimum conversion thresholds for their bid strategy or optimization goal.

| % of campaigns meeting thresholds | Score |
|---|---|
| 90-100% | 27-30 |
| 70-89% | 21-26 |
| 50-69% | 15-20 |
| 30-49% | 9-14 |
| 0-29% | 0-8 |

Scoring formula: `(campaigns meeting threshold / total campaigns) * 30`, rounded to nearest integer. Weight campaigns by spend — a $500/day campaign below threshold is worse than a $20/day campaign below threshold.

### Budget Allocation (25 points)

Measures whether campaigns have sufficient daily budgets for their objectives and whether budget distribution is rational.

| Criteria | Points |
|---|---|
| All campaigns above minimum daily budget thresholds | 0-10 |
| No campaigns exhausting budget before 3 PM | 0-5 |
| Budget distribution aligns with goals (highest-ROI campaigns get most budget) | 0-5 |
| No shared budgets causing cross-campaign interference (Google) | 0-5 |

Deduct 2 points per campaign below minimum. Deduct 3 points per shared budget portfolio. Deduct 1 point per campaign that exhausts budget before 3 PM.

### Targeting Efficiency (25 points)

Measures audience/keyword overlap and whether campaigns are competing against each other.

| Criteria | Points |
|---|---|
| No audience pairs with >25% overlap (Meta) | 0-10 |
| No keyword cannibalization across campaigns (Google) | 0-8 |
| Proper funnel exclusions in place (prospecting excludes retargeting audiences) | 0-4 |
| PMax brand term isolation (brand negatives applied) | 0-3 |

Deduct 2 points per audience pair with >25% overlap. Deduct 3 points per keyword appearing in 2+ campaigns without negatives. Deduct 4 points if prospecting campaigns don't exclude converters/retargeting audiences. Deduct 3 points if PMax is active without brand negatives.

### Objective Alignment (20 points)

Measures whether campaigns use the correct objectives, bid strategies, and optimization events for their goals.

| Criteria | Points |
|---|---|
| All campaigns use conversion-based objectives when conversion tracking is active | 0-8 |
| Bid strategies match conversion volume (no tROAS on <50 conversions/month) | 0-5 |
| No mixed objectives within campaigns (lead gen + ecommerce) | 0-4 |
| Conversion tracking is complete (all valuable actions tracked, correct attribution) | 0-3 |

Deduct 3 points per campaign using Traffic/Clicks objective when conversions are tracked. Deduct 4 points per campaign using tROAS or tCPA below volume minimums. Deduct 5 points for mixed lead gen + ecommerce in same campaign.

### Score Interpretation

| Score | Rating | Implication |
|---|---|---|
| 85-100 | Excellent | Minor optimizations only. Focus on creative and bidding, not structure. |
| 70-84 | Good | 1-3 structural issues to address. Schedule consolidation within 30 days. |
| 50-69 | Needs Work | Significant structural problems limiting performance. Prioritize restructure within 2 weeks. |
| 30-49 | Poor | Account structure is actively wasting budget. Immediate intervention required. |
| 0-29 | Critical | Fundamental rebuild needed. Pause underperforming campaigns immediately and start from scratch. |

---

## Audit Output Template

Use this template for all account structure review deliverables.

```markdown
# Account Structure Review — [Client Name] — [Date]

## Executive Summary
- **Total monthly spend**: $X
- **Total campaigns**: X (Google: X, Meta: X)
- **Campaigns flagged**: X (X% of total)
- **Primary issues**: [List top 3]
- **Recommended consolidation**: X campaigns → X campaigns
- **Expected impact**: [Estimated improvement in CPA, ROAS, or learning phase stability]

## Structural Health Score: X/100
- Conversion volume: X/30 (campaigns meeting minimum thresholds)
- Budget allocation: X/25 (campaigns with sufficient daily budgets)
- Targeting efficiency: X/25 (overlap score)
- Objective alignment: X/20 (campaigns using correct objectives for goals)

## Google Ads Findings

### Campaign Inventory
| Campaign Name | Type | Bid Strategy | Daily Budget | Monthly Conversions | Status | Flag |
|---|---|---|---|---|---|---|
| [Name] | Search/PMax/Display/Shopping | tCPA/tROAS/MaxConv | $X | X | Active/Paused | Under-Volume / Under-Budget / Overlap / OK |

### Issues Identified
1. **[Issue Category]** (Over-Segmentation / Budget Fragmentation / Keyword Overlap / Objective Mismatch)
   - **Finding**: [Specific data point — e.g., "22 of 28 Search campaigns have <20 conversions/month"]
   - **Impact**: [Why this matters — e.g., "Campaigns perpetually in learning phase, CPAs 35% above target"]
   - **Recommendation**: [What to do — e.g., "Merge 28 Search campaigns into 6 by intent theme"]

### Google Consolidation Plan
- **Merge**: [Campaign A] + [Campaign B] → [New Campaign Name] (rationale)
- **Pause**: [Campaign C] (reason: redundant with PMax / zero conversions 60d)
- **Restructure**: [Campaign D] (change: Maximize Clicks → tCPA, increase budget to $X/day)

## Meta Findings

### Campaign Inventory
| Campaign Name | Objective | Budget Type | Daily Budget | Weekly Conversions | Overlap % | Flag |
|---|---|---|---|---|---|---|
| [Name] | Sales/Leads/Traffic | CBO/ABO | $X | X | X% | Under-Volume / Overlap / OK |

### Issues Identified
1. **[Issue Category]**
   - **Finding**: [Specific data point]
   - **Impact**: [Why this matters]
   - **Recommendation**: [What to do]

### Meta Consolidation Plan
- **Merge**: [Ad Set A] + [Ad Set B] → [New Campaign Name] (CBO, $X/day)
- **Migrate to Advantage+**: [Campaign E] (conversion volume meets 50/week threshold)
- **Pause**: [Campaign F] (reason: 55% overlap with retargeting campaign)

## Migration Roadmap

### Phase 1 (Week 1-2): Immediate Actions
- **Launch**: [New Campaign X] at $X/day
- **Reduce**: [Old Campaign Y] from $X/day to $X/day
- **Pause**: [Campaign Z] (no conversions in 60 days)

### Phase 2 (Week 3-4): Performance Validation
- **Monitor**: [New campaigns] for learning phase completion
- **Compare**: New vs old campaign CPA/ROAS at 50% budget split
- **Decision**: Roll out 100% if new campaigns within 15% of old CPA, or revert

### Phase 3 (Week 5-6): Full Migration
- **Shift**: 100% budget to new structure
- **Pause**: All old campaigns (do NOT delete)
- **Archive**: Export historical data, document campaign mapping

## Expected Outcomes
- **Learning phase stability**: X campaigns will exit learning phase within 14 days with consolidated volume
- **Budget efficiency**: X campaigns will sustain full-day delivery instead of exhausting budget by early afternoon
- **Reporting clarity**: [Describe benefit — e.g., "8 campaigns vs 40 makes weekly reporting actionable"]
- **Algorithmic performance**: Expect CPA to improve X-X% within 30 days as algorithms receive stronger signal

## Risks & Mitigations
| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Performance dip during learning phase | High | Medium | Gradual migration — keep 50% budget in proven campaigns during 14-day transition |
| Loss of granular audience insights | Medium | Low | Use UTM parameters, labels (Google), or breakdown dimensions (Meta) to maintain visibility |
| Advantage+ underperforms manual campaigns | Low | High | Keep manual prospecting campaign at 20% budget as hedge for 30 days |

## Next Steps
1. [Action 1 — e.g., "Export last 90 days of campaign data for archive"]
2. [Action 2 — e.g., "Build new consolidated campaign shells in draft mode"]
3. [Action 3 — e.g., "Schedule migration start for Monday, monitor daily through Week 2"]
```
