---
name: safe-push
description: "Pre-push hygiene check for GitHub repositories. Scans for PII, secrets, and sensitive data before pushing. Audits commit messages, enforces repo-specific blocklists, and rate-limits pushes to avoid GitHub abuse detection. Use before any git push, especially to public repos."
license: MIT
origin: custom
author: Rebecca Rae Barton
author_url: https://github.com/thatrebeccarae
metadata:
  version: 1.1.0
  category: devops
  domain: git
  updated: 2026-03-20
  tested: 2026-03-20
  tested_with: "Claude Code v2.1"
---

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
