<div align="center">

# Claude Code Skills

**Open-source skill packs that give Claude Code deep expertise in DTC marketing, data visualization, and presentation generation.**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/thatrebeccarae/claude-code-skills?style=flat)](https://github.com/thatrebeccarae/claude-code-skills/stargazers)
[![Skills](https://img.shields.io/badge/Skills-8-5B5F8D)](skill-packs/dtc-skill-pack/)

Install a skill, use natural language. Audit Klaviyo flows, analyze Shopify funnels, build Looker Studio dashboards, generate polished slide decks — all from your terminal.

[**DTC Skill Pack Demo**](https://thatrebeccarae.github.io/claude-code-skills/skill-packs/dtc-skill-pack/demo/) · [**LinkedIn Data Viz Demo**](https://thatrebeccarae.github.io/claude-code-skills/skills/linkedin-data-viz/demo/) · [**Getting Started**](skill-packs/dtc-skill-pack/GETTING_STARTED.md)

</div>

---

## Why This Exists

Claude Code is powerful out of the box, but it doesn't know the difference between a good and great abandoned cart flow. It can't tell you that a 1.2% click rate on your welcome series is below benchmark, or that your Shopify checkout completion rate signals a shipping cost surprise.

These skills give Claude **domain expertise** — the same frameworks, benchmarks, and diagnostic patterns a senior DTC marketing consultant would use. Install what you need, ask in plain English, get implementation-ready answers.

## Skill Packs

### [DTC Skill Pack](skill-packs/dtc-skill-pack/) — 6 skills for e-commerce marketing

> [**View Live Demo**](https://thatrebeccarae.github.io/claude-code-skills/skill-packs/dtc-skill-pack/demo/) — See all 6 skills in action with example terminal output.

| Skill | What Claude Can Do |
|-------|-------------------|
| **[Klaviyo Analyst](skill-packs/dtc-skill-pack/klaviyo-analyst/)** | 4-phase account audit, flow gap analysis, segment health, deliverability diagnostics, revenue attribution, three-tier recommendations with implementation specs |
| **[Klaviyo Developer](skill-packs/dtc-skill-pack/klaviyo-developer/)** | Event schema design, SDK integration, webhook handling, rate limit strategy, catalog sync, integration health audit |
| **[Shopify](skill-packs/dtc-skill-pack/shopify/)** | 12-step store audit, conversion funnel analysis, site speed diagnostics, marketing stack integration |
| **[Google Analytics](skill-packs/dtc-skill-pack/google-analytics/)** | GA4 traffic analysis, channel comparison, conversion funnels, content performance |
| **[Looker Studio](skill-packs/dtc-skill-pack/looker-studio/)** | Cross-platform dashboards via Google Sheets pipeline, DTC dashboard templates, calculated field library |
| **[Pro Deck Builder](skill-packs/dtc-skill-pack/pro-deck-builder/)** | Polished HTML slide decks and PDF-ready reports with dark cover pages and warm light content slides |

### [LinkedIn Data Viz](skills/linkedin-data-viz/) — Interactive career visualizations

> [**View Live Demo**](https://thatrebeccarae.github.io/claude-code-skills/skills/linkedin-data-viz/demo/)

Turn a LinkedIn data export into 9 interactive visualizations: D3.js network graphs, Chart.js charts, career timelines. Includes onboarding wizard, dark theme, and privacy-safe sanitization for publishing.

## Quick Start

### DTC Skill Pack

```bash
# Clone and run the setup wizard
git clone https://github.com/thatrebeccarae/claude-code-skills.git
cd claude-code-skills/skill-packs/dtc-skill-pack
python scripts/setup.py
```

The wizard handles API keys, dependencies, and connection testing.

<details>
<summary><strong>Manual install (skip the wizard)</strong></summary>

```bash
# Copy all 6 skills
for skill in klaviyo-analyst klaviyo-developer google-analytics shopify looker-studio pro-deck-builder; do
  cp -r claude-code-skills/skill-packs/dtc-skill-pack/$skill ~/.claude/skills/
done
```

See [GETTING_STARTED.md](skill-packs/dtc-skill-pack/GETTING_STARTED.md) for API key setup per platform.

</details>

### LinkedIn Data Viz

```bash
git clone https://github.com/thatrebeccarae/claude-code-skills.git
cp -r claude-code-skills/skills/linkedin-data-viz ~/.claude/skills/
```

Then say: **"Analyze my LinkedIn data export"**

## Example Prompts

```
"Audit my Klaviyo flows and identify which essential flows I'm missing"

"My checkout completion rate is 31% — what's causing the drop-off?"

"Which traffic sources are driving the most conversions this month?"

"Plan a CRM dashboard reconciling Klaviyo and Shopify data"

"Create a dark-mode deck summarizing this month's email performance"

"Debug why my webhook events aren't triggering flows"
```

## Documentation

| Resource | Description |
|----------|-------------|
| [DTC Skill Pack README](skill-packs/dtc-skill-pack/README.md) | Skill details, architecture, MCP server setup, example prompts, FAQ |
| [DTC Getting Started](skill-packs/dtc-skill-pack/GETTING_STARTED.md) | Step-by-step setup for each platform |
| [LinkedIn Data Viz SKILL.md](skills/linkedin-data-viz/SKILL.md) | Wizard flow, visualization descriptions |
| [LinkedIn Data Viz REFERENCE.md](skills/linkedin-data-viz/REFERENCE.md) | CSV schemas, parsing quirks, theme customization |

## Security

All scripts include input validation, path sanitization, SSRF protection, and secure credential handling. API keys are stored in `.env` files (gitignored) and never hardcoded. All API access is read-only by default.

## License

[MIT](LICENSE) — built by [Rebecca Rae Barton](https://linkedin.com/in/rebeccaraebarton)
