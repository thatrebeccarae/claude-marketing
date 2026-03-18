# icp-research


# ICP Research

Build comprehensive ideal customer profiles for targeted marketing, including community discovery and voice-of-customer language extraction.

## Workflow

### 1. Gather Product Context

- What do you sell?
- Key features and differentiators
- Pricing model and range
- Current customers (who buys today?)

### 2. Define Market

- Industry / vertical
- Company size (employees, revenue)
- Geography
- B2B vs. B2C vs. B2B2C

### 3. Build Persona

**Demographics:**
- Job title and seniority level
- Department and reporting structure
- Company size and revenue range
- Industry and sub-vertical
- Geography and timezone

**Psychographics:**
- Daily responsibilities (what fills their calendar)
- Goals they are measured on (KPIs, OKRs)
- Frustrations and daily friction
- Career aspirations
- How they stay informed (publications, podcasts, communities)

**Buying Behavior:**
- Who influences the decision?
- Who approves the budget?
- What is the buying process? (self-serve, demo, RFP, committee)
- Evaluation criteria (price, features, support, integration)
- Typical buying timeline

### 4. Map Pain Points

| Category | Questions to Answer |
|----------|-------------------|
| **Time** | What takes too long? What manual work do they hate? |
| **Money** | Where are they wasting budget? What costs too much? |
| **Risk** | What keeps them up at night? What could go wrong? |
| **Quality** | Where is output inconsistent or error-prone? |
| **Growth** | What blocks them from scaling? |

Score each pain point: **Frequency** (1-10) x **Intensity** (1-10) = **Priority Score**

### 5. Identify Objections

| Objection Type | Response Strategy |
|---------------|-------------------|
| **Price** | ROI calculation, cost of inaction, payment flexibility |
| **Time** | Quick setup, done-for-you options, time-to-value metrics |
| **Trust** | Social proof, case studies, free trial/pilot, guarantees |
| **Need** | Cost of status quo, competitor pressure, market trends |
| **Authority** | Executive summary, ROI one-pager, pilot proposal |

### 6. Map Buying Triggers

**External triggers:**
- New funding round or budget cycle
- Leadership change (new CMO, VP)
- Competitor pressure (lost deal, feature gap)
- Regulatory change (compliance deadline)
- Failed vendor or tool (contract end, outage)

**Internal triggers:**
- Missed targets (revenue, growth, efficiency)
- Team complaints (process pain, tool frustration)
- Process breaking at scale
- New initiative requiring new capabilities
- Budget cuts forcing consolidation

### 7. Community Research

Discover where your ICP gathers online and extract their exact language.

**Platforms to search:**
- Reddit (subreddits by industry/role)
- Facebook Groups
- Discord and Slack communities
- LinkedIn Groups
- Quora and Stack Exchange
- Industry forums
- YouTube comments
- App review sites (G2, Capterra, Trustpilot)

**Search templates:**
```
"[industry/role] frustrating OR annoying"
"why is [process] so hard"
"alternatives to [competitor]"
"[tool] vs [tool]"
"best [tool type] for [use case]"
"I switched from [tool] because"
```

**What to extract:**
- Exact phrases and vocabulary they use (voice-of-customer)
- Pain points with emotional language
- Evaluation criteria they mention
- Competitors they compare
- Objections they raise

**Classify community members:**
- **Actively seeking:** ready to buy, asking for recommendations
- **Aware but stuck:** know the problem, not acting on it
- **Venting only:** complaining but unlikely to change

### 8. Craft Messaging Angles

For each pain point, create:
- **Headline:** attention-grabbing statement
- **Supporting proof:** data point, case study, or testimonial
- **CTA:** specific next step

## Output Format

See REFERENCE.md for the complete ICP profile template.

## Key Principles

1. **Real language over marketing language.** Use the exact words your ICP uses, not polished marketing copy.
2. **Pain over features.** Lead with what hurts, not what you built.
3. **Specificity wins.** "VP of Marketing at a 50-person SaaS company" > "Marketing leaders."
4. **Validate with data.** Community research > assumptions.
5. **One ICP per profile.** If you serve different personas, create separate profiles.

For templates and frameworks, see [REFERENCE.md](REFERENCE.md).

---

# ICP Research — Reference

## ICP Profile Template

```markdown
# ICP Profile: [Persona Name]
**Created:** YYYY-MM-DD
**Confidence Level:** High / Medium / Low
**Based on:** [Data sources: interviews, community research, customer data, etc.]

## Demographics
- **Title:** [Job title]
- **Seniority:** [C-level / VP / Director / Manager / IC]
- **Department:** [Marketing / Sales / Ops / Engineering / etc.]
- **Reports to:** [Title]
- **Company size:** [Employees] / [Revenue range]
- **Industry:** [Primary] / [Sub-vertical]
- **Geography:** [Region/Country]

## Day in the Life
[2-3 paragraph narrative of what this person's typical day looks like.
What meetings do they attend? What tools do they use? What frustrates them?
What does success look like at the end of the day?]

## Goals & KPIs
1. [Primary goal they are measured on]
2. [Secondary goal]
3. [Tertiary goal]

## Pain Points (Ranked by Priority Score)

| # | Pain Point | Frequency (1-10) | Intensity (1-10) | Score | Category |
|---|-----------|-------------------|-------------------|-------|----------|
| 1 | [Pain]    | [X]               | [X]               | [XX]  | [Time/Money/Risk/Quality/Growth] |
| 2 | [Pain]    | [X]               | [X]               | [XX]  | [Category] |
| 3 | [Pain]    | [X]               | [X]               | [XX]  | [Category] |

## Objections & Responses

### "[Objection 1]"
- **Type:** Price / Time / Trust / Need / Authority
- **Response:** [2-3 sentences]
- **Proof point:** [Case study, stat, or testimonial]

### "[Objection 2]"
...

## Buying Triggers
**Most likely triggers (in order):**
1. [Trigger] — [Why this triggers action]
2. [Trigger] — [Why this triggers action]
3. [Trigger] — [Why this triggers action]

## Buying Process
- **Timeline:** [Typical length from awareness to purchase]
- **Decision makers:** [Who is involved]
- **Evaluation criteria:** [What they compare on]
- **Preferred buying model:** [Self-serve / Demo / Trial / RFP]

## Community Intelligence
**Where they gather:**
| Platform | Specific Location | Activity Level |
|----------|-------------------|---------------|
| Reddit   | r/[subreddit]     | [High/Med/Low] |
| [Platform] | [Group/Channel] | [Activity] |

**Voice-of-customer quotes:**
> "[Exact quote from community]" — [Source]
> "[Exact quote from community]" — [Source]

**Language patterns:**
- They say "[phrase]" not "[our marketing term]"
- Common vocabulary: [list of terms they use]

## Messaging Angles

### Angle 1: [Name]
- **Pain point addressed:** [Which one]
- **Headline:** [Attention-grabbing statement]
- **Supporting proof:** [Data point or case study]
- **Best channel:** [Where to use this message]

### Angle 2: [Name]
...
```

## Pain Point Scoring Matrix

```
Priority Score = Frequency x Intensity

Score 80-100: Critical — lead with this in all messaging
Score 50-79:  Important — strong supporting message
Score 30-49:  Moderate — mention but don't lead with
Score 1-29:   Minor — omit from primary messaging

Frequency (1-10):
1-3:  Rare (monthly or less)
4-6:  Regular (weekly)
7-9:  Frequent (daily)
10:   Constant (multiple times per day)

Intensity (1-10):
1-3:  Mild annoyance
4-6:  Significant frustration
7-9:  Major pain, actively seeking solution
10:   Hair-on-fire, will pay anything to fix
```

## Objection Handling Frameworks

### LAER Framework

```
Listen:    Acknowledge the objection without defensiveness
Acknowledge: "That's a fair concern. [Paraphrase their worry]."
Explore:   "Can you tell me more about what's driving that?"
Respond:   [Address with proof point, case study, or reframe]
```

### Cost of Inaction Calculator

```
Annual cost of the problem:
  [Hours wasted per week] x [Hourly cost] x 52 = $[Annual waste]
  OR
  [Revenue lost per month] x 12 = $[Annual loss]
  OR
  [Tool cost] + [Opportunity cost] = $[Annual total]

Your solution cost: $[Price]
Net benefit: $[Savings - Price] per year
Payback period: [Months]
```

## Community Research Search Templates

### Reddit

```
site:reddit.com "[industry]" "[pain point]"
site:reddit.com "switched from [competitor]" "[industry]"
site:reddit.com "best [tool type] for" "[use case]"
site:reddit.com "frustrating" "[process or tool]"
```

### G2 / Capterra Reviews

```
site:g2.com "[competitor]" reviews "switched to"
site:capterra.com "[competitor]" "pros and cons"
```

### LinkedIn

```
site:linkedin.com "[job title]" "[pain point or challenge]"
site:linkedin.com "[industry]" "biggest challenge"
```

### General Community Discovery

```
"[industry] community" OR "slack" OR "discord" OR "forum"
"[job title] group" site:facebook.com
"[industry] subreddit" OR "r/[industry]"
```

## Messaging Angle Formulas

### Problem-Agitate-Solution (PAS)

```
Problem:  [State the pain in their language]
Agitate:  [Make it worse — show consequences of not acting]
Solution: [Your product as the resolution]
```

### Before-After-Bridge (BAB)

```
Before:  [Life with the problem]
After:   [Life after solving it]
Bridge:  [How your product gets them there]
```

### Feature-Advantage-Benefit (FAB)

```
Feature:   [What it does]
Advantage: [Why that matters vs. alternatives]
Benefit:   [How it improves their life/work]
```
