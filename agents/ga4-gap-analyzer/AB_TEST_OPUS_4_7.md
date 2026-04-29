# A/B Test Plan: Opus 4.6 vs Opus 4.7 for Gap Analysis

**Status:** Pending baseline data
**Created:** 2026-04-29
**Decision threshold:** See [Decision criteria](#decision-criteria) below

---

## Why this test exists

Worktree #1 ships gap analysis on **Opus 4.6 + adaptive thinking** rather than Opus 4.7. The reason is risk control: third-party reports (single-source, unverified) suggest Opus 4.7 may consume more tokens per request than 4.6 due to tokenizer changes. Until that's measured against this agent's actual workload, sticking with 4.6 keeps cost behavior predictable.

Opus 4.7 may produce better diagnostic output, lower latency, or comparable quality at lower effective cost. This test answers: **is the upgrade worth it for gap analysis specifically?**

---

## What to measure

Run the same gap-analysis request through both models and compare:

| Metric | How to capture | Why it matters |
|---|---|---|
| Input token count | `usage.input_tokens` from API response | Tokenizer drift signal |
| Output token count | `usage.output_tokens` | Cost driver |
| Thinking token count | `usage.thinking_tokens` (if surfaced) or inferred | Adaptive thinking budget choice differs by model |
| Total cost per call | Compute from current pricing × tokens | Bottom-line check |
| End-to-end latency | Wall-clock from request to final response | UX impact for synchronous use |
| JSON parse success | Did `parse-gap-analysis-response.js` extract clean JSON? | Reliability signal |
| Output structure | Did the model honor the schema (quick_wins, phases, unexpected_event_analysis)? | Diagnostic quality proxy |
| Diagnostic quality | Manual review of recommendations against ground truth | Upgrade justification |

---

## Test fixture

Use a **representative gap-analysis request body** captured from a real run. Store under:

```
agents/ga4-gap-analyzer/test-data/representative-gap-request.json
```

(Mirrors the existing `agents/ga4-monitor/test-data/` convention. Public-repo-safe — strip client identifiers if needed.)

The fixture should include:
- A spec with at least one full event group and 5+ missing events (mix of priorities)
- A handful of unexpected events
- Optional: AEO context block (test both with `aeo_tracking_enabled: true` and `false`)

---

## How to run

### Option A: Manual side-by-side via curl

For each model, send the request body via curl, capture full response + usage:

```bash
# 4.6 baseline
curl -s https://api.anthropic.com/v1/messages \
  -H "x-api-key: $ANTHROPIC_API_KEY" \
  -H "anthropic-version: 2023-06-01" \
  -H "content-type: application/json" \
  -d @<(jq '.anthropic_request_body | .model = "claude-opus-4-6"' representative-gap-request.json) \
  > opus-4-6-response.json

# 4.7 candidate
curl -s https://api.anthropic.com/v1/messages \
  -H "x-api-key: $ANTHROPIC_API_KEY" \
  -H "anthropic-version: 2023-06-01" \
  -H "content-type: application/json" \
  -d @<(jq '.anthropic_request_body | .model = "claude-opus-4-7"' representative-gap-request.json) \
  > opus-4-7-response.json

# Compare usage
jq '.usage' opus-4-6-response.json opus-4-7-response.json
```

Run **at least 3 trials per model** to control for output sampling variance. Report median, not single-shot.

### Option B: n8n branch with model override

The gap-analysis prompt builder reads `clientConfig.gap_analysis.model`. To test 4.7 in production-shaped conditions:

1. Duplicate the client config (e.g., `{client-slug}-opus-4-7-trial.json`)
2. Set `gap_analysis.model = "claude-opus-4-7"` in the trial config
3. Trigger the pipeline manually via the webhook with the trial config path
4. Run for 2 weeks alongside the baseline; compare report quality and cost

### Option C: Anthropic Batch API

If running multiple representative requests, submit them as a batch (`POST /v1/messages/batches`) with both model variants in the same batch. 50% cost discount and side-by-side execution. See [Batch API docs](https://platform.claude.com/docs/en/build-with-claude/batch-processing).

---

## Decision criteria

Switch to Opus 4.7 if **all** of these hold on the median of ≥3 trials:

1. **Token efficiency:** Total tokens (input + output + thinking) on 4.7 are within +10% of 4.6 (i.e., the rumored tokenizer inflation is overstated for this workload)
2. **Cost:** Computed cost per call is within +20% of 4.6 (tokenizer drift × pricing × thinking budget all combined)
3. **Quality:** Manual review of 4.7 output is at least as good as 4.6 on the same input — same or better diagnostic accuracy, no regressions in schema adherence
4. **Reliability:** JSON parse success rate ≥ 4.6 on the trial set

If any criterion fails, stay on 4.6 and re-run after Anthropic's next pricing/tokenizer update.

If 4.7 wins decisively (better quality at lower cost), swap the default in `build-gap-analysis-prompt.js` and update the README cost notes.

---

## Test log

| Date | Trial | Model | Input tokens | Output tokens | Thinking tokens | Cost ($) | Latency (s) | JSON parsed? | Quality notes |
|---|---|---|---|---|---|---|---|---|---|
| _pending_ | — | — | — | — | — | — | — | — | — |

Append rows here as trials run. Use the same input fixture across rows.

---

## Notes

- **Adaptive thinking budget** is decided by the model itself, so observed thinking_tokens will vary across calls even on the same model. This is expected — average across trials.
- **Tokenizer differences:** input_tokens reported by the API reflects what was actually counted. If 4.7's input_token count diverges materially from 4.6 on identical request bodies, that's the tokenizer-drift signal.
- **Pricing source:** [https://platform.claude.com/docs/en/about-claude/pricing](https://platform.claude.com/docs/en/about-claude/pricing) — verify before computing costs; pricing changes don't bump this doc automatically.
