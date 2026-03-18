# brand-dna


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

| Signal | Axis | Direction |
|--------|------|-----------|
| Uses "you/your" frequently | formal_casual | +2 toward casual |
| Technical jargon, industry terms | expert_accessible | -2 toward expert |
| Short punchy sentences (≤8 words) | bold_subtle | +2 toward bold |
| Data, stats, percentages in hero | rational_emotional | -2 toward rational |
| "Transform", "revolutionize", "disrupt" | traditional_innovative | +2 toward innovative |
| Customer testimonials lead | rational_emotional | +2 toward emotional |
| "Trusted by X companies", awards | traditional_innovative | -1 toward traditional |
| Humor, wordplay, casual phrasing | playful_serious | +2 toward playful |
| Formal language, third person | playful_serious | -2 toward serious |

Start each axis at 5 (neutral) and adjust based on signals found.

**Descriptors:** Choose 3-5 adjectives that capture the overall voice tone. These should complement the numerical scores, not repeat them.

#### Imagery
- **Style:** Professional photography, illustration, flat design, 3D renders, or mixed
- **Subjects:** What appears in hero images and product shots (people, products, abstract, data)
- **Composition:** Clean/minimal, busy/editorial, dark/dramatic, light/airy
- **Forbidden elements:** Infer from industry (healthcare → no unqualified medical claims imagery; B2B → no cheesy stock photos)

#### Aesthetic
- **Mood keywords:** 3 adjectives describing the visual mood (e.g., "trustworthy", "modern", "premium")
- **Texture:** minimal, textured, or mixed
- **Negative space:** generous, moderate, or dense

#### Brand Values
Extract from about page, mission statement, or footer. Look for repeated themes. Choose 3-5 core values.

#### Target Audience
Infer from copy, pricing signals, and positioning:
- **Age range:** Estimate from visual design, language complexity, and product type
- **Profession:** Who the product/service is for
- **Pain points:** What problems the brand addresses (from hero copy and feature descriptions)
- **Aspirations:** What the audience wants to achieve (from benefit-oriented copy)

### Step 4: Build brand-profile.json

Construct the JSON following the schema in REFERENCE.md precisely. Use `null` for any field that cannot be confidently extracted — never guess.

### Step 5: Write and Confirm

Write `brand-profile.json` to the current working directory.

Display a summary:
```
Brand DNA extracted → brand-profile.json

  Brand: [brand_name]
  Voice: [descriptor 1], [descriptor 2], [descriptor 3]
  Primary Color: [hex]
  Typography: [heading_font] / [body_font]
  Audience: [age_range], [profession]

This profile can be consumed by:
  - seo-content-writer (voice matching)
  - email-composer (tone calibration)
  - frontend-design (visual identity)
  - pro-deck-builder (brand colors/fonts)
  - cross-platform-audit (brand consistency checks)
```

## Limitations

- **Sparse sites:** <200 words of body text produce lower-confidence profiles. Note this in output.
- **SPA/React sites:** JavaScript-rendered content may not be fully captured by WebFetch. Note this if detected.
- **Multi-brand enterprises:** Creates one profile per URL. Run separately for each brand.
- **CSS-in-JS:** Modern React/Next.js sites may not have extractable CSS. Use og:image analysis as fallback.

## How to Use This Skill

Ask questions like:
- "Extract the brand DNA from https://example.com"
- "Build a brand profile for my client's website"
- "Analyze the brand voice and colors of https://competitor.com"
- "Quick brand profile — homepage only — for https://example.com"
- "What's the brand identity of this website?"

---

# Brand DNA Reference

## brand-profile.json Schema

```json
{
  "schema_version": "1.0",
  "brand_name": "string",
  "website_url": "string (full URL including https://)",
  "extracted_at": "ISO-8601 timestamp",

  "voice": {
    "formal_casual": 1-10,
    "rational_emotional": 1-10,
    "playful_serious": 1-10,
    "bold_subtle": 1-10,
    "traditional_innovative": 1-10,
    "expert_accessible": 1-10,
    "descriptors": ["adjective1", "adjective2", "adjective3"]
  },

  "colors": {
    "primary": "#hexcode or null",
    "secondary": ["#hex1", "#hex2"],
    "forbidden": ["#hex or color name"],
    "background": "#hexcode",
    "text": "#hexcode"
  },

  "typography": {
    "heading_font": "Font Name or null",
    "body_font": "Font Name or system-ui",
    "pairing_descriptor": "brief description of the pairing"
  },

  "imagery": {
    "style": "professional photography | illustration | flat design | 3D renders | mixed",
    "subjects": ["subject1", "subject2"],
    "composition": "brief description",
    "forbidden": ["element1", "element2"]
  },

  "aesthetic": {
    "mood_keywords": ["keyword1", "keyword2", "keyword3"],
    "texture": "minimal | textured | mixed",
    "negative_space": "generous | moderate | dense"
  },

  "brand_values": ["value1", "value2", "value3"],

  "target_audience": {
    "age_range": "e.g., 25-45",
    "profession": "brief description",
    "pain_points": ["pain1", "pain2"],
    "aspirations": ["aspiration1", "aspiration2"]
  }
}
```

## Field Reference

### Voice Axes (1-10 Scale)

Score interpretation: 1 = extreme left pole, 10 = extreme right pole, 5 = neutral.

| Field | 1 (Left Pole) | 10 (Right Pole) | Marketing Implication |
|-------|---------------|-----------------|----------------------|
| `formal_casual` | Corporate, third-person | Conversational, first-person | Headline and CTA tone |
| `rational_emotional` | Data-driven, logical proof | Story-driven, emotionally evocative | Content structure (stats vs narratives) |
| `playful_serious` | Humorous, witty, fun | No-nonsense, professional | CTA phrasing and creative direction |
| `bold_subtle` | Big claims, provocative | Understated, nuanced | Visual hierarchy and headline strength |
| `traditional_innovative` | Classic, established trust | Cutting-edge, disruptive | Imagery style and competitive positioning |
| `expert_accessible` | Deep expertise, technical | Everyone can understand, jargon-free | Copy complexity and reading level |

**Descriptors:** 3-5 free-form adjectives that capture voice nuance not covered by the numerical axes. Examples: "authoritative", "warm", "direct", "irreverent", "polished", "empathetic".

### Colors

| Field | Purpose | Null Handling |
|-------|---------|---------------|
| `primary` | Main brand color — use for accent elements, buttons, headers | If null, skip color injection in downstream output |
| `secondary` | Supporting palette — accents, backgrounds, highlights | Empty array if not detected |
| `forbidden` | Colors to explicitly avoid (competitor colors, off-brand tones) | Empty array if no restrictions identified |
| `background` | Page background color | Default "#FFFFFF" if not detected |
| `text` | Primary text color | Default "#1A1A1A" if not detected |

### Typography

| Field | Purpose | Null Handling |
|-------|---------|---------------|
| `heading_font` | Display/headline font | `null` if no Google Fonts detected |
| `body_font` | Body copy font | `"system-ui"` as fallback |
| `pairing_descriptor` | Human-readable description of the type pairing | Always provide — even if "system default" |

### Imagery

| Field | Purpose | Usage |
|-------|---------|-------|
| `style` | Primary visual approach | Guides creative direction in content and ads |
| `subjects` | Common image subjects | Informs stock photo selection and creative briefs |
| `composition` | Layout and spacing approach | Guides visual design decisions |
| `forbidden` | Elements to avoid | Prevents off-brand imagery in content and ads |

### Target Audience

| Field | Purpose | Inference Sources |
|-------|---------|-------------------|
| `age_range` | Estimated demographic range | Visual design, language complexity, product pricing |
| `profession` | Who the product/service serves | Hero copy, case studies, testimonials |
| `pain_points` | Problems the brand addresses | Feature descriptions, hero headlines, FAQ |
| `aspirations` | What the audience wants to achieve | Benefit-oriented copy, outcomes, testimonials |

## CSS Extraction Targets

```css
/* Colors */
body { background-color: → colors.background; color: → colors.text }
header, .hero { background-color: → colors.primary candidate }
.btn-primary, .cta { background-color: → colors.primary candidate }
h1, h2 { color: → potential accent/secondary }
a { color: → potential secondary }

/* Typography */
@import url("https://fonts.googleapis.com/css2?family=Inter:wght@400;700")
  → heading_font = "Inter"
body { font-family: → body_font }
h1, h2, .headline { font-family: → heading_font }

/* Imagery signals */
meta[property="og:image"] → analyze for dominant color and imagery style
.hero img, .hero video → imagery style classification
```

## How Downstream Skills Consume brand-profile.json

### seo-content-writer
- **Voice axes** → calibrate tone, reading level, formality of written content
- **Descriptors** → anchor voice consistency checks
- **Target audience** → adjust pain points and aspirations in content framing
- **Brand values** → weave into messaging naturally

### email-composer
- **Voice axes** → set email tone (formal_casual drives salutation and sign-off style)
- **Descriptors** → guide subject line personality
- **Colors** → suggest email template accent colors

### frontend-design
- **Colors** → primary, secondary, background, text for design system
- **Typography** → heading and body font selections
- **Aesthetic** → mood keywords, texture, and negative space guide layout decisions
- **Imagery** → style and composition inform hero sections and visual elements

### pro-deck-builder
- **Colors** → override default RRBC palette with brand colors for client-facing decks
- **Typography** → use brand fonts when available, fall back to system fonts
- **Brand name** → title slides, headers, footers

### cross-platform-audit
- **Voice** → check creative messaging consistency across platforms
- **Colors** → verify ad creative uses brand palette
- **Imagery** → confirm creative style matches brand positioning
