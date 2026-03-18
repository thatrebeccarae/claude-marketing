# Microsoft Ads — Examples

## 1. Full Account Audit

**User Request**: "Audit my Microsoft Ads account. We spend about $15K/month across search and shopping. Performance has been flat for 3 months."

**Analysis Steps**:
1. Review account structure — campaign organization, naming conventions, budget allocation across campaign types
2. Analyze keyword health — match type distribution, quality scores, search term relevance, negative keyword coverage
3. Evaluate ad copy — RSA asset ratings, extension completeness, ad rotation settings
4. Check audience layers — remarketing lists, LinkedIn Profile Targeting, in-market audiences applied
5. Assess tracking — UET tag firing, conversion goal configuration, attribution model

**Sample Output**:

### Account Audit Summary

| Area | Score | Status |
|------|-------|--------|
| Account Structure | 6/10 | Needs work |
| Keyword Health | 5/10 | Critical |
| Ad Copy | 7/10 | Acceptable |
| Audience Targeting | 3/10 | Critical |
| Tracking & Attribution | 8/10 | Good |
| Budget Allocation | 5/10 | Needs work |

### Critical Findings

**1. Keyword bloat is draining budget**
- 1,847 active keywords across 12 ad groups, but 62% have zero conversions in 90 days
- 38% of spend goes to broad match terms with <1% conversion rate
- Only 2 shared negative keyword lists (should have 5-8 for this account size)

**2. No audience layering**
- Zero LinkedIn Profile Targeting applied — this is your biggest missed opportunity on Microsoft
- Only 1 remarketing list (all visitors, 30 days). No segmentation by page depth or intent
- No in-market audiences applied to any campaign

**3. Budget misallocation**

| Campaign | Monthly Spend | Conversions | CPA | Recommendation |
|----------|--------------|-------------|-----|----------------|
| Brand Search | $2,100 | 89 | $23.60 | Reduce — 92% impression share already |
| Non-Brand Search | $7,400 | 41 | $180.49 | Restructure — CPA 3x target |
| Shopping | $4,200 | 67 | $62.69 | Increase — best CPA in account |
| Audience Network | $1,300 | 3 | $433.33 | Pause — insufficient conversion data |

### Priority Recommendations

1. **Immediate**: Pause the 1,142 zero-conversion keywords. Reallocate $4,600/mo to Shopping
2. **This week**: Add LinkedIn Profile Targeting to Non-Brand Search (target by industry + job function for your B2B segments)
3. **This week**: Build 3 new negative keyword lists from search term report (last 90 days shows 34% irrelevant queries)
4. **Next sprint**: Restructure Non-Brand Search into SKAG-lite groups (5-10 tightly themed keywords per ad group)
5. **Next sprint**: Create segmented remarketing lists (product page viewers, cart abandoners, blog readers)

---

## 2. Google Ads Import Review

**User Request**: "We just imported our Google Ads campaigns into Microsoft. What should we check and optimize specifically for Microsoft?"

**Analysis Steps**:
1. Verify import completeness — campaigns, ad groups, keywords, ads, extensions all transferred
2. Identify what did NOT import — Performance Max, Display, bid strategy resets
3. Flag Microsoft-specific opportunities the import cannot create (LinkedIn targeting, Audience Network)
4. Review budget scaling — Microsoft typically needs 20-30% of Google budgets for comparable impression share
5. Check tracking setup — UET is separate from Google Tag, conversion goals need manual creation

**Sample Output**:

### Import Health Check

| Component | Imported | Issues |
|-----------|----------|--------|
| Campaigns (8) | 7 of 8 | 1 Performance Max skipped |
| Ad Groups (34) | 34 of 34 | Clean |
| Keywords (1,204) | 1,198 of 1,204 | 6 rejected (too long) |
| RSAs (22) | 22 of 22 | Clean |
| Sitelinks (12) | 12 of 12 | Clean |
| Callouts (8) | 8 of 8 | Clean |
| Structured Snippets (4) | 4 of 4 | Clean |
| Audiences (6) | 0 of 6 | Google audiences don't transfer — rebuild |
| Bid Strategies | Reset | All campaigns reset to Manual CPC |

### What Needs Immediate Attention

**1. Bid strategies reset to Manual CPC**
All automated strategies (Target CPA, Maximize Conversions) reverted. You need at least 2 weeks of conversion data before re-enabling automated bidding on Microsoft. Keep Manual CPC for now, then switch to Enhanced CPC as a bridge.

**2. Audiences did not transfer**
Google remarketing lists, in-market audiences, and custom segments are platform-specific. Rebuild:
- Create UET-based remarketing lists (requires UET tag — see item 4)
- Apply Microsoft's in-market audiences (similar categories but different taxonomy)
- Add LinkedIn Profile Targeting (not available on Google)

**3. Budget scaling**
Your Google budgets imported at full value. Microsoft search volume is ~10-15% of Google.

| Campaign | Google Budget | Recommended Microsoft Budget |
|----------|-------------|---------------------------|
| Brand Search | $150/day | $35/day |
| Non-Brand — Category A | $200/day | $50/day |
| Non-Brand — Category B | $180/day | $45/day |
| Shopping | $250/day | $70/day |

**4. UET tracking not set up**
Google Tag conversions do not carry over. You need:
- Install UET base tag on all pages
- Create conversion goals matching your Google goals
- Wait 24-48 hours for tag validation before enabling automated bidding

### Microsoft-Specific Optimizations (not possible via import)

1. **LinkedIn Profile Targeting**: Layer company industry and job function targeting on B2B campaigns. This alone can improve conversion rates 15-25% for B2B
2. **Microsoft Audience Network**: Create a dedicated Audience campaign for native placements on MSN, Outlook, and Edge
3. **Microsoft Clarity**: Free — link it to your Microsoft Ads account for session recordings on ad landing pages
4. **Search partner network**: Microsoft's partner network (DuckDuckGo, Yahoo) often performs differently than Bing proper. Monitor and adjust with network bid modifiers
5. **Image extensions**: Microsoft supports image extensions on search — import doesn't create these. Add product/brand images to boost CTR

---

## 3. LinkedIn Profile Targeting Setup

**User Request**: "We sell HR software to mid-market companies. Help me set up LinkedIn Profile Targeting on Microsoft Ads."

**Analysis Steps**:
1. Define ideal customer profile — company size, industry, job functions that match HR software buyers
2. Design targeting layers — which LinkedIn dimensions to combine, bid adjustment strategy
3. Recommend campaign structure — whether to create dedicated campaigns or layer onto existing
4. Set bid adjustments — starting multipliers for each LinkedIn audience segment
5. Plan measurement — how to isolate and measure LinkedIn targeting performance

**Sample Output**:

### LinkedIn Profile Targeting Strategy

**Target Audience**: HR decision-makers at mid-market companies (200-5,000 employees)

### Recommended Targeting Layers

| Layer | Targeting | Bid Adjustment | Rationale |
|-------|-----------|---------------|-----------|
| Job Function: Human Resources | +40% | Primary buyers |
| Job Function: Management | +20% | Budget holders |
| Industry: Technology | +30% | Fastest sales cycle |
| Industry: Professional Services | +25% | High close rate |
| Industry: Healthcare | +15% | Growing segment |
| Company: [Named accounts] | +60% | ABM targets |

### Campaign Structure

**Option A (Recommended): Layer on existing Search campaigns**
```
Non-Brand Search — HR Software
├── Keywords: hr software, hris platform, employee management system
├── LinkedIn Layer: Job Function = Human Resources (+40%)
├── LinkedIn Layer: Job Function = Management (+20%)
└── LinkedIn Layer: Industry = Technology (+30%)
```
This lets you bid higher when the searcher matches your ICP without restricting reach.

**Option B: Dedicated LinkedIn-targeted campaign**
```
LinkedIn — HR Decision Makers (Search)
├── Target: Job Function = Human Resources AND Industry = Technology
├── Target: Job Function = Human Resources AND Industry = Professional Services
└── Budget: $30/day (test for 2-4 weeks)
```
Use this for ABM-style campaigns targeting specific companies.

### Setup Steps

1. Navigate to Campaign > Audiences > LinkedIn Profile Targeting
2. Add Job Function = "Human Resources" at observation level with +40% bid
3. Add Industry segments at observation level with respective bid adjustments
4. For named accounts: add Company targeting for your top 50 target accounts at +60%
5. Run for 2 weeks, then analyze: compare conversion rates for LinkedIn-matched vs unmatched clicks
6. Adjust bids based on CPA differential — if LinkedIn-matched users convert at 2x, increase bid adjustments accordingly

### Expected Impact

| Metric | Before LinkedIn Targeting | After (estimated) |
|--------|--------------------------|-------------------|
| Avg CPC | $2.85 | $3.40 (+19%) |
| Conversion Rate | 3.2% | 4.8% (+50%) |
| CPA | $89 | $71 (-20%) |
| Lead Quality (SQL rate) | 22% | 35% (+59%) |

The CPC increase is offset by significantly higher conversion rates and lead quality. LinkedIn-matched clicks typically cost more but convert at 1.5-2x the rate.

---

## 4. UET Tracking & Conversion Goals

**User Request**: "We need to set up conversion tracking for our Microsoft Ads account. We have a SaaS product with free trial signups and demo requests."

**Analysis Steps**:
1. Audit current UET tag status — is the base tag installed, firing on all pages, validated
2. Define conversion goals — map business outcomes to Microsoft Ads goal types
3. Configure event tracking — custom events for trial signup, demo request, and micro-conversions
4. Set up offline conversion import for CRM-sourced conversions (trial-to-paid)
5. Recommend attribution model based on sales cycle length

**Sample Output**:

### UET Implementation Review

| Check | Status | Action |
|-------|--------|--------|
| UET base tag installed | Not found | Install on all pages |
| Tag fires on page load | N/A | Verify after install |
| Auto-SPA tracking enabled | N/A | Enable for React/SPA sites |
| Microsoft Clarity linked | No | Link for free session recordings |
| Auto-tagging (msclkid) | Disabled | Enable in account settings |

### Conversion Goals to Create

| Goal | Type | Value | Counting | Priority |
|------|------|-------|----------|----------|
| Free Trial Signup | Event | $50 | Unique | Primary |
| Demo Request | Event | $150 | Unique | Primary |
| Pricing Page View | URL | $5 | Unique | Secondary |
| Blog Engagement (>3 min) | Duration | $2 | Unique | Observation |
| Trial-to-Paid | Offline Import | $2,400 | Unique | Primary |

### Event Tracking Code

```javascript
// Free trial signup (fire on form submission success)
window.uetq = window.uetq || [];
window.uetq.push('event', 'free_trial_signup', {
  'revenue_value': 50,
  'currency': 'USD'
});

// Demo request (fire on demo form submission)
window.uetq.push('event', 'demo_request', {
  'revenue_value': 150,
  'currency': 'USD'
});

// Pricing page view (fire on pricing page load)
window.uetq.push('event', 'pricing_page_view', {
  'revenue_value': 5,
  'currency': 'USD'
});
```

### Offline Conversion Import (Trial-to-Paid)

For tracking the full funnel from ad click to paid subscription:

1. Capture `msclkid` parameter on trial signup (append to CRM record)
2. When trial converts to paid, export CSV:
   ```
   Microsoft Click ID,Conversion Name,Conversion Time,Conversion Value,Conversion Currency
   abc123def...,Trial to Paid,2026-02-15 14:30:00,2400.00,USD
   ```
3. Upload weekly via Microsoft Ads UI > Conversions > Import
4. For automation: use the Bing Ads API `AddOfflineConversions` endpoint

### Attribution Model Recommendation

Given a 14-21 day average sales cycle for SaaS free trials:
- **Use "Linear" attribution** — distributes credit across all touchpoints
- Avoid "Last click" — it undervalues upper-funnel Microsoft Audience Network campaigns
- Review attribution in 30 days with enough conversion data, then test "Position-based" (40/20/40)

---

## 5. Shopping Campaign Setup

**User Request**: "We're launching Shopping campaigns on Microsoft. We already have Google Shopping running. We have about 2,000 SKUs across 8 product categories."

**Analysis Steps**:
1. Verify Microsoft Merchant Center setup — feed status, product approval rates, data quality
2. Design campaign structure — priority-based strategy for 2,000 SKUs across categories
3. Set bidding strategy — starting bids based on Google Shopping performance (adjusted for Microsoft's lower CPCs)
4. Configure product group segmentation — subdivision logic by category, brand, margin
5. Plan negative keyword strategy for Shopping (competitor brands, irrelevant queries)

**Sample Output**:

### Merchant Center Status

| Check | Status | Notes |
|-------|--------|-------|
| Feed uploaded | Pending | Submit via URL fetch or manual upload |
| Products approved | — | Expect 85-95% approval on first submission |
| Feed schedule | Not set | Set daily auto-fetch at 4 AM |
| Feed format | Google-compatible | Microsoft accepts Google feed format with minor field differences |
| Shipping configured | No | Must configure in Microsoft Merchant Center (does not import from Google) |
| Tax settings | No | Set state-level tax rules |

### Campaign Structure (3-tier priority)

```
Shopping — Priority High ($40/day)
├── Top 50 SKUs by margin (manually selected)
├── Bid: $0.55 avg (40% below Google Shopping bids)
└── Negative keywords: category-level terms (forces non-top SKUs to Medium)

Shopping — Priority Medium ($60/day)
├── Product Groups by Category
│   ├── Electronics (142 SKUs) — Bid: $0.42
│   ├── Outdoor Gear (287 SKUs) — Bid: $0.38
│   ├── Home & Kitchen (340 SKUs) — Bid: $0.31
│   ├── Fitness Equipment (198 SKUs) — Bid: $0.44
│   ├── Clothing (412 SKUs) — Bid: $0.28
│   ├── Accessories (289 SKUs) — Bid: $0.25
│   ├── Pet Supplies (178 SKUs) — Bid: $0.33
│   └── Seasonal (154 SKUs) — Bid: $0.22
└── Negative keywords: specific product names (forces to Low catch-all)

Shopping — Priority Low ($25/day)
├── All Products (catch-all)
├── Bid: $0.18 avg
└── No negative keywords — catches everything the other campaigns don't
```

### Starting Bids (Microsoft vs Google comparison)

| Category | Google CPC | Microsoft CPC (est.) | Starting Bid |
|----------|-----------|---------------------|-------------|
| Electronics | $0.89 | $0.58 | $0.42 |
| Outdoor Gear | $0.74 | $0.48 | $0.38 |
| Home & Kitchen | $0.61 | $0.40 | $0.31 |
| Fitness Equipment | $0.82 | $0.53 | $0.44 |
| Clothing | $0.55 | $0.36 | $0.28 |
| Accessories | $0.48 | $0.31 | $0.25 |
| Pet Supplies | $0.63 | $0.41 | $0.33 |
| Seasonal | $0.44 | $0.29 | $0.22 |

*Microsoft Shopping CPCs typically run 30-40% below Google. Starting bids set at ~75% of estimated CPC to ramp conservatively.*

### Recommendations

1. **Feed quality**: Add `custom_label_0` for margin tiers (high/medium/low) — enables bid segmentation by profitability
2. **Promotions**: Use Merchant Promotions to show sale badges (higher CTR than Google promotions in Microsoft's less crowded SERP)
3. **Local inventory**: If you have physical stores, enable Local Inventory Ads for in-store pickup queries
4. **LinkedIn layer**: Add LinkedIn Industry targeting to Shopping for B2B product categories (office equipment, bulk orders)
5. **Monitor search partners**: DuckDuckGo Shopping results can drive strong performance — check network segmentation weekly

---

## 6. Keyword & Search Term Analysis

**User Request**: "Our Microsoft Ads search campaigns are spending $8K/month but CPA has crept up from $45 to $72 over the last quarter. Help me diagnose the keyword and search term health."

**Analysis Steps**:
1. Analyze match type distribution — ratio of broad/phrase/exact and spend allocation per type
2. Review quality scores — distribution across keywords, identify sub-6 scores dragging performance
3. Pull search term report — calculate relevance rate, identify negative keyword gaps
4. Identify wasted spend — keywords and search terms with spend but zero/low conversions
5. Find expansion opportunities — high-converting search terms not yet added as keywords

**Sample Output**:

### Match Type Analysis (Last 90 Days)

| Match Type | Keywords | Spend | Conversions | CPA | CTR |
|------------|----------|-------|-------------|-----|-----|
| Broad | 342 | $4,120 (51%) | 38 | $108.42 | 2.1% |
| Phrase | 189 | $2,480 (31%) | 52 | $47.69 | 4.3% |
| Exact | 87 | $1,400 (18%) | 41 | $34.15 | 5.8% |
| **Total** | **618** | **$8,000** | **131** | **$61.07** | **3.2%** |

**Problem identified**: Broad match is consuming 51% of budget but delivering 29% of conversions at 3x the CPA of exact match.

### Quality Score Distribution

| Quality Score | Keywords | % of Spend | Avg CPA |
|---------------|----------|-----------|---------|
| 9-10 | 34 | 12% | $28.40 |
| 7-8 | 187 | 41% | $42.15 |
| 5-6 | 244 | 33% | $78.90 |
| 1-4 | 153 | 14% | $142.60 |

**153 keywords with QS 1-4 are consuming 14% of spend at $142.60 CPA** — these need immediate attention (pause or fix landing page/ad relevance).

### Search Term Relevance (Last 30 Days)

| Category | Search Terms | Spend | Action |
|----------|-------------|-------|--------|
| Highly relevant | 412 (58%) | $4,640 | Keep |
| Somewhat relevant | 156 (22%) | $1,760 | Monitor |
| Irrelevant | 143 (20%) | $1,600 | Add as negatives |

**$1,600/month (20% of budget) is going to irrelevant search terms.** Top offenders:

| Irrelevant Search Term | Spend (30d) | Clicks | Conv | Add as Negative |
|----------------------|-------------|--------|------|----------------|
| [competitor name] free trial | $187 | 42 | 0 | Exact |
| how to [product category] DIY | $143 | 38 | 0 | Phrase |
| [product] jobs hiring | $128 | 31 | 0 | Broad |
| [product] reviews reddit | $112 | 29 | 0 | Phrase |
| free [product] download | $98 | 26 | 0 | Broad |

### Recommended Actions

**Immediate (save ~$2,400/month)**:
1. Add the 143 irrelevant search terms as negative keywords (create 3 themed negative lists: competitors, informational, jobs/free)
2. Pause 153 keywords with QS 1-4 (save $1,120/month, lose only 3 conversions)
3. Shift $2,000 from broad match to phrase/exact versions of top converters

**This week**:
4. Promote 23 high-converting search terms to exact match keywords (these are converting through broad/phrase but don't have dedicated exact match entries)
5. Review landing pages for the 244 keywords with QS 5-6 — ad relevance and landing page experience are the fixable components

**Expected impact**: CPA reduction from $72 back to $48-52 range within 30 days.

---

## 7. Performance Max on Microsoft

**User Request**: "We're considering Performance Max on Microsoft. We already run PMax on Google. What's different and how should we set it up?"

**Analysis Steps**:
1. Compare Microsoft PMax vs Google PMax — feature parity, maturity gaps, network differences
2. Design asset group structure — adapt Google PMax learnings for Microsoft's network
3. Configure audience signals — leverage LinkedIn Profile Targeting (Microsoft-exclusive advantage)
4. Set URL expansion and final URL rules — control where traffic lands
5. Plan budget and timeline — ramp strategy given Microsoft PMax's smaller data pool

**Sample Output**:

### Microsoft PMax vs Google PMax

| Feature | Google PMax | Microsoft PMax |
|---------|------------|----------------|
| Maturity | 3+ years, well-established | Newer, still evolving |
| Networks | Search, Shopping, Display, YouTube, Gmail, Discover, Maps | Search, Shopping, Audience Network (MSN, Outlook, Edge) |
| Video placements | YouTube (massive reach) | Limited video inventory |
| Audience signals | Custom segments, your data | LinkedIn Profile Targeting + standard |
| Asset group reporting | Basic (improving) | Basic |
| Search term visibility | Very limited | Slightly more transparent |
| Conversion data needs | 30+ conversions/month recommended | 50+ recommended (smaller network = slower learning) |
| URL expansion | Aggressive by default | Similar, but check settings |

### Recommended Asset Group Structure

Based on your Google PMax setup (3 asset groups), adapt for Microsoft:

```
Microsoft PMax Campaign ($50/day starting)
├── Asset Group 1: Core Products
│   ├── 15 headlines (adapt top Google performers)
│   ├── 5 long headlines
│   ├── 5 descriptions
│   ├── 20 images (landscape + square)
│   ├── Audience signal: In-market + LinkedIn (Industry: Technology, Job Function: IT)
│   └── Final URL: /products/
├── Asset Group 2: Solutions by Use Case
│   ├── 15 headlines (use-case focused)
│   ├── 5 long headlines
│   ├── 5 descriptions
│   ├── 20 images
│   ├── Audience signal: Custom (competitor URLs) + LinkedIn (Job Function: Management)
│   └── Final URL: /solutions/
└── Asset Group 3: Brand + Retargeting
    ├── 15 headlines (brand-focused)
    ├── 5 long headlines
    ├── 5 descriptions
    ├── 20 images (brand lifestyle)
    ├── Audience signal: Remarketing lists + Customer Match
    └── Final URL: /
```

### LinkedIn Audience Signals (Microsoft-exclusive advantage)

This is where Microsoft PMax can outperform Google PMax for B2B:

| Signal | Targeting | Expected Impact |
|--------|-----------|----------------|
| Job Function: IT Decision Makers | Prioritize tech buyers | +25% conversion rate vs generic |
| Industry: Financial Services | Prioritize finance vertical | +18% conversion rate |
| Company: Fortune 500 | Enterprise ABM signal | +40% lead quality |

*Audience signals are suggestions, not hard targeting — but Microsoft's algorithm heavily weights them, especially LinkedIn signals.*

### Budget & Ramp Plan

| Week | Daily Budget | Goal |
|------|-------------|------|
| 1-2 | $30/day | Learning phase — let the algorithm explore |
| 3-4 | $50/day | Evaluate early signals, adjust audience signals |
| 5-6 | $75/day | Scale if CPA within 20% of target |
| 7-8 | $100/day | Full optimization, compare to Google PMax |

**Key difference from Google**: Microsoft PMax needs a longer learning phase because of lower search volume. Expect 3-4 weeks before meaningful optimization signals vs 1-2 weeks on Google.

### Recommendations

1. **Do NOT just import Google PMax** — the import support is limited and often creates broken campaigns. Build natively on Microsoft
2. **Start with 1-2 asset groups** max. Microsoft's smaller data pool means splitting too thin will slow learning
3. **Use LinkedIn signals aggressively** — this is your competitive advantage over Google PMax. Layer company, industry, and job function signals
4. **Monitor URL expansion** — turn it OFF initially to maintain landing page control, then selectively enable after 30 days
5. **Expect 30-40% lower CPCs** but longer learning cycles. Net result: similar or better CPA to Google PMax once optimized

---

## Common Analysis Patterns

### Account Health Check
```
For each campaign:
1. Impression share (target >60%)
2. Quality score distribution (flag <6)
3. Search term relevance (flag <70% relevant)
4. Budget lost IS vs Rank lost IS
5. LinkedIn targeting utilization
```

### Keyword Expansion Template
```
1. Pull search term report (last 90 days)
2. Filter: conversions >= 1, not already a keyword
3. Sort by conversion rate descending
4. Add top terms as exact match keywords
5. Create phrase match for high-volume terms
```

### Audience Audit Template
```
1. List all applied audiences (targeting + observation)
2. Check LinkedIn Profile Targeting on all Search/Shopping campaigns
3. Verify remarketing list sizes (minimum 1,000 for Search, 300 for Audience)
4. Review bid adjustments by audience segment
5. Identify missing in-market categories
```

### Budget Reallocation Template
```
1. Rank campaigns by CPA (ascending)
2. Identify campaigns limited by budget with CPA below target
3. Identify campaigns with CPA 2x+ above target
4. Shift budget from high-CPA to low-CPA campaigns
5. Reallocate at least 10% of total budget per cycle
```

---

## Pro Tips

| Instead of... | Ask... |
|---------------|--------|
| "How's my Microsoft Ads account doing?" | "Audit my Microsoft Ads account — focus on keyword waste, audience gaps, and the top 3 budget reallocation moves." |
| "Set up LinkedIn targeting" | "I sell B2B SaaS to HR leaders at mid-market companies. Design a LinkedIn Profile Targeting strategy with bid adjustments and measurement plan." |
| "Fix my quality scores" | "I have 153 keywords with quality score below 6 spending $1,100/month. Diagnose whether the issue is ad relevance, landing page, or expected CTR — and prioritize the fixes by spend." |
| "Import my Google Ads" | "I just imported Google Ads into Microsoft. Walk me through the post-import checklist: what broke, what's missing, and what Microsoft-specific features should I add." |
| "Help with Shopping campaigns" | "I have 2,000 SKUs across 8 categories with varying margins. Design a 3-tier priority Shopping structure with starting bids benchmarked against my Google Shopping CPCs." |

---

## 8. Scored Account Audit (Health Score)

**User Request:**
> "Score my Microsoft Ads account. We imported from Google 3 months ago but haven't optimized it."

**Analysis Steps:**
1. Load `skills/shared/scoring-system.md` for scoring algorithm and `CHECKS.md` for the 30-check audit
2. Evaluate each applicable check as PASS, WARNING, or FAIL based on account data
3. Calculate category scores using severity multipliers and category weights
4. Identify Quick Wins (Critical/High severity, ≤15 min fix time)
5. Produce health score, grade, and prioritized action plan

**Sample Output:**

## Account Health Score: 58/100 (Grade D — Poor)

### Quick Wins (fix in ≤15 min, high impact)
1. **[Critical]** Enable MSCLKID auto-tagging — MS-TE2 (2 min)
2. **[Critical]** Exclude syndication from brand campaigns — MS-SB1 (2 min)
3. **[High]** Exclude underperforming search partners — MS-SB2 (5 min)
4. **[High]** Add Microsoft-specific negative keywords — MS-SP3 (10 min)
5. **[High]** Enable LinkedIn Profile Targeting — MS-SA1 (10 min)

### Category Breakdown

| Category | Weight | Score | Grade | Top Issue |
|----------|--------|-------|-------|-----------|
| Technical Setup | 25% | 62 | C | Auto-tagging disabled, no Clarity |
| Syndication & Bidding | 20% | 45 | D | Brand on syndication network |
| Structure & Audience | 20% | 55 | D | No LinkedIn targeting, no remarketing |
| Creative & Extensions | 20% | 68 | C | No Multimedia Ads, missing Action Extensions |
| Settings & Performance | 15% | 52 | D | CPCs same as Google (no advantage captured) |

### Prioritized Action Plan

**Immediate (This Week)**
1. Enable MSCLKID auto-tagging
2. Exclude syndication partners from all brand campaigns
3. Review Microsoft-specific search terms and add negatives
4. Exclude underperforming search partners

**This Month**
5. Enable LinkedIn Profile Targeting for B2B campaigns
6. Set up UET-based remarketing lists
7. Install Microsoft Clarity for behavioral analysis
8. Test Multimedia Ads format on top campaigns
9. Add Action Extensions and Filter Link Extensions

**Next Quarter**
10. Set up Microsoft Merchant Center (separate from Google)
11. Build Microsoft-specific campaign structure (not just Google mirror)
12. Implement Enhanced Conversions
