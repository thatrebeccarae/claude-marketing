Create polished HTML technical reports and multi-page documents for consulting deliverables. Includes a customizable design system with dark cover page, warm cream content pages (8.5x11 portrait), professional typography, and a curated component library (KPI cards, data tables with severity coloring, callout boxes, recommendation cards, priority banners). Trigger on report, audit report, technical document, written report, assessment, or multi-page document. Outputs standalone HTML files exported to PDF via Chrome headless.


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


(Truncated. See full skill at github.com/thatrebeccarae/claude-marketing)
