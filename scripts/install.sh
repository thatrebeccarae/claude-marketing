#!/usr/bin/env bash
# install.sh — dgtldept Skills Multi-Tool Installer
# Detects installed AI coding tools, lets you pick which to install for,
# and deploys converted skills from integrations/ to your project.
#
# Usage:
#   bash scripts/install.sh [OPTIONS]
#
# Options:
#   --project-dir <path>   Target project directory (default: current directory)
#   --non-interactive      Auto-select all detected tools; skip UI
#   --help                 Show this help message

set -euo pipefail

# ---------------------------------------------------------------------------
# Paths
# ---------------------------------------------------------------------------

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
INTEGRATIONS_DIR="$REPO_ROOT/integrations"

# ---------------------------------------------------------------------------
# Defaults
# ---------------------------------------------------------------------------

PROJECT_DIR="$(pwd)"
NON_INTERACTIVE=false

# ---------------------------------------------------------------------------
# Argument parsing
# ---------------------------------------------------------------------------

show_help() {
  cat <<EOF
dgtldept Skills — Multi-Tool Installer

USAGE
  bash scripts/install.sh [OPTIONS]

OPTIONS
  --project-dir <path>   Target project directory (default: current directory)
  --non-interactive      Auto-select all detected tools; skip interactive UI
  --help                 Show this help message

DESCRIPTION
  Detects which AI coding tools you have installed, presents an interactive
  selection menu, and deploys converted skills to the correct locations in
  your project directory.

  Requires that integrations/ exists. If it does not, run:
    bash scripts/convert.sh

SUPPORTED TOOLS
  1. Cursor       — .cursor/rules/*.mdc
  2. Aider        — CONVENTIONS.md + .aider.conf.yml
  3. Windsurf     — .windsurfrules
  4. Copilot      — .github/copilot-instructions.md + .github/instructions/
  5. Gemini CLI   — GEMINI.md + reference/

EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --project-dir)
      PROJECT_DIR="${2:-}"
      if [[ -z "$PROJECT_DIR" ]]; then
        echo "ERROR: --project-dir requires a path argument" >&2
        exit 1
      fi
      shift 2
      ;;
    --non-interactive)
      NON_INTERACTIVE=true
      shift
      ;;
    --help|-h)
      show_help
      exit 0
      ;;
    *)
      echo "ERROR: Unknown option: $1" >&2
      echo "Run with --help for usage." >&2
      exit 1
      ;;
  esac
done

# ---------------------------------------------------------------------------
# Preflight: integrations/ must exist and be non-empty
# ---------------------------------------------------------------------------

if [[ ! -d "$INTEGRATIONS_DIR" ]] || [[ -z "$(ls -A "$INTEGRATIONS_DIR" 2>/dev/null)" ]]; then
  echo ""
  echo "ERROR: integrations/ directory not found or empty."
  echo ""
  echo "Run convert.sh first to generate tool-specific formats:"
  echo "  bash scripts/convert.sh"
  echo ""
  exit 1
fi

# Create project dir if it doesn't exist
if [[ ! -d "$PROJECT_DIR" ]]; then
  mkdir -p "$PROJECT_DIR"
fi

# Resolve to absolute path
PROJECT_DIR="$(cd "$PROJECT_DIR" && pwd)"

# ---------------------------------------------------------------------------
# Tool detection
# ---------------------------------------------------------------------------

detect_cursor() {
  command -v cursor &>/dev/null || [[ -d "$HOME/.cursor" ]]
}

detect_aider() {
  command -v aider &>/dev/null
}

detect_windsurf() {
  command -v windsurf &>/dev/null || [[ -d "$HOME/.codeium" ]]
}

detect_copilot() {
  command -v code &>/dev/null || [[ -d "$HOME/.vscode" ]]
}

detect_gemini() {
  command -v gemini &>/dev/null || [[ -d "$HOME/.gemini" ]]
}

# Run detection; store results (1=detected, 0=not found)
CURSOR_DETECTED=0
AIDER_DETECTED=0
WINDSURF_DETECTED=0
COPILOT_DETECTED=0
GEMINI_DETECTED=0

detect_cursor   && CURSOR_DETECTED=1   || true
detect_aider    && AIDER_DETECTED=1    || true
detect_windsurf && WINDSURF_DETECTED=1 || true
detect_copilot  && COPILOT_DETECTED=1  || true
detect_gemini   && GEMINI_DETECTED=1   || true

DETECTED=("$CURSOR_DETECTED" "$AIDER_DETECTED" "$WINDSURF_DETECTED" "$COPILOT_DETECTED" "$GEMINI_DETECTED")

# ---------------------------------------------------------------------------
# Selection state
# ---------------------------------------------------------------------------

TOOL_NAMES=("Cursor" "Aider" "Windsurf" "GitHub Copilot" "Gemini CLI")
# selected[i]: 1 = will install, 0 = skip
SELECTED=(0 0 0 0 0)

# ---------------------------------------------------------------------------
# Interactive selection UI
# ---------------------------------------------------------------------------

show_selection() {
  clear 2>/dev/null || printf '\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n'
  echo ""
  echo "  dgtldept Skills — Multi-Tool Installer"
  echo ""
  echo "  Select tools to install for:"
  echo ""
  for i in 0 1 2 3 4; do
    local num=$((i + 1))
    local name="${TOOL_NAMES[$i]}"
    local check=" "
    [[ "${SELECTED[$i]}" == "1" ]] && check="*"
    local status="not found"
    [[ "${DETECTED[$i]}" == "1" ]] && status="detected"
    printf "    [%s] %d. %-16s (%s)\n" "$check" "$num" "$name" "$status"
  done
  echo ""
  echo "  1-5: toggle  |  d: detected only  |  a: all  |  n: none  |  Enter: install"
  echo ""
}

run_selection_ui() {
  # Pre-select detected tools as default
  for i in 0 1 2 3 4; do
    SELECTED[$i]="${DETECTED[$i]}"
  done

  while true; do
    show_selection
    # Read single character (no newline needed)
    IFS= read -rsn1 key || key=""

    case "$key" in
      1) [[ "${SELECTED[0]}" == "1" ]] && SELECTED[0]=0 || SELECTED[0]=1 ;;
      2) [[ "${SELECTED[1]}" == "1" ]] && SELECTED[1]=0 || SELECTED[1]=1 ;;
      3) [[ "${SELECTED[2]}" == "1" ]] && SELECTED[2]=0 || SELECTED[2]=1 ;;
      4) [[ "${SELECTED[3]}" == "1" ]] && SELECTED[3]=0 || SELECTED[3]=1 ;;
      5) [[ "${SELECTED[4]}" == "1" ]] && SELECTED[4]=0 || SELECTED[4]=1 ;;
      d)
        for i in 0 1 2 3 4; do SELECTED[$i]="${DETECTED[$i]}"; done
        ;;
      a)
        for i in 0 1 2 3 4; do SELECTED[$i]=1; done
        ;;
      n)
        for i in 0 1 2 3 4; do SELECTED[$i]=0; done
        ;;
      "") # Enter key
        break
        ;;
    esac
  done
}

# ---------------------------------------------------------------------------
# Per-tool install functions
# ---------------------------------------------------------------------------

install_cursor() {
  local project_dir="$1"
  local dest="$project_dir/.cursor/rules"
  local src="$INTEGRATIONS_DIR/cursor"

  if [[ ! -d "$src" ]]; then
    echo "  WARNING: integrations/cursor/ not found — skipping Cursor install." >&2
    return 0
  fi

  mkdir -p "$dest"

  local count=0
  for f in "$src"/*.mdc; do
    [[ -f "$f" ]] || continue
    cp "$f" "$dest/"
    count=$((count + 1))
  done

  echo "  Cursor: installed $count rule files to .cursor/rules/"
}

install_aider() {
  local project_dir="$1"
  local src_conventions="$INTEGRATIONS_DIR/aider/CONVENTIONS.md"
  local dest_conventions="$project_dir/CONVENTIONS.md"
  local conf_file="$project_dir/.aider.conf.yml"

  if [[ ! -f "$src_conventions" ]]; then
    echo "  WARNING: integrations/aider/CONVENTIONS.md not found — skipping Aider install." >&2
    return 0
  fi

  # Copy CONVENTIONS.md
  cp "$src_conventions" "$dest_conventions"

  # Create or update .aider.conf.yml
  if [[ -f "$conf_file" ]]; then
    # Check if CONVENTIONS.md is already referenced
    if grep -q "CONVENTIONS.md" "$conf_file" 2>/dev/null; then
      echo "  Aider: CONVENTIONS.md installed. .aider.conf.yml already references CONVENTIONS.md — no changes needed."
    else
      # Append read: CONVENTIONS.md entry
      printf '\n# Added by dgtldept install.sh\nread: CONVENTIONS.md\n' >> "$conf_file"
      echo "  Aider: CONVENTIONS.md installed. .aider.conf.yml updated (read: CONVENTIONS.md added)."
    fi
  else
    # Create fresh .aider.conf.yml
    printf 'read: CONVENTIONS.md\n' > "$conf_file"
    echo "  Aider: CONVENTIONS.md installed. Created .aider.conf.yml with read: CONVENTIONS.md."
  fi
}

install_windsurf() {
  local project_dir="$1"
  local src="$INTEGRATIONS_DIR/windsurf/.windsurfrules"
  local dest="$project_dir/.windsurfrules"

  if [[ ! -f "$src" ]]; then
    echo "  WARNING: integrations/windsurf/.windsurfrules not found — skipping Windsurf install." >&2
    return 0
  fi

  if [[ -f "$dest" ]]; then
    if [[ "$NON_INTERACTIVE" == "true" ]]; then
      cp "$src" "$dest"
      echo "  Windsurf: .windsurfrules overwritten (non-interactive mode)."
    else
      echo ""
      printf "  .windsurfrules already exists in project. Overwrite? [y/N] "
      IFS= read -r answer
      if [[ "$answer" =~ ^[Yy]$ ]]; then
        cp "$src" "$dest"
        echo "  Windsurf: .windsurfrules overwritten."
      else
        echo "  Windsurf: .windsurfrules kept unchanged."
      fi
    fi
  else
    cp "$src" "$dest"
    echo "  Windsurf: .windsurfrules installed."
  fi
}

install_copilot() {
  local project_dir="$1"
  local src="$INTEGRATIONS_DIR/copilot"
  local dest_github="$project_dir/.github"
  local dest_instructions="$dest_github/instructions"
  local dest_aggregate="$dest_github/copilot-instructions.md"

  if [[ ! -d "$src" ]]; then
    echo "  WARNING: integrations/copilot/ not found — skipping Copilot install." >&2
    return 0
  fi

  mkdir -p "$dest_instructions"

  # Copy per-skill .instructions.md files
  local count=0
  for f in "$src"/*.instructions.md; do
    [[ -f "$f" ]] || continue
    cp "$f" "$dest_instructions/"
    count=$((count + 1))
  done

  # Generate aggregated copilot-instructions.md
  {
    echo "# dgtldept Skills for GitHub Copilot"
    echo ""
    echo "This file is auto-generated by dgtldept install.sh."
    echo "It aggregates all skill instructions for use with VS Code Copilot Chat."
    echo ""
    for f in "$src"/*.instructions.md; do
      [[ -f "$f" ]] || continue
      local slug
      slug="$(basename "$f" .instructions.md)"
      echo "## $slug"
      echo ""
      # Strip frontmatter if present, then emit body.
      # If no frontmatter delimiters found, print entire file.
      awk 'BEGIN{in_fm=0; done=0; lines_seen=0}
           /^---$/{
             if(!done){
               if(in_fm){done=1}
               else{in_fm=1}
               next
             }
           }
           {
             lines_seen++
             if(done){print}
             else if(!in_fm){print}
           }' "$f"
      echo ""
    done
  } > "$dest_aggregate"

  echo "  Copilot: installed $count skill files to .github/instructions/"
  echo "  Copilot: generated .github/copilot-instructions.md (aggregated, universal)"
}

install_gemini() {
  local project_dir="$1"
  local src="$INTEGRATIONS_DIR/gemini"
  local dest_gemini_md="$project_dir/GEMINI.md"
  local dest_reference="$project_dir/reference"

  if [[ ! -f "$src/GEMINI.md" ]]; then
    echo "  WARNING: integrations/gemini/GEMINI.md not found — skipping Gemini install." >&2
    return 0
  fi

  # Copy GEMINI.md
  cp "$src/GEMINI.md" "$dest_gemini_md"

  # Copy reference/ directory tree (preserves @import relative paths)
  local ref_count=0
  if [[ -d "$src/reference" ]]; then
    mkdir -p "$dest_reference"
    for f in "$src/reference"/*.md; do
      [[ -f "$f" ]] || continue
      cp "$f" "$dest_reference/"
      ref_count=$((ref_count + 1))
    done
  fi

  echo "  Gemini: GEMINI.md installed."
  echo "  Gemini: $ref_count reference files installed to reference/"
}

# ---------------------------------------------------------------------------
# Main flow
# ---------------------------------------------------------------------------

main() {
  echo ""
  echo "  dgtldept Skills — Multi-Tool Installer"
  echo "  Target: $PROJECT_DIR"
  echo ""

  if [[ "$NON_INTERACTIVE" == "true" ]]; then
    # Auto-select all detected tools
    for i in 0 1 2 3 4; do
      SELECTED[$i]="${DETECTED[$i]}"
    done
    echo "  Non-interactive mode: selecting all detected tools."
    echo ""
    for i in 0 1 2 3 4; do
      local status="not found — skipping"
      [[ "${SELECTED[$i]}" == "1" ]] && status="detected — will install"
      printf "  %s: %s\n" "${TOOL_NAMES[$i]}" "$status"
    done
    echo ""
  else
    run_selection_ui
    clear 2>/dev/null || true
    echo ""
    echo "  Installing selected tools to: $PROJECT_DIR"
    echo ""
  fi

  # Count selected tools
  local any_selected=false
  for i in 0 1 2 3 4; do
    [[ "${SELECTED[$i]}" == "1" ]] && any_selected=true && break
  done

  if [[ "$any_selected" == "false" ]]; then
    echo "  No tools selected. Nothing to install."
    echo ""
    exit 0
  fi

  # Run installs
  [[ "${SELECTED[0]}" == "1" ]] && install_cursor   "$PROJECT_DIR"
  [[ "${SELECTED[1]}" == "1" ]] && install_aider     "$PROJECT_DIR"
  [[ "${SELECTED[2]}" == "1" ]] && install_windsurf  "$PROJECT_DIR"
  [[ "${SELECTED[3]}" == "1" ]] && install_copilot   "$PROJECT_DIR"
  [[ "${SELECTED[4]}" == "1" ]] && install_gemini    "$PROJECT_DIR"

  echo ""
  echo "  Installation complete."
  echo ""

  # Post-install notes
  local notes_shown=false
  if [[ "${SELECTED[1]}" == "1" ]]; then
    notes_shown=true
    echo "  Note (Aider): .aider.conf.yml updated — CONVENTIONS.md will auto-load next session."
  fi
  if [[ "${SELECTED[3]}" == "1" ]]; then
    notes_shown=true
    echo "  Note (Copilot): .github/copilot-instructions.md works with VS Code Copilot Chat."
    echo "                  Per-skill files in .github/instructions/ work with Copilot coding agent on GitHub.com."
  fi
  if [[ "${SELECTED[4]}" == "1" ]]; then
    notes_shown=true
    echo "  Note (Gemini): GEMINI.md uses @import paths — keep GEMINI.md and reference/ together."
  fi

  [[ "$notes_shown" == "true" ]] && echo ""
}

main "$@"
