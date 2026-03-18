Unified multi-platform paid media audit with parallel execution. Spawns scored audits for Google Ads, Meta Ads, and Microsoft Ads simultaneously, merges results into a budget-weighted aggregate health score (A-F), adds cross-platform analysis (budget allocation, tracking consistency, creative alignment, attribution overlap), and produces a prioritized action plan. Optionally generates a client-ready deck via pro-deck-builder. Use when the user asks for a full paid media audit, cross-platform review, or multi-channel ad assessment.


# Cross-Platform Audit — Unified Paid Media Assessment

Orchestrates parallel scored audits across Google Ads, Meta Ads, and Microsoft Ads, then merges results into a single budget-weighted health score with cross-platform intelligence.

## Context Intake (Always Do First)

Before running audits, collect this information. Without it, benchmarks will be generic and recommendations may be wrong.

Ask these questions (combine into one prompt):

1. **Business type** — E-commerce/DTC, SaaS/B2B, Local Service, Lead Gen, Agency, Other
2. **Monthly ad spend** — Total and per-platform breakdown (approximate is fine)
3. **Primary goal** — Revenue/ROAS, Leads/CPA, App Installs, Brand Awareness
4. **Active platforms** — Which platforms are they advertising on? (Google, Meta, Microsoft, others)
5. **Data available** — What can they provide? (exports, screenshots, pasted metrics, MCP access)

Use the provided context to:
- Determine which platform audits to run (skip platforms they don't use)
- Calculate budget share per platform for aggregate scoring
- Calibrate severity based on spend level ($5K/mo gets different advice than $100K/mo)

## Orchestration Workflow

### Step 1: Collect Context
Gather business type, platforms, budgets, goals, and available data per the intake above.

### Step 2: Spawn Parallel Audits

Use the Task tool to run platform audits simultaneously. Each audit task should:

1. Load `skills/shared/scoring-system.md` for the scoring algorithm
2. Load the platform-specific `CHECKS.md` for the audit checklist
3. Load the platform-specific `SKILL.md` and `REFERENCE.md` for diagnostic context
4. Evaluate each applicable check as PASS, WARNING, or FAIL
5. Calculate the platform health score using weighted formula
6. Identify Quick Wins
7. Write results to a structured output

**Spawn these tasks in parallel** (adjust based on which platforms the user has):

```
Task 1: Google Ads Audit
  → Read skills/shared/scoring-system.md
  → Read skills/google-ads/CHECKS.md
  → Evaluate 74 checks against provided data
  → Calculate score → Write google-audit-results.md

Task 2: Meta Ads Audit
  → Read skills/shared/scoring-system.md
  → Read skills/facebook-ads/CHECKS.md
  → Evaluate 46 checks against provided data
  → Calculate score → Write meta-audit-results.md

Task 3: Microsoft Ads Audit
  → Read skills/shared/scoring-system.md
  → Read skills/microsoft-ads/CHECKS.md
  → Evaluate 30 checks against provided data
  → Calculate score → Write microsoft-audit-results.md
```

If the user only has 2 platforms, spawn only those 2 tasks.

### Step 3: Merge Results

After all audit tasks complete:


(Truncated. See full skill at github.com/thatrebeccarae/claude-marketing)
