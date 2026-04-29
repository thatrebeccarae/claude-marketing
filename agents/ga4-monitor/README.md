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
├── data/
│   └── ga4-auto-events.json         # GA4 auto-collected + Enhanced Measurement events (exclusion list)
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

## Auto-Collected Event Exclusion List

GA4 fires platform-default events (page views, sessions, scroll, video, file downloads, etc.) that aren't part of any client tracking spec. The comparison engine filters these out before flagging "unexpected events" — otherwise every report would be drowned in noise.

The canonical list lives at `data/ga4-auto-events.json`, organized by category:

- **`automatic`** — fired by GA4 with no configuration (page_view, session_start, first_visit, etc.)
- **`enhanced_measurement_web`** — Enhanced Measurement web events (scroll, click, video_*, form_*, file_download, view_search_results)
- **`enhanced_measurement_mobile`** — Enhanced Measurement mobile events (notification_*)

`compare-events.js` reads this list optionally from a `Read Auto Events` n8n node. If that node isn't wired in, it falls back to an embedded copy. **Keep the embedded fallback in sync with the JSON file when updating either.**

To update the list when GA4 ships new auto-events: edit `data/ga4-auto-events.json` and the `DEFAULT_AUTO` constant in `compare-events.js` together.

## Anomaly Detection

The comparison engine supports two detection methods, selected via `clientConfig.anomaly_detection.method`:

| Method | Inputs needed | Use when |
|---|---|---|
| `binary` | Single prior period's counts | Quick smoke test; legacy compatibility |
| `rolling_zscore` | ≥14 days of historical daily counts | Production monitoring with low false-positive tolerance |
| `auto` (default) | Either shape | Use rolling_zscore if enough history, otherwise binary |

### Rolling z-score (multi-baseline)

When sufficient history is available, anomalies are flagged using three independent baselines. An event is flagged only if it's anomalous against **at least 2 of 3**:

1. **Rolling 7-day mean + standard deviation z-score** — `|z| > z_threshold` (default 3.0)
2. **Same-day-last-week** — drop or spike of `|drop_floor_pct|%` or more (default 25%)
3. **Same-day-4-weeks-ago** — drop or spike of `|drop_floor_pct|%` or more

This catches partial drops (95% drop from 1000 → 50) that the binary check misses, and avoids false-firing on normal day-over-day variance for low-volume events.

### Configuration

```json
{
  "anomaly_detection": {
    "method": "auto",
    "min_history_days": 14,
    "z_threshold": 3.0,
    "drop_floor_pct": 25
  }
}
```

All fields optional. Defaults shown.

### Required input shape

To enable `rolling_zscore`, the upstream `Read Previous Counts` node should return:

```json
{
  "event_counts": { "page_view": 1234, "purchase": 12, "...": "..." },
  "history": [
    { "date": "2026-04-15", "counts": { "page_view": 1180, "...": "..." } },
    { "date": "2026-04-16", "counts": { "page_view": 1240, "...": "..." } }
  ]
}
```

History is an ordered array (any order; the script sorts ascending by date). For binary mode, the legacy flat shape (`{ event_name: count }`) still works.

## License

MIT — see [LICENSE](../../LICENSE) for details.
