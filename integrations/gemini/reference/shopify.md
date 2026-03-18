# shopify


# Shopify Marketing & E-commerce

Expert-level guidance for Shopify — optimizing store conversion, marketing integrations, analytics, product feeds, and the full e-commerce marketing stack.

## Core Capabilities

### Store Performance Auditing
- Conversion funnel analysis (visit → add to cart → checkout → purchase)
- Site speed and Core Web Vitals assessment
- Mobile experience review (60-70%+ of DTC traffic is mobile)
- Checkout optimization (Shopify Checkout extensibility, one-page checkout)
- Product page optimization (layout, copy, social proof, urgency)

### Marketing Integrations
- **Email/SMS**: Klaviyo (recommended), Omnisend, Postscript, Attentive
- **Ads**: Meta Pixel + CAPI, Google Ads + Enhanced Conversions, TikTok Pixel, Pinterest Tag
- **Attribution**: Triple Whale, Northbeam, Polar Analytics, Lifetimely
- **Reviews**: Judge.me, Yotpo, Stamped, Loox (photo reviews)
- **Loyalty**: Smile.io, LoyaltyLion, Yotpo Loyalty
- **Subscriptions**: Recharge, Loop, Bold, Skio
- **SEO**: JSON-LD structured data, sitemap optimization, page speed

### Analytics & Reporting
- Shopify Analytics (built-in) — sessions, conversion rate, AOV, returning customer rate
- GA4 integration via Google & YouTube channel or GTM
- Server-side tracking setup (Shopify Pixel API + CAPI)
- Customer cohort analysis (LTV, retention, purchase frequency)
- Product analytics (sell-through rate, margin analysis)

### Product Feed Management
- Google Merchant Center feed optimization
- Facebook/Instagram Catalog (via Meta Commerce Manager)
- Feed attribute optimization: title, description, product type, custom labels
- Variant handling and inventory sync
- Disapproval diagnosis and feed error resolution

### Conversion Rate Optimization (CRO)
- A/B testing (using Shopify's built-in or tools like Shoplift, Visually)
- Collection page optimization (filters, sorting, layout)
- Cart and checkout optimization (cart drawer vs page, upsells, trust badges)
- Post-purchase upsell flows (Zipify OCU, ReConvert, AfterSell)
- Pop-up and lead capture strategy (Privy, Justuno, Wisepops)

## Key Benchmarks

| Metric | Good | Great | Warning |
|--------|------|-------|---------|
| Overall Conversion Rate | 2-3% | 4%+ | <1.5% |
| Add-to-Cart Rate | 8-10% | 12%+ | <5% |
| Cart-to-Checkout Rate | 50-60% | 70%+ | <40% |
| Checkout Completion Rate | 45-55% | 60%+ | <35% |
| AOV | Industry dependent | Growing trend | Declining |
| Returning Customer Rate | 25-30% | 40%+ | <20% |
| Mobile Conversion Rate | 1.5-2.5% | 3%+ | <1% |
| Email Revenue % | 25-35% | 40%+ | <15% |
| LTV:CAC Ratio | 3:1 | 4:1+ | <2:1 |
| Page Load (LCP) | <2.5s | <1.5s | >4s |

## Essential Shopify Marketing Stack

### Tier 1 — Must-Have
1. **Klaviyo** — Email + SMS marketing, flows, segmentation
2. **Meta Pixel + CAPI** — Facebook/Instagram ad tracking
3. **Google & YouTube channel** — Google Ads, Shopping, free listings
4. **Judge.me or Yotpo** — Product reviews and social proof
5. **GA4** — Web analytics (via GTM or Shopify Pixel API)

### Tier 2 — Growth Stage
6. **Triple Whale or Polar Analytics** — Attribution and analytics
7. **Smile.io** — Loyalty and rewards program
8. **ReConvert or AfterSell** — Post-purchase upsells
9. **Recharge** — Subscriptions (if applicable)
10. **Privy or Wisepops** — Pop-ups and lead capture

### Tier 3 — Scale Stage
11. **Northbeam** — Advanced multi-touch attribution
12. **Gorgias or Zendesk** — Customer support (impacts repeat rate)
13. **TikTok Pixel** — TikTok ad tracking
14. **Loop Returns** — Returns management
15. **Rebuy** — Personalized product recommendations

## Workflow: Full Shopify Audit

When asked to audit a Shopify store's marketing:

1. **Tracking & Analytics** — Pixel/CAPI setup, GA4 integration, UTM consistency, attribution tool
2. **Conversion Funnel** — Session → ATC → Checkout → Purchase rates, identify largest drop-off
3. **Site Speed** — Core Web Vitals, theme performance, app bloat, image optimization
4. **Product Pages** — Layout, imagery, copy, reviews, trust signals, urgency elements
5. **Collection Pages** — Navigation, filters, sorting, merchandising rules
6. **Cart & Checkout** — Cart experience, checkout completion rate, payment options, trust badges
7. **Email/SMS** — Platform integration, flow coverage, campaign frequency, revenue attribution
8. **Paid Media Integration** — Pixel health, CAPI event match quality, product feed quality
9. **SEO** — Title tags, meta descriptions, structured data, site architecture, blog content
10. **Customer Retention** — Loyalty program, subscription offering, post-purchase experience
11. **App Stack** — Review installed apps for redundancy, performance impact, cost
12. **Recommendations** — Prioritized by expected revenue impact and implementation effort

## Shopify-Specific Tracking Setup

### Meta Pixel + CAPI
- Use Shopify's Customer Events (Pixel API) — not the old theme-based pixel
- Enable CAPI through Facebook & Instagram channel app
- Verify Event Match Quality score in Meta Events Manager (target 8+)
- Track: PageView, ViewContent, AddToCart, InitiateCheckout, Purchase

### Google Ads + Enhanced Conversions
- Install Google & YouTube channel for Shopping + Performance Max
- Set up Enhanced Conversions in Google Ads
- Verify conversion tracking in Google Tag Assistant
- Feed optimization: product titles, descriptions, GTINs, custom labels

### GA4
- Recommended: Google Tag Manager via Shopify Pixel API (Custom Pixel)
- Alternative: Google & YouTube channel (simpler but less control)
- Key events: page_view, view_item, add_to_cart, begin_checkout, purchase
- Enhanced measurement: site search, scroll depth, outbound clicks

## How to Use This Skill

Ask me questions like:
- "Audit my Shopify store's conversion funnel"
- "What apps should I add to my Shopify marketing stack?"
- "Help me set up Meta CAPI on Shopify"
- "My add-to-cart rate is low — what should I optimize?"
- "Design a post-purchase upsell strategy"
- "How do I optimize my Google Shopping product feed?"
- "Review my Shopify checkout for conversion improvements"
- "Plan a loyalty program for my DTC brand"

For detailed Shopify API reference, Liquid theme customization, and advanced configurations, see [REFERENCE.md](REFERENCE.md).

## Analysis Examples

For complete analysis patterns, sample outputs, and use cases, see [EXAMPLES.md](EXAMPLES.md).

## Scripts

The skill includes utility scripts for API interaction and automated analysis:

### Fetch Store Data
```bash
# Get store info (API health check)
python scripts/shopify_client.py --resource shop

# List recent orders
python scripts/shopify_client.py --resource orders --days 30

# Export products as CSV
python scripts/shopify_client.py --resource products --status active --format csv --output products.csv

# Quick order count
python scripts/shopify_client.py --resource order-count --status any
```

### Run Analysis
```bash
# Full store audit (all analyses combined)
python scripts/analyze.py --analysis-type full-audit

# Conversion funnel (last 30 days)
python scripts/analyze.py --analysis-type conversion-funnel --days 30

# Product performance
python scripts/analyze.py --analysis-type product-performance --days 30

# Customer cohorts (last 90 days)
python scripts/analyze.py --analysis-type customer-cohorts --days 90

# Revenue analysis with output file
python scripts/analyze.py --analysis-type revenue-analysis --days 30 --output revenue.json
```

The scripts handle API authentication, rate limiting, pagination, and basic analysis. I'll interpret the results and provide actionable recommendations.

## Troubleshooting

**Authentication Error**: Verify that:
- `SHOPIFY_STORE_URL` is your `.myshopify.com` URL (not your custom domain)
- `SHOPIFY_ACCESS_TOKEN` starts with `shpat_` and is from a Custom App
- The app has the required API scopes (read_orders, read_products, read_customers)

**Rate Limiting**: The scripts handle Shopify's 2 requests/second limit automatically. If you see 429 errors, the retry logic will wait and continue. For large stores, consider using `--limit` to reduce data volume.

**No Orders Returned**: Check that:
- The date range (`--days`) covers a period with orders
- The `--status` filter matches your orders (use `any` to see all)
- The Admin API access token hasn't expired

**Import Errors**: Install required packages:
```bash
pip install -r requirements.txt
```

## Security & Privacy

- **Never hardcode** API credentials in code — use `.env` files
- Store access tokens **outside** version control
- Add `.env` and credential files to `.gitignore`
- The scripts are **read-only** — they do not create, modify, or delete any Shopify data
- Use Admin API scopes with minimum required access (read-only)
- Customer PII (emails, names) is processed locally and never stored persistently
- Rotate access tokens periodically

---

# Shopify Reference

## Shopify Analytics (Built-in)

### Key Reports
| Report | Metrics Available |
|--------|-------------------|
| Overview | Total sales, sessions, conversion rate, AOV, returning customer rate |
| Sales by channel | Revenue breakdown by online store, POS, draft orders, etc. |
| Sales by product | Units sold, revenue, average price per product/variant |
| Sales by traffic source | Revenue attributed to UTM source/medium |
| Customers | New vs returning, purchase frequency, geographic distribution |
| Behavior | Top landing pages, top products viewed, search terms |

### Shopify vs GA4 Data Discrepancies
Common differences and why:
- **Sessions**: Shopify counts sessions differently (30-min timeout, new UTM = new session)
- **Conversion rate**: Shopify = orders/sessions; GA4 = purchase events/sessions (may differ)
- **Revenue**: Shopify includes taxes/shipping by default; GA4 depends on implementation
- **Attribution**: Shopify uses last-click; GA4 uses data-driven (default)
- Best practice: Use Shopify as source of truth for revenue, GA4 for behavior/attribution

## Checkout Optimization

### Shopify Checkout (One-Page)
Current features:
- Shop Pay (accelerated checkout — 1.72x higher conversion)
- Express checkout buttons (Apple Pay, Google Pay, PayPal, Amazon Pay)
- Address autocomplete
- Checkout extensibility (Shopify Functions, checkout UI extensions)
- Thank-you page customization

### Checkout Optimization Checklist
1. **Express payments**: Enable Shop Pay, Apple Pay, Google Pay, PayPal at minimum
2. **Guest checkout**: Enable (don't require account creation)
3. **Trust signals**: SSL badge, payment icons, return policy link
4. **Shipping transparency**: Show rates early (or free shipping threshold)
5. **Cart abandonment**: Recovery emails via Klaviyo/Shopify (within 1 hour)
6. **Upsells**: Post-purchase offers (AfterSell, ReConvert, Zipify OCU)
7. **Payment options**: Consider BNPL (Shop Pay Installments, Klarna, Afterpay)
8. **Mobile**: Test entire checkout flow on mobile (60-70%+ of traffic)

### Checkout Extensibility (Shopify Plus)
- **Checkout UI Extensions**: Custom fields, banners, upsells in checkout
- **Shopify Functions**: Custom discounts, shipping rates, payment methods
- **Post-purchase extensions**: One-click upsells after payment
- **Thank-you customizations**: Order status, cross-sells, surveys

## Product Feed Optimization

### Google Merchant Center Feed

#### Required Attributes
| Attribute | Requirements | Optimization Tips |
|-----------|--------------|-------------------|
| title | Max 150 chars | Brand + Product + Key Attributes (front-load important terms) |
| description | Max 5000 chars | Include search terms naturally, highlight key features |
| link | Product URL | Must match landing page exactly |
| image_link | Min 100x100px | White background, no text overlay, high resolution |
| price | Match landing page | Include sale_price if applicable |
| availability | in_stock / out_of_stock / preorder | Sync frequently (at least daily) |
| brand | Brand name | Required for most categories |
| gtin | UPC/EAN/ISBN | Required for branded products |
| condition | new / refurbished / used | Required |

#### Recommended Attributes
| Attribute | Use For |
|-----------|---------|
| product_type | Your own categorization (up to 5 levels deep) |
| google_product_category | Google's taxonomy ID |
| custom_label_0 through 4 | Campaign segmentation (margin tier, best seller, season, new) |
| additional_image_link | Up to 10 additional images |
| sale_price | Crossed-out original price display |
| shipping | Override account-level shipping |
| tax | Override account-level tax |

#### Title Formula Templates
```
Apparel: [Brand] [Product Type] [Material] [Color] [Size]
→ "Nike Air Max 90 Leather White Men's Size 10"

Electronics: [Brand] [Product Line] [Model] [Key Spec] [Color]
→ "Apple MacBook Pro 14 M3 Pro 18GB Space Gray"

Beauty: [Brand] [Product Type] [Key Ingredient] [Size]
→ "CeraVe Moisturizing Cream Hyaluronic Acid 16oz"

Home: [Brand] [Product Type] [Material] [Dimensions] [Color]
→ "West Elm Mid-Century Coffee Table Walnut 42-inch"
```

### Meta Commerce Manager Feed
- Synced via Facebook & Instagram channel on Shopify
- Auto-pulls product data from Shopify catalog
- Customization via feed rules in Commerce Manager
- Required: title, description, image, price, availability, link, brand
- Product sets: Group products for Dynamic Ads targeting

## Tracking Implementation

### Meta Pixel + CAPI on Shopify
**Setup via Facebook & Instagram Channel (Recommended)**:
1. Install Facebook & Instagram channel in Shopify
2. Connect Facebook Business Manager
3. Select/create Pixel
4. CAPI is enabled automatically via Shopify's server-side integration
5. Verify Event Match Quality in Meta Events Manager

**Events synced automatically**:
- PageView, ViewContent, AddToCart, InitiateCheckout, Purchase, AddPaymentInfo, Search

### Google Ads Enhanced Conversions
**Setup via Google & YouTube Channel**:
1. Install Google & YouTube channel in Shopify
2. Link Google Ads account
3. Enhanced conversions enabled automatically
4. Verify in Google Ads > Tools > Conversions > Tag diagnostics

### GA4 on Shopify
**Option 1: Google & YouTube Channel (Simple)**
- Automatic e-commerce event tracking
- Limited customization
- Events: page_view, view_item, add_to_cart, begin_checkout, purchase

**Option 2: Custom Pixel via GTM (Advanced)**
```javascript
// Shopify Customer Events > Custom Pixel
analytics.subscribe("page_viewed", (event) => {
  gtag('event', 'page_view', {
    page_location: event.context.document.location.href,
    page_title: event.context.document.title
  });
});

analytics.subscribe("product_viewed", (event) => {
  gtag('event', 'view_item', {
    currency: event.data.productVariant.price.currencyCode,
    value: parseFloat(event.data.productVariant.price.amount),
    items: [{
      item_id: event.data.productVariant.sku || event.data.productVariant.id,
      item_name: event.data.productVariant.title,
      price: parseFloat(event.data.productVariant.price.amount)
    }]
  });
});

analytics.subscribe("checkout_completed", (event) => {
  gtag('event', 'purchase', {
    transaction_id: event.data.checkout.order?.id,
    value: parseFloat(event.data.checkout.totalPrice.amount),
    currency: event.data.checkout.totalPrice.currencyCode,
    items: event.data.checkout.lineItems.map(item => ({
      item_id: item.variant?.sku || item.variant?.id,
      item_name: item.title,
      quantity: item.quantity,
      price: parseFloat(item.variant?.price?.amount || 0)
    }))
  });
});
```

### UTM Tracking Best Practices
```
# Paid channels
?utm_source=facebook&utm_medium=paid&utm_campaign={campaign_name}&utm_content={ad_name}
?utm_source=google&utm_medium=cpc&utm_campaign={campaign_name}&utm_term={keyword}
?utm_source=bing&utm_medium=cpc&utm_campaign={campaign_name}

# Email
?utm_source=klaviyo&utm_medium=email&utm_campaign={campaign_name}&utm_content={flow_name}

# Social
?utm_source=instagram&utm_medium=social&utm_campaign={post_type}
?utm_source=linkedin&utm_medium=social&utm_campaign={post_type}
```

## Shopify App Recommendations by Category

### Email & SMS
| App | Best For | Price |
|-----|----------|-------|
| Klaviyo | Full-featured email + SMS, best Shopify integration | Free to 250 contacts, then from $20/mo |
| Omnisend | Budget alternative to Klaviyo | Free to 250 contacts, then from $16/mo |
| Postscript | SMS-only specialist | $25/mo + per-message |
| Attentive | Enterprise SMS | Custom pricing |

### Reviews & Social Proof
| App | Best For | Price |
|-----|----------|-------|
| Judge.me | Budget reviews with photos/video | Free plan, $15/mo unlimited |
| Yotpo | Reviews + loyalty + referrals (suite) | Free plan, $79/mo+ |
| Stamped | Reviews + loyalty | Free plan, $23/mo+ |
| Loox | Photo/video reviews focus | $9.99/mo+ |

### Upsells & Cross-Sells
| App | Best For | Price |
|-----|----------|-------|
| ReConvert | Thank-you page + post-purchase | $4.99/mo+ |
| AfterSell | Post-purchase + thank-you page | $7.99/mo+ |
| Zipify OCU | One-click upsells (Plus) | $35/mo+ |
| Rebuy | AI personalization + upsells | $99/mo+ |
| Bold Upsell | Cart + checkout upsells | $9.99/mo+ |

### Attribution & Analytics
| App | Best For | Price |
|-----|----------|-------|
| Triple Whale | DTC attribution + creative analytics | $100/mo+ |
| Northbeam | Multi-touch attribution | $400/mo+ |
| Polar Analytics | All-in-one analytics dashboard | $300/mo+ |
| Lifetimely | LTV + cohort analysis | $19/mo+ |

### Loyalty & Referrals
| App | Best For | Price |
|-----|----------|-------|
| Smile.io | Points, VIP tiers, referrals | Free plan, $49/mo+ |
| LoyaltyLion | Advanced loyalty programs | $199/mo+ |
| Yotpo Loyalty | Part of Yotpo suite | From $79/mo |
| ReferralCandy | Referral program focus | $47/mo+ |

### Subscriptions
| App | Best For | Price |
|-----|----------|-------|
| Recharge | Market leader, most integrations | $99/mo+ |
| Loop | Shopify-native subscriptions | Free plan, $99/mo+ |
| Bold Subscriptions | Budget option | $49.99/mo+ |
| Skio | Passwordless + group subs | $299/mo+ |

### SEO
| App | Best For | Price |
|-----|----------|-------|
| SEO Manager | Comprehensive SEO toolkit | $20/mo |
| Smart SEO | JSON-LD + meta tags | Free plan, $4.99/mo |
| Schema Plus | Rich snippet structured data | $14.99/mo |

## Shopify API Reference

### REST Admin API
```
Base URL: https://{store}.myshopify.com/admin/api/2024-10/

# Products
GET    /products.json
POST   /products.json
GET    /products/{id}.json
PUT    /products/{id}.json
DELETE /products/{id}.json

# Orders
GET    /orders.json?status=any
GET    /orders/{id}.json
POST   /orders.json

# Customers
GET    /customers.json
GET    /customers/{id}.json
POST   /customers.json
GET    /customers/search.json?query=email:test@example.com

# Inventory
GET    /inventory_levels.json?location_ids={id}
POST   /inventory_levels/set.json
```

### GraphQL Admin API
```graphql
# Product query
{
  products(first: 10) {
    edges {
      node {
        id
        title
        totalInventory
        variants(first: 5) {
          edges {
            node {
              sku
              price
              inventoryQuantity
            }
          }
        }
      }
    }
  }
}

# Order query
{
  orders(first: 10, sortKey: CREATED_AT, reverse: true) {
    edges {
      node {
        id
        name
        totalPriceSet { shopMoney { amount currencyCode } }
        customer { email firstName lastName }
        lineItems(first: 5) {
          edges {
            node {
              title
              quantity
              variant { sku price }
            }
          }
        }
      }
    }
  }
}
```

### Shopify Webhooks
| Topic | When Fired |
|-------|-----------|
| orders/create | New order placed |
| orders/paid | Order payment confirmed |
| orders/fulfilled | Order fulfilled |
| orders/cancelled | Order cancelled |
| products/create | New product created |
| products/update | Product updated |
| customers/create | New customer registered |
| checkouts/create | Checkout initiated |
| checkouts/update | Checkout updated |
| inventory_levels/update | Inventory changed |

## Liquid Theme Reference

### Common Objects
```liquid
{{ product.title }}
{{ product.price | money }}
{{ product.description }}
{{ product.featured_image | img_url: '500x' }}
{{ product.variants.first.sku }}
{{ product.metafields.custom.field_name }}

{{ collection.title }}
{{ collection.products_count }}

{{ customer.first_name }}
{{ customer.email }}
{{ customer.orders_count }}
{{ customer.total_spent | money }}

{{ cart.item_count }}
{{ cart.total_price | money }}
```

### Useful Filters
```liquid
{{ product.price | money }}                    # $29.99
{{ product.price | money_without_currency }}   # 29.99
{{ 'now' | date: '%B %d, %Y' }}              # January 15, 2024
{{ product.title | handleize }}                # product-title
{{ product.description | strip_html | truncate: 160 }}  # SEO description
{{ product.images | size }}                    # Number of images
```

## Core Web Vitals & Speed

### Key Metrics
| Metric | Good | Needs Work | Poor |
|--------|------|------------|------|
| LCP (Largest Contentful Paint) | <2.5s | 2.5-4s | >4s |
| INP (Interaction to Next Paint) | <200ms | 200-500ms | >500ms |
| CLS (Cumulative Layout Shift) | <0.1 | 0.1-0.25 | >0.25 |

### Common Shopify Speed Issues
1. **Too many apps**: Each adds JavaScript/CSS (audit and remove unused)
2. **Unoptimized images**: Use Shopify's CDN with responsive sizes
3. **Render-blocking scripts**: Defer non-critical JavaScript
4. **Heavy theme**: Choose performance-optimized themes (Dawn, Sense, Craft)
5. **Third-party scripts**: Chat widgets, social embeds, analytics tags
6. **No lazy loading**: Load images below fold on scroll

### Speed Optimization Checklist
- [ ] Remove unused apps (test disabling one at a time)
- [ ] Optimize images (WebP format, responsive sizes)
- [ ] Minimize custom Liquid code
- [ ] Use system fonts or limit web fonts to 2 families
- [ ] Defer third-party scripts (chat, social, etc.)
- [ ] Enable lazy loading for images below fold
- [ ] Minimize redirects
- [ ] Use Shopify's CDN for all assets
- [ ] Test with Google PageSpeed Insights and Chrome DevTools
