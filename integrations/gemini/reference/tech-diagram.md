# tech-diagram


# Technical Diagram Generator

Generate technical architecture diagrams and system illustrations as standalone HTML files with embedded CSS + inline SVG. No external dependencies.

## Core Capabilities

- Pipeline flow diagrams (data pipelines, CI/CD, ETL)
- Layer/stack diagrams (tech stack, OSI model, infrastructure)
- Component diagrams (microservices, system architecture)
- Before/after split comparisons
- Timeline diagrams (roadmaps, migration phases)
- Metric callout rows (KPI summaries)

## Design System

### Color Tokens

```css
:root {
  /* Dark mode (default canvas) */
  --bg-deep: #0d1117;
  --bg-surface: #161b22;
  --bg-elevated: #21262d;
  --border-subtle: rgba(240, 246, 252, 0.1);
  --text-bright: #f0f6fc;
  --text-secondary: #8b949e;
  --text-muted: #6e7681;

  /* Accent palette */
  --accent-blue: #58a6ff;
  --accent-green: #3fb950;
  --accent-purple: #bc8cff;
  --accent-orange: #d29922;
  --accent-red: #f85149;
  --accent-cyan: #39d2c0;
  --accent-pink: #f778ba;

  /* Light mode (optional, for embedded diagrams) */
  --bg-light: #ffffff;
  --bg-light-surface: #f6f8fa;
  --text-light-primary: #1f2328;
  --text-light-secondary: #656d76;
}
```

### Color Rules

- Dark mode is default for all diagrams
- Each pipeline stage or layer gets a distinct accent color
- Use `--text-secondary` for labels and annotations
- Use `--border-subtle` for connecting lines and borders
- Semantic colors: green = healthy/success, red = error/alert, orange = warning

### Typography

| Role | Font | Weight | Size |
|------|------|--------|------|
| Diagram title | system-ui | 600 | 28-32px |
| Section/stage label | system-ui | 600 | 16-18px |
| Description text | system-ui | 400 | 13-14px |
| Annotation | monospace | 400 | 12px |
| Metric value | monospace | 700 | 36-48px |

### Canvas

```
Width:  1200px (default, responsive down to 800px)
Height: auto (content-driven)
Padding: 48px
```

## Component Library

### Pipeline Flow

Horizontal or vertical sequence of stages with connecting arrows. Each stage has an icon area, label, and description.

### Layer/Stack Diagram

Vertical stack of labeled layers with optional descriptions. Top = highest abstraction, bottom = lowest.

### Component Diagram

Grid or freeform layout of service boxes with connection lines. Each component shows name, tech, and status.

### Before/After Split

Side-by-side comparison with a vertical divider. Left = before state, right = after state.

### Timeline

Horizontal or vertical sequence of milestones with dates, descriptions, and status indicators.

### Metric Callout Row

Horizontal row of KPI cards with large numbers, labels, and optional trend indicators.

## Key Principles

1. **One concept per diagram.** If it needs two diagrams, make two files.
2. **Labels on everything.** Every box, arrow, and region should be labeled.
3. **Consistent spacing.** Use CSS grid or flexbox, not absolute positioning.
4. **No external deps.** Everything inline — CSS in `<style>`, icons as inline SVG.
5. **Print-friendly.** Include `@media print` with light background override.

## Anti-Patterns

- No raster images (PNG/JPG) — use inline SVG for all icons
- No external CSS/JS — everything embedded
- No gradients as primary fill — use flat colors with subtle borders
- No more than 8 items in a single row — wrap or use grid
- No decorative elements that do not convey information

## File Conventions

- **Filename:** `{project}-{diagram-type}.html` (e.g., `pipeline-architecture.html`)
- **Single file:** All CSS inline in `<style>`, all SVG inline
- **Responsive:** Works at 800-1400px width range

For complete HTML/CSS patterns and full examples, see [REFERENCE.md](REFERENCE.md).

---

# Tech Diagram — Reference

Complete HTML/CSS patterns for building technical diagrams.

## HTML Boilerplate

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Diagram Title</title>
  <style>
    /* Paste design tokens from SKILL.md :root block */
    /* Then add component styles below */
  </style>
</head>
<body>
  <div class="canvas">
    <h1 class="diagram-title">Diagram Title</h1>
    <!-- Components here -->
  </div>
</body>
</html>
```

## Base Styles

```css
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

body {
  background: var(--bg-deep);
  color: var(--text-bright);
  font-family: system-ui, -apple-system, sans-serif;
  line-height: 1.5;
}

.canvas {
  max-width: 1200px;
  margin: 0 auto;
  padding: 48px;
}

.diagram-title {
  font-size: 32px;
  font-weight: 600;
  margin-bottom: 8px;
}

.diagram-subtitle {
  font-size: 16px;
  color: var(--text-secondary);
  margin-bottom: 40px;
}
```

## Pipeline Flow

```css
.pipeline {
  display: flex;
  align-items: stretch;
  gap: 0;
}

.pipeline-stage {
  flex: 1;
  padding: 24px;
  background: var(--bg-surface);
  border: 1px solid var(--border-subtle);
  border-radius: 12px;
  position: relative;
}

.pipeline-stage + .pipeline-stage { margin-left: 32px; }

/* Arrow connector between stages */
.pipeline-stage + .pipeline-stage::before {
  content: "";
  position: absolute;
  left: -24px;
  top: 50%;
  transform: translateY(-50%);
  width: 16px;
  height: 2px;
  background: var(--text-muted);
}

.pipeline-stage + .pipeline-stage::after {
  content: "";
  position: absolute;
  left: -12px;
  top: 50%;
  transform: translateY(-50%) rotate(45deg);
  width: 8px;
  height: 8px;
  border-top: 2px solid var(--text-muted);
  border-right: 2px solid var(--text-muted);
}

.stage-icon {
  width: 40px;
  height: 40px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 16px;
}

.stage-label {
  font-size: 16px;
  font-weight: 600;
  margin-bottom: 8px;
}

.stage-desc {
  font-size: 13px;
  color: var(--text-secondary);
  line-height: 1.5;
}
```

```html
<div class="pipeline">
  <div class="pipeline-stage">
    <div class="stage-icon" style="background: rgba(88,166,255,0.15);">
      <svg width="20" height="20" fill="var(--accent-blue)"><!-- icon --></svg>
    </div>
    <div class="stage-label">Ingest</div>
    <div class="stage-desc">Pull data from APIs and webhooks into the staging layer.</div>
  </div>
  <div class="pipeline-stage">
    <div class="stage-icon" style="background: rgba(63,185,80,0.15);">
      <svg width="20" height="20" fill="var(--accent-green)"><!-- icon --></svg>
    </div>
    <div class="stage-label">Transform</div>
    <div class="stage-desc">Clean, normalize, and enrich raw records.</div>
  </div>
  <!-- more stages -->
</div>
```

## Layer/Stack Diagram

```css
.stack {
  display: flex;
  flex-direction: column;
  gap: 4px;
  max-width: 700px;
}

.stack-layer {
  display: flex;
  align-items: center;
  padding: 20px 28px;
  border-radius: 10px;
  border: 1px solid var(--border-subtle);
}

.layer-label {
  font-size: 15px;
  font-weight: 600;
  min-width: 160px;
}

.layer-desc {
  font-size: 13px;
  color: var(--text-secondary);
}

.layer-tag {
  margin-left: auto;
  font-family: monospace;
  font-size: 12px;
  padding: 2px 8px;
  border-radius: 4px;
  background: var(--bg-elevated);
  color: var(--text-muted);
}
```

## Component Diagram

```css
.components {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 16px;
}

.component-box {
  padding: 20px;
  background: var(--bg-surface);
  border: 1px solid var(--border-subtle);
  border-radius: 10px;
}

.component-name {
  font-size: 15px;
  font-weight: 600;
  margin-bottom: 4px;
}

.component-tech {
  font-family: monospace;
  font-size: 12px;
  color: var(--text-muted);
  margin-bottom: 12px;
}

.component-status {
  font-size: 12px;
  display: inline-flex;
  align-items: center;
  gap: 6px;
}

.status-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
}
```

## Metric Callout Row

```css
.metrics-row {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
  gap: 16px;
  margin: 32px 0;
}

.metric-card {
  padding: 24px;
  background: var(--bg-surface);
  border: 1px solid var(--border-subtle);
  border-radius: 12px;
  text-align: center;
}

.metric-value {
  font-family: monospace;
  font-size: 42px;
  font-weight: 700;
  line-height: 1.1;
  margin-bottom: 4px;
}

.metric-label {
  font-size: 13px;
  color: var(--text-secondary);
  text-transform: uppercase;
  letter-spacing: 0.08em;
}

.metric-trend {
  font-size: 13px;
  margin-top: 8px;
}

.trend-up { color: var(--accent-green); }
.trend-down { color: var(--accent-red); }
```

## Before/After Split

```css
.split {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 0;
  border: 1px solid var(--border-subtle);
  border-radius: 12px;
  overflow: hidden;
}

.split-side {
  padding: 32px;
}

.split-before {
  background: var(--bg-surface);
  border-right: 1px solid var(--border-subtle);
}

.split-after {
  background: var(--bg-elevated);
}

.split-label {
  font-size: 12px;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  color: var(--text-muted);
  margin-bottom: 16px;
}
```

## Timeline

```css
.timeline {
  position: relative;
  padding-left: 32px;
}

.timeline::before {
  content: "";
  position: absolute;
  left: 7px;
  top: 8px;
  bottom: 8px;
  width: 2px;
  background: var(--border-subtle);
}

.timeline-item {
  position: relative;
  padding-bottom: 32px;
}

.timeline-dot {
  position: absolute;
  left: -32px;
  top: 6px;
  width: 16px;
  height: 16px;
  border-radius: 50%;
  border: 2px solid;
  background: var(--bg-deep);
}

.timeline-date {
  font-family: monospace;
  font-size: 12px;
  color: var(--text-muted);
  margin-bottom: 4px;
}

.timeline-title {
  font-size: 16px;
  font-weight: 600;
  margin-bottom: 4px;
}

.timeline-desc {
  font-size: 13px;
  color: var(--text-secondary);
}
```

## Inline SVG Icon Patterns

Common icons as inline SVG (20x20):

```html
<!-- Database -->
<svg width="20" height="20" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.5">
  <ellipse cx="10" cy="5" rx="7" ry="3"/>
  <path d="M3 5v10c0 1.66 3.13 3 7 3s7-1.34 7-3V5"/>
  <path d="M3 10c0 1.66 3.13 3 7 3s7-1.34 7-3"/>
</svg>

<!-- Server -->
<svg width="20" height="20" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.5">
  <rect x="3" y="2" width="14" height="6" rx="1.5"/>
  <rect x="3" y="12" width="14" height="6" rx="1.5"/>
  <circle cx="6" cy="5" r="1" fill="currentColor"/>
  <circle cx="6" cy="15" r="1" fill="currentColor"/>
</svg>

<!-- Cloud -->
<svg width="20" height="20" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.5">
  <path d="M5.5 16A3.5 3.5 0 015 9.05 5 5 0 0115 9a3 3 0 01.5 5.95"/>
</svg>

<!-- Code/API -->
<svg width="20" height="20" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.5">
  <polyline points="7 6 3 10 7 14"/>
  <polyline points="13 6 17 10 13 14"/>
  <line x1="11" y1="4" x2="9" y2="16"/>
</svg>

<!-- Chart -->
<svg width="20" height="20" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.5">
  <rect x="3" y="10" width="3" height="7" rx="0.5"/>
  <rect x="8.5" y="6" width="3" height="11" rx="0.5"/>
  <rect x="14" y="3" width="3" height="14" rx="0.5"/>
</svg>
```

## Print Styles

```css
@media print {
  body { background: white; color: #1f2328; }
  .canvas { padding: 24px; }
  .pipeline-stage,
  .stack-layer,
  .component-box,
  .metric-card {
    background: #f6f8fa;
    border-color: #d0d7de;
    box-shadow: none;
  }
  * { print-color-adjust: exact; -webkit-print-color-adjust: exact; }
}
```
