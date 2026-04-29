# GA4 Gap Analyzer

**Uses Claude to diagnose GA4 tracking gaps and anomalies, generating root cause analysis and GTM implementation specs.**

[![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)](../../LICENSE)

## What It Does

Takes the output from [GA4 Monitor](../ga4-monitor/) and sends it to Claude for analysis:

- **Gap analysis** (Claude Opus + adaptive thinking) — diagnoses why events are missing, recommends GTM implementations with tag type, trigger conditions, and variable dependencies
- **Anomaly analysis** (Claude Haiku) — identifies root cause patterns for volume drops and spikes, flags urgent issues

Outputs structured JSON that can be consumed by the [GTM Implementer](../gtm-implementer/) or used standalone for manual remediation.

## What's Included

```
ga4-gap-analyzer/
├── scripts/
│   ├── build-gap-analysis-prompt.js      # Constructs Claude API request for gap analysis
│   ├── build-anomaly-prompt.js           # Constructs Claude API request for anomaly analysis
│   ├── parse-gap-analysis-response.js    # Extracts structured JSON from Claude's response
│   └── parse-anomaly-response.js         # Extracts structured JSON from anomaly response
└── AB_TEST_OPUS_4_7.md                   # Sidecar A/B test plan: Opus 4.6 vs Opus 4.7
```

## How It Works

### Gap Analysis Flow

1. `build-gap-analysis-prompt.js` takes comparison results + event spec, enriches missing events with full GTM config, and constructs a Claude Messages API request
2. Claude Opus (with adaptive thinking) analyzes the gaps and returns implementation recommendations
3. `parse-gap-analysis-response.js` extracts the JSON response (handles markdown fences, parse errors, fallback structures)

### Anomaly Analysis Flow

1. `build-anomaly-prompt.js` takes anomaly data and constructs a Claude Messages API request
2. Claude Haiku identifies patterns and root causes
3. `parse-anomaly-response.js` extracts the structured response

## Reasoning Model

Gap analysis uses **Opus 4.6 + adaptive thinking** (`thinking: { type: "adaptive" }`). This is a tradeoff: deeper root-cause reasoning on missing events at higher per-call cost than Sonnet, in exchange for a less rigid output format.

### Why adaptive thinking, not forced tool use

Anthropic's Messages API offers two paths to reliable structured output:

- **Forced tool use** (`tool_choice: { type: "tool", name: "..." }` + `strict: true`) — server-side schema validation, guaranteed JSON, no parser fallbacks needed
- **Extended/adaptive thinking** (`thinking: { type: "adaptive" }`) — multi-step internal reasoning before generating output; surfaces stronger diagnostic conclusions

These two modes are **mutually exclusive** — Anthropic's API returns 400 if you combine forced `tool_choice` with extended thinking. This agent picks adaptive thinking because gap-analysis quality depends on diagnosis depth more than on output rigidity. The parser already handles markdown-fence stripping and JSON-parse fallbacks defensively, so a looser output format is cheap to absorb.

If you'd rather optimize for guaranteed schema compliance over reasoning depth, swap the model to `claude-sonnet-4-6`, drop the `thinking` field, and migrate the parser to consume `tool_use.input` instead of `content[].text`.

### Model override for A/B testing

The model name and max_tokens can be overridden per client via the client config:

```json
{
  "gap_analysis": {
    "model": "claude-opus-4-7",
    "max_tokens": 16384
  }
}
```

See `AB_TEST_OPUS_4_7.md` for the recommended A/B test pattern when evaluating Opus 4.7 against the 4.6 baseline.

## AEO Awareness

When the client config sets `aeo_tracking_enabled: true`, the gap-analysis system prompt is augmented with LLM-traffic context:

- GA4 has no native channel for AI-search referrers
- ~70% of LLM-referred traffic lands as Direct (referrer stripped, especially ChatGPT free tier and Google AI Mode)
- Common AI referrer hosts (regex): `chatgpt.com|chat.openai.com|claude.ai|perplexity.ai|gemini.google.com|copilot.microsoft.com|grok.com|x.ai|meta.ai|you.com`
- Practitioner-default solution is a custom Channel Group "AI Assistants" plus an `ai_referral` custom event

When AEO awareness is enabled, the agent will recommend an `ai_referral` event scaffold in `quick_wins` if missing from the client's spec. The [GTM Implementer](../gtm-implementer/) is responsible for actually building the corresponding Custom JavaScript variable, Custom Event trigger, and GA4 Event tag.

If `aeo_tracking_enabled` is unset or `false`, the system prompt is unchanged from baseline and no AEO recommendations are surfaced.

## Cost Notes

Costs depend on:
- Model (Opus 4.6 vs 4.7, or Sonnet if downgraded)
- Adaptive thinking budget (model decides per-call)
- Spec size and number of missing events in the user message

Adaptive thinking tokens are billed at the output token rate. Run a representative request through the API and check actual token usage before extrapolating monthly costs — token consumption varies significantly with input size and reasoning depth requested.

For a baseline reference run with thinking disabled and Sonnet 4.6, expect ~$0.05–0.10 per gap-analysis call. With Opus 4.6 + adaptive thinking, expect higher per-call cost in exchange for better diagnostic quality. Use the A/B test in `AB_TEST_OPUS_4_7.md` to calibrate before committing to a model.

## License

MIT — see [LICENSE](../../LICENSE) for details.
