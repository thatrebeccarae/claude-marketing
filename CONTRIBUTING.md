# Contributing

Thanks for your interest in contributing to claude-marketing. Whether it's a bug report, a new skill idea, or a documentation improvement — it all helps.

## What We're Looking For

- **Bug reports** — something broken? [Open an issue](https://github.com/thatrebeccarae/claude-marketing/issues/new?template=bug_report.md)
- **Skill suggestions** — ideas for new skills or improvements to existing ones
- **Documentation fixes** — typos, unclear instructions, missing steps
- **New skills** — production-tested skills for marketing platforms, analytics, or data visualization

## Getting Started

1. **Fork** the repository
2. **Clone** your fork:
   ```bash
   git clone https://github.com/YOUR_USERNAME/claude-marketing.git
   cd claude-marketing
   ```
3. **Create a branch** for your changes:
   ```bash
   git checkout -b feature/your-skill-name
   ```

## Submitting a Skill

Every skill needs at minimum:

| File | Purpose |
|------|---------|
| `SKILL.md` | Frontmatter + instructions Claude reads at invocation |
| `REFERENCE.md` | Platform-specific reference data (benchmarks, API schemas, field mappings) |
| `EXAMPLES.md` | Working examples with realistic prompts and expected output |

### SKILL.md Frontmatter

```yaml
---
name: your-skill-name
description: "One-line description of what the skill does"
license: MIT
origin: custom
author: Your Name
author_url: https://github.com/your-username
metadata:
  version: 1.0.0
  category: paid-media | dtc | content | strategy | creative | reporting | dev-tools
  domain: the-platform-or-focus-area
  updated: YYYY-MM-DD
---
```

### Quality Checklist

Before submitting, verify:

- [ ] Skill has been tested with Claude Code (not just written — actually used)
- [ ] REFERENCE.md contains real benchmarks, schemas, or platform data
- [ ] EXAMPLES.md prompts produce useful, accurate output
- [ ] No API keys, secrets, or PII in any files
- [ ] Scripts include input validation and error handling
- [ ] Works without MCP servers (graceful degradation if no live API access)

## Pull Request Process

1. **Branch naming:** `feature/skill-name`, `fix/issue-description`, or `docs/what-changed`
2. **Keep PRs focused** — one skill or one fix per PR
3. **Fill out the PR template** — it's short, and it helps review go faster
4. **Test your changes** — run the skill with Claude Code and confirm the output makes sense

PRs are reviewed within a week. If your skill needs iteration, you'll get specific feedback on what to adjust.

## Style Guide

### Skill Naming

- Lowercase, hyphenated: `klaviyo-analyst`, `google-analytics`, `pro-deck-builder`
- Name describes the platform or capability, not the implementation

### Documentation

- Write for someone who knows their platform but is new to Claude Code skills
- Be specific — "click the gear icon" beats "go to settings"
- Include real numbers in benchmarks (with sources or date ranges)

### Scripts

- Python 3.8+ compatible
- Include input validation for file paths, API keys, and user input
- Use `argparse` for CLI scripts
- Follow the existing patterns in `scripts/` directories

## Code of Conduct

Be kind. Be constructive. Assume good intent.

This is a small project. We don't need a 2,000-word conduct policy to treat each other well. If you're here to help people do better marketing with better tools, you're welcome.

If someone's behavior makes contributing feel unwelcome, email **security@rebeccaraebarton.com** and it'll be handled directly.

## Shared References

Cross-skill reference files live in `skills/shared/`. These provide shared data and conventions that multiple skills can load:

| File | Purpose | Used By |
|------|---------|---------|
| `scoring-system.md` | Weighted audit scoring algorithm, severity multipliers, grade thresholds | All audit-oriented skills |

### Reference Loading Convention

- Skills always load their own `REFERENCE.md` at invocation
- Skills may load files from `skills/shared/` when they need cross-cutting data (scoring, benchmarks)
- Skills should **never** load another skill's `REFERENCE.md` directly
- Reference files should be optimized for token efficiency (tables over paragraphs, no redundancy)

## CHECKS.md Convention (Audit Skills)

Audit-oriented skills (google-ads, facebook-ads, microsoft-ads, account-structure-review, wasted-spend-finder, klaviyo-analyst, shopify) should include a `CHECKS.md` file with numbered, severity-tagged checks.

### Check Format

```markdown
### [ID]: Check Name [Severity, Multiplier]
- **Check:** What is being evaluated
- **Pass:** Criteria for PASS (1.0)
- **Warning:** Criteria for WARNING (0.5)
- **Fail:** Criteria for FAIL (0.0)
- **Quick Win:** Yes/No (estimated fix time)
```

### Check ID Convention

IDs use platform prefix + category abbreviation + number:
- Google: `G-CT1`, `G-WS1`, `G-ST1`, `G-KW1`, `G-AD1`, `G-SE1`
- Meta: `M-PX1`, `M-CR1`, `M-ST1`, `M-AU1`
- Microsoft: `MS-TE1`, `MS-SB1`, `MS-SA1`, `MS-CE1`, `MS-SP1`

### Scored Output

When a skill has CHECKS.md, it should produce a health score (0-100, grade A-F) using the algorithm in `skills/shared/scoring-system.md`. Output must include Quick Wins, Category Breakdown, and Prioritized Action Plan sections.

## Hard Rules

Audit skills should include a `## Hard Rules` section in their `SKILL.md`. These are non-negotiable constraints that Claude must never violate when making recommendations (e.g., "Never recommend Broad Match without Smart Bidding"). Hard rules protect against recommendations that could waste budget or break compliance.

## Cross-Skill Orchestration Pattern

Some skills orchestrate other skills by spawning parallel tasks. The pattern:

1. **Orchestrator skill** collects context from the user (business type, platforms, budgets, goals)
2. **Spawns sub-tasks** via Claude Code's Task tool — one per platform or analysis dimension
3. Each sub-task **loads its own skill files** (SKILL.md, CHECKS.md, REFERENCE.md) and produces structured results
4. **Orchestrator reads all results** and merges into a unified report
5. **Cross-cutting analysis** adds intelligence that no single-skill audit can provide
6. Optionally **pipes to a reporting skill** (e.g., pro-deck-builder) for a client-ready deliverable

The `cross-platform-audit` skill is the reference implementation. Future orchestrator skills (e.g., a full DTC audit running Klaviyo + Shopify + GA4 in parallel) should follow this same pattern.

### Key Rules for Orchestrator Skills

- Sub-tasks must be **independent** — they should not depend on each other's output
- Each sub-task should produce a **self-contained result** that the orchestrator can read and merge
- The orchestrator is responsible for **cross-cutting analysis** that spans multiple sub-task results
- Sub-tasks should load `skills/shared/scoring-system.md` for consistent scoring across platforms
