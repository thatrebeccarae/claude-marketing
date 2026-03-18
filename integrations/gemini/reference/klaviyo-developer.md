# klaviyo-developer


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

Always include the `revision` header in API requests.

## Essential Developer Checklist

1. **API key management** — Store private keys in environment variables, never commit to source. Rotate keys periodically.
2. **Revision header** — Always include `revision: YYYY-MM-DD` header. Pin to a specific version.
3. **Rate limit handling** — Implement exponential backoff with jitter on 429 responses.
4. **Idempotent events** — Include a unique `unique_id` property to prevent duplicate event tracking.
5. **Profile upserts** — Use `POST /profiles/` with existing identifier for upsert behavior (creates or updates).
6. **Webhook verification** — Validate webhook signatures before processing payloads.
7. **Pagination** — Use cursor-based pagination for list endpoints. Never assume result counts.
8. **Error handling** — Parse JSON:API error responses. Handle 4xx (client) and 5xx (server) differently.
9. **SDK initialization** — Configure SDK with API key at app startup, not per-request.
10. **Testing** — Use Klaviyo test/sandbox accounts. Mock API responses in unit tests.

## Workflow: Custom Integration Setup

When building a custom Klaviyo integration:

1. **Define requirements** — What events to track, what profile data to sync, what triggers are needed
2. **API key provisioning** — Create a private API key with minimum required scopes
3. **Event schema design** — Map business events to Klaviyo metric names and properties
4. **Profile sync strategy** — Determine identifier (email vs phone vs external_id), upsert frequency
5. **Implement tracking** — Server-side event tracking with proper error handling and retries
6. **Catalog sync** (if applicable) — Product feed sync for recommendations and browse abandonment
7. **Webhook setup** — Subscribe to relevant events, implement handler with signature verification
8. **Rate limit strategy** — Queue and throttle API calls, implement backoff
9. **Monitoring** — Log API errors, track event delivery rates, alert on failures
10. **Testing & validation** — Verify events appear in Klaviyo, test flow triggers, validate profile data

## Workflow: Integration Health Audit

When auditing an existing Klaviyo integration for health and data quality:

1. **Inventory active integrations** — List all configured integrations (built-in and custom). Identify active vs stale connections.
2. **Map event sources** — For each metric in the account, identify its source (built-in integration, custom API, Klaviyo-internal, form). Flag metrics with zero recent volume.
3. **Audit event schemas** — Pull property structures for key events (Placed Order, Started Checkout, Viewed Product, Added to Cart). Check for:
   - Missing standard properties (e.g., `$value`, `ItemNames`, line items)
   - Duplicate/redundant metrics (e.g., "Placed Order" and "Order Placed" from different sources)
   - Inconsistent property naming (camelCase vs snake_case across events)
4. **Check profile data pipeline** — Verify profile properties are being synced correctly. Look for:
   - Properties set by API vs properties set by events
   - Stale properties (set once, never updated)
   - Properties used in segmentation vs properties sitting unused
5. **Review catalog sync** — Verify product catalog is synced and fresh. Check:
   - Total catalog items vs expected product count
   - Last sync timestamp
   - Variant coverage (are variants synced or just parent products?)
   - Category structure completeness
6. **Assess flow trigger architecture** — Map how flows are triggered:
   - Direct metric triggers (robust) vs segment-entry triggers via API-synced properties (brittle)
   - Single points of failure (if API sync breaks, do all flows stop?)
   - Trigger redundancy and fallback patterns
7. **Identify data accessibility gaps** — Check for data that exists in event payloads but isn't usable:
   - Nested objects in event properties (can use in templates, cannot use in segments/splits)
   - Properties available in events but not synced to profiles (can't segment on them)
   - Events tracked but not used in any flow or segment
8. **Produce integration health report** — Document findings with severity ratings:
   - **Critical**: Integration failures, broken event tracking, data loss
   - **High**: Missing standard events, duplicate metrics, flow trigger fragility
   - **Medium**: Unused events, incomplete catalog, stale profile properties
   - **Low**: Naming inconsistencies, optimization opportunities

## Event Schema Best Practices

### Property Naming Conventions
- Use **PascalCase** for standard Klaviyo properties: `ProductName`, `ItemPrice`, `OrderId`
- Use **snake_case** for custom properties: `business_type`, `account_id`, `reorder_count`
- Never mix conventions within a single event — pick one and be consistent
- Prefix custom properties to avoid collision with Klaviyo-reserved names

### Required Properties by Event

| Event | Required Properties | Revenue Property |
|-------|-------------------|------------------|
| Placed Order | `$value`, `OrderId`, `Items[]` (line items) | `$value` |
| Started Checkout | `$value`, `CheckoutURL`, `Items[]` | `$value` |
| Viewed Product | `ProductName`, `ProductID`, `URL`, `ImageURL` | — |
| Added to Cart | `$value`, `AddedItemProductName`, `AddedItemProductID`, `Items[]` | `$value` |
| Fulfilled Order | `$value`, `OrderId` | — |

### Nesting Rules and Limitations

Klaviyo handles nested objects differently depending on where you access them:

| Context | Access Level | Example |
|---------|-------------|---------|
| **Email/SMS templates** | Full access via Jinja — can loop over arrays, access nested properties | `{% for item in event.Items %}{{ item.ProductName }}{% endfor %}` |
| **Flow conditional splits** | Top-level properties ONLY — cannot access nested object fields | Can split on `event.OrderId`, cannot split on `event.Items[0].ProductName` |
| **Segments** | Top-level properties ONLY — cannot filter by nested object fields | Can segment on "has done Placed Order where $value > 100", cannot segment on "where Items contains ProductName = X" |
| **Flow triggers** | Top-level properties for trigger filters | Same as conditional splits |

**Workaround for nested data**: If you need to segment or split on nested data, flatten it to top-level properties:
```python
# Instead of relying on Items[] array for segmentation:
properties = {
    "$value": 149.99,
    "OrderId": "ORD-123",
    "Items": [{"ProductName": "Wireless Headphones", "Category": "Electronics"}],
    # Flatten for segmentation:
    "ItemCategories": "Electronics,Accessories",  # Comma-joined for "contains" filter
    "HasElectronics": True,                        # Boolean flag for split
    "TopItemCategory": "Electronics"               # Top category for split
}
```

### Custom Event Patterns (DTC / Subscription / Marketplace)

Additional events beyond the standard Shopify/e-commerce schema:

| Event Name | Trigger | Key Properties |
|------------|---------|----------------|
| `Account Created` | New account registered | `account_type`, `referral_source`, `signup_channel` |
| `Subscription Started` | Recurring order activated | `$value`, `frequency`, `product_ids`, `plan_name` |
| `Subscription Cancelled` | Recurring order stopped | `reason`, `plan_name`, `lifetime_charges` |
| `Reorder Placed` | Repeat purchase of consumable | `$value`, `OrderId`, `days_since_last_order`, `reorder_items` |
| `Wishlist Added` | Item saved for later | `ProductName`, `ProductID`, `Categories`, `Price` |
| `Catalog Browsed` | Category/search activity | `category`, `search_term`, `results_count` |

Sync key customer properties to profiles for segmentation:
```python
profile_properties = {
    "customer_type": "Subscriber",
    "interests": ["Skincare", "Wellness"],
    "subscription_plan": "Monthly Box",
    "account_tier": "VIP",
    "first_order_date": "2024-03-15",
    "lifetime_order_count": 8,
    "avg_order_value": 72.50,
    "preferred_categories": ["Skincare", "Supplements"]
}
```

## Data Accessibility Diagnosis

When data exists in Klaviyo but isn't usable where expected:

### Symptoms
- "We track [event] but can't segment on [property]"
- "Flow split doesn't see the property we're sending"
- "Profile has the data but segment doesn't pick it up"

### Root Causes and Solutions

| Symptom | Root Cause | Solution |
|---------|-----------|----------|
| Can't segment on event property | Property is nested inside an array/object | Flatten to top-level property on the event |
| Can't split flow on event property | Property is nested | Flatten, or use profile property instead |
| Segment doesn't match profiles | Property is on events, not profiles | Sync property to profile via API or "Update Profile Property" flow action |
| Profile property exists but segment empty | Property value format mismatch (string "true" vs boolean `true`) | Standardize data types in API sync |
| Event tracked but no flow triggers | Metric name mismatch (case-sensitive) | Verify exact metric name in Klaviyo matches API call |
| Flow triggers but filter excludes everyone | Segment used as flow filter evaluates incorrectly | Check segment conditions — may reference stale or incorrectly-typed properties |

### Diagnosis Workflow
1. **Check metric exists**: Use GET `/metrics/` to verify the event name appears
2. **Check event properties**: Use GET `/events/?filter=...` to pull recent events and inspect property structure
3. **Check profile properties**: Use GET `/profiles/{id}/` to verify expected properties are on the profile
4. **Test segment conditions**: Compare segment definition against actual profile data — look for type mismatches, case sensitivity issues
5. **Test flow trigger**: Send a test event and trace whether the flow fires, where it stops, and why

## How to Use This Skill

Ask me questions like:
- "How do I track a custom event from my Node.js backend?"
- "Help me set up a bulk profile import script"
- "What are Klaviyo's rate limits and how should I handle them?"
- "How do I verify Klaviyo webhook signatures?"
- "Set up catalog sync for my custom e-commerce platform"
- "How do I implement OAuth for a Klaviyo app?"
- "Design a data pipeline to export Klaviyo data to BigQuery"
- "Help me migrate from Klaviyo v1/v2 API to the current API"
- "Audit my integration — are events structured correctly?"
- "Why can't I segment on a property I'm tracking in events?"

## Integration Examples

For complete integration patterns, worked examples with sample output, and code snippets, see [EXAMPLES.md](EXAMPLES.md).

## Scripts

The skill includes utility scripts for API interaction and integration management:

### Developer Client
```bash
# Track a custom event
python scripts/klaviyo_client.py --action track-event \
    --email user@example.com --event "Placed Order" \
    --properties '{"value": 99.99, "OrderId": "ORD-123"}'

# Upsert a profile
python scripts/klaviyo_client.py --action upsert-profile \
    --email user@example.com \
    --properties '{"first_name": "Jane", "loyalty_tier": "Gold"}'

# List catalog items
python scripts/klaviyo_client.py --action catalog-items --format table

# Export profiles to CSV
python scripts/klaviyo_client.py --action export-profiles \
    --max-pages 10 --format csv --output profiles.csv
```

### Developer Tools
```bash
# Integration health check
python scripts/dev_tools.py --tool health-check

# Validate event tracking
python scripts/dev_tools.py --tool validate-events \
    --events "Placed Order,Started Checkout,Viewed Product"

# Test webhook endpoint
python scripts/dev_tools.py --tool test-webhook \
    --webhook-url https://example.com/webhooks/klaviyo

# Import profiles from CSV
python scripts/dev_tools.py --tool import-csv \
    --file contacts.csv --list-id LIST_ID

# Export data with pagination
python scripts/dev_tools.py --tool export-data \
    --resource profiles --max-records 5000 --output profiles.csv
```

The scripts handle API authentication, rate limiting, and JSON:API formatting. I'll help interpret results and provide implementation guidance.

## Troubleshooting

**Authentication Error**: Verify that:
- `KLAVIYO_API_KEY` is set as an environment variable or in a `.env` file
- The key starts with `pk_` (private API key, not public)
- The key has the required scopes for your operation (e.g., `events:write` for tracking, `profiles:write` for imports)

**Rate Limit Errors (429)**: The SDK handles retries automatically (up to 3 retries with 60s max delay). If you still hit limits:
- Queue and throttle bulk operations (max 10 req/s for imports)
- Check `RateLimit-Remaining` header proactively
- Implement exponential backoff with jitter for raw HTTP

**Bulk Import Errors**: Check that:
- Batch size does not exceed 10,000 profiles per job
- Email or phone is provided for each profile (at least one identifier)
- CSV column names match expected field names

**Import Errors**: Install required packages:
```bash
pip install klaviyo-api python-dotenv pandas
```

## Security Notes

- **Never hardcode** API keys in code or commit them to version control
- Store keys in environment variables or `.env` files
- Add `.env` to `.gitignore`
- Use **minimum required scopes** — only enable write access where needed
- Rotate API keys periodically in Klaviyo Settings
- For OAuth integrations, store client secrets securely and refresh tokens before expiry

## Data Privacy

This skill interacts with the Klaviyo API for integration development. When using write operations:
- Validate data before sending to avoid corrupting profile records
- Never log or store API keys, webhook secrets, or PII in plain text
- Use idempotency keys to prevent duplicate events
- Implement webhook signature verification to prevent spoofing
- Follow GDPR/CCPA requirements when handling profile data
- Use the Data Privacy Deletion endpoint for right-to-erasure requests

All operations are performed via the official Klaviyo API with proper authentication.

For detailed API endpoint reference, code patterns, authentication, and architecture diagrams, see [REFERENCE.md](REFERENCE.md).

For marketing strategy, flow optimization, and campaign auditing, use the **klaviyo-analyst** skill.

---

# Klaviyo Developer Reference

## API Endpoints

### Base URL
```
https://a.klaviyo.com/api/
```

### Authentication
```
Authorization: Klaviyo-API-Key {private-api-key}
Content-Type: application/json
revision: 2025-10-15
```

### Profiles
```
GET    /profiles/                                    # List profiles (paginated)
POST   /profiles/                                    # Create or upsert profile
GET    /profiles/{id}/                                # Get profile by ID
PATCH  /profiles/{id}/                                # Update profile
POST   /profile-subscription-bulk-create-jobs/        # Bulk subscribe profiles
POST   /profile-suppression-bulk-create-jobs/         # Bulk suppress profiles
POST   /profile-suppression-bulk-delete-jobs/         # Bulk unsuppress profiles
POST   /profile-bulk-import-jobs/                     # Bulk import profiles
```

### Events
```
POST   /events/                                      # Create event
GET    /events/                                      # Query events (paginated)
GET    /events/{id}/                                  # Get event by ID
```

### Metrics
```
GET    /metrics/                                     # List available metrics
POST   /metric-aggregates/                           # Aggregate metric data (reporting)
```

### Lists
```
GET    /lists/                                       # List all lists
POST   /lists/                                       # Create list
GET    /lists/{id}/                                   # Get list
PATCH  /lists/{id}/                                   # Update list
DELETE /lists/{id}/                                   # Delete list
POST   /lists/{id}/relationships/profiles/            # Add profiles to list
DELETE /lists/{id}/relationships/profiles/            # Remove profiles from list
GET    /lists/{id}/profiles/                          # Get list members
```

### Segments
```
GET    /segments/                                    # List all segments
GET    /segments/{id}/                                # Get segment
GET    /segments/{id}/profiles/                       # Get segment members
```

### Campaigns
```
GET    /campaigns/                                   # List campaigns
POST   /campaigns/                                   # Create campaign
GET    /campaigns/{id}/                               # Get campaign
PATCH  /campaigns/{id}/                               # Update campaign
DELETE /campaigns/{id}/                               # Delete campaign
POST   /campaign-send-jobs/                          # Send campaign
POST   /campaign-recipient-estimation-jobs/           # Estimate recipients
```

### Flows
```
GET    /flows/                                       # List flows
GET    /flows/{id}/                                   # Get flow details
PATCH  /flows/{id}/                                   # Update flow status
GET    /flows/{id}/flow-actions/                      # Get flow actions
GET    /flows/{id}/flow-messages/                     # Get flow messages
```

### Catalogs
```
POST   /catalog-items/                               # Create catalog item
GET    /catalog-items/                               # List catalog items
GET    /catalog-items/{id}/                           # Get catalog item
PATCH  /catalog-items/{id}/                           # Update catalog item
DELETE /catalog-items/{id}/                           # Delete catalog item
POST   /catalog-categories/                          # Create category
GET    /catalog-categories/                          # List categories
POST   /catalog-variants/                            # Create variant
GET    /catalog-variants/                            # List variants
POST   /catalog-item-bulk-create-jobs/               # Bulk create items
POST   /catalog-item-bulk-update-jobs/               # Bulk update items
POST   /catalog-item-bulk-delete-jobs/               # Bulk delete items
```

### Templates
```
GET    /templates/                                   # List templates
POST   /templates/                                   # Create template
GET    /templates/{id}/                               # Get template
PATCH  /templates/{id}/                               # Update template
DELETE /templates/{id}/                               # Delete template
POST   /template-clone/                              # Clone template
POST   /template-render/                             # Render template
```

### Tags
```
GET    /tags/                                        # List tags
POST   /tags/                                        # Create tag
GET    /tag-groups/                                   # List tag groups
POST   /tag-groups/                                   # Create tag group
```

### Images
```
GET    /images/                                      # List images
POST   /images/                                      # Upload image
GET    /images/{id}/                                  # Get image
PATCH  /images/{id}/                                  # Update image
```

### Data Privacy
```
POST   /data-privacy-deletion-jobs/                  # Request profile deletion (GDPR)
```

---

## Authentication

### Private API Key (Server-side)
```python
# Python
from klaviyo_api import KlaviyoAPI
klaviyo = KlaviyoAPI("pk_abc123...", max_delay=60, max_retries=3)
```

```javascript
// Node.js
const { ApiClient } = require('klaviyo-api');
const klaviyo = new ApiClient('pk_abc123...');
```

```bash
# Raw HTTP
curl -X GET "https://a.klaviyo.com/api/profiles/" \
  -H "Authorization: Klaviyo-API-Key pk_abc123..." \
  -H "revision: 2025-10-15"
```

### Public API Key (Client-side - klaviyo.js)
```html
<script>
  !function(){if(!window.klaviyo){window._klOnsite=window._klOnsite||[];try{window.klaviyo=new Proxy({},{get:function(n,i){return"push"===i?function(){var n;(n=window._klOnsite).push.apply(n,arguments)}:function(){for(var n=arguments.length,o=new Array(n),w=0;w<n;w++)o[w]=arguments[w];var t="function"==typeof o[o.length-1]?o.pop():void 0,e=new Promise((function(n){t&&n(t())}));return window._klOnsite.push([i].concat(o,[function(i){e=i}])),e}}})}catch(n){window.klaviyo=window.klaviyo||[],window.klaviyo.push=function(){var n;(n=window._klOnsite).push.apply(n,arguments)}}}}();
</script>
<script async src="https://static.klaviyo.com/onsite/js/klaviyo.js?company_id=YOUR_PUBLIC_KEY"></script>
```

### OAuth 2.0 (Third-party Apps)

**Authorization URL:**
```
https://www.klaviyo.com/oauth/authorize?response_type=code&client_id={CLIENT_ID}&redirect_uri={REDIRECT_URI}&scope={SCOPES}&state={STATE}
```

**Token Exchange:**
```bash
curl -X POST "https://a.klaviyo.com/oauth/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=authorization_code&code={AUTH_CODE}&redirect_uri={REDIRECT_URI}" \
  -u "{CLIENT_ID}:{CLIENT_SECRET}"
```

**Token Refresh:**
```bash
curl -X POST "https://a.klaviyo.com/oauth/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=refresh_token&refresh_token={REFRESH_TOKEN}" \
  -u "{CLIENT_ID}:{CLIENT_SECRET}"
```

**OAuth Scopes:**

| Scope | Description |
|-------|-------------|
| `accounts:read` | Read account info |
| `campaigns:read` | Read campaigns |
| `campaigns:write` | Create/update campaigns |
| `events:read` | Read events |
| `events:write` | Create events |
| `flows:read` | Read flows |
| `flows:write` | Update flows |
| `lists:read` | Read lists |
| `lists:write` | Create/update lists |
| `metrics:read` | Read metrics |
| `profiles:read` | Read profiles |
| `profiles:write` | Create/update profiles |
| `segments:read` | Read segments |
| `segments:write` | Update segments |
| `subscriptions:read` | Read subscriptions |
| `subscriptions:write` | Manage subscriptions |
| `catalogs:read` | Read catalog items |
| `catalogs:write` | Create/update catalog items |
| `templates:read` | Read templates |
| `templates:write` | Create/update templates |
| `tags:read` | Read tags |
| `tags:write` | Create/update tags |

---

## Code Patterns

### Python SDK — Initialize
```python
from klaviyo_api import KlaviyoAPI

klaviyo = KlaviyoAPI(
    "pk_abc123...",
    max_delay=60,      # Max retry delay in seconds
    max_retries=3       # Max retry attempts on 429/5xx
)
```

### Node.js SDK — Initialize
```javascript
const { ApiClient, ProfilesApi, EventsApi } = require('klaviyo-api');

const defaultClient = ApiClient.instance;
const ApiKeyAuth = defaultClient.authentications['ApiKeyAuth'];
ApiKeyAuth.apiKey = 'pk_abc123...';

const profilesApi = new ProfilesApi();
const eventsApi = new EventsApi();
```

### Track Event (Python SDK)
```python
from klaviyo_api import KlaviyoAPI

klaviyo = KlaviyoAPI("pk_abc123...")

body = {
    "data": {
        "type": "event",
        "attributes": {
            "metric": {
                "data": {
                    "type": "metric",
                    "attributes": {"name": "Placed Order"}
                }
            },
            "profile": {
                "data": {
                    "type": "profile",
                    "attributes": {"email": "customer@example.com"}
                }
            },
            "properties": {
                "OrderId": "ORD-12345",
                "value": 99.99,
                "ItemNames": ["Widget A", "Gadget B"],
                "ItemCount": 2
            },
            "unique_id": "ORD-12345"  # Idempotency key
        }
    }
}

klaviyo.Events.create_event(body)
```

### Track Event (Raw HTTP)
```python
import requests

response = requests.post(
    "https://a.klaviyo.com/api/events/",
    headers={
        "Authorization": "Klaviyo-API-Key pk_abc123...",
        "Content-Type": "application/json",
        "revision": "2025-10-15"
    },
    json={
        "data": {
            "type": "event",
            "attributes": {
                "metric": {"data": {"type": "metric", "attributes": {"name": "Placed Order"}}},
                "profile": {"data": {"type": "profile", "attributes": {"email": "customer@example.com"}}},
                "properties": {"OrderId": "ORD-12345", "value": 99.99},
                "unique_id": "ORD-12345"
            }
        }
    }
)
```

### Profile Upsert
```python
body = {
    "data": {
        "type": "profile",
        "attributes": {
            "email": "customer@example.com",
            "phone_number": "+15551234567",
            "first_name": "Jane",
            "last_name": "Doe",
            "properties": {
                "loyalty_tier": "Gold",
                "lifetime_orders": 12,
                "preferred_category": "Electronics"
            }
        }
    }
}

# POST creates if new, updates if email/phone matches existing profile
klaviyo.Profiles.create_profile(body)
```

### Bulk Profile Import
```python
body = {
    "data": {
        "type": "profile-bulk-import-job",
        "attributes": {
            "profiles": {
                "data": [
                    {
                        "type": "profile",
                        "attributes": {
                            "email": "user1@example.com",
                            "first_name": "Alice",
                            "properties": {"source": "migration"}
                        }
                    },
                    {
                        "type": "profile",
                        "attributes": {
                            "email": "user2@example.com",
                            "first_name": "Bob",
                            "properties": {"source": "migration"}
                        }
                    }
                    # Up to 10,000 profiles per job
                ]
            }
        },
        "relationships": {
            "lists": {
                "data": [{"type": "list", "id": "LIST_ID"}]  # Optional: add to list
            }
        }
    }
}

klaviyo.Profiles.spawn_bulk_profile_import_job(body)
```

### Cursor-based Pagination
```python
def get_all_profiles(klaviyo):
    """Paginate through all profiles."""
    profiles = []
    cursor = None

    while True:
        response = klaviyo.Profiles.get_profiles(
            page_cursor=cursor,
            page_size=100
        )
        profiles.extend(response.get("data", []))

        # Get next page cursor from links
        next_link = response.get("links", {}).get("next")
        if not next_link:
            break

        # Extract cursor from next link URL
        from urllib.parse import urlparse, parse_qs
        parsed = urlparse(next_link)
        cursor = parse_qs(parsed.query).get("page[cursor]", [None])[0]

    return profiles
```

### Webhook Handler (Express.js)
```javascript
const express = require('express');
const crypto = require('crypto');

const app = express();
app.use(express.raw({ type: 'application/json' }));

const WEBHOOK_SECRET = process.env.KLAVIYO_WEBHOOK_SECRET;

function verifyWebhookSignature(payload, signature, secret) {
  const hmac = crypto.createHmac('sha256', secret);
  hmac.update(payload);
  const expected = hmac.digest('hex');
  return crypto.timingSafeEqual(
    Buffer.from(signature),
    Buffer.from(expected)
  );
}

app.post('/webhooks/klaviyo', (req, res) => {
  const signature = req.headers['x-klaviyo-webhook-signature'];

  if (!verifyWebhookSignature(req.body, signature, WEBHOOK_SECRET)) {
    return res.status(401).json({ error: 'Invalid signature' });
  }

  const event = JSON.parse(req.body);

  // Process webhook event
  switch (event.type) {
    case 'profile.subscribed':
      // Handle new subscriber
      break;
    case 'profile.unsubscribed':
      // Handle unsubscribe
      break;
    default:
      console.log(`Unhandled event type: ${event.type}`);
  }

  res.status(200).json({ received: true });
});
```

### Client-side Tracking (klaviyo.js)
```javascript
// Identify a visitor
klaviyo.push(['identify', {
  email: 'customer@example.com',
  first_name: 'Jane',
  last_name: 'Doe',
  $consent: ['email']
}]);

// Track a custom event
klaviyo.push(['track', 'Viewed Product', {
  ProductName: 'Widget A',
  ProductID: 'PROD-123',
  Price: 29.99,
  ImageURL: 'https://example.com/widget-a.jpg',
  URL: 'https://example.com/products/widget-a'
}]);

// Track Added to Cart
klaviyo.push(['track', 'Added to Cart', {
  $value: 29.99,
  AddedItemProductName: 'Widget A',
  AddedItemProductID: 'PROD-123',
  AddedItemPrice: 29.99,
  AddedItemQuantity: 1,
  ItemNames: ['Widget A'],
  Items: [{
    ProductID: 'PROD-123',
    ProductName: 'Widget A',
    Quantity: 1,
    ItemPrice: 29.99,
    ImageURL: 'https://example.com/widget-a.jpg',
    URL: 'https://example.com/products/widget-a'
  }]
}]);
```

---

## Rate Limits

### Fixed-window Limits

| Endpoint Category | Burst Limit | Steady-state Limit |
|-------------------|-------------|-------------------|
| Most GET endpoints | 75/s | 700/min |
| Profile create/update | 350/s | 700/min |
| Event create | 350/s | 700/min |
| Bulk operations | 10/s | 150/min |
| Campaign send | 10/s | 100/min |

### Rate Limit Headers
```
RateLimit-Limit: 75
RateLimit-Remaining: 42
RateLimit-Reset: 1700000000
Retry-After: 1           # Only on 429 responses
```

### Retry Algorithm with Exponential Backoff
```python
import time
import random
import requests

def klaviyo_request(method, url, **kwargs):
    max_retries = 5
    base_delay = 1.0

    for attempt in range(max_retries):
        response = requests.request(method, url, **kwargs)

        if response.status_code == 429:
            retry_after = float(response.headers.get("Retry-After", base_delay))
            delay = retry_after + random.uniform(0, 1)  # Jitter
            time.sleep(delay)
            continue

        if response.status_code >= 500:
            delay = base_delay * (2 ** attempt) + random.uniform(0, 1)
            time.sleep(delay)
            continue

        return response

    raise Exception(f"Max retries exceeded for {url}")
```

---

## Error Response Structure

All errors follow JSON:API format:

```json
{
  "errors": [
    {
      "id": "unique-error-id",
      "status": 400,
      "code": "invalid",
      "title": "Invalid input.",
      "detail": "The 'email' field is required.",
      "source": {
        "pointer": "/data/attributes/email"
      }
    }
  ]
}
```

### Common Error Codes

| Status | Code | Meaning |
|--------|------|---------|
| 400 | `invalid` | Malformed request body or invalid parameters |
| 401 | `not_authenticated` | Missing or invalid API key |
| 403 | `not_authorized` | API key lacks required scope |
| 404 | `not_found` | Resource does not exist |
| 409 | `conflict` | Resource already exists (duplicate) |
| 429 | `throttled` | Rate limit exceeded — check Retry-After header |
| 500 | `internal` | Server error — retry with backoff |
| 503 | `service_unavailable` | Temporary outage — retry with backoff |

---

## API Versioning

### How It Works
- Include `revision: YYYY-MM-DD` header in every request
- Omitting the header defaults to the oldest supported revision
- Each revision is supported for ~2 years after release
- Breaking changes only happen in new revisions, never within a revision

### Revision History

| Revision | Status | Key Changes |
|----------|--------|-------------|
| 2026-01-15 | **Latest** | Custom Objects Ingestion, Geofencing API (beta) |
| 2025-10-15 | Supported | Forms API, Flow Actions API, SMS ROI reporting |
| 2025-07-15 | Supported | Mapped Metrics API, Custom Objects API (GA) |
| 2025-04-15 | Supported | Web Feeds API, Custom Metrics, Push Token registration |
| 2025-01-15 | Supported | Reviews APIs, Flows Create API, Campaign image management |
| 2024-10-15 | Supported | Universal Content API, Form/Segment Reporting, Reviews API |
| 2024-07-15 | Supported | Forms API (retrieval), Webhooks API |
| 2024-02-15 | Supported | Reporting API, Create or Update Profile (upsert) |
| 2023-10-15 | Deprecated | List suppression filtering, subscription status on profiles |
| 2023-06-15 | Deprecated | Accounts API, list/segment member counts, rate limit increases |

### Version Lifecycle
1. **Current** — Latest revision, recommended for new integrations
2. **Supported** — Fully functional, receives bug fixes
3. **Deprecated** — 6-month sunset notice, then removed

---

## Migration Guide: Legacy to Current API

### Endpoint Mapping

| Legacy (v1/v2) | Current API | Notes |
|----------------|-------------|-------|
| `POST /api/identify` | `POST /api/profiles/` | Use JSON:API body format |
| `POST /api/track` | `POST /api/events/` | Include metric + profile in body |
| `GET /api/v1/people` | `GET /api/profiles/` | Cursor pagination |
| `GET /api/v2/lists` | `GET /api/lists/` | JSON:API response format |
| `POST /api/v2/list/{id}/subscribe` | `POST /api/profile-subscription-bulk-create-jobs/` | Async job |
| `GET /api/v1/metrics/timeline` | `POST /api/metric-aggregates/` | New aggregation body |
| `POST /api/v1/catalog/items` | `POST /api/catalog-items/` | JSON:API format |

### Key Migration Changes
- All endpoints now use JSON:API format (`{ "data": { "type": "...", "attributes": {...} } }`)
- Authentication changed from query param `?api_key=` to header `Authorization: Klaviyo-API-Key`
- Pagination changed from offset to cursor-based
- `revision` header required
- Async jobs for bulk operations (subscribe, import, suppress)
- Relationships use JSON:API linkage (`/relationships/`)

---

## Integration Architecture Patterns

### E-commerce Sync
```
┌─────────────┐     Events API      ┌─────────┐
│  Storefront │ ──────────────────→  │ Klaviyo │
│  (Custom)   │                      │         │
│             │ ←─────────────────── │  Flows  │
│             │     Webhooks         │  Sends  │
└──────┬──────┘                      └────┬────┘
       │                                  │
       │  Catalog API                     │  Reporting API
       │  (nightly sync)                  │
       ▼                                  ▼
┌─────────────┐                    ┌─────────────┐
│  Product DB │                    │  Dashboard   │
└─────────────┘                    └─────────────┘
```

### Data Warehouse ETL
```
┌─────────┐    Profiles API     ┌──────────┐    Transform    ┌───────────┐
│ Klaviyo │ ─────────────────→  │  ETL Job │ ──────────────→ │ Warehouse │
│         │    Events API       │ (Airflow │                 │ (BigQuery │
│         │ ─────────────────→  │  / dbt)  │                 │  Snowflake│
│         │    Metrics API      │          │                 │  Redshift)│
│         │ ─────────────────→  └──────────┘                 └───────────┘
└─────────┘
```

### Real-time Event Streaming
```
┌──────────┐    Track API     ┌─────────┐     Webhook     ┌──────────┐
│  App     │ ──────────────→  │ Klaviyo │ ──────────────→  │  Queue   │
│  Server  │                  │         │                  │ (SQS /   │
│          │ ←───────────────  │  Flows  │                  │  Kafka)  │
│          │   Flow webhook   │         │                  │          │
└──────────┘                  └─────────┘                  └─────┬────┘
                                                                 │
                                                           ┌─────▼────┐
                                                           │  Worker  │
                                                           │ (process │
                                                           │  events) │
                                                           └──────────┘
```

---

## Standard Event Property Schemas

Complete property schemas for standard e-commerce events. Use these as the reference when auditing event tracking or building custom integrations.

### Placed Order

The primary revenue event. Must include line items for product-level analytics and flow personalization.

```json
{
  "data": {
    "type": "event",
    "attributes": {
      "metric": {
        "data": { "type": "metric", "attributes": { "name": "Placed Order" } }
      },
      "profile": {
        "data": {
          "type": "profile",
          "attributes": {
            "email": "customer@example.com",
            "properties": { "first_name": "Jane", "last_name": "Doe" }
          }
        }
      },
      "properties": {
        "$value": 149.99,
        "OrderId": "ORD-12345",
        "Categories": ["Electronics", "Accessories"],
        "ItemNames": ["Wireless Headphones Pro", "Phone Case - Midnight"],
        "Brands": ["AudioTech", "CaseCraft"],
        "DiscountCode": "WELCOME10",
        "DiscountValue": 15.00,
        "Items": [
          {
            "ProductID": "PROD-001",
            "SKU": "AT-WHP-001",
            "ProductName": "Wireless Headphones Pro",
            "Quantity": 1,
            "ItemPrice": 89.99,
            "RowTotal": 89.99,
            "ProductURL": "https://example.com/products/wireless-headphones-pro",
            "ImageURL": "https://example.com/images/headphones-pro.jpg",
            "Categories": ["Electronics", "Audio"],
            "Brand": "AudioTech"
          },
          {
            "ProductID": "PROD-002",
            "SKU": "CC-CASE-MID",
            "ProductName": "Phone Case - Midnight",
            "Quantity": 1,
            "ItemPrice": 29.99,
            "RowTotal": 29.99,
            "ProductURL": "https://example.com/products/phone-case-midnight",
            "ImageURL": "https://example.com/images/case-midnight.jpg",
            "Categories": ["Accessories", "Cases"],
            "Brand": "CaseCraft"
          }
        ],
        "ItemCount": 3,
        "ShippingMethod": "Standard",
        "ShippingCost": 0.00,
        "Tax": 12.00,
        "Subtotal": 149.97,
        "BillingAddress": {
          "FirstName": "Jane",
          "LastName": "Doe",
          "City": "Austin",
          "Region": "TX",
          "Country": "US",
          "Zip": "60601"
        }
      },
      "unique_id": "ORD-12345",
      "time": "2026-02-09T14:30:00Z"
    }
  }
}
```

**Usage notes:**
- `$value` is the revenue property Klaviyo uses for attribution and flow filters
- `Items[]` array enables product-level recommendations in flow emails
- `unique_id` = `OrderId` for idempotency (prevents duplicate order events)
- `Categories` (top-level) = flattened list for segmentation (since `Items[].Categories` is nested and not accessible in segments)
- `BillingAddress` is nested — accessible in templates but NOT in segments/splits

### Started Checkout

Triggers abandoned cart flows. Must include cart contents for personalization.

```json
{
  "data": {
    "type": "event",
    "attributes": {
      "metric": {
        "data": { "type": "metric", "attributes": { "name": "Started Checkout" } }
      },
      "profile": {
        "data": {
          "type": "profile",
          "attributes": { "email": "customer@example.com" }
        }
      },
      "properties": {
        "$value": 149.99,
        "CheckoutURL": "https://example.com/checkout/abc123",
        "ItemNames": ["Wireless Headphones Pro", "Phone Case - Midnight"],
        "Categories": ["Electronics", "Accessories"],
        "Items": [
          {
            "ProductID": "PROD-001",
            "SKU": "AT-WHP-001",
            "ProductName": "Wireless Headphones Pro",
            "Quantity": 1,
            "ItemPrice": 89.99,
            "RowTotal": 89.99,
            "ProductURL": "https://example.com/products/wireless-headphones-pro",
            "ImageURL": "https://example.com/images/headphones-pro.jpg"
          }
        ],
        "ItemCount": 3
      },
      "unique_id": "CHECKOUT-abc123"
    }
  }
}
```

**Usage notes:**
- `CheckoutURL` is critical for the abandoned cart email CTA
- `$value` enables "cart value > $X" flow filters
- `Items[]` enables dynamic product blocks in cart recovery emails
- Deduplicate with `unique_id` = checkout session ID

### Viewed Product

Triggers browse abandonment flows. Lightweight event — no line items needed.

```json
{
  "data": {
    "type": "event",
    "attributes": {
      "metric": {
        "data": { "type": "metric", "attributes": { "name": "Viewed Product" } }
      },
      "profile": {
        "data": {
          "type": "profile",
          "attributes": { "email": "customer@example.com" }
        }
      },
      "properties": {
        "ProductName": "Wireless Headphones Pro",
        "ProductID": "PROD-001",
        "SKU": "AT-WHP-001",
        "Categories": ["Electronics", "Audio"],
        "Brand": "AudioTech",
        "Price": 89.99,
        "CompareAtPrice": 109.99,
        "ImageURL": "https://example.com/images/headphones-pro.jpg",
        "URL": "https://example.com/products/wireless-headphones-pro"
      }
    }
  }
}
```

**Usage notes:**
- No `$value` — this isn't a revenue event
- `URL` and `ImageURL` required for browse abandonment email personalization
- `CompareAtPrice` enables "on sale" logic in flow templates
- No `unique_id` — multiple views of the same product are expected
- `Categories` at top level enables segment filters like "viewed product in Electronics category"

### Added to Cart

Tracks cart additions. Useful for cart-based flows when Started Checkout isn't tracked.

```json
{
  "data": {
    "type": "event",
    "attributes": {
      "metric": {
        "data": { "type": "metric", "attributes": { "name": "Added to Cart" } }
      },
      "profile": {
        "data": {
          "type": "profile",
          "attributes": { "email": "customer@example.com" }
        }
      },
      "properties": {
        "$value": 89.99,
        "AddedItemProductName": "Wireless Headphones Pro",
        "AddedItemProductID": "PROD-001",
        "AddedItemSKU": "AT-WHP-001",
        "AddedItemCategories": ["Electronics", "Audio"],
        "AddedItemImageURL": "https://example.com/images/headphones-pro.jpg",
        "AddedItemURL": "https://example.com/products/wireless-headphones-pro",
        "AddedItemPrice": 89.99,
        "AddedItemQuantity": 1,
        "ItemNames": ["Wireless Headphones Pro", "Phone Case - Midnight"],
        "Items": [
          {
            "ProductID": "PROD-001",
            "ProductName": "Wireless Headphones Pro",
            "Quantity": 1,
            "ItemPrice": 89.99,
            "ImageURL": "https://example.com/images/headphones-pro.jpg",
            "URL": "https://example.com/products/wireless-headphones-pro"
          },
          {
            "ProductID": "PROD-002",
            "ProductName": "Phone Case - Midnight",
            "Quantity": 1,
            "ItemPrice": 29.99,
            "ImageURL": "https://example.com/images/case-midnight.jpg",
            "URL": "https://example.com/products/phone-case-midnight"
          }
        ]
      }
    }
  }
}
```

**Usage notes:**
- `$value` = price of the added item (not total cart value)
- `AddedItem*` properties describe the specific item added (top-level, segmentable)
- `Items[]` = full current cart contents (for template rendering)
- `ItemNames` = flattened array for segmentation

### Order Completed / Fulfilled Order

Triggers post-purchase flows (review requests, replenishment reminders).

```json
{
  "data": {
    "type": "event",
    "attributes": {
      "metric": {
        "data": { "type": "metric", "attributes": { "name": "Fulfilled Order" } }
      },
      "profile": {
        "data": {
          "type": "profile",
          "attributes": { "email": "customer@example.com" }
        }
      },
      "properties": {
        "$value": 149.99,
        "OrderId": "ORD-12345",
        "FulfillmentId": "SHIP-67890",
        "TrackingNumber": "1Z999AA10123456784",
        "TrackingURL": "https://tracking.example.com/1Z999AA10123456784",
        "Carrier": "UPS",
        "Items": [
          {
            "ProductID": "PROD-001",
            "ProductName": "Wireless Headphones Pro",
            "Quantity": 1,
            "ItemPrice": 89.99
          }
        ]
      },
      "unique_id": "SHIP-67890"
    }
  }
}
```

**Usage notes:**
- Use as trigger for review request flows (with 7-14 day delay)
- Use as trigger for replenishment flows (with product-specific delay)
- `TrackingURL` enables shipping confirmation emails
- `unique_id` = fulfillment ID (an order can have multiple fulfillments/shipments)

### Cancelled Order

Tracks order cancellations. Useful for re-engagement and save-the-sale flows.

```json
{
  "data": {
    "type": "event",
    "attributes": {
      "metric": {
        "data": { "type": "metric", "attributes": { "name": "Cancelled Order" } }
      },
      "profile": {
        "data": {
          "type": "profile",
          "attributes": { "email": "customer@example.com" }
        }
      },
      "properties": {
        "$value": 149.99,
        "OrderId": "ORD-12345",
        "Reason": "Customer requested",
        "Items": [
          {
            "ProductID": "PROD-001",
            "ProductName": "Wireless Headphones Pro",
            "Quantity": 1,
            "ItemPrice": 89.99
          }
        ]
      },
      "unique_id": "CANCEL-ORD-12345"
    }
  }
}
```

**Usage notes:**
- Use to suppress cancelled orders from post-purchase and review flows
- `Reason` at top level enables flow splits by cancellation reason
- `$value` = cancelled order value (useful for segment: "cancelled $500+ order")

---

## Nested Object Limitations & Workarounds

Klaviyo's data model handles nested objects (arrays, sub-objects) differently depending on where you access them. This is the #1 source of "I track the data but can't use it" complaints.

### Access Matrix

| Data Location | Email/SMS Templates | Flow Conditional Splits | Flow Trigger Filters | Segments |
|---------------|:-------------------:|:----------------------:|:-------------------:|:--------:|
| Top-level string/number/boolean | Yes | Yes | Yes | Yes |
| Top-level array (e.g., `ItemNames`) | Yes (loop) | Yes (`contains`) | Yes (`contains`) | Yes (`contains`) |
| Nested object field (e.g., `Items[0].ProductName`) | Yes (loop) | **No** | **No** | **No** |
| Nested object in nested object | Yes (deep loop) | **No** | **No** | **No** |
| Profile property (string/number/boolean) | Yes | Yes | Yes | Yes |
| Profile property (array) | Yes | Yes (`contains`) | Yes (`contains`) | Yes (`contains`) |
| Profile property (object) | Yes (dot notation) | **No** | **No** | **No** |

### Workaround Patterns

**Pattern 1: Flatten arrays to comma-joined strings**
```python
# Instead of relying on Items[].Category for segmentation:
properties["ItemCategories"] = ",".join(set(item["Category"] for item in items))
# Now segment: "Placed Order where ItemCategories contains Electronics"
```

**Pattern 2: Promote key nested values to top-level**
```python
# Need to split flow by first item brand?
properties["TopBrand"] = items[0]["Brand"] if items else ""
properties["HasElectronics"] = any(
    "Electronics" in item.get("Categories", []) for item in items
)
```

**Pattern 3: Sync to profile for persistent segmentation**
```python
# Need to segment by "ever purchased Electronics"?
# Track on profile, not just on event:
profile_properties["purchased_categories"] = list(set(
    existing_categories + new_order_categories
))
```

**Pattern 4: Use "Update Profile Property" flow action**
```
Flow: Placed Order trigger
  → Update Profile Property: "last_order_category" = {{ event.TopCategory }}
  → Conditional Split: Profile "last_order_category" = "Electronics"
```

---

## Custom Event Design Patterns (DTC / Subscription)

Beyond standard Shopify events, these patterns cover subscription, loyalty, and advanced DTC workflows.

### Account & Subscription Lifecycle Events

```python
# Account Created — new customer registration
{
    "name": "Account Created",
    "properties": {
        "account_id": "ACCT-12345",
        "signup_channel": "Website",
        "referral_source": "Instagram Ad",
        "interests": ["Skincare", "Wellness"],
        "quiz_completed": True,
        "skin_type": "Combination",
        "state": "CA"
    }
}

# Subscription Started — recurring order activated
{
    "name": "Subscription Started",
    "properties": {
        "$value": 39.99,
        "plan_name": "Monthly Essentials Box",
        "frequency": "monthly",
        "product_ids": ["PROD-100", "PROD-200"],
        "payment_method": "Credit Card",
        "account_id": "ACCT-12345"
    }
}

# Subscription Cancelled — churn event
{
    "name": "Subscription Cancelled",
    "properties": {
        "plan_name": "Monthly Essentials Box",
        "reason": "Too expensive",
        "lifetime_charges": 6,
        "lifetime_revenue": 239.94,
        "account_id": "ACCT-12345"
    }
}
```

### Advanced Purchase Events

```python
# Wishlist Added — high-intent browsing signal
{
    "name": "Wishlist Added",
    "properties": {
        "ProductName": "Vitamin C Serum",
        "ProductID": "PROD-300",
        "Categories": ["Skincare", "Serums"],
        "Price": 48.00,
        "wishlist_count": 3,
        "account_id": "ACCT-12345"
    }
}

# Reorder Placed — repeat purchase (consumable)
{
    "name": "Reorder Placed",
    "properties": {
        "$value": 72.50,
        "OrderId": "ORD-99887",
        "days_since_last_order": 28,
        "is_auto_reorder": False,
        "reorder_items": ["Daily Moisturizer", "SPF 50 Sunscreen", "Lip Balm"],
        "reorder_category": "Skincare",
        "account_id": "ACCT-12345"
    }
}
```

### DTC Profile Properties for Segmentation

```python
# Sync these to profiles for advanced segmentation:
profile_properties = {
    # Customer identity
    "customer_type": "Subscriber",
    "interests": ["Skincare", "Wellness"],
    "subscription_plan": "Monthly Essentials Box",
    "account_tier": "VIP",                # Standard, VIP, Founding Member
    "state": "CA",

    # Purchase behavior
    "first_order_date": "2024-03-15",
    "last_order_date": "2026-01-28",
    "lifetime_order_count": 18,
    "avg_order_value": 72.50,
    "lifetime_revenue": 1305.00,
    "avg_days_between_orders": 31,

    # Product affinity
    "preferred_categories": ["Skincare", "Supplements"],
    "purchased_brands": ["GlowLab", "VitaWell", "PureBlend"],

    # Personalization
    "skin_type": "Combination",
    "quiz_score": 85,

    # Engagement
    "last_email_click_date": "2026-02-05",
    "email_engagement_tier": "Active"
}
```

### Segmentation Examples

```
# High-value customers for VIP flow
Segment: "VIP Customers"
Conditions:
  - lifetime_revenue > 500 OR
  - lifetime_order_count > 8 OR
  - avg_order_value > 100

# Reorder candidates (consumable replenishment)
Segment: "Reorder - Skincare (30d)"
Conditions:
  - Has done "Placed Order" where Categories contains "Skincare"
    at least 1 time in the last 180 days
  - Has NOT done "Placed Order" in the last 25 days
  - preferred_categories contains "Skincare"

# Interest-based targeting
Segment: "Wellness Enthusiasts"
Conditions:
  - interests contains "Wellness" OR
  - preferred_categories contains "Supplements"
  - Has done "Placed Order" at least 1 time (verified buyer)

# At-risk high-value customers
Segment: "At-Risk VIP"
Conditions:
  - lifetime_revenue > 300
  - Has NOT done "Placed Order" in the last 60 days
  - Has NOT done "Opened Email" in the last 30 days
```
