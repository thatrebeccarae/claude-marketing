# Getting Started with the Paid Media Pack

A step-by-step guide to setting up the Paid Media Pack for Claude Code. No terminal experience required -- this guide explains everything in plain English.

## What This Pack Does

This skill pack gives Claude Code deep expertise in the platforms paid media teams use every day:

| Skill | What Claude Can Do |
|-------|-------------------|
| **Google Ads** | Audit campaigns, diagnose Quality Scores, optimize bidding strategies, review PMax and Shopping, analyze search terms, find wasted spend |
| **Meta Ads** | Audit Facebook/Instagram campaigns, diagnose creative fatigue, review pixel/CAPI health, evaluate Advantage+ readiness, design full-funnel structures |
| **Microsoft Ads** | Audit Bing campaigns, optimize Google Ads imports, set up LinkedIn Profile Targeting, review UET tracking, plan Shopping campaigns |
| **Account Structure Review** | Cross-platform structural audit — conversion volume thresholds, budget fragmentation, targeting overlap, consolidation roadmaps |

## Prerequisites

Before you start, you'll need:

1. **Claude Code** installed and running ([installation guide](https://docs.anthropic.com/en/docs/claude-code))
2. **Python 3.9 or newer** installed on your computer
3. **API keys** for the platforms you use (instructions below)

You do NOT need all API keys. Set up only the skills for platforms you actually use. Account Structure Review needs no API keys — it's analysis-only.

## Quick Start (Automated)

The fastest way to get set up is the interactive wizard:

```bash
python skill-packs/scripts/setup-paid-media.py
```

The wizard will:
1. Check your Python version and required tools
2. Ask which skills you want to configure
3. Walk you through getting each API key (with links and instructions)
4. Create the configuration files automatically
5. Install required Python packages
6. Test that each API connection works

If you prefer to set things up manually, follow the steps below.

## Manual Setup

### Step 1: Get Your API Keys

Only get keys for the platforms you use. Each key takes 2-10 minutes.

#### Google Ads
1. Go to [Google Cloud Console](https://console.cloud.google.com)
2. Create a project (or select existing)
3. Enable the **Google Ads API**
4. Go to **APIs & Services** > **Credentials** > **Create Credentials** > **OAuth 2.0 Client**
5. Download the credentials JSON file
6. Apply for a **Developer Token** at the [Google Ads API Center](https://ads.google.com/aw/apicenter)
7. Find your **Customer ID** in the top-right corner of the Google Ads UI (10-digit number)

#### Meta Ads (Facebook & Instagram)
1. Go to [Facebook Business Settings](https://business.facebook.com)
2. Navigate to **Users** > **System Users** > **Add**
3. Create a System User with **ads_management** and **ads_read** permissions
4. Click **Generate New Token** and copy it
5. Find your **Ad Account ID** under **Accounts** > **Ad Accounts** (starts with `act_`)
6. Find your **Pixel ID** in **Events Manager** > **Data Sources**

#### Microsoft Ads
1. Go to [Azure Portal](https://portal.azure.com) > **App registrations** > **New registration**
2. Add **Microsoft Advertising API** permissions
3. Generate a **Client Secret**
4. Apply for a **Developer Token** at [Microsoft Advertising](https://about.ads.microsoft.com/en-us/resources/tools/developer-token)
5. Find your **Account ID** in Microsoft Ads under **Settings** > **Account**

### Step 2: Configure Your Environment

Each skill uses a `.env` file to store your API keys. These files stay on your computer and are never shared.

For each skill you want to use, copy the example file:

```bash
# Google Ads
cp skills/google-ads/.env.example skills/google-ads/.env

# Meta Ads
cp skills/facebook-ads/.env.example skills/facebook-ads/.env

# Microsoft Ads
cp skills/microsoft-ads/.env.example skills/microsoft-ads/.env
```

Open each `.env` file and paste your API keys where indicated. The `.env.example` files contain comments explaining each value.

### Step 3: Install Dependencies

Install the Python packages each skill needs:

```bash
# Install for specific skills
pip install -r skills/google-ads/requirements.txt
pip install -r skills/facebook-ads/requirements.txt
pip install -r skills/microsoft-ads/requirements.txt
```

Or install everything with one command:
```bash
pip install google-ads facebook-business bingads python-dotenv
```

### Step 4: Install Skills into Claude Code

Copy the skills to Claude Code's skill directory:

```bash
for skill in google-ads facebook-ads microsoft-ads account-structure-review; do
  cp -r "skills/$skill" ~/.claude/skills/
done
```

### Step 5: Verify Setup

Ask Claude to verify each skill is loaded:
```
"List the paid media skills you have available"
```

Or test with a specific prompt:
```
"What bid strategies are available in Google Ads and when should I use each one?"
```

### Step 6: Your First Audit

Try a cross-platform account structure review:
```
"Audit my paid media account structure — I'm spending $30K/month across Google and Meta"
```

Or start with a single platform:
```
"Audit my Google Ads account and find wasted spend"
```

## Troubleshooting

### "command not found: python"
Python isn't in your system PATH. Try `python3` instead of `python`. On macOS, you may need to install Python:
```bash
brew install python
```

### "No module named 'dotenv'" or similar import error
The required packages aren't installed. Run:
```bash
pip install -r requirements.txt
```
in the skill directory. If `pip` doesn't work, try `pip3`.

### "API key invalid" or 401 errors
- **Google Ads**: Verify your developer token is approved (not test mode) and customer ID is correct
- **Meta Ads**: Make sure the System User token has `ads_management` and `ads_read` permissions
- **Microsoft Ads**: Check that your Azure AD app has the correct API permissions

### "Permission denied" on macOS
If you get permission errors running scripts:
```bash
chmod +x skill-packs/scripts/*.py
```

### Account Structure Review doesn't need API keys
This skill is analysis-only. Provide your data by:
- Pasting campaign metrics from Google Ads or Meta Ads Manager
- Sharing screenshots of campaign structure
- Exporting CSVs from your ad platforms

## Getting Help

- **In Claude Code**: Ask Claude directly -- the skills provide context automatically
- **Issues**: Open an issue on this repository
- **Claude Code help**: Run `/help` in Claude Code for general assistance
