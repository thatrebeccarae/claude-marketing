# Data Viz Deck — Technical Reference

## PPTX Generation with python-pptx

### Slide Dimensions & Setup

```python
from pptx import Presentation
from pptx.util import Inches, Pt, Emu
from pptx.dml.color import RGBColor
from pptx.enum.text import PP_ALIGN, MSO_ANCHOR
from pptx.enum.chart import XL_CHART_TYPE, XL_LEGEND_POSITION, XL_LABEL_POSITION
from pptx.enum.shapes import MSO_SHAPE
from pptx.chart.data import CategoryChartData, ChartData

prs = Presentation()
prs.slide_width = Inches(13.333)  # 16:9 widescreen
prs.slide_height = Inches(7.5)
SLIDE_LAYOUT = prs.slide_layouts[6]  # Blank layout
```

### Color Constants

```python
from pptx.dml.color import RGBColor

# Brand accent -- customize to match your brand
ACCENT       = RGBColor(0x3D, 0x7A, 0x5C)
ACCENT_LIGHT = RGBColor(0x6A, 0xB8, 0x8A)

# Semantic
GREEN        = RGBColor(0x2E, 0x8B, 0x57)
AMBER        = RGBColor(0xD9, 0x77, 0x06)
RED          = RGBColor(0xC0, 0x39, 0x2B)
SLATE        = RGBColor(0x8B, 0x94, 0x9E)

# Chart series colors (use in order)
SERIES_COLORS = [
    ACCENT, ACCENT_LIGHT,
    RGBColor(0x8B, 0x7E, 0xC8),  # Lavender
    RGBColor(0xD4, 0x84, 0x5A),  # Terracotta
    RGBColor(0xC9, 0xA8, 0x4C),  # Gold
    RGBColor(0xC7, 0x5B, 0x6F),  # Dusty Rose
    RGBColor(0x93, 0xC9, 0xA8),  # Mist
    SLATE,
]

# Dark mode (title slides, section dividers)
BG_DEEP      = RGBColor(0x14, 0x14, 0x14)
BG_SURFACE   = RGBColor(0x1E, 0x1E, 0x1E)
TEXT_BRIGHT  = RGBColor(0xF0, 0xF3, 0xF6)
TEXT_SEC_DK  = RGBColor(0x9C, 0xA3, 0xAF)
TEXT_MUTED_DK= RGBColor(0x6E, 0x76, 0x81)

# Light mode (content slides)
BG_LIGHT     = RGBColor(0xFA, 0xF7, 0xF2)  # Warm cream
BG_CARD      = RGBColor(0xF2, 0xED, 0xE6)
TEXT_PRIMARY  = RGBColor(0x0F, 0x0E, 0x0E)
TEXT_SECONDARY= RGBColor(0x57, 0x60, 0x6A)
TEXT_MUTED   = RGBColor(0x8B, 0x94, 0x9E)
```

### Helper Functions

```python
def add_textbox(slide, left, top, width, height, text, font_size=12,
                bold=False, color=TEXT_PRIMARY, alignment=PP_ALIGN.LEFT,
                font_name="Switzer"):
    txBox = slide.shapes.add_textbox(Inches(left), Inches(top), Inches(width), Inches(height))
    tf = txBox.text_frame
    tf.word_wrap = True
    p = tf.paragraphs[0]
    p.text = text
    p.font.size = Pt(font_size)
    p.font.bold = bold
    p.font.color.rgb = color
    p.font.name = font_name
    p.alignment = alignment
    return txBox


def add_shape_bg(slide, left, top, width, height, fill_color=BG_CARD, corner_radius=None):
    shape = slide.shapes.add_shape(
        MSO_SHAPE.ROUNDED_RECTANGLE, Inches(left), Inches(top), Inches(width), Inches(height)
    )
    shape.fill.solid()
    shape.fill.fore_color.rgb = fill_color
    shape.line.fill.background()
    if corner_radius:
        shape.adjustments[0] = corner_radius
    return shape


def set_cell_style(cell, text, font_size=11, bold=False, color=TEXT_PRIMARY,
                   alignment=PP_ALIGN.LEFT, font_name="Switzer", fill_color=None):
    cell.text = str(text)
    for paragraph in cell.text_frame.paragraphs:
        paragraph.font.size = Pt(font_size)
        paragraph.font.bold = bold
        paragraph.font.color.rgb = color
        paragraph.font.name = font_name
        paragraph.alignment = alignment
    cell.vertical_anchor = MSO_ANCHOR.MIDDLE
    if fill_color:
        cell.fill.solid()
        cell.fill.fore_color.rgb = fill_color


def benchmark_color(value, good_threshold, warning_threshold, higher_is_better=True):
    if higher_is_better:
        return GREEN if value >= good_threshold else (AMBER if value >= warning_threshold else RED)
    else:
        return GREEN if value <= good_threshold else (AMBER if value <= warning_threshold else RED)
```

### Slide Templates

#### Title Slide (Dark Mode)

```python
def make_title_slide(prs, title, subtitle, date_str):
    slide = prs.slides.add_slide(SLIDE_LAYOUT)
    bg = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, 0, 0, prs.slide_width, prs.slide_height)
    bg.fill.solid()
    bg.fill.fore_color.rgb = BG_DEEP
    bg.line.fill.background()
    add_textbox(slide, 0.8, 1.5, 11, 1.5, title, font_size=54, bold=False, color=TEXT_BRIGHT)
    add_textbox(slide, 0.8, 3.2, 11, 0.8, subtitle, font_size=20, color=TEXT_SEC_DK)
    add_textbox(slide, 0.8, 5.5, 5, 0.5, date_str, font_size=14, color=TEXT_MUTED_DK, font_name="Cartograph CF")
    return slide
```

#### KPI Scorecard Slide

```python
def make_kpi_slide(prs, title, kpis):
    """kpis: list of dicts with keys: label, value, subtitle, color (optional)"""
    slide = prs.slides.add_slide(SLIDE_LAYOUT)
    bg = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, 0, 0, prs.slide_width, prs.slide_height)
    bg.fill.solid()
    bg.fill.fore_color.rgb = BG_LIGHT
    bg.line.fill.background()
    add_textbox(slide, 0.8, 0.4, 11, 0.6, title, font_size=32, bold=False, color=TEXT_PRIMARY)
    n = len(kpis)
    tile_width = min(2.4, (11.5 / n) - 0.3)
    for i, kpi in enumerate(kpis):
        x = 0.8 + i * (tile_width + 0.3)
        add_shape_bg(slide, x, 1.4, tile_width, 2.2, fill_color=BG_CARD)
        add_textbox(slide, x + 0.2, 1.6, tile_width - 0.4, 1.0, kpi["value"],
                    font_size=44, bold=True, color=kpi.get("color", ACCENT),
                    alignment=PP_ALIGN.CENTER, font_name="Cartograph CF")
        add_textbox(slide, x + 0.2, 2.6, tile_width - 0.4, 0.4, kpi["label"],
                    font_size=12, alignment=PP_ALIGN.CENTER)
        if kpi.get("subtitle"):
            add_textbox(slide, x + 0.2, 3.0, tile_width - 0.4, 0.4, kpi["subtitle"],
                        font_size=10, color=TEXT_MUTED, alignment=PP_ALIGN.CENTER,
                        font_name="Cartograph CF")
    return slide
```

#### Bar Chart Slide

```python
def make_bar_chart_slide(prs, title, categories, values, value_label="Revenue",
                         insight_text="", recommendation="", chart_color=ACCENT):
    """Bar chart on left 60%, insight text on right 40%."""
    slide = prs.slides.add_slide(SLIDE_LAYOUT)
    bg = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, 0, 0, prs.slide_width, prs.slide_height)
    bg.fill.solid()
    bg.fill.fore_color.rgb = BG_LIGHT
    bg.line.fill.background()
    add_textbox(slide, 0.8, 0.4, 11, 0.6, title, font_size=24, bold=False, color=TEXT_PRIMARY)
    chart_data = CategoryChartData()
    chart_data.categories = categories
    chart_data.add_series(value_label, values)
    chart_frame = slide.shapes.add_chart(
        XL_CHART_TYPE.BAR_CLUSTERED, Inches(0.8), Inches(1.3), Inches(7.2), Inches(5.5), chart_data
    )
    chart = chart_frame.chart
    chart.has_legend = False
    plot = chart.plots[0]
    plot.gap_width = 80
    series = plot.series[0]
    series.format.fill.solid()
    series.format.fill.fore_color.rgb = chart_color
    series.has_data_labels = True
    data_labels = series.data_labels
    data_labels.font.size = Pt(10)
    data_labels.font.color.rgb = TEXT_PRIMARY
    data_labels.font.name = "Cartograph CF"
    data_labels.number_format = "$#,##0"
    if insight_text:
        add_shape_bg(slide, 8.3, 1.3, 4.5, 3.0, fill_color=BG_CARD)
        add_textbox(slide, 8.5, 1.5, 4.1, 0.4, "KEY INSIGHT", font_size=11, color=ACCENT, font_name="Cartograph CF")
        add_textbox(slide, 8.5, 2.0, 4.1, 2.0, insight_text, font_size=12, color=TEXT_PRIMARY)
    return slide
```

---

## Interactive HTML Dashboard (Jinja2 + Plotly.js)

### Plotly Config Patterns

```python
PLOTLY_ACCENT = "#3D7A5C"
PLOTLY_SERIES = ["#3D7A5C", "#6AB88A", "#8B7EC8", "#D4845A", "#C9A84C", "#C75B6F", "#93C9A8", "#8B949E"]
PLOTLY_FONT = "Switzer, Inter, system-ui, sans-serif"
PLOTLY_MONO = "Cartograph CF, Consolas, monospace"

def bar_chart_config(categories, values, title="", color=PLOTLY_ACCENT, orientation="h"):
    return {
        "data": [{
            "type": "bar",
            "x": values if orientation == "h" else categories,
            "y": categories if orientation == "h" else values,
            "orientation": orientation,
            "marker": {"color": color},
            "text": [f"${v:,.0f}" for v in values] if any(v > 100 for v in values) else values,
            "textposition": "outside",
            "textfont": {"family": PLOTLY_MONO},
        }],
        "layout": {
            "title": {"text": title, "font": {"size": 16, "family": PLOTLY_FONT}},
            "margin": {"l": 200, "t": 50, "r": 50, "b": 50},
            "plot_bgcolor": "rgba(0,0,0,0)",
            "paper_bgcolor": "rgba(0,0,0,0)",
        }
    }

def doughnut_chart_config(labels, values, title=""):
    return {
        "data": [{
            "type": "pie", "labels": labels, "values": values, "hole": 0.5,
            "marker": {"colors": PLOTLY_SERIES[:len(labels)]},
            "textinfo": "label+percent", "textposition": "outside",
        }],
        "layout": {
            "title": {"text": title, "font": {"size": 16, "family": PLOTLY_FONT}},
            "showlegend": True, "legend": {"orientation": "h", "y": -0.15},
            "paper_bgcolor": "rgba(0,0,0,0)",
        }
    }

def funnel_chart_config(stages, values, title=""):
    return {
        "data": [{
            "type": "funnel", "y": stages, "x": values,
            "textinfo": "value+percent initial",
            "marker": {"color": PLOTLY_SERIES[:len(stages)]},
        }],
        "layout": {
            "title": {"text": title, "font": {"size": 16, "family": PLOTLY_FONT}},
            "margin": {"l": 150, "t": 50},
            "paper_bgcolor": "rgba(0,0,0,0)", "plot_bgcolor": "rgba(0,0,0,0)",
        }
    }
```

---

## Matplotlib Charts (for Markdown/Image Output)

```python
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np

plt.rcParams.update({
    "figure.facecolor": "#FAF7F2",
    "axes.facecolor": "#F2EDE6",
    "axes.edgecolor": "#D6D0C8",
    "text.color": "#0F0E0E",
    "font.size": 11,
})

def save_horizontal_bar(categories, values, title, filepath, color="#3D7A5C",
                        value_format="${:,.0f}", figsize=(10, 6)):
    fig, ax = plt.subplots(figsize=figsize)
    y_pos = np.arange(len(categories))
    bars = ax.barh(y_pos, values, color=color, height=0.6)
    ax.set_yticks(y_pos)
    ax.set_yticklabels(categories)
    ax.invert_yaxis()
    ax.set_title(title, fontsize=16, fontweight="light", pad=15)
    for bar, val in zip(bars, values):
        ax.text(bar.get_width() + max(values) * 0.02, bar.get_y() + bar.get_height() / 2,
                value_format.format(val), va="center", fontsize=10, fontfamily="monospace")
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)
    ax.xaxis.set_visible(False)
    plt.tight_layout()
    fig.savefig(filepath, dpi=150, bbox_inches="tight")
    plt.close(fig)
```

---

## Data Parsing Utilities

```python
import pandas as pd
import re

def parse_md_table(md_text, table_index=0):
    tables = []
    lines = md_text.split("\\n")
    i = 0
    while i < len(lines):
        line = lines[i].strip()
        if line.startswith("|") and i + 1 < len(lines) and "---" in lines[i + 1]:
            headers = [h.strip() for h in line.split("|")[1:-1]]
            rows = []
            i += 2
            while i < len(lines) and lines[i].strip().startswith("|"):
                row = [c.strip() for c in lines[i].strip().split("|")[1:-1]]
                rows.append(row)
                i += 1
            tables.append(pd.DataFrame(rows, columns=headers))
        i += 1
    return tables[table_index] if table_index < len(tables) else tables

def parse_currency(val):
    if isinstance(val, (int, float)):
        return float(val)
    return float(re.sub(r"[,$]", "", str(val))) if val and val.strip() else 0.0

def parse_percentage(val):
    if isinstance(val, (int, float)):
        return float(val)
    return float(re.sub(r"%", "", str(val))) if val and val.strip() else 0.0
```

---

## Dependencies

### Already Installed
- `python-pptx` -- PPTX generation
- `pandas` -- Data processing
- `numpy` -- Numerical operations
- `jinja2` -- HTML templating
- `Pillow` -- Image handling

### Install If Needed
```bash
pip install matplotlib    # PNG chart generation
pip install plotly        # Local plotly (optional -- CDN works for HTML)
```

### python-pptx Chart Types
- `BAR_CLUSTERED`, `BAR_STACKED` -- Horizontal bars
- `COLUMN_CLUSTERED`, `COLUMN_STACKED` -- Vertical bars
- `LINE`, `LINE_MARKERS` -- Line charts
- `PIE`, `DOUGHNUT` -- Composition charts
- `AREA`, `AREA_STACKED` -- Area charts
- `XY_SCATTER` -- Scatter plots
