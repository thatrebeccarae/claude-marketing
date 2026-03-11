# Getting Started with the DTC Skill Pack

A step-by-step guide to setting up the DTC Skill Pack for Claude Code. No terminal experience required -- this guide explains everything in plain English.

## What This Pack Does

This skill pack gives Claude Code deep expertise in the tools DTC e-commerce teams use every day:

| Skill | What Claude Can Do |
|-------|-------------------|
| **Klaviyo Analyst** | Audit email/SMS flows, diagnose deliverability, benchmark campaign metrics, build segmentation strategies, produce implementation specs |
| **Klaviyo Developer** | Design event schemas, build API integrations, handle webhooks, manage rate limits, audit data pipelines |
| **Google Analytics** | Analyze GA4 traffic, identify conversion drop-offs, compare channels, review content performance |
| **Shopify** | Audit store performance, analyze product velocity, review customer cohorts, optimize conversion funnels |
| **Looker Studio** | Build cross-platform dashboards, push data to Google Sheets, design calculated fields, create report templates |
| **Pro Deck Builder** | Create polished PowerPoint decks from any analysis, with dark/light modes and modern design |

## Prerequisites

Before you start, you'll need:

1. **Claude Code** installed and running ([installation guide](https://docs.anthropic.com/en/docs/claude-code))
2. **Python 3.9 or newer** installed on your computer
3. **API keys** for the platforms you use (instructions below)

You do NOT need all API keys. Set up only the skills for platforms you actually use.

## Quick Start (Automated)

The fastest way to get set up is the interactive wizard:

```bash
python skill-packs/scripts/setup-dtc.py
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

Only get keys for the platforms you use. Each key takes 2-5 minutes.

#### Klaviyo (for Analyst + Developer skills)
1. Log in to [Klaviyo](https://www.klaviyo.com/login)
2. Click your **organization name** (bottom-left corner)
3. Go to **Settings** > **API keys**
4. Click **Create Private API Key**
5. Name it `claude-code` and select **Read-only** access
6. Click **Create** and copy the key (starts with `pk_`)

#### Shopify (for Shopify skill)
1. Log in to your [Shopify admin](https://admin.shopify.com)
2. Go to **Settings** > **Apps and sales channels** > **Develop apps**
3. Click **Create an app** and name it `Claude Code Analytics`
4. Under **Configuration**, enable these scopes: `read_orders`, `read_products`, `read_customers`, `read_inventory`
5. Click **Install app** and copy the **Admin API access token** (starts with `shpat_`)

#### Google Analytics (for GA4 skill)
1. Go to [Google Cloud Console](https://console.cloud.google.com)
2. Create a project (or select existing)
3. Enable the **Google Analytics Data API**
4. Go to **IAM & Admin** > **Service Accounts** > **Create Service Account**
5. Download the **JSON key file** and store it somewhere safe (not in your Downloads folder)
6. In GA4, go to **Admin** > **Property access management** and add the service account email as a **Viewer**

#### Google Sheets (for Looker Studio skill)
1. Same Google Cloud project as above
2. Enable the **Google Sheets API** and **Google Drive API**
3. Use the same service account, or create a new one
4. Download the JSON key file

### Step 2: Configure Your Environment

Each skill uses a `.env` file to store your API keys. These files stay on your computer and are never shared.

For each skill you want to use, copy the example file:

```bash
# Klaviyo (same key for both analyst and developer)
cp skills/klaviyo-analyst/.env.example skills/klaviyo-analyst/.env
cp skills/klaviyo-developer/.env.example skills/klaviyo-developer/.env

# Shopify
cp skills/shopify/.env.example skills/shopify/.env

# Google Analytics
cp skills/google-analytics/.env.example skills/google-analytics/.env

# Looker Studio
cp skills/looker-studio/.env.example skills/looker-studio/.env
```

Open each `.env` file and paste your API keys where indicated. The `.env.example` files contain comments explaining each value.

### Step 3: Install Dependencies

Install the Python packages each skill needs:

```bash
# Install for all skills at once
pip install -r skills/klaviyo-analyst/requirements.txt
pip install -r skills/google-analytics/requirements.txt
pip install -r skills/shopify/requirements.txt
pip install -r skills/looker-studio/requirements.txt
```

Or install everything with one command:
```bash
pip install klaviyo-api python-dotenv pandas requests google-analytics-data \
    ShopifyAPI google-api-python-client google-auth gspread
```

### Step 4: Install Skills into Claude Code

Copy the skills to Claude Code's skill directory:

```bash
for skill in klaviyo-analyst klaviyo-developer google-analytics shopify looker-studio pro-deck-builder; do
  cp -r "skills/$skill" ~/.claude/skills/
done
```

### Step 5: Verify Setup

Test each skill's API connection:

```bash
# Shopify: should return your store info
python skills/shopify/scripts/shopify_client.py --resource shop

# Google Analytics: should return session data
python skills/google-analytics/scripts/ga_client.py --days 7 --metrics sessions

# Looker Studio: list available templates
python skills/looker-studio/scripts/data_pipeline.py --action list-templates
```

For Klaviyo, the MCP server handles the connection. Verify with `/mcp` in Claude Code.

### Step 6: Your First Audit

Try a complete Shopify store audit:

```bash
python skills/shopify/scripts/analyze.py --analysis-type full-audit
```

Or ask Claude directly:
```
"Audit my Shopify store and tell me what needs fixing"
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
- **Klaviyo**: Make sure the key starts with `pk_` (private key, not public)
- **Shopify**: Make sure the token starts with `shpat_` and the app has the correct scopes
- **Google**: Make sure the service account JSON file exists at the path in your `.env`

### "Permission denied" on macOS
If you get permission errors running scripts:
```bash
chmod +x skill-packs/scripts/*.py
```

### "SHOPIFY_STORE_URL not set"
Your `.env` file isn't configured. Copy the example and fill in your values:
```bash
cp skills/shopify/.env.example skills/shopify/.env
```

### Klaviyo MCP server not connecting
1. Check that `KLAVIYO_API_KEY` is exported in your shell (`echo $KLAVIYO_API_KEY`)
2. Verify `~/.mcp.json` has the klaviyo server entry (see [dtc-pack.md](dtc-pack.md))
3. Restart Claude Code after changing MCP configuration
4. Run `/mcp` in Claude Code to verify the server is connected

## Getting Help

- **In Claude Code**: Ask Claude directly -- the skills provide context automatically
- **Skill-specific help**: Run any script with `--help` for usage info
- **Issues**: Open an issue on this repository
- **Claude Code help**: Run `/help` in Claude Code for general assistance
