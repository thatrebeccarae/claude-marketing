# Skill Creator — Examples

## Example 1: Create a PDF Editor Skill

### Prompt

> I want to create a skill that helps Claude work with PDF files — rotating pages, merging documents, and extracting text.

### What the skill does

1. Gathers concrete examples: rotate single page, merge 3 PDFs, extract text from scanned PDF
2. Identifies reusable resources: `scripts/rotate_pdf.py`, `scripts/merge_pdfs.py`, `references/pdf_structure.md`
3. Initializes: `scripts/init_skill.py pdf-editor --path ./skills/`
4. Creates SKILL.md with workflow decision tree (rotate vs merge vs extract)
5. Writes Python scripts for deterministic operations
6. Packages: `scripts/package_skill.py ./skills/pdf-editor`

---

## Example 2: Create a Database Query Skill

### Prompt

> Build a skill that helps Claude query our BigQuery data warehouse with schema references and common query patterns.

### What the skill does

1. Asks user for BigQuery project ID, dataset names, and common queries
2. Creates `references/schema.md` documenting all tables, columns, and relationships
3. Creates `references/common_queries.md` with parameterized SQL patterns
4. Writes SKILL.md with workflow: understand question -> find relevant tables -> construct query -> validate -> execute
5. Includes grep patterns for finding relevant schema sections in large reference files

---

## Example 3: Package and Share a Skill

### Prompt

> I have been iterating on a skill for financial analysis. Help me package it for distribution.

### What the skill does

1. Reviews existing skill structure for completeness
2. Validates frontmatter (name, description fields)
3. Checks that all referenced files exist
4. Runs: `scripts/package_skill.py ./skills/financial-analysis`
5. Reports validation results and creates distributable zip
