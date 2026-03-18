# Brand DNA — Examples

## 1. Full Brand Extraction

**User Request:**
> "Extract the brand DNA from https://linear.app"

**Analysis Steps:**
1. Fetch homepage, about page, and product page via WebFetch
2. Extract colors from CSS and meta tags
3. Analyze typography from Google Fonts imports and font-family declarations
4. Score voice axes from hero copy, feature descriptions, and CTA text
5. Classify imagery style from og:image and hero visuals
6. Infer target audience from positioning, pricing, and copy
7. Write brand-profile.json

**Sample Output:**

```
Brand DNA extracted → brand-profile.json

  Brand: Linear
  Voice: precise, confident, opinionated
  Primary Color: #5E6AD2
  Typography: Inter / Inter
  Audience: 25-40, engineering and product teams

This profile can be consumed by:
  - seo-content-writer (voice matching)
  - email-composer (tone calibration)
  - frontend-design (visual identity)
  - pro-deck-builder (brand colors/fonts)
  - cross-platform-audit (brand consistency checks)
```

**Sample brand-profile.json:**

```json
{
  "schema_version": "1.0",
  "brand_name": "Linear",
  "website_url": "https://linear.app",
  "extracted_at": "2026-03-16T14:30:00Z",

  "voice": {
    "formal_casual": 4,
    "rational_emotional": 3,
    "playful_serious": 3,
    "bold_subtle": 8,
    "traditional_innovative": 8,
    "expert_accessible": 4,
    "descriptors": ["precise", "confident", "opinionated"]
  },

  "colors": {
    "primary": "#5E6AD2",
    "secondary": ["#FFFFFF", "#F7F8F9"],
    "forbidden": [],
    "background": "#000000",
    "text": "#FFFFFF"
  },

  "typography": {
    "heading_font": "Inter",
    "body_font": "Inter",
    "pairing_descriptor": "single typeface system, weight-differentiated, clean and precise"
  },

  "imagery": {
    "style": "product screenshots with motion",
    "subjects": ["product UI", "workflow animations", "minimal abstract shapes"],
    "composition": "dark backgrounds, centered focal point, generous negative space",
    "forbidden": ["stock photos", "people", "corporate imagery"]
  },

  "aesthetic": {
    "mood_keywords": ["premium", "precise", "minimal"],
    "texture": "minimal",
    "negative_space": "generous"
  },

  "brand_values": ["craftsmanship", "speed", "purposeful design"],

  "target_audience": {
    "age_range": "25-40",
    "profession": "software engineers, product managers, and engineering leaders",
    "pain_points": ["slow, bloated project tools", "context switching", "poor developer experience"],
    "aspirations": ["ship faster", "build excellent products", "reduce project management overhead"]
  }
}
```

---

## 2. Quick Extraction (Homepage Only)

**User Request:**
> "Quick brand profile for https://glossier.com — just the homepage"

**Analysis Steps:**
1. Fetch homepage only via WebFetch
2. Extract available brand elements
3. Note reduced confidence where secondary pages would have helped
4. Write brand-profile.json

**Sample Output:**

```
Brand DNA extracted → brand-profile.json (homepage only — reduced confidence)

  Brand: Glossier
  Voice: friendly, inclusive, effortless
  Primary Color: #F5C6C6
  Typography: Neue Haas Grotesk / system-ui
  Audience: 18-35, beauty-conscious consumers

Note: About and product pages were not analyzed. Voice and value
extraction may be less accurate. Run full extraction for higher confidence.
```

---

## 3. Extraction with Downstream Usage

**User Request:**
> "Extract brand DNA for https://notion.so, then use it to draft a LinkedIn post about their new AI features."

**Analysis Steps:**
1. Run brand DNA extraction → brand-profile.json
2. Hand off to seo-content-writer with brand-profile.json context
3. SEO content writer reads voice axes and descriptors to calibrate tone
4. Draft LinkedIn post matching Notion's brand voice

**Workflow:**
```
Step 1: brand-dna extracts → brand-profile.json
Step 2: seo-content-writer reads brand-profile.json
  → formal_casual: 6 (slightly casual)
  → bold_subtle: 6 (moderate confidence)
  → descriptors: ["approachable", "thoughtful", "empowering"]
Step 3: Draft uses Notion's voice characteristics
  → Approachable but not flippant
  → Feature-focused but benefit-led
  → "We" language, inclusive framing
```

---

## 4. Competitor Brand Comparison

**User Request:**
> "Extract brand DNA for both https://figma.com and https://sketch.com so I can compare their positioning."

**Analysis Steps:**
1. Run brand DNA extraction for Figma → figma-brand-profile.json
2. Run brand DNA extraction for Sketch → sketch-brand-profile.json
3. Compare voice axes, color palettes, imagery styles, and target audiences
4. Summarize positioning differences

**Sample Comparison Output:**

| Dimension | Figma | Sketch |
|-----------|-------|--------|
| Voice: formal_casual | 7 (casual) | 5 (neutral) |
| Voice: bold_subtle | 8 (bold) | 5 (subtle) |
| Voice: traditional_innovative | 9 (innovative) | 6 (moderate) |
| Primary Color | #A259FF (vibrant purple) | #FDB300 (warm yellow) |
| Imagery Style | Product UI with collaboration | Clean product shots, minimal |
| Mood | Energetic, collaborative, bold | Crafted, focused, refined |
| Target | Design teams, cross-functional | Independent designers, Mac users |

**Positioning gap:** Figma leans heavily into collaboration and team workflows. Sketch positions around individual craft and native Mac experience. Content for Figma should emphasize "together" language; content for Sketch should emphasize "your workflow" language.
