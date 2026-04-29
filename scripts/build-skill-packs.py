#!/usr/bin/env python3
"""Generate the "What's Included" table and install command in each
skill-pack/*-pack.md file from the pack's YAML frontmatter `skills:` list.

Source of truth: each pack file's frontmatter declares which skills belong
to it. This script reads that, looks up each skill's description from
`skills/{slug}/SKILL.md` frontmatter, detects which of REFERENCE.md /
EXAMPLES.md / scripts/ exist, and rewrites two marker-bounded sections in
the pack file:

    <!-- SKILLS-TABLE-START -->
    ...generated table...
    <!-- SKILLS-TABLE-END -->

    <!-- INSTALL-CMD-START -->
    ```bash
    cd claude-marketing
    for skill in skill-a skill-b skill-c; do
      cp -r "skills/$skill" ~/.claude/skills/
    done
    ```
    <!-- INSTALL-CMD-END -->

Usage:
    python scripts/build-skill-packs.py            # rewrite in place
    python scripts/build-skill-packs.py --check    # exit 1 if any pack
                                                   # would change
"""

import argparse
import re
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
SKILL_PACKS_DIR = REPO_ROOT / "skill-packs"
SKILLS_DIR = REPO_ROOT / "skills"
README_PATH = REPO_ROOT / "README.md"

TABLE_START = "<!-- SKILLS-TABLE-START -->"
TABLE_END = "<!-- SKILLS-TABLE-END -->"
INSTALL_START = "<!-- INSTALL-CMD-START -->"
INSTALL_END = "<!-- INSTALL-CMD-END -->"

# Root README marker blocks — keep in sync with skill-packs/ frontmatter.
PACK_LIST_START = "<!-- PACK-LIST-START -->"
PACK_LIST_END = "<!-- PACK-LIST-END -->"
PACK_DOCS_START = "<!-- PACK-DOCS-START -->"
PACK_DOCS_END = "<!-- PACK-DOCS-END -->"


def parse_frontmatter(text: str) -> tuple[dict, str]:
    """Split a markdown file into (frontmatter_dict, body).

    Frontmatter is the block between the first two `---` lines. Returns an
    empty dict if no frontmatter is present.
    """
    if not text.startswith("---\n"):
        return {}, text
    end_idx = text.find("\n---\n", 4)
    if end_idx == -1:
        return {}, text
    raw = text[4:end_idx]
    body = text[end_idx + 5 :]
    return _parse_yaml_subset(raw), body


def _parse_yaml_subset(raw: str) -> dict:
    """Tiny YAML subset: scalar `key: value` and `key:` followed by a list
    of `  - value` items. Sufficient for our pack frontmatter; avoids the
    PyYAML dependency."""
    result: dict = {}
    current_list_key: str | None = None
    for line in raw.splitlines():
        if not line.strip() or line.lstrip().startswith("#"):
            continue
        if line.startswith("  - "):
            if current_list_key is None:
                continue
            result.setdefault(current_list_key, []).append(line[4:].strip())
            continue
        m = re.match(r"^([a-zA-Z0-9_-]+):\s*(.*)$", line)
        if not m:
            continue
        key, val = m.group(1), m.group(2).strip()
        current_list_key = key if val == "" else None
        if val:
            # Strip surrounding quotes if present
            if (val.startswith('"') and val.endswith('"')) or (
                val.startswith("'") and val.endswith("'")
            ):
                val = val[1:-1]
            result[key] = val
    return result


def get_skill_metadata(slug: str) -> dict:
    """Read skills/{slug}/SKILL.md frontmatter and detect on-disk file presence."""
    skill_dir = SKILLS_DIR / slug
    skill_md = skill_dir / "SKILL.md"
    if not skill_md.exists():
        raise FileNotFoundError(f"Skill not found: skills/{slug}/SKILL.md")
    fm, _ = parse_frontmatter(skill_md.read_text())
    description = fm.get("description", "").strip()
    includes = ["SKILL"]
    if (skill_dir / "REFERENCE.md").exists():
        includes.append("REFERENCE")
    if (skill_dir / "EXAMPLES.md").exists():
        includes.append("EXAMPLES")
    if (skill_dir / "scripts").is_dir():
        includes.append("scripts")
    if (skill_dir / ".env.example").exists():
        includes.append(".env")
    return {
        "slug": slug,
        "description": description,
        "includes": " + ".join(includes),
    }


def build_table(skills: list[dict]) -> str:
    lines = [
        "| Skill | What It Does | Includes |",
        "|-------|-------------|----------|",
    ]
    for s in skills:
        lines.append(
            f"| **[{s['slug']}](../skills/{s['slug']}/)** | {s['description']} | {s['includes']} |"
        )
    return "\n".join(lines)


def build_install_command(skills: list[dict]) -> str:
    slugs = " ".join(s["slug"] for s in skills)
    return (
        "```bash\n"
        "cd claude-marketing\n"
        f"for skill in {slugs}; do\n"
        '  cp -r "skills/$skill" ~/.claude/skills/\n'
        "done\n"
        "```"
    )


def replace_marker_block(text: str, start: str, end: str, content: str, file: str) -> str:
    pattern = re.compile(
        re.escape(start) + r"\n.*?\n" + re.escape(end), re.DOTALL
    )
    replacement = f"{start}\n{content}\n{end}"
    new_text, n = pattern.subn(replacement, text)
    if n == 0:
        raise ValueError(
            f"{file}: missing marker block ({start} ... {end}). "
            f"Add the markers manually first."
        )
    return new_text


def process_pack(pack_path: Path, check_only: bool) -> bool:
    """Rewrite (or check) a single pack file. Returns True if a change is
    needed (meaningful when check_only=True)."""
    text = pack_path.read_text()
    fm, _body = parse_frontmatter(text)
    skill_slugs = fm.get("skills", [])
    if not skill_slugs:
        raise ValueError(
            f"{pack_path.name}: frontmatter is missing the 'skills:' list."
        )

    skills = [get_skill_metadata(slug) for slug in skill_slugs]
    table = build_table(skills)
    install = build_install_command(skills)

    new_text = replace_marker_block(
        text, TABLE_START, TABLE_END, table, pack_path.name
    )
    new_text = replace_marker_block(
        new_text, INSTALL_START, INSTALL_END, install, pack_path.name
    )

    changed = new_text != text
    if check_only:
        return changed
    if changed:
        pack_path.write_text(new_text)
    return changed


def collect_pack_summaries() -> list[dict]:
    """Read each pack's frontmatter and return a list of summary dicts in
    pack-file-name order, suitable for rendering README pack list and
    pack documentation table sections."""
    summaries: list[dict] = []
    for pack_path in sorted(SKILL_PACKS_DIR.glob("*-pack.md")):
        fm, _ = parse_frontmatter(pack_path.read_text())
        skill_slugs = fm.get("skills", [])
        if not skill_slugs:
            raise ValueError(
                f"{pack_path.name}: frontmatter is missing the 'skills:' list."
            )
        # Pull display label for each skill via the same metadata helper
        # used for pack tables — `name` from each skill's SKILL.md
        # frontmatter is the human-friendly form.
        skill_labels: list[str] = []
        for slug in skill_slugs:
            skill_md = SKILLS_DIR / slug / "SKILL.md"
            if not skill_md.exists():
                raise FileNotFoundError(
                    f"{pack_path.name} references missing skill: {skill_md}"
                )
            sk_fm, _ = parse_frontmatter(skill_md.read_text())
            skill_labels.append(sk_fm.get("name") or slug)
        summaries.append(
            {
                "filename": pack_path.name,
                "title": fm.get("title", pack_path.stem),
                "description": fm.get("description", ""),
                "skill_count": len(skill_slugs),
                "skill_labels": skill_labels,
            }
        )
    return summaries


def build_pack_list(summaries: list[dict]) -> str:
    """Bullet-list of packs for the Skills section of the root README."""
    lines = []
    for s in summaries:
        labels = ", ".join(s["skill_labels"])
        lines.append(
            f"- **[{s['title']}](skill-packs/{s['filename']})** — "
            f"{s['description']} ({labels})"
        )
    return "\n".join(lines)


def build_pack_docs_table(summaries: list[dict]) -> str:
    """Documentation-section table linking to each pack file."""
    lines = [
        "| Pack | Skills | Description |",
        "|------|--------|-------------|",
    ]
    for s in summaries:
        lines.append(
            f"| [{s['title']}](skill-packs/{s['filename']}) "
            f"| {s['skill_count']} "
            f"| {s['description']} |"
        )
    return "\n".join(lines)


def process_readme(check_only: bool) -> bool:
    """Rewrite (or check) the two pack-derived sections in README.md.
    Skipped silently if README.md does not exist or has no markers (so
    the script can run safely on repos where README integration hasn't
    been wired up)."""
    if not README_PATH.exists():
        return False
    text = README_PATH.read_text()
    if PACK_LIST_START not in text and PACK_DOCS_START not in text:
        return False  # README hasn't opted into pack-list generation

    summaries = collect_pack_summaries()
    new_text = text
    if PACK_LIST_START in new_text:
        new_text = replace_marker_block(
            new_text,
            PACK_LIST_START,
            PACK_LIST_END,
            build_pack_list(summaries),
            "README.md",
        )
    if PACK_DOCS_START in new_text:
        new_text = replace_marker_block(
            new_text,
            PACK_DOCS_START,
            PACK_DOCS_END,
            build_pack_docs_table(summaries),
            "README.md",
        )

    changed = new_text != text
    if check_only:
        return changed
    if changed:
        README_PATH.write_text(new_text)
    return changed


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    parser.add_argument(
        "--check",
        action="store_true",
        help="Exit 1 if any pack file would change (CI mode).",
    )
    args = parser.parse_args()

    pack_files = sorted(SKILL_PACKS_DIR.glob("*-pack.md"))
    if not pack_files:
        print(f"No *-pack.md files found in {SKILL_PACKS_DIR}", file=sys.stderr)
        return 1

    any_changed = False
    for pack in pack_files:
        try:
            changed = process_pack(pack, args.check)
        except (FileNotFoundError, ValueError) as exc:
            print(f"ERROR {pack.name}: {exc}", file=sys.stderr)
            return 2
        status = "DRIFT" if (args.check and changed) else (
            "wrote" if changed else "ok"
        )
        print(f"  [{status}] {pack.name}")
        any_changed = any_changed or changed

    # Root README pack list + pack docs table (skipped silently if README
    # has not opted in via marker comments).
    try:
        readme_changed = process_readme(args.check)
    except (FileNotFoundError, ValueError) as exc:
        print(f"ERROR README.md: {exc}", file=sys.stderr)
        return 2
    if README_PATH.exists():
        status = "DRIFT" if (args.check and readme_changed) else (
            "wrote" if readme_changed else "ok"
        )
        print(f"  [{status}] README.md")
    any_changed = any_changed or readme_changed

    if args.check and any_changed:
        print(
            "\nDrift detected. Run `python scripts/build-skill-packs.py` "
            "to regenerate, then commit.",
            file=sys.stderr,
        )
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
