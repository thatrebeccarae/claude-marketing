#!/usr/bin/env bash
# convert.sh — Transform skills/ into integrations/ for 5 AI coding tools
# Usage: bash scripts/convert.sh (from repo root)
# No external dependencies beyond bash, awk, sed, wc, sort

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="$REPO_ROOT/skills"
OUT_DIR="$REPO_ROOT/integrations"

# ---------------------------------------------------------------------------
# Helper functions
# ---------------------------------------------------------------------------

# extract_frontmatter_field <file> <field>
# Extracts a YAML frontmatter field value from between the first two --- lines.
# Handles quoted and unquoted values. Strips surrounding quotes from the result.
extract_frontmatter_field() {
  local file="$1"
  local field="$2"
  awk -v field="$field" '
    BEGIN { delim = 0; done = 0 }
    /^---$/ {
      delim++
      if (delim == 2) { done = 1 }
      next
    }
    delim == 1 && !done {
      # Match "field:" at start of line
      if (index($0, field ":") == 1) {
        val = substr($0, length(field) + 2)
        # Strip leading whitespace
        gsub(/^[ \t]+/, "", val)
        # Strip surrounding double or single quotes
        if (substr(val,1,1) == "\"" && substr(val,length(val),1) == "\"") {
          val = substr(val, 2, length(val) - 2)
        } else if (substr(val,1,1) == "'"'"'" && substr(val,length(val),1) == "'"'"'") {
          val = substr(val, 2, length(val) - 2)
        }
        print val
        exit
      }
    }
  ' "$file"
}

# strip_frontmatter <file>
# Returns everything after the closing --- of YAML frontmatter.
strip_frontmatter() {
  local file="$1"
  awk '
    BEGIN { delim = 0; printing = 0 }
    /^---$/ {
      delim++
      if (delim == 2) { printing = 1 }
      next
    }
    printing { print }
  ' "$file"
}

# remove_install_section
# Reads from stdin. Removes ## Install section through the next ## or EOF.
remove_install_section() {
  awk '
    BEGIN { skip = 0 }
    /^## Install/ { skip = 1; next }
    skip && /^## / { skip = 0 }
    !skip { print }
  '
}

# extract_core_capabilities <file>
# Strips frontmatter, removes Install section, returns remaining body content.
extract_core_capabilities() {
  local file="$1"
  strip_frontmatter "$file" | remove_install_section
}

# char_count_check <file> <limit> <label>
# Returns non-zero and prints error to stderr if file exceeds limit.
char_count_check() {
  local file="$1"
  local limit="$2"
  local label="$3"
  local count
  count=$(wc -c < "$file")
  if [ "$count" -gt "$limit" ]; then
    echo "ERROR: $label ($file) exceeds $limit chars (actual: $count chars)" >&2
    return 1
  fi
  return 0
}

# get_skill_slugs
# Lists all skill directory names sorted alphabetically. Excludes shared/.
get_skill_slugs() {
  ls -1 "$SKILLS_DIR" | LC_ALL=C sort | grep -v '^shared$'
}

# truncate_description <text> <max_chars>
# Truncates description text to max_chars, cutting at word boundary.
truncate_description() {
  local text="$1"
  local max_chars="$2"
  if [ "${#text}" -le "$max_chars" ]; then
    printf '%s' "$text"
    return
  fi
  # Truncate to max_chars, then backtrack to last space
  local truncated="${text:0:$max_chars}"
  # Find last space
  truncated="${truncated% *}"
  printf '%s...' "$truncated"
}

# ---------------------------------------------------------------------------
# Tool converter functions
# ---------------------------------------------------------------------------

convert_cursor() {
  local out="$OUT_DIR/cursor"
  mkdir -p "$out"

  while IFS= read -r slug; do
    local skill_file="$SKILLS_DIR/$slug/SKILL.md"
    local ref_file="$SKILLS_DIR/$slug/REFERENCE.md"
    local outfile="$out/$slug.mdc"

    [ -f "$skill_file" ] || continue

    local description
    description=$(extract_frontmatter_field "$skill_file" "description")

    local body
    body=$(strip_frontmatter "$skill_file" | remove_install_section)

    # Escape double quotes in description for YAML safety
    local escaped_desc="${description//\"/\\\"}"

    # Write YAML frontmatter + body
    {
      printf -- '---\n'
      printf 'description: "%s"\n' "$escaped_desc"
      printf 'globs: []\n'
      printf 'alwaysApply: false\n'
      printf -- '---\n'
      printf '%s\n' "$body"
    } > "$outfile"

    # Append REFERENCE.md if it exists and combined line count stays under 500
    if [ -f "$ref_file" ]; then
      local total_lines ref_lines
      total_lines=$(wc -l < "$outfile")
      ref_lines=$(wc -l < "$ref_file")
      if [ $(( total_lines + ref_lines )) -lt 500 ]; then
        {
          printf '\n---\n\n'
          cat "$ref_file"
        } >> "$outfile"
      fi
    fi

  done < <(get_skill_slugs)
}

convert_aider() {
  local outfile="$OUT_DIR/aider/CONVENTIONS.md"
  mkdir -p "$OUT_DIR/aider"

  {
    printf '# dgtldept Marketing Skills for Aider\n\n'
    printf 'This file provides AI coding assistance conventions for digital marketing work.\n'
    printf 'Each section corresponds to a tested Claude Code skill from the dgtldept library.\n'
    printf 'Auto-generated by scripts/convert.sh — do not edit directly.\n\n'

    while IFS= read -r slug; do
      local skill_file="$SKILLS_DIR/$slug/SKILL.md"
      [ -f "$skill_file" ] || continue

      local name description
      name=$(extract_frontmatter_field "$skill_file" "name")
      description=$(extract_frontmatter_field "$skill_file" "description")

      printf '## %s\n\n' "$name"
      printf '%s\n\n' "$description"

      # Core capabilities: body with Install removed
      strip_frontmatter "$skill_file" | remove_install_section
      printf '\n'

    done < <(get_skill_slugs)
  } > "$outfile"
}

convert_windsurf() {
  local outfile="$OUT_DIR/windsurf/.windsurfrules"
  mkdir -p "$OUT_DIR/windsurf"

  # Full version: description + up to 5 bullets per skill
  _write_windsurfrules_full() {
    {
      printf '# dgtldept Marketing Skills\n\n'

      while IFS= read -r slug; do
        local skill_file="$SKILLS_DIR/$slug/SKILL.md"
        [ -f "$skill_file" ] || continue

        local name description
        name=$(extract_frontmatter_field "$skill_file" "name")
        description=$(extract_frontmatter_field "$skill_file" "description")

        printf '## %s\n\n' "$name"
        printf '%s\n\n' "$description"

        # Extract up to 5 bullet/starred items from skill body (excluding Install)
        local bullets
        bullets=$(strip_frontmatter "$skill_file" | remove_install_section | \
          grep -E '^[-*] ' | head -5 || true)
        if [ -n "$bullets" ]; then
          printf '%s\n' "$bullets"
        fi
        printf '\n'

      done < <(get_skill_slugs)
    } > "$outfile"
  }

  # Compact version: description only, truncated to ~180 chars
  _write_windsurfrules_compact() {
    {
      printf '# dgtldept Marketing Skills\n\n'

      while IFS= read -r slug; do
        local skill_file="$SKILLS_DIR/$slug/SKILL.md"
        [ -f "$skill_file" ] || continue

        local name description short_desc
        name=$(extract_frontmatter_field "$skill_file" "name")
        description=$(extract_frontmatter_field "$skill_file" "description")

        # Truncate to first sentence (first period + space or end)
        short_desc=$(printf '%s' "$description" | awk '
          {
            # Find first period followed by space or end
            n = index($0, ". ")
            if (n > 0) { print substr($0, 1, n); exit }
            n = index($0, ".")
            if (n > 0 && n == length($0)) { print $0; exit }
            print $0
          }
        ')

        printf '## %s\n\n' "$name"
        printf '%s\n\n' "$short_desc"

      done < <(get_skill_slugs)
    } > "$outfile"
  }

  # Ultra-compact: just name + one-line description, hard-truncated at 120 chars
  _write_windsurfrules_ultracompact() {
    {
      printf '# dgtldept Marketing Skills\n\n'

      while IFS= read -r slug; do
        local skill_file="$SKILLS_DIR/$slug/SKILL.md"
        [ -f "$skill_file" ] || continue

        local name description
        name=$(extract_frontmatter_field "$skill_file" "name")
        description=$(extract_frontmatter_field "$skill_file" "description")

        # Hard truncate at 120 chars to word boundary
        local short_desc
        short_desc=$(truncate_description "$description" 120)

        printf '## %s\n\n' "$name"
        printf '%s\n\n' "$short_desc"

      done < <(get_skill_slugs)
    } > "$outfile"
  }

  # Try full version first
  _write_windsurfrules_full

  local char_count
  char_count=$(wc -c < "$outfile" | tr -d ' ')

  if [ "$char_count" -gt 11500 ]; then
    echo "  Windsurf: full ($char_count chars) exceeds 11,500. Trying compact..." >&2
    _write_windsurfrules_compact

    char_count=$(wc -c < "$outfile" | tr -d ' ')
    if [ "$char_count" -gt 11500 ]; then
      echo "  Windsurf: compact ($char_count chars) still exceeds 11,500. Trying ultra-compact..." >&2
      _write_windsurfrules_ultracompact

      char_count=$(wc -c < "$outfile" | tr -d ' ')
      if [ "$char_count" -gt 11500 ]; then
        echo "ERROR: integrations/windsurf/.windsurfrules exceeds 11,500 chars ($char_count) even in ultra-compact mode." >&2
        echo "       Reduce skill count or description lengths before running convert.sh." >&2
        exit 1
      fi
      echo "  Windsurf: ultra-compact mode used ($char_count chars)" >&2
    fi
  fi
}

convert_copilot() {
  local out="$OUT_DIR/copilot"
  mkdir -p "$out"

  while IFS= read -r slug; do
    local skill_file="$SKILLS_DIR/$slug/SKILL.md"
    local outfile="$out/$slug.instructions.md"

    [ -f "$skill_file" ] || continue

    local description
    description=$(extract_frontmatter_field "$skill_file" "description")

    local body
    body=$(strip_frontmatter "$skill_file" | remove_install_section)

    # Write to temp, check size, truncate if needed
    local tmpfile
    tmpfile=$(mktemp)

    {
      printf '%s\n\n' "$description"
      printf '%s\n' "$body"
    } > "$tmpfile"

    local char_count
    char_count=$(wc -c < "$tmpfile" | tr -d ' ')

    if [ "$char_count" -gt 3500 ]; then
      # Truncate at last blank line before 3500 chars using awk
      awk '
        BEGIN { chars = 0; output = ""; last_para_end = "" }
        {
          line = $0 "\n"
          chars += length(line)
          if (chars > 3500) {
            # We have exceeded limit; print up to last_para_end
            printf "%s", last_para_end
            exit
          }
          output = output line
          if ($0 == "") {
            last_para_end = output
          }
        }
        END {
          if (chars <= 3500) { printf "%s", output }
        }
      ' "$tmpfile" > "$outfile"

      printf '\n(Truncated. See full skill at github.com/thatrebeccarae/claude-marketing)\n' >> "$outfile"
    else
      cp "$tmpfile" "$outfile"
    fi

    rm -f "$tmpfile"

  done < <(get_skill_slugs)
}

convert_gemini() {
  local gemini_dir="$OUT_DIR/gemini"
  local ref_dir="$gemini_dir/reference"
  mkdir -p "$ref_dir"

  local index_file="$gemini_dir/GEMINI.md"

  # Write the index file
  {
    printf '# dgtldept Marketing Skills\n\n'
    printf 'Digital marketing skill library for Gemini CLI. Each section links to a detailed\n'
    printf 'reference file for full skill documentation. Auto-generated by scripts/convert.sh.\n\n'

    while IFS= read -r slug; do
      local skill_file="$SKILLS_DIR/$slug/SKILL.md"
      [ -f "$skill_file" ] || continue

      local name description
      name=$(extract_frontmatter_field "$skill_file" "name")
      description=$(extract_frontmatter_field "$skill_file" "description")

      printf '## %s\n\n' "$name"
      printf '%s\n\n' "$description"
      printf '@./reference/%s.md\n\n' "$slug"

    done < <(get_skill_slugs)
  } > "$index_file"

  # Write per-skill reference files
  while IFS= read -r slug; do
    local skill_file="$SKILLS_DIR/$slug/SKILL.md"
    local ref_file="$SKILLS_DIR/$slug/REFERENCE.md"
    local outfile="$ref_dir/$slug.md"

    [ -f "$skill_file" ] || continue

    local name
    name=$(extract_frontmatter_field "$skill_file" "name")

    {
      printf '# %s\n\n' "$name"
      strip_frontmatter "$skill_file" | remove_install_section

      if [ -f "$ref_file" ]; then
        printf '\n---\n\n'
        cat "$ref_file"
      fi
    } > "$outfile"

  done < <(get_skill_slugs)
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

main() {
  echo "convert.sh — generating integrations/ from skills/"
  echo "Repo root: $REPO_ROOT"
  echo ""

  # Remove and recreate output directory tree
  rm -rf "$OUT_DIR"
  mkdir -p \
    "$OUT_DIR/cursor" \
    "$OUT_DIR/aider" \
    "$OUT_DIR/windsurf" \
    "$OUT_DIR/copilot" \
    "$OUT_DIR/gemini/reference"

  local skill_count
  skill_count=$(get_skill_slugs | wc -l | tr -d ' ')

  echo "Found $skill_count skill directories (skills with SKILL.md will be converted)"
  echo ""

  printf '  Cursor...   '
  convert_cursor
  local cursor_count
  cursor_count=$(ls -1 "$OUT_DIR/cursor/"*.mdc 2>/dev/null | wc -l | tr -d ' ')
  printf 'done (%s .mdc files)\n' "$cursor_count"

  printf '  Aider...    '
  convert_aider
  local aider_chars
  aider_chars=$(wc -c < "$OUT_DIR/aider/CONVENTIONS.md" | tr -d ' ')
  printf 'done (CONVENTIONS.md: %s chars)\n' "$aider_chars"

  printf '  Windsurf... '
  convert_windsurf 2>&1 | grep -v '^$' | while IFS= read -r line; do printf '%s\n' "$line"; done
  local ws_chars
  ws_chars=$(wc -c < "$OUT_DIR/windsurf/.windsurfrules" | tr -d ' ')
  printf '  Windsurf:   done (.windsurfrules: %s chars)\n' "$ws_chars"

  printf '  Copilot...  '
  convert_copilot
  local copilot_count
  copilot_count=$(ls -1 "$OUT_DIR/copilot/"*.instructions.md 2>/dev/null | wc -l | tr -d ' ')
  printf 'done (%s .instructions.md files)\n' "$copilot_count"

  printf '  Gemini...   '
  convert_gemini
  local gemini_refs
  gemini_refs=$(ls -1 "$OUT_DIR/gemini/reference/"*.md 2>/dev/null | wc -l | tr -d ' ')
  printf 'done (GEMINI.md + %s reference files)\n' "$gemini_refs"

  echo ""
  echo "Done. integrations/ generated successfully."
}

main "$@"
