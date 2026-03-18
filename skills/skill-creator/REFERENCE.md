# Skill Creator — Reference

## Skill Metadata Schema

### Required Frontmatter Fields

```yaml
---
name: skill-name          # Kebab-case, matches directory name
description: |            # When Claude should use this skill
  Description that helps Claude decide when to activate.
  Be specific about triggers and use cases.
---
```

### Optional Frontmatter Fields

```yaml
license: MIT              # Or other license identifier
origin: custom            # custom, marketplace, anthropic
author: Author Name
author_url: https://github.com/author
metadata:
  version: 1.0.0
  category: category-name
  domain: specific-domain
  updated: YYYY-MM-DD
  tested: YYYY-MM-DD
  tested_with: "Claude Code vX.X"
```

## File Structure Rules

| File/Directory | Required | Purpose |
|----------------|----------|---------|
| SKILL.md | Yes | Main instructions with YAML frontmatter |
| scripts/ | No | Executable Python/Bash scripts |
| references/ | No | Documentation loaded into context as needed |
| assets/ | No | Files used in output (templates, images) |
| REFERENCE.md | No | Single-file alternative to references/ directory |
| EXAMPLES.md | No | Worked examples showing skill in action |

## Writing Style Guide

- Use **imperative/infinitive form** (verb-first instructions)
- Write for another Claude instance, not a human
- Focus on non-obvious procedural knowledge
- Include grep search patterns for large reference files
- Keep SKILL.md under 5,000 words — move details to references/

## Description Quality Checklist

- [ ] Describes WHAT the skill does (not just the domain)
- [ ] Lists specific TRIGGER phrases or scenarios
- [ ] Mentions when NOT to use this skill (if relevant)
- [ ] Uses third person ("This skill should be used when...")
