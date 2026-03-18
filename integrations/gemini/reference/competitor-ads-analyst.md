# competitor-ads-analyst


# Competitor Ads Analyst

Analyze competitor advertising from public ad libraries to understand what messaging, creative formats, and positioning strategies are working.

## Core Capabilities

- Extract ads from public ad libraries (Facebook, Google, TikTok, LinkedIn)
- Categorize ad creative by format, message type, and funnel stage
- Identify pain points competitors highlight (with frequency scoring)
- Map competitor positioning and find white space
- Extract headline and copy formulas
- Track creative format trends (UGC, before/after, testimonial, etc.)
- Generate competitive intelligence reports and swipe files

## Ad Library Access

| Platform | URL | Access |
|----------|-----|--------|
| Meta (Facebook/Instagram) | facebook.com/ads/library | Free, public |
| Google Ads | adstransparency.google.com | Free, public |
| TikTok | library.tiktok.com | Free, public |
| LinkedIn | linkedin.com/ad-library | Requires account |

## Workflow

### 1. Define Scope

- **Competitors:** 3-5 companies to analyze
- **Timeframe:** Last 30, 60, or 90 days
- **Platforms:** Which ad libraries to search
- **Focus:** Messaging, creative format, audience targeting, or all

### 2. Extract Ads

For each competitor, collect:
- Ad copy (headline, primary text, CTA)
- Creative format (image, video, carousel, UGC)
- Landing page URL
- Active date range (if visible)
- Platform and placement

### 3. Categorize

Classify each ad by:

**Message Type:**
- Pain point (problem-aware)
- Solution (product-aware)
- Social proof (testimonial, case study, press)
- Offer (discount, free trial, demo)
- Educational (how-to, tip, guide)
- Brand (awareness, positioning)

**Funnel Stage:**
- Top (awareness, problem education)
- Middle (consideration, comparison)
- Bottom (conversion, offer, urgency)

**Creative Format:**
- Static image
- Video (short <15s, medium 15-60s, long >60s)
- Carousel
- UGC-style
- Before/after
- Screenshot/product demo
- Testimonial quote card
- Data/stat visualization

### 4. Analyze Patterns

- **Pain point frequency:** Which problems appear most across competitors?
- **Message clustering:** Are competitors saying the same things?
- **Format preferences:** Which creative types are most used?
- **Positioning map:** Where does each competitor sit on key dimensions?
- **Gaps:** What messages/angles are NO competitors using?

### 5. Generate Output

Choose from: competitive report, swipe file, messaging matrix, or creative brief.

## Key Principles

1. **Analyze patterns, not individual ads.** One ad is an anecdote; 20 ads from 5 competitors is intelligence.
2. **Look for gaps, not just patterns.** The most valuable finding is what competitors are NOT saying.
3. **Separate observation from recommendation.** Report what you see, then separately recommend what to do with it.
4. **Date everything.** Competitive intelligence decays fast.
5. **Never copy, always adapt.** The goal is informed inspiration, not plagiarism.

For analysis frameworks and output templates, see [REFERENCE.md](REFERENCE.md).

---

# Competitor Ads Analyst — Reference

## Messaging Categorization Taxonomy

### Pain Point Categories

| Category | Description | Examples |
|----------|-------------|---------|
| Time | Manual work, slow processes | "Stop spending hours on reports" |
| Money | Budget waste, expensive tools | "You're overpaying for email marketing" |
| Complexity | Too many tools, hard to use | "One platform, not twenty" |
| Results | Poor performance, missed goals | "Your campaigns aren't converting because..." |
| Scale | Growth blockers, capacity limits | "Built for teams that outgrew spreadsheets" |
| Risk | Compliance, security, reliability | "Enterprise-grade security, startup simplicity" |
| Knowledge | Lack of expertise, uncertainty | "No data science team required" |

### Value Proposition Categories

| Category | Description | Examples |
|----------|-------------|---------|
| Speed | Faster execution or results | "Launch campaigns in minutes, not days" |
| Savings | Cost reduction or ROI | "Save $X/month vs. [competitor]" |
| Simplicity | Ease of use | "So simple your intern could run it" |
| Power | Advanced features, capabilities | "The most powerful segmentation engine" |
| Integration | Works with existing stack | "Connects to 200+ tools" |
| Support | Service and reliability | "24/7 support, 99.9% uptime" |
| Innovation | AI, automation, cutting-edge | "AI-powered recommendations" |

## Creative Format Taxonomy

### Static Image Formats

| Format | Description | Best For |
|--------|-------------|----------|
| Product shot | Clean product on colored bg | Bottom funnel, retargeting |
| Lifestyle | Product in use / context | Top funnel, awareness |
| Quote card | Testimonial on branded bg | Social proof |
| Stat graphic | Large number + context | Data-driven claims |
| Comparison | Side-by-side vs. competitor | Middle funnel |
| Screenshot | Product UI or dashboard | Demo, feature highlight |
| Meme/cultural | Pop culture reference | Top funnel, engagement |

### Video Formats

| Format | Length | Best For |
|--------|--------|----------|
| UGC testimonial | 15-30s | Social proof, bottom funnel |
| Product demo | 30-60s | Feature education, middle funnel |
| Problem/solution | 15-30s | Pain point awareness |
| Before/after | 15-30s | Transformation proof |
| Founder story | 30-90s | Brand building |
| Tutorial/how-to | 60-120s | Education, top funnel |

## Competitive Positioning Template

### 2x2 Positioning Map

```
Y-Axis Label (e.g., "Feature Depth")
    ^
    |
    |  [Competitor A]        [Competitor B]
    |
    |         [YOUR BRAND]
    |
    |  [Competitor C]        [Competitor D]
    |
    +---------------------------------> X-Axis Label (e.g., "Price")
```

**Common axis pairs:**
- Price vs. Feature depth
- Ease of use vs. Power/flexibility
- SMB focus vs. Enterprise focus
- Specialist vs. Generalist
- Self-serve vs. Managed service

### Messaging Matrix

| Pain Point | Competitor A | Competitor B | Competitor C | You | Gap? |
|------------|-------------|-------------|-------------|-----|------|
| [Pain 1]   | Primary msg | Mentioned   | Not used    | ?   | ?    |
| [Pain 2]   | Not used    | Primary msg | Secondary   | ?   | ?    |
| [Pain 3]   | Secondary   | Not used    | Not used    | ?   | Yes  |

### Competitive Intelligence Report Template

```markdown
# Competitive Ads Analysis: [Industry/Category]
**Period:** [Date range]
**Competitors analyzed:** [Count]
**Total ads reviewed:** [Count]
**Platforms:** [List]

## Executive Summary
- [Top 3 findings]

## Competitor Profiles

### [Competitor A]
- **Primary message:** [One-line summary]
- **Pain points targeted:** [List with frequency]
- **Creative formats:** [Most used formats]
- **Estimated volume:** [# of active ads]
- **Notable:** [Anything unusual or innovative]

### [Competitor B]
...

## Pattern Analysis

### Pain Point Frequency
| Pain Point | Frequency (% of ads) | Top User |
|------------|----------------------|----------|

### Creative Format Distribution
| Format | % of Total | Trend |
|--------|-----------|-------|

### Messaging Clusters
[Which competitors are saying similar things?]

## Gaps & Opportunities
- **Unaddressed pain points:** [What no one is talking about]
- **Underused formats:** [Creative types competitors ignore]
- **Positioning white space:** [Where no competitor sits on the map]

## Recommendations
1. [Specific recommendation with rationale]
2. [Specific recommendation with rationale]
3. [Specific recommendation with rationale]
```

## Swipe File Format

```markdown
## [Competitor Name] — [Platform]

### Ad #1
- **Headline:** [Text]
- **Primary text:** [Text]
- **CTA:** [Button text]
- **Format:** [Image/Video/Carousel]
- **Message type:** [Pain point/Solution/Social proof/Offer]
- **Funnel stage:** [Top/Middle/Bottom]
- **Landing page:** [URL]
- **Active since:** [Date if available]
- **Notes:** [What makes this ad notable]
```
