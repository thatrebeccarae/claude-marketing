Google and Meta paid media account structure evaluation. Audits campaign/ad set architecture against conversion volume minimums, budget thresholds, and targeting overlap. Identifies over-segmentation, under-segmentation, budget fragmentation, and structural anti-patterns blocking algorithmic learning. Provides consolidation roadmaps with migration plans. Use when inheriting accounts, quarterly health checks, or before scaling budgets.


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


(Truncated. See full skill at github.com/thatrebeccarae/claude-marketing)
