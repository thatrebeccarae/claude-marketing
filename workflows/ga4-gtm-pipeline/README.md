<div align="center">

# GA4-GTM Pipeline

**Autonomous n8n workflow that orchestrates GA4 monitoring, Claude-powered gap analysis, and GTM implementation — daily, hands-off.**

[![GitHub stars](https://img.shields.io/github/stars/thatrebeccarae/claude-marketing?style=for-the-badge&logo=github&color=181717)](https://github.com/thatrebeccarae/claude-marketing/stargazers)
[![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)](../../LICENSE)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Rebecca%20Rae%20Barton-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/rebeccaraebarton)
[![Substack](https://img.shields.io/badge/Substack-dgtl%20dept*-FF6719?style=for-the-badge&logo=substack&logoColor=white)](https://dgtldept.substack.com/welcome)

An n8n workflow that wires together three agents — [GA4 Monitor](../../agents/ga4-monitor/), [GA4 Gap Analyzer](../../agents/ga4-gap-analyzer/), and [GTM Implementer](../../agents/gtm-implementer/) — into a daily pipeline with Slack notifications and human approval gates.

Works for in-house teams monitoring a single property or agencies and consultants managing multiple GA4 properties and GTM containers.

[**Back to Repo**](../../README.md)

</div>

---

## What It Does

Most analytics teams discover GA4 tracking gaps reactively — a dashboard goes blank, a stakeholder asks why conversions dropped, or someone notices a missing event six weeks after a deploy broke it.

This pipeline flips that. It runs daily, compares your live GA4 event data against a defined tracking spec, and catches tracking gaps and anomalies before anyone notices. GA4 anomaly detection flags volume drops and spikes; gap analysis identifies missing or misconfigured events. When it finds issues, it uses Claude to diagnose root causes, generate GTM implementation specs, and create the actual tags, triggers, and variables in a GTM workspace — all without publishing. A human reviews and approves before anything goes live.

**What it never does:**
- Publish a GTM container (workspace changes stay unpublished until a human publishes)
- Modify GA4 configuration (read-only access to GA4 Data API)
- Push code to any repository (dataLayer changes are flagged for eng teams)
- Skip the human approval gate

The end-to-end build walkthrough — n8n hosting choices, GCP service account, Slack app, Anthropic API key, the 10-stage workflow assembly, scheduling, and day-to-day use for the marketing team — lives on page 6 of the [**Claude Marketing — The Complete Guide**](https://thatrebeccarae.kit.com/claude-marketing-guide). Free, in Notion. The version of this README I'd hand to an engineer setting it up for a marketing team.

<div align="center">

[![Get the build walkthrough](https://img.shields.io/badge/Get_the_build_walkthrough-Free-353535?style=for-the-badge)](https://thatrebeccarae.kit.com/claude-marketing-guide)

</div>

## Agents Used

This workflow orchestrates three standalone agents:

| Agent | Role in Pipeline | Can Use Standalone? |
|-------|-----------------|-------------------|
| **[GA4 Monitor](../../agents/ga4-monitor/)** | Compares GA4 events against tracking spec, flags gaps and anomalies | Yes — one-time audits, validation scripts |
| **[GA4 Gap Analyzer](../../agents/ga4-gap-analyzer/)** | Claude diagnoses gaps (Opus, adaptive thinking) and anomalies (Haiku) | Yes — manual analysis from any comparison data |
| **[GTM Implementer](../../agents/gtm-implementer/)** | Creates GTM resources from analysis output | Yes — manual GTM provisioning from specs |

## Architecture Overview

Three stages, gated by a human approval step.

1. **Monitor.** A scheduled trigger fires per property, reads the property config, fetches the current GA4 event inventory, and compares it against the tracking spec.
2. **Analyze.** If gaps or anomalies surface, GA4 Gap Analyzer runs Claude Opus (with adaptive thinking) on gap analysis and trigger / tag implementation logic, and Claude Haiku on anomaly root-cause. Slack receives the results with approve / reject controls.
3. **Implement.** On approval, GTM Implementer preflight-checks workspace availability, then creates the workspace, variables, triggers, and tags — never published. The reviewer publishes manually in the GTM UI.

## What's Included

- `scripts/n8n-nodes/` — JavaScript files for n8n Code nodes (auth, Slack formatters, report writers)
- `templates/` — markdown templates for monitoring reports and implementation docs

## Prerequisites

| Requirement                      | Purpose                                                                         |
| -------------------------------- | ------------------------------------------------------------------------------- |
| **n8n** (self-hosted)            | Workflow orchestration and scheduling                                           |
| **Google Cloud service account** | GA4 Data API (read) + GTM API (read/write)                                      |
| **GA4 property**                 | The property you want to monitor                                                |
| **GTM container**                | Where implementation changes are created                                        |
| **Claude API key**               | Opus (adaptive thinking) for gap analysis, Haiku for anomaly detection          |
| **Slack app**                    | Notifications, alerts, and approval requests (requires Slack admin permissions) |

### Google Cloud Setup

The service account needs two API scopes:

- **GA4 Data API v1** — read-only access to event data
- **GTM API v2** — read/write access to workspaces, tags, triggers, and variables (but **not** publish permission)

> [!IMPORTANT]
> The service account should intentionally lack GTM publish permission. This is the technical enforcement of the approval gate — the agent literally cannot publish a container, even if the code tried.

## Setup

### 1. Create a Property Config

Define a JSON config per GA4 property following the schema in [`agents/ga4-monitor/schemas/client-config.schema.json`](../../agents/ga4-monitor/schemas/client-config.schema.json). This specifies the GA4 property ID, GTM container ID, schedule, Slack channel, and approvers.

```bash
# Validate your config
python agents/ga4-monitor/scripts/validate-client-config.py path/to/client-config.json
```

### 2. Create an Event Spec

Define the expected events for the property following the schema in [`agents/ga4-monitor/schemas/event-spec.schema.json`](../../agents/ga4-monitor/schemas/event-spec.schema.json). This is the source of truth the pipeline compares against.

```bash
# Validate your spec
python agents/ga4-monitor/scripts/validate-event-spec.py path/to/event-spec.json
```

### 3. Build the workflow in n8n

Follow [page 6 of the Complete Guide](https://thatrebeccarae.kit.com/claude-marketing-guide) — node-by-node walkthrough with the Code-node JS from `scripts/n8n-nodes/` dropped into place.

### 4. Configure Credentials in n8n

Set up the following credentials in n8n:

- Google service account JSON (for GA4 + GTM)
- Claude API key
- Slack bot token

### 5. Test with Sample Data

Use [`agents/ga4-monitor/test-data/ga4-sample-response.json`](../../agents/ga4-monitor/test-data/ga4-sample-response.json) to dry-run the pipeline without hitting live APIs.

## How It Works

A daily run hits the GA4 Data API, pulls the last 7 days of event counts, and compares them against the property's tracking spec. Match → Slack confirms 100% coverage and the pipeline writes the daily report. No match → the run branches.

When the comparison surfaces anomalies, Haiku runs root-cause on the volume drops or spikes and Slack gets an urgent alert. When it surfaces gaps, Opus generates the full gap analysis and the GTM specs needed to close them, and Slack sends the proposed changes with approve / reject controls.

On approval, GTM Implementer preflights workspace availability, creates the named workspace (`claude-{purpose}-{date}`), and writes the variables, triggers, and tags inside it — rate-limited, idempotent, never published. A reviewer opens GTM, checks the workspace, and clicks publish if the changes are right. The service account has no publish permission by design.

## Security Model

### Credential Isolation

- Service account JSON files are stored outside any synced directory and never committed to version control
- Each property gets its own service account with scoped permissions
- n8n credential storage handles encryption at rest

### Approval Gate

The pipeline has a hard stop before any GTM writes. Proposed changes are sent to Slack with full specs. A designated approver must explicitly approve before the pipeline continues. Rejection ends the run with logged reasoning.

### Workspace Isolation

GTM workspaces act like branches — changes are invisible to the live container until explicitly published by a human with publish permission. The service account intentionally lacks this permission, making accidental publication impossible at the API level.

### Audit Trail

Every pipeline run produces timestamped documentation:
- Monitoring reports (what was checked, what was found)
- Implementation docs (what was created, GTM resource IDs)
- Slack message history (approvals, rejections, alerts)

## FAQ

<details>
<summary><strong>Does this publish GTM changes automatically?</strong></summary>

No. The service account is configured without publish permission, and the pipeline creates changes in an isolated workspace. A human must review in the GTM UI and publish manually.

</details>

<details>
<summary><strong>What happens if GTM already has 3 workspaces?</strong></summary>

The preflight check detects this and sends a Slack alert instead of failing. Free GTM accounts allow 3 workspaces total (including the default). The pipeline will not attempt to create a workspace if none are available.

</details>

<details>
<summary><strong>Can I run this without the GTM implementation step?</strong></summary>

Yes. The monitoring and gap analysis stages work independently. You can use this purely for daily tracking health checks — just skip the approval step and the pipeline ends after the Slack notification with gap analysis results. You can also use the [GA4 Monitor](../../agents/ga4-monitor/) agent standalone for one-time audits.

</details>

<details>
<summary><strong>How do I add a new property?</strong></summary>

1. Create a property config JSON (validate with `agents/ga4-monitor/scripts/validate-client-config.py`)
2. Create an event spec JSON (validate with `agents/ga4-monitor/scripts/validate-event-spec.py`)
3. Add a schedule trigger in n8n pointing to the new config
4. Set up the Google service account with GA4 read + GTM write access for the property

No workflow changes needed.

</details>

## Resources

- [Claude Marketing — The Complete Guide](https://thatrebeccarae.kit.com/claude-marketing-guide) — free Notion reference. Page 6 has the full n8n build walkthrough; the rest covers install, credentials, the six skills to start with, scored audits, and workflow chains
- [The Marketing Expertise Layer for Claude Code](https://dgtldept.substack.com/p/the-marketing-expertise-layer-for-claude-code) — companion essay on dgtl dept*
- [GA4 Data API v1 Documentation](https://developers.google.com/analytics/devguides/reporting/data/v1)
- [Google Tag Manager API v2 Reference](https://developers.google.com/tag-platform/tag-manager/api/v2)
- [n8n Documentation](https://docs.n8n.io/)
- [Claude API Documentation](https://docs.anthropic.com/en/docs/api-reference)

## License

MIT — see [LICENSE](../../LICENSE) for details.
