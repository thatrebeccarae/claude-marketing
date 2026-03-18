# HTML Report Reference — CSS Framework & Component Patterns

Complete implementation reference. Copy the CSS framework into every new report, then compose pages from the component patterns below.

---

## HTML Boilerplate

Every report starts with this structure:

```html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Report Title</title>
<link rel="preconnect" href="https://api.fontshare.com">
<link href="https://api.fontshare.com/v2/css?f[]=switzer@300,400,500,600,700&display=swap" rel="stylesheet">
<style>
  /* === PASTE FULL CSS FRAMEWORK HERE === */
</style>
</head>
<body>

<!-- PAGES GO HERE -->

</body>
</html>
```

---

## CSS Framework

Paste this complete CSS block into every new report. It defines all tokens, the page system, and every component.

```css
/* ===================================================
   Consulting Report Design System
   Dark cover + Warm cream content pages
   Fonts: Switzer + Cartograph CF (swappable)
   =================================================== */

@font-face {
  font-family: 'Cartograph CF';
  src: local('Cartograph CF'), local('CartographCF-Regular');
  font-weight: 400;
  font-style: normal;
}
@font-face {
  font-family: 'Cartograph CF';
  src: local('Cartograph CF Bold'), local('CartographCF-Bold');
  font-weight: 700;
  font-style: normal;
}

/* -- Reset ----------------------------------------- */
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
html { -webkit-font-smoothing: antialiased; -moz-osx-font-smoothing: grayscale; }

/* -- Custom Properties ----------------------------- */
:root {
  --accent:        #3D7A5C;
  --accent-dim:    rgba(61, 122, 92, 0.08);
  --accent-dark:   #2E6B4A;
  --accent-light:  #6AB88A;
  --excellent:     #2e8b57;
  --warning:       #D97706;
  --critical:      #c0392b;
  --bg-page:       #FAF7F2;
  --bg-surface:    #F2EDE6;
  --bg-elevated:   #EBE5DD;
  --text-primary:  #0f0e0e;
  --text-body:     #57606a;
  --text-muted:    #8b949e;
  --border:        rgba(15, 14, 14, 0.1);
  --border-dim:    rgba(15, 14, 14, 0.06);
  --canvas:        #d1d5db;
  --tint-blue:     #eaf2ed;
  --tint-green:    #eaf5ef;
  --tint-red:      #fef2f2;
  --tint-amber:    #fffbeb;
  --dark-bg:       #141414;
  --dark-surface:  #1E1E1E;
  --dark-text:     #f0f3f6;
  --dark-muted:    #6e7681;
  --dark-secondary:#9ca3af;
  --dark-border:   rgba(255, 255, 255, 0.08);
}

/* -- Base ------------------------------------------ */
body {
  font-family: 'Switzer', system-ui, -apple-system, sans-serif;
  font-size: 10pt;
  line-height: 1.55;
  color: var(--text-body);
  background: var(--canvas);
}

/* -- Page Container -------------------------------- */
.page {
  width: 8.5in;
  min-height: 11in;
  margin: 32px auto;
  background: var(--bg-page);
  position: relative;
  box-shadow: 0 4px 32px rgba(0, 0, 0, 0.12);
  overflow: hidden;
}

.page-footer {
  position: absolute;
  bottom: 0; left: 0; right: 0;
  text-align: center;
  font-family: 'Switzer', system-ui, sans-serif;
  font-size: 7pt;
  color: var(--text-muted);
  padding: 10px 0.75in 14px;
  border-top: 1px solid var(--border);
  letter-spacing: 0.03em;
}

/* -- Print ----------------------------------------- */
@page { size: 8.5in 11in; margin: 0; }
@media print {
  * { print-color-adjust: exact; -webkit-print-color-adjust: exact; }
  body { background: white; margin: 0; }
  .page { margin: 0; box-shadow: none; page-break-after: always; page-break-inside: avoid; width: 8.5in; min-height: 11in; }
  .page:last-child { page-break-after: avoid; }
}

/* -- Cover Page ------------------------------------ */
.cover-page {
  background: var(--dark-bg);
  height: 11in;
  padding: 0 1in 1in;
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
  position: relative;
  overflow: hidden;
}
.cover-page::before {
  content: ''; position: absolute; top: 0; left: 0; right: 0; height: 2px;
  background: var(--accent);
  box-shadow: 0 0 40px rgba(61, 122, 92, 0.4), 0 0 120px rgba(61, 122, 92, 0.15);
}
.cover-page::after {
  content: ''; position: absolute; top: -20%; left: -20%; width: 140%; height: 60%;
  background: radial-gradient(ellipse at 30% 50%, rgba(61, 122, 92, 0.06) 0%, transparent 60%);
  pointer-events: none;
}
.cover-tag { font-family: 'Cartograph CF', monospace; font-size: 8pt; color: var(--accent); text-transform: uppercase; letter-spacing: 0.15em; margin-bottom: 12px; position: relative; z-index: 1; }
.cover-title { font-family: 'Switzer', sans-serif; font-size: 36pt; font-weight: 300; color: var(--dark-text); line-height: 1.1; letter-spacing: -0.03em; margin-bottom: 8px; position: relative; z-index: 1; }
.cover-subtitle { font-family: 'Switzer', sans-serif; font-size: 16pt; font-weight: 400; color: var(--dark-muted); margin-bottom: 48px; position: relative; z-index: 1; }
.cover-meta { font-family: 'Cartograph CF', monospace; font-size: 8.5pt; color: var(--dark-muted); line-height: 2; position: relative; z-index: 1; }
.cover-meta span { color: var(--dark-secondary); }
.cover-divider { width: 48px; height: 1px; background: var(--accent); margin: 32px 0 20px; opacity: 0.6; position: relative; z-index: 1; }

/* -- Content Pages --------------------------------- */
.content { padding: 0.6in 0.75in 0.7in; min-height: calc(11in - 36px); }

/* -- Section Titles -------------------------------- */
.section-title { font-family: 'Switzer', sans-serif; font-size: 18pt; font-weight: 400; color: var(--text-primary); letter-spacing: -0.02em; margin-bottom: 4px; }
.accent-rule { width: 40px; height: 2px; background: var(--accent); border: none; margin-bottom: 20px; }
.section-continued { font-size: 11pt; font-weight: 300; color: var(--text-muted); }
.subsection-title { font-family: 'Switzer', sans-serif; font-size: 12.5pt; font-weight: 600; color: var(--text-primary); margin-top: 20px; margin-bottom: 8px; }

/* -- Body Text ------------------------------------- */
p { margin-bottom: 6px; }
.body-text { font-size: 9.5pt; line-height: 1.6; color: var(--text-body); }
ul.bullet-list { list-style: none; padding-left: 0; margin: 6px 0 10px; }
ul.bullet-list li { padding-left: 16px; position: relative; font-size: 9pt; line-height: 1.6; margin-bottom: 4px; color: var(--text-body); }
ul.bullet-list li::before { content: ''; position: absolute; left: 4px; top: 7px; width: 4px; height: 4px; border-radius: 50%; background: var(--accent); }
ol.numbered-list { padding-left: 20px; margin: 6px 0 10px; }
ol.numbered-list li { font-size: 9pt; line-height: 1.6; margin-bottom: 4px; color: var(--text-body); }
ol.numbered-list li::marker { color: var(--accent-dark); font-family: 'Cartograph CF', monospace; font-size: 8.5pt; }

/* -- KPI Cards ------------------------------------- */
.kpi-row { display: grid; grid-template-columns: repeat(4, 1fr); gap: 10px; margin: 18px 0; }
.kpi-card { background: var(--bg-surface); border: 1px solid var(--border); border-radius: 10px; padding: 16px 12px; text-align: center; }
.kpi-value { font-family: 'Cartograph CF', monospace; font-size: 16pt; font-weight: 600; color: var(--text-primary); line-height: 1.2; letter-spacing: -0.02em; }
.kpi-label { font-family: 'Cartograph CF', monospace; font-size: 6.5pt; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.06em; line-height: 1.3; margin-top: 6px; }
.kpi-card--risk { background: var(--tint-red); border-color: rgba(192, 57, 43, 0.2); }

/* -- Tables ---------------------------------------- */
table { width: 100%; border-collapse: collapse; font-size: 8.5pt; margin: 10px 0; }
thead th { background: var(--accent); color: white; font-family: 'Cartograph CF', monospace; font-weight: 600; font-size: 7.5pt; text-transform: uppercase; letter-spacing: 0.05em; text-align: left; padding: 8px 10px; }
tbody td { padding: 6px 10px; border-bottom: 1px solid var(--border-dim); vertical-align: top; color: var(--text-body); }
tbody tr:nth-child(even) { background: var(--bg-surface); }
tbody tr:nth-child(odd) { background: var(--bg-page); }
tbody td:nth-child(n+2) { font-variant-numeric: tabular-nums; }
.severity-critical { color: var(--critical); font-weight: 700; }
.severity-warning { color: var(--warning); font-weight: 700; }
.severity-good { color: var(--excellent); font-weight: 700; }
.severity-mixed { color: #8B7355; font-weight: 600; }
.severity-below { color: var(--warning); font-weight: 600; }
.text-red { color: var(--critical); font-weight: 700; }

/* -- Callout Boxes --------------------------------- */
.callout { border-radius: 6px; padding: 14px 16px; margin: 12px 0; font-size: 9pt; line-height: 1.55; border: 1px solid var(--border); border-left: 3px solid; }
.callout-blue { background: var(--tint-blue); border-left-color: var(--accent); }
.callout-green { background: var(--tint-green); border-left-color: var(--excellent); }
.callout-red { background: var(--tint-red); border-left-color: var(--critical); }
.callout-amber { background: var(--tint-amber); border-left-color: var(--warning); }
.callout strong { color: var(--text-primary); }

/* -- Priority Banners ------------------------------ */
.priority-banner { font-family: 'Cartograph CF', monospace; font-weight: 600; font-size: 9pt; text-transform: uppercase; letter-spacing: 0.08em; padding: 10px 16px; border-radius: 6px; margin: 20px 0 12px; border: 1px solid; }
.priority-critical { color: var(--critical); background: rgba(220, 38, 38, 0.06); border-color: rgba(220, 38, 38, 0.35); }
.priority-high { color: var(--warning); background: rgba(230, 119, 0, 0.06); border-color: rgba(230, 119, 0, 0.4); }
.priority-medium { color: var(--accent-dark); background: rgba(61, 122, 92, 0.10); border-color: rgba(61, 122, 92, 0.35); }
.priority-low { color: var(--text-muted); background: rgba(139, 148, 158, 0.06); border-color: rgba(139, 148, 158, 0.25); }

/* -- Recommendation Cards -------------------------- */
.rec-card { background: var(--bg-page); border: 1px solid var(--border); border-radius: 8px; margin: 10px 0 16px; overflow: hidden; break-inside: avoid; }
.rec-card-title { font-family: 'Switzer', sans-serif; font-size: 10pt; font-weight: 500; color: var(--text-primary); margin-bottom: 4px; }
.rec-card > div:first-child { border-left: 3px solid var(--accent); background: var(--bg-surface); }
.rec-card--critical > div:first-child { border-left-color: var(--critical); }
.rec-card--high > div:first-child { border-left-color: var(--warning); }
.rec-card--medium > div:first-child { border-left-color: var(--accent); }
.rec-card--low > div:first-child { border-left-color: var(--text-muted); }
.rec-field { display: grid; grid-template-columns: 68px 1fr; border-bottom: 1px solid var(--border-dim); font-size: 8.5pt; }
.rec-field:last-child { border-bottom: none; }
.rec-label { font-family: 'Cartograph CF', monospace; font-weight: 600; color: var(--text-primary); padding: 6px 10px; font-size: 7.5pt; text-transform: uppercase; letter-spacing: 0.04em; }
.rec-value { padding: 6px 10px; line-height: 1.55; color: var(--text-body); }

/* -- Quick Wins ------------------------------------ */
.qw-num { text-align: center; font-family: 'Cartograph CF', monospace; font-weight: 600; color: var(--accent-dark); width: 40px; }

/* -- Utility --------------------------------------- */
.section-divider { border: none; border-top: 1px solid var(--border); margin: 20px 0; }
.mt-4 { margin-top: 4px; } .mt-8 { margin-top: 8px; } .mt-16 { margin-top: 16px; }
.mb-4 { margin-bottom: 4px; } .mb-8 { margin-bottom: 8px; } .mb-16 { margin-bottom: 16px; }
strong { font-weight: 600; color: var(--text-primary); }
.keep-together { break-inside: avoid; }
```

---

## HTML Patterns

### Cover Page

```html
<div class="page">
<div class="cover-page">
  <div class="cover-tag">Document Type Label</div>
  <h1 class="cover-title">Report Title</h1>
  <p class="cover-subtitle">Subtitle Description</p>
  <div class="cover-divider"></div>
  <div class="cover-meta">
    <p><span>Date</span> &mdash; March 18, 2026</p>
    <p><span>Account</span> &mdash; Company Name</p>
    <p><span>Period</span> &mdash; Jan 2025 &ndash; Jan 2026</p>
  </div>
</div>
</div>
```

### Content Page

```html
<div class="page">
<div class="content">
  <h2 class="section-title">Section Title</h2>
  <hr class="accent-rule">
  <!-- Components go here -->
</div>
<div class="page-footer">Report Title&ensp;|&ensp;Page 2</div>
</div>
```

### Section Continued

```html
<h2 class="section-title">2. Flow Audit <span class="section-continued">(continued)</span></h2>
<hr class="accent-rule">
```

### KPI Cards

```html
<div class="kpi-row">
  <div class="kpi-card">
    <div class="kpi-value">$52,400</div>
    <div class="kpi-label">Monthly Revenue</div>
  </div>
  <div class="kpi-card kpi-card--risk">
    <div class="kpi-value">$80&ndash;120K</div>
    <div class="kpi-label">Revenue at Risk</div>
  </div>
</div>
```

### Data Table

```html
<table>
  <thead>
    <tr>
      <th style="width:28%">Metric</th>
      <th style="width:10%">Value</th>
      <th>Assessment</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Open Rate</td>
      <td>22.4%</td>
      <td class="severity-good">GOOD</td>
    </tr>
    <tr>
      <td>Click Rate</td>
      <td>1.8%</td>
      <td class="severity-critical">CRITICAL</td>
    </tr>
  </tbody>
</table>
```

### Callout Box

```html
<div class="callout callout-blue">
  <strong>Key Finding:</strong> Summary insight text.
</div>
<div class="callout callout-red">
  <strong>PROBLEM:</strong> Critical issue description.
</div>
```

### Recommendation Card

```html
<div class="priority-banner priority-critical">PRIORITY 1 &mdash; CRITICAL</div>
<div class="rec-card rec-card--critical">
  <div style="padding: 10px 14px 4px">
    <span class="rec-card-title">1.1 Fix Welcome Flow Bounce Rate</span>
  </div>
  <div class="rec-field">
    <div class="rec-label">Issue</div>
    <div class="rec-value">12.4% bounce rate on first email</div>
  </div>
  <div class="rec-field">
    <div class="rec-label">Action</div>
    <div class="rec-value"><ul>
      <li>Add double opt-in confirmation</li>
      <li>Implement list hygiene automation</li>
    </ul></div>
  </div>
</div>
```

---

## Composition Tips

### Rec-Card Page Budgets

| Card Type | Approximate Height |
|-----------|-------------------|
| Full (4 fields, 3-4 action items) | ~180-220px |
| Standard (3 fields, 2-3 action items) | ~140-170px |
| Minimal (2 fields, 2-3 action items) | ~110-130px |

A page can hold: **3 full rec-cards** or **4-5 minimal rec-cards** (with priority banner).

### Table Row Limits

| Table Size | Font Size | Max Rows |
|------------|-----------|----------|
| Default | 8.5pt | 10-12 |
| Dense | 7.5pt | 14-16 |
| Very dense | 7pt | 18-20 |

### Severity Color Mapping

| Assessment | Table Class | Callout Class |
|-----------|-------------|---------------|
| Good | `.severity-good` | `.callout-green` |
| Warning | `.severity-warning` | `.callout-amber` |
| Critical | `.severity-critical` | `.callout-red` |
| Mixed | `.severity-mixed` | `.callout-blue` |
