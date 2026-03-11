<div align="center">

# Paid Media Pack

**4 skills that give Claude Code deep expertise in paid media — Google Ads, Meta Ads, Microsoft Ads, and cross-platform account structure.**

[![GitHub stars](https://img.shields.io/github/stars/thatrebeccarae/dgtldept?style=for-the-badge&logo=github&color=181717)](https://github.com/thatrebeccarae/dgtldept/stargazers)
[![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)](../LICENSE)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Rebecca%20Rae%20Barton-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/rebeccaraebarton)
[![Substack](https://img.shields.io/badge/Substack-dgtl%20dept*-FF6719?style=for-the-badge&logo=substack&logoColor=white)](https://dgtldept.substack.com/welcome)

Audit Google Ads campaigns, diagnose Meta Ads creative fatigue, optimize Microsoft Ads imports, and review cross-platform account structure — all from natural language prompts in your terminal.

[**Getting Started**](paid-media-getting-started.md) · [**Back to Repo**](../README.md)

</div>

---

## What's Included

| Skill | What It Does | Includes |
|-------|-------------|----------|
| **[google-ads](../skills/google-ads/)** | Full account audit: campaigns, keywords, Quality Scores, bidding, PMax, Shopping, conversion tracking. Industry benchmarks and GAQL query patterns. | SKILL + REFERENCE + EXAMPLES + .env |
| **[facebook-ads](../skills/facebook-ads/)** | Meta Ads audit: campaign structure, audiences, creative fatigue, pixel/CAPI health, iOS 14.5+ attribution, Advantage+ readiness. | SKILL + REFERENCE + EXAMPLES + .env |
| **[microsoft-ads](../skills/microsoft-ads/)** | Microsoft Ads audit: Google import optimization, LinkedIn Profile Targeting, UET tracking, Shopping, Clarity integration. | SKILL + REFERENCE + EXAMPLES + .env |
| **[account-structure-review](../skills/account-structure-review/)** | Cross-platform structural audit: conversion volume thresholds, budget fragmentation, targeting overlap, consolidation roadmaps with migration plans. | SKILL + REFERENCE + EXAMPLES |

## How the Skills Connect

```
Google Ads (search, shopping, PMax, display, YouTube)
    |
    +--> Microsoft Ads (import optimization, LinkedIn targeting)
    |
    +--> Meta Ads (prospecting, retargeting, Advantage+)
    |
    +--> Account Structure Review (cross-platform structural health)
```

Each skill works independently — install only the ones you need. But they complement each other:

- Run a **Google Ads** audit, then use **Account Structure Review** to evaluate if the campaign count is sustainable
- Import from **Google Ads** to **Microsoft Ads** and optimize for Microsoft-specific features
- Use **Account Structure Review** before scaling budgets across any platform

## Quick Start

### Option 1: Interactive Wizard (Recommended)

```bash
git clone https://github.com/thatrebeccarae/dgtldept.git
cd dgtldept
python skill-packs/scripts/setup-paid-media.py
```

The wizard checks prerequisites, walks you through API key setup, installs dependencies, and tests connections.

### Option 2: Copy Skills Directly

```bash
cd dgtldept
for skill in google-ads facebook-ads microsoft-ads account-structure-review; do
  cp -r "skills/$skill" ~/.claude/skills/
done
```

> [!TIP]
> See [paid-media-getting-started.md](paid-media-getting-started.md) for detailed step-by-step instructions and API key setup per platform.

## Example Prompts

### Google Ads
- "Audit my Google Ads account and find wasted spend"
- "My Quality Scores are low — help me diagnose and fix"
- "Design a Performance Max campaign structure for my ecommerce store"

### Meta Ads (Facebook & Instagram)
- "Audit my Facebook Ads account performance"
- "My ROAS is declining — what should I investigate?"
- "Help me set up Conversions API (CAPI)"
- "Design a creative testing framework for my brand"

### Microsoft Ads
- "My Google Ads import isn't performing well on Microsoft — what should I change?"
- "Help me set up LinkedIn Profile Targeting for B2B"
- "Audit my Microsoft Ads account structure"

### Account Structure Review
- "Audit my Google + Meta account structure and identify consolidation opportunities"
- "My campaigns keep re-entering learning phase — is my structure the problem?"
- "What's the right campaign structure for a $50K/month budget?"

## FAQ

<details>
<summary><strong>Do I need all four skills?</strong></summary>

No. Install only the skills for platforms you use. Each skill works independently. If you only run Google Ads and Meta Ads, install those two plus Account Structure Review for cross-platform analysis.

</details>

<details>
<summary><strong>What API access is needed?</strong></summary>

Each platform needs its own API credentials. See [paid-media-getting-started.md](paid-media-getting-started.md) for step-by-step setup. Most skills work with read-only access. Account Structure Review needs no API — it's analysis-only.

</details>

<details>
<summary><strong>Can I use this without API keys?</strong></summary>

Yes. Claude still has full platform expertise without API access. You'll need to provide data manually (paste metrics, share screenshots, export CSVs). API keys enable automated data pulling via scripts.

</details>

<details>
<summary><strong>How is this different from each platform's built-in tools?</strong></summary>

Platform tools optimize within their own ecosystem. This skill pack gives Claude cross-platform diagnostic expertise: it can compare your Google Ads and Meta Ads structure side by side, identify where budget fragmentation or audience overlap is costing you money, and produce implementation-ready consolidation plans with migration roadmaps.

</details>

## Resources

- [Google Ads API Documentation](https://developers.google.com/google-ads/api/docs/start)
- [Meta Marketing API Documentation](https://developers.facebook.com/docs/marketing-apis/)
- [Microsoft Advertising API Documentation](https://learn.microsoft.com/en-us/advertising/guides/get-started)
- [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code)

## License

MIT — see [LICENSE](../LICENSE) for details.
