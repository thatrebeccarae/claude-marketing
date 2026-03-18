# Shared References

Cross-skill reference files used by multiple skills. These provide shared conventions and data that individual skills load on demand.

## Files

| File | Purpose | Used By |
|------|---------|---------|
| `scoring-system.md` | Weighted audit scoring algorithm, severity multipliers, grade thresholds, output format | All audit-oriented skills (google-ads, facebook-ads, microsoft-ads, account-structure-review, wasted-spend-finder) |

## Usage

Skills reference shared files via relative path: `skills/shared/scoring-system.md`. Load at audit invocation alongside the skill-specific `CHECKS.md`.

See [CONTRIBUTING.md](../../CONTRIBUTING.md) for the full shared reference and CHECKS.md conventions.
