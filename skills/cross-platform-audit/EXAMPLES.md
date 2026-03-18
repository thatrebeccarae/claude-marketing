# Cross-Platform Audit — Examples

## 1. Full Multi-Platform Scored Audit

**User Request:**
> "I spend $20K/month on Google, $15K/month on Meta, and $5K/month on Microsoft. Run a full cross-platform audit and give me a unified health score. We're a DTC e-commerce brand doing about $150K/month in revenue from paid."

**Analysis Steps:**
1. Collect context: DTC e-commerce, $40K/month total, 50% Google / 37.5% Meta / 12.5% Microsoft, revenue goal
2. Spawn 3 parallel audit tasks (Google 74 checks, Meta 46 checks, Microsoft 30 checks)
3. Each task evaluates checks, calculates platform score, identifies Quick Wins
4. Merge results: budget-weighted aggregate, cross-platform analysis, unified action plan

**Sample Output:**

# Cross-Platform Audit — DTC E-commerce — 2026-03-16

## Aggregate Health Score: 68/100 (Grade C — Needs Improvement)

| Platform | Budget | Share | Score | Grade | Top Issue |
|----------|--------|-------|-------|-------|-----------|
| Google Ads | $20,000/mo | 50% | 72 | C | Enhanced Conversions inactive, PMax brand cannibalization |
| Meta Ads | $15,000/mo | 37.5% | 65 | C | No CAPI, creative fatigue on 3 ad sets |
| Microsoft Ads | $5,000/mo | 12.5% | 58 | D | Raw Google import, no Microsoft-specific optimization |

```
Aggregate = (72 × 0.50) + (65 × 0.375) + (58 × 0.125) = 36.0 + 24.4 + 7.3 = 67.6 → 68
```

## Quick Wins (All Platforms — Fix This Week)

| # | Platform | Check | Fix | Impact | Time |
|---|----------|-------|-----|--------|------|
| 1 | Meta | M-PX2 | Deploy CAPI via Gateway | Critical — 30-40% data loss without it | 15 min |
| 2 | Google | G-CT2 | Enable Enhanced Conversions | Critical — missing conversion data | 5 min |
| 3 | Microsoft | MS-TE2 | Enable MSCLKID auto-tagging | Critical — breaks all tracking | 2 min |
| 4 | Microsoft | MS-SB1 | Exclude brand syndication | Critical — low-quality brand traffic | 2 min |
| 5 | Google | G-WS2 | Create negative keyword lists | Critical — 14% irrelevant spend | 10 min |
| 6 | Google | G-ST7 | Add brand exclusions to PMax | High — 28% PMax from brand terms | 5 min |
| 7 | Meta | M-PX9 | Set 7-day click / 1-day view | High — attribution misconfigured | 2 min |
| 8 | Microsoft | MS-SP3 | Add Microsoft-specific negatives | High — relying on Google import only | 10 min |

## Cross-Platform Analysis

### Budget Allocation
- **Current split**: Google 50% / Meta 37.5% / Microsoft 12.5%
- **Recommended for DTC**: Google 40-50% / Meta 35-45% / Microsoft 5-10%
- **Finding**: Split is reasonable. However, Google Search campaigns are budget-constrained (top performers hitting cap by 2 PM) while Microsoft has $1,200/month on underperforming syndication. **Reallocate $800/month from Microsoft syndication waste to Google Search.**

### Tracking Consistency
- **Google**: Enhanced Conversions OFF — estimated 15-20% data loss on Google
- **Meta**: No CAPI — estimated 30-40% data loss on Meta
- **Microsoft**: MSCLKID disabled — all conversion data unreliable
- **GA4**: Linked to Google only, not receiving Meta or Microsoft data
- **Assessment**: Tracking is the #1 priority. No optimization recommendations are reliable until tracking is fixed on all 3 platforms. **Fix tracking first, then re-audit in 30 days.**

### Creative Alignment
- **Google**: RSA headlines are product-focused ("Shop Running Shoes"), PMax uses generic lifestyle images
- **Meta**: Feed ads use benefit-driven copy ("Run Faster, Recover Quicker"), but 3 of 5 creatives are stale (CTR declining 25% over 14 days)
- **Microsoft**: Identical RSAs to Google (raw import) — not optimized for Microsoft's audience
- **Assessment**: Messaging is inconsistent between Google (product-focused) and Meta (benefit-focused). Align on core value proposition. Meta creative needs immediate refresh.

### Attribution Overlap
- **Platforms report**: Google 420 purchases + Meta 380 purchases + Microsoft 45 purchases = 845/month
- **GA4 reports**: 620 purchases/month
- **Overlap**: 36% over-reporting (845 vs 620)
- **Assessment**: High overlap — platforms are double-counting ~225 conversions/month. Need UTM parameter consistency and GA4 as single source of truth. Current ROAS calculations on individual platforms are inflated.

### Kill List
| Platform | Campaign | Monthly Spend | CPA | Target CPA | Multiplier | Action |
|----------|----------|--------------|-----|-----------|-----------|--------|
| Google | NB - Generic Keywords | $2,800 | $142 | $45 | 3.2x | Pause — restructure targeting |
| Meta | Prospecting - Interest Fitness | $1,400 | $98 | $30 | 3.3x | Pause — audience exhausted |
| Microsoft | Syndication (all) | $1,200 | N/A | N/A | N/A | Exclude — low-quality traffic |
| **Total Waste** | | **$5,400/mo** | | | **13.5% of spend** | |

### Scaling Opportunities
| Platform | Campaign | Monthly Spend | CPA | Target CPA | Headroom | Recommendation |
|----------|----------|--------------|-----|-----------|----------|----------------|
| Google | Brand Search | $4,200 | $13 | $45 | Budget-capped at 2 PM | Increase budget $1,500/mo |
| Google | Shopping - Top SKUs | $8,100 | $42 | $45 | Impression share 62% | Increase budget $2,000/mo |
| Meta | Advantage+ Shopping | $7,200 | $28 | $30 | 92% budget utilized | Increase budget $1,500/mo |

**Net reallocation**: Cut $5,400 waste → Reinvest $5,000 in winners = $400/mo savings + better performance

## Prioritized Action Plan

### Phase 1: Fix Tracking (Week 1)
1. Deploy Meta CAPI via Gateway
2. Enable Google Enhanced Conversions
3. Enable Microsoft MSCLKID auto-tagging
4. Set up consistent UTM parameters across all platforms
5. Link GA4 to Meta and Microsoft for unified reporting
**Expected impact**: Accurate data across all platforms within 7 days

### Phase 2: Stop the Bleeding (Week 2)
6. Pause Kill List campaigns ($5,400/mo waste eliminated)
7. Exclude Microsoft syndication partners from brand campaigns
8. Create and apply Google negative keyword lists
9. Add brand exclusions to Google PMax
10. Set Meta attribution to 7-day click / 1-day view
**Expected impact**: $5,400/mo waste eliminated, brand cannibalization stopped

### Phase 3: Reallocate and Scale (Week 3-4)
11. Increase Google Brand Search budget by $1,500/mo
12. Increase Google Shopping - Top SKUs budget by $2,000/mo
13. Increase Meta Advantage+ Shopping budget by $1,500/mo
14. Refresh stale Meta creatives (3 ad sets with fatigue)
15. Optimize Microsoft Ads beyond Google import (new negatives, LinkedIn targeting, bid adjustments)
**Expected impact**: 15-25% CPA improvement as budget shifts from waste to winners

### Phase 4: Re-Audit (Day 30)
16. Re-run cross-platform audit after tracking fixes have 30 days of clean data
17. Recalculate health scores with accurate conversion data
18. Adjust budget allocation based on true platform CPA (not inflated by attribution overlap)

## Expected Outcomes (90-Day Projection)

| Metric | Current | Projected | Change |
|--------|---------|-----------|--------|
| Aggregate Health Score | 68 (C) | 80+ (B) | +12 points |
| Monthly Waste | $5,400 (13.5%) | <$2,000 (<5%) | -$3,400/mo |
| Blended CPA | $58 (reported) / ~$65 (actual) | $45-50 (actual) | -23% to -31% |
| Monthly Conversions (GA4) | 620 | 720-780 | +16% to +26% |

---

## 2. Two-Platform Audit (Google + Meta)

**User Request:**
> "Audit my Google and Meta accounts. $30K/month on Google, $20K on Meta. SaaS company, goal is demo requests."

**Analysis Steps:**
1. Context: SaaS B2B, $50K/month, 60% Google / 40% Meta, lead gen goal
2. Spawn 2 parallel audit tasks (Google + Meta only)
3. Merge with budget-weighted aggregate
4. Cross-platform analysis focused on lead gen attribution

*[Output follows same format as Example 1, with 2 platforms instead of 3]*

---

## 3. Audit with Deck Generation

**User Request:**
> "Run a full paid media audit and build me a deck I can present to my client. They're on Google and Meta, spending $60K/month total on DTC."

**Analysis Steps:**
1. Run standard cross-platform audit (Example 1 format)
2. After unified report is generated, invoke pro-deck-builder skill
3. Generate branded HTML slide deck with:
   - Title slide with aggregate score
   - Executive summary (aggregate score, top 3 findings, estimated waste)
   - Per-platform score cards (1 slide each)
   - Cross-platform analysis (budget, tracking, creative, attribution)
   - Quick Wins slide
   - Kill List + Scaling Opportunities
   - Prioritized 90-day action plan
   - Expected outcomes with projected metrics

**Deck invocation:**
> "Pipe this audit to pro-deck-builder. Use dark cover slide, warm cream content slides. Include the aggregate score prominently on the title slide."

*[Audit output feeds directly into pro-deck-builder, which generates the HTML deck]*
