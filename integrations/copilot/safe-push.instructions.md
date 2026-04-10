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

**Default mode** — scan the diff against the target branch:

```bash
git diff origin/main...HEAD
```

**Full repo mode** (`/safe-push --full`) — scan ALL tracked files, not just the diff. Use this for baseline audits, first-time pushes of existing repos, or periodic hygiene checks. Searches the entire working tree for blocked patterns:

```bash
git ls-files | xargs grep -n -E 'PATTERN' --include='*.md' --include='*.py' --include='*.js' --include='*.ts' --include='*.html' --include='*.sh' --include='*.json' --include='*.yml' --include='*.yaml'
```

Check for:
- Email addresses (personal or client)
- Phone numbers
- API keys, tokens, secrets (AWS, GitHub, Slack, Telegram, generic)
- Private IP addresses, internal hostnames
- Private key material
- Client names or internal project codenames
- Hardcoded credentials or passwords

**Client names and internal project codenames:** Maintain a per-user blocklist at `~/.claude/safe-push-blocklist` (one pattern per line) and load it into the scan. Never hardcode real client names inside this skill file — that would defeat the purpose of the scan.

**Infrastructure patterns (always blocked in public repos):**
- Private IP ranges: Tailscale (100.64.0.0/10), RFC 1918 LAN (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16)
- Hostnames and `.local` / `.lan` / `.internal` TLDs for any machine you run
- Internal directory names specific to your workstation (home dir subfolders, sync folder names)
- VLAN and network segment names
- Self-hosted service names (reverse proxies, databases, dashboards, workflow automation, file sync tools) when appearing in infra context
- Device and hardware serials (e.g., `^[A-Z0-9]{7,12}$`-shaped identifiers in config/doc files)
- Hardware model names in personal-infra context
- Docker paths, `.env` file references
- Slack bot tokens (`xoxb-`), Slack channel IDs (`C` + 10 alphanumerics)
- API keys and credentials for any self-hosted service
- SSH config details, private port mappings
- Hardcoded tracking IDs: GA4 measurement IDs (`G-XXXXXXXXXX`), GTM container IDs (`GTM-XXXXXXX`)

Load your personal patterns from `~/.claude/safe-push-blocklist` rather than embedding them here.

If anything is found:
- List each finding with file, line number, and what was detected
- Ask the user to fix before proceeding
- Do NOT push until resolved

### 3. Commit message audit

Review ALL commit messages in the push range:

```bash
git log origin/main..HEAD --format="%h %s"
```


(Truncated. See full skill at github.com/thatrebeccarae/claude-marketing)
