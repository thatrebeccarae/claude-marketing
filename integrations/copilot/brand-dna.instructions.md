Extract brand identity from a website URL — voice, colors, typography, imagery, values, and target audience — into a structured brand-profile.json. The profile feeds downstream skills (seo-content-writer, email-composer, frontend-design, pro-deck-builder, cross-platform-audit) for brand-consistent output. Use when the user says brand DNA, brand profile, extract brand, analyze brand, brand voice, brand identity, brand colors, or brand style guide.


# Brand DNA — Brand Identity Extractor

Extracts brand identity from a website and produces a structured `brand-profile.json` that other skills can consume for brand-consistent output.

## Quick Reference

| Command | What It Does |
|---------|-------------|
| "Extract brand DNA from https://example.com" | Full extraction → `brand-profile.json` |
| "Quick brand profile for https://example.com" | Homepage-only extraction (faster, lower confidence) |

## Zero Dependencies

This skill uses only the WebFetch tool — no Python scripts, no Playwright, no external APIs. It works anywhere Claude Code runs.

## Extraction Process

### Step 1: Collect URL

If the user hasn't provided a URL, ask:
> "What website URL should I analyze? (e.g., https://yoursite.com)"

### Step 2: Fetch Pages

Use the **WebFetch tool** to retrieve page content. For each URL, request:
- All visible text content
- Full contents of `<style>` blocks
- Inline `style=` attributes
- `<meta>` tags (especially `og:image`, `description`)
- Google Fonts `@import` URLs
- Any `<link>` tags referencing external stylesheets

**Fetch order:**
1. **Homepage** (`<url>`)
2. **About page** — try `<url>/about`, then `/about-us`, then `/our-story`
3. **Product/Services page** — try `<url>/products`, then `/product`, then `/services`

**Quick mode:** If the user requests a quick extraction, fetch homepage only — skip pages 2 and 3.

If a secondary page returns 404 or redirects to homepage, continue with fewer pages and note reduced confidence.

### Step 3: Extract Brand Elements

#### Colors
- **Primary color:** Most prominent brand color from CSS `background-color` on `.hero`, `.btn-primary`, `header`, or `og:image` dominant color
- **Secondary colors:** Supporting palette from CTAs, accents, borders
- **Background/text:** `body` background-color and color
- **Forbidden:** Infer from brand positioning (e.g., competitor colors if identifiable)
- **Dark mode detection:** If body background is #333 or darker, swap background/text values

**CSS targets:** `background-color`, `color`, `border-color` on `body`, `header`, `.hero`, `.btn`, `.cta`, `h1`, `h2`

#### Typography
- **Google Fonts:** Extract from `@import url(https://fonts.googleapis.com/css2?family=...)` — parse font name from URL
- **CSS font-family:** Check `h1`, `h2`, `body`, `.headline` declarations
- **Fallback:** If no Google Fonts detected, set heading_font to `null` and body_font to `"system-ui"`

#### Voice (1-10 scale per axis)
Analyze hero headline, subheadline, about page intro, and CTA button text:


(Truncated. See full skill at github.com/thatrebeccarae/claude-marketing)
