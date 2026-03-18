# Cross-Platform Audit Reference

## Budget Allocation Benchmarks

### Platform Mix by Business Type

| Business Type | Google Ads | Meta Ads | Microsoft Ads | Notes |
|--------------|-----------|---------|--------------|-------|
| E-commerce/DTC | 40-50% | 35-45% | 5-10% | Shopping/PMax + Meta creative-driven prospecting |
| SaaS/B2B | 35-45% | 15-25% | 10-15% | Search intent + LinkedIn targeting via Microsoft |
| Local Service | 50-70% | 20-30% | 5-15% | Google Search + Maps dominance |
| Lead Gen | 30-40% | 40-50% | 5-10% | Meta lead forms + Google high-intent search |
| Agency (multi-client) | Varies | Varies | Varies | Allocate per client vertical |

### Minimum Viable Spend by Platform

| Platform | Minimum Monthly | Recommended Monthly | Why |
|----------|----------------|-------------------|-----|
| Google Ads (Search) | $3,000 | $5,000+ | Need ≥15 conversions/month for Smart Bidding |
| Google Ads (PMax) | $3,000 | $10,000+ | PMax needs volume across all channels |
| Meta Ads | $3,000 | $5,000+ | Need ≥50 conversions/week for learning phase |
| Microsoft Ads | $1,500 | $3,000+ | Lower CPCs but still needs conversion volume |

If a platform is below minimum viable spend, recommend consolidating to fewer platforms rather than spreading thin.

## Attribution and Tracking Consistency

### Recommended Attribution Setup

| Platform | Attribution Window | Attribution Model | Source of Truth |
|----------|-------------------|-------------------|-----------------|
| Google Ads | 30-day click (Search), 30-day click (PMax) | Data-driven | GA4 for cross-platform |
| Meta Ads | 7-day click / 1-day view | Last touch (platform) | GA4 for cross-platform |
| Microsoft Ads | 30-day click | Last click | GA4 for cross-platform |
| GA4 | N/A | Data-driven cross-channel | Primary source of truth |

### Attribution Overlap Indicators

| Platform-Reported vs GA4 | Status | Likely Cause |
|--------------------------|--------|-------------|
| Within 10% | Healthy | Normal attribution differences |
| 10-20% over | Moderate | View-through or cross-device overlap |
| 20-40% over | High | Multiple platforms claiming same conversions |
| 40%+ over | Critical | No deduplication, broken tracking, or misconfigured events |

### UTM Requirements for Cross-Platform Deduplication

All platforms must use consistent UTM parameters for GA4 to arbitrate attribution:

```
utm_source: google | meta | microsoft
utm_medium: cpc | paid-social | cpc
utm_campaign: {campaign_name}
utm_content: {ad_id} or {creative_name}
utm_term: {keyword} (search only)
```

## Cross-Platform Performance Benchmarks

### CPA Comparison by Vertical (2025-2026)

| Vertical | Google Search | Meta (Purchase) | Microsoft Search | Notes |
|----------|-------------|----------------|-----------------|-------|
| E-commerce (avg) | $45-65 | $30-50 | $35-55 | Meta typically lower CPA for DTC |
| SaaS (trial/demo) | $80-150 | $100-200 | $60-120 | Microsoft often cheapest for B2B |
| Lead Gen | $40-80 | $25-50 | $30-60 | Meta strongest for volume |
| Local Service | $30-60 | $35-70 | $25-50 | Google dominates intent |

### ROAS Comparison by Vertical

| Vertical | Google Shopping/PMax | Meta (DTC) | Microsoft Shopping | Notes |
|----------|---------------------|-----------|-------------------|-------|
| E-commerce (avg) | 4-6x | 3-5x | 3-5x | Google Shopping typically highest ROAS |
| E-commerce (premium) | 6-10x | 5-8x | 5-8x | Brand strength drives higher returns |
| E-commerce (commoditized) | 2-4x | 2-3x | 2-4x | Price competition compresses margins |

## Budget Reallocation Framework

### When to Shift Budget Between Platforms

| Signal | Action |
|--------|--------|
| Platform A: CPA below target, budget constrained | Increase budget on Platform A |
| Platform B: CPA >2x target, not improving for 30 days | Reduce budget on Platform B |
| Platform C: CPA at target, but below minimum viable spend | Either increase to viable threshold or consolidate out |
| New platform not tested | Allocate 10-15% of total budget for 60-day test |

### Reallocation Rules

1. **Never reallocate more than 25% of a platform's budget in one week** — dramatic shifts reset learning phases
2. **Reallocate from waste first** — use Kill List spending before cutting working campaigns
3. **Account for platform minimums** — don't reduce a platform below its minimum viable spend unless fully exiting
4. **Monitor for 14 days** after reallocation before making further changes
5. **Keep a testing budget** — 10-15% of total should fund platform/audience/creative experiments

## Cross-Platform Creative Alignment

### Messaging Consistency Checks

| Element | Should Match Across Platforms | Platform-Specific Adaptation |
|---------|-------------------------------|------------------------------|
| Value proposition | Yes — core message must be consistent | Tone can adapt (professional on Search, casual on social) |
| Offer/promotion | Yes — same offer across platforms | Format adapts (text on Search, visual on Meta) |
| Landing pages | Yes — consistent post-click experience | Can use platform-specific UTMs for tracking |
| Brand voice | Yes — recognizable across touchpoints | Length and format adapt per platform norms |
| Creative refresh cadence | No — platform-specific | Meta: every 30-45 days. Search: every 90 days. Microsoft: mirrors Google |

### Format Requirements by Platform

| Platform | Primary Formats | Aspect Ratios | Key Constraint |
|----------|----------------|---------------|----------------|
| Google Search | Text (RSA) | N/A | 30-char headlines, 90-char descriptions |
| Google PMax | Image + Video + Text | 1.91:1, 1:1, 4:5 | Need all asset types for full coverage |
| Meta Feed | Image, Video, Carousel | 1:1, 4:5 | Creative = targeting post-iOS14 |
| Meta Reels/Stories | Video | 9:16 | Sound-on, hook in first 3 seconds |
| Microsoft Search | Text (RSA) + Multimedia | N/A | Multimedia Ads = unique rich format |
| Microsoft Audience | Image | 1.91:1, 1:1 | Smaller inventory than Google Display |

## Kill List Criteria

### Universal Thresholds (Apply Across All Platforms)

| Metric | Threshold | Action |
|--------|-----------|--------|
| CPA >3x target | Kill or restructure | Pause campaign, investigate root cause |
| CPA >2x target for 30+ days | Warning — on watch | Review targeting, creative, landing page |
| $0 conversions with >$500 spend | Kill | Pause immediately, reallocate budget |
| CTR <50% of platform benchmark | Investigate | Creative or targeting issue |
| Frequency >5 (social) | Creative fatigue | Refresh creative or expand audience |

### Waste Aggregation

Total monthly waste across all platforms:
```
Total Waste = Σ(monthly spend on campaigns flagged as Kill List)
Waste % = Total Waste / Total Ad Spend × 100
```

| Waste % | Assessment |
|---------|------------|
| <5% | Healthy — normal optimization overhead |
| 5-15% | Moderate — addressable with regular hygiene |
| 15-30% | High — significant budget leak, immediate action needed |
| >30% | Critical — structural problems, possible tracking issues |
