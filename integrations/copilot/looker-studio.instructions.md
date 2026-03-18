Looker Studio (formerly Google Data Studio) expertise. Build dashboards, design data visualizations, connect data sources, and create marketing reports. Use when the user asks about Looker Studio, Data Studio, marketing dashboards, data visualization, report building, or connecting analytics data sources.


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


(Truncated. See full skill at github.com/thatrebeccarae/claude-marketing)
