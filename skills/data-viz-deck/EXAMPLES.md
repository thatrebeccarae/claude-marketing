# Data Viz Deck — Examples

## Example 1: Email Marketing Audit Deck (PPTX)

### Prompt

> Create a presentation deck from this Klaviyo audit data. The account has 8 flows (3 missing essential ones), $140K flow revenue, $918K campaign revenue. Open rate is 22% (benchmark 25%), click rate 1.8% (benchmark 3%). Include title slide, KPI scorecard, flow performance chart, and recommendations.

### What the skill does

1. Parses the audit metrics into structured data
2. Creates a PPTX with python-pptx:
   - **Slide 1 (dark)**: Title slide with report name, date, brand lockup
   - **Slide 2 (light)**: Executive Summary with 4 KPI tiles ($1.06M total revenue, $140K flow revenue, 22% open rate in amber, 1.8% click rate in red)
   - **Slide 3 (light)**: Horizontal bar chart of flow revenue (sorted descending), insight panel noting 3 missing flows
   - **Slide 4 (light)**: Benchmark comparison table (flows x metrics, color-coded cells)
   - **Slide 5 (light)**: Recommendations table (Quick Wins / Strategic / Maintenance)
   - **Slide 6 (dark)**: Closing slide

### Key code pattern

```python
from pptx import Presentation
from pptx.util import Inches, Pt

prs = Presentation()
prs.slide_width = Inches(13.333)
prs.slide_height = Inches(7.5)

# KPI tiles
kpis = [
    {"label": "Total Revenue", "value": "$1,058,829", "color": ACCENT},
    {"label": "Flow Revenue", "value": "$140,149", "subtitle": "13.2% of total"},
    {"label": "Open Rate", "value": "22.4%", "color": AMBER, "subtitle": "Benchmark: 25%"},
    {"label": "Click Rate", "value": "1.8%", "color": RED, "subtitle": "Benchmark: 3%"},
]
make_kpi_slide(prs, "Executive Summary", kpis)
prs.save("email-audit-deck.pptx")
```

---

## Example 2: Interactive Campaign Dashboard (HTML)

### Prompt

> Build an HTML dashboard showing campaign performance across 4 channels (Email, SMS, Social, Paid) with KPI tiles for total revenue, average ROI, and conversion rate. Include a bar chart comparing channel revenue and a funnel chart showing the email conversion path.

### What the skill does

1. Structures the data as JSON for plotly.js
2. Generates a single-file HTML dashboard with:
   - Dark header with title and date
   - KPI row (3 tiles: $285K revenue in green, 4.2x ROI, 2.8% conversion)
   - 2-column grid layout:
     - Left: Channel revenue bar chart (plotly.js)
     - Right: Email funnel chart (Sent > Delivered > Opened > Clicked > Converted)
   - Insight boxes with left accent borders
   - Responsive layout (collapses to single column on mobile)
3. All CSS is inline, plotly.js loaded via CDN

### Key code pattern

```python
chart_configs = {
    "channel-revenue": bar_chart_config(
        categories=["Email", "SMS", "Social", "Paid"],
        values=[142000, 58000, 45000, 40000],
        title="Revenue by Channel"
    ),
    "email-funnel": funnel_chart_config(
        stages=["Sent", "Delivered", "Opened", "Clicked", "Converted"],
        values=[50000, 48500, 12125, 2182, 654],
        title="Email Conversion Funnel"
    )
}
```

---

## Example 3: Monthly Performance Report with Charts (Markdown + Images)

### Prompt

> Generate a visual markdown report with embedded charts showing month-over-month trends for revenue, subscriber growth, and engagement rates over the last 6 months. Include benchmark comparison bars.

### What the skill does

1. Creates matplotlib charts saved as PNG:
   - Line chart: Revenue trend (6 months) with benchmark reference line
   - Grouped bar chart: Subscriber growth (new vs churned) per month
   - Benchmark comparison: Current metrics vs industry averages
2. Generates a markdown report with `![]()` image embeds:

```markdown
# Monthly Performance Report — March 2026

## Revenue Trend
![Revenue Trend](./charts/revenue-trend.png)

**Key Insight:** Revenue grew 18% MoM, crossing the $50K benchmark in February.

## Subscriber Health
![Subscriber Growth](./charts/subscriber-growth.png)

**Key Insight:** Net subscriber growth turned positive in January after 3 months of decline.
```

### Key code pattern

```python
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

months = ["Oct", "Nov", "Dec", "Jan", "Feb", "Mar"]
revenue = [38200, 41500, 39800, 44100, 51200, 52400]

save_horizontal_bar(
    categories=months,
    values=revenue,
    title="Monthly Email Revenue",
    filepath="./charts/revenue-trend.png",
    value_format="${:,.0f}"
)
```
