# Meta Ads Audit Checklist

<!-- Total Checks: 46 | Categories: 4 | See skills/shared/scoring-system.md for weights and algorithm -->

## Quick Reference

| Category | Weight | Checks |
|----------|--------|--------|
| Pixel / CAPI Health | 30% | M-PX1 through M-PX10 (10 checks) |
| Creative Diversity & Fatigue | 30% | M-CR1 through M-CR12 (12 checks) |
| Account Structure | 20% | M-ST1 through M-ST18 (18 checks) |
| Audience & Targeting | 20% | M-AU1 through M-AU6 (6 checks) |

---

## Pixel / CAPI Health (Weight: 30%)

### M-PX1: Meta Pixel Installed [Critical, 5.0]
- **Check:** Meta Pixel firing on all pages
- **Pass:** Pixel firing on all pages (verified in Events Manager)
- **Warning:** Firing on most pages (>90%)
- **Fail:** Pixel not firing
- **Quick Win:** No

### M-PX2: Conversions API (CAPI) Active [Critical, 5.0]
- **Check:** Server-side events sending alongside pixel events
- **Pass:** CAPI active with events flowing
- **Warning:** CAPI planned but not yet deployed
- **Fail:** No CAPI (30-40% data loss post-iOS 14.5)
- **Quick Win:** Yes (15 min via CAPI Gateway)

### M-PX3: Event Deduplication [Critical, 5.0]
- **Check:** event_id matching between pixel and CAPI events to prevent double-counting
- **Pass:** event_id matching active, ≥90% deduplication rate
- **Warning:** event_id present but <90% deduplication rate
- **Fail:** Missing event_id (double-counting conversions)
- **Quick Win:** No

### M-PX4: Event Match Quality (EMQ) [Critical, 5.0]
- **Check:** EMQ score for primary conversion event (Purchase or Lead)
- **Pass:** EMQ ≥8.0
- **Warning:** EMQ 6.0-7.9
- **Fail:** EMQ <6.0
- **Quick Win:** No

### M-PX5: Domain Verification [High, 2.5]
- **Check:** Business domain verified in Business Manager
- **Pass:** Domain verified
- **Warning:** —
- **Fail:** Domain not verified (limits AEM and conversion optimization)
- **Quick Win:** Yes (5 min)

### M-PX6: Aggregated Event Measurement (AEM) [High, 2.5]
- **Check:** Top 8 web events configured and prioritized
- **Pass:** Events configured and correctly prioritized
- **Warning:** Events configured but not properly prioritized
- **Fail:** AEM not configured
- **Quick Win:** Yes (10 min)

### M-PX7: Standard vs Custom Events [High, 2.5]
- **Check:** Using Meta standard events vs custom events
- **Pass:** Standard events used (Purchase, AddToCart, Lead, etc.)
- **Warning:** Mix of standard and custom events
- **Fail:** Custom events replacing standard events (limits optimization)
- **Quick Win:** No

### M-PX8: CAPI Gateway [Medium, 1.5]
- **Check:** CAPI Gateway deployed for simplified server-side tracking
- **Pass:** CAPI Gateway active
- **Warning:** Direct CAPI integration active (functional but more maintenance)
- **Fail:** —
- **Quick Win:** No

### M-PX9: Attribution Window Configuration [High, 2.5]
- **Check:** Attribution window set appropriately
- **Pass:** 7-day click / 1-day view configured
- **Warning:** 1-day click only (missing view-through and longer click window)
- **Fail:** Attribution not configured (default may not match business model)
- **Quick Win:** Yes (2 min)

### M-PX10: Data Freshness [Medium, 1.5]
- **Check:** Event data freshness in Events Manager
- **Pass:** Events firing in real-time (no >1hr lag)
- **Warning:** <4hr lag
- **Fail:** >4hr lag or intermittent firing
- **Quick Win:** No

---

## Creative Diversity & Fatigue (Weight: 30%)

### M-CR1: Creative Format Diversity [Critical, 5.0]
- **Check:** Number of creative formats active across account
- **Pass:** ≥3 formats active (static image, video, carousel)
- **Warning:** 2 formats
- **Fail:** Only 1 format used
- **Quick Win:** Yes (15 min — add second format)

### M-CR2: Creative Volume Per Ad Set [High, 2.5]
- **Check:** Number of creatives per ad set
- **Pass:** 5-8 creatives per ad set (optimal for Andromeda algorithm)
- **Warning:** 3-4 creatives
- **Fail:** <3 creatives per ad set
- **Quick Win:** No

### M-CR3: Video Aspect Ratios [High, 2.5]
- **Check:** 9:16 vertical video present for Reels/Stories placements
- **Pass:** 9:16 vertical video present
- **Warning:** Only 1:1 or 4:5 video
- **Fail:** No video assets
- **Quick Win:** No

### M-CR4: Creative Fatigue Detection [Critical, 5.0]
- **Check:** CTR trends on active creatives
- **Pass:** No creatives with CTR decline >20% over 14 days
- **Warning:** CTR decline 10-20% on some creatives
- **Fail:** CTR decline >20% + frequency >3 (fatigue confirmed)
- **Quick Win:** No (requires new creative production)

### M-CR5: Video Hook Rate [High, 2.5]
- **Check:** Video ad performance in first 3 seconds
- **Pass:** <50% skip rate in first 3 seconds
- **Warning:** 50-70% skip rate
- **Fail:** >70% skip rate (hook not engaging)
- **Quick Win:** No

### M-CR6: Social Proof Utilization [Medium, 1.5]
- **Check:** Organic posts boosted as paid ads
- **Pass:** Top organic posts used as Spark/partnership ads
- **Warning:** Some organic content boosted
- **Fail:** No organic content leveraged in paid
- **Quick Win:** Yes (10 min)

### M-CR7: UGC / Social-Native Content [High, 2.5]
- **Check:** Percentage of creative assets that are UGC or social-native
- **Pass:** ≥30% of creatives are UGC or social-native
- **Warning:** 10-30% UGC content
- **Fail:** <10% UGC (all polished/corporate — lower engagement)
- **Quick Win:** No

### M-CR8: Advantage+ Creative [Medium, 1.5]
- **Check:** Advantage+ creative enhancements tested
- **Pass:** Advantage+ Creative enabled with test vs control
- **Warning:** —
- **Fail:** Not tested
- **Quick Win:** Yes (5 min)

### M-CR9: Creative Freshness [High, 2.5]
- **Check:** Last time new creative was tested
- **Pass:** New creative tested within last 30 days
- **Warning:** New creative 30-60 days ago
- **Fail:** No new creative in >60 days
- **Quick Win:** No

### M-CR10: Prospecting Frequency [High, 2.5]
- **Check:** Ad set frequency for prospecting campaigns (7-day window)
- **Pass:** Frequency <3.0
- **Warning:** Frequency 3.0-5.0
- **Fail:** Frequency >5.0 (audience exhausted)
- **Quick Win:** No

### M-CR11: Retargeting Frequency [Medium, 1.5]
- **Check:** Ad set frequency for retargeting campaigns (7-day window)
- **Pass:** Frequency <8.0
- **Warning:** Frequency 8.0-12.0
- **Fail:** Frequency >12.0
- **Quick Win:** No

### M-CR12: CTR Benchmark [High, 2.5]
- **Check:** Overall CTR vs platform benchmarks
- **Pass:** CTR ≥1.0%
- **Warning:** CTR 0.5-1.0%
- **Fail:** CTR <0.5%
- **Quick Win:** No

---

## Account Structure (Weight: 20%)

### M-ST1: Campaign Count [High, 2.5]
- **Check:** Number of active campaigns per country/funnel stage
- **Pass:** ≤5 active campaigns per segment
- **Warning:** 6-8 campaigns per segment
- **Fail:** >8 campaigns (over-fragmented, splits learning data)
- **Quick Win:** No

### M-ST2: CBO vs ABO Appropriateness [High, 2.5]
- **Check:** Budget optimization type matches spend level
- **Pass:** CBO for >$500/day budgets; ABO for testing <$100/day
- **Warning:** Mismatched but functional
- **Fail:** CBO on <$100/day OR ABO on >$500/day
- **Quick Win:** Yes (5 min)

### M-ST3: Learning Phase Status [Critical, 5.0]
- **Check:** Percentage of ad sets in Learning Limited
- **Pass:** <30% of ad sets in Learning Limited
- **Warning:** 30-50% Learning Limited
- **Fail:** >50% ad sets Learning Limited
- **Quick Win:** No

### M-ST4: Learning Phase Stability [High, 2.5]
- **Check:** Unnecessary edits during active learning phases
- **Pass:** No unnecessary edits during learning
- **Warning:** 1-2 minor learning phase resets
- **Fail:** Frequent resets from edits during learning
- **Quick Win:** No (behavioral change)

### M-ST5: Advantage+ Sales Campaign [Medium, 1.5]
- **Check:** Advantage+ Shopping Campaign tested for eligible ecommerce accounts
- **Pass:** ASC active with catalog
- **Warning:** ASC tested but paused
- **Fail:** Not tested despite eligible product catalog
- **Quick Win:** No

### M-ST6: Ad Set Consolidation [High, 2.5]
- **Check:** Audience overlap between active ad sets
- **Pass:** No overlapping ad sets targeting same audience
- **Warning:** Minor overlap (<20%)
- **Fail:** Significant audience overlap (>30%) — self-competition
- **Quick Win:** No

### M-ST7: Minimum Budget Distribution [High, 2.5]
- **Check:** Minimum daily budget per ad set
- **Pass:** All ad sets getting ≥$10/day
- **Warning:** Some ad sets $5-$10/day
- **Fail:** Ad sets getting <$5/day (insufficient for optimization)
- **Quick Win:** Yes (5 min — consolidate or increase)

### M-ST8: Campaign Objective Alignment [High, 2.5]
- **Check:** Campaign objective matches actual business goal
- **Pass:** Objective aligned (e.g., Sales for ecommerce, Leads for lead gen)
- **Warning:** —
- **Fail:** Objective mismatched (e.g., Traffic objective for Sales goal)
- **Quick Win:** No (requires campaign rebuild)

### M-ST9: Advantage+ Placements [Medium, 1.5]
- **Check:** Placement optimization setting
- **Pass:** Advantage+ Placements enabled (Meta optimizes distribution)
- **Warning:** Manual placements with documented justification
- **Fail:** Manual placements limiting delivery without clear reason
- **Quick Win:** Yes (2 min)

### M-ST10: Placement Performance Review [Medium, 1.5]
- **Check:** Placement breakdown reviewed regularly
- **Pass:** Reviewed monthly; underperformers excluded
- **Warning:** Reviewed quarterly
- **Fail:** Never reviewed
- **Quick Win:** Yes (10 min)

### M-ST11: Attribution Setting Consistency [High, 2.5]
- **Check:** Attribution window configured consistently
- **Pass:** 7-day click / 1-day view across campaigns
- **Warning:** 1-day click only
- **Fail:** Attribution not configured or inconsistent across campaigns
- **Quick Win:** Yes (2 min)

### M-ST12: Bid Strategy Appropriateness [High, 2.5]
- **Check:** Bid strategy matches business goals
- **Pass:** Cost Cap for margin protection; Lowest Cost for volume
- **Warning:** —
- **Fail:** Bid Cap set below historical CPA (severely limits delivery)
- **Quick Win:** Yes (5 min)

### M-ST13: Campaign Frequency Monitoring [High, 2.5]
- **Check:** Campaign-level prospecting frequency (7-day window)
- **Pass:** Frequency <4.0
- **Warning:** Frequency 4.0-6.0
- **Fail:** Frequency >6.0 (audience saturation)
- **Quick Win:** No

### M-ST14: Breakdown Reporting [Medium, 1.5]
- **Check:** Age, gender, placement, platform breakdown reviewed
- **Pass:** Reviewed monthly
- **Warning:** Reviewed quarterly
- **Fail:** Never reviewed
- **Quick Win:** Yes (10 min)

### M-ST15: UTM Parameters [Medium, 1.5]
- **Check:** UTM parameters on all ad URLs for GA4 attribution
- **Pass:** UTMs on all ads (via campaign URL template)
- **Warning:** UTMs on some ads
- **Fail:** No UTM parameters
- **Quick Win:** Yes (5 min)

### M-ST16: A/B Testing Active [Medium, 1.5]
- **Check:** Active A/B test using Meta Experiments
- **Pass:** At least 1 active A/B test
- **Warning:** Test planned
- **Fail:** No testing infrastructure
- **Quick Win:** No

### M-ST17: Budget Adequacy [High, 2.5]
- **Check:** Daily budget relative to target CPA
- **Pass:** Daily budget ≥5× target CPA per ad set
- **Warning:** Budget 2-5× CPA
- **Fail:** Budget <2× target CPA (insufficient for learning)
- **Quick Win:** Yes (5 min — increase or consolidate)

### M-ST18: Budget Utilization [Medium, 1.5]
- **Check:** Percentage of daily budget being utilized
- **Pass:** >80% of daily budget utilized
- **Warning:** 60-80% utilization
- **Fail:** <60% utilization (indicates targeting or bid issues)
- **Quick Win:** No

---

## Audience & Targeting (Weight: 20%)

### M-AU1: Audience Overlap [High, 2.5]
- **Check:** Overlap between active ad sets
- **Pass:** <20% overlap between active ad sets
- **Warning:** 20-40% overlap
- **Fail:** >40% overlap (self-competition in auction)
- **Quick Win:** No

### M-AU2: Custom Audience Freshness [High, 2.5]
- **Check:** Age of Website Custom Audiences
- **Pass:** Custom Audiences refreshed within 180 days
- **Warning:** 180-365 days old
- **Fail:** >365 days old or not created
- **Quick Win:** No

### M-AU3: Lookalike Source Quality [Medium, 1.5]
- **Check:** Size and quality of Lookalike Audience source
- **Pass:** Source ≥1,000 users from high-value events (purchasers, high-LTV)
- **Warning:** 500-1,000 users
- **Fail:** <500 users or low-value source event
- **Quick Win:** No

### M-AU4: Advantage+ Audience Testing [Medium, 1.5]
- **Check:** Advantage+ Audience tested vs manual targeting
- **Pass:** Tested (with or without suggestions as starting point)
- **Warning:** —
- **Fail:** Not tested
- **Quick Win:** Yes (5 min)

### M-AU5: Purchaser/Converter Exclusions [High, 2.5]
- **Check:** Existing customers excluded from prospecting campaigns
- **Pass:** Purchasers/converters excluded from all prospecting
- **Warning:** Partial exclusions
- **Fail:** No purchaser exclusions from prospecting (wasted spend)
- **Quick Win:** Yes (10 min)

### M-AU6: First-Party Data Utilization [High, 2.5]
- **Check:** Customer list uploaded for Custom Audiences and Lookalikes
- **Pass:** Customer list uploaded and refreshed within 90 days
- **Warning:** List uploaded but not refreshed
- **Fail:** No first-party data uploaded
- **Quick Win:** No

---

## Context Notes

- **Detailed targeting exclusions removed (Jan 2026):** Meta fully removed detailed targeting exclusions. Use Custom Audience exclusions or Advantage+ Audience instead.
- **Flexible Ads (2024):** Automatically optimizes creative elements per placement. Evaluate alongside Advantage+ Creative.
- **Financial Products Special Ad Category (Jan 2025):** Financial products now enforced as Special Ad Category with same restrictions as Housing/Employment/Credit.

---

## Special Ad Categories Compliance

If running ads in restricted categories, these additional checks apply:

| Category | Restrictions | Enforcement |
|----------|-------------|-------------|
| Housing | No ZIP code targeting, age 18-65+ only, no Lookalike | Campaign disapproval |
| Employment | Same as Housing | Campaign disapproval |
| Credit | Same as Housing | Campaign disapproval |
| Financial Products (Jan 2025) | Same restrictions as above | Campaign disapproval |

Must declare Special Ad Category BEFORE campaign creation.

---

## Quick Wins Summary

| Check | Fix | Time |
|-------|-----|------|
| M-PX2 — CAPI setup | Deploy via CAPI Gateway | 15 min |
| M-PX5 — Domain verification | Verify domain in Business Manager | 5 min |
| M-PX9 — Attribution window | Set to 7-day click / 1-day view | 2 min |
| M-AU5 — Purchaser exclusions | Create Custom Audience, exclude from prospecting | 10 min |
| M-CR1 — Format diversity | Add video or carousel to single-format ad sets | 15 min |
| M-ST15 — UTM parameters | Add UTM template at campaign level | 5 min |
| M-ST11 — Attribution consistency | Set 7-day click / 1-day view across campaigns | 2 min |
| M-ST9 — Advantage+ Placements | Enable Advantage+ Placements | 2 min |
