# DOCX Skill — Examples

## Example 1: Create New Contract Document

### Prompt

> Create a professional services agreement as a .docx file between Acme Corp and Widget LLC for software consulting. Include scope, payment terms (net 30), confidentiality, IP assignment, termination, and signature blocks.

### What the skill does

1. Reads `docx-js.md` for the JavaScript document creation API
2. Creates a structured JS file using the `docx` library
3. Generates: cover page, table of contents, numbered sections (Article I, II, etc.), defined terms in bold, signature block with lines
4. Exports via `Packer.toBuffer()`

---

## Example 2: Redline Existing Document

### Prompt

> Review this vendor agreement and add tracked changes: change payment from net 60 to net 30, update indemnification cap, add GDPR section, fix termination notice to 90 days.

### What the skill does

1. Converts to markdown: `pandoc --track-changes=all vendor-agreement.docx -o current.md`
2. Reads `ooxml.md` for Document library API
3. Unpacks: `python ooxml/scripts/unpack.py vendor-agreement.docx unpacked/`
4. Implements changes in 4 batches using minimal, precise edits
5. Packs: `python ooxml/scripts/pack.py unpacked/ reviewed-vendor-agreement.docx`
6. Verifies all changes with pandoc and grep

---

## Example 3: Extract and Analyze Document

### Prompt

> Extract the text from this MSA and summarize the key terms: payment, termination, non-compete, IP, and key dates. Also extract reviewer comments.

### What the skill does

1. Extracts text: `pandoc --track-changes=all msa.docx -o extracted.md`
2. Unpacks for comments: `python ooxml/scripts/unpack.py msa.docx unpacked/`
3. Reads `word/comments.xml` for reviewer comments with author, date, and referenced text
4. Produces structured summary of payment terms, termination conditions, restrictive covenants, IP structure, and key dates
