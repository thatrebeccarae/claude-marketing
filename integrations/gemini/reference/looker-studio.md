# looker-studio


# Looker Studio (Google Data Studio)

Expert-level guidance for Looker Studio — building dashboards, connecting data sources, designing visualizations, and creating automated marketing reports.

## Core Capabilities

### Dashboard Design
- Layout and visual hierarchy best practices
- Executive summary vs detailed operational dashboards
- Mobile-responsive report design
- Interactive controls: date range selectors, filters, drill-downs
- Consistent styling with themes and color palettes

### Data Sources & Connectors
- **Native (free)**: Google Analytics 4, Google Ads, Google Sheets, BigQuery, Search Console, YouTube Analytics
- **Partner connectors**: Facebook Ads, Microsoft Ads, LinkedIn Ads, HubSpot, Salesforce, Shopify, Klaviyo, Semrush
- **Community connectors**: Hundreds of third-party sources
- **Data blending**: Join multiple sources on shared dimensions
- **Custom queries**: BigQuery SQL, Google Sheets formulas as data sources

### Calculated Fields & Metrics
- Regex-based field creation (REGEXP_MATCH, REGEXP_REPLACE, REGEXP_EXTRACT)
- CASE statements for custom groupings and bucketing
- Date functions for period-over-period comparisons
- Aggregation (SUM, AVG, COUNT_DISTINCT, MEDIAN)
- Blended field calculations across sources

#### Formula Syntax Rules
- **No comments allowed** — Looker Studio formulas do not support `--`, `//`, or `/* */` style comments. Never include comments in formulas. Add context in the field description instead.
- **No inline flags in simple cases** — prefer `CONTAINS_TEXT()`, `LOWER()`, or exact match over regex when possible
- **RE2 regex engine** — supports `(?i)` for case-insensitive, but does NOT support lookaheads/lookbehinds
- **String escaping** — use `\\` for literal backslash in regex patterns within string literals (e.g., `"\\s"` for whitespace, `"\\|"` for literal pipe)

### Report Automation
- Scheduled email delivery (PDF snapshots)
- Embedded reports in websites and portals
- Template reports for client scaling
- Data freshness monitoring

## Dashboard Templates by Use Case

### Marketing Performance Dashboard
```
Page 1: Executive Summary
|- KPI scorecards (Revenue, ROAS, CPA, Spend, Conversions)
|- Period-over-period trend lines
|- Channel performance table (sortable)
|- Budget pacing gauge chart

Page 2: Paid Media Deep-Dive
|- Google Ads performance (campaign breakdown)
|- Meta Ads performance (campaign breakdown)
|- Microsoft Ads performance
|- Cross-channel spend allocation (pie/donut)
|- CPA trend by channel (combo chart)

Page 3: SEO & Organic
|- Google Search Console: impressions, clicks, CTR, position
|- Top queries table
|- Page-level performance
|- Organic landing page engagement (from GA4)

Page 4: Email & CRM
|- Email campaign metrics (opens, clicks, revenue)
|- List growth trend
|- Flow/automation revenue
|- Subscriber engagement tiers

Page 5: Conversion Funnel
|- Funnel visualization (awareness -> consideration -> conversion)
|- Landing page performance table
|- Device breakdown
|- Geographic heatmap
```

### E-commerce Dashboard
```
Page 1: Revenue Overview
|- Revenue, Orders, AOV, Conversion Rate scorecards
|- Revenue trend (daily/weekly)
|- Revenue by channel
|- Top products table

Page 2: Customer Acquisition
|- New vs returning customer revenue
|- CAC by channel
|- LTV:CAC ratio
|- First-order source attribution
```

### SEO Dashboard
```
Page 1: Organic Performance
|- Total clicks, impressions, CTR, avg position
|- Trend lines (90-day)
|- Top 20 queries (with position change)
|- Top landing pages
|- Device + country breakdown
```

## Key Visualization Guidelines

| Data Type | Best Chart | Avoid |
|-----------|-----------|-------|
| KPI with comparison | Scorecard with delta | Pie chart |
| Trend over time | Line chart or area chart | Bar chart (if >7 periods) |
| Category comparison | Horizontal bar chart | 3D charts |
| Part of whole | Stacked bar or donut | Pie with >6 slices |
| Distribution | Histogram or heatmap | Scatter (if not correlation) |
| Geographic | Geo map or heatmap | Tables for location data |
| Funnel | Custom funnel (shapes) | Bar chart |
| Table data | Table with heatmap bars | Unsorted tables |

## Workflow: Build a Dashboard

When asked to create a Looker Studio dashboard:

1. **Define Purpose** — Who views it? How often? What decisions does it inform?
2. **Identify Data Sources** — Which platforms/connectors needed? Any blending?
3. **Design KPI Framework** — Primary metrics, secondary metrics, diagnostic metrics
4. **Plan Layout** — Page structure, visual hierarchy, interactivity
5. **Create Calculated Fields** — Custom metrics, CASE groupings, regex transformations
6. **Build Visualizations** — Chart types matched to data types, consistent formatting
7. **Add Controls** — Date range, filters, drill-down parameters
8. **Style & Polish** — Theme, colors, fonts, logos, white space
9. **Test & Validate** — Cross-reference numbers with source platforms
10. **Set Up Delivery** — Scheduled emails, sharing permissions, embedding

## Calculated Field Recipes

### Period-over-Period Comparison
```
CASE
  WHEN date_field >= DATE_DIFF(TODAY(), INTERVAL 30 DAY) THEN "Current Period"
  WHEN date_field >= DATE_DIFF(TODAY(), INTERVAL 60 DAY) THEN "Previous Period"
  ELSE "Older"
END
```

### Channel Grouping (Custom)
```
CASE
  WHEN REGEXP_MATCH(source_medium, "google.*cpc|google.*paid") THEN "Google Ads"
  WHEN REGEXP_MATCH(source_medium, "facebook|fb|meta|instagram") THEN "Meta Ads"
  WHEN REGEXP_MATCH(source_medium, "bing.*cpc|microsoft") THEN "Microsoft Ads"
  WHEN REGEXP_MATCH(source_medium, "email|klaviyo|braze") THEN "Email"
  WHEN source_medium = "organic" THEN "Organic Search"
  WHEN REGEXP_MATCH(source_medium, "social") THEN "Organic Social"
  ELSE "Other"
END
```

### ROAS Calculation
```
SUM(revenue) / SUM(cost)
```

## How to Use This Skill

Ask me questions like:
- "Build a marketing performance dashboard in Looker Studio"
- "How do I connect Facebook Ads data to Looker Studio?"
- "Create a calculated field for custom channel grouping"
- "Design an executive summary page with KPI scorecards"
- "How do I blend Google Ads and GA4 data?"
- "Build an SEO dashboard with Search Console data"
- "What's the best way to show period-over-period comparisons?"
- "Help me set up automated email reports for my client"

For detailed Looker Studio function reference, connector setup guides, and advanced techniques, see [REFERENCE.md](REFERENCE.md).


## DTC Dashboard Recipes

Dashboard templates designed for DTC e-commerce teams running Klaviyo + Shopify + GA4.

### 1. CRM Performance Dashboard
Track email and SMS marketing effectiveness with Klaviyo data.

```
Page 1: Email & SMS Overview
|- Scorecards: Total Revenue, Flow Revenue %, Campaign Revenue %, List Size
|- Revenue trend: flows vs campaigns over time (area chart)
|- Channel split: email vs SMS revenue (stacked bar)
|- Engagement tiers donut: Active / Warm / At-Risk / Lapsed

Page 2: Flow Performance
|- Flow revenue table (sortable by revenue, click rate)
|- Welcome Series funnel (sent -> opened -> clicked -> converted)
|- Abandoned Cart recovery rate trend
|- Flow-over-flow comparison (combo chart)

Page 3: Campaign Performance
|- Campaign table: send date, subject, open rate, click rate, revenue
|- A/B test results (winner highlighting)
|- Send time heatmap (day of week x hour)
|- Unsubscribe rate trend
```

**Data source**: Google Sheets (fed by `data_pipeline.py --action sync-klaviyo`)

### 2. Lifecycle Marketing Dashboard
Map flow performance across the customer journey.

```
Page 1: Journey Overview
|- Stage funnel: Prospect -> New Customer -> Active -> VIP -> At-Risk -> Lapsed
|- Revenue by stage (horizontal bar)
|- Stage transition rates

Page 2: Stage Deep-Dive
|- Filter control: select lifecycle stage
|- Flow performance for selected stage
|- Customer count trend per stage
|- Revenue per customer by stage (combo chart)
```

### 3. Revenue Attribution Dashboard
Reconcile Klaviyo-attributed revenue with Shopify actuals.

```
Page 1: Attribution Overview
|- Scorecards: Shopify Revenue, Klaviyo Attributed, Attribution %, Gap
|- Daily revenue: Shopify total vs Klaviyo attributed (dual axis)
|- Channel breakdown: Email, SMS, Flows, Campaigns (stacked bar)
|- Attribution gap trend line

Page 2: Channel Detail
|- Channel performance table (Klaviyo revenue per channel)
|- Shopify source breakdown (UTM-based)
|- Overlap analysis notes
```

**Data source**: Blended — Shopify Orders sheet + Klaviyo Revenue sheet

### 4. Campaign ROI Tracker
Campaign-level ROI with A/B test insights.

```
Page 1: Campaign Scorecard
|- Filter: date range, campaign type, channel
|- Campaign table with conditional formatting (green/red on benchmarks)
|- Revenue per recipient trend
|- Best-performing subject lines (top 10)

Page 2: Send Optimization
|- Send time analysis (heatmap: day x hour)
|- Audience size vs performance scatter
|- Frequency analysis: sends per subscriber per month
```

## DTC Calculated Field Library

Copy-paste formulas for common DTC metrics in Looker Studio.

### Customer Lifetime Value (LTV)
```
SUM(total_revenue) / COUNT_DISTINCT(customer_email)
```

### Customer Acquisition Cost (CAC)
```
SUM(ad_spend) / COUNT_DISTINCT(CASE WHEN order_number = 1 THEN customer_email ELSE NULL END)
```

### LTV:CAC Ratio
```
(SUM(total_revenue) / COUNT_DISTINCT(customer_email)) / (SUM(ad_spend) / COUNT_DISTINCT(new_customer_email))
```

### Repeat Purchase Rate
```
COUNT_DISTINCT(CASE WHEN order_count > 1 THEN customer_email ELSE NULL END) / COUNT_DISTINCT(customer_email) * 100
```

### Flow Revenue Percentage
```
SUM(CASE WHEN source_type = "flow" THEN revenue ELSE 0 END) / SUM(revenue) * 100
```

### Engagement Tier
```
CASE
  WHEN days_since_last_open <= 30 THEN "Active (0-30d)"
  WHEN days_since_last_open <= 90 THEN "Warm (31-90d)"
  WHEN days_since_last_open <= 180 THEN "At-Risk (91-180d)"
  ELSE "Lapsed (180d+)"
END
```

### Revenue Per Recipient
```
SUM(revenue) / SUM(recipients)
```

### Discount Impact
```
SUM(discount_amount) / SUM(gross_revenue) * 100
```

## Data Source Setup

### Connecting Klaviyo Data (Free Method)

Paid connectors (Supermetrics, $30-100/mo) work but aren't necessary. The free pattern:

1. **Run the data pipeline script** to push Klaviyo data to Google Sheets:
   ```bash
   python scripts/data_pipeline.py --action sync-klaviyo --sheet-id YOUR_SHEET_ID
   ```
2. **In Looker Studio**, add data source > Google Sheets > select the spreadsheet
3. **Set date field type** to Date in the data source config
4. **Schedule sync** — run the pipeline daily via cron or n8n

### Connecting Shopify Data (Free Method)
1. Push order data to Sheets:
   ```bash
   python scripts/data_pipeline.py --action sync-shopify --sheet-id YOUR_SHEET_ID --days 30
   ```
2. Connect the Sheet in Looker Studio
3. Blend with Klaviyo sheet on Date dimension for attribution view

### Connecting GA4 Data (Native — Free)
1. In Looker Studio, add data source > Google Analytics > select your GA4 property
2. No intermediary needed — native connector is comprehensive and free

### Creating Pre-Formatted Sheets
```bash
# Create a sheet with correct headers for a CRM dashboard
python scripts/data_pipeline.py --action create-sheet --template crm-dashboard

# See all available templates
python scripts/data_pipeline.py --action list-templates
```

## Analysis Examples

For complete dashboard build walkthroughs and use cases, see [EXAMPLES.md](EXAMPLES.md).

## Scripts

The skill includes a data pipeline script for pushing data to Google Sheets:

### Sync Klaviyo Data
```bash
python scripts/data_pipeline.py --action sync-klaviyo --sheet-id SPREADSHEET_ID
```

### Sync Shopify Orders
```bash
python scripts/data_pipeline.py --action sync-shopify --sheet-id SPREADSHEET_ID --days 30
```

### Create Dashboard Sheet
```bash
python scripts/data_pipeline.py --action create-sheet --template crm-dashboard
```

## Troubleshooting

**Data not refreshing**: Google Sheets data in Looker Studio caches for ~15 minutes. Force refresh with the "Refresh data" button in Looker Studio, or set the data source cache to 1 minute in report settings.

**Calculated field errors**: Common causes:
- **Comments in formulas** — Looker Studio does NOT support `--`, `//`, or `/* */` comments. Never include comments in calculated field formulas. Use the field description for documentation instead.
- **Type mismatches** — Ensure date fields are typed as Date (not Text) in the data source config. Use CAST() to convert between types.
- **Regex escaping** — Patterns are inside string literals, so backslashes need double-escaping (e.g., `"\\s"` for whitespace, `"\\|"` for literal pipe).

**Blending shows nulls**: Left outer join means unmatched rows from the right source show null. Ensure join keys match exactly (case-sensitive, same date format).

**Sheets row limit**: Google Sheets has a 10M cell limit. For large datasets, aggregate before writing (daily summaries instead of per-event data), or use BigQuery instead.

**Service account permission errors**: The service account email must be shared on the target Google Sheet with Editor access. Check IAM permissions if Drive API calls fail.

## Security & Privacy

- **Never hardcode** API credentials in scripts — use `.env` files
- Store service account JSON **outside** version control
- Add `.env` and credential files to `.gitignore`
- The data pipeline writes to Google Sheets you control — data stays in your Google Workspace
- Pipeline scripts are read-only against Klaviyo and Shopify APIs
- Use least-privilege API scopes (read-only keys)

---

# Looker Studio Reference

## Data Source Connectors

### Native (Free) Google Connectors
| Connector | Data Available |
|-----------|---------------|
| Google Analytics 4 | Sessions, users, events, conversions, ecommerce, demographics |
| Google Ads | Campaigns, keywords, ads, conversions, quality score, auction insights |
| Google Sheets | Any tabular data (manual or API-fed) |
| BigQuery | SQL-queryable data warehouse |
| Search Console | Queries, pages, impressions, clicks, CTR, position |
| YouTube Analytics | Views, watch time, subscribers, demographics, revenue |
| Google Cloud Storage | CSV, JSON files |
| Campaign Manager 360 | Display & video campaign data |
| Display & Video 360 | Programmatic campaign data |

### Popular Partner Connectors
| Connector | Provider | Cost |
|-----------|----------|------|
| Facebook Ads | Supermetrics, Funnel, Windsor.ai | $30-100/mo |
| Microsoft Ads | Supermetrics, Windsor.ai | $30-100/mo |
| LinkedIn Ads | Supermetrics | $30-100/mo |
| HubSpot | Supermetrics, Porter Metrics | $30-100/mo |
| Shopify | Supermetrics, Coupler.io | $30-100/mo |
| Klaviyo | Supermetrics | $30-100/mo |
| Salesforce | Supermetrics | $50-150/mo |
| TikTok Ads | Supermetrics | $30-100/mo |
| Semrush | Supermetrics | $30-100/mo |

### Free Workarounds
- Use Google Sheets as intermediary (pull data via API/Zapier/n8n -> Sheet -> Looker Studio)
- BigQuery: Load data from any source, connect natively
- CSV upload: Manual periodic updates

## Calculated Fields Reference

### Data Types
| Type | Description | Example |
|------|-------------|---------|
| Number | Numeric values | SUM(revenue) |
| Text | String values | CONCAT(first_name, " ", last_name) |
| Date | Date/datetime | TODATE(date_string, 'BASIC', '%Y%m%d') |
| Boolean | True/false | clicks > 100 |
| Geo | Geographic data | Country, city |

### Arithmetic
```
# Basic math
revenue - cost                        # Profit
(revenue - cost) / revenue * 100      # Profit Margin %
SUM(revenue) / SUM(cost)              # ROAS
SUM(conversions) / SUM(clicks) * 100  # Conversion Rate %
SUM(cost) / SUM(conversions)          # CPA
SUM(clicks) / SUM(impressions) * 100  # CTR %
```

### Text Functions
```
# Concatenation
CONCAT(source, " / ", medium)

# Substring
SUBSTR(campaign_name, 1, 10)

# Replace
REPLACE(url, "https://", "")

# Lowercase/Uppercase
LOWER(source)
UPPER(medium)

# Length
LENGTH(page_title)

# Contains check (returns boolean)
CONTAINS_TEXT(campaign_name, "brand")
```

### CASE Statements
```
# Custom channel grouping
CASE
  WHEN REGEXP_MATCH(source_medium, "(?i)google.*cpc") THEN "Google Ads"
  WHEN REGEXP_MATCH(source_medium, "(?i)(facebook|fb|meta|ig).*paid") THEN "Meta Ads"
  WHEN REGEXP_MATCH(source_medium, "(?i)bing.*cpc") THEN "Microsoft Ads"
  WHEN REGEXP_MATCH(source_medium, "(?i)linkedin.*cpc") THEN "LinkedIn Ads"
  WHEN REGEXP_MATCH(medium, "(?i)email") THEN "Email"
  WHEN REGEXP_MATCH(medium, "(?i)organic") THEN "Organic Search"
  WHEN REGEXP_MATCH(medium, "(?i)(social|facebook|instagram|twitter|linkedin)") THEN "Organic Social"
  WHEN REGEXP_MATCH(medium, "(?i)referral") THEN "Referral"
  WHEN source = "(direct)" THEN "Direct"
  ELSE "Other"
END

# Performance tier
CASE
  WHEN conversion_rate >= 5 THEN "High Performer"
  WHEN conversion_rate >= 2 THEN "Average"
  ELSE "Needs Attention"
END

# Revenue buckets
CASE
  WHEN revenue >= 1000 THEN "$1,000+"
  WHEN revenue >= 500 THEN "$500-999"
  WHEN revenue >= 100 THEN "$100-499"
  ELSE "Under $100"
END
```

### Regex Functions
```
# Match (returns boolean)
REGEXP_MATCH(page_path, "/blog/.*")

# Extract
REGEXP_EXTRACT(page_path, "/blog/(.*)")

# Replace
REGEXP_REPLACE(utm_campaign, "_", " ")

# Common patterns
REGEXP_MATCH(source, "(?i)(google|bing|yahoo|duckduckgo)")  # Search engines
REGEXP_MATCH(page_path, "^/(product|shop|store)/")           # Product pages
REGEXP_EXTRACT(url, "utm_campaign=([^&]+)")                  # Extract UTM param
```

### Date Functions
```
# Current date/time
CURRENT_DATE()
CURRENT_DATETIME()

# Date parts
YEAR(date_field)
MONTH(date_field)
WEEK(date_field)
DAY(date_field)
QUARTER(date_field)

# Date math
DATE_DIFF(date1, date2)              # Days between dates
DATETIME_ADD(date_field, INTERVAL 7 DAY)
DATETIME_SUB(date_field, INTERVAL 30 DAY)

# Date formatting
FORMAT_DATETIME("%Y-%m-%d", date_field)
FORMAT_DATETIME("%B %Y", date_field)  # "January 2024"

# Date parsing
TODATE(date_string, 'BASIC', '%Y%m%d')
PARSE_DATETIME('%Y-%m-%dT%H:%M:%S', datetime_string)
```

### Aggregation Functions
```
SUM(metric)
AVG(metric)
COUNT(dimension)
COUNT_DISTINCT(dimension)
MIN(metric)
MAX(metric)
MEDIAN(metric)
PERCENTILE(metric, 90)              # 90th percentile
```

### Conditional Aggregation
```
# Count with condition
SUM(CASE WHEN device = "mobile" THEN sessions ELSE 0 END)

# Weighted average
SUM(ctr * impressions) / SUM(impressions)  # Weighted CTR
```

## Chart Types & Best Practices

### Scorecard
- Best for: KPIs with period comparison
- Settings: Show comparison period, compact numbers, conditional formatting
- Use custom date ranges for accurate comparisons

### Time Series (Line Chart)
- Best for: Trends over time
- Settings: Smooth lines for trends, dual axis for different scales
- Limit to 3-4 series for readability

### Bar Chart
- Best for: Category comparisons
- Horizontal for long labels, vertical for time-based
- Sort by value (not alphabetical) for impact

### Table
- Best for: Detailed data exploration
- Settings: Heatmap bars, pagination, sortable columns
- Add conditional formatting for at-a-glance insights

### Pie/Donut Chart
- Best for: Simple part-of-whole (max 5-6 slices)
- Avoid for: Many categories, similar-sized slices
- Donut with KPI in center is effective

### Geo Map
- Best for: Geographic distribution
- Settings: Color scale (sequential for values, diverging for comparison)
- Bubble map for city-level data

### Combo Chart
- Best for: Two related metrics with different scales (e.g., spend + CPA)
- Line + bar combination
- Use dual Y-axes carefully

### Treemap
- Best for: Hierarchical data with size + color dimensions
- Settings: Size = volume metric, color = efficiency metric

## Controls (Interactive Filters)

### Date Range Control
- Pre-set options: Last 7/14/28/30/90 days, this/last month/quarter/year
- Custom range picker
- Comparison period: previous period, same period last year
- Applies to all charts on page (or linked chart group)

### Filter Control
- Dropdown: Single or multi-select from dimension values
- Search bar: Type-to-filter for large lists
- Slider: Numeric range selection
- Checkbox: Boolean toggle

### Data Control
- Lets viewer switch data sources (e.g., different GA4 properties)
- Useful for multi-client reports with same structure

### Parameters
- User-defined variables (text, number, date)
- Reference in calculated fields: @parameter_name
- Example: CPA goal parameter -> conditional formatting in charts

## Data Blending

### How It Works
- Joins multiple data sources on shared dimensions (join keys)
- Left outer join by default
- Max 5 data sources per blend
- Blended data can be used in charts and calculated fields

### Common Blends
```
Blend 1: Google Ads + GA4
|- Join key: Date + Campaign (UTM)
|- From Google Ads: Cost, Clicks, Impressions
|- From GA4: Sessions, Conversions, Revenue
Result: Full-funnel view with ROAS

Blend 2: Multiple Ad Platforms
|- Join key: Date
|- From Google Ads: Cost, Conversions
|- From Facebook Ads: Cost, Conversions
|- From Microsoft Ads: Cost, Conversions
Result: Cross-platform daily spend/conversion comparison

Blend 3: Google Sheets + GA4
|- Join key: Page URL
|- From Sheets: Content category, author, publish date
|- From GA4: Pageviews, engaged sessions, conversions
Result: Content performance with editorial metadata
```

### Limitations
- Cannot filter a blend on a field from only one source
- Aggregation happens before joining (pre-aggregated)
- Performance can be slower with large datasets
- Null handling: unmatched rows show null for the missing source

## Report Design Best Practices

### Layout Principles
1. **Z-pattern**: Important KPIs top-left, details flow right and down
2. **Visual hierarchy**: Largest/boldest = most important metric
3. **White space**: Don't crowd charts -- breathing room improves readability
4. **Consistent grid**: Align charts to an invisible grid (12-column recommended)
5. **Page structure**: Summary -> Detail -> Deep-dive (progressive disclosure)

### Color Guidelines
- Max 5-7 colors in a single chart
- Use brand colors consistently
- Red = negative/down, green = positive/up (universal convention)
- Sequential palette for ranges (light -> dark)
- High contrast for accessibility

### Report Sizing
- **Desktop optimized**: 1200 x 900px per page (16:9 landscape)
- **PDF export**: Standard page sizes work best
- **Embedded**: Match container width, fluid height
- **Mobile**: Use responsive layout mode, vertical scroll

### Performance Tips
- Limit data sources per page (3-4 max)
- Use date range controls to limit data pulled
- Avoid blending large datasets
- Use extract data sources for slow connections
- Reduce calculated field complexity where possible

## Sharing & Distribution

### Sharing Options
| Method | Who Can View | Real-time? |
|--------|-------------|------------|
| Link sharing (viewers) | Anyone with link | Yes |
| Link sharing (editors) | Collaborators | Yes |
| Embed (iframe) | Website visitors | Yes |
| Scheduled email (PDF) | Email recipients | Snapshot |
| Download (PDF/CSV) | Manual | Snapshot |

### Embedding
```html
<iframe
  width="800"
  height="600"
  src="https://lookerstudio.google.com/embed/reporting/REPORT_ID/page/PAGE_ID"
  frameborder="0"
  style="border:0"
  allowfullscreen
  sandbox="allow-storage-access-by-user-activation allow-scripts allow-same-origin allow-popups allow-popups-to-escape-sandbox"
></iframe>
```

### Template Reports
- Create a report with placeholder data source
- Share as template link
- Viewers make a copy with their own data source
- Useful for: agency-client scaling, community templates
