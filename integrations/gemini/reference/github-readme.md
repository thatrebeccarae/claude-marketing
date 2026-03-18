# github-readme


# GitHub README Generator

Generate, audit, or update GitHub READMEs against a standard template. Detects repo type and adapts structure accordingly.

## Modes

### 1. Generate (New README)

Create a README from scratch by analyzing the repo.

**Steps:**
1. Detect repo type (library, CLI tool, web app, API, monorepo, skill pack)
2. Read package.json/pyproject.toml/Cargo.toml for metadata
3. Scan directory structure for key patterns
4. Select badge set based on repo type and detected CI/tooling
5. Generate sections appropriate to repo type
6. Write README.md

### 2. Audit (Check Existing)

Evaluate an existing README for completeness and quality.

**Checks:**
- All required sections present for the repo type
- Badge URLs resolve (not broken)
- Version numbers are current
- Install commands work
- Code examples are syntactically valid
- Links are not broken
- No placeholder text remaining
- PII/infrastructure scrub (no internal IPs, hostnames, credentials)

**Output:** Score (0-100) + findings report with specific fix recommendations.

### 3. Update (Patch Existing)

Modify an existing README while preserving its structure.

**Steps:**
1. Read current README
2. Identify sections and their content
3. Plan changes (add missing sections, update stale content)
4. Show diff-style preview
5. Apply updates on approval

## Repo Type Detection

| Signal | Type |
|--------|------|
| `src/` + `package.json` with `main`/`exports` | Library |
| `bin` field in package.json or CLI entry point | CLI Tool |
| `app/` or `pages/` directory, framework config | Web App |
| `routes/` or OpenAPI spec | API |
| `packages/` or workspace config | Monorepo |
| `skills/` with SKILL.md files | Skill Pack |

## Section Order by Type

### Library
1. Title + badges
2. One-line description
3. Features
4. Installation
5. Quick Start
6. API Reference
7. Configuration
8. Contributing
9. License

### CLI Tool
1. Title + badges
2. One-line description
3. Installation (brew, npm, cargo, etc.)
4. Quick Start
5. Commands reference
6. Configuration
7. Contributing
8. License

### Web App
1. Title + badges
2. One-line description
3. Screenshots/demo
4. Features
5. Getting Started (prerequisites, install, run)
6. Environment Variables
7. Deployment
8. Contributing
9. License

### API
1. Title + badges
2. One-line description
3. Base URL + authentication
4. Quick Start
5. Endpoints reference
6. Error handling
7. Rate limits
8. Contributing
9. License

## Badge Selection

| Badge | When to Include |
|-------|----------------|
| Build/CI status | CI config detected (.github/workflows/) |
| Coverage | Coverage config detected (codecov, coveralls) |
| npm version | package.json with npm publish |
| PyPI version | pyproject.toml with PyPI config |
| License | Always |
| Node/Python version | When runtime version matters |
| TypeScript | tsconfig.json present |
| Docker | Dockerfile present |

## Key Principles

1. **Lead with what it does.** First sentence should explain the tool in one line.
2. **Show, don't tell.** Code examples > descriptions.
3. **Install command must work.** Test it mentally — does it reference the right package name?
4. **No placeholder text.** Every `TODO`, `YOUR_`, `CHANGEME` must be resolved.
5. **No stale badges.** Remove badges for services not configured.

## Anti-Patterns

- Walls of text without code examples
- Broken badge URLs or badges for unconfigured services
- Generic descriptions ("A tool for doing things")
- Missing install instructions
- Stale version numbers in examples
- Internal URLs, IPs, or credentials in examples
- Placeholder text left in ("TODO", "Add description here")

For badge URL patterns and section templates, see [REFERENCE.md](REFERENCE.md).

---

# GitHub README — Reference

## Badge URL Patterns

### Shields.io Badges

```markdown
<!-- Build status (GitHub Actions) -->
![Build](https://img.shields.io/github/actions/workflow/status/{owner}/{repo}/{workflow}.yml?branch=main)

<!-- npm version -->
![npm](https://img.shields.io/npm/v/{package-name})

<!-- PyPI version -->
![PyPI](https://img.shields.io/pypi/v/{package-name})

<!-- License -->
![License](https://img.shields.io/github/license/{owner}/{repo})

<!-- TypeScript -->
![TypeScript](https://img.shields.io/badge/TypeScript-5.x-blue?logo=typescript&logoColor=white)

<!-- Node.js -->
![Node](https://img.shields.io/badge/Node.js-%3E%3D18-green?logo=node.js&logoColor=white)

<!-- Python -->
![Python](https://img.shields.io/badge/Python-3.11%2B-blue?logo=python&logoColor=white)

<!-- Coverage (Codecov) -->
![Coverage](https://img.shields.io/codecov/c/github/{owner}/{repo})

<!-- Docker -->
![Docker](https://img.shields.io/docker/v/{owner}/{repo}?sort=semver&logo=docker)

<!-- Downloads (npm) -->
![Downloads](https://img.shields.io/npm/dm/{package-name})

<!-- Stars -->
![Stars](https://img.shields.io/github/stars/{owner}/{repo}?style=social)
```

## Section Templates

### Title Block

```markdown
# Project Name

[![Build](badge-url)](link) [![License](badge-url)](link)

> One-line description of what this project does and who it's for.
```

### Features

```markdown
## Features

- **Feature name** — What it does and why it matters
- **Feature name** — What it does and why it matters
- **Feature name** — What it does and why it matters
```

### Installation

```markdown
## Installation

```bash
npm install package-name
# or
yarn add package-name
# or
pnpm add package-name
```
```

### Quick Start

```markdown
## Quick Start

```typescript
import { thing } from "package-name";

const result = thing.doSomething({
  option: "value",
});

console.log(result);
```
```

### Environment Variables

```markdown
## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `API_KEY` | Yes | — | Your API key from the dashboard |
| `PORT` | No | `3000` | Server port |
| `LOG_LEVEL` | No | `info` | Logging verbosity |

Copy `.env.example` to `.env` and fill in your values:

```bash
cp .env.example .env
```
```

### CLI Commands

```markdown
## Commands

| Command | Description |
|---------|-------------|
| `tool init` | Initialize a new project |
| `tool build` | Build for production |
| `tool dev` | Start development server |
| `tool test` | Run test suite |

### `tool init`

```bash
tool init [project-name] [--template <name>]
```

Options:
- `--template` — Starter template (default: `basic`)
- `--no-git` — Skip git initialization
```

### API Endpoints

```markdown
## API Reference

### Authentication

All requests require an API key in the `Authorization` header:

```bash
curl -H "Authorization: Bearer YOUR_API_KEY" https://api.example.com/v1/resource
```

### Endpoints

#### `GET /v1/resources`

List all resources.

**Parameters:**

| Param | Type | Required | Description |
|-------|------|----------|-------------|
| `limit` | integer | No | Max results (default: 20) |
| `offset` | integer | No | Pagination offset |

**Response:**

```json
{
  "data": [...],
  "total": 100,
  "limit": 20,
  "offset": 0
}
```
```

### Contributing

```markdown
## Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) before submitting a PR.

1. Fork the repo
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request
```

### License

```markdown
## License

[MIT](LICENSE) &copy; [Your Name](https://github.com/yourusername)
```

## Audit Scoring Rubric

| Category | Weight | Criteria |
|----------|--------|----------|
| Description | 15% | Clear one-liner, explains what + who |
| Installation | 20% | Working install command, prerequisites listed |
| Usage/Examples | 20% | Code examples that work, cover main use case |
| Badges | 10% | Relevant badges, all URLs resolve |
| Structure | 15% | Logical section order, appropriate for repo type |
| Completeness | 10% | All required sections present |
| Freshness | 10% | Version numbers current, no stale references |

## PII/Infrastructure Scrub Checklist

Before publishing, verify the README contains none of:

- [ ] Email addresses (personal or team)
- [ ] Internal IP addresses or hostnames
- [ ] API keys, tokens, or passwords (even example ones that look real)
- [ ] Internal URLs (intranet, staging, VPN)
- [ ] Client names or project codenames
- [ ] Employee names (unless public maintainers)
- [ ] File paths containing usernames
- [ ] Internal tool references (Slack channels, Jira projects)
