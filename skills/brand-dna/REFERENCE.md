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
