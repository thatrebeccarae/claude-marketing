# CRO Auditor — Examples

## Example 1: Landing Page Audit

### Prompt

> Audit our SaaS landing page. Current conversion rate is 1.8% from paid traffic. We want to hit 4%.

### What the skill does

1. Runs LIFT Model heuristic evaluation on each above-the-fold element
2. Identifies 5 issues:
   - Headline is feature-focused ("AI-Powered Analytics") instead of benefit-focused
   - CTA says "Get Started" (generic) — should be "Start Free 14-Day Trial"
   - No social proof visible above the fold
   - 3 competing CTAs in the hero section
   - Form asks for phone number (unnecessary for free trial)
3. Scores each fix with ICE framework
4. Produces A/B test hypotheses for top 3 recommendations

---

## Example 2: Checkout Funnel Analysis

### Prompt

> Our e-commerce checkout has a 68% abandonment rate. Diagnose where users are dropping off and what to fix.

### What the skill does

1. Maps the funnel: Cart (100%) -> Shipping (72%) -> Payment (48%) -> Confirmation (32%)
2. Identifies the biggest drop-off: Shipping to Payment (24 percentage points lost)
3. Diagnoses root causes: unexpected shipping costs revealed on payment page, no guest checkout option, form requires 14 fields
4. Produces prioritized fixes with ICE scores and estimated revenue impact

---

## Example 3: Form Optimization

### Prompt

> Our lead gen form has a 6% completion rate. The form has 8 fields. Help us improve it.

### What the skill does

1. Audits each field for necessity (name, email, phone, company, title, size, budget, message)
2. Recommends reducing to 3 fields (name, email, company) — estimates 15-20% completion rate
3. Suggests progressive profiling: collect additional data after initial conversion
4. Provides inline validation patterns and error message best practices
5. Generates A/B test plan: 8-field vs 3-field form
