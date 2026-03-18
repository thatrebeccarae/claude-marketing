# frontend-design


# Frontend Design

Create distinctive, production-grade web interfaces that avoid generic AI aesthetics.

## Design Thinking Process

### 1. Understand Context

Before writing code, answer:
- **Purpose:** What problem does this interface solve? Who uses it?
- **Audience:** Technical sophistication, expectations, emotional state when arriving
- **Constraints:** Framework requirements, browser support, performance budget, accessibility needs

### 2. Commit to an Aesthetic Direction

Choose a specific point of view — not "clean and modern" but a real aesthetic:

| Direction | Characteristics |
|-----------|----------------|
| Brutally minimal | Monochrome, system fonts, stark spacing, no decoration |
| Maximalist | Dense, layered, multiple type scales, rich texture |
| Retro-futuristic | Neon accents, dark backgrounds, grid lines, monospace |
| Organic/natural | Soft shapes, earth tones, hand-drawn elements, warm |
| Luxury/refined | Thin serifs, generous whitespace, muted palette, restrained |
| Playful/toy-like | Rounded shapes, bright primaries, bouncy animations |
| Editorial/magazine | Strong grid, dramatic type hierarchy, pull quotes |
| Brutalist/raw | Exposed structure, monospace, raw HTML feeling |
| Art deco/geometric | Symmetry, metallic accents, decorative borders, angular |
| Soft/pastel | Light palette, gentle gradients, rounded, approachable |
| Industrial/utilitarian | Exposed grid, status indicators, dense information |

### 3. Identify the Memorable Thing

Every interface should have one element someone remembers:
- An unexpected interaction
- A distinctive type treatment
- A bold color choice
- An animation that surprises
- A layout that breaks convention

### 4. Execute with Intentionality

The key is commitment, not intensity. Maximalism executed fully works. Minimalism executed with precision works. The mushy middle does not.

## Typography

### Principles

- Choose distinctive fonts, NOT defaults (avoid Arial, Inter, Roboto for display use)
- Pair a display font (personality) with a body font (readability)
- Size hierarchy: display (48-96px), heading (24-36px), body (16-18px), small (12-14px)
- Tight letter-spacing on large display text (-0.02 to -0.04em)
- Normal or slightly loose spacing on body text

### Free Font Sources

| Source | Best For |
|--------|----------|
| Google Fonts | Widest selection, easy CDN |
| Fontshare | High-quality display fonts |
| Fontsource | Self-hosted, npm installable |
| Atipo Foundry | Distinctive display faces |

### Pairing Strategy

| Display | Body | Vibe |
|---------|------|------|
| Serif (dramatic) | Sans-serif (clean) | Editorial, luxury |
| Geometric sans | Humanist sans | Modern, friendly |
| Monospace | System sans | Technical, brutalist |
| Slab serif | Neutral sans | Bold, structured |
| Handwritten/display | Geometric sans | Playful, creative |

## Color & Theme

### Building a Palette

1. Start with one dominant color (the mood-setter)
2. Add 1-2 accent colors (for interaction, emphasis)
3. Define neutral scale (backgrounds, borders, text)
4. Add semantic colors (success, warning, error)
5. Store everything in CSS custom properties

```css
:root {
  --color-primary: #...;
  --color-accent: #...;
  --color-bg: #...;
  --color-surface: #...;
  --color-text: #...;
  --color-text-secondary: #...;
  --color-border: #...;
}
```

### Rules

- Dominant + accent, not evenly distributed
- WCAG AA contrast minimum (4.5:1 for text, 3:1 for large text)
- Dark vs. light: commit fully. Do not hedge.
- Test with real content, not lorem ipsum

## Motion & Animation

### CSS Transitions (Micro-interactions)

```css
.button {
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}
.button:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}
```

### CSS @keyframes (Ambient)

```css
@keyframes float {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-10px); }
}
.floating-element { animation: float 3s ease-in-out infinite; }
```

### Scroll-Triggered (IntersectionObserver)

```javascript
const observer = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.classList.add('visible');
    }
  });
}, { threshold: 0.1 });

document.querySelectorAll('.animate-on-scroll').forEach(el => observer.observe(el));
```

### Staggered Reveals

```css
.stagger-item { opacity: 0; transform: translateY(20px); transition: all 0.5s ease; }
.stagger-item.visible { opacity: 1; transform: translateY(0); }
.stagger-item:nth-child(1) { transition-delay: 0s; }
.stagger-item:nth-child(2) { transition-delay: 0.1s; }
.stagger-item:nth-child(3) { transition-delay: 0.2s; }
```

### Performance

- Animate only `transform` and `opacity` (GPU-composited)
- Avoid animating `width`, `height`, `margin`, `padding` (trigger layout)
- Use `will-change` sparingly and only on elements that will animate
- Prefer CSS over JS for simple animations
- Use `prefers-reduced-motion` media query for accessibility

## Spatial Composition

- Break out of the centered-content-column default
- Use asymmetry and grid-breaking elements intentionally
- Overlap elements with z-index for depth
- Generous negative space OR controlled density — commit to one
- CSS Grid for complex layouts, Flexbox for component alignment

## Code Quality

- Semantic HTML (nav, main, article, section, aside, footer)
- Accessible: ARIA labels, keyboard navigation, focus management
- Responsive: mobile-first or fluid, tested at 320-1440px
- Performance: lazy loading images, efficient selectors, minimal JS
- No external dependencies unless essential (CDN fonts are fine)

## Anti-Patterns

- Generic AI aesthetics (purple gradients everywhere, glassmorphism on everything)
- Cookie-cutter component libraries used without customization
- Predictable layouts (hero → 3-column → testimonials → CTA)
- "Clean and modern" as the entire design direction
- Overused fonts (Inter, Poppins for display)
- Decorative elements without purpose
- Rounded everything (a specific choice is fine, but default rounding is lazy)
- Dark mode with neon accents (overdone)

For typography pairings, color construction, animation library, and accessibility checklist, see [REFERENCE.md](REFERENCE.md).

## Brand Context (Optional)

If `brand-profile.json` exists in the working directory, read it before designing. Use colors (primary, secondary, background, text) for the design system, typography (heading and body fonts) for type selections, aesthetic (mood keywords, texture, negative space) for layout decisions, and imagery (style, composition) for hero sections and visual elements. This profile is produced by the `brand-dna` skill.

---

# Frontend Design — Reference

## Typography Pairing Library

### Editorial / Luxury

```css
/* Playfair Display + Source Sans 3 */
@import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Source+Sans+3:wght@400;600&display=swap');

:root {
  --font-display: 'Playfair Display', Georgia, serif;
  --font-body: 'Source Sans 3', system-ui, sans-serif;
}
```

### Modern / Geometric

```css
/* Space Grotesk + Inter */
@import url('https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;500;700&family=Inter:wght@400;500;600&display=swap');

:root {
  --font-display: 'Space Grotesk', system-ui, sans-serif;
  --font-body: 'Inter', system-ui, sans-serif;
}
```

### Technical / Brutalist

```css
/* JetBrains Mono + System UI */
@import url('https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;700&display=swap');

:root {
  --font-display: 'JetBrains Mono', monospace;
  --font-body: system-ui, -apple-system, sans-serif;
}
```

### Bold / Expressive

```css
/* Clash Display (Fontshare) + Switzer (Fontshare) */
@import url('https://api.fontshare.com/v2/css?f[]=clash-display@400;600;700&f[]=switzer@400;500&display=swap');

:root {
  --font-display: 'Clash Display', system-ui, sans-serif;
  --font-body: 'Switzer', system-ui, sans-serif;
}
```

### Warm / Friendly

```css
/* DM Serif Display + DM Sans */
@import url('https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=DM+Sans:wght@400;500;700&display=swap');

:root {
  --font-display: 'DM Serif Display', Georgia, serif;
  --font-body: 'DM Sans', system-ui, sans-serif;
}
```

## Color Palette Construction

### From a Single Dominant Color

```css
:root {
  /* Start with your dominant color */
  --color-primary: #2563eb;

  /* Derive lighter/darker variants */
  --color-primary-light: #60a5fa;
  --color-primary-dark: #1d4ed8;

  /* Complementary accent (opposite on color wheel) */
  --color-accent: #f59e0b;

  /* Neutral scale (desaturated version of primary) */
  --color-gray-50: #f8fafc;
  --color-gray-100: #f1f5f9;
  --color-gray-200: #e2e8f0;
  --color-gray-300: #cbd5e1;
  --color-gray-400: #94a3b8;
  --color-gray-500: #64748b;
  --color-gray-600: #475569;
  --color-gray-700: #334155;
  --color-gray-800: #1e293b;
  --color-gray-900: #0f172a;

  /* Semantic */
  --color-success: #22c55e;
  --color-warning: #f59e0b;
  --color-error: #ef4444;
}
```

### Palette Strategies

| Strategy | Description | When to Use |
|----------|-------------|-------------|
| Monochromatic | One hue, vary lightness/saturation | Minimal, elegant, focused |
| Complementary | Two opposite hues | High contrast, energetic |
| Analogous | Three adjacent hues | Harmonious, natural |
| Split-complementary | One hue + two adjacent to its complement | Vibrant but balanced |
| Triadic | Three equidistant hues | Bold, playful |

## Animation Pattern Library

### Page Load Sequence

```css
@keyframes fadeUp {
  from { opacity: 0; transform: translateY(30px); }
  to { opacity: 1; transform: translateY(0); }
}

.hero-title { animation: fadeUp 0.8s ease forwards; }
.hero-subtitle { animation: fadeUp 0.8s ease 0.15s forwards; opacity: 0; }
.hero-cta { animation: fadeUp 0.8s ease 0.3s forwards; opacity: 0; }
```

### Hover Card Lift

```css
.card {
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}
.card:hover {
  transform: translateY(-4px);
  box-shadow: 0 12px 24px rgba(0,0,0,0.1);
}
```

### Magnetic Button (JS)

```javascript
const btn = document.querySelector('.magnetic-btn');
btn.addEventListener('mousemove', (e) => {
  const rect = btn.getBoundingClientRect();
  const x = e.clientX - rect.left - rect.width / 2;
  const y = e.clientY - rect.top - rect.height / 2;
  btn.style.transform = `translate(${x * 0.3}px, ${y * 0.3}px)`;
});
btn.addEventListener('mouseleave', () => {
  btn.style.transform = 'translate(0, 0)';
  btn.style.transition = 'transform 0.3s ease';
});
```

### Text Reveal (Character by Character)

```css
.char {
  display: inline-block;
  opacity: 0;
  transform: translateY(20px);
  animation: charReveal 0.4s ease forwards;
}
@keyframes charReveal {
  to { opacity: 1; transform: translateY(0); }
}
/* Apply via JS: split text into spans, stagger animation-delay */
```

### Smooth Scroll Sections

```css
html { scroll-behavior: smooth; scroll-snap-type: y mandatory; }
section { scroll-snap-align: start; min-height: 100vh; }
```

### Gradient Background Shift

```css
@keyframes gradientShift {
  0% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
  100% { background-position: 0% 50%; }
}
.gradient-bg {
  background: linear-gradient(-45deg, #ee7752, #e73c7e, #23a6d5, #23d5ab);
  background-size: 400% 400%;
  animation: gradientShift 15s ease infinite;
}
```

## Background & Texture Patterns

### Noise Texture (CSS)

```css
.noise::after {
  content: "";
  position: fixed;
  inset: 0;
  background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.65' numOctaves='3' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)'/%3E%3C/svg%3E");
  opacity: 0.03;
  pointer-events: none;
  z-index: 9999;
}
```

### Grid Pattern

```css
.grid-bg {
  background-image:
    linear-gradient(rgba(255,255,255,0.05) 1px, transparent 1px),
    linear-gradient(90deg, rgba(255,255,255,0.05) 1px, transparent 1px);
  background-size: 40px 40px;
}
```

### Dot Pattern

```css
.dot-bg {
  background-image: radial-gradient(circle, rgba(0,0,0,0.1) 1px, transparent 1px);
  background-size: 20px 20px;
}
```

## Accessibility Checklist

### Color & Contrast
- [ ] Text contrast ratio meets WCAG AA (4.5:1 normal, 3:1 large text)
- [ ] Information is not conveyed by color alone
- [ ] Focus indicators are visible (not just outline: none)
- [ ] Tested with grayscale filter

### Keyboard Navigation
- [ ] All interactive elements reachable via Tab
- [ ] Tab order follows visual layout
- [ ] Focus styles are visible and intentional
- [ ] Modal traps focus within the modal
- [ ] Escape key closes modals/overlays

### Screen Readers
- [ ] Semantic HTML used (nav, main, article, etc.)
- [ ] Images have descriptive alt text
- [ ] Form inputs have associated labels
- [ ] ARIA labels on icon-only buttons
- [ ] Landmark roles present (navigation, main, complementary)

### Motion
- [ ] `prefers-reduced-motion` media query respected
- [ ] Essential animations have reduced-motion alternatives
- [ ] No auto-playing video without user control
- [ ] Parallax/scroll effects have fallbacks

```css
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
}
```

## Responsive Breakpoints

```css
/* Mobile first */
/* Default: 0-639px (mobile) */

@media (min-width: 640px)  { /* sm: tablet portrait */ }
@media (min-width: 768px)  { /* md: tablet landscape */ }
@media (min-width: 1024px) { /* lg: desktop */ }
@media (min-width: 1280px) { /* xl: large desktop */ }
@media (min-width: 1536px) { /* 2xl: ultrawide */ }
```

## Performance Checklist

- [ ] Images lazy loaded (`loading="lazy"`)
- [ ] Fonts preloaded (`<link rel="preload" as="font">`)
- [ ] CSS above the fold is inlined
- [ ] No render-blocking JS in `<head>`
- [ ] Images sized correctly (no 4000px images in 400px containers)
- [ ] Web fonts limited to 2-3 families, subset if possible
- [ ] Animations use transform/opacity only
- [ ] No layout shifts on load (CLS)
