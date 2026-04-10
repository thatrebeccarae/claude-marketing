# safe-push


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

For public repos, flag:
- Any pattern from your `~/.claude/safe-push-blocklist` (client names, internal codenames)
- Infrastructure references: hostnames, VLAN names, internal paths, private IPs, self-hosted service names, device identifiers
- Hardware identifiers (model numbers, serials, device IDs)
- Internal URLs, private IPs, port numbers tied to services
- Personal info (email, phone, address)
- Vague messages ("fix", "update", "wip") — suggest rewrites

If issues found, suggest interactive rebase to clean messages (with user approval).

### 4. Staggered push (rate limiting)

To avoid triggering GitHub bulk action / automation abuse detection:

- If pushing a single branch with < 50 commits: push normally
- If pushing multiple branches or > 50 commits:
  - Push one branch at a time
  - Wait 5 seconds between branch pushes
  - For very large pushes (100+ commits), break into batches of 50 and wait 10 seconds between batches
- If creating a new repo and pushing initial content with multiple branches:
  - Push main/default branch first
  - Wait 10 seconds
  - Push remaining branches one at a time with 5-second gaps
- NEVER use `git push --all` or `git push --mirror` to a public remote without staggering

```bash
# Example staggered multi-branch push
for branch in main develop feature/foo; do
  git push origin "$branch"
  sleep 5
done
```

### 5. Final confirmation

Before executing the push, present a summary:
- Repository: name and public/private status
- Branch(es) being pushed
- Number of commits
- Any warnings from steps 2-4
- Push strategy (direct or staggered)

Wait for explicit user confirmation before pushing.

### 6. Push and verify

After pushing:
```bash
git push origin <branch>
# Verify
git log origin/<branch> --oneline -5
```

Report success and the remote URL.

## Configuration files

- **User-level blocklist** — `~/.claude/safe-push-blocklist`: one regex per line, personal strings that must never appear in public commits (client names, your hostnames, your internal paths). Load and scan against this list on every public push.
- **Repo-local `.pii-allowlist`** — one regex per line, matches are excluded from the PII scan (used to allow false positives like example keys in docs)
- **Repo-local `.commit-msg-blocklist`** — terms that should never appear in public commit messages for this repo specifically

## Notes

- This skill does NOT bypass the global pre-commit hook — they work together
- For projects with a public/private repo split (dev mirror → public release): always push to the dev repo first, sync via your sync script, then safe-push the public repo
- When in doubt, treat a repo as public

---

# Safe Push — Reference

## Secret Detection Patterns

### API Keys and Tokens

| Pattern | Description |
|---------|-------------|
| `AKIA[0-9A-Z]{16}` | AWS Access Key ID |
| `[0-9a-zA-Z/+]{40}` (near AWS context) | AWS Secret Access Key |
| `ghp_[0-9a-zA-Z]{36}` | GitHub Personal Access Token |
| `gho_[0-9a-zA-Z]{36}` | GitHub OAuth Token |
| `ghs_[0-9a-zA-Z]{36}` | GitHub Server Token |
| `github_pat_[0-9a-zA-Z_]{82}` | GitHub Fine-grained PAT |
| `xoxb-[0-9]+-[0-9]+-[a-zA-Z0-9]+` | Slack Bot Token |
| `xoxp-[0-9]+-[0-9]+-[a-zA-Z0-9]+` | Slack User Token |
| `sk-[a-zA-Z0-9]{48}` | OpenAI API Key |
| `sk-ant-[a-zA-Z0-9-_]{90,}` | Anthropic API Key |
| `SG\.[a-zA-Z0-9_-]{22}\.[a-zA-Z0-9_-]{43}` | SendGrid API Key |
| `sk_live_[0-9a-zA-Z]{24,}` | Stripe Secret Key |
| `pk_live_[0-9a-zA-Z]{24,}` | Stripe Publishable Key |
| `sq0[a-z]{3}-[0-9A-Za-z_-]{22,}` | Square API Key |

### Private Keys

| Pattern | Description |
|---------|-------------|
| `-----BEGIN RSA PRIVATE KEY-----` | RSA Private Key |
| `-----BEGIN OPENSSH PRIVATE KEY-----` | SSH Private Key |
| `-----BEGIN PGP PRIVATE KEY BLOCK-----` | PGP Private Key |
| `-----BEGIN EC PRIVATE KEY-----` | EC Private Key |
| `-----BEGIN DSA PRIVATE KEY-----` | DSA Private Key |

### Generic Secrets

| Pattern | Description |
|---------|-------------|
| `password\s*[:=]\s*['"][^'"]+['"]` | Hardcoded password |
| `secret\s*[:=]\s*['"][^'"]+['"]` | Hardcoded secret |
| `api[_-]?key\s*[:=]\s*['"][^'"]+['"]` | Generic API key assignment |
| `token\s*[:=]\s*['"][^'"]+['"]` | Generic token assignment |
| `bearer\s+[a-zA-Z0-9_\-.~+/]+=*` | Bearer token in code |

### PII Patterns

| Pattern | Description |
|---------|-------------|
| `[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}` | Email address |
| `\b\d{3}[-.]?\d{3}[-.]?\d{4}\b` | US phone number |
| `\b\d{3}-\d{2}-\d{4}\b` | SSN |
| `\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b` (RFC 1918) | Private IP address |

### RFC 1918 Private IP Ranges

```
10.0.0.0/8        → 10.x.x.x
172.16.0.0/12     → 172.16.x.x through 172.31.x.x
192.168.0.0/16    → 192.168.x.x
```

Also flag Tailscale CGNAT range: `100.64.0.0/10` (100.64.x.x through 100.127.x.x).

## Staggered Push Implementation

```bash
# Multi-branch staggered push
branches=("main" "develop" "feature/new-feature")
for branch in "${branches[@]}"; do
  echo "Pushing $branch..."
  git push origin "$branch"
  sleep 5
done

# Large commit batch push
total_commits=$(git rev-list --count origin/main..HEAD)
if [ "$total_commits" -gt 50 ]; then
  echo "Large push detected ($total_commits commits). Staggering..."
  # Push in batches using refspecs
  commits=($(git rev-list --reverse origin/main..HEAD))
  batch_size=50
  for ((i=0; i<${#commits[@]}; i+=batch_size)); do
    batch_end=$((i + batch_size - 1))
    if [ $batch_end -ge ${#commits[@]} ]; then
      git push origin HEAD:refs/heads/main
    else
      git push origin "${commits[$batch_end]}:refs/heads/main"
    fi
    echo "Pushed batch $((i/batch_size + 1)). Waiting 10s..."
    sleep 10
  done
fi
```

## Example .pii-allowlist

```
# Documentation examples
user@example\.com
test@example\.com
admin@example\.com

# RFC 5737 documentation IP ranges (safe to publish)
192\.0\.2\.\d+
198\.51\.100\.\d+
203\.0\.113\.\d+

# Example domains
example\.com
example\.org
example\.net

# Test fixtures
test-api-key-\w+
FAKE_TOKEN_\w+
```

## Example .commit-msg-blocklist

```
# Client names (add your own)
# client-name-here

# Internal infrastructure
# internal-hostname
# staging.internal

# Project codenames
# project-codename
```

## Commit Message Quality Guide

### Bad Messages (Flag These)

```
fix
update
wip
changes
stuff
misc
```

### Good Message Patterns

```
feat: add email validation to signup form
fix: prevent duplicate webhook deliveries
refactor: extract shared auth logic into middleware
docs: add API rate limit documentation
chore: upgrade dependencies to latest patch versions
```

## Pre-commit Hook Integration

Safe-push complements (does not replace) pre-commit hooks. Recommended pairing:

| Layer | Catches | When |
|-------|---------|------|
| Pre-commit hook | Secrets in staged files | Before each commit |
| Safe-push | Secrets across full diff, commit messages, push rate | Before each push |

Both layers should use the same `.pii-allowlist` for consistency.
