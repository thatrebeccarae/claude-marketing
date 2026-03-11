# GA4 Gap Analyzer

**Uses Claude to diagnose GA4 tracking gaps and anomalies, generating root cause analysis and GTM implementation specs.**

[![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)](../../LICENSE)

## What It Does

Takes the output from [GA4 Monitor](../ga4-monitor/) and sends it to Claude for analysis:

- **Gap analysis** (Claude Sonnet) — diagnoses why events are missing, recommends GTM implementations with tag type, trigger conditions, and variable dependencies
- **Anomaly analysis** (Claude Haiku) — identifies root cause patterns for volume drops and spikes, flags urgent issues

Outputs structured JSON that can be consumed by the [GTM Implementer](../gtm-implementer/) or used standalone for manual remediation.

## What's Included

```
ga4-gap-analyzer/
└── scripts/
    ├── build-gap-analysis-prompt.js      # Constructs Claude API request for gap analysis
    ├── build-anomaly-prompt.js           # Constructs Claude API request for anomaly analysis
    ├── parse-gap-analysis-response.js    # Extracts structured JSON from Claude's response
    └── parse-anomaly-response.js         # Extracts structured JSON from anomaly response
```

## How It Works

### Gap Analysis Flow

1. `build-gap-analysis-prompt.js` takes comparison results + event spec, enriches missing events with full GTM config, and constructs a Claude Messages API request
2. Claude Sonnet analyzes the gaps and returns implementation recommendations
3. `parse-gap-analysis-response.js` extracts the JSON response (handles markdown fences, parse errors, fallback structures)

### Anomaly Analysis Flow

1. `build-anomaly-prompt.js` takes anomaly data and constructs a Claude Messages API request
2. Claude Haiku identifies patterns and root causes
3. `parse-anomaly-response.js` extracts the structured response

### Claude Model Usage

| Task | Model | Why | Approx. Cost |
|------|-------|-----|-------------|
| Gap analysis + GTM specs | Sonnet | Deep reasoning about event relationships and implementation tradeoffs | ~$0.05-0.10/run |
| Anomaly root cause | Haiku | Fast pattern matching on volume changes | ~$0.01/run |

## License

MIT — see [LICENSE](../../LICENSE) for details.
