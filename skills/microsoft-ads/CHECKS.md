# Microsoft Ads Audit Checklist

<!-- Total Checks: 30 | Categories: 5 | See skills/shared/scoring-system.md for weights and algorithm -->

## Quick Reference

| Category | Weight | Checks |
|----------|--------|--------|
| Technical Setup | 25% | MS-TE1 through MS-TE6 (6 checks) |
| Syndication & Bidding | 20% | MS-SB1 through MS-SB6 (6 checks) |
| Structure & Audience | 20% | MS-SA1 through MS-SA6 (6 checks) |
| Creative & Extensions | 20% | MS-CE1 through MS-CE6 (6 checks) |
| Settings & Performance | 15% | MS-SP1 through MS-SP6 (6 checks) |

---

## Technical Setup (Weight: 25%)

### MS-TE1: UET Tag Verified and Firing [Critical, 5.0]
- **Check:** Universal Event Tracking tag installed and verified
- **Pass:** UET tag active and firing on all pages (verified in Tag Helper)
- **Warning:** Tag firing but with errors/warnings
- **Fail:** UET tag not installed or not firing
- **Quick Win:** No

### MS-TE2: Auto-Tagging (MSCLKID) Enabled [Critical, 5.0]
- **Check:** Microsoft Click ID auto-tagging is active
- **Pass:** MSCLKID auto-tagging enabled
- **Warning:** —
- **Fail:** Auto-tagging disabled (breaks conversion tracking and analytics)
- **Quick Win:** Yes (2 min)

### MS-TE3: Enhanced Conversions Active [High, 2.5]
- **Check:** Enhanced conversions configured for primary goals
- **Pass:** Enhanced conversions active and verified
- **Warning:** Enabled but not verified
- **Fail:** Not enabled
- **Quick Win:** Yes (10 min)

### MS-TE4: Google Import Validation [High, 2.5]
- **Check:** Imported campaigns from Google reviewed and adjusted for Microsoft
- **Pass:** Import completed with Microsoft-specific adjustments (bids, extensions, targeting)
- **Warning:** Imported but only partially adjusted
- **Fail:** Raw import without any Microsoft-specific optimization
- **Quick Win:** No

### MS-TE5: Conversion Goals Configured [Critical, 5.0]
- **Check:** Conversion goals set up with appropriate types
- **Pass:** Primary goals configured with correct counting and values
- **Warning:** Goals exist but settings not reviewed
- **Fail:** No conversion goals configured
- **Quick Win:** Yes (10 min)

### MS-TE6: Clarity Integration [Medium, 1.5]
- **Check:** Microsoft Clarity installed for user behavior insights
- **Pass:** Clarity active with heatmaps and session recordings
- **Warning:** Clarity installed but not reviewed
- **Fail:** Clarity not installed
- **Quick Win:** Yes (10 min)

---

## Syndication & Bidding (Weight: 20%)

### MS-SB1: Brand Syndication Excluded [Critical, 5.0]
- **Check:** Brand campaigns exclude syndication partner network
- **Pass:** Syndication partners excluded from brand campaigns
- **Warning:** —
- **Fail:** Brand campaigns serving on syndication network (low-quality traffic)
- **Quick Win:** Yes (2 min)

### MS-SB2: Search Partner Performance [High, 2.5]
- **Check:** Search partner network performance monitored
- **Pass:** Partners monitored; underperformers excluded
- **Warning:** Partners enabled but not monitored
- **Fail:** Partners enabled with significantly worse CPA than search
- **Quick Win:** Yes (5 min — exclude underperformers)

### MS-SB3: Smart Bidding Active [High, 2.5]
- **Check:** Automated bidding on campaigns with sufficient conversion data
- **Pass:** Automated bidding on campaigns with ≥15 conversions/30d
- **Warning:** Partially automated
- **Fail:** Manual CPC on campaigns with sufficient data
- **Quick Win:** Yes (5 min)

### MS-SB4: Copilot/AI Placement Review [Medium, 1.5]
- **Check:** Performance of ads in Copilot and AI-powered placements
- **Pass:** Copilot placement performance reviewed, performing at or above average CPA
- **Warning:** Copilot placements enabled but not reviewed
- **Fail:** —
- **Quick Win:** Yes (5 min)

### MS-SB5: Bid Adjustment Strategy [High, 2.5]
- **Check:** Device, location, and schedule bid adjustments configured
- **Pass:** Bid adjustments based on performance data
- **Warning:** Default adjustments (no data review)
- **Fail:** No bid adjustments on campaigns with performance variance by segment
- **Quick Win:** Yes (10 min)

### MS-SB6: Budget Pacing [Medium, 1.5]
- **Check:** Daily budget utilization and pacing
- **Pass:** >80% budget utilized without early exhaustion
- **Warning:** 60-80% utilization or hitting cap before 4 PM
- **Fail:** <60% utilization or consistently capped before noon
- **Quick Win:** Yes (5 min)

---

## Structure & Audience (Weight: 20%)

### MS-SA1: LinkedIn Profile Targeting Active [High, 2.5]
- **Check:** LinkedIn Profile Targeting used for B2B accounts (Microsoft-exclusive feature)
- **Pass:** LinkedIn targeting active (company, industry, job function)
- **Warning:** Available but not tested
- **Fail:** Not used despite B2B relevance
- **N/A:** Non-B2B accounts
- **Quick Win:** Yes (10 min)

### MS-SA2: Campaign Structure [High, 2.5]
- **Check:** Campaign organization follows best practices
- **Pass:** Clean brand/non-brand separation, themed ad groups
- **Warning:** Partially organized
- **Fail:** No structure (everything in one campaign or random grouping)
- **Quick Win:** No

### MS-SA3: In-Market Audiences [Medium, 1.5]
- **Check:** In-market audiences applied for targeting or observation
- **Pass:** Relevant in-market audiences applied
- **Warning:** Some audiences applied
- **Fail:** No audience targeting configured
- **Quick Win:** Yes (10 min)

### MS-SA4: Remarketing Lists [High, 2.5]
- **Check:** UET-based remarketing lists configured
- **Pass:** Active remarketing lists with recent data
- **Warning:** Lists exist but not refreshed
- **Fail:** No remarketing lists despite sufficient traffic
- **Quick Win:** No

### MS-SA5: Customer Match [Medium, 1.5]
- **Check:** Customer list uploaded for targeting
- **Pass:** Customer Match list uploaded and refreshed within 30 days
- **Warning:** List >30 days old
- **Fail:** No Customer Match list
- **Quick Win:** No

### MS-SA6: Audience Exclusions [High, 2.5]
- **Check:** Converters excluded from prospecting campaigns
- **Pass:** Converter/customer exclusions active on prospecting
- **Warning:** Partial exclusions
- **Fail:** No exclusions (remarketing overlap with prospecting)
- **Quick Win:** Yes (10 min)

---

## Creative & Extensions (Weight: 20%)

### MS-CE1: RSA Quality [High, 2.5]
- **Check:** Responsive Search Ad completeness and quality
- **Pass:** ≥8 headlines, ≥3 descriptions, Ad Strength "Good" or better
- **Warning:** 3-7 headlines or "Average" Ad Strength
- **Fail:** <3 headlines or "Poor" Ad Strength
- **Quick Win:** No

### MS-CE2: Multimedia Ads Tested [Medium, 1.5]
- **Check:** Multimedia Ads format tested (Microsoft-exclusive rich format)
- **Pass:** Multimedia Ads active with performance data
- **Warning:** —
- **Fail:** Not tested (missing opportunity for higher CTR/engagement)
- **Quick Win:** No

### MS-CE3: Sitelink Extensions [High, 2.5]
- **Check:** Sitelink assets configured
- **Pass:** ≥4 sitelinks per campaign
- **Warning:** 1-3 sitelinks
- **Fail:** No sitelinks
- **Quick Win:** Yes (10 min)

### MS-CE4: Action Extensions [Medium, 1.5]
- **Check:** Action Extensions configured (Microsoft-exclusive CTA buttons)
- **Pass:** Action Extensions active with relevant CTAs
- **Warning:** —
- **Fail:** Not configured
- **Quick Win:** Yes (5 min)

### MS-CE5: Filter Link Extensions [Medium, 1.5]
- **Check:** Filter Link Extensions tested (Microsoft-exclusive category links)
- **Pass:** Filter Links active for accounts with product categories
- **Warning:** —
- **Fail:** Not tested despite eligible product catalog
- **N/A:** Accounts without product categories
- **Quick Win:** Yes (10 min)

### MS-CE6: Image Extensions [Medium, 1.5]
- **Check:** Image extensions active for search campaigns
- **Pass:** Image extensions active
- **Warning:** —
- **Fail:** No image extensions
- **Quick Win:** Yes (10 min)

---

## Settings & Performance (Weight: 15%)

### MS-SP1: CPC Advantage Tracking [High, 2.5]
- **Check:** CPC compared to equivalent Google Ads campaigns
- **Pass:** CPCs 20-40% lower than Google (typical advantage)
- **Warning:** CPCs within 10% of Google (advantage not captured)
- **Fail:** CPCs higher than Google (import settings not optimized)
- **Quick Win:** No

### MS-SP2: Conversion Rate Comparison [High, 2.5]
- **Check:** Conversion rates compared to Google Ads
- **Pass:** Conversion rate within 20% of Google equivalent
- **Warning:** 20-50% lower than Google
- **Fail:** >50% lower than Google (landing page or audience quality issue)
- **Quick Win:** No

### MS-SP3: Negative Keywords [High, 2.5]
- **Check:** Negative keyword lists applied (especially post-import)
- **Pass:** Microsoft-specific negative keywords added beyond Google import
- **Warning:** Only Google-imported negatives
- **Fail:** No negative keywords
- **Quick Win:** Yes (10 min)

### MS-SP4: Search Term Review [High, 2.5]
- **Check:** Microsoft-specific search terms reviewed (different from Google)
- **Pass:** Microsoft search terms reviewed within 14 days
- **Warning:** Reviewed within 30 days
- **Fail:** Not reviewed (relying only on Google-imported negatives)
- **Quick Win:** Yes (15 min)

### MS-SP5: Shopping Campaign Setup [High, 2.5]
- **Check:** Microsoft Shopping campaigns configured (separate Merchant Center)
- **Pass:** Shopping campaigns active with Microsoft Merchant Center feed
- **Warning:** Using Google import for Shopping (partial functionality)
- **Fail:** No Shopping campaigns despite eligible product catalog
- **N/A:** Non-ecommerce accounts
- **Quick Win:** No

### MS-SP6: Geographic Targeting [Medium, 1.5]
- **Check:** Location targeting method appropriate
- **Pass:** "People in" selected for local/regional businesses
- **Warning:** —
- **Fail:** "People in or interested in" for local business
- **Quick Win:** Yes (2 min)

---

## Context Notes

- **CPC Advantage:** Microsoft Ads typically delivers 20-40% lower CPCs than Google due to less auction competition. Monitor this advantage; if not present, import settings likely need optimization.
- **LinkedIn Profile Targeting:** Microsoft-exclusive feature enabling B2B targeting by company name, industry, and job function. High-value differentiator for B2B accounts.
- **Multimedia Ads:** Microsoft-exclusive rich ad format with larger visual real estate. Higher CTR than standard RSAs.
- **Separate Merchant Center:** Microsoft has its own Merchant Center — do not rely solely on Google import for Shopping campaigns.
- **Clarity Integration:** Free Microsoft-owned analytics tool providing heatmaps, session recordings, and scroll depth analysis.

---

## Quick Wins Summary

| Check | Fix | Time |
|-------|-----|------|
| MS-TE2 — Auto-tagging | Enable MSCLKID auto-tagging | 2 min |
| MS-SB1 — Brand syndication | Exclude syndication from brand campaigns | 2 min |
| MS-SB2 — Partner performance | Exclude underperforming search partners | 5 min |
| MS-SB3 — Smart Bidding | Switch eligible campaigns to automated bidding | 5 min |
| MS-CE3 — Sitelinks | Add ≥4 sitelinks | 10 min |
| MS-CE4 — Action Extensions | Configure CTA extensions | 5 min |
| MS-SP3 — Negative keywords | Add Microsoft-specific negatives beyond import | 10 min |
| MS-SA1 — LinkedIn targeting | Enable LinkedIn Profile Targeting for B2B | 10 min |
| MS-SP6 — Location targeting | Switch to "People in" for local businesses | 2 min |
