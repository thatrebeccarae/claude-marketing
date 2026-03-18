Transform audit data, performance reports, and structured analyses into polished visual deliverables. Generates presentation decks (PPTX), interactive HTML dashboards, or styled markdown reports with charts. Includes a customizable design system with forest green accent and warm cream backgrounds. Use when the user has analysis data and needs a visual deliverable.


# Data Visualization & Deck Builder

Transform structured data and analysis into polished visual deliverables: presentation decks, interactive dashboards, and visual reports.

## When to Use This Skill

- User has completed an audit or analysis and wants a visual deliverable
- User says "make a deck," "create a presentation," "build a dashboard," "visualize this"
- User wants to turn a markdown report into client-ready slides
- User needs charts, tables, or visual summaries from performance data

## Output Formats

### 1. PPTX Deck (Primary)
Native PowerPoint with editable charts, styled tables, and professional layouts. Best for client handoffs and presentations.

**Requires:** python-pptx (installed), pandas (installed)

### 2. Interactive HTML Dashboard
Single-file HTML with plotly.js charts (loaded via CDN), filterable tables, and responsive layout. Best for sharing interactive reports.

**Requires:** jinja2 (installed), pandas (installed). Plotly.js loaded via CDN at runtime.

### 3. Visual Markdown Report
Enhanced markdown with embedded chart images (requires matplotlib: `pip install matplotlib`). Best for vault reports and documentation.

## Workflow

### Step 1: Identify the Data Source

Read the source file (audit markdown, CSV, JSON, or database query results). Parse the key metrics, tables, and findings into a pandas DataFrame or structured dict.

### Step 2: Select Chart Types

| Data Pattern | Chart Type | When to Use |
|-------------|------------|-------------|
| Categories with values | **Bar chart** (horizontal) | Revenue by category |
| Categories + benchmark | **Bar chart with reference line** | Performance vs benchmark |
| Parts of a whole | **Doughnut/Pie chart** | Revenue concentration, channel mix |
| Values over time | **Line chart** | Trend data, period-over-period |
| Two variables | **Scatter plot** | Correlation analysis |
| Performance scoring | **Heatmap table** | Color-coded metrics (green/amber/red) |
| Before/after or gaps | **Waterfall chart** | Revenue opportunity sizing |
| Ranked items | **Horizontal bar** | Top 10 sorted |
| Funnels | **Funnel chart** | Delivered > opened > clicked > converted |
| Status overview | **Scorecard/KPI tiles** | Executive summary metrics |

### Step 3: Apply the Design System

All deliverables use a configurable design system. Override the color tokens and font choices to match your brand.

#### Color Palette

```python
COLORS = {
    # Brand accent -- change to your brand color
    "accent":      "#3D7A5C",  # Forest green
    "accent_light":"#6AB88A",  # Light green

    # Chart series (ordered for visual distinction)
    "series": ["#3D7A5C", "#6AB88A", "#8B7EC8", "#D4845A", "#C9A84C", "#C75B6F", "#93C9A8", "#8B949E"],

    # Semantic
    "good":        "#2E8B57",  # Green -- above benchmark
    "warning":     "#D97706",  # Amber -- watch
    "critical":    "#C0392B",  # Red -- action needed
    "neutral":     "#8B949E",  # Slate -- no judgment


(Truncated. See full skill at github.com/thatrebeccarae/claude-marketing)
