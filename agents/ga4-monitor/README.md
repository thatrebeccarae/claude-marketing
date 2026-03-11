# GA4 Monitor

**Compares your live GA4 event data against a tracking spec and flags gaps, unexpected events, and volume anomalies.**

[![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)](../../LICENSE)

## What It Does

Pulls your GA4 event inventory and compares it against a defined tracking spec (JSON). Outputs a structured comparison identifying:

- **Gaps** — events in your spec that aren't firing in GA4
- **Unexpected events** — events firing in GA4 that aren't in your spec
- **Anomalies** — volume drops or spikes that suggest tracking breakage

Works standalone for one-time audits or as the first stage of the [GA4-GTM Pipeline](../../workflows/ga4-gtm-pipeline/).

## What's Included

```
ga4-monitor/
├── schemas/
│   ├── client-config.schema.json    # Per-property configuration schema
│   └── event-spec.schema.json       # Tracking spec schema (expected events)
├── scripts/
│   ├── compare-events.js            # Core comparison engine
│   ├── validate-client-config.py    # Config validator (standalone CLI)
│   └── validate-event-spec.py       # Event spec validator (standalone CLI)
└── test-data/
    └── ga4-sample-response.json     # Sample GA4 API response for testing
```

## Usage

### Validate Your Tracking Spec

```bash
python agents/ga4-monitor/scripts/validate-event-spec.py path/to/event-spec.json
```

### Validate a Property Config

```bash
python agents/ga4-monitor/scripts/validate-client-config.py path/to/client-config.json
```

### Comparison Engine

`compare-events.js` takes GA4 event data and an event spec as input and returns a structured comparison object with flags (`gaps_found`, `anomalies_found`, `all_clear`). Currently designed as an n8n Code node script — see the [GA4-GTM Pipeline](../../workflows/ga4-gtm-pipeline/) for orchestrated usage.

## Event Spec Format

Define expected events following `schemas/event-spec.schema.json`. Each event includes:

- Event name and group (e.g., "ecommerce", "engagement")
- Expected parameters
- GTM implementation config (tag type, trigger conditions, variable dependencies)
- Priority level for gap analysis

## License

MIT — see [LICENSE](../../LICENSE) for details.
