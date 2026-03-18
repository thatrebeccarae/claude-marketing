# Google Ads Audit Checklist

<!-- Total Checks: 74 | Categories: 6 | See skills/shared/scoring-system.md for weights and algorithm -->

## Quick Reference

| Category | Weight | Checks |
|----------|--------|--------|
| Conversion Tracking | 25% | G-CT1 through G-CT11 (11 checks) |
| Wasted Spend / Negatives | 20% | G-WS1 through G-WS8 (8 checks) |
| Account Structure | 15% | G-ST1 through G-ST12 (12 checks) |
| Keywords & Quality Score | 15% | G-KW1 through G-KW8 (8 checks) |
| Ads & Assets | 15% | G-AD1 through G-AD17 (17 checks) |
| Settings & Targeting | 10% | G-SE1 through G-SE18 (18 checks) |

---

## Conversion Tracking (Weight: 25%)

### G-CT1: Primary Conversion Action Exists [Critical, 5.0]
- **Check:** At least 1 Primary Conversion Action configured and receiving data
- **Pass:** Primary action exists and received conversions in last 30 days
- **Warning:** Primary action exists but 0 conversions in last 30 days
- **Fail:** No Primary Conversion Action configured
- **Quick Win:** Yes (5 min)

### G-CT2: Enhanced Conversions Active [Critical, 5.0]
- **Check:** Enhanced conversions enabled for primary conversion actions
- **Pass:** Enhanced conversions active and verified
- **Warning:** Enabled but not verified (data quality unknown)
- **Fail:** Not enabled
- **Quick Win:** Yes (5 min)

### G-CT3: Server-Side Tracking [High, 2.5]
- **Check:** Server-side GTM or Google Ads API conversion import is active
- **Pass:** Server-side tracking deployed and verified
- **Warning:** Planned but not yet deployed
- **Fail:** No server-side tracking (browser-only)
- **Quick Win:** No

### G-CT4: Consent Mode v2 (EU/EEA) [Critical, 5.0]
- **Check:** Consent Mode v2 implemented for accounts serving EU/EEA traffic
- **Pass:** Advanced Consent Mode active with proper CMP integration
- **Warning:** Basic Consent Mode only
- **Fail:** Not implemented despite EU/EEA targeting
- **N/A:** Account does not target EU/EEA
- **Quick Win:** No

### G-CT5: Conversion Window Matches Sales Cycle [Medium, 1.5]
- **Check:** Conversion window is appropriate for the business model
- **Pass:** Window matches sales cycle (7d ecommerce, 30-90d B2B, 30d lead gen)
- **Warning:** Default 30d without validation against actual sales cycle
- **Fail:** Window clearly mismatched (e.g., 7d window on 90d B2B sales cycle)
- **Quick Win:** Yes (2 min)

### G-CT6: Macro vs Micro Conversion Separation [High, 2.5]
- **Check:** Only macro conversions (Purchase, Lead, Signup) set as Primary for bidding
- **Pass:** Primary actions are macro conversions only; micro events are Secondary
- **Warning:** Some micro events (AddToCart, PageView) set as Primary
- **Fail:** All events including micro conversions set as Primary (pollutes bidding)
- **Quick Win:** Yes (5 min)

### G-CT7: Attribution Model [Medium, 1.5]
- **Check:** Data-driven attribution (DDA) is selected
- **Pass:** DDA active
- **Warning:** Last Click selected intentionally (documented reason)
- **Fail:** Legacy rule-based model still active (deprecated Sep 2025)
- **Quick Win:** Yes (2 min)

### G-CT8: Conversion Value Assignment [High, 2.5]
- **Check:** Conversion values are assigned for bid optimization
- **Pass:** Dynamic values for ecommerce; value rules configured for lead gen
- **Warning:** Static values assigned (better than nothing)
- **Fail:** No conversion values assigned
- **Quick Win:** No

### G-CT9: No Duplicate Conversion Counting [Critical, 5.0]
- **Check:** GA4 import and native Google Ads tag are not counting the same conversion
- **Pass:** No duplicate counting between GA4 and Google Ads
- **Warning:** —
- **Fail:** Both GA4 import and native tag counting same conversion action
- **Quick Win:** Yes (10 min)

### G-CT10: GA4 Linked and Flowing [High, 2.5]
- **Check:** GA4 property linked to Google Ads with data flowing correctly
- **Pass:** Linked, audiences shared, data consistent
- **Warning:** Linked but data discrepancies present
- **Fail:** Not linked
- **Quick Win:** Yes (5 min)

### G-CT11: Google Tag Firing Correctly [Critical, 5.0]
- **Check:** gtag.js or GTM container firing on all relevant pages
- **Pass:** Tag firing correctly on all pages
- **Warning:** Firing on most pages (>90%) but missing some
- **Fail:** Tag missing or broken on key conversion pages
- **Quick Win:** No

---

## Wasted Spend / Negatives (Weight: 20%)

### G-WS1: Search Term Review Recency [Critical, 5.0]
- **Check:** Search terms have been reviewed recently
- **Pass:** Reviewed within last 14 days
- **Warning:** Reviewed within last 30 days
- **Fail:** Not reviewed in >30 days
- **Quick Win:** Yes (15 min)

### G-WS2: Negative Keyword Lists Exist [Critical, 5.0]
- **Check:** Themed negative keyword lists are configured
- **Pass:** ≥3 themed lists (e.g., Competitor, Jobs/Careers, Free/Cheap, Irrelevant)
- **Warning:** 1-2 lists exist
- **Fail:** No negative keyword lists
- **Quick Win:** Yes (10 min)

### G-WS3: Account-Level Negatives Applied [High, 2.5]
- **Check:** Negative keyword lists are applied broadly
- **Pass:** Lists applied at account level or to all relevant campaigns
- **Warning:** Applied to some campaigns only
- **Fail:** Lists exist but not applied
- **Quick Win:** Yes (5 min)

### G-WS4: Irrelevant Search Term Spend [Critical, 5.0]
- **Check:** Percentage of spend going to irrelevant search terms
- **Pass:** <5% of spend on irrelevant terms (last 30 days)
- **Warning:** 5-15% on irrelevant terms
- **Fail:** >15% on irrelevant terms
- **Quick Win:** No (requires ongoing management)

### G-WS5: Broad Match + Smart Bidding Pairing [Critical, 5.0]
- **Check:** No Broad Match keywords running on Manual CPC
- **Pass:** All Broad Match keywords use Smart Bidding (Target CPA, Target ROAS, Max Conversions)
- **Warning:** —
- **Fail:** Broad Match + Manual CPC active (uncontrolled spend)
- **Quick Win:** Yes (5 min — switch to Smart Bidding or Exact Match)

### G-WS6: Close Variant Pollution [High, 2.5]
- **Check:** Exact/Phrase match keywords not triggering irrelevant close variants
- **Pass:** Close variant matches are relevant (>90% relevant)
- **Warning:** Minor close variant issues (10-20% irrelevant)
- **Fail:** Significant irrelevant close variant spend (>20%)
- **Quick Win:** No

### G-WS7: Search Term Visibility [Medium, 1.5]
- **Check:** Percentage of search term spend that is visible (not hidden by Google)
- **Pass:** >60% of search term spend is visible
- **Warning:** 40-60% visible
- **Fail:** <40% visible (limited optimization ability)
- **Quick Win:** No

### G-WS8: Zero-Conversion Keywords [High, 2.5]
- **Check:** Keywords with high click volume but zero conversions
- **Pass:** No keywords with >100 clicks and 0 conversions
- **Warning:** 1-3 such keywords
- **Fail:** >3 keywords with >100 clicks and 0 conversions
- **Quick Win:** Yes (pause or restructure — 10 min)

---

## Account Structure (Weight: 15%)

### G-ST1: Campaign Naming Convention [Medium, 1.5]
- **Check:** Consistent naming pattern across campaigns
- **Pass:** Consistent pattern (e.g., [Brand]_[Type]_[Geo]_[Target])
- **Warning:** Partially consistent
- **Fail:** No naming convention
- **Quick Win:** No

### G-ST2: Ad Group Naming Convention [Medium, 1.5]
- **Check:** Ad group names follow campaign naming pattern
- **Pass:** Consistent with campaign naming
- **Warning:** Partially consistent
- **Fail:** No naming convention
- **Quick Win:** No

### G-ST3: Single Theme Ad Groups [High, 2.5]
- **Check:** Each ad group targets one keyword theme
- **Pass:** ≤10 keywords per ad group, all same theme
- **Warning:** 11-20 keywords with consistent theme
- **Fail:** 20+ unrelated keywords (theme drift)
- **Quick Win:** No

### G-ST4: Campaign Count Per Objective [High, 2.5]
- **Check:** Campaign proliferation is controlled
- **Pass:** ≤5 campaigns per funnel stage/objective
- **Warning:** 6-8 campaigns per objective
- **Fail:** >8 campaigns per objective (fragmented data, slow learning)
- **Quick Win:** No

### G-ST5: Brand vs Non-Brand Separation [Critical, 5.0]
- **Check:** Brand and non-brand keywords in separate campaigns
- **Pass:** Fully separated with independent budgets and bidding
- **Warning:** —
- **Fail:** Brand and non-brand mixed in same campaign
- **Quick Win:** Yes (10 min to create new campaign and move keywords)

### G-ST6: PMax Present for Eligible Accounts [Medium, 1.5]
- **Check:** Performance Max tested for accounts with conversion history
- **Pass:** PMax active with proper asset groups
- **Warning:** PMax tested but paused
- **Fail:** No PMax tested despite eligibility (ecom with feed, or 50+ conversions/month)
- **Quick Win:** No

### G-ST7: Search + PMax Brand Overlap [High, 2.5]
- **Check:** Brand exclusions configured in PMax when brand Search campaign exists
- **Pass:** Brand exclusions active in PMax
- **Warning:** Partial brand exclusions
- **Fail:** No brand exclusions in PMax alongside brand Search (cannibalization)
- **Quick Win:** Yes (5 min)

### G-ST8: Budget Allocation Matches Priority [High, 2.5]
- **Check:** Top-performing campaigns are not budget-constrained
- **Pass:** Top performers not limited by budget
- **Warning:** Minor budget constraints on top performers
- **Fail:** Top performers severely budget-limited while low performers have excess budget
- **Quick Win:** Yes (5 min — reallocate)

### G-ST9: Campaign Daily Budget Pacing [Medium, 1.5]
- **Check:** Campaigns not exhausting budget too early in the day
- **Pass:** No campaigns hitting cap before 6 PM
- **Warning:** 1-2 campaigns hitting cap early
- **Fail:** Multiple campaigns capped before noon
- **Quick Win:** Yes (5 min)

### G-ST10: Ad Schedule Configured [Low, 0.5]
- **Check:** Ad scheduling set for businesses with operating hours
- **Pass:** Schedule configured matching business hours
- **Warning:** —
- **Fail:** No schedule despite clear business hours (e.g., local service)
- **N/A:** 24/7 businesses
- **Quick Win:** Yes (5 min)

### G-ST11: Geographic Targeting Method [High, 2.5]
- **Check:** Location targeting uses "People in" not "People in or interested in"
- **Pass:** "People in" selected for local/regional businesses
- **Warning:** —
- **Fail:** "People in or interested in" for local business (wasted spend on out-of-area)
- **Quick Win:** Yes (2 min)

### G-ST12: Network Settings [High, 2.5]
- **Check:** Search Partner and Display Network settings are intentional
- **Pass:** Search Partners and Display Network disabled for Search campaigns (unless intentional)
- **Warning:** Search Partners ON but monitored
- **Fail:** Display Network ON for Search campaign (unintentional)
- **Quick Win:** Yes (2 min)

---

## Keywords & Quality Score (Weight: 15%)

### G-KW1: Account-Wide Average Quality Score [High, 2.5]
- **Check:** Impression-weighted average Quality Score across account
- **Pass:** Average QS ≥7
- **Warning:** QS 5-6
- **Fail:** QS ≤4
- **Quick Win:** No

### G-KW2: Critical Low QS Keywords [Critical, 5.0]
- **Check:** Percentage of keywords with QS ≤3
- **Pass:** <10% of keywords with QS ≤3
- **Warning:** 10-25% with QS ≤3
- **Fail:** >25% with QS ≤3
- **Quick Win:** No

### G-KW3: Expected CTR Component [High, 2.5]
- **Check:** Expected CTR Quality Score sub-component
- **Pass:** <20% of keywords with "Below Average" expected CTR
- **Warning:** 20-35% Below Average
- **Fail:** >35% Below Average
- **Quick Win:** No

### G-KW4: Ad Relevance Component [High, 2.5]
- **Check:** Ad relevance Quality Score sub-component
- **Pass:** <20% of keywords with "Below Average" ad relevance
- **Warning:** 20-35% Below Average
- **Fail:** >35% Below Average
- **Quick Win:** No

### G-KW5: Landing Page Experience Component [High, 2.5]
- **Check:** Landing page experience Quality Score sub-component
- **Pass:** <15% of keywords with "Below Average" landing page experience
- **Warning:** 15-30% Below Average
- **Fail:** >30% Below Average
- **Quick Win:** No

### G-KW6: Top Keyword Quality Scores [Medium, 1.5]
- **Check:** Quality Scores for highest-spend keywords
- **Pass:** Top 20 spend keywords all have QS ≥7
- **Warning:** Some top keywords at QS 5-6
- **Fail:** Top keywords with QS ≤4
- **Quick Win:** No

### G-KW7: Zero-Impression Keywords [Medium, 1.5]
- **Check:** Keywords with no impressions in last 30 days
- **Pass:** No keywords with 0 impressions (30 days)
- **Warning:** <10% zero-impression keywords
- **Fail:** >10% of keywords with 0 impressions (dead weight)
- **Quick Win:** Yes (5 min — pause or remove)

### G-KW8: Keyword-to-Ad Relevance [High, 2.5]
- **Check:** Ad headlines contain primary keyword variants from ad group
- **Pass:** Headlines contain primary keyword variants
- **Warning:** Partial keyword inclusion
- **Fail:** No keyword variants in ad headlines (poor relevance signal)
- **Quick Win:** No

---

## Ads & Assets (Weight: 15%)

### G-AD1: RSA Per Ad Group [High, 2.5]
- **Check:** Responsive Search Ads present in each ad group
- **Pass:** ≥1 RSA per ad group (≥2 recommended)
- **Warning:** 1 RSA per ad group
- **Fail:** Ad groups without any RSA
- **Quick Win:** No

### G-AD2: RSA Headline Count [High, 2.5]
- **Check:** Number of unique headlines per RSA
- **Pass:** ≥8 unique headlines (ideal: 12-15)
- **Warning:** 3-7 headlines
- **Fail:** <3 headlines
- **Quick Win:** No

### G-AD3: RSA Description Count [Medium, 1.5]
- **Check:** Number of descriptions per RSA
- **Pass:** ≥3 descriptions (ideal: 4)
- **Warning:** 2 descriptions
- **Fail:** <2 descriptions
- **Quick Win:** No

### G-AD4: RSA Ad Strength [High, 2.5]
- **Check:** Google's Ad Strength rating for RSAs
- **Pass:** All RSAs rated "Good" or "Excellent"
- **Warning:** Some RSAs rated "Average"
- **Fail:** Any RSA with "Poor" Ad Strength
- **Quick Win:** No

### G-AD5: RSA Pinning Strategy [Medium, 1.5]
- **Check:** Strategic use of headline/description pinning
- **Pass:** Strategic pinning (1-2 positions, 2-3 variants each)
- **Warning:** Over-pinned (all positions fixed)
- **Fail:** —
- **Quick Win:** No

### G-AD6: PMax Asset Group Density [Critical, 5.0]
- **Check:** Asset completeness in Performance Max asset groups
- **Pass:** ≥20 images, ≥5 logos, ≥5 videos per asset group (maximum density)
- **Warning:** 5-19 images, 1-4 logos, or 1-4 videos
- **Fail:** <5 images OR 0 logos OR 0 videos
- **Quick Win:** No

### G-AD7: PMax Video Assets [High, 2.5]
- **Check:** Native video present in PMax (not auto-generated)
- **Pass:** Native video in all formats (16:9, 1:1, 9:16)
- **Warning:** 1-2 video formats only
- **Fail:** No native video (auto-generated only)
- **Quick Win:** No

### G-AD8: PMax Asset Group Count [Medium, 1.5]
- **Check:** Number of asset groups per PMax campaign
- **Pass:** ≥2 asset groups per PMax (segmented by intent/theme)
- **Warning:** 1 asset group
- **Fail:** —
- **Quick Win:** No

### G-AD9: PMax Final URL Expansion [High, 2.5]
- **Check:** Final URL expansion setting reviewed
- **Pass:** Configured intentionally (ON for discovery, OFF for control)
- **Warning:** —
- **Fail:** Default ON without review (may send traffic to irrelevant pages)
- **Quick Win:** Yes (2 min)

### G-AD10: Ad Copy Keyword Relevance [High, 2.5]
- **Check:** Ad headlines contain primary keyword variants
- **Pass:** Headlines contain primary keyword variants from ad group
- **Warning:** Partial keyword inclusion
- **Fail:** No keyword relevance in headlines
- **Quick Win:** No

### G-AD11: Ad Copy Freshness [Medium, 1.5]
- **Check:** New ad copy tested recently
- **Pass:** New ad copy tested within last 90 days
- **Warning:** —
- **Fail:** No new ads in >90 days
- **Quick Win:** No

### G-AD12: CTR vs Industry Benchmark [High, 2.5]
- **Check:** Click-through rate compared to industry average
- **Pass:** CTR ≥ industry average
- **Warning:** CTR 50-100% of industry average
- **Fail:** CTR <50% of industry average
- **Quick Win:** No

### G-AD13: PMax Audience Signals [High, 2.5]
- **Check:** Custom audience signals configured per PMax asset group
- **Pass:** Custom audience signals with first-party data
- **Warning:** Generic signals only
- **Fail:** No audience signals configured
- **Quick Win:** Yes (10 min)

### G-AD14: PMax Ad Strength [High, 2.5]
- **Check:** PMax asset group Ad Strength rating
- **Pass:** "Good" or "Excellent"
- **Warning:** "Average"
- **Fail:** "Poor"
- **Quick Win:** No

### G-AD15: PMax Brand Cannibalization [High, 2.5]
- **Check:** Percentage of PMax conversions from brand terms
- **Pass:** <15% of PMax conversions from brand terms
- **Warning:** 15-30% from brand terms
- **Fail:** >30% from brand terms (PMax inflating results via brand capture)
- **Quick Win:** No

### G-AD16: PMax Search Themes [Medium, 1.5]
- **Check:** Search themes configured for intent signals
- **Pass:** Search themes configured (up to 50 per asset group)
- **Warning:** <5 search themes
- **Fail:** No search themes configured
- **Quick Win:** Yes (10 min)

### G-AD17: PMax Negative Keywords [High, 2.5]
- **Check:** Brand and irrelevant negative keywords applied to PMax
- **Pass:** Negatives applied (up to 10,000)
- **Warning:** Some negatives applied
- **Fail:** No negative keywords in PMax
- **Quick Win:** Yes (10 min)

---

## Settings & Targeting (Weight: 10%)

### G-SE1: Sitelink Extensions [High, 2.5]
- **Check:** Sitelink assets configured
- **Pass:** ≥4 sitelinks per campaign
- **Warning:** 1-3 sitelinks
- **Fail:** No sitelinks
- **Quick Win:** Yes (10 min)

### G-SE2: Callout Extensions [Medium, 1.5]
- **Check:** Callout assets configured
- **Pass:** ≥4 callouts per campaign
- **Warning:** 1-3 callouts
- **Fail:** No callouts
- **Quick Win:** Yes (5 min)

### G-SE3: Structured Snippets [Medium, 1.5]
- **Check:** Structured snippet assets configured
- **Pass:** ≥1 structured snippet set
- **Warning:** —
- **Fail:** No structured snippets
- **Quick Win:** Yes (5 min)

### G-SE4: Image Extensions [Medium, 1.5]
- **Check:** Image assets active for Search campaigns
- **Pass:** Image extensions active
- **Warning:** —
- **Fail:** No image extensions
- **Quick Win:** Yes (10 min)

### G-SE5: Call Extensions [Medium, 1.5]
- **Check:** Call assets with tracking for phone-based businesses
- **Pass:** Call extensions with call tracking enabled
- **Warning:** Call extension without call tracking
- **Fail:** No call extension for phone-based business
- **N/A:** Business does not rely on phone calls
- **Quick Win:** Yes (5 min)

### G-SE6: Lead Form Extensions [Low, 0.5]
- **Check:** Lead form assets tested for lead gen accounts
- **Pass:** Lead form active with CRM integration
- **Warning:** —
- **Fail:** Not tested for lead gen account
- **N/A:** Non-lead gen accounts
- **Quick Win:** No

### G-SE7: Audience Segments in Observation [High, 2.5]
- **Check:** Remarketing and in-market audiences applied in Observation mode
- **Pass:** Multiple audience segments applied in Observation mode
- **Warning:** Some audiences applied
- **Fail:** No audience signals (missing bid adjustment data)
- **Quick Win:** Yes (10 min)

### G-SE8: Customer Match Lists [High, 2.5]
- **Check:** Customer Match lists uploaded and maintained
- **Pass:** Customer Match list uploaded, refreshed within 30 days
- **Warning:** List >30 days old
- **Fail:** No Customer Match lists
- **Quick Win:** No

### G-SE9: Placement Exclusions [High, 2.5]
- **Check:** Account-level placement exclusions for Display/PMax
- **Pass:** Account-level exclusions for games, apps, MFA sites
- **Warning:** Campaign-level exclusions only
- **Fail:** No placement exclusions
- **Quick Win:** Yes (10 min)

### G-SE10: Landing Page Mobile Speed [High, 2.5]
- **Check:** Mobile landing page performance
- **Pass:** Mobile LCP <2.5s (ideal <2.0s)
- **Warning:** LCP 2.5-4.0s
- **Fail:** LCP >4.0s
- **Quick Win:** No

### G-SE11: Landing Page Relevance [High, 2.5]
- **Check:** Landing page H1/title matches ad group keyword theme
- **Pass:** Clear message match between ad and landing page
- **Warning:** Partial relevance
- **Fail:** No relevance to ad group theme (generic homepage)
- **Quick Win:** No

### G-SE12: Landing Page Schema Markup [Medium, 1.5]
- **Check:** Structured data (schema.org) on landing pages
- **Pass:** Product/FAQ/Service schema present
- **Warning:** —
- **Fail:** No schema markup
- **Quick Win:** No

### G-SE13: Smart Bidding Strategy Active [High, 2.5]
- **Check:** Automated bidding on campaigns with sufficient conversion data
- **Pass:** All campaigns with ≥15 conversions/30d use Smart Bidding
- **Warning:** Partially automated
- **Fail:** Manual CPC on campaigns with sufficient conversion data
- **Quick Win:** Yes (5 min)

### G-SE14: Target CPA/ROAS Reasonableness [Critical, 5.0]
- **Check:** Bid targets are realistic based on historical performance
- **Pass:** Targets within 20% of historical performance
- **Warning:** Targets 20-50% off historical
- **Fail:** Target CPA <50% of actual CPA (will severely limit delivery)
- **Quick Win:** Yes (5 min — adjust targets)

### G-SE15: Learning Phase Status [High, 2.5]
- **Check:** Percentage of campaigns in Learning or Learning Limited
- **Pass:** <25% of campaigns in Learning/Learning Limited
- **Warning:** 25-40% in learning
- **Fail:** >40% in learning
- **Quick Win:** No

### G-SE16: Budget-Constrained Campaigns [High, 2.5]
- **Check:** Top performers showing "Eligible" vs "Limited by Budget"
- **Pass:** Top performers not budget-constrained
- **Warning:** Minor budget limitation
- **Fail:** Top performers severely budget-limited
- **Quick Win:** Yes (5 min — reallocate budget)

### G-SE17: Manual CPC Justification [Medium, 1.5]
- **Check:** Manual CPC only used where appropriate
- **Pass:** Manual CPC only on campaigns with <15 conversions/month
- **Warning:** Manual CPC with 15-30 conversions/month
- **Fail:** Manual CPC with >30 conversions/month (should use Smart Bidding)
- **Quick Win:** Yes (5 min)

### G-SE18: Portfolio Bid Strategies [Medium, 1.5]
- **Check:** Low-volume campaigns grouped into portfolio strategies
- **Pass:** Low-volume campaigns (<15 conv/month) grouped into portfolios
- **Warning:** —
- **Fail:** Multiple <15 conversion campaigns running independently (insufficient data per strategy)
- **Quick Win:** Yes (10 min)

---

## Context Notes

- **ECPC deprecation (March 2025):** Enhanced CPC is no longer available for new campaigns. Existing ECPC campaigns should migrate to Target CPA, Target ROAS, or Maximize Conversions.
- **Call Campaigns sunset (Feb 2026):** Google stopped allowing new Call campaigns in February 2026; existing ones serve until February 2027. Migrate to Search campaigns with call assets.
- **Power Pack framework:** Google recommends PMax + Demand Gen + AI Max for Search as a unified campaign stack.
- **AI Max for Search (2025):** Extends broad match and automated creative to Search campaigns. Evaluate if account has sufficient conversion data.

---

## Quick Wins Summary

| Check | Fix | Time |
|-------|-----|------|
| G-CT2 — Enhanced Conversions | Enable in conversion settings | 5 min |
| G-ST11 — Location targeting | Switch to "People in" your targeted locations | 2 min |
| G-WS2 — Negative keyword lists | Create initial themed negative lists | 10 min |
| G-WS5 — Broad Match + Manual CPC | Switch to Smart Bidding or change to Exact Match | 5 min |
| G-ST12 — Network settings | Disable Display Network on Search campaigns | 2 min |
| G-ST5 — Brand separation | Split brand keywords into separate campaign | 10 min |
| G-SE1 — Sitelink extensions | Add ≥4 sitelinks to campaigns | 10 min |
| G-SE14 — Bid target reasonableness | Adjust CPA/ROAS targets to within 20% of historical | 5 min |
| G-AD9 — PMax URL expansion | Review and set intentionally | 2 min |
| G-ST7 — PMax brand exclusions | Add brand exclusions to PMax | 5 min |
