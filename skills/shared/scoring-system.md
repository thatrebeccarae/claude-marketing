# Audit Scoring System

Shared scoring methodology for all audit-oriented skills in claude-marketing. Any skill that produces a health score should follow this system for consistency across platforms and cross-platform aggregation.

## Weighted Scoring Algorithm

```
S_total = Σ(C_pass × W_sev × W_cat) / Σ(C_total × W_sev × W_cat) × 100
```

- `C_pass` = check result: PASS = 1.0, WARNING = 0.5, FAIL = 0.0
- `W_sev` = severity multiplier of the individual check
- `W_cat` = category weight for that platform (sums to 100% per platform)
- `N/A` checks are excluded from both numerator and denominator
- Result: 0-100 Health Score

## Severity Multipliers

| Severity | Multiplier | Criteria | Remediation |
|----------|-----------|----------|-------------|
| Critical | 5.0 | Immediate revenue or data loss risk | Fix immediately |
| High | 2.5 | Significant performance drag or compliance risk | Fix within 7 days |
| Medium | 1.5 | Optimization opportunity with measurable upside | Fix within 30 days |
| Low | 0.5 | Best practice, minor or cosmetic impact | Nice to have |

## Grade Thresholds

| Grade | Score | Label | Action Required |
|-------|-------|-------|-----------------|
| A | 90-100 | Excellent | Minor optimizations only |
| B | 75-89 | Good | Targeted improvements available |
| C | 60-74 | Needs Improvement | Notable issues affecting performance |
| D | 40-59 | Poor | Significant problems requiring intervention |
| F | <40 | Critical | Urgent action required |

Thresholds use wider bands than academic scoring because ad account health is typically distributed lower — a score of 75+ represents genuinely well-managed accounts.

## Category Weights by Platform

### Google Ads

| Category | Weight | Rationale |
|----------|--------|-----------|
| Conversion Tracking | 25% | Foundation for Smart Bidding and optimization; Enhanced Conversions + Consent Mode |
| Wasted Spend / Negatives | 20% | Direct money leak; search terms, negative lists, close variant pollution |
| Account Structure | 15% | Campaign organization, brand/non-brand separation, budget fragmentation |
| Keywords & Quality Score | 15% | QS directly impacts CPC and Ad Rank; targets average QS ≥7 |
| Ads & Assets | 15% | RSA quality, PMax asset completeness, extensions/assets |
| Settings & Targeting | 10% | Location method, network settings, audiences, landing pages |

### Meta Ads

| Category | Weight | Rationale |
|----------|--------|-----------|
| Pixel / CAPI Health | 30% | Post-iOS 14.5 signal resilience; 87% of advertisers have poor EMQ |
| Creative Diversity & Fatigue | 30% | Creative drives ~70% of campaign results per Meta research |
| Account Structure | 20% | Learning phase management, CBO/ABO, consolidation |
| Audience & Targeting | 20% | Overlap detection, exclusions, first-party data utilization |

### Microsoft Ads

| Category | Weight | Rationale |
|----------|--------|-----------|
| Technical Setup | 25% | UET tag, import validation, Enhanced Conversions |
| Syndication & Bidding | 20% | Partner network control, Copilot placement |
| Structure & Audience | 20% | LinkedIn Profile Targeting (unique), campaign structure |
| Creative & Extensions | 20% | Multimedia Ads, Action/Filter Link Extensions (unique) |
| Settings & Performance | 15% | CPC advantage tracking, conversion rate vs Google |

## Quick Wins Identification

```
IF severity == "Critical" OR severity == "High"
AND estimated_fix_time ≤ 15 minutes
THEN flag as Quick Win
```

Quick Wins are sorted by `severity_multiplier × estimated_impact` descending and presented first in audit output.

## Cross-Platform Aggregate Score

When auditing multiple platforms, calculate per-platform scores then aggregate by budget share:

```
Aggregate Score = Σ(Platform_Score × Platform_Budget_Share)

Example:
  Google (82) × 40% = 32.80
  Meta   (71) × 35% = 24.85
  Microsoft (90) × 25% = 22.50
  ─────────────────────────
  Aggregate = 80.15 → Grade B
```

## Standard Output Format

All audit skills producing a health score should output in this format:

```markdown
## Account Health Score: [SCORE]/100 (Grade [GRADE] — [LABEL])

### Quick Wins (fix in ≤15 min, high impact)
1. [Severity] Check description (estimated fix time)
2. ...

### Category Breakdown
| Category | Score | Grade | Top Issue |
|----------|-------|-------|-----------|
| Category Name | XX | X | One-line description |
| ...

### Detailed Findings
[Organized by category, each check showing PASS/WARNING/FAIL with evidence]

### Prioritized Action Plan
[Sorted by severity × impact, grouped into Immediate / This Week / This Month]
```

## CHECKS.md Convention

Each audit skill should have a `CHECKS.md` file with numbered, severity-tagged checks following this format:

```markdown
## Category Name (Weight: XX%)

### [ID]: Check Name [Severity, Multiplier]
- **Check:** What is being evaluated
- **Pass:** Criteria for PASS (1.0)
- **Warning:** Criteria for WARNING (0.5)
- **Fail:** Criteria for FAIL (0.0)
- **Quick Win:** Yes/No (estimated fix time)
```

Check IDs use platform prefix + category abbreviation + number:
- Google: `G-CT1` (Conversion Tracking), `G-WS1` (Wasted Spend), `G-ST1` (Structure), `G-KW1` (Keywords), `G-AD1` (Ads), `G-SE1` (Settings)
- Meta: `M-PX1` (Pixel/CAPI), `M-CR1` (Creative), `M-ST1` (Structure), `M-AU1` (Audience)
- Microsoft: `MS-TE1` (Technical), `MS-SB1` (Syndication/Bidding), `MS-SA1` (Structure/Audience), `MS-CE1` (Creative/Extensions), `MS-SP1` (Settings/Performance)

## How Skills Should Load This File

Audit skills should read `skills/shared/scoring-system.md` when producing a health score. Load it alongside the skill-specific `CHECKS.md` at audit invocation. Non-audit skills should not load this file.
