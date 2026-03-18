# Google Ads Skill — Examples

Realistic examples showing how to use the Google Ads skill for audits, diagnostics, and optimization.

---

## 1. Full Account Audit

**User Request:**
> "Run a full audit on our Google Ads account. We're spending $45K/month across Search, Shopping, and Performance Max but CPA has been creeping up for the last 3 months."

**Analysis Steps:**
1. Pull campaign inventory with spend, conversions, CPA, and ROAS for last 90 days — compare month-over-month trend
2. Check conversion tracking setup: verify Google Tag firing, conversion actions, attribution model, and enhanced conversions status
3. Review account structure: campaign naming conventions, ad group themes, match type strategy, negative keyword lists
4. Analyze budget allocation vs performance: identify campaigns over/under-spending relative to efficiency
5. Compile findings into prioritized recommendations with estimated impact

**Sample Output:**

### Account Overview (Last 90 Days)

| Campaign | Type | Monthly Spend | Conv. | CPA | ROAS | Trend |
|----------|------|--------------|-------|-----|------|-------|
| Brand Search | Search | $4,200 | 312 | $13.46 | 8.2x | Stable |
| NB - High Intent | Search | $12,800 | 186 | $68.82 | 3.1x | CPA +18% |
| NB - Category | Search | $6,400 | 54 | $118.52 | 1.4x | CPA +31% |
| Shopping - Top SKUs | Shopping | $8,100 | 142 | $57.04 | 4.6x | Stable |
| Shopping - Catch All | Shopping | $3,200 | 28 | $114.29 | 1.8x | Declining |
| Performance Max | PMax | $10,300 | 97 | $106.19 | 2.3x | CPA +24% |

### Key Findings

1. **Conversion tracking gap**: Enhanced conversions not enabled. Estimated 15-20% of conversions unattributed, inflating reported CPA.
2. **NB - Category campaign**: CPA up 31% with only 54 conversions/month. Broad match keywords triggering irrelevant queries — 38% of search terms have zero conversions.
3. **PMax cannibalizing brand**: Insights report shows 22% of PMax conversions come from brand search terms. Brand campaign impression share dropped from 94% to 81%.
4. **Shopping catch-all**: 140 products with zero clicks in 60 days dragging down campaign Quality Score signals.
5. **No audience layering**: Zero remarketing lists applied to Search campaigns. No Customer Match uploaded.

### Recommendations (Priority Order)

| # | Action | Expected Impact | Effort |
|---|--------|----------------|--------|
| 1 | Enable enhanced conversions | Recover 15-20% lost attribution, improve Smart Bidding signals | Low |
| 2 | Add brand exclusions to PMax | Restore brand Search impression share to 94%+, reduce PMax CPA | Low |
| 3 | Overhaul NB - Category negatives | Cut wasted spend ~$2K/month, reduce CPA by 20-25% | Medium |
| 4 | Upload Customer Match list + build RLSA | Improve conversion rates on non-brand Search by 15-30% | Medium |
| 5 | Prune zero-click Shopping products into separate low-bid group | Reallocate ~$800/month to top performers | Low |

---

## 2. Quality Score Diagnosis

**User Request:**
> "Most of our non-brand keywords have Quality Scores of 4-5. CPCs are really high compared to competitors. What's going on and how do we fix it?"

**Analysis Steps:**
1. Pull Quality Score breakdown (expected CTR, ad relevance, landing page experience) for all enabled keywords
2. Segment by ad group to identify whether the issue is systemic or isolated
3. Cross-reference low-QS keywords with ad copy and landing page URLs to find mismatches
4. Identify the dominant QS sub-component dragging scores down
5. Prioritize fixes by spend-weighted impact

**Sample Output:**

### Quality Score Distribution (Enabled Keywords)

| QS | Keyword Count | % of Spend | Avg CPC |
|----|--------------|------------|---------|
| 9-10 | 12 | 8% | $2.14 |
| 7-8 | 34 | 22% | $3.87 |
| 5-6 | 68 | 41% | $6.52 |
| 3-4 | 43 | 24% | $9.18 |
| 1-2 | 8 | 5% | $12.40 |

### Sub-Component Analysis

| Component | Below Average | Average | Above Average |
|-----------|--------------|---------|---------------|
| Expected CTR | 31% | 52% | 17% |
| Ad Relevance | 48% | 39% | 13% |
| Landing Page Exp. | 62% | 30% | 8% |

**Root cause: Landing page experience is the primary drag**, with 62% of keywords rated "Below Average." Ad relevance is the secondary issue.

### Top 10 Keywords by Wasted QS Spend

| Keyword | QS | eCTR | Ad Rel. | LP Exp. | Monthly Spend | Issue |
|---------|----|----|---------|---------|--------------|-------|
| [crm software pricing] | 3 | Avg | Below | Below | $1,840 | LP is homepage, not pricing page |
| "project management tool" | 4 | Avg | Below | Below | $1,620 | Ad copy mentions "solutions" not "tool" |
| [employee onboarding platform] | 4 | Below | Below | Avg | $1,410 | Ad group has 22 keywords, poor theme |
| ... | | | | | | |

### Fix Priority

1. **Landing pages (highest impact)**: Map each ad group to a dedicated landing page matching keyword intent. The homepage is the landing page for 73% of ad groups — this is the single biggest QS penalty.
2. **Ad relevance**: Restructure ad groups to 5-10 tightly themed keywords each. Write RSA headlines that include the exact keyword themes per group.
3. **Expected CTR**: After fixing LP and ad relevance, CTR will improve organically. Add sitelink and callout extensions to improve click-through.

**Estimated impact**: Improving QS from avg 5.2 to 7.0 would reduce CPCs by ~25% ($18K annual savings at current spend).

---

## 3. Performance Max Audit

**User Request:**
> "We launched Performance Max 6 weeks ago to replace our Display campaigns. Spend is $8K/month but we can't tell what's working. Can you audit it?"

**Analysis Steps:**
1. Review asset group structure, audience signals, and URL expansion settings
2. Pull Insights report data: top-performing asset combinations, search categories, audience segments
3. Check for Search/Shopping cannibalization by comparing pre/post PMax metrics on existing campaigns
4. Evaluate asset quality ratings and identify gaps
5. Assess whether PMax conversion data is incremental or shifted from other campaigns

**Sample Output:**

### Asset Group Review

| Asset Group | Assets Provided | Asset Strength | Audience Signals | Issues |
|-------------|----------------|----------------|-----------------|--------|
| All Products | 8 headlines, 3 descriptions, 6 images, 0 videos, 1 logo | Average | None configured | No video, no audience signals |

**Critical issues found:**

1. **Single asset group for all products**: No segmentation by category or audience theme. Google cannot optimize creative per segment.
2. **No audience signals**: PMax is running fully blind on prospecting. Without signals, it defaults to the broadest possible targeting — likely why efficiency is low.
3. **No video assets**: Google auto-generates low-quality videos from images. These perform poorly on YouTube inventory and waste budget.
4. **URL expansion ON with no exclusions**: PMax is sending traffic to blog posts, careers page, and support docs. 18% of landing page URLs are non-commercial.

### Cannibalization Check

| Metric | Brand Search (Pre-PMax) | Brand Search (Post-PMax) | Delta |
|--------|------------------------|--------------------------|-------|
| Impressions | 24,100 | 19,300 | -20% |
| Conversions | 186 | 148 | -20% |
| Impression Share | 93% | 78% | -15pts |

PMax is capturing brand queries. Brand Search lost 20% of volume since PMax launch.

### Recommendations

| # | Action | Impact |
|---|--------|--------|
| 1 | Add brand exclusions to PMax immediately | Restores brand Search volume, removes fake "incremental" conversions from PMax reporting |
| 2 | Split into 3-4 asset groups by product category | Enables per-category creative optimization and audience targeting |
| 3 | Configure audience signals: Customer Match list + in-market segments per group | Gives PMax a starting point for prospecting, faster learning |
| 4 | Upload 2-3 real video assets (15s and 30s) | Replaces auto-generated videos, improves YouTube placement quality |
| 5 | Exclude non-commercial URLs from URL expansion | Prevents traffic to blog/careers/support pages |

---

## 4. Wasted Spend Analysis

**User Request:**
> "We feel like we're wasting money on Google Ads but don't know where. Can you find where spend is being wasted and tell us what to cut?"

**Analysis Steps:**
1. Pull search term report for last 30 days — flag terms with spend but zero conversions
2. Identify keywords with high spend and CPA above 2x target
3. Review device, geo, day-of-week, and hour-of-day performance for bid adjustment opportunities
4. Check for audience overlap and competing campaigns bidding on the same queries

**Sample Output:**

### Wasted Spend Summary (Last 30 Days)

| Category | Wasted Spend | % of Total | Action |
|----------|-------------|------------|--------|
| Irrelevant search terms | $3,840 | 12.8% | Add negatives |
| High-CPA keywords (>2x target) | $2,960 | 9.9% | Pause or restructure |
| Low-performing devices (tablets) | $1,120 | 3.7% | Bid adjustment -50% |
| Off-hours spend (11pm-6am) | $890 | 3.0% | Ad schedule exclusion |
| Search Partner network | $1,450 | 4.8% | Disable on 3 campaigns |
| **Total identifiable waste** | **$10,260** | **34.2%** | |

### Top Irrelevant Search Terms (by spend, zero conversions)

| Search Term | Impressions | Clicks | Spend | Triggered By |
|-------------|------------|--------|-------|-------------|
| free crm download | 1,420 | 86 | $412 | "crm software" (broad) |
| crm developer api documentation | 890 | 52 | $338 | "crm platform" (broad) |
| what is a crm | 2,100 | 71 | $284 | "crm" (broad) |
| crm jobs hiring | 640 | 44 | $261 | "crm" (broad) |
| salesforce vs hubspot | 780 | 38 | $228 | "crm comparison" (phrase) |

### Recommended Negative Keyword List

```
Account-level negatives (apply to all Search campaigns):
- free
- download
- api
- documentation
- developer
- jobs
- hiring
- salary
- tutorial
- what is
- reddit
- quora
```

### Budget Reallocation

| From | To | Amount | Rationale |
|------|----|--------|-----------|
| NB - Category (broad) | NB - High Intent (exact/phrase) | $3,000/mo | Shift from low-intent to high-intent queries |
| Search Partners | Brand Search | $1,450/mo | Brand IS is only 81%, competitors capturing share |
| Off-hours spend | Peak hours (9am-5pm) | $890/mo | 78% of conversions happen during business hours |

---

## 5. Shopping Campaign Optimization

**User Request:**
> "Our Shopping campaigns are underperforming versus competitors. Products are showing but CTR and conversion rates are low. How do we improve?"

**Analysis Steps:**
1. Audit Merchant Center feed: title quality, image compliance, missing attributes, disapprovals
2. Review product group structure and bid segmentation
3. Pull competitive metrics: benchmark CTR, CPC, and impression share vs category averages
4. Identify top and bottom performing product segments
5. Check for supplemental feed opportunities

**Sample Output:**

### Feed Health Check

| Metric | Your Account | Benchmark | Status |
|--------|-------------|-----------|--------|
| Products approved | 842 / 910 (92.5%) | 97%+ | Needs attention |
| Title optimization score | Low | High | Primary issue |
| Missing GTINs | 124 products | 0 | Disapprovals likely |
| Image issues | 18 products | 0 | Promotional overlays |
| Price competitiveness | 34th percentile | 50th+ | Below average |

### Feed Quality Issues

| Issue | Product Count | Impact | Fix |
|-------|--------------|--------|-----|
| Titles are brand-only (e.g., "Widget Pro") | 380 | Low CTR — no key attributes in title | Rewrite: Brand + Type + Color + Size + Material |
| Missing GTINs | 124 | Suppressed from some auctions | Add UPC/EAN from manufacturer |
| Promotional overlay on images | 18 | Policy disapproval | Use clean product-on-white images |
| Missing product_type | 290 | Poor segmentation | Add 3-level product type taxonomy |
| No custom labels | 910 | Cannot segment by margin or velocity | Add custom_label_0: margin tier, custom_label_1: best seller |

### Competitive Metrics (Auction Insights)

| Competitor | Impression Share | Overlap Rate | Outranking Share |
|------------|-----------------|-------------|-----------------|
| Competitor A | 68% | 72% | 61% |
| Competitor B | 54% | 58% | 44% |
| Your Account | 31% | -- | -- |

### Recommendations

1. **Title optimization (highest impact)**: Rewrite titles using formula: Brand + Product Type + Key Attributes. This alone can improve CTR by 15-25%.
2. **Add custom labels**: Segment products by margin tier (high/medium/low) and sales velocity (best seller/standard/slow). Bid aggressively on high-margin best sellers.
3. **Fix 124 missing GTINs**: Required for competitive auctions. Suppressed products are invisible spend blockers.
4. **Restructure product groups**: Current structure is "All Products" in one group. Split by category and margin tier for differentiated bidding.
5. **Add supplemental feed** with optimized titles, custom labels, and missing attributes without modifying the primary feed.

---

## 6. Bidding Strategy Review

**User Request:**
> "We're on Maximize Conversions across all campaigns. Should we switch to Target CPA or Target ROAS? Some campaigns are efficient and some aren't."

**Analysis Steps:**
1. Pull conversion volume and CPA/ROAS by campaign for the last 30 days
2. Assess which campaigns meet the threshold for Target CPA (30+ conversions) or Target ROAS (50+ conversions)
3. Check for learning phase issues and recent bid strategy changes
4. Recommend per-campaign strategy based on maturity and goals

**Sample Output:**

### Current Performance (Last 30 Days)

| Campaign | Strategy | Conv. (30d) | CPA | ROAS | Budget | Status |
|----------|----------|-------------|-----|------|--------|--------|
| Brand Search | Max Conv. | 312 | $13.46 | 8.2x | $150/d | Eligible for tCPA |
| NB - High Intent | Max Conv. | 62 | $68.82 | 3.1x | $425/d | Eligible for tCPA |
| NB - Category | Max Conv. | 18 | $118.52 | 1.4x | $215/d | Too few conv. for tCPA |
| Shopping - Top SKUs | Max Conv. | 47 | $57.04 | 4.6x | $270/d | Eligible for tCPA |
| Shopping - Catch All | Max Conv. | 9 | $114.29 | 1.8x | $105/d | Too few conv. |
| Performance Max | Max Conv. | 32 | $106.19 | 2.3x | $340/d | Borderline for tCPA |

### Strategy Recommendations

| Campaign | Recommended Strategy | Target | Rationale |
|----------|---------------------|--------|-----------|
| Brand Search | Target CPA | $15.00 | High volume, stable CPA. Set target 10% above current to avoid under-delivery. |
| NB - High Intent | Target CPA | $75.00 | 62 conversions is solid. Start conservative, tighten over 2-3 weeks. |
| NB - Category | Stay on Max Conv. | -- | Only 18 conversions. Not enough data for tCPA. Focus on negatives and ad relevance first. |
| Shopping - Top SKUs | Target ROAS | 400% | 47 conversions with strong ROAS. Target ROAS preserves value optimization. |
| Shopping - Catch All | Manual CPC | -- | 9 conversions is too low for automation. Use manual CPC while building volume. |
| Performance Max | Target CPA | $115.00 | 32 conversions is minimum viable. Set conservative target, monitor weekly. |

### Transition Plan

1. **Week 1**: Switch Brand Search and NB - High Intent to Target CPA. Do not touch other campaigns.
2. **Week 2**: Monitor learning phase. Do not change bids, budgets, or ads during learning (~7 days).
3. **Week 3**: If stable, switch Shopping - Top SKUs to Target ROAS. Switch PMax to Target CPA.
4. **Week 4**: Review all campaigns. Tighten targets by 5-10% if performance is stable.

**Important**: Never switch more than 2 campaigns at once. Stagger changes to isolate the impact of each switch.

---

## 7. Competitor & Impression Share Analysis

**User Request:**
> "We keep seeing competitors above us in search results. How much market share are we losing and what would it cost to recapture it?"

**Analysis Steps:**
1. Pull Auction Insights report for brand and non-brand campaigns
2. Calculate impression share losses broken down by budget vs rank
3. Estimate incremental cost to close impression share gaps
4. Assess competitive positioning: who is outranking, on which queries, how often

**Sample Output:**

### Brand Search — Auction Insights (Last 30 Days)

| Competitor | Impression Share | Overlap Rate | Position Above Rate | Outranking Share |
|------------|-----------------|-------------|-------------------|-----------------|
| **Your Account** | **81%** | -- | -- | -- |
| Competitor A | 42% | 48% | 22% | 38% |
| Competitor B | 28% | 31% | 8% | 18% |
| Competitor C | 15% | 18% | 3% | 9% |

### Non-Brand Search — Auction Insights

| Competitor | Impression Share | Overlap Rate | Position Above Rate | Outranking Share |
|------------|-----------------|-------------|-------------------|-----------------|
| **Your Account** | **34%** | -- | -- | -- |
| Competitor A | 61% | 72% | 54% | 68% |
| Competitor B | 48% | 58% | 41% | 52% |
| Competitor C | 44% | 51% | 38% | 47% |

### Impression Share Loss Breakdown

| Campaign | Current IS | Lost IS (Budget) | Lost IS (Rank) | Total Lost |
|----------|-----------|-----------------|---------------|------------|
| Brand Search | 81% | 4% | 15% | 19% |
| NB - High Intent | 38% | 22% | 40% | 62% |
| NB - Category | 24% | 31% | 45% | 76% |
| Shopping - Top SKUs | 42% | 18% | 40% | 58% |

### Cost to Close the Gap

| Campaign | Current Spend | Target IS | Est. Additional Spend | Expected Add'l Conv. |
|----------|-------------|-----------|----------------------|---------------------|
| Brand Search (to 95%) | $4,200/mo | 95% | +$900/mo | +52 conv. at $13 CPA |
| NB - High Intent (to 55%) | $12,800/mo | 55% | +$5,700/mo | +48 conv. at $69 CPA |
| Shopping - Top SKUs (to 60%) | $8,100/mo | 60% | +$3,500/mo | +38 conv. at $57 CPA |

### Recommendations

1. **Brand Search is the highest-ROI recapture**: Spend $900/month more to go from 81% to 95% IS. These are users searching your brand name — losing them to competitors is unacceptable at $13 CPA.
2. **NB - High Intent has the most headroom**: 62% impression share is lost. But fix Quality Scores and ad relevance first (rank losses) before adding budget.
3. **Do not chase NB - Category IS**: At $118 CPA and 1.4x ROAS, gaining more share here would be unprofitable. Fix efficiency before scaling.
4. **Shopping IS gap is mostly rank**: Improve feed titles and bids on top-margin products to win more auctions without pure budget increases.

---

## Common Analysis Patterns

### Quick Health Check Template
When a user asks "how's my account doing?" — pull these 5 metrics first:
1. **Conversion tracking**: Are conversions actually firing? Check last 7 days for gaps.
2. **Brand impression share**: Below 90% means competitors are stealing branded traffic.
3. **Search term relevance**: What % of search terms converted in the last 30 days?
4. **CPA trend**: Is CPA rising, falling, or stable over 90 days?
5. **Budget utilization**: Any campaigns limited by budget that have strong ROAS?

### Spend Efficiency Template
When asked "where am I wasting money?" — check these buckets:
1. Search terms with spend but zero conversions (last 30 days)
2. Keywords with CPA above 2x the account average
3. Geographic regions with below-average conversion rates
4. Device segments with high CPC but low conversion rates
5. Time-of-day and day-of-week patterns for scheduling gaps

### PMax Diagnostic Template
When asked about Performance Max specifically:
1. Asset group count and theme clarity
2. Audience signals present or absent
3. URL expansion settings and non-commercial landing pages
4. Brand cannibalization: compare brand Search IS before vs after PMax launch
5. Insights tab: what search categories and audience segments is PMax actually targeting?

### Conversion Tracking Verification Template
When conversion data looks off:
1. Google Tag Assistant: is the tag firing on all pages?
2. Conversion action settings: counting model (one vs every), include in conversions, attribution model
3. Enhanced conversions: enabled or disabled?
4. Tag firing location: is it on the right thank-you/confirmation page?
5. Cross-domain tracking: if the user journey spans multiple domains, is the linker configured?

---

## Pro Tips

**Instead of:** "Audit my Google Ads account"
**Ask:** "Audit my Google Ads account. Our goal is $50 CPA for demo requests. We spend $30K/month across Search and PMax. CPA has increased 25% in the last 60 days."

**Instead of:** "Fix my Quality Scores"
**Ask:** "These 15 keywords have QS of 3-4 and account for 40% of our non-brand spend. Landing page experience is 'Below Average' on all of them. What's the fix priority?"

**Instead of:** "Should I use Performance Max?"
**Ask:** "We run standard Shopping and Search campaigns. Shopping ROAS is 4.2x. We're considering PMax to expand reach. What's the risk of cannibalization and how do we structure asset groups for our 4 product categories?"

**Instead of:** "My campaigns aren't working"
**Ask:** "Non-brand Search CPA went from $45 to $72 over 8 weeks. Conversion volume is flat but spend increased. We didn't change bids or budgets. What could be driving this?"

**Instead of:** "Help with bidding"
**Ask:** "We have 5 campaigns: 2 have 50+ conversions/month, 2 have 15-20, and 1 has under 10. All are on Maximize Conversions. Which should move to Target CPA and at what targets?"

---

## 8. Scored Account Audit (Health Score)

**User Request:**
> "Give me a scored audit of our Google Ads account with a health grade."

**Analysis Steps:**
1. Load `skills/shared/scoring-system.md` for scoring algorithm and `CHECKS.md` for the 74-check audit
2. Evaluate each applicable check as PASS, WARNING, or FAIL based on account data
3. Calculate category scores using severity multipliers and category weights
4. Identify Quick Wins (Critical/High severity, ≤15 min fix time)
5. Produce health score, grade, and prioritized action plan

**Sample Output:**

## Account Health Score: 64/100 (Grade C — Needs Improvement)

### Quick Wins (fix in ≤15 min, high impact)
1. **[Critical]** Enable Enhanced Conversions — G-CT2 (5 min)
2. **[Critical]** Add negative keyword lists — G-WS2 (10 min)
3. **[Critical]** Fix Broad Match + Manual CPC — G-WS5 (5 min)
4. **[High]** Switch location targeting to "People in" — G-ST11 (2 min)
5. **[High]** Disable Display Network on Search campaigns — G-ST12 (2 min)
6. **[High]** Add brand exclusions to PMax — G-ST7 (5 min)

### Category Breakdown

| Category | Weight | Score | Grade | Top Issue |
|----------|--------|-------|-------|-----------|
| Conversion Tracking | 25% | 52 | D | Enhanced Conversions inactive (G-CT2) |
| Wasted Spend / Negatives | 20% | 38 | F | No negative keyword lists, 18% irrelevant spend |
| Account Structure | 15% | 75 | B | PMax brand overlap not addressed |
| Keywords & Quality Score | 15% | 71 | C | Average QS at 5.8, below 7 target |
| Ads & Assets | 15% | 78 | B | PMax asset groups need more video |
| Settings & Targeting | 10% | 82 | B | Missing Customer Match lists |

### Detailed Findings

**Conversion Tracking (52/100 — Grade D)**
| Check | Result | Finding |
|-------|--------|---------|
| G-CT1 Primary conversion action | PASS | Purchase action active, 186 conversions/month |
| G-CT2 Enhanced conversions | FAIL | Not enabled — estimated 15-20% data loss |
| G-CT3 Server-side tracking | WARNING | Planned Q2 but not deployed |
| G-CT5 Conversion window | PASS | 30-day window appropriate for this business |
| G-CT6 Macro/micro separation | FAIL | AddToCart set as Primary (inflating bidding signals) |
| G-CT9 No duplicate counting | PASS | GA4 import disabled, using native tag only |
| G-CT11 Google Tag firing | PASS | Tag verified on all pages |

*[Additional categories follow same format...]*

### Prioritized Action Plan

**Immediate (This Week)**
1. Enable Enhanced Conversions for Purchase action
2. Remove AddToCart from Primary conversion actions (set to Secondary)
3. Create 3 themed negative keyword lists and apply account-wide
4. Fix Broad Match + Manual CPC on NB-Category campaign

**This Month**
5. Address Quality Score: rewrite headlines for top 20 keywords with QS ≤5
6. Add Customer Match list and remarketing audiences in Observation mode
7. Deploy server-side tracking (GTM server container)

**Next Quarter**
8. Restructure PMax asset groups with full video coverage
9. Test portfolio bid strategies for low-volume campaigns
