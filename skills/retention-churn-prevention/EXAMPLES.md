# Retention & Churn Prevention — Examples

## Example 1: Build Churn Early Warning System
### Prompt
> Design a customer health scoring system for our SaaS product. We have login data, feature usage, support tickets, and billing info.

### What the skill does
1. Designs health score with weighted signals (usage 25%, feature depth 20%, support 15%, billing 15%, engagement 15%, NPS 10%)
2. Defines thresholds: Green (80-100), Yellow (50-79), Red (0-49)
3. Creates alert triggers for each risk level with recommended CS actions
4. Proposes automated intervention playbook for Yellow and Red accounts

---

## Example 2: Win-Back Campaign
### Prompt
> Design a win-back campaign for churned users. We had 340 cancellations last quarter. Top exit reasons: too expensive (40%), not using it enough (35%), switched to competitor (25%).

### What the skill does
1. Segments churned users by exit reason
2. Designs 3 win-back sequences (one per exit reason): discount offer for price-sensitive, new feature showcase for low-usage, comparison content for competitor-switched
3. Sets timing: Day 1, 7, 14, 30 cadence
4. Estimates recovery: 8-12% of price-sensitive, 5-8% of low-usage, 2-3% of competitor-switched

---

## Example 3: Cohort Retention Analysis
### Prompt
> Analyze our monthly cohort retention curves. January cohort retained 68% at month 3, but March cohort only retained 52%.

### What the skill does
1. Compares cohort curves to identify where March diverges from January
2. Investigates variables: onboarding changes, product updates, traffic source mix, seasonal factors
3. Identifies root cause: March cohort had 60% from paid ads (vs January 30%) with lower intent
4. Recommends: segment retention by acquisition channel, improve paid traffic onboarding, tighten ICP targeting
