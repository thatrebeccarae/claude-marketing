# Account Structure Review — Examples

Six realistic examples demonstrating how to use the account structure review skill across different scenarios, budgets, and platforms.

---

## Example 1: Mid-Market DTC Account Audit ($30K/mo)

### User Request

"I just inherited a DTC skincare account spending $30K/month across Google and Meta. The previous agency had 40+ campaigns running. Performance has been declining for 3 months — CPAs are up 35% and ROAS is down. Audit the structure and give me a consolidation plan."

### Analysis Steps

1. **Inventory all campaigns** — List every campaign across both platforms with type, objective, bid strategy, daily budget, and last-30-day conversions.
2. **Run conversion volume audit** — Compare each campaign's conversions against minimum thresholds for its bid strategy (Google) or optimization goal (Meta). Flag under-volume campaigns.
3. **Run budget fragmentation audit** — Check daily budgets against minimums. Identify campaigns exhausting budget before 3 PM.
4. **Run targeting overlap audit** — Pull Google Search Terms Report to find cross-campaign cannibalization. Run Meta Audience Overlap tool on all prospecting audiences.
5. **Build consolidation plan** — Group campaigns by merge candidates, pause candidates, and restructure candidates. Design migration roadmap.

### Sample Output

```markdown
# Account Structure Review — [Skincare DTC Brand] — 2026-03-11

## Executive Summary
- **Total monthly spend**: $30,000 ($15K Google, $15K Meta)
- **Total campaigns**: 42 (Google: 28, Meta: 14)
- **Campaigns flagged**: 34 (81% of total)
- **Primary issues**: (1) Severe over-segmentation on Google Search — 28 campaigns averaging $18/day each; (2) 10 Meta prospecting campaigns with 35-60% audience overlap; (3) PMax + Standard Shopping running simultaneously
- **Recommended consolidation**: 42 campaigns → 11 campaigns
- **Expected impact**: CPA reduction of 20-30% within 30 days as campaigns exit learning phase

## Structural Health Score: 28/100
- Conversion volume: 6/30 (only 8 of 42 campaigns meet minimum thresholds)
- Budget allocation: 5/25 (26 campaigns below minimum daily budget)
- Targeting efficiency: 8/25 (critical overlap on both platforms)
- Objective alignment: 9/20 (3 Google campaigns on Maximize Clicks with conversion tracking active)

## Google Ads Findings

### Campaign Inventory
| Campaign Name | Type | Bid Strategy | Daily Budget | Monthly Conv. | Flag |
|---|---|---|---|---|---|
| Brand - Exact | Search | tCPA | $40 | 85 | OK |
| Brand - Broad | Search | tCPA | $25 | 42 | OK |
| Category - Moisturizer | Search | tCPA | $18 | 12 | Under-Volume |
| Category - Serum | Search | tCPA | $18 | 8 | Under-Volume |
| Category - Cleanser | Search | tCPA | $15 | 6 | Under-Volume, Under-Budget |
| Category - SPF | Search | tCPA | $12 | 4 | Under-Volume, Under-Budget |
| Category - Toner | Search | tCPA | $10 | 2 | Under-Volume, Under-Budget |
| Product - Vitamin C Serum | Search | MaxClicks | $15 | 3 | Objective Mismatch |
| Product - Retinol Cream | Search | MaxClicks | $12 | 2 | Objective Mismatch |
| Product - HA Moisturizer | Search | MaxClicks | $10 | 1 | Objective Mismatch |
| ... (18 more product-level campaigns) | Search | Various | $5-15 | 0-3 | Under-Volume, Under-Budget |
| PMax - All Products | PMax | MaxConv | $80 | 35 | OK |
| Standard Shopping | Shopping | ManualCPC | $30 | 4 | Cannibalized by PMax |
| Display - Retargeting | Display | MaxConv | $25 | 8 | Under-Budget |

### Issues Identified
1. **Over-Segmentation (Search)** — 28 Search campaigns averaging $18/day and 8 conversions/month. 22 campaigns are below the 30/month minimum for tCPA optimization. Campaigns perpetually re-enter learning, driving CPAs up 35%.
   - **Impact**: Algorithm never stabilizes. Each bid change or ad rotation resets learning on campaigns that were never out of learning to begin with.
   - **Recommendation**: Merge 28 Search campaigns into 6: Brand, Competitor, Category (Skincare), Category (SPF/Sun), Generic (Skin Concerns), Product (Top 5 SKUs).

2. **Budget Fragmentation** — 15 campaigns have daily budgets under $20. These exhaust by 10 AM, missing afternoon and evening shoppers entirely.
   - **Impact**: Missing 60% of daily shopping window. Algorithm front-loads impressions into early morning when competition is highest.
   - **Recommendation**: Consolidation fixes this automatically — 6 campaigns at $60-100/day each.

3. **PMax Cannibalization** — Standard Shopping campaign getting <5% of eligible impressions. PMax is capturing all Shopping traffic. Standard Shopping generated 4 conversions vs PMax's 35.
   - **Impact**: $30/day ($900/month) wasted on a campaign that can't compete for impressions.
   - **Recommendation**: Pause Standard Shopping immediately. Increase PMax budget from $80/day to $120/day.

4. **Objective Mismatch** — 3 product-level campaigns using Maximize Clicks despite active conversion tracking.
   - **Impact**: Paying for clicks instead of optimizing for purchases. These campaigns have the worst CPA in the account ($85 vs $22 average).
   - **Recommendation**: Merge into consolidated Category campaigns with tCPA bidding.

### Google Consolidation Plan
- **Merge**: 28 Search campaigns → 6 campaigns (Brand $65/day, Competitor $50/day, Category Skincare $100/day, Category SPF $60/day, Generic $60/day, Product Top SKUs $45/day)
- **Pause**: Standard Shopping (cannibalized by PMax)
- **Restructure**: PMax — increase budget from $80/day to $120/day, add brand negatives
- **Resulting structure**: 6 Search + 1 PMax + 1 Display Retargeting = 8 campaigns

## Meta Findings

### Campaign Inventory
| Campaign Name | Objective | Budget Type | Daily Budget | Weekly Conv. | Overlap % | Flag |
|---|---|---|---|---|---|---|
| Prospecting - LAL 1% | Sales | ABO | $50 | 18 | 65% (w/ LAL 2-3%) | Overlap |
| Prospecting - LAL 2-3% | Sales | ABO | $50 | 12 | 65% (w/ LAL 1%) | Overlap, Under-Volume |
| Prospecting - Interest Skincare | Sales | ABO | $40 | 8 | 45% (w/ LAL 1%) | Overlap, Under-Volume |
| Prospecting - Interest Beauty | Sales | ABO | $35 | 6 | 52% (w/ Skincare) | Overlap, Under-Volume |
| Prospecting - Interest Anti-Aging | Sales | ABO | $30 | 4 | 38% (w/ Skincare) | Overlap, Under-Volume |
| Prospecting - Broad | Sales | ABO | $25 | 3 | N/A | Under-Volume, Under-Budget |
| Prospecting - LAL Purchasers | Sales | ABO | $30 | 5 | 70% (w/ LAL 1%) | Overlap, Under-Volume |
| Prospecting - LAL ATC | Sales | ABO | $25 | 3 | 55% (w/ LAL 1%) | Overlap, Under-Volume |
| Prospecting - LAL Email | Sales | ABO | $20 | 2 | 48% (w/ LAL 1%) | Overlap, Under-Volume |
| Prospecting - Cold Video | Sales | ABO | $15 | 1 | N/A | Under-Volume, Under-Budget |
| Retargeting - Website 30d | Sales | ABO | $80 | 25 | N/A | OK |
| Retargeting - Cart Abandon | Sales | ABO | $40 | 15 | N/A | OK |
| Retargeting - DPA | Sales | ABO | $30 | 10 | N/A | Under-Volume |
| Retargeting - Email List | Sales | ABO | $30 | 8 | N/A | Under-Volume |

### Issues Identified
1. **Targeting Overlap (Critical)** — 10 prospecting campaigns with 35-70% audience overlap. Lookalike 1% and Lookalike Purchasers have 70% overlap — effectively the same audience in two campaigns.
   - **Impact**: Bidding against yourself in 35-70% of auctions. Inflated CPMs, fragmented data, no campaign has enough volume to optimize.
   - **Recommendation**: Consolidate 10 prospecting campaigns into 1 Advantage+ Shopping campaign.

2. **Under-Volume** — 8 of 10 prospecting campaigns have <50 purchases/week. None can exit learning phase.
   - **Impact**: All 8 are in "learning limited" status. CPAs 40% above the 2 campaigns that have sufficient volume.
   - **Recommendation**: Consolidation into Advantage+ solves this — projected 60+ purchases/week from combined budget.

### Meta Consolidation Plan
- **Merge**: 10 prospecting campaigns → 1 Advantage+ Shopping campaign ($320/day)
- **Merge**: 4 retargeting campaigns → 1 Retargeting CBO campaign ($180/day, 3 ad sets: Website 7-30d, Cart Abandoners 7d, Engaged Users 30d)
- **Resulting structure**: 2 campaigns total (Advantage+, Retargeting CBO)

## Migration Roadmap

### Phase 1 (Week 1-2): Immediate Actions
- **Launch**: 6 consolidated Google Search campaigns at 25% budget ($95/day total)
- **Launch**: 1 Advantage+ Shopping campaign at $160/day (50% of prospecting budget)
- **Launch**: 1 Retargeting CBO campaign at $90/day (50% of retargeting budget)
- **Reduce**: Old Google Search campaigns to 75% budget
- **Reduce**: Old Meta prospecting campaigns to 50% budget
- **Pause**: Standard Shopping campaign immediately

### Phase 2 (Week 3-4): Performance Validation
- **Monitor**: New campaigns for learning phase completion (expect by day 10-14)
- **Compare**: New vs old CPA at 50/50 budget split
- **If new campaigns within 15% of old CPA**: Shift to 75% new / 25% old

### Phase 3 (Week 5-6): Full Migration
- **Shift**: 100% budget to new structure
- **Pause**: All old campaigns (do NOT delete)
- **Archive**: Export 12 months of historical data from old campaigns
- **Final structure**: 8 Google campaigns + 2 Meta campaigns = 10 total (down from 42)

## Expected Outcomes
- **Learning phase stability**: All 10 campaigns will have sufficient volume to exit and stay out of learning
- **Budget efficiency**: Every campaign will sustain full-day delivery with budgets above platform minimums
- **CPA improvement**: Projected 20-30% CPA reduction within 30 days
- **Reporting clarity**: 10 campaigns instead of 42 makes weekly performance reviews actionable

## Risks & Mitigations
| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Performance dip during learning phase | High | Medium | Gradual 50/50 migration over 4 weeks |
| Advantage+ underperforms manual prospecting | Low | High | Keep $50/day manual prospecting campaign as hedge for 30 days |
| Loss of audience-level insights | Medium | Low | Use Meta breakdown dimensions (age, gender, placement) for insights |
```

---

## Example 2: Startup Account Structure Design ($5K/mo)

### User Request

"We're launching paid media for a B2B SaaS startup. Budget is $5K/month total across Google and Meta. We need a structure that maximizes learning with minimal budget. What campaigns should we set up and how should we allocate budget?"

### Analysis Steps

1. **Determine platform split** — Assess whether Google or Meta (or both) is appropriate for B2B SaaS at $5K/month.
2. **Apply minimum viable structure** — Use the $5K/month tier guidelines, adjusted for B2B SaaS (leads, not purchases).
3. **Calculate conversion volume feasibility** — At $5K/month, estimate CPL and check if campaigns can hit minimum thresholds.
4. **Design campaign architecture** — Specify campaigns, ad groups/ad sets, targeting, and budget allocation.

### Sample Output

```markdown
# Account Structure Design — [B2B SaaS Startup] — 2026-03-11

## Executive Summary
- **Total monthly budget**: $5,000 ($3,000 Google, $2,000 Meta)
- **Recommended structure**: 5 campaigns total (Google: 3, Meta: 2)
- **Primary constraint**: At $167/day total, every campaign must justify its existence. Zero room for experimentation campaigns or audience testing — that comes at $10K+/month.
- **Expected monthly leads**: 50-80 (assuming $65-100 CPL for B2B SaaS)

## Structural Health Score: N/A (new account — baseline)

## Google Ads Structure ($3,000/month, $100/day)

### Recommended Campaigns
| Campaign | Type | Bid Strategy | Daily Budget | Expected Monthly Conv. | Rationale |
|---|---|---|---|---|---|
| Brand Search | Search | Maximize Conversions | $20/day | 15-20 | Protect branded terms, lowest CPL. Even at launch, competitors may bid on your brand. |
| Category Search | Search | Maximize Conversions | $60/day | 20-30 | Core demand capture. 2-3 ad groups by problem/solution theme, 8-12 keywords each, phrase + broad match. |
| Display Retargeting | Display | Maximize Conversions | $20/day | 5-10 | Website visitors only. Don't run Display Prospecting at this budget — CPLs are too high. |

### Why NOT PMax at $5K/month
PMax minimum viable budget is $100/day. At $20/day (what's left after Search and Retargeting), PMax can't test across its 6 channels. It will default to Display and Gmail — the lowest-quality placements. Use Search for demand capture, skip PMax until budget hits $10K+/month.

### Why NOT Competitor Search
At $5K/month, Competitor Search CPCs ($15-30 for B2B SaaS) will consume budget without enough volume to optimize. Defer until budget doubles.

## Meta Ads Structure ($2,000/month, $67/day)

### Recommended Campaigns
| Campaign | Objective | Budget Type | Daily Budget | Expected Weekly Conv. | Rationale |
|---|---|---|---|---|---|
| Prospecting | Leads | CBO | $47/day | 5-8 | 2 ad sets: Advantage+ Audience with job title signals, Lookalike 1% of email list. Lead form or landing page. |
| Retargeting | Leads | ABO | $20/day | 3-5 | 1 ad set: Website visitors 180d + LinkedIn profile visitors (if using CAPI partner). |

### Critical Constraints
- At $47/day CBO with Leads optimization, you need 10+ leads/week per ad set to exit learning. If you're getting 5-8 across 2 ad sets, one will starve. Start with 1 ad set and add the second when you hit 15+ leads/week.
- Do NOT optimize for Purchase or ATC — you're B2B SaaS, optimize for Lead (form fill, demo request, or trial signup).
- Advantage+ Shopping is not appropriate for B2B lead gen.

## Migration Roadmap

### Week 1-2: Launch
- Launch Brand Search + Category Search on Google
- Launch Prospecting (1 ad set only) + Retargeting on Meta
- Install conversion tracking: Google Ads tag + Meta pixel + CAPI for lead events

### Week 3-4: Optimize
- Review Search Terms Report — add negatives aggressively
- If Meta prospecting hits 10+ leads/week: add second ad set
- If any campaign has zero conversions by day 14: pause and reallocate budget

### Month 2+: Scale Decisions
- If CPL <$80 and lead quality is good: increase budget to $7.5K/month, add second Category Search campaign
- If CPL >$120: narrow targeting, improve landing page, or reduce to Google-only

## Expected Outcomes
- **Month 1**: 30-50 leads at $100-170 CPL (learning phase, expect higher costs)
- **Month 2**: 50-80 leads at $65-100 CPL (campaigns exit learning, costs stabilize)
- **Month 3+**: Optimize toward 80-120 leads at $40-65 CPL as algorithms learn
```

---

## Example 3: Budget Scaling Assessment ($20K to $50K/mo)

### User Request

"We're scaling our DTC brand from $20K/month to $50K/month on Google and Meta. Current structure is 5 Google campaigns and 3 Meta campaigns. Is our structure ready for 2.5x budget, or do we need to restructure before scaling?"

### Analysis Steps

1. **Audit current structure at $20K** — Verify campaigns meet volume and budget thresholds at current spend.
2. **Model structure at $50K** — Project conversion volumes and daily budgets at 2.5x. Identify campaigns that will benefit vs campaigns that will waste incremental budget.
3. **Identify structural gaps** — Determine what new campaigns are needed at $50K that aren't needed at $20K.
4. **Build scaling plan** — Sequence the budget increase with structural changes.

### Sample Output

```markdown
# Budget Scaling Assessment — [DTC Brand] — 2026-03-11

## Executive Summary
- **Current spend**: $20,000/month (Google: $12K, Meta: $8K)
- **Target spend**: $50,000/month (Google: $25K, Meta: $25K)
- **Current structure**: 8 campaigns (Google: 5, Meta: 3) — structurally sound at $20K
- **Scaling readiness**: PARTIAL — Google structure can absorb 2x, but Meta needs 2 additional campaigns before scaling past $30K
- **Recommended pre-scale changes**: Add 1 Advantage+ Shopping campaign (Meta), add 1 YouTube Prospecting campaign (Google), split Category Search into 2 campaigns by product line

## Structural Health Score: 72/100 (at current $20K spend)
- Conversion volume: 24/30 (all but 1 campaign meet thresholds)
- Budget allocation: 20/25 (Display Retargeting slightly under minimum)
- Targeting efficiency: 16/25 (moderate overlap between prospecting audiences on Meta)
- Objective alignment: 12/20 (1 campaign misaligned — Maximize Clicks on Competitor Search)

## Scaling Readiness by Campaign

### Google Ads — Current Structure
| Campaign | Daily Budget Now | Conv/Month Now | Daily Budget at $50K | Projected Conv/Month | Scaling Risk |
|---|---|---|---|---|---|
| Brand Search | $100 | 120 | $150 | 160 | LOW — Brand has ceiling, diminishing returns past $150/day |
| Competitor Search | $100 | 25 | $150 | 35 | MEDIUM — Switch from MaxClicks to tCPA before scaling |
| Category Search | $150 | 45 | $300 | 80 | MEDIUM — Split into 2 campaigns at $150/day each for better ad group control |
| PMax | $200 | 55 | $400 | 100 | LOW — PMax scales well, more budget = more asset group testing |
| Display Retargeting | $50 | 15 | $100 | 25 | LOW — Retargeting pool grows with prospecting spend |

### Meta Ads — Current Structure
| Campaign | Daily Budget Now | Conv/Week Now | Daily Budget at $50K | Projected Conv/Week | Scaling Risk |
|---|---|---|---|---|---|
| Prospecting CBO | $400 | 55 | $500 | 65 | HIGH — Adding $100/day to existing audiences hits diminishing returns. Need Advantage+ to absorb incremental. |
| Retargeting CBO | $150 | 35 | $200 | 45 | LOW — Retargeting pool grows naturally with more prospecting spend |
| Creative Testing | $117 | 15 | $150 | 20 | LOW — Testing budget should scale proportionally |

### Structural Changes Needed Before Scaling

1. **Add Advantage+ Shopping campaign (Meta)** — At $50K, Meta gets $25K/month ($833/day). Current Prospecting CBO can't absorb $500+/day efficiently — audience frequency will spike. Launch Advantage+ at $400/day to absorb incremental budget. Requires 50+ purchases/week (currently at 55, so threshold is met).

2. **Add YouTube Prospecting (Google)** — At $25K/month Google, there's room for upper-funnel investment. YouTube Prospecting at $100/day builds awareness and feeds Search/PMax retargeting pools.

3. **Split Category Search** — At $300/day, one Category Search campaign with 5 ad groups becomes unwieldy. Split into Category A ($150/day, 3 ad groups) and Category B ($150/day, 2 ad groups) for better budget control.

4. **Fix Competitor Search bid strategy** — Switch from Maximize Clicks to tCPA before scaling. At $150/day with MaxClicks, you're paying for traffic without optimizing for conversions.

## Scaling Roadmap

### Week 1-2: Pre-Scale Restructure (stay at $20K)
- Split Category Search into 2 campaigns
- Switch Competitor Search to tCPA
- Launch Advantage+ Shopping at $100/day (funded by reducing Prospecting CBO to $300/day)
- Let new campaigns exit learning phase

### Week 3-4: Scale to $35K
- Increase Google to $18K/month: PMax +$100/day, YouTube Prospecting launch at $100/day, remaining across Search
- Increase Meta to $17K/month: Advantage+ to $250/day, Prospecting CBO to $350/day, Retargeting to $167/day

### Week 5-8: Scale to $50K
- Increase Google to $25K/month: distribute evenly across campaigns
- Increase Meta to $25K/month: Advantage+ to $400/day, Prospecting CBO to $200/day, Retargeting to $200/day, Testing to $150/day
- Final structure: 8 Google campaigns + 4 Meta campaigns = 12 total

## Expected Outcomes
- **At $50K**: 250-350 monthly conversions (up from 120-150 at $20K)
- **Blended CPA**: $145-200 (vs $130-170 currently — expect 10-15% CPA increase at higher scale due to broader audience reach)
- **Efficiency ratio**: 2.5x budget should yield 1.7-2.3x conversions (diminishing returns are normal at scale)
```

---

## Example 4: Google PMax Cannibalization Review

### User Request

"We're running PMax, Standard Shopping, and Brand Search simultaneously. Our Brand Search CPA has doubled in the last 60 days and Shopping impressions dropped 80%. Is PMax cannibalizing everything? Should we kill it or restructure?"

### Analysis Steps

1. **Pull impression share data** — Compare Brand Search and Shopping impression share before and after PMax launch.
2. **Analyze PMax search terms** — Check Insights tab for branded queries appearing in PMax.
3. **Compare CPA trends** — Plot Brand Search CPA, Shopping CPA, and PMax CPA on the same timeline.
4. **Model scenarios** — What happens if you pause PMax, add brand negatives to PMax, or pause Shopping.

### Sample Output

```markdown
# PMax Cannibalization Review — [Brand] — 2026-03-11

## Executive Summary
- **Diagnosis**: PMax is cannibalizing both Brand Search and Standard Shopping. 65% of PMax conversions are from branded queries (Insights tab). Standard Shopping impression share dropped from 45% to 8% since PMax launch.
- **Root cause**: No brand negatives in PMax. PMax prioritizes easy wins (branded queries) to hit its Maximize Conversions target.
- **Recommended action**: Add brand term negatives to PMax + pause Standard Shopping. This is not optional — it's the only path to clean data.

## Structural Health Score: 45/100
- Conversion volume: 20/30 (all campaigns have volume, but it's the wrong volume)
- Budget allocation: 18/25 (budgets are adequate)
- Targeting efficiency: 2/25 (critical cannibalization across all 3 campaigns)
- Objective alignment: 5/20 (PMax is optimizing for branded conversions it's stealing from Brand Search)

## Cannibalization Evidence

### Impression Share Timeline
| Campaign | 90 Days Ago | 60 Days Ago | 30 Days Ago | Today |
|---|---|---|---|---|
| Brand Search IS | 92% | 78% | 61% | 55% |
| Standard Shopping IS | 45% | 28% | 12% | 8% |
| PMax (estimated) | 15% | 35% | 52% | 68% |

### CPA Trend
| Campaign | 90 Days Ago | Today | Change |
|---|---|---|---|
| Brand Search | $8 | $16 | +100% |
| Standard Shopping | $22 | $45 | +105% |
| PMax | $18 | $15 | -17% |
| Blended | $14 | $18 | +29% |

PMax CPA looks great in isolation — but it's artificially low because 65% of its conversions are branded queries that Brand Search was capturing at $8 CPA. PMax is claiming credit for conversions that would have happened anyway.

### PMax Search Terms Breakdown (from Insights)
- Branded queries: 65% of PMax conversions
- Category queries: 20% of PMax conversions
- Product queries: 10% of PMax conversions
- Discovery/Display: 5% of PMax conversions

## Consolidation Plan

### Immediate Actions (This Week)
1. **Add brand negatives to PMax** — Submit all brand terms, brand misspellings, and brand + product combinations as account-level negatives for PMax (requires Google rep or API access as of 2026).
2. **Pause Standard Shopping** — PMax has fully absorbed Shopping traffic. Standard Shopping at 8% impression share is a reporting artifact, not a real campaign.
3. **Monitor Brand Search** — After brand negatives are applied to PMax, Brand Search impression share should recover to 85-90% within 7-10 days.

### Expected Post-Fix Performance
| Campaign | Projected CPA | Projected Monthly Conv. |
|---|---|---|
| Brand Search | $9-10 (recovery from $16) | 150 (recovery from 90) |
| PMax (non-brand only) | $28-35 (true non-brand CPA) | 60-80 |
| Blended | $15-18 (improvement from $18) | 210-230 |

### Key Insight
PMax's "true" non-brand CPA is $28-35, not the $15 it's reporting. Once you strip out branded conversions, evaluate PMax on its non-brand performance only. If $28-35 CPA is acceptable for non-brand acquisition, keep PMax. If not, consider replacing with manual Shopping + Display Prospecting.

## Risks & Mitigations
| Risk | Mitigation |
|---|---|
| PMax performance drops after brand negatives | Expected — the $15 CPA was inflated by brand. True non-brand CPA of $28-35 is the real benchmark. |
| Brand Search doesn't recover impression share | Check that brand negatives are actually applied in PMax. Also check if competitors are now bidding on your brand. |
| Losing Shopping traffic after pausing Standard | PMax covers Shopping placements. If PMax Shopping performance is poor, launch a new Standard Shopping campaign without PMax running. |
```

---

## Example 5: Meta Audience Overlap Diagnosis

### User Request

"We have 10 prospecting campaigns on Meta, all optimizing for purchases. CPMs have been climbing for 3 months and CPAs are up 45%. I think we're bidding against ourselves. Can you diagnose the overlap and give me a consolidation plan?"

### Analysis Steps

1. **Map all audiences** — List every prospecting campaign with its audience targeting.
2. **Identify overlap pairs** — Determine which audiences are functionally similar.
3. **Quantify the damage** — Calculate estimated CPM inflation from self-competition.
4. **Design consolidated structure** — Reduce to 1-2 prospecting campaigns.

### Sample Output

```markdown
# Meta Audience Overlap Diagnosis — [Brand] — 2026-03-11

## Executive Summary
- **Active prospecting campaigns**: 10, all Sales objective, ABO, optimizing for Purchase
- **Total prospecting budget**: $500/day ($15,000/month)
- **Average audience overlap**: 47% across all campaign pairs (range: 22-78%)
- **Estimated CPM inflation**: 25-35% above market rate due to self-competition
- **Recommended consolidation**: 10 campaigns → 2 campaigns (Advantage+ Shopping + 1 Broad Prospecting)
- **Projected savings**: $3,750-5,250/month in wasted CPM inflation

## Structural Health Score: 32/100
- Conversion volume: 8/30 (8 of 10 campaigns under 50 purchases/week)
- Budget allocation: 10/25 (budgets individually adequate but collectively fragmented)
- Targeting efficiency: 4/25 (critical overlap across all campaigns)
- Objective alignment: 10/20 (correct objective, wrong structure)

## Audience Overlap Matrix

| Campaign | Audience | Budget | Purch/Wk |
|---|---|---|---|
| Prospecting 1 | LAL 1% - Purchasers | $60/day | 22 |
| Prospecting 2 | LAL 2-3% - Purchasers | $55/day | 15 |
| Prospecting 3 | LAL 1% - ATC | $50/day | 12 |
| Prospecting 4 | LAL 1% - Email List | $50/day | 10 |
| Prospecting 5 | Interest: Fitness | $50/day | 8 |
| Prospecting 6 | Interest: Wellness | $45/day | 6 |
| Prospecting 7 | Interest: Yoga | $40/day | 5 |
| Prospecting 8 | Interest: Running | $40/day | 4 |
| Prospecting 9 | Broad (no targeting) | $60/day | 18 |
| Prospecting 10 | LAL 5% - Purchasers | $50/day | 3 |

### Critical Overlap Pairs
| Campaign A | Campaign B | Overlap % | Impact |
|---|---|---|---|
| LAL 1% Purchasers | LAL 2-3% Purchasers | 78% | These are nearly identical audiences. Campaign B is a slightly wider version of Campaign A. |
| LAL 1% Purchasers | LAL 1% ATC | 72% | Purchasers are a subset of ATC users. Seed audiences overlap heavily. |
| LAL 1% Purchasers | LAL 1% Email | 65% | Email list and purchaser list overlap significantly. |
| Interest: Fitness | Interest: Wellness | 58% | Broad interest overlap — Meta's interest graph connects these heavily. |
| Interest: Fitness | Interest: Running | 52% | Running is a subset of Fitness in Meta's taxonomy. |
| Interest: Wellness | Interest: Yoga | 48% | Similar overlap pattern. |
| LAL 1% Purchasers | Broad | 55% | Broad targeting includes your LAL audiences by definition. |
| LAL 5% Purchasers | Broad | 70% | 5% LAL is effectively Broad with a seed signal. Highly redundant. |

### The Math on Self-Competition
- 10 campaigns entering the same auctions means your bid competes against your own bid in ~47% of impressions
- Meta's auction deduplicates (only charges you once), but your effective CPM rises because you're signaling high demand for the same users
- Average CPM across campaigns: $18.50. Estimated market CPM without overlap: $12-14
- **$4-6.50 CPM premium = $3,750-5,250/month in waste** at current spend levels

## Consolidation Plan

### Target Structure: 2 Prospecting Campaigns

**Campaign 1: Advantage+ Shopping ($350/day)**
- Let Advantage+ handle all audience finding
- Feed it your best 8-12 creative assets
- Advantage+ will naturally find the audiences your LAL and interest campaigns were targeting — but without the overlap penalty
- Projected: 65-85 purchases/week (vs 103 combined currently, but at 30% lower CPA)

**Campaign 2: Broad Prospecting ($100/day)**
- 1 ad set, no targeting constraints (Advantage+ Audience with age/gender only)
- Purpose: creative testing and incremental reach beyond Advantage+
- 3-4 ads per ad set, rotate new creative weekly
- Projected: 15-25 purchases/week

**Retargeting stays as-is** — not part of this diagnosis.

### Migration Plan
- **Week 1**: Launch Advantage+ at $175/day (50% of target). Keep all 10 old campaigns at 50% budget.
- **Week 2**: If Advantage+ CPA is within 20% of old blended CPA, increase to $250/day. Pause 5 lowest-performing old campaigns.
- **Week 3**: Increase Advantage+ to $350/day. Pause remaining 5 old campaigns. Launch Broad Prospecting at $100/day.
- **Week 4**: Full new structure. Monitor for learning phase completion.

## Expected Outcomes
- **CPM reduction**: $18.50 → $12-14 (25-35% decrease from eliminating self-competition)
- **CPA improvement**: $55 → $38-42 (25-30% improvement from lower CPMs + better algorithmic learning)
- **Weekly purchases**: 80-110 (vs 103 currently) at significantly lower cost
- **Monthly savings**: $3,750-5,250 in reduced CPM waste
- **Management time**: 2 campaigns to monitor instead of 10
```

---

## Example 6: Quarterly Health Check

### User Request

"Run a quarterly health check on our paid media accounts. We're spending $45K/month across Google ($25K) and Meta ($20K). I want a structural health score, trend analysis vs last quarter, and any action items."

### Analysis Steps

1. **Score current structure** — Apply the 100-point health score methodology across all four dimensions.
2. **Compare to previous quarter** — Identify improvements and regressions.
3. **Flag new issues** — Any structural problems that emerged since last review.
4. **Prioritize action items** — Rank by impact and urgency.
5. **Set targets for next quarter** — Define what "good" looks like in 90 days.

### Sample Output

```markdown
# Quarterly Health Check — [Brand] — Q1 2026

## Executive Summary
- **Total monthly spend**: $45,000 (Google: $25,000, Meta: $20,000)
- **Total campaigns**: 14 (Google: 8, Meta: 6)
- **Structural Health Score**: 71/100 (up from 58 last quarter)
- **Key improvement**: Google Search consolidation from 15 campaigns to 6 (+18 points)
- **Key regression**: Meta prospecting overlap crept back to 32% as new audiences were added (-4 points)
- **Action items**: 3 (1 urgent, 2 scheduled)

## Structural Health Score: 71/100

### Score Breakdown
| Dimension | This Quarter | Last Quarter | Change | Notes |
|---|---|---|---|---|
| Conversion Volume | 22/30 | 14/30 | +8 | Search consolidation pushed 4 campaigns above threshold |
| Budget Allocation | 20/25 | 16/25 | +4 | Eliminated shared budgets, all campaigns above minimums |
| Targeting Efficiency | 15/25 | 18/25 | -3 | New Meta prospecting audiences introduced 32% overlap |
| Objective Alignment | 14/20 | 10/20 | +4 | Migrated Competitor Search from MaxClicks to tCPA |
| **Total** | **71/100** | **58/100** | **+13** | |

### Trend Analysis
- **Q3 2025**: 42/100 (critical — 35+ campaigns, severe fragmentation)
- **Q4 2025**: 58/100 (improving — Google consolidation Phase 1 complete)
- **Q1 2026**: 71/100 (good — on track for 80+ by Q2 if Meta overlap is resolved)

## Google Ads Health (Score: 42/45)

### Campaign Inventory
| Campaign | Type | Daily Budget | Monthly Conv. | Status |
|---|---|---|---|---|
| Brand Search | Search | $120 | 145 | Healthy |
| Competitor Search | Search | $80 | 32 | Healthy (recently migrated to tCPA) |
| Category - Skincare | Search | $120 | 48 | Healthy |
| Category - Wellness | Search | $100 | 35 | Healthy |
| Generic - Problems | Search | $80 | 22 | Marginal (below 30 ideal for tCPA) |
| PMax | PMax | $250 | 85 | Healthy |
| Display Retargeting | Display | $50 | 18 | Healthy |
| YouTube Prospecting | YouTube | $80 | 12 | Marginal (but awareness goal, volume less critical) |

### Issues
1. **Generic Search volume** — 22 conversions/month is below tCPA ideal of 30. Not urgent — monitor for one more month. If still under 30, consider merging into Category - Skincare.
2. **YouTube Prospecting measurement** — 12 conversions/month is low, but YouTube's role is awareness/consideration. Validate with view-through conversion data and Search lift studies if available.

### No Action Required — Google structure is sound.

## Meta Ads Health (Score: 29/55)

### Campaign Inventory
| Campaign | Objective | Budget Type | Daily Budget | Weekly Conv. | Overlap % | Status |
|---|---|---|---|---|---|---|
| Advantage+ Shopping | Sales | CBO | $300 | 72 | N/A | Healthy |
| Prospecting - LAL | Sales | CBO | $150 | 28 | 32% (w/ Interest) | Overlap |
| Prospecting - Interest | Sales | CBO | $100 | 15 | 32% (w/ LAL) | Overlap, Under-Volume |
| Retargeting - Website | Sales | CBO | $80 | 22 | N/A | Healthy |
| Retargeting - Engaged | Sales | ABO | $30 | 8 | N/A | Under-Volume |
| Creative Testing | Sales | ABO | $40 | 6 | N/A | Testing (expected low volume) |

### Issues
1. **URGENT — Prospecting overlap returned** — LAL and Interest campaigns have 32% overlap. Interest campaign was added in February without checking overlap with existing LAL audience. Interest campaign has only 15 purchases/week (below 50 minimum).
   - **Action**: Merge Interest campaign into LAL campaign as a second ad set, OR pause Interest and increase LAL budget by $100/day.
   - **Timeline**: This week.

2. **Retargeting - Engaged under-volume** — 8 purchases/week from engaged users. This ad set has been under 10 for 3 consecutive months.
   - **Action**: Merge into Retargeting - Website campaign as a second ad set. Combined budget of $110/day with CBO.
   - **Timeline**: Next 2 weeks.

## Action Items (Priority Order)

| # | Action | Platform | Priority | Timeline | Expected Impact |
|---|---|---|---|---|---|
| 1 | Merge or pause Interest prospecting campaign | Meta | Urgent | This week | Eliminate 32% audience overlap, reduce CPM by 10-15% |
| 2 | Merge Retargeting - Engaged into Retargeting - Website | Meta | Scheduled | Next 2 weeks | Consolidate under-volume ad set, improve learning |
| 3 | Monitor Generic Search campaign volume | Google | Watch | End of Q2 | If still <30 conv/month, merge into Category |

## Q2 2026 Targets
- **Health Score target**: 80+/100
- **Conversion volume**: 26+/30 (all campaigns above minimum thresholds)
- **Budget allocation**: 22+/25 (maintain current)
- **Targeting efficiency**: 20+/25 (resolve Meta overlap, maintain Google clean)
- **Objective alignment**: 14+/20 (maintain current)

## Next Review: June 2026
```

---

## Common Analysis Patterns

### Pattern 1: "Inherited Account" Audit
```
I just took over [account/client] spending $[X]/month on [Google/Meta/both].
Here's a summary of the current structure:
[Paste campaign list with budgets and recent performance]

Audit the structure and give me:
1. Structural health score
2. Top 3 issues
3. Consolidation plan with migration roadmap
```

### Pattern 2: "Should I Consolidate?" Assessment
```
I have [X] campaigns on [platform] spending $[X]/month total.
[X] campaigns have fewer than [X] conversions per [month/week].
Daily budgets range from $[X] to $[X].

Should I consolidate? If so, what's the target structure and migration plan?
```

### Pattern 3: "Pre-Scale" Structure Check
```
I'm scaling from $[X]/month to $[X]/month on [platform].
Current structure: [list campaigns with budgets]

Is my structure ready for [X]x budget? What needs to change before I scale?
```

---

## Pro Tips

1. **Instead of**: "How many campaigns should I have?"
   **Ask**: "Given $30K/month budget, 200 monthly conversions, and 3 product categories on Google + Meta, what's the right campaign structure?"

2. **Instead of**: "Should I use PMax?"
   **Ask**: "I'm running Brand Search ($100/day, 80 conv/month) and Standard Shopping ($150/day, 45 conv/month). Should I add PMax, and if so, what happens to Shopping?"

3. **Instead of**: "My CPAs are too high"
   **Ask**: "My tCPA campaigns are running at $45 CPA against a $30 target. 4 of 6 campaigns have <20 conversions/month. Is the structure causing this?"

4. **Instead of**: "Audit my account"
   **Ask**: "Audit my account structure against conversion volume minimums, budget fragmentation thresholds, and targeting overlap. Score it and give me a prioritized consolidation plan."

5. **Instead of**: "Should I use CBO or ABO?"
   **Ask**: "I have $200/day for Meta prospecting with 3 audiences averaging 15 purchases/week each. CBO or ABO, and should I consolidate into fewer ad sets?"
