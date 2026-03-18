# safe-push


# Safe Push

Pre-push hygiene checker for GitHub repositories. Prevents accidental exposure of secrets, PII, and sensitive infrastructure details.

## When to Use

- Before any `git push` to a remote repository
- Especially before pushing to public repos
- When onboarding a new repo to ensure clean push habits
- After bulk commits or rebases before pushing

## Procedure

### Step 1: Classify the Repo

```bash
# Check remote URL
git remote -v

# Check for public repo marker
test -f .public-repo && echo "PUBLIC" || echo "private or unmarked"
```

**Public repos** (`.public-repo` marker or public remote): apply ALL checks below.
**Private repos**: apply PII/secrets scan only (Step 2).

When in doubt, treat a repo as public.

### Step 2: PII and Secrets Scan

Scan the full diff against the target branch:

```bash
git diff origin/main...HEAD
```

**Always blocked:**
- Email addresses (personal or client)
- Phone numbers
- API keys, tokens, secrets (AWS, GitHub, Slack, generic patterns)
- Private IP addresses (RFC 1918 ranges)
- Internal hostnames and infrastructure details
- Private key material (RSA, SSH, PGP headers)
- Hardcoded credentials or passwords
- Client names configured in `.commit-msg-blocklist`

**Allowlist:** Patterns matching repo-local `.pii-allowlist` (one regex per line) are excluded from the scan.

If anything is found:
- List each finding with file, line number, and what was detected
- Do NOT push until all findings are resolved or allowlisted

### Step 3: Commit Message Audit

Review all commit messages in the push range:

```bash
git log origin/main..HEAD --format="%h %s"
```

For public repos, flag:
- Client names or internal project codenames (per `.commit-msg-blocklist`)
- Internal URLs, private IPs, hostnames
- Infrastructure details (service names, device IDs, network names)
- Personal information
- Vague messages ("fix", "update", "wip") — suggest descriptive rewrites

### Step 4: Staggered Push (Rate Limiting)

To avoid triggering GitHub bulk action / automation abuse detection:

| Scenario | Strategy |
|----------|----------|
| Single branch, < 50 commits | Push normally |
| Multiple branches | One branch at a time, 5s gap between pushes |
| > 50 commits on one branch | Batch into groups of 50, 10s gap between batches |
| New repo, initial push | Push default branch first, wait 10s, then remaining branches with 5s gaps |

Never use `git push --all` or `git push --mirror` to a public remote without staggering.

### Step 5: Final Confirmation

Present a summary before executing:
- Repository name and public/private classification
- Branch(es) being pushed
- Number of commits
- Any warnings from Steps 2-4
- Push strategy (direct or staggered)

Wait for explicit user confirmation.

### Step 6: Push and Verify

```bash
git push origin <branch>
git log origin/<branch> --oneline -5
```

Report success and the remote URL.

## Configuration Files

### `.pii-allowlist`

Place in repo root. One regex per line. Matches are excluded from the PII scan.

```
# Allow example.com emails in docs
example\.com
# Allow documentation IP ranges
192\.0\.2\.\d+
198\.51\.100\.\d+
```

### `.commit-msg-blocklist`

Place in repo root. Terms that must never appear in public commit messages.

```
# Client names
acme-corp
bigco
# Internal project codenames
project-phoenix
# Infrastructure
staging\.internal
```

## Key Principles

1. **Default to caution.** If unsure whether a repo is public, treat it as public.
2. **Never bypass.** This skill complements pre-commit hooks — they work together.
3. **Fix, don't suppress.** Remove the sensitive data rather than allowlisting it, when possible.
4. **Audit the full range.** Always scan from the divergence point, not just the latest commit.

For regex patterns and detection details, see [REFERENCE.md](REFERENCE.md).

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
