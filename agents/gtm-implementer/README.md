# GTM Implementer

**Creates GTM variables, triggers, and tags from gap analysis output — rate-limited, idempotent, and workspace-isolated.**

[![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)](../../LICENSE)

## What It Does

Takes structured output from the [GA4 Gap Analyzer](../ga4-gap-analyzer/) and creates the corresponding GTM resources via the GTM API v2:

1. **Preflight check** — verifies workspace availability (free GTM accounts allow 3 workspaces)
2. **Payload construction** — transforms analysis + event spec into GTM API payloads for variables, triggers, and tags
3. **Rate-limited writes** — creates resources with 4-second delays between API calls, deduplicates against existing resources

All changes land in a named workspace (`claude-{purpose}-{date}`), never in the default workspace. The service account intentionally lacks publish permission — a human must review and publish in the GTM UI.

## What's Included

```
gtm-implementer/
└── scripts/
    ├── workspace-preflight.js     # Checks GTM workspace availability
    ├── build-gtm-resources.js     # Transforms analysis into GTM API payloads
    └── execute-gtm-writes.js      # Rate-limited, idempotent GTM API writes
```

## Safety Model

- **Rate-limited:** 4-second delays between GTM API calls (respects quotas)
- **Idempotent:** detects existing resources by name and skips duplicates
- **Workspace-isolated:** changes land in a named workspace, never the default
- **No publish permission:** the service account cannot publish containers by design
- **Preflight checks:** verifies workspace availability before attempting creation

## Write Order

Resources are created in dependency order:
1. Variables (data layer variables, constants)
2. Triggers (event triggers referencing variables)
3. Tags (GA4 event tags referencing triggers)

## License

MIT — see [LICENSE](../../LICENSE) for details.
