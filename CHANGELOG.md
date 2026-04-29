# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/), and this project adheres to [Semantic Versioning](https://semver.org/).

## [1.8.0] - 2026-04-29

Audit 2026-04 — agent-script modernization across `ga4-gap-analyzer`, `ga4-monitor`, and `gtm-implementer`. See `.planning/ROADMAP.md` plan 05-03 for the full audit context. The remaining W4 (n8n workflow JSON re-wiring) stays in the parking lot pending parallel pipeline work.

### Changed

- **`ga4-gap-analyzer` modernization (W1)** — gap analysis now uses Claude Opus 4.6 with adaptive thinking (`thinking: { type: "adaptive" }`) instead of Sonnet 4.6 standard. Trades higher per-call cost for stronger root-cause reasoning on missing events. Anomaly analysis still on Haiku 4.5 (unchanged — fast pattern matching is the right shape there).
- **`ga4-gap-analyzer` AEO awareness** — when the client config sets `aeo_tracking_enabled: true`, the gap-analysis system prompt is augmented with LLM-traffic context (~70% Direct attribution caveat, AI referrer host regex, `ai_referral` event scaffold recommendation). Default (`false` or unset) preserves baseline prompt behavior.

### Added

- **`agents/ga4-gap-analyzer/AB_TEST_OPUS_4_7.md`** — sidecar A/B test plan for evaluating Opus 4.7 against the Opus 4.6 baseline once initial production data is available. Covers token-efficiency, cost, latency, and quality decision criteria.
- **Per-client model override** — `gap_analysis.model` and `gap_analysis.max_tokens` fields in the client config now flow through to the Anthropic request body, enabling A/B testing without code changes.

### Documentation

- **`agents/ga4-gap-analyzer/README.md`** rewritten — new "Reasoning model" section explains the Opus + adaptive thinking choice and the forced-tool-use tradeoff; new "AEO awareness" section documents the `aeo_tracking_enabled` flag; cost notes recalibrated for the new model + thinking pricing.
- **`agents/ga4-monitor/README.md`** rewritten — new "Auto-Collected Event Exclusion List" and "Anomaly Detection" sections document the data file, the `auto`/`binary`/`rolling_zscore` method modes, and the upstream input shape required for multi-baseline detection.

### Changed (W2)

- **`ga4-monitor` auto-event exclusion list externalized** — moved from a 6-event hardcoded set inside `compare-events.js` to `data/ga4-auto-events.json`. The new list covers GA4's full Enhanced Measurement set (form_*, video_*, file_download, view_search_results) plus mobile-app events (first_open, screen_view, notification_*) that today get false-flagged as "unexpected." The script reads from a `Read Auto Events` n8n node when available; falls back to an embedded synced copy otherwise.
- **`ga4-monitor` multi-baseline anomaly detection** — replaces the binary "previous count >100, now exactly 0" check with a multi-baseline approach: rolling 7-day mean + z-score, same-day-last-week, same-day-4-weeks-ago. Alerts only when ≥2 of 3 baselines flag the same event. Catches partial drops the old check missed; avoids false-fires on legitimate event deletions. Configurable via `anomaly_detection.{method,min_history_days,z_threshold,drop_floor_pct}`. Defaults to `auto` mode — uses rolling_zscore when enough history, falls back to binary otherwise.

### Added (W2)

- **`agents/ga4-monitor/data/ga4-auto-events.json`** — canonical GA4 auto-event exclusion list, organized by category (`automatic`, `enhanced_measurement_web`, `enhanced_measurement_mobile`).
- **Client config schema additions** (`schemas/client-config.schema.json`):
  - `aeo_tracking_enabled: bool` — toggles AEO context injection in W1's gap-analyzer prompt
  - `anomaly_detection: object` — knobs for the new W2 multi-baseline detection
  - `gap_analysis: object` — backports W1's `model` and `max_tokens` overrides into the schema (previously the script accepted these but the schema rejected them)
- **Event spec schema** (`schemas/event-spec.schema.json`) — `trigger_type` enum bumped to include `CLICK`, `LINK_CLICK`, `FORM_SUBMISSION` (the GTM Implementer already handles these; the schema previously didn't allow them).

### Changed (W3)

- **`gtm-implementer` server-side container guard** — `workspace-preflight.js` now detects sGTM containers via the GTM API response and exits with `route: "unsupported_container_type"` instead of falling through to the web-container resource builders. The downstream `gaawe`/`gaawc` payloads don't apply to sGTM's resource model; this prevents creating broken resources.
- **`gtm-implementer` AEO scaffold** — when `aeo_tracking_enabled: true` and the spec doesn't already define `ai_referral`, `build-gtm-resources.js` appends a self-contained scaffold: a Custom JS variable matching `document.referrer` against the AI host regex, a pageview trigger keyed on the variable, and a GA4 Event tag posting the matched host as an event parameter. Idempotent — the existing resource-name dedup handles re-runs.

### Added (W3)

- **`agents/gtm-implementer/README.md`** — new "Server-Side GTM (sGTM)" section documenting the safety guard, "AEO Scaffolding" section documenting the `ai_referral` resources, and a "Consent Mode v2" awareness note (P3 — not implemented; current US-only client base).
- **`workflows/ga4-gtm-pipeline/architecture.md`** — model reference updated from stale `claude-sonnet-4-20250514` to current Opus 4.6 + adaptive thinking; cost table notes calibration is now per-client; tech stack row reflects Opus + Haiku split.

## [1.7.0] - 2026-04-21

### Changed

- **Renamed `gtm` skill to `google-tag-manager`** — the `name:` frontmatter field now matches the folder name (`skills/google-tag-manager/`), restoring consistency with every other skill in the catalog. Install commands, catalog entries, and generated integrations/ files updated.

### Documentation

- **CHANGELOG backfill** — previously undocumented skills from 2026-03-18 and 2026-03-19 added to their corresponding version entries. The `skills/` directory now matches what the CHANGELOG claims is shipped.

## [1.6.0] - 2026-03-19

### Added

- **Quickstart site** — hosted walkthrough at [/quickstart.html](https://thatrebeccarae.github.io/claude-marketing/quickstart.html) covering install, top picks, the full catalog, compatibility matrix, and common fixes. Catalog-driven search indexes every skill's description and capabilities.
- **DevOps pack** (6 skills): `repo-health`, `repo-scaffold`, `sync-repos`, `release-notes`, `social-preview`, `dep-audit`
- **google-tag-manager** — standalone GTM expertise skill (container auditing, tag architecture, consent mode v2, server-side tagging). Replaces the inline GTM guidance previously split across google-analytics and the GTM Implementer agent.
- **llms-txt** — `/llms.txt` manifest generator for AI answer-engine discoverability. Complements the AEO stack.

## [1.5.0] - 2026-03-18

### Added

- **Multi-Tool Support** — Skills now work with Cursor, Aider, Windsurf, GitHub Copilot, and Gemini CLI in addition to Claude Code
- **convert.sh** — Transforms all skills into 5 tool-specific formats; handles YAML frontmatter extraction, Windsurf size limits, and Gemini @import structure without external dependencies
- **install.sh** — Interactive installer with auto-detection for installed tools; installs to correct location per tool
- **integrations/** — Pre-built converted output for all 5 tools, committed and ready to copy into any project
- **CI validation** — Workflow checks integrations/ for drift from source skills and validates format compliance on every push
- **21 new skills shipped alongside multi-tool support** across content, SEO/AEO, growth, email, paid media, reporting, and strategy:
  - **Content** (4): `brand-voice-guidelines`, `content-creator`, `content-pipeline`, `copywriting-frameworks`
  - **SEO & AEO** (5): `aeo-geo-optimizer`, `schema-markup-generator`, `technical-seo-audit`, `programmatic-seo`, `utm-attribution-strategy`
  - **Growth & Conversion** (4): `ab-testing-framework`, `cro-auditor`, `landing-page-optimizer`, `pricing-strategy`
  - **Email & Lifecycle** (3): `cold-email-outreach`, `customer-journey-mapping`, `retention-churn-prevention`
  - **Paid Media** (2): `linkedin-ads`, `tiktok-ads`
  - **Strategy & Research** (1): `social-media-strategy`
  - **Reporting & Deliverables** (2): `data-viz-deck`, `pro-report-builder`

## [1.4.0] - 2026-03-16

### Added

- **Unified Scoring System** — Weighted audit scoring algorithm with severity multipliers (Critical 5.0, High 2.5, Medium 1.5, Low 0.5), A-F health grades, Quick Wins identification, and cross-platform budget-weighted aggregation
  - New `skills/shared/scoring-system.md` — shared scoring methodology for all audit skills
  - New `skills/shared/README.md` — index for shared cross-skill references
- **Google Ads CHECKS.md** — 74 numbered, severity-tagged audit checks across 6 categories (Conversion Tracking 25%, Wasted Spend 20%, Structure 15%, Keywords 15%, Ads 15%, Settings 10%)
- **Meta Ads CHECKS.md** — 46 numbered, severity-tagged audit checks across 4 categories (Pixel/CAPI 30%, Creative 30%, Structure 20%, Audience 20%)
- **Microsoft Ads CHECKS.md** — 30 numbered, severity-tagged audit checks across 5 categories (Technical 25%, Syndication 20%, Structure 20%, Creative 20%, Settings 15%)
- **Hard Rules** sections added to Google Ads, Meta Ads, and Microsoft Ads SKILL.md — non-negotiable constraints Claude must never violate in recommendations
- **Scored Audit examples** added to all three paid media EXAMPLES.md — health score output with category breakdown, Quick Wins, and prioritized action plans
- **CHECKS.md convention** documented in CONTRIBUTING.md — standardized format for audit skills with check IDs, severity tags, and Pass/Warning/Fail criteria
- **Shared References convention** documented in CONTRIBUTING.md — cross-skill reference loading pattern
- **Cross-Platform Audit** — New orchestrator skill that spawns parallel scored audits across Google Ads, Meta Ads, and Microsoft Ads, merges into budget-weighted aggregate health score (A-F), adds cross-platform analysis (budget allocation, tracking consistency, creative alignment, attribution overlap, kill list, scaling opportunities), and optionally generates client-ready decks via pro-deck-builder
  - New `skills/cross-platform-audit/SKILL.md` — orchestration workflow with context intake, parallel task spawning, result merging, and cross-platform intelligence
  - New `skills/cross-platform-audit/REFERENCE.md` — cross-platform benchmarks, attribution setup, budget allocation frameworks, kill list criteria
  - New `skills/cross-platform-audit/EXAMPLES.md` — full worked example with 3-platform audit, cross-platform analysis, and 90-day action plan
- **Brand DNA** — New skill that extracts brand identity (voice, colors, typography, imagery, values, audience) from a website URL into a structured `brand-profile.json` consumed by downstream skills
  - New `skills/brand-dna/SKILL.md` — extraction workflow using WebFetch (zero external dependencies)
  - New `skills/brand-dna/REFERENCE.md` — brand-profile.json schema with field reference and CSS extraction targets
  - New `skills/brand-dna/EXAMPLES.md` — full extraction, quick mode, downstream usage, and competitor comparison examples
- **Brand Context sections** added to seo-content-writer, email-composer, frontend-design, and pro-deck-builder — each skill now reads brand-profile.json when present for brand-consistent output
- **Cross-Platform Audit** — New orchestrator skill that spawns parallel scored audits across Google Ads, Meta Ads, and Microsoft Ads, merges into budget-weighted aggregate health score (A-F), adds cross-platform analysis (budget allocation, tracking consistency, creative alignment, attribution overlap, kill list, scaling opportunities), and optionally generates client-ready decks via pro-deck-builder
  - New  — orchestration workflow with context intake, parallel task spawning, result merging, and cross-platform intelligence
  - New  — cross-platform benchmarks, attribution setup, budget allocation frameworks, kill list criteria
  - New  — full worked example with 3-platform audit, cross-platform analysis, and 90-day action plan

### Changed

- Updated README skill descriptions for Google Ads, Meta Ads, and Microsoft Ads to reflect scored audit capabilities
- Fixed remaining dgtl dept* references in README.md and CONTRIBUTING.md


## [1.3.0] - 2026-03-13

### Added

- **14 new skills** across 5 categories:
  - **Content**: SEO Content Writer, Content Workflow, Email Composer
  - **Strategy & Research**: Market Research, ICP Research, Research Digest
  - **Creative & Design**: Frontend Design, Tech Diagram, Remotion Video
  - **Reporting & Deliverables**: HTML Report Builder
  - **Developer Tools**: Safe Push, GitHub README
  - **Paid Media**: Competitor Ads Analyst, Wasted Spend Finder
- **4 new skill packs** with pack-specific taglines, "Who This Is For" sections, and FAQ:
  - Content Pack (3 skills)
  - Strategy & Research Pack (3 skills)
  - Creative & Design Pack (3 skills)
  - Developer Tools Pack (2 skills)

### Changed

- **Paid Media Pack** expanded from 4 to 6 skills (added Competitor Ads Analyst, Wasted Spend Finder)
- **README rewritten**: 7 category tables, Claude Code definition for first-time visitors, "Why This Exists" replacing first-person "Why I Built This," heading hierarchy fixes, nav updated
- **Skill Packs section** promoted to H2, "How It Works > Skill Packs" renamed to "How Skills Work" with AEO-ready skill definition
- CONTRIBUTING.md frontmatter example updated to match actual SKILL.md schema
- Total skill count: 11 → 25
- Total skill packs: 2 → 6

## [1.2.0] - 2026-03-11

### Added

- **Paid Media Pack** — 4 skills for paid advertising (`skill-packs/paid-media-pack.md`)
  - Google Ads: Campaign auditing, Quality Score optimization, PMax, Shopping, bidding strategies, GAQL queries
  - Meta Ads (Facebook & Instagram): Account audit, creative fatigue diagnosis, pixel/CAPI health, Advantage+ evaluation, iOS 14.5+ attribution
  - Microsoft Ads (Bing): Google import optimization, LinkedIn Profile Targeting, UET tracking, Shopping campaigns, Clarity integration
  - Account Structure Review: Cross-platform structural audit with conversion volume thresholds, budget fragmentation analysis, targeting overlap detection, consolidation roadmaps
- **Braze** — Standalone skill for Braze customer engagement (`skills/braze/`)
  - Canvas audit, segmentation review, cross-channel orchestration, data architecture, deliverability and IP warming
- Interactive setup wizard for Paid Media Pack (`skill-packs/scripts/setup-paid-media.py`)
- Getting started guide for paid media platforms (`skill-packs/paid-media-getting-started.md`)

### Changed

- **Restructured repo layout**: flat `skills/` for all 11 individual skills, `skill-packs/` for curated collection docs and setup wizards, `agents/` for standalone agent logic, `workflows/` for n8n orchestration
- Extracted 3 standalone agents from analytics-agents workflow: GA4 Monitor, GA4 Gap Analyzer, GTM Implementer — each usable independently without n8n
- Renamed `workflows/analytics-agents/` → `workflows/ga4-gtm-pipeline/` for platform-clear naming
- Updated root README with Paid Media Pack in "What's Inside" table and new "Skill Packs" section
- Updated "Coming Soon" — Google Ads and Meta Ads are now shipped

## [1.1.0] - 2026-03-09

### Added

- **Analytics Agents** — autonomous GA4 monitoring + GTM implementation pipeline (`workflows/analytics-agents/`)
  - Daily GA4 event monitoring with tracking spec comparison
  - Claude Sonnet gap analysis with GTM implementation recommendations
  - Claude Haiku anomaly detection for event volume drops/spikes
  - Rate-limited, idempotent GTM tag/trigger/variable creation in isolated workspaces
  - Slack notifications at every pipeline stage
  - Multi-tenant design (one pipeline, multiple GA4 properties)
  - JSON schemas for client config and event spec validation
  - Comprehensive getting-started guide for non-technical users
- New top-level `workflows/` category for autonomous n8n + Claude pipelines

### Changed

- Repositioned claude-marketing from "Claude Code skills" to a broader toolkit: skills, agent workflows, and automation pipelines for solo marketers and small teams
- Updated root README with new positioning, "What's Inside" overview, and Agent Workflows section
- Private development repo (`claude-marketing-dev`) with `sync-public.sh` for PII-safe downstream sync

### Removed

- LinkedIn Data Viz (moved to [linkedin-toolkit](https://github.com/thatrebeccarae/linkedin-toolkit))

## [1.0.0] - 2026-02-23

### Added

- **DTC Skill Pack** — 6 production-tested skills for e-commerce marketing
  - Klaviyo Analyst: 4-phase account audit, flow gap analysis, segment health, deliverability diagnostics, revenue attribution
  - Klaviyo Developer: Event schema design, SDK integration, webhook handling, rate limit strategy, catalog sync
  - Shopify: 12-step store audit, conversion funnel analysis, site speed diagnostics
  - Google Analytics: GA4 traffic analysis, channel comparison, conversion funnels
  - Looker Studio: Cross-platform dashboards via Google Sheets pipeline, DTC templates
  - Pro Deck Builder: Polished HTML slide decks and PDF-ready reports
- **LinkedIn Data Viz** — 9 interactive visualizations from LinkedIn data exports (D3.js, Chart.js)
- Interactive setup wizard with API key validation and health checks
- Live demos for [DTC Skill Pack](https://thatrebeccarae.github.io/claude-marketing/skills/dtc-skill-pack/demo/) and [LinkedIn Data Viz](https://thatrebeccarae.github.io/claude-marketing/skills/linkedin-data-viz/demo/)
- SECURITY.md, CONTRIBUTING.md, and GitHub issue/PR templates
