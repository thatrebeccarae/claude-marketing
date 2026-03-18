# pro-report-builder


# Pro Report Builder

Polished consulting reports as standalone HTML. Export to PDF via Chrome headless.

## Quick Reference

| Task | Approach |
|------|----------|
| Create report from scratch | Read [REFERENCE.md](REFERENCE.md) for CSS + HTML patterns |
| Add a new component type | Compose from existing components in REFERENCE.md |
| Export to PDF | Chrome headless `--print-to-pdf` (see Export section) |
| Customize brand tokens | Edit CSS custom properties in `:root` block |

### When to Use This Skill vs pro-deck-builder

| | pro-report-builder | pro-deck-builder |
|---|---|---|
| **Format** | 8.5x11" portrait pages | 16:9 landscape slides |
| **Content flow** | Multi-page, flowing text | Single-slide compositions |
| **Export** | Chrome headless `--print-to-pdf` | Puppeteer |
| **Use for** | Audit reports, assessments, written deliverables | Presentation decks, pitch slides |


## Before You Start

### Step 1: Understand the Brief

Ask the user:

1. **What type of document?** Audit report, assessment, technical brief, case study?
2. **How many pages roughly?** Helps plan section flow and page distribution.
3. **What data do they have?** Raw numbers, API exports, spreadsheets? Pull exact values -- never estimate when actuals exist.
4. **Where should the file be saved?** Default: `./output/`

### Step 2: Plan the Document Structure

Every report follows this structure:

```
Cover Page --> Executive Summary --> Analysis Sections (3-6) --> Prioritized Recommendations --> Quick Wins --> Appendix
```

Each analysis section should occupy 1-2 pages. Recommendation cards are the most space-intensive component -- budget carefully.


## Design System

### Customizable Brand Identity

The included design system provides a professional default. All color tokens, typography, and spacing are defined as CSS custom properties in `:root`. **Override these to match your brand.**

### Color Tokens

```css
:root {
  /* Accent -- change this to your brand color */
  --accent:        #3D7A5C;
  --accent-dim:    rgba(61, 122, 92, 0.08);
  --accent-dark:   #2E6B4A;
  --accent-light:  #6AB88A;

  /* Severity */
  --excellent:     #2e8b57;
  --warning:       #D97706;
  --critical:      #c0392b;

  /* Light-mode backgrounds (warm cream) */
  --bg-page:       #FAF7F2;
  --bg-surface:    #F2EDE6;
  --bg-elevated:   #EBE5DD;

  /* Light-mode text */
  --text-primary:  #0f0e0e;
  --text-body:     #57606a;
  --text-muted:    #8b949e;

  /* Borders */
  --border:        rgba(15, 14, 14, 0.1);
  --border-dim:    rgba(15, 14, 14, 0.06);

  /* Callout tints */
  --tint-blue:     #eaf2ed;
  --tint-green:    #eaf5ef;
  --tint-red:      #fef2f2;
  --tint-amber:    #fffbeb;

  /* Dark mode (cover page only) */
  --dark-bg:       #141414;
  --dark-surface:  #1E1E1E;
  --dark-text:     #f0f3f6;
  --dark-muted:    #6e7681;
  --dark-secondary:#9ca3af;
  --dark-border:   rgba(255, 255, 255, 0.08);
}
```

**Color rules:**
- Warm cream (`#FAF7F2`) backgrounds on ALL content pages -- NOT white. This is a brand differentiator.
- Dark mode (`#141414`) is reserved for the cover page only.
- Accent color for accent rules, table headers, bullet markers, priority banner accents, rec-card left stripes. Used deliberately, never for decoration.
- Severity colors (green/amber/red) ONLY for performance indicators. Never decorative.
- Callout tints (blue/green/red/amber) for left-bordered callout boxes matching their severity.

### Typography

| Role | Font | Weight | Size | Tracking | Notes |
|------|------|--------|------|----------|-------|
| Cover title | Switzer | Light (300) | 36pt | -0.03em | Document name on dark cover. |
| Cover subtitle | Switzer | Regular (400) | 16pt | normal | Below cover title. Color: `--dark-muted`. |
| Cover tag | Cartograph CF | Regular (400) | 8pt | +0.15em | ALL CAPS. Color: `--accent`. Above title. |
| Section title | Switzer | Regular (400) | 18pt | -0.02em | Content page h2. Followed by accent rule. |
| Subsection title | Switzer | SemiBold (600) | 12.5pt | normal | Content page h3. |
| Body text | Switzer | Regular (400) | 9.5pt | normal | Paragraphs, descriptions. Line-height: 1.6. |
| Table header | Cartograph CF | SemiBold (600) | 7.5pt | +0.05em | ALL CAPS. White text on accent bg. |
| Table body | Switzer | Regular (400) | 8.5pt | normal | Alternating row backgrounds. |
| KPI value | Cartograph CF | SemiBold (600) | 16pt | -0.02em | KPI card numbers. |
| KPI label | Cartograph CF | Regular (400) | 6.5pt | +0.06em | ALL CAPS. Below KPI values. |
| Rec-card label | Cartograph CF | SemiBold (600) | 7.5pt | +0.04em | ALL CAPS. Field labels. |
| Priority banner | Cartograph CF | SemiBold (600) | 9pt | +0.08em | ALL CAPS. Priority tier labels. |
| Page footer | Switzer | Regular (400) | 7pt | +0.03em | Centered. Color: `--text-muted`. |

**Critical typography rules:**
1. **Cover title uses Light (300), NOT Bold.** Light at large sizes = confident, premium.
2. **Monospace font for ALL numeric/data content.** KPI values, table headers, rec-card labels, priority banners.
3. **Body text at 9.5pt with 1.6 line-height.** Reading-optimized document, not a slide.
4. **Table headers are ALL CAPS monospace on accent background.** Distinctive table style.

**Font defaults (swappable):**
- Switzer: loaded from Fontshare CDN (free). Fallback: `system-ui, sans-serif`
- Cartograph CF: commercial, loaded via `local()`. Fallback: `JetBrains Mono, monospace`

### Page Dimensions

```
Width:   8.5in
Height:  11in
Orientation: Portrait
```

### Spacing

| Zone | Value |
|------|-------|
| Content padding | `0.6in 0.75in 0.7in` |
| Cover page padding | `0 1in 1in` (bottom-aligned) |
| Page footer | Absolute positioned, `bottom: 0`, `padding: 10px 0.75in 14px` |
| Section title margin-bottom | `4px` (then accent rule adds `20px` below) |
| Subsection title margin | `20px top, 8px bottom` |


## Component Library

All components are documented with full HTML + CSS in [REFERENCE.md](REFERENCE.md). Here is what is available:

### Page Structure

| Component | Class | Use |
|-----------|-------|-----|
| Page Container | `.page` | 8.5x11" page with shadow. |
| Cover Page | `.cover-page` | Dark cover with bottom-aligned content. |
| Content Area | `.content` | Padded content region within a page. |
| Page Footer | `.page-footer` | Centered footer with doc name + page number. |
| Section Title | `.section-title` + `.accent-rule` | Section heading with accent underline. |
| Section Continued | `.section-continued` | "(continued)" tag for multi-page sections. |

### Data Display

| Component | Class | Use |
|-----------|-------|-----|
| KPI Row | `.kpi-row` / `.kpi-card` | 4-column grid of big-number cards. |
| KPI Card (Risk) | `.kpi-card--risk` | Red-tinted variant for risk/negative KPIs. |
| Data Table | `table` with severity classes | Striped rows, accent headers, severity colors. |

### Content Blocks

| Component | Class | Use |
|-----------|-------|-----|
| Callout Box | `.callout` + `.callout-{color}` | Left-bordered insight box (blue/green/red/amber). |
| Body Text | `.body-text` | Standard paragraph text. |
| Bullet List | `.bullet-list` | Accent-colored dot bullets. |
| Numbered List | `.numbered-list` | Mono-font accent markers. |

### Recommendations

| Component | Class | Use |
|-----------|-------|-----|
| Priority Banner | `.priority-banner` + level class | Tier label (CRITICAL/HIGH/MEDIUM/LOW). |
| Recommendation Card | `.rec-card` + level class | Multi-field card with left accent stripe. |
| Quick Wins Table | Table with `.qw-num` | Numbered action items table. |


## Document Compositions

### Mandatory Pages

Every report must include:

1. **Cover Page** (`.cover-page`) -- Dark background, document title, metadata (date, account, period)
2. **Executive Summary** -- KPI row + key findings callout + brief narrative
3. **Recommendations** -- Prioritized rec-cards grouped by priority tier
4. **Quick Wins** -- Short action table for immediate wins

### Content Page Types

| Type | When to Use | Key Components |
|------|-------------|----------------|
| Data Table + Narrative | Inventory, benchmarking | Table + `.body-text` + `.bullet-list` |
| Callout Stack | Deep-dive on specific items | Multiple `.callout` boxes (green/red/amber) |
| Table + Callout | Performance data with insight | Table + single callout summary |
| Rec-Card Stack | Prioritized recommendations | `.priority-banner` + `.rec-card` stack |
| Mixed Analysis | Multi-part section | Tables + callouts + bullets + subsections |


## Narrative Rules

1. **One section per page when possible.** If a section spans multiple pages, use "(continued)" on subsequent pages.
2. **Lead with the data.** Tables and KPI cards BEFORE the narrative explanation.
3. **Callout after evidence.** Every data table should be followed by a callout summarizing the key insight.
4. **Never estimate when actuals exist.** If the data has exact values, compute precise totals.
5. **Benchmark everything.** Always show industry benchmarks alongside metrics.
6. **Severity colors = signal.** Green/amber/red ONLY for performance indicators.
7. **Callout colors match severity.** `.callout-green` for strengths, `.callout-red` for problems, `.callout-amber` for warnings, `.callout-blue` for neutral insights.
8. **Accent rules under section titles.** Every `.section-title` is followed by `<hr class="accent-rule">`.
9. **Consistent rec-card fields.** Every recommendation card should have at minimum: title bar, ISSUE, ACTION fields.


## Page Overflow Prevention

Pages are fixed at 11in tall. Content that exceeds the page container overflows visibly in the PDF. **Every page must be budgeted before building.**

### Height Budget

| Zone | Height |
|------|--------|
| Content padding (top + bottom) | ~1.3in |
| Page footer | ~0.4in |
| **Usable content area** | **~9.3in** |

### Component Density Limits

| Component | Max items per page | Dense mode override |
|-----------|-------------------|---------------------|
| **Rec-cards (full fields)** | 3 cards | For 4+: drop optional fields |
| **Rec-cards (minimal)** | 4-5 cards | Reduce margin to `8px 0 12px` |
| **Data tables** | 10-12 rows | For 13+: reduce font to `7.5pt`, padding to `3px 8px` |
| **Callout boxes** | 3-4 per page | Reduce padding to `10px 14px` |
| **Bullet lists** | 6-8 items | Shorten descriptions |

### Page Break Strategy

1. **Test every page in the browser** before exporting to PDF
2. **Redistribute content** across pages when overflow occurs
3. **Each `<div class="page">` is one PDF page**
4. **Use `.keep-together`** on components that should not split across pages
5. **Update ALL downstream page numbers** when redistributing


## Anti-Patterns (Never Do)

1. **No white backgrounds.** Always `#FAF7F2` (warm cream) for content pages.
2. **No bold section titles.** Use Regular (400) for `.section-title`.
3. **No decorative accent bars** beyond the 40px accent rule under section titles.
4. **No emoji in reports.** Unless the user explicitly requests them.
5. **No dark-mode content pages.** Dark is only for the cover page.
6. **No walls of text.** Break long prose into bullet lists. Max 3 sentences per callout.
7. **No unformatted numbers.** Always use `$X,XXX` or `$XXXK` with tabular-nums.
8. **No inline styles when a class exists.** Use the component library.
9. **No monospace fonts in page footers.** Use body font for footers.
10. **No orphan rec-cards.** Priority tier banner + first card must be on same page.
11. **No missing accent rules.** Every `.section-title` must be followed by `<hr class="accent-rule">`.


## PDF Export

### Automated Export (Preferred)

Use Chrome headless for reliable 8.5x11" portrait PDF generation:

```bash
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  --headless \
  --disable-gpu \
  --print-to-pdf="/OUTPUT/PATH/report.pdf" \
  --no-pdf-header-footer \
  --print-to-pdf-no-header \
  "file:///PATH/TO/report.html"
```

### Manual Export (Fallback)

1. Open the HTML file in Chrome
2. `Cmd+P` --> Save as PDF
3. Set margins to "None"
4. Enable "Background graphics"
5. Paper size: Letter (8.5" x 11")

### Required Print CSS

Every report MUST include this `@page` rule and `@media print` block:

```css
@page { size: 8.5in 11in; margin: 0; }
@media print {
  * { print-color-adjust: exact; -webkit-print-color-adjust: exact; }
  body { background: white; margin: 0; }
  .page {
    margin: 0;
    box-shadow: none;
    page-break-after: always;
    page-break-inside: avoid;
    width: 8.5in;
    min-height: 11in;
  }
  .page:last-child { page-break-after: avoid; }
}
```


## QA Checklist

Before delivering, verify:

### Data Accuracy
- [ ] All numbers are accurate and internally consistent
- [ ] Percentages add up where they should
- [ ] Revenue figures match across exec summary KPIs, tables, and rec-card references

### Page Overflow (check EVERY page)
- [ ] No content overflows page boundaries
- [ ] Rec-card pages have max 3 full-field cards
- [ ] Data tables with 13+ rows use dense mode

### Visual Consistency
- [ ] Every content page has a `.page-footer` with correct page number
- [ ] Cover page has NO `.page-footer`
- [ ] Every `.section-title` is followed by `<hr class="accent-rule">`
- [ ] Multi-page sections use "(continued)"
- [ ] Callout colors match their severity
- [ ] Priority banners use correct level class

### PDF Export
- [ ] `@page` rule present with `size: 8.5in 11in`
- [ ] `print-color-adjust: exact` applied globally
- [ ] All background colors render in PDF

---

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
