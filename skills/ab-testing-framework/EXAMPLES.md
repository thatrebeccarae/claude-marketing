# A/B Testing Framework — Examples

## Example 1: Landing Page Headline Test

### Prompt

> Design an A/B test for our SaaS landing page headline. Current conversion rate is 3.2% with 5,000 visitors/week. We want to test a benefit-focused headline vs our current feature-focused one.

### What the skill does

1. Formulates hypothesis: "Changing headline from feature-focused to benefit-focused will increase signup rate by 20% because benefits resonate more with non-technical buyers"
2. Calculates sample size: baseline 3.2%, MDE 20% → ~14,400 per variation → ~29,000 total → ~6 weeks at 5K/week
3. Designs test: Control ("AI-Powered Analytics Platform") vs Variant ("See What Is Costing You Customers — in 60 Seconds")
4. Specifies: 50/50 split, primary metric = signup rate, secondary = bounce rate
5. Sets decision criteria and pre-registers the analysis plan

---

## Example 2: Analyze Test Results

### Prompt

> Our A/B test finished. Control: 412 conversions from 15,200 visitors. Variant: 478 conversions from 15,100 visitors. Is this significant?

### What the skill does

1. Calculates conversion rates: Control 2.71%, Variant 3.17%
2. Runs Z-test: Z = 2.41, p = 0.016 (statistically significant at 95%)
3. Calculates relative lift: +17.0%
4. Computes confidence interval: 3.1% to 31.8% relative lift
5. Recommendation: Implement variant. 98.4% probability variant is better than control.

---

## Example 3: Low-Traffic Test Strategy

### Prompt

> We only get 800 visitors/month to our pricing page. Can we still A/B test?

### What the skill does

1. Calculates: at 800/month, testing for 20% lift on a 5% conversion rate would take 24+ months — not feasible
2. Recommends alternatives: test for larger effects (50%+ lift), use Bayesian approach for faster reads, test higher-traffic pages first
3. Suggests qualitative research instead: user testing, session recordings, survey
4. Proposes "big swing" tests that could show 50%+ lift (restructure pricing page entirely vs minor copy tweak)
