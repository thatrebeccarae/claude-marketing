# UTM & Attribution Strategy — Examples

## Example 1: Build UTM Taxonomy from Scratch

### Prompt

> We are starting to track our marketing campaigns properly. Build a UTM naming convention for our team. We use Google Ads, LinkedIn Ads, email (Klaviyo), and organic social (LinkedIn, Twitter).

### What the skill does

1. Creates a documented UTM taxonomy with source, medium, campaign, and content conventions
2. Builds channel-specific templates (Google Ads, LinkedIn Ads, Klaviyo email, organic social)
3. Creates a shared spreadsheet template for the team to log all UTM URLs
4. Maps utm_medium values to GA4 default channel groupings to ensure proper reporting
5. Writes enforcement rules and a QA checklist

---

## Example 2: Attribution Model Selection

### Prompt

> We sell B2B software with a 45-day average sales cycle. Help us choose the right attribution model and set it up in GA4.

### What the skill does

1. Analyzes sales cycle length (45 days > 30-day default lookback window)
2. Recommends extending GA4 lookback window to 90 days
3. Suggests Position-Based model for reporting (values both awareness and conversion)
4. Recommends Data-Driven model if conversion volume supports it (1000+/month)
5. Provides GA4 configuration steps for attribution settings

---

## Example 3: UTM Audit

### Prompt

> Audit our UTM practices. We are seeing a lot of "(other)" traffic in GA4 and our channel data looks messy.

### What the skill does

1. Pulls GA4 source/medium report to identify issues
2. Finds 12 variations of Facebook source (facebook, Facebook, fb, meta, instagram)
3. Finds utm_medium values not recognized by GA4 ("social-media", "paid", "ad")
4. Identifies internal links with UTM parameters (breaking sessions)
5. Produces cleanup plan: standardize naming, fix internal links, create enforcement doc
