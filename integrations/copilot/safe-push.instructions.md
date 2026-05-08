Pre-push hygiene check for GitHub repositories. Scans for PII, secrets, and sensitive data before pushing. Audits commit messages, enforces repo-specific blocklists, and rate-limits pushes to avoid GitHub abuse detection. Use before any git push, especially to public repos.


# Safe Push

Pre-push hygiene check for GitHub repositories. Use when the user asks to push code, especially to public repos.

## Trigger

When the user says "push", "safe push", "push to GitHub", or runs `/safe-push`.

## Procedure

### 1. Classify the repo

```bash
# Check if public repo
git remote -v
# Check for .public-repo marker
test -f .public-repo && echo "PUBLIC" || echo "private or unmarked"
```

If public (or pushing to a public remote): apply ALL checks below.
If private: apply only the PII scan (step 2).

### 2. PII and secrets scan

Load your personal pattern list from `~/.claude/safe-push-blocklist` and scan against it. The same patterns apply to diff content (step 2) AND commit messages (step 3) — both run from the same source of truth.

**Default mode** — scan the diff against the target branch:

```bash
# Load personal patterns (graceful fallback if file missing):
if [ -f ~/.claude/safe-push-blocklist ]; then
  PATTERNS=$(grep -v '^#' ~/.claude/safe-push-blocklist | grep -v '^$' | paste -sd '|' -)
else
  PATTERNS=""
  echo "WARNING: ~/.claude/safe-push-blocklist not found. Personal pattern checks skipped."
fi

git diff origin/main...HEAD
[ -n "$PATTERNS" ] && git diff origin/main...HEAD | grep -nE "$PATTERNS" \
  || echo "NO MATCHES IN DIFF"
```

**Full repo mode** (`/safe-push --full`) — scan ALL tracked files, not just the diff. Use this for baseline audits, first-time pushes of existing repos, or periodic hygiene checks:

```bash
git ls-files | xargs grep -n -E "$PATTERNS" \
  --include='*.md' --include='*.py' --include='*.js' --include='*.ts' \
  --include='*.html' --include='*.sh' --include='*.json' \
  --include='*.yml' --include='*.yaml'
```

Check for these categories (your `~/.claude/safe-push-blocklist` covers the regex-able ones):

- Client names or internal project codenames
- Personal infrastructure: hostnames, internal directory names, device IDs, hardware models, self-hosted service names
- Email addresses (personal or client), phone numbers, addresses
- API keys, tokens, secrets (AWS, GitHub, Slack, Telegram, generic)
- Private IP addresses, internal hostnames
- Private key material
- Slack tokens (`xoxb-`), Slack channel IDs
- Tracking IDs: GA4 (`G-XXXXXXXXXX`), GTM (`GTM-XXXXXXX`)

Edit `~/.claude/safe-push-blocklist` to maintain your personal patterns. Never hardcode real client names or infrastructure identifiers inside this skill file — the blocklist is the source of truth.

If anything is found:
- List each finding with file, line number, and what was detected
- Ask the user to fix before proceeding
- Do NOT push until resolved

### 3. Commit message audit

Review the FULL commit message — both subject (title) and body (description) — for every commit in the push range. Sensitive patterns can hide in either:

```bash
# Print the full message (subject + body) for every commit:
git log origin/main..HEAD --format="===%h %s===%n%b"


(Truncated. See full skill at github.com/thatrebeccarae/claude-marketing)
