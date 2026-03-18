# pro-deck-builder


# Presentation Designer

VC-backed SaaS design quality for PowerPoint. Think Linear, Attio, Vercel, Raycast — not corporate clip art.

## Quick Reference

| Task | Approach |
|------|----------|
| Create from scratch | Read [REFERENCE.md](REFERENCE.md), use PptxGenJS |
| Edit existing / use template | Read [editing.md](editing.md) |
| Read/extract content | `python -m markitdown presentation.pptx` |
| Visual overview | `python scripts/thumbnail.py presentation.pptx` |


## Before You Start (Required Steps)

### Step 1: Ask the User

Before writing any code, ask:

1. **Light or dark mode?** Dark = premium/keynote feel. Light = reports/data-heavy decks.
2. **Palette preference?** Show the palette table below, or ask if they have brand colors.
3. **Logo?** Ask if they have a logo file to include (PNG/SVG path).

### Step 2: Discover Fonts

Check what's installed — premium fonts make a massive difference:

```bash
# macOS — list all installed font families
fc-list : family | sort -u

# Search for premium fonts first
fc-list : family | grep -iE "inter|dm.sans|poppins|avenir|futura|geist|sf.pro|sf.mono|jetbrains|fira.code|montserrat|playfair|source.sans"

# Check macOS Font Book directories directly
ls ~/Library/Fonts/ /Library/Fonts/ /System/Library/Fonts/Supplemental/ 2>/dev/null
```

**Priority order for font selection:**
1. **Inter** — the gold standard for SaaS UI (if installed, use it for everything)
2. **DM Sans** — geometric, startup-friendly
3. **Poppins** — rounded, approachable
4. **Avenir / Avenir Next** — ships with macOS, Apple-adjacent elegance
5. **Calibri** — safe fallback, always available

**For data/mono:** JetBrains Mono > Fira Code > SF Mono > Consolas


## Design Language: VC-Backed SaaS

### Aesthetic Principles

1. **Depth through layering** — Surfaces float above backgrounds. Cards and panels have subtle elevation via shadows and fine borders, not flat colored boxes.
2. **Bold typography, minimal decoration** — Let type hierarchy do the work. No accent lines, no decorative shapes, no clip art.
3. **Restrained color** — One accent color used sparingly (10%). Mostly neutrals. Color = signal, not decoration.
4. **Generous whitespace** — Empty space signals confidence. If a slide feels sparse, make the content bigger, don't add more.
5. **Every element earns its place** — Before adding anything: what does it communicate? If removing it changes nothing, remove it.

### Light vs Dark Mode

The user picks one mode for the entire deck. Never mix modes within a deck.


## Color System

### Dark Mode (Default — Premium/Keynote)

| Token | Value | Use |
|-------|-------|-----|
| `bg-primary` | `0A0A0C` | Slide backgrounds (deep space black) |
| `bg-surface` | `17181A` | Cards, panels (deep slate) |
| `bg-elevated` | `1E1F23` | Elevated surfaces, hover states |
| `bg-glass` | `FFFFFF` at 4% opacity | Translucent overlays |
| `text-primary` | `FFFFFF` | Headlines, key content |
| `text-secondary` | `A0A0A0` | Body text, descriptions |
| `text-muted` | `5A5A5E` | Captions, metadata, labels |
| `border-subtle` | `FFFFFF` at 8% opacity | Card borders |

### Light Mode (Reports/Data-Heavy)

| Token | Value | Use |
|-------|-------|-----|
| `bg-primary` | `FFFFFF` | Slide backgrounds |
| `bg-surface` | `F8F9FA` | Cards, panels |
| `bg-elevated` | `FFFFFF` | Elevated surfaces (use shadow) |
| `text-primary` | `111111` | Headlines, key content |
| `text-secondary` | `555555` | Body text, descriptions |
| `text-muted` | `999999` | Captions, metadata, labels |
| `border-subtle` | `E8E8E8` | Card borders |


## Palette System

Each palette defines one accent color (used at 10%) plus semantic status colors. The accent is the personality — everything else is neutral.

### Built-In Palettes

| Name | Accent | Hex | Best For |
|------|--------|-----|----------|
| **Electric Blue** | Intense azure | `0055FF` | SaaS, tech, product |
| **Neon Lime** | Acid green | `39FF14` | Dev tools, performance |
| **Hot Coral** | Warm energy | `FF6B6B` | Marketing, creative |
| **Indigo** | Deep purple | `6366F1` | Startups, AI/ML |
| **Teal Trust** | Cool confidence | `0D9488` | Healthcare, finance |
| **Amber Signal** | Warm authority | `F59E0B` | Consulting, strategy |
| **Rose** | Refined pink | `F43F5E` | Design, brand, luxury |
| **Emerald** | Growth green | `10B981` | Sustainability, success |
| **Cyan Edge** | Sharp blue-green | `06B6D4` | Data, analytics |
| **Violet** | Creative depth | `8B5CF6` | Education, innovation |
| **Slate** | No accent | `64748B` | Minimal, understated |
| **Gold Standard** | Financial premium | `D4AF37` | Investor, board decks |

### Custom Palette (User Brand Colors)

If the user provides brand colors, build a custom palette:

```javascript
const palette = {
  accent: "0055FF",      // primary brand color
  accentMuted: "0055FF" + " at 15% opacity", // for tinted backgrounds
  positive: "10B981",    // good, up, success
  warning: "F59E0B",     // attention, caution
  critical: "EF4444",    // bad, down, error
};
```

### Color Application: 85/10/5 Rule

- **85%** — Backgrounds + neutral text (bg + text tokens from mode)
- **10%** — Accent (key numbers, chart primary, CTAs, active states)
- **5%** — Semantic status (positive/warning/critical in KPIs and data)


## Typography

### Font Priority

Run font discovery (Step 2 above), then pick:

| Priority | Header | Body | Data/Mono | Vibe |
|----------|--------|------|-----------|------|
| 1st | Inter 700 | Inter 400 | JetBrains Mono | Linear/Vercel |
| 2nd | DM Sans 700 | DM Sans 400 | Fira Code | Geometric startup |
| 3rd | Avenir Next Bold | Avenir 400 | SF Mono | Apple-adjacent |
| 4th | Poppins 700 | Poppins 400 | JetBrains Mono | Friendly modern |
| Safe | Calibri Bold | Calibri | Consolas | Always available |

For editorial/financial decks:

| Header | Body | Vibe |
|--------|------|------|
| DM Serif Display | DM Sans | Sophisticated editorial |
| Playfair Display | Source Sans Pro | Luxury, financial |
| Georgia | Calibri | Classic corporate |

### Size Scale

| Role | Size | Weight | Use |
|------|------|--------|-----|
| Hero title | 54-72pt | Bold (700) | Title slide only |
| Slide title | 32-40pt | Bold (700) | Every content slide |
| Section header | 20-24pt | Semibold (600) | Within-slide sections |
| Body text | 14-16pt | Regular (400) | Paragraphs, bullets |
| Captions/meta | 10-12pt | Regular (400) | Footnotes, sources |
| Big KPI number | 48-72pt | Bold (700) | Dashboard callouts |
| KPI label | 9-10pt | Semibold, ALL CAPS, +tracking | Below KPI numbers |
| Data/numbers | 11-14pt | Mono regular | Tables, data labels |

### Typography Rules
- **Left-align** body text and lists — center ONLY titles and KPI values
- **Max 2 font families** per deck (+1 mono for data)
- **ALL CAPS + charSpacing** only for small labels (KPI labels, category tags)
- **Line height**: 1.3x for body, 1.1x for titles
- **Never underline** for emphasis — use bold or accent color

### Text Fitting (Prevents Overflow)

Big numbers and titles WILL overflow if you use a fixed font size without checking content length. Use these rules:

**Big KPI Numbers — scale font to character count:**

| Characters | Example | Max Font Size (card) | Max Font Size (standalone) |
|------------|---------|---------------------|--------------------------|
| 1–4 | `$4.2M` | 48pt | 72pt |
| 5–7 | `$5,307K` | 36pt | 54pt |
| 8–10 | `$5,307,540` | 28pt | 44pt |
| 11+ | `$12,345,678` | 22pt | 36pt |

**Rule: prefer abbreviated numbers.** `$5.3M` > `$5,307,540`. Only use full numbers in tables or footnotes where precision matters.

**Slide Titles — max characters before wrapping:**

| Font Size | Max Chars (~9" wide) | If Longer |
|-----------|---------------------|-----------|
| 54pt | ~30 | Reduce to 44pt or rewrite shorter |
| 44pt | ~38 | Reduce to 36pt or rewrite shorter |
| 36pt | ~46 | Reduce to 32pt or rewrite shorter |
| 32pt | ~52 | Use subtitle for overflow |

**Rule: count characters before setting fontSize.** Never let content slide titles wrap to 2 lines. Section dividers can wrap.

**Body Text in Narrow Containers (Insight Panels, Sidebars):**

Text overflow in narrow panels (< 4" wide) is a common problem. PptxGenJS does not auto-shrink text. Apply these rules:

| Container Width | Max fontSize | Max chars per line (~) | Max lines at 1.25x spacing |
|----------------|-------------|----------------------|---------------------------|
| 4.0"+ | 14pt | ~55 | Height ÷ 0.22" |
| 3.0-3.9" | 11pt | ~45 | Height ÷ 0.18" |
| 2.0-2.9" | 10pt | ~35 | Height ÷ 0.16" |
| < 2.0" | 9pt | ~25 | Height ÷ 0.15" |

**Rule: estimate line count before adding text.** Count characters in your text, divide by max chars per line to get line count, then verify it fits in the container height. If it doesn't fit: (1) reduce fontSize, (2) shorten the text, or (3) increase the container. Never let text silently overflow — it gets clipped or overlaps adjacent elements.

```javascript
// ✅ CORRECT: 2.8" panel → max 10pt, ~35 chars/line
// "Welcome series dominates at 62%..." = 90 chars ≈ 3 lines
// Container h: 1.6" → fits ~10 lines at 10pt. Safe.
s.addText("Short, edited copy.", {
  x: 6.55, y: 1.45, w: 2.7, h: 1.6,
  fontSize: 10, fontFace: theme.font.body,
});

// ❌ WRONG: 2.8" panel with 14pt font and 200+ char paragraph
s.addText("Very long paragraph that will overflow...", {
  x: 6.55, y: 1.45, w: 2.8, h: 1.6,
  fontSize: 14, fontFace: theme.font.body,  // too large for narrow panel
});
```

### Chart Number Formatting

Always format chart numbers for readability — raw numbers like "1000000" are never acceptable on axes OR data labels.

**CRITICAL: `valAxisLabelFormatCode` only formats the AXIS. Data labels from `showValue: true` are formatted separately via `dataLabelFormatCode`.** If you set `valAxisLabelFormatCode` but not `dataLabelFormatCode`, data labels will show raw unformatted numbers like "2888000". `numFmt` is NOT a valid PptxGenJS property — always use `dataLabelFormatCode`.

**Preferred approach — OOXML conditional format with raw values:**
Use raw (unscaled) values and let OOXML conditional number formatting handle the display. This is the most reliable approach and handles mixed-magnitude data (e.g., a chart with both $2.9M and $3.6K values).

```javascript
// ✅ BEST: Raw values + OOXML conditional format
// Under 1K: whole number ($500)
// 1K-999K: X.XXK ($540.18K, $57.72K)
// 1M+: X.XM ($2.9M)
const currFmt = '[>=1000000]"$"#,##0.0,,"M";[>=1000]"$"#,##0.00,"K";"$"#,##0';

values: [2888000, 717734, 425467, 3655],  // raw dollar values
dataLabelFormatCode: currFmt,              // conditional brackets OK here
valAxisLabelFormatCode: '"$"#,##0.0,,"M"', // simple format only (no brackets)
```

```javascript
// ✅ ALSO OK: Pre-scale when all values are same magnitude
values: [2888, 718, 425],  // raw values divided by 1000
dataLabelFormatCode: '"$"#,##0"K"',
valAxisLabelFormatCode: '"$"#,##0"K"',
```

```javascript
// ❌ WRONG: Raw values with axis-only format
values: [2888000, 718000, 425000],
valAxisLabelFormatCode: "$#,##0,K",  // axis may format but data labels show 2888000
// ❌ WRONG: numFmt (not a valid PptxGenJS property)
```

**OOXML conditional format reference (use with RAW values):**

| Data Range | Format Code | Renders As |
|------------|-------------|------------|
| Currency (auto-scale) | `'[>=1000000]"$"#,##0.0,,"M";[>=1000]"$"#,##0.00,"K";"$"#,##0'` | $2.9M, $540.18K, $500 |
| Plain number (auto-scale) | `'[>=1000000]#,##0.0,,"M";[>=1000]#,##0.00,"K";#,##0'` | 2.9M, 540.18K, 500 |
| Percentage | `'0%'` | 50%, 85% |

**Format code syntax:** OOXML supports up to 2 conditions in brackets + a default: `[condition1]format1;[condition2]format2;defaultFormat`. Each trailing `,` divides by 1,000 (so `,,` divides by 1M).

**IMPORTANT: `valAxisLabelFormatCode` does NOT support OOXML conditional brackets `[>=1000]`.** Use a simple format for the axis based on the data range:

| Axis Range | `valAxisLabelFormatCode` | Renders As |
|------------|----------------|------------|
| Up to ~999K | `'"$"#,##0,"K"'` | $0K, $100K, $500K |
| Up to ~10M+ | `'"$"#,##0.0,,"M"'` | $0.0M, $0.5M, $1.0M |
| Up to ~999 | `'"$"#,##0'` | $0, $100, $500 |

Use the conditional `currFmt` for `dataLabelFormatCode` (which supports brackets), but a simple format for `valAxisLabelFormatCode`. Always set `showValue: true` with `dataLabelPosition: "outEnd"` on bar charts so readers can see exact values without tracing to the axis.


## Spacing

| Token | Value | Use |
|-------|-------|-----|
| `xs` | 0.125" | Within grouped elements |
| `sm` | 0.25" | Label to value, icon to text |
| `md` | 0.375" | Between sections within a card |
| `lg` | 0.5" | Between cards, major sections |
| `xl` | 0.75" | Between content zones |

### Layout Grid (10" × 5.625")

```
Margins:       0.5" from all edges
Content area:  9.0" wide × ~4.5" tall
Title zone:    y = 0.3"
Content zone:  y = 1.0" to y = 5.0"
Footer zone:   y = 5.2"
Card gap:      0.25" - 0.3"
```


## Logo Placement

### Finding Logos

```bash
find ~/Desktop ~/Downloads ~/Documents -maxdepth 3 -iname "*logo*" \( -name "*.png" -o -name "*.svg" -o -name "*.jpg" \) 2>/dev/null
```

### Placement Patterns

| Slide Type | Position | Size | Notes |
|------------|----------|------|-------|
| Title slide (top-left) | `x:0.5, y:0.4` | `w:1.5, h:0.5` | Subtle brand mark |
| Title slide (centered) | `x:4.0, y:0.8` | `w:2.0, h:0.7` | Above title text |
| Content slides | `x:8.5, y:0.2` | `w:1.0, h:0.35` | Top-right corner, every slide |
| Closing slide | `x:3.5, y:1.5` | `w:3.0, h:1.0` | Centered, hero size |

### Logo Rules
- Always use `sizing: { type: "contain", w, h }` to preserve aspect ratio
- **Content slides**: max 1" wide, don't compete with content
- **Title/closing**: up to 3" wide for brand moment
- **Dark mode**: use white/light logo variant if available (ask user)
- **Slide master**: if logo goes on every slide, add it to a master definition


## Icons

### Pipeline: react-icons → sharp → PNG → PptxGenJS

```bash
npm install -g react-icons react react-dom sharp
```

**Prefer Lucide (`react-icons/lu`) or Feather (`react-icons/fi`)** — they match the Linear/Vercel icon language.

| Package | Import | Style |
|---------|--------|-------|
| `react-icons/lu` | Lucide | Linear-style, clean |
| `react-icons/fi` | Feather | Thin, modern |
| `react-icons/hi2` | Heroicons v2 | Apple-ish |
| `react-icons/tb` | Tabler | Consistent strokes |

### Icon Sizes

| Context | Display Size | Color |
|---------|-------------|-------|
| KPI card icon | 0.35" × 0.35" | Accent on dark, muted on light |
| Feature row icon | 0.4" × 0.4" | White inside accent circle |
| Section divider | 0.5" × 0.5" | Accent color |
| Inline bullet | 0.25" × 0.25" | text-secondary |


## Reusable Components

### Bottom Callout Box (Standardized)

Many slides end with a highlighted callout box (recommendation, key insight, total impact). **These must be visually identical across all slides:**

| Property | Value | Notes |
|----------|-------|-------|
| Box height | 0.6" | Always 0.6" — never 0.5", 0.7", 0.9" |
| Text height | 0.5" | Fits inside 0.6" box with padding |
| Font size | 11pt | Always 11pt bold — never 12pt or 13pt |
| Font | `theme.font.body` | Bold, left-aligned, valign: "middle" |
| Box x/w | `x: 0.5, w: 9.0` | Full content width |
| Text x/w | `x: 0.7, w: 8.6` | Inset 0.2" from box edges |
| Text y offset | box y + 0.05" | Centers text vertically in box |
| Corner radius | 0.06" | Consistent across all callouts |

```javascript
// Standard bottom callout — copy this pattern exactly
s.addShape(pres.shapes.RECTANGLE, {
  x: 0.5, y: calloutY, w: 9.0, h: 0.6,
  fill: { color: "DCFCE7" },  // or theme.accentMuted, "FEF3C7", etc.
  line: { color: theme.status.positive, width: 0.75 },
  rectRadius: 0.06,
});

s.addText("Callout text here.", {
  x: 0.7, y: calloutY + 0.05, w: 8.6, h: 0.5,
  fontSize: 11, fontFace: theme.font.body, bold: true,
  color: "166534", align: "left", valign: "middle",
});
```

### Table + Callout Layout (Prevents Overlap)

**Always calculate the table bottom position before placing a callout below it.** PptxGenJS tables don't auto-report their height, so you must compute it:

```
tableBottom = tableY + (rowCount × rowH)
calloutY = tableBottom + 0.15"  // minimum 0.15" gap
```

**Verify calloutY + 0.6" (callout height) < 5.2" (footer zone).** If it doesn't fit, reduce `rowH` or table font sizes — never let the callout overlap the footer.

| Rows (incl header) | rowH: 0.32" | rowH: 0.36" | rowH: 0.42" | rowH: 0.48" | rowH: 0.55" |
|---------------------|-------------|-------------|-------------|-------------|-------------|
| 6 rows | 1.92" | 2.16" | 2.52" | 2.88" | 3.30" |
| 7 rows | 2.24" | 2.52" | 2.94" | 3.36" | 3.85" |
| 8 rows | 2.56" | 2.88" | 3.36" | 3.84" | 4.40" |
| 11 rows | 3.52" | 3.96" | 4.62" | — | — |

With table starting at y: 1.0" and callout needing 0.75" (0.15" gap + 0.6" box), the table height limit is **3.45"** to stay above footer. Choose `rowH` accordingly.

### Cross-Slide Consistency Rules

Repeated elements MUST use identical dimensions across all slides:

1. **Bottom callout boxes** — same h, fontSize, padding on every slide (see standard above)
2. **Chart font sizes** — if multiple slides have bar/line charts, use identical `dataLabelFontSize`, `catAxisLabelFontSize`, and `valAxisLabelFontSize` across all of them
3. **Table styling** — header row style (`hdr()`) and cell style (`cell()`) should be defined once as helpers and reused
4. **Card dimensions** — if using stat cards on multiple slides, keep card width/height/corner radius consistent
5. **Section badge positions** — impact badges (e.g., "$400K-$800K") should use the same x, y, w, h, fontSize

**Rule: define reusable constants at the top of the script** for any dimension that appears on more than one slide.


## Slide Compositions

### Vary Layouts — The #1 Rule

Never repeat the same layout more than twice consecutively. Rotate through:

| Type | When | Elements |
|------|------|----------|
| **Title Slide** | Opening/closing | Hero text, subtitle, logo, date |
| **KPI Dashboard** | Executive summary | 3-5 cards, big numbers |
| **Chart + Insight** | Data with context | 60/40 split |
| **Full-Width Chart** | Chart IS the story | Full span, callout overlay |
| **Icon Feature Grid** | Features, pillars | 3-4 icon+text rows |
| **Data Table** | Financials, comparisons | Styled rows, mono numbers |
| **Section Divider** | Between sections | Bold title on dark/accent bg |
| **Quote** | Testimonials | Large italic, attribution |
| **Big Number** | Single key stat | Huge centered metric |
| **Comparison** | Before/after, vs. | Side-by-side columns |
| **Image + Text** | Products, case studies | Half-bleed image |
| **Closing** | End | Logo, CTA, contact |


## Anti-Patterns (Never Do These)

1. **NEVER add horizontal accent lines/bars under titles, subtitles, or headings** — This is the #1 AI tell. No thin rectangles (h: 0.03-0.05) placed under text as decorative separators. Not on title slides, not on section dividers, not on closing slides, not anywhere. If you feel a slide needs visual separation, use whitespace or a tinted panel instead.
2. **No gradient fills on shapes** — use solid colors + subtle borders
3. **No heavy shadows** — max opacity 0.1, blur 6
4. **Don't repeat layouts** on consecutive slides
5. **Don't center body text** — left-align everything except titles/KPIs
6. **No more than 2 fonts** (+1 mono)
7. **No walls of text** — max 6 lines body per slide
8. **No decorative shapes** — no random circles, triangles, swooshes
9. **No clip art** — use Lucide/Feather icons
10. **No colored card backgrounds** — cards = `bg-surface` + subtle border
11. **No unicode bullets** — use `bullet: true`
12. **No mixing light/dark** within a deck
13. **No unformatted chart data labels** — if you use `showValue: true`, you MUST also set `dataLabelFormatCode`. `valAxisLabelFormatCode` alone does NOT format data labels. Use OOXML conditional formats with raw values for best results.
14. **No long text in narrow panels without size checks** — before adding body text to any container < 4" wide, estimate line count (chars ÷ chars-per-line) and verify it fits the container height. Reduce font size or shorten text if it won't fit.
15. **No inconsistent callout boxes** — all full-width bottom callout boxes must use identical height (0.6"), text fontSize (11pt), and padding across every slide. Define the callout pattern once and copy it exactly.
16. **No callout-over-table overlap** — always calculate `tableBottom = tableY + (rows × rowH)` and place the callout at `tableBottom + 0.15"` minimum. Never hardcode callout y-positions without verifying they clear the table.
17. **No inconsistent chart font sizes** — if multiple slides contain charts, use identical `dataLabelFontSize`, `catAxisLabelFontSize`, and `valAxisLabelFontSize` values. Define these as constants and reuse them.


## QA (Required)

**Assume there are problems. First render is never correct.**

### Content Check
```bash
python -m markitdown output.pptx
python -m markitdown output.pptx | grep -iE "xxxx|lorem|ipsum|placeholder|click to"
```

### Visual QA (Use Subagents)
```bash
python scripts/office/soffice.py --headless --convert-to pdf output.pptx
pdftoppm -jpeg -r 150 output.pdf slide
```

Subagent prompt:
```
Inspect these slides. Assume issues exist — find them.
Look for:
- TEXT OVERFLOW: Numbers or titles that wrap to a second line inside their container. Also check body text in narrow panels (<4" wide) — long paragraphs at font sizes >11pt will overflow.
- ACCENT LINES: Any thin horizontal bars/lines under titles or headings (must be removed)
- CHART DATA LABELS: Raw unformatted numbers on data labels (e.g., "2888000" instead of "$2,889K"). This is the #1 chart bug — valAxisLabelFormatCode does NOT format data labels.
- CHART AXES: Raw unformatted numbers on axes (should be $500K not 500000)
- Overlapping elements, cramped spacing (<0.3"), insufficient margins (<0.5")
- Low contrast, text-only slides, repeated layouts, placeholder text
- Mode inconsistency (light elements on dark or vice versa)
- Big numbers that should be abbreviated ($5.3M not $5,307,540)
- CALLOUT INCONSISTENCY: Bottom callout boxes with different heights, font sizes, or padding across slides (all must be h:0.6", fontSize:11)
- TABLE-CALLOUT OVERLAP: Callout boxes overlapping tables — calculate tableY + (rows × rowH) and verify callout clears it
- CHART FONT INCONSISTENCY: Different dataLabelFontSize, catAxisLabelFontSize, or valAxisLabelFontSize between charts on different slides
```

Fix → re-render → inspect → repeat until clean. **Complete at least one fix cycle.**


## Dependencies

```bash
npm install -g pptxgenjs                          # Creation
npm install -g react-icons react react-dom sharp  # Icons
pip install "markitdown[pptx]" Pillow             # Reading + QA
# Also: LibreOffice (soffice) + Poppler (pdftoppm) for visual QA
```

## Implementation

Read [REFERENCE.md](REFERENCE.md) for PptxGenJS API patterns and complete slide composition code for both light and dark modes.

## Brand Context (Optional)

If `brand-profile.json` exists in the working directory, read it before building decks. Override the default RRBC palette with the brand's colors (primary, secondary, background), use brand fonts when available (fall back to system fonts), and include the brand name on title slides and headers. This profile is produced by the `brand-dna` skill.

---

# PptxGenJS Reference — VC-Backed SaaS Aesthetic

Complete implementation patterns for both light and dark modes. Copy-paste ready.

---

## Setup & Initialization

```javascript
const pptxgen = require("pptxgenjs");

let pres = new pptxgen();
pres.layout = "LAYOUT_16x9"; // 10" × 5.625"
pres.author = "Author Name";
pres.title = "Presentation Title";
```

### Theme Configuration

Define your theme once at the top. Every slide references this object.

```javascript
// --- DARK MODE ---
const theme = {
  mode: "dark",
  bg:          { primary: "0A0A0C", surface: "17181A", elevated: "1E1F23" },
  text:        { primary: "FFFFFF", secondary: "A0A0A0", muted: "5A5A5E" },
  border:      "2A2A2E",  // subtle card border (8% white equivalent on dark)
  accent:      "0055FF",  // swap per palette — this is Electric Blue
  accentMuted: "0D1B3F",  // accent at ~15% on dark bg (for tinted panels)
  status:      { positive: "10B981", warning: "F59E0B", critical: "EF4444" },
  font:        { head: "Inter", body: "Inter", mono: "JetBrains Mono" },
  shadow:      () => ({ type: "outer", blur: 6, offset: 2, color: "000000", opacity: 0.25 }),
  cardShadow:  () => ({ type: "outer", blur: 10, offset: 3, color: "000000", opacity: 0.3 }),
};

// --- LIGHT MODE ---
const theme = {
  mode: "light",
  bg:          { primary: "FFFFFF", surface: "F8F9FA", elevated: "FFFFFF" },
  text:        { primary: "111111", secondary: "555555", muted: "999999" },
  border:      "E8E8E8",
  accent:      "0055FF",
  accentMuted: "EBF0FF",  // accent at ~10% on white bg
  status:      { positive: "10B981", warning: "F59E0B", critical: "EF4444" },
  font:        { head: "Inter", body: "Inter", mono: "JetBrains Mono" },
  shadow:      () => ({ type: "outer", blur: 8, offset: 2, color: "000000", opacity: 0.07 }),
  cardShadow:  () => ({ type: "outer", blur: 12, offset: 3, color: "000000", opacity: 0.1 }),
};
```

### Palette Swapping

To use a different palette, just change `accent` and `accentMuted`:

```javascript
// Electric Blue (default)
theme.accent = "0055FF"; theme.accentMuted = theme.mode === "dark" ? "0D1B3F" : "EBF0FF";

// Indigo
theme.accent = "6366F1"; theme.accentMuted = theme.mode === "dark" ? "1A1A3E" : "EEF0FF";

// Teal Trust
theme.accent = "0D9488"; theme.accentMuted = theme.mode === "dark" ? "0A2825" : "E6F7F5";

// Emerald
theme.accent = "10B981"; theme.accentMuted = theme.mode === "dark" ? "0A2E20" : "E8FAF0";

// Hot Coral
theme.accent = "FF6B6B"; theme.accentMuted = theme.mode === "dark" ? "3D1A1A" : "FFF0F0";

// Rose
theme.accent = "F43F5E"; theme.accentMuted = theme.mode === "dark" ? "3D1020" : "FFF0F3";

// Amber Signal
theme.accent = "F59E0B"; theme.accentMuted = theme.mode === "dark" ? "3D2A08" : "FFF8E6";

// Violet
theme.accent = "8B5CF6"; theme.accentMuted = theme.mode === "dark" ? "1F1540" : "F3EFFE";

// Gold Standard
theme.accent = "D4AF37"; theme.accentMuted = theme.mode === "dark" ? "332B10" : "FBF6E6";

// Neon Lime (dark mode only — fails contrast on white)
theme.accent = "39FF14"; theme.accentMuted = "0A3308";

// Cyan Edge
theme.accent = "06B6D4"; theme.accentMuted = theme.mode === "dark" ? "082F35" : "E6FAFE";

// Slate (no accent — monochrome)
theme.accent = "64748B"; theme.accentMuted = theme.mode === "dark" ? "1E2530" : "F1F5F9";
```

---

## Layout Dimensions (16:9 = 10" × 5.625")

```
Full width:  10.0"     Full height:  5.625"
Margins:     0.5" all sides
Content:     x=0.5, w=9.0    y=1.0 to 5.0 (4.0" tall)
Title zone:  y=0.3 to 0.8
Footer zone: y=5.15 to 5.4
```

### Column Math

| Columns | Card Width | Gap | x positions |
|---------|-----------|-----|-------------|
| 2 | 4.35" | 0.3" | 0.5, 5.15 |
| 3 | 2.8" | 0.3" | 0.5, 3.6, 6.7 |
| 4 | 2.025" | 0.3" | 0.5, 2.825, 5.15, 7.475 |
| 5 | 1.56" | 0.3" | 0.5, 2.36, 4.22, 6.08, 7.94 |

---

## ⚠️ Critical Pitfalls

### 1. NEVER use `#` in hex colors
```javascript
// ❌ CORRUPTS FILE
{ color: "#0055FF" }
// ✅ CORRECT
{ color: "0055FF" }
```

### 2. NEVER encode opacity in hex (8-char colors)
```javascript
// ❌ CORRUPTS FILE
{ color: "0055FF20" }
// ✅ Use separate opacity property
{ color: "0055FF", transparency: 80 }
// Note: transparency is INVERSE of opacity (80 = 20% visible)
```

### 3. Use `bullet: true`, not unicode
```javascript
// ❌ AI hallmark
{ text: "• Feature one" }
// ✅ Proper formatting
{ text: "Feature one", options: { bullet: true } }
```

### 4. Use `breakLine: true` between text array items
```javascript
// Text arrays need explicit line breaks
slide.addText([
  { text: "Line one", options: { fontSize: 14, breakLine: true } },
  { text: "Line two", options: { fontSize: 14 } },
], { x: 0.5, y: 1.0, w: 9.0 });
```

### 5. NEVER reuse option objects (mutation trap)
```javascript
// ❌ Second call gets corrupted values
const shadow = { type: "outer", blur: 6 };
slide.addShape(pres.shapes.RECTANGLE, { shadow, x: 1 });
slide.addShape(pres.shapes.RECTANGLE, { shadow, x: 3 }); // BROKEN

// ✅ Use factory functions (theme.shadow() / theme.cardShadow())
slide.addShape(pres.shapes.RECTANGLE, { shadow: theme.shadow(), x: 1 });
slide.addShape(pres.shapes.RECTANGLE, { shadow: theme.shadow(), x: 3 });
```

### 6. Fresh `pptxgen()` per presentation
```javascript
// ❌ Reusing instance from a previous deck
// ✅ Always: let pres = new pptxgen();
```

### 7. No `ROUNDED_RECTANGLE` for accent overlays
Use `RECTANGLE` for thin accent bars/overlays. Rounded corners on thin shapes look wrong.

### 8. Shadow direction
```javascript
// Downward shadow (normal)
{ type: "outer", blur: 6, offset: 2, angle: 180, color: "000000", opacity: 0.1 }
// Upward shadow (don't use negative offset — use angle)
{ type: "outer", blur: 6, offset: 2, angle: 0, color: "000000", opacity: 0.1 }
```

### 9. Gradient fills
PptxGenJS doesn't support native gradient fills on shapes. For gradient backgrounds, generate a gradient image and use it as slide/shape background.

### 10. Avoid `lineSpacing` with bullets
It causes inconsistent spacing. Control spacing with `paraSpaceAfter` instead.

---

## Text Patterns

### Basic Text
```javascript
slide.addText("Hello World", {
  x: 0.5, y: 0.3, w: 9.0, h: 0.6,
  fontSize: 36, fontFace: theme.font.head, bold: true,
  color: theme.text.primary, align: "left",
});
```

### Rich Text (Multiple Styles)
```javascript
slide.addText([
  { text: "Revenue grew ", options: { fontSize: 16, color: theme.text.secondary, fontFace: theme.font.body } },
  { text: "47%", options: { fontSize: 16, color: theme.accent, fontFace: theme.font.body, bold: true } },
  { text: " year-over-year", options: { fontSize: 16, color: theme.text.secondary, fontFace: theme.font.body } },
], { x: 0.5, y: 1.5, w: 9.0 });
```

### Bullet List
```javascript
slide.addText([
  { text: "First item", options: { bullet: true, fontSize: 15, color: theme.text.secondary, fontFace: theme.font.body, breakLine: true, paraSpaceAfter: 6 } },
  { text: "Second item", options: { bullet: true, fontSize: 15, color: theme.text.secondary, fontFace: theme.font.body, breakLine: true, paraSpaceAfter: 6 } },
  { text: "Third item", options: { bullet: true, fontSize: 15, color: theme.text.secondary, fontFace: theme.font.body } },
], { x: 0.5, y: 1.5, w: 8.0, valign: "top" });
```

### KPI Number + Label
```javascript
// Big number
slide.addText("$4.2M", {
  x: cardX, y: cardY + 0.3, w: cardW, h: 0.8,
  fontSize: 48, fontFace: theme.font.mono, bold: true,
  color: theme.accent, align: "center",
});
// Label below
slide.addText("ANNUAL REVENUE", {
  x: cardX, y: cardY + 1.1, w: cardW, h: 0.3,
  fontSize: 9, fontFace: theme.font.body, bold: true,
  color: theme.text.muted, align: "center",
  charSpacing: 2.5,  // tracking for ALL CAPS labels
});
```

---

## Shapes & Cards

### Card (Elevated Surface)
```javascript
// Card background
slide.addShape(pres.shapes.RECTANGLE, {
  x: 0.5, y: 1.0, w: 2.8, h: 2.5,
  fill: { color: theme.bg.surface },
  line: { color: theme.border, width: 0.5 },
  rectRadius: 0.08,
  shadow: theme.cardShadow(),
});
```

### Accent Bar (Thin Vertical/Horizontal)
```javascript
// Vertical accent bar (left edge of a panel)
slide.addShape(pres.shapes.RECTANGLE, {
  x: 5.1, y: 1.5, w: 0.04, h: 2.0,
  fill: { color: theme.accent },
});

```

### Tinted Panel (Accent at Low Opacity)
```javascript
slide.addShape(pres.shapes.RECTANGLE, {
  x: 5.15, y: 1.0, w: 4.35, h: 3.5,
  fill: { color: theme.accentMuted },
  line: { color: theme.border, width: 0.5 },
  rectRadius: 0.08,
});
```

### Status Indicator Dot
```javascript
// Green dot for positive KPI
slide.addShape(pres.shapes.OVAL, {
  x: cardX + 0.15, y: cardY + 0.2, w: 0.12, h: 0.12,
  fill: { color: theme.status.positive },
});
```

---

## Images & Logos

### Logo from File
```javascript
slide.addImage({
  path: "/path/to/logo.png",
  x: 0.5, y: 0.3, w: 1.5, h: 0.5,
  sizing: { type: "contain", w: 1.5, h: 0.5 },
});
```

### Logo in Slide Master (Every Slide)
```javascript
pres.defineSlideMaster({
  title: "BRANDED",
  background: { color: theme.bg.primary },
  objects: [
    { image: {
      path: "/path/to/logo.png",
      x: 8.5, y: 0.2, w: 1.0, h: 0.35,
      sizing: { type: "contain", w: 1.0, h: 0.35 },
    }},
  ],
});

let slide = pres.addSlide({ masterName: "BRANDED" });
```

### Logo from Base64
```javascript
slide.addImage({
  data: "image/png;base64,iVBOR...",
  x: 0.5, y: 0.3, w: 1.5, h: 0.5,
  sizing: { type: "contain", w: 1.5, h: 0.5 },
});
```

### Full-Bleed Background Image with Overlay
```javascript
// Background image
slide.addImage({
  path: "/path/to/photo.jpg",
  x: 0, y: 0, w: 10, h: 5.625,
  sizing: { type: "cover", w: 10, h: 5.625 },
});
// Dark overlay for text readability
slide.addShape(pres.shapes.RECTANGLE, {
  x: 0, y: 0, w: 10, h: 5.625,
  fill: { color: "000000" },
  transparency: 40,  // 60% visible (dark overlay)
});
```

---

## Icons (react-icons → PNG → PptxGenJS)

### Conversion Utility

```javascript
const React = require("react");
const ReactDOMServer = require("react-dom/server");
const sharp = require("sharp");

async function iconToPng(iconName, pkg, color, size = 256) {
  const icons = require(`react-icons/${pkg}`);
  const svg = ReactDOMServer.renderToStaticMarkup(
    React.createElement(icons[iconName], { color, size: String(size) })
  );
  const png = await sharp(Buffer.from(svg)).png().toBuffer();
  return "image/png;base64," + png.toString("base64");
}

// Usage — Lucide icons (preferred)
const chartIcon = await iconToPng("LuBarChart3", "lu", "#" + theme.accent);
const usersIcon = await iconToPng("LuUsers", "lu", "#FFFFFF");

// Then add to slide
slide.addImage({ data: chartIcon, x: 0.7, y: 1.3, w: 0.35, h: 0.35 });
```

### Icon in Colored Circle

```javascript
// Circle background
slide.addShape(pres.shapes.OVAL, {
  x: 0.6, y: 1.2, w: 0.55, h: 0.55,
  fill: { color: theme.accent },
});
// White icon centered in circle
const icon = await iconToPng("LuZap", "lu", "#FFFFFF", 256);
slide.addImage({ data: icon, x: 0.7, y: 1.3, w: 0.35, h: 0.35 });
```

---

## Charts

### Bar/Column Chart

**CRITICAL: Set BOTH `dataLabelFormatCode` and `valAxisLabelFormatCode`.** `valAxisLabelFormatCode` only formats the axis — data labels from `showValue: true` need `dataLabelFormatCode`. `numFmt` is NOT a valid PptxGenJS property. Use OOXML conditional formats with raw values for best results.

```javascript
// Raw values + OOXML conditional format (auto-scales to K/M)
const currFmt = '[>=1000000]"$"#,##0.0,,"M";[>=1000]"$"#,##0.00,"K";"$"#,##0';
slide.addChart(pres.charts.BAR, [
  { name: "Revenue", labels: ["Q1", "Q2", "Q3", "Q4"], values: [1200000, 1800000, 2400000, 3100000] }
], {
  x: 0.5, y: 1.2, w: 5.5, h: 3.5,
  showValue: true,
  dataLabelColor: theme.text.secondary,
  dataLabelFontSize: 9,
  dataLabelFontFace: theme.font.mono,
  dataLabelPosition: "outEnd",
  dataLabelFormatCode: currFmt,  // REQUIRED: formats data labels ($1.2M, $540.18K)
  valAxisLabelFormatCode: '"$"#,##0.0,,"M"',  // Simple format (no conditional brackets on axis)
  showLegend: false,
  catAxisLabelColor: theme.text.muted,
  valAxisLabelColor: theme.text.muted,
  catAxisLabelFontSize: 10,
  valAxisLabelFontSize: 9,
  catAxisLineShow: false,
  valAxisLineShow: false,
  valGridLine: { color: theme.border, width: 0.5 },
  chartColors: [theme.accent],
  plotArea: { fill: { color: theme.bg.primary } },
  barGapWidthPct: 80,
  shadow: theme.shadow(),
});
```

### Line Chart
```javascript
slide.addChart(pres.charts.LINE, [
  { name: "2024", labels: months, values: data2024 },
  { name: "2025", labels: months, values: data2025 },
], {
  x: 0.5, y: 1.2, w: 9.0, h: 3.5,
  showLegend: true, legendPos: "t", legendFontSize: 10, legendColor: theme.text.secondary,
  catAxisLabelColor: theme.text.muted,
  valAxisLabelColor: theme.text.muted,
  catAxisLineShow: false,
  valAxisLineShow: false,
  valGridLine: { color: theme.border, width: 0.5 },
  chartColors: [theme.accent, theme.text.muted],
  lineDataSymbol: "circle", lineDataSymbolSize: 6,
  lineSmooth: true,
  plotArea: { fill: { color: theme.bg.primary } },
});
```

### Pie / Doughnut Chart
```javascript
slide.addChart(pres.charts.DOUGHNUT, [
  { name: "Share", labels: ["Product", "Services", "Support"], values: [55, 30, 15] }
], {
  x: 0.5, y: 1.2, w: 4.0, h: 3.5,
  showLegend: true, legendPos: "r", legendFontSize: 11, legendColor: theme.text.secondary,
  showPercent: true, dataLabelColor: theme.text.primary, dataLabelFontSize: 11,
  chartColors: [theme.accent, theme.text.muted, theme.border],
  holeSize: 55,
});
```

---

## Tables

### Styled Data Table

```javascript
const headerOpts = {
  fill: { color: theme.mode === "dark" ? theme.bg.elevated : theme.accent },
  color: theme.mode === "dark" ? theme.accent : "FFFFFF",
  fontSize: 10, fontFace: theme.font.body, bold: true,
  align: "left", valign: "middle",
  border: { type: "solid", color: theme.border, pt: 0.5 },
};

const rowOpts = (i) => ({
  fill: { color: i % 2 === 0 ? theme.bg.surface : theme.bg.primary },
  color: theme.text.secondary,
  fontSize: 11, fontFace: theme.font.body,
  align: "left", valign: "middle",
  border: { type: "solid", color: theme.border, pt: 0.5 },
});

const numOpts = (i) => ({
  ...rowOpts(i),
  fontFace: theme.font.mono,
  align: "right",
});

const rows = [
  // Header row
  [
    { text: "METRIC", options: headerOpts },
    { text: "Q1", options: { ...headerOpts, align: "right" } },
    { text: "Q2", options: { ...headerOpts, align: "right" } },
    { text: "Q3", options: { ...headerOpts, align: "right" } },
  ],
  // Data rows
  ...data.map((row, i) => [
    { text: row.name, options: rowOpts(i) },
    { text: row.q1, options: numOpts(i) },
    { text: row.q2, options: numOpts(i) },
    { text: row.q3, options: numOpts(i) },
  ]),
];

slide.addTable(rows, {
  x: 0.5, y: 1.2, w: 9.0,
  colW: [3.0, 2.0, 2.0, 2.0],
  rowH: 0.4,
  margin: [4, 8, 4, 8],
});
```

---

## Complete Slide Compositions

All compositions below work in both modes — they reference `theme` tokens.

### 1. Title Slide (Dark Hero)

```javascript
let slide = pres.addSlide();
slide.background = { color: theme.bg.primary };

// Optional: logo
slide.addImage({
  path: logoPath,
  x: 0.5, y: 0.4, w: 1.5, h: 0.5,
  sizing: { type: "contain", w: 1.5, h: 0.5 },
});

// Hero title
slide.addText("Quarterly Business Review", {
  x: 0.5, y: 1.5, w: 9.0, h: 1.2,
  fontSize: 54, fontFace: theme.font.head, bold: true,
  color: theme.text.primary, align: "left",
});

// Subtitle
slide.addText("Q4 2025 — Growth & Operational Metrics", {
  x: 0.5, y: 2.7, w: 9.0, h: 0.5,
  fontSize: 20, fontFace: theme.font.body,
  color: theme.text.secondary, align: "left",
});

// Date / attribution
slide.addText("January 15, 2026  •  Confidential", {
  x: 0.5, y: 5.1, w: 9.0, h: 0.3,
  fontSize: 10, fontFace: theme.font.body,
  color: theme.text.muted, align: "left",
});
```

### 2. KPI Dashboard (3-4 Cards)

```javascript
let slide = pres.addSlide();
slide.background = { color: theme.bg.primary };

// Title
slide.addText("Executive Summary", {
  x: 0.5, y: 0.3, w: 9.0, h: 0.5,
  fontSize: 32, fontFace: theme.font.head, bold: true,
  color: theme.text.primary,
});

// KPI Cards
const kpis = [
  { value: "$4.2M", label: "REVENUE", change: "+23%", status: "positive" },
  { value: "1,847", label: "ACTIVE USERS", change: "+12%", status: "positive" },
  { value: "94.2%", label: "RETENTION", change: "-0.3%", status: "warning" },
  { value: "47", label: "NPS SCORE", change: "+8", status: "positive" },
];

const cardW = 2.025;
const cardH = 2.2;
const gap = 0.3;
const startX = 0.5;
const cardY = 1.2;

kpis.forEach((kpi, i) => {
  const cx = startX + i * (cardW + gap);

  // Card bg
  slide.addShape(pres.shapes.RECTANGLE, {
    x: cx, y: cardY, w: cardW, h: cardH,
    fill: { color: theme.bg.surface },
    line: { color: theme.border, width: 0.5 },
    rectRadius: 0.08,
    shadow: theme.cardShadow(),
  });

  // Status dot
  slide.addShape(pres.shapes.OVAL, {
    x: cx + 0.2, y: cardY + 0.25, w: 0.1, h: 0.1,
    fill: { color: theme.status[kpi.status] },
  });

  // Big number
  slide.addText(kpi.value, {
    x: cx, y: cardY + 0.5, w: cardW, h: 0.7,
    fontSize: 36, fontFace: theme.font.mono, bold: true,
    color: theme.text.primary, align: "center",
  });

  // Label
  slide.addText(kpi.label, {
    x: cx, y: cardY + 1.25, w: cardW, h: 0.3,
    fontSize: 9, fontFace: theme.font.body, bold: true,
    color: theme.text.muted, align: "center", charSpacing: 2.5,
  });

  // Change indicator
  slide.addText(kpi.change, {
    x: cx, y: cardY + 1.6, w: cardW, h: 0.3,
    fontSize: 13, fontFace: theme.font.mono,
    color: theme.status[kpi.status], align: "center",
  });
});
```

### 3. Chart + Insight (60/40 Split)

```javascript
let slide = pres.addSlide();
slide.background = { color: theme.bg.primary };

// Title
slide.addText("Revenue Trend", {
  x: 0.5, y: 0.3, w: 9.0, h: 0.5,
  fontSize: 32, fontFace: theme.font.head, bold: true,
  color: theme.text.primary,
});

// Chart area (left 60%)
slide.addChart(pres.charts.BAR, chartData, {
  x: 0.5, y: 1.0, w: 5.2, h: 3.8,
  showValue: false, showLegend: false,
  catAxisLabelColor: theme.text.muted, valAxisLabelColor: theme.text.muted,
  catAxisLabelFontSize: 10, valAxisLabelFontSize: 9,
  catAxisLineShow: false, valAxisLineShow: false,
  valGridLine: { color: theme.border, width: 0.5 },
  chartColors: [theme.accent],
  plotArea: { fill: { color: theme.bg.primary } },
  barGapWidthPct: 80,
});

// Insight panel (right 40%) — tinted background
slide.addShape(pres.shapes.RECTANGLE, {
  x: 5.9, y: 1.0, w: 3.6, h: 2.5,
  fill: { color: theme.accentMuted },
  line: { color: theme.border, width: 0.5 },
  rectRadius: 0.08,
});

// Vertical accent bar
slide.addShape(pres.shapes.RECTANGLE, {
  x: 5.9, y: 1.0, w: 0.04, h: 2.5,
  fill: { color: theme.accent },
});

// Insight content
slide.addText("Key Insight", {
  x: 6.15, y: 1.15, w: 3.1, h: 0.3,
  fontSize: 11, fontFace: theme.font.body, bold: true,
  color: theme.accent, charSpacing: 1.5,
});

// NOTE: For panels < 4" wide, use fontSize 10-11 max.
// Estimate line count: chars ÷ ~40 chars/line at 11pt in 3" width.
// Verify total lines fit in container height (line ≈ 0.18" at 11pt).
slide.addText("Revenue grew 23% QoQ driven by enterprise expansion. Deal size rose from $42K to $58K.", {
  x: 6.15, y: 1.5, w: 3.0, h: 1.5,
  fontSize: 11, fontFace: theme.font.body,
  color: theme.text.secondary, align: "left", valign: "top",
  lineSpacingMultiple: 1.25,
});

// Recommendation panel below insight
slide.addShape(pres.shapes.RECTANGLE, {
  x: 5.9, y: 3.7, w: 3.6, h: 1.1,
  fill: { color: theme.bg.surface },
  line: { color: theme.border, width: 0.5 },
  rectRadius: 0.08,
});

slide.addText("Recommendation", {
  x: 6.15, y: 3.85, w: 3.1, h: 0.25,
  fontSize: 11, fontFace: theme.font.body, bold: true,
  color: theme.status.positive, charSpacing: 1.5,
});

slide.addText("Double down on enterprise pipeline — hire 2 additional AEs for Q1.", {
  x: 6.15, y: 4.15, w: 3.1, h: 0.5,
  fontSize: 13, fontFace: theme.font.body,
  color: theme.text.secondary, valign: "top",
});
```

### 4. Section Divider

```javascript
let slide = pres.addSlide();
slide.background = { color: theme.mode === "dark" ? theme.bg.elevated : theme.accent };

// Section number
slide.addText("02", {
  x: 0.5, y: 1.2, w: 9.0, h: 0.6,
  fontSize: 18, fontFace: theme.font.mono,
  color: theme.mode === "dark" ? theme.accent : "FFFFFF",
  transparency: 30,
});

// Section title
slide.addText("Product & Engineering", {
  x: 0.5, y: 1.8, w: 9.0, h: 1.2,
  fontSize: 44, fontFace: theme.font.head, bold: true,
  color: theme.mode === "dark" ? theme.text.primary : "FFFFFF",
});

// Description
slide.addText("Sprint velocity, feature launches, and technical debt reduction", {
  x: 0.5, y: 3.4, w: 7.0, h: 0.5,
  fontSize: 16, fontFace: theme.font.body,
  color: theme.mode === "dark" ? theme.text.secondary : "FFFFFF",
  transparency: theme.mode === "dark" ? 0 : 20,
});
```

### 5. Data Table

```javascript
let slide = pres.addSlide();
slide.background = { color: theme.bg.primary };

slide.addText("Financial Summary", {
  x: 0.5, y: 0.3, w: 9.0, h: 0.5,
  fontSize: 32, fontFace: theme.font.head, bold: true,
  color: theme.text.primary,
});

const hdr = {
  fill: { color: theme.mode === "dark" ? theme.bg.elevated : theme.accent },
  color: theme.mode === "dark" ? theme.accent : "FFFFFF",
  fontSize: 10, fontFace: theme.font.body, bold: true,
  border: { type: "solid", color: theme.border, pt: 0.5 },
  valign: "middle",
};

const cell = (i, align = "left") => ({
  fill: { color: i % 2 === 0 ? theme.bg.surface : theme.bg.primary },
  color: theme.text.secondary,
  fontSize: 11, fontFace: align === "right" ? theme.font.mono : theme.font.body,
  align, valign: "middle",
  border: { type: "solid", color: theme.border, pt: 0.5 },
});

const changeCell = (i, val) => ({
  ...cell(i, "right"),
  color: val >= 0 ? theme.status.positive : theme.status.critical,
});

const tableData = [
  [
    { text: "METRIC", options: { ...hdr, align: "left" } },
    { text: "Q3 ACTUAL", options: { ...hdr, align: "right" } },
    { text: "Q4 ACTUAL", options: { ...hdr, align: "right" } },
    { text: "Δ QOQ", options: { ...hdr, align: "right" } },
  ],
  // ... map your data into rows using cell() and changeCell()
];

slide.addTable(tableData, {
  x: 0.5, y: 1.1, w: 9.0,
  colW: [3.0, 2.0, 2.0, 2.0],
  rowH: 0.4,
  margin: [4, 10, 4, 10],
});
```

### 6. Icon Feature Grid (3-4 Rows)

```javascript
let slide = pres.addSlide();
slide.background = { color: theme.bg.primary };

slide.addText("Why Choose Us", {
  x: 0.5, y: 0.3, w: 9.0, h: 0.5,
  fontSize: 32, fontFace: theme.font.head, bold: true,
  color: theme.text.primary,
});

const features = [
  { icon: "LuZap", title: "Lightning Fast", desc: "Sub-100ms response times across all endpoints" },
  { icon: "LuShield", title: "Enterprise Security", desc: "SOC 2 Type II certified with end-to-end encryption" },
  { icon: "LuBarChart3", title: "Real-Time Analytics", desc: "Live dashboards with customizable KPI tracking" },
];

for (let i = 0; i < features.length; i++) {
  const fy = 1.2 + i * 1.25;

  // Accent circle
  slide.addShape(pres.shapes.OVAL, {
    x: 0.5, y: fy, w: 0.55, h: 0.55,
    fill: { color: theme.accent },
  });

  // Icon (white on accent)
  const ico = await iconToPng(features[i].icon, "lu", "#FFFFFF", 256);
  slide.addImage({ data: ico, x: 0.6, y: fy + 0.1, w: 0.35, h: 0.35 });

  // Title
  slide.addText(features[i].title, {
    x: 1.3, y: fy, w: 7.5, h: 0.35,
    fontSize: 18, fontFace: theme.font.head, bold: true,
    color: theme.text.primary,
  });

  // Description
  slide.addText(features[i].desc, {
    x: 1.3, y: fy + 0.35, w: 7.5, h: 0.35,
    fontSize: 14, fontFace: theme.font.body,
    color: theme.text.secondary,
  });
}
```

### 7. Quote Slide

```javascript
let slide = pres.addSlide();
slide.background = { color: theme.bg.primary };

// Large decorative quotation mark
slide.addText("\u201C", {
  x: 0.5, y: 0.5, w: 2.0, h: 2.0,
  fontSize: 144, fontFace: "Georgia",
  color: theme.accent, transparency: 60,
});

// Quote text
slide.addText("The product practically sells itself. Our team adoption went from 0 to 95% in under two weeks.", {
  x: 1.5, y: 1.5, w: 7.0, h: 2.0,
  fontSize: 24, fontFace: theme.font.body, italic: true,
  color: theme.text.primary, align: "center", valign: "middle",
  lineSpacingMultiple: 1.4,
});

// Attribution
slide.addText("— Sarah Chen, VP Engineering at Stripe", {
  x: 1.5, y: 3.7, w: 7.0, h: 0.4,
  fontSize: 14, fontFace: theme.font.body,
  color: theme.text.muted, align: "center",
});
```

### 8. Big Number Slide

```javascript
let slide = pres.addSlide();
slide.background = { color: theme.bg.primary };

// Context label
slide.addText("YEAR-OVER-YEAR GROWTH", {
  x: 0.5, y: 1.2, w: 9.0, h: 0.3,
  fontSize: 11, fontFace: theme.font.body, bold: true,
  color: theme.text.muted, align: "center", charSpacing: 3,
});

// Huge number
slide.addText("247%", {
  x: 0.5, y: 1.6, w: 9.0, h: 2.0,
  fontSize: 120, fontFace: theme.font.mono, bold: true,
  color: theme.accent, align: "center",
});

// Supporting context
slide.addText("From $1.2M to $4.2M ARR in 12 months", {
  x: 1.5, y: 3.6, w: 7.0, h: 0.5,
  fontSize: 18, fontFace: theme.font.body,
  color: theme.text.secondary, align: "center",
});
```

### 9. Comparison (Side-by-Side)

```javascript
let slide = pres.addSlide();
slide.background = { color: theme.bg.primary };

slide.addText("Before & After", {
  x: 0.5, y: 0.3, w: 9.0, h: 0.5,
  fontSize: 32, fontFace: theme.font.head, bold: true,
  color: theme.text.primary,
});

// Left panel (before)
slide.addShape(pres.shapes.RECTANGLE, {
  x: 0.5, y: 1.0, w: 4.25, h: 3.8,
  fill: { color: theme.bg.surface },
  line: { color: theme.border, width: 0.5 },
  rectRadius: 0.08,
});

slide.addText("BEFORE", {
  x: 0.5, y: 1.15, w: 4.25, h: 0.3,
  fontSize: 10, fontFace: theme.font.body, bold: true,
  color: theme.text.muted, align: "center", charSpacing: 3,
});

// Right panel (after) — accent tinted
slide.addShape(pres.shapes.RECTANGLE, {
  x: 5.25, y: 1.0, w: 4.25, h: 3.8,
  fill: { color: theme.accentMuted },
  line: { color: theme.border, width: 0.5 },
  rectRadius: 0.08,
});

slide.addText("AFTER", {
  x: 5.25, y: 1.15, w: 4.25, h: 0.3,
  fontSize: 10, fontFace: theme.font.body, bold: true,
  color: theme.accent, align: "center", charSpacing: 3,
});

// Add content to each panel...
```

### 10. Closing Slide

```javascript
let slide = pres.addSlide();
slide.background = { color: theme.bg.primary };

// Logo (large, centered)
if (logoPath) {
  slide.addImage({
    path: logoPath,
    x: 3.5, y: 0.8, w: 3.0, h: 1.0,
    sizing: { type: "contain", w: 3.0, h: 1.0 },
  });
}

// Thank you
slide.addText("Thank You", {
  x: 0.5, y: 2.0, w: 9.0, h: 0.8,
  fontSize: 44, fontFace: theme.font.head, bold: true,
  color: theme.text.primary, align: "center",
});

// CTA or next steps
slide.addText("Questions?", {
  x: 0.5, y: 2.8, w: 9.0, h: 0.5,
  fontSize: 20, fontFace: theme.font.body,
  color: theme.text.secondary, align: "center",
});

// Contact info
slide.addText("team@company.com  •  company.com", {
  x: 0.5, y: 3.8, w: 9.0, h: 0.4,
  fontSize: 13, fontFace: theme.font.body,
  color: theme.text.muted, align: "center",
});
```

---

## Save & Export

```javascript
// Save to file
await pres.writeFile({ fileName: "/path/to/output.pptx" });

// Save to buffer (for piping)
const buffer = await pres.write({ outputType: "nodebuffer" });
require("fs").writeFileSync("/path/to/output.pptx", buffer);
```

---

## Reading & Editing Existing PPTX

For reading existing presentations, extracting content, or editing templates, see [editing.md](editing.md).

Quick extraction:
```bash
python -m markitdown presentation.pptx
```
