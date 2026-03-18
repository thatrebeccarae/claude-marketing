Create polished HTML slide decks and PDF-ready documents for consulting deliverables. Uses the RRBC design system with warm light mode, dark mode cover pages, Lora/Inter/Roboto Mono typography, and data visualization palette. Trigger on 'deck', 'slides', 'presentation', 'pitch deck', 'keynote', 'report', or 'PDF'.


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


(Truncated. See full skill at github.com/thatrebeccarae/claude-marketing)
