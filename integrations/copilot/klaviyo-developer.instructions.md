Klaviyo API and developer integration expertise. Event tracking, SDKs, webhooks, rate limits, OAuth, catalog sync, and code patterns. Use when the user asks about Klaviyo API, integrating with Klaviyo, tracking events, building custom integrations, webhook handling, or developer implementation. For marketing strategy, flow optimization, and campaign auditing, see the klaviyo-analyst skill.


# Klaviyo Developer

Expert-level guidance for building with the Klaviyo API — custom event tracking, profile management, SDK integration, webhooks, catalog sync, and data pipeline architecture.

> For marketing strategy, flow auditing, segmentation, deliverability, and campaign optimization, see the **klaviyo-analyst** skill.

## MCP vs. SDK: When to Use Which

This skill is **SDK-first by design** — you're building production integrations against the Klaviyo API, not running ad-hoc queries. That said, Klaviyo's official MCP server is the right tool for parts of integration work, and you should know when to reach for it.

| Use the **SDK** (`klaviyo-api`) when… | Use the **MCP** (`https://mcp.klaviyo.com/mcp`) when… |
|---|---|
| Writing production event-tracking code | Exploring an account's event schema before writing the integration |
| Building bulk import / sync pipelines | Sanity-checking that events landed with the right property shape |
| Implementing webhook handlers | Pulling a quick property inventory during integration design |
| Catalog sync jobs | Inspecting flow trigger conditions while debugging why an event isn't firing a flow |
| Anything in CI, cron, or a deployed service | Iterating on event schema design with the marketing analyst in the room |

The MCP wraps the same API this skill targets, so the schema rules, rate limits, and nesting constraints below apply equally to MCP-driven calls. The MCP is currently pinned to API revision `2026-04-15` — keep that in mind if you're versioning your own SDK code against an older revision.

For the full MCP tool inventory, OAuth setup, and read-only mode flag, see [REFERENCE.md](REFERENCE.md#mcp-server-reference). For audit/analyst work, see the **klaviyo-analyst** skill — it's built around the MCP.

## Core Capabilities

### API Authentication & Versioning
- Private API key setup and key management best practices
- Public API key usage for client-side tracking (klaviyo.js)
- OAuth 2.0 authorization flow for third-party apps
- API revision headers and version lifecycle management

### Custom Event Tracking
- Server-side event tracking via Events API
- Client-side tracking with klaviyo.js
- Event schema design and property naming conventions
- Idempotent event submission patterns

### Profile Management
- Profile create, upsert, and bulk import patterns
- Custom property management and data types
- Subscription management (email, SMS consent)
- Profile merge and deduplication strategies

### Webhooks
- Webhook subscription setup and event types
- Payload verification and signature validation
- Retry handling and idempotent webhook processing

### SDK Usage & Libraries
- Python SDK (klaviyo-api)
- Node.js SDK (klaviyo-api-node)
- Ruby, PHP, and other community SDKs
- SDK initialization, error handling, and retry configuration

### Catalog & Product Feed Sync
- Catalog item create/update/delete via API
- Category and variant management
- Product feed sync architecture for recommendations
- Handling large catalogs with bulk operations


(Truncated. See full skill at github.com/thatrebeccarae/claude-marketing)
