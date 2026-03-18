# Pro Report Builder — Examples

## Example 1: SaaS Platform Email Marketing Audit

### Prompt

> Create a technical audit report for a SaaS platform email marketing setup. The audit found 3 critical issues, 4 high-priority items, and 2 quick wins. Key metrics: $52K monthly email revenue, 22% open rate (below 25% benchmark), 1.8% click rate (below 3% benchmark). 8 pages total.

### Expected Document Structure

```
Page 1: Cover Page (dark)
  - Tag: "EMAIL MARKETING AUDIT"
  - Title: "[Company Name]"
  - Subtitle: "Comprehensive Email & Lifecycle Analysis"
  - Meta: Date, Account, Industry, Period

Page 2: Executive Summary
  - KPI row (4 cards): Total Revenue, Open Rate, Click Rate, Revenue at Risk
  - Key findings callout (blue)
  - Brief narrative (2-3 sentences)

Page 3: Flow Audit
  - Essential flows checklist table (10 rows, severity-colored status)
  - Callout (red): missing critical flows

Page 4: Segment Analysis
  - Segment health table
  - Callout (amber): engagement tier gaps

Page 5: Campaign Performance
  - Metrics table with benchmarks (green/amber/red severity)
  - Callout (green): top performer highlight

Page 6: Recommendations — Priority 1 (Critical)
  - Priority banner (critical)
  - 3 rec-cards with ISSUE/IMPACT/ACTION/TIMELINE

Page 7: Recommendations — Priority 2 (High)
  - Priority banner (high)
  - 4 minimal rec-cards with ISSUE/ACTION

Page 8: Quick Wins
  - Quick wins table (numbered actions)
  - Closing callout (blue): next steps summary
```

### Sample HTML Snippet (Executive Summary Page)

```html
<div class="page">
<div class="content">
  <h2 class="section-title">Executive Summary</h2>
  <hr class="accent-rule">

  <div class="kpi-row">
    <div class="kpi-card">
      <div class="kpi-value">$52,400</div>
      <div class="kpi-label">Monthly Email Revenue</div>
    </div>
    <div class="kpi-card">
      <div class="kpi-value">22.4%</div>
      <div class="kpi-label">Open Rate</div>
    </div>
    <div class="kpi-card kpi-card--risk">
      <div class="kpi-value">1.8%</div>
      <div class="kpi-label">Click Rate (Below Benchmark)</div>
    </div>
    <div class="kpi-card kpi-card--risk">
      <div class="kpi-value">$80&ndash;120K</div>
      <div class="kpi-label">Revenue at Risk / Year</div>
    </div>
  </div>

  <div class="callout callout-blue">
    <strong>Key Finding:</strong> Email program generates $52K/month but leaves
    $80-120K on the table annually due to missing lifecycle flows and
    below-benchmark click rates.
  </div>

  <p class="body-text">
    The audit identified <strong>3 critical issues</strong> requiring immediate
    action, <strong>4 high-priority improvements</strong> for the next 30 days,
    and <strong>2 quick wins</strong> implementable this week.
  </p>
</div>
<div class="page-footer">Email Marketing Audit&ensp;|&ensp;Page 2</div>
</div>
```

---

## Example 2: E-commerce Quarterly Performance Report

### Prompt

> Build a quarterly performance report for an e-commerce brand. Include a KPI dashboard comparing Q4 vs Q3, channel performance breakdown table, product category analysis, and prioritized recommendations for Q1. 6 pages.

### Expected Document Structure

```
Page 1: Cover Page
Page 2: Executive Summary (KPI row: Revenue, AOV, Conversion Rate, Customer Count)
Page 3: Channel Performance (table with Q4 vs Q3 deltas, severity coloring)
Page 4: Product Category Analysis (table + callout for top/bottom performers)
Page 5: Recommendations (Priority 1 + Priority 2 rec-cards)
Page 6: Quick Wins + Next Steps
```

### Key Patterns Used

- **KPI cards with trend indicators**: Use subtitle text like "vs Q3: +12.4%"
- **Delta tables**: Show Q4 value, Q3 value, delta column with severity colors
- **Comparison callouts**: Green for improvements, amber for flat, red for declines

---

## Example 3: Minimal 3-Page Technical Brief

### Prompt

> Create a concise 3-page technical brief: cover page, executive summary with 3 KPIs, and a recommendations page with 4 items grouped by priority.

### Expected Document Structure

```
Page 1: Cover Page (dark)
Page 2: Executive Summary
  - 3-column KPI row
  - Key finding callout
  - 2 bullet points of supporting context
Page 3: Recommendations
  - Priority banner (high)
  - 2 rec-cards (ISSUE + ACTION only, minimal fields)
  - Priority banner (medium)
  - 2 rec-cards (ACTION only)
```

### Sample HTML Snippet (Recommendations Page)

```html
<div class="page">
<div class="content">
  <h2 class="section-title">Recommendations</h2>
  <hr class="accent-rule">

  <div class="priority-banner priority-high">PRIORITY 1 — HIGH (Next 30 Days)</div>

  <div class="rec-card rec-card--high">
    <div style="padding: 10px 14px 4px">
      <span class="rec-card-title">1.1 Implement Abandoned Cart Flow</span>
    </div>
    <div class="rec-field">
      <div class="rec-label">Issue</div>
      <div class="rec-value">No automated recovery for abandoned carts — estimated $3,200/month lost</div>
    </div>
    <div class="rec-field">
      <div class="rec-label">Action</div>
      <div class="rec-value"><ul>
        <li>Set up 3-email abandon cart sequence</li>
        <li>Include dynamic product blocks</li>
        <li>Add 10% discount in email 3</li>
      </ul></div>
    </div>
  </div>

  <div class="priority-banner priority-medium">PRIORITY 2 — MEDIUM (Next 60 Days)</div>

  <div class="rec-card rec-card--medium">
    <div style="padding: 10px 14px 4px">
      <span class="rec-card-title">2.1 Add Browse Abandonment Flow</span>
    </div>
    <div class="rec-field">
      <div class="rec-label">Action</div>
      <div class="rec-value"><ul>
        <li>Trigger on 2+ product views without add-to-cart</li>
        <li>Send within 4 hours of browse session</li>
      </ul></div>
    </div>
  </div>
</div>
<div class="page-footer">Technical Brief&ensp;|&ensp;Page 3</div>
</div>
```
