---
name: creative-pack
title: Creative & Design Pack
description: 3 skills for frontend interfaces, technical diagrams, and programmatic video.
skills:
  - frontend-design
  - tech-diagram
  - remotion-video
---

<div align="center">

# Creative & Design Pack

**3 skills for frontend interfaces, technical diagrams, and programmatic video.**

[![GitHub stars](https://img.shields.io/github/stars/thatrebeccarae/claude-marketing?style=for-the-badge&logo=github&color=181717)](https://github.com/thatrebeccarae/claude-marketing/stargazers)
[![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)](../LICENSE)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Rebecca%20Rae%20Barton-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/rebeccaraebarton)
[![Substack](https://img.shields.io/badge/Substack-dgtl%20dept*-FF6719?style=for-the-badge&logo=substack&logoColor=white)](https://dgtldept.substack.com/welcome)

Design, diagram, and animate — all code, no Figma.

[**Back to Repo**](../README.md)

</div>

---

## Who This Is For

- **Solo operators** who need a landing page or product page without hiring a designer
- **Developers** documenting system architecture who want diagrams that aren't draw.io screenshots
- **Marketing teams** producing product demos, social video content, or animated explainers programmatically

## What's Included

<!-- SKILLS-TABLE-START -->
| Skill | What It Does | Includes |
|-------|-------------|----------|
| **[frontend-design](../skills/frontend-design/)** | Create distinctive, production-grade frontend interfaces with high design quality. Covers design thinking, typography pairing, color theory, motion design, spatial composition, and code quality. Generates real working code — HTML/CSS/JS or React — with intentional aesthetic direction, not generic AI output. | SKILL + REFERENCE + EXAMPLES |
| **[tech-diagram](../skills/tech-diagram/)** | Generate technical architecture diagrams, pipeline flows, layer/stack diagrams, and system illustrations as standalone HTML files. Uses a dark-mode design system with embedded CSS and inline SVG. Use when the user needs architecture diagrams, system illustrations, flow charts, or technical visualizations. | SKILL + REFERENCE + EXAMPLES |
| **[remotion-video](../skills/remotion-video/)** | Remotion video production best practices — spring animations, interpolation patterns, SVG draw-on effects, scene transitions, chart animations, audio integration, and rendering. Use when building programmatic videos with Remotion, creating animated content, or producing marketing videos with code. | SKILL + REFERENCE + EXAMPLES |
<!-- SKILLS-TABLE-END -->

## How the Skills Connect

Three independent jobs-to-be-done that happen to share a creative production focus:

- **Build a launch page** → Frontend Design
- **Document your system architecture** → Tech Diagram
- **Produce a product demo or social clip** → Remotion Video

They can also work together: generate architecture visuals with **Tech Diagram** and embed them in a **Frontend Design** page, or produce animated product demos with **Remotion Video** using the same design tokens established in **Frontend Design**.

## Quick Start

<!-- INSTALL-CMD-START -->
```bash
cd claude-marketing
for skill in frontend-design tech-diagram remotion-video; do
  cp -r "skills/$skill" ~/.claude/skills/
done
```
<!-- INSTALL-CMD-END -->

No API keys required. Remotion Video requires Node.js and the Remotion package for rendering.

## Example Prompts

### Frontend Design
- "Build a landing page for a marketing analytics SaaS — editorial aesthetic, not template"
- "Create a portfolio site with a brutalist, raw technical feel"
- "Design a product page for a luxury candle brand — refined, no urgency tactics"

### Tech Diagram
- "Diagram our data pipeline: S3 → Lambda → Redshift → Looker"
- "Create a system architecture diagram for our microservices stack"
- "Build a timeline diagram showing our migration phases"

### Remotion Video
- "Create a 30-second product demo video with spring animations"
- "Build an animated chart video showing our quarterly growth metrics"
- "Produce a social media intro clip with logo animation and text reveals"

## FAQ

<details>
<summary><strong>Does Frontend Design output code that's ready to ship?</strong></summary>

Yes. The skill produces complete HTML/CSS with specific typography choices, color palettes, and layout systems. The output works on static hosting (GitHub Pages, Netlify, Vercel) or as a starting point for React/Next.js projects. It's not a wireframe or mockup — it's working code.

</details>

<details>
<summary><strong>What makes Frontend Design different from asking Claude to build a website?</strong></summary>

The skill loads an aesthetic direction framework with typography pairing libraries, color construction rules, animation patterns, and spatial composition guidelines. Without it, Claude tends to default to generic layouts with safe font choices. With it, Claude commits to a specific design point of view — brutalist, editorial, luxury, industrial — and follows through consistently.

</details>

<details>
<summary><strong>Do the diagrams require any external tools?</strong></summary>

No. Tech Diagram outputs standalone HTML files — no Mermaid, no draw.io, no external dependencies. Open in a browser, screenshot for documentation, or embed directly.

</details>

## License

MIT — see [LICENSE](../LICENSE) for details.
