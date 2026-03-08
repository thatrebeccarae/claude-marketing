# Pro Deck Builder Examples

Practical examples of common presentation creation tasks using PptxGenJS.

## Example 1: Executive Summary Deck (Dark Mode)

**User Request**: "Create a 5-slide executive summary for Q1 performance"

**Approach**:
1. Ask user for palette preference and logo
2. Run font discovery to find best available fonts
3. Build dark mode theme with chosen palette
4. Create: title slide, KPI dashboard, chart + insight, data table, closing slide
5. Run QA cycle with markitdown + visual inspection

**Key Patterns Used**:
- Dark mode color tokens (`bg-primary: 0A0A0C`, `bg-surface: 17181A`)
- 85/10/5 color rule (backgrounds / accent / semantic)
- KPI font scaling based on character count
- Bottom callout box (standard h: 0.6", fontSize: 11pt)

## Example 2: Client Pitch Deck (Light Mode)

**User Request**: "Build a pitch deck for a SaaS product demo, light mode, Electric Blue palette"

**Approach**:
1. Set light mode tokens + Electric Blue accent (`0055FF`)
2. Vary layouts: title, icon feature grid, big number, chart + insight, comparison, closing
3. Use Lucide icons via react-icons pipeline
4. Place client logo top-right on content slides (w: 1.0, h: 0.35)
5. QA: check text overflow, accent line anti-pattern, chart formatting

**Key Patterns Used**:
- Light mode color tokens (`bg-primary: FFFFFF`, `bg-surface: F8F9FA`)
- Icon pipeline: react-icons → sharp → PNG → PptxGenJS
- Layout rotation (never repeat same layout consecutively)
- Text fitting rules for narrow panels (< 4" wide)

## Example 3: Data-Heavy Financial Report

**User Request**: "Create a quarterly financial report with charts and tables"

**Approach**:
1. Use light mode + Gold Standard palette for financial credibility
2. OOXML conditional format for mixed-magnitude currency values
3. Calculate table bottom position before placing callout boxes
4. Use mono font (JetBrains Mono > Fira Code) for data/numbers
5. Consistent chart font sizes across all slides

**Key Patterns Used**:
- OOXML conditional format: `[>=1000000]"$"#,##0.0,,"M";[>=1000]"$"#,##0.00,"K";"$"#,##0`
- `dataLabelFormatCode` (supports conditional brackets) vs `valAxisLabelFormatCode` (simple format only)
- Table + callout layout: `calloutY = tableY + (rows x rowH) + 0.15"`
- Cross-slide consistency: identical callout dimensions, chart font sizes, card dimensions
