Klaviyo API and developer integration expertise. Event tracking, SDKs, webhooks, rate limits, OAuth, catalog sync, and code patterns. Use when the user asks about Klaviyo API, integrating with Klaviyo, tracking events, building custom integrations, webhook handling, or developer implementation. For marketing strategy, flow optimization, and campaign auditing, see the klaviyo-analyst skill.


# Klaviyo Developer

Expert-level guidance for building with the Klaviyo API — custom event tracking, profile management, SDK integration, webhooks, catalog sync, and data pipeline architecture.

> For marketing strategy, flow auditing, segmentation, deliverability, and campaign optimization, see the **klaviyo-analyst** skill.

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

### Data Export & Warehouse Sync
- Metric aggregation API for reporting
- Profile and event export patterns
- Cursor-based pagination for large datasets
- ETL pipeline design for data warehouse integration

## SDK Quick Reference

| Language | Package | Install |
|----------|---------|---------|
| Python | `klaviyo-api` | `pip install klaviyo-api` |
| Node.js | `klaviyo-api` | `npm install klaviyo-api` |
| Ruby | `klaviyo-api-sdk` | `gem install klaviyo-api-sdk` |
| PHP | `klaviyo/api` | `composer require klaviyo/api` |

## Rate Limits

| Endpoint Category | Limit | Window |
|-------------------|-------|--------|
| Most endpoints | 75 requests | per second |
| Bulk imports | 10 requests | per second |
| Profile/Event create | 350 requests | per second |
| Campaign send | 10 requests | per second |

Headers returned: `RateLimit-Limit`, `RateLimit-Remaining`, `RateLimit-Reset`

## API Revision Timeline

| Revision | Key Changes |
|----------|-------------|
| 2026-01-15 | Latest. Custom Objects Ingestion, Geofencing API (beta). |
| 2025-10-15 | Forms API, Flow Actions API, SMS ROI reporting. |
| 2025-07-15 | Mapped Metrics API, Custom Objects API (GA). |
| 2025-04-15 | Web Feeds API, Custom Metrics, Push Token registration. |
| 2025-01-15 | Reviews APIs, Flows Create API, Campaign image management. |
| 2024-10-15 | Universal Content API, Form/Segment Reporting, Reviews API. |
| 2024-07-15 | Forms API (retrieval), Webhooks API. |
| 2024-02-15 | Reporting API, Create or Update Profile (upsert). |


(Truncated. See full skill at github.com/thatrebeccarae/claude-marketing)
