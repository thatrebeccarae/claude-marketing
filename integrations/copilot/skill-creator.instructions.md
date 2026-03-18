Guide for creating effective Claude Code skills that extend capabilities with specialized knowledge, workflows, and tool integrations. Use when users want to create a new skill or update an existing skill.


# Skill Creator

Guide for creating effective skills that extend Claude's capabilities.

## About Skills

Skills are modular, self-contained packages that provide specialized knowledge, workflows, and tools. They transform Claude from a general-purpose agent into a specialized one.

### Anatomy of a Skill

```
skill-name/
+-- SKILL.md (required)
|   +-- YAML frontmatter (name, description)
|   +-- Markdown instructions
+-- scripts/          - Executable code
+-- references/       - Documentation loaded as needed
+-- assets/           - Files used in output (templates, icons)
```

### Progressive Disclosure

1. **Metadata** (~100 words) — Always in context
2. **SKILL.md body** (<5k words) — When skill triggers
3. **Bundled resources** (unlimited) — As needed

## Skill Creation Process

### Step 1: Understand with Concrete Examples
Gather concrete examples of how the skill will be used. Ask about functionality, usage patterns, and trigger phrases.

### Step 2: Plan Reusable Contents
Analyze each example to identify what scripts, references, and assets would help. Example: a PDF editor skill needs `scripts/rotate_pdf.py`; a BigQuery skill needs `references/schema.md`.

### Step 3: Initialize the Skill
```bash
scripts/init_skill.py <skill-name> --path <output-directory>
```

### Step 4: Edit the Skill
Start with bundled resources (scripts/, references/, assets/), then update SKILL.md. Write in imperative/infinitive form. Focus on non-obvious procedural knowledge.

### Step 5: Package
```bash
scripts/package_skill.py <path/to/skill-folder>
```
Validates structure, frontmatter, and creates distributable zip.

### Step 6: Iterate
Use the skill on real tasks, notice struggles, update, and test again.
