# GTM Implementer

**Creates GTM variables, triggers, and tags from gap analysis output — rate-limited, idempotent, and workspace-isolated.**

[![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)](../../LICENSE)

## What It Does

Takes structured output from the [GA4 Gap Analyzer](../ga4-gap-analyzer/) and creates the corresponding GTM resources via the GTM API v2:

1. **Preflight check** — verifies workspace availability (free GTM accounts allow 3 workspaces) and rejects server-side containers
2. **Payload construction** — transforms analysis + event spec into GTM API payloads for variables, triggers, and tags
3. **Rate-limited writes** — creates resources with 4-second delays between API calls, deduplicates against existing resources

All changes land in a named workspace (`claude-{purpose}-{date}`), never in the default workspace. The service account intentionally lacks publish permission — a human must review and publish in the GTM UI.

## What's Included

```
gtm-implementer/
└── scripts/
    ├── workspace-preflight.js     # Checks GTM workspace availability + sGTM safety guard
    ├── build-gtm-resources.js     # Transforms analysis into GTM API payloads (incl. AEO scaffold)
    └── execute-gtm-writes.js      # Rate-limited, idempotent GTM API writes
```

## Safety Model

- **Rate-limited:** 4-second delays between GTM API calls (respects quotas)
- **Idempotent:** detects existing resources by name and skips duplicates
- **Workspace-isolated:** changes land in a named workspace, never the default
- **No publish permission:** the service account cannot publish containers by design
- **Preflight checks:** verifies workspace availability before attempting creation
- **Server-side container guard:** sGTM containers are detected and rejected (this agent is web-only)

## Write Order

Resources are created in dependency order:
1. Variables (data layer variables, constants, custom JavaScript)
2. Triggers (event triggers referencing variables)
3. Tags (GA4 event tags referencing triggers)

## Server-Side GTM (sGTM)

`workspace-preflight.js` detects server-side containers via the GTM API response and exits with `route: "unsupported_container_type"`. The downstream tag/trigger/variable builders emit web-container payloads (`gaawe`, `gaawc`) that don't apply to sGTM's resource model. Server-side support is out of scope today; the guard prevents creating broken resources.

If you need sGTM support: fork the implementer, swap the tag types and trigger logic for sGTM's Client/Tag model, and wire it as a separate code path keyed on `container_type`.

## AEO Scaffolding

When `clientConfig.aeo_tracking_enabled === true`, `build-gtm-resources.js` automatically appends a self-contained `ai_referral` scaffold to the workspace:

- **Custom JavaScript variable** `cjs_ai_referrer_host` — matches `document.referrer` against an AI host regex (`chatgpt.com|claude.ai|perplexity.ai|gemini.google.com|copilot.microsoft.com|grok.com|x.ai|meta.ai|you.com|chat.openai.com`) and returns the matched host or empty string
- **Pageview trigger** `PV - ai_referral` — fires when the variable returns a non-empty host
- **GA4 Event tag** `GA4 Event - ai_referral` — sends an `ai_referral` event with `ai_referrer_host` parameter set to the matched host

This complements the [Gap Analyzer's AEO awareness](../ga4-gap-analyzer/README.md#aeo-awareness): the analyzer flags `ai_referral` as a missing event in `quick_wins`, and this builder constructs the actual GTM resources.

The scaffold is skipped when:
- The client's event spec already defines an `ai_referral` event (the spec wins; the standard event-builder handles it)
- `measurement_id` is absent from the client config (the GA4 Configuration tag dependency is unavailable)
- `aeo_tracking_enabled` is unset or `false`

Note that ~70% of LLM-referred traffic still lands as Direct in GA4 because the referrer is stripped by the source (especially ChatGPT free tier and Google AI Mode). The `ai_referral` event captures the fraction that does pass referrer; pair it with a custom Channel Group "AI Assistants" in GA4 for reporting.

## Consent Mode v2

This implementer does not currently audit Consent Mode v2 wiring. Google's `ad_storage` / Signals split lands **2026-06-15**, with material behavior changes for tags that today fire under Signals consent. If you serve EU/UK traffic, verify Consent Mode v2 manually in the GTM UI before publishing any workspace this agent creates.

A future enhancement could add a Consent Mode v2 preflight check; not in scope today (audit 2026-04 demoted this to P3 because the current client base is US-only).

## License

MIT — see [LICENSE](../../LICENSE) for details.
