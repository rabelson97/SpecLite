#!/usr/bin/env bash
# Symlink framework for Codex, Kiro, and Cursor. Uses symlinks only—never copies.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
FRAMEWORK_PATH="${FRAMEWORK_PATH:-$ROOT_DIR}"

ensure_link() {
  local src="$1"
  local dest="$2"
  local label="$3"
  if [[ -e "$dest" ]]; then
    echo "$label exists: $dest"
    return 0
  fi
  if [[ -L "$dest" ]]; then
    rm -f "$dest"
  fi
  ln -s "$src" "$dest"
  echo "$label: $dest -> $src"
}

usage() {
  echo "Usage: $0 [--codex] [--kiro] [--cursor] [--project]"
  echo ""
  echo "  --codex   Symlink for Codex: skills + prompts (~/.codex/skills, ~/.codex/prompts)"
  echo "  --kiro    Symlink for Kiro CLI (~/.kiro/agents/)"
  echo "  --cursor  Symlink for Cursor commands (~/.cursor/commands/)"
  echo "  --project Use project-scoped paths (run from project root)"
  echo ""
  echo "  Default: --codex --kiro (global)"
  echo "  All operations use symlinks only. Set FRAMEWORK_PATH to override framework location."
  exit 1
}

do_codex=false
do_kiro=false
do_cursor=false
project_scope=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --codex) do_codex=true; shift ;;
    --kiro) do_kiro=true; shift ;;
    --cursor) do_cursor=true; shift ;;
    --project) project_scope=true; shift ;;
    -h|--help) usage ;;
    *) echo "Unknown: $1"; usage ;;
  esac
done

if [[ "$do_codex" != "true" && "$do_kiro" != "true" && "$do_cursor" != "true" ]]; then
  do_codex=true
  do_kiro=true
fi

[[ -f "$FRAMEWORK_PATH/SKILL.md" ]] || { echo "SKILL.md not found at $FRAMEWORK_PATH"; exit 1; }
[[ -d "$FRAMEWORK_PATH/integrations/codex/skills" ]] || { echo "Codex skills dir not found at $FRAMEWORK_PATH/integrations/codex/skills"; exit 1; }

if [[ "$project_scope" == "true" ]]; then
  CODEX_SKILLS_DEST=".codex/skills"
  CODEX_PROMPTS_DEST=".codex/prompts"
  KIRO_DEST=".kiro/agents"
  CURSOR_DEST=".cursor/commands"
else
  CODEX_SKILLS_DEST="$HOME/.codex/skills"
  CODEX_PROMPTS_DEST="$HOME/.codex/prompts"
  KIRO_DEST="$HOME/.kiro/agents"
  CURSOR_DEST="$HOME/.cursor/commands"
fi

WORKFLOWS=("requirements:requirements" "research:research" "plan:plan" "implementation:implement" "validation:validate" "version-control:version-control")
CODEX_SKILLS=(
  "ai-assisted-framework:$FRAMEWORK_PATH"
  "framework-requirements:$FRAMEWORK_PATH/integrations/codex/skills/framework-requirements"
  "framework-research:$FRAMEWORK_PATH/integrations/codex/skills/framework-research"
  "framework-plan:$FRAMEWORK_PATH/integrations/codex/skills/framework-plan"
  "framework-implement:$FRAMEWORK_PATH/integrations/codex/skills/framework-implement"
  "framework-validate:$FRAMEWORK_PATH/integrations/codex/skills/framework-validate"
  "framework-version-control:$FRAMEWORK_PATH/integrations/codex/skills/framework-version-control"
)

if [[ "$do_codex" == "true" ]]; then
  mkdir -p "$CODEX_SKILLS_DEST"
  for entry in "${CODEX_SKILLS[@]}"; do
    skill_name="${entry%%:*}"
    skill_src="${entry##*:}"
    skill_dest="$CODEX_SKILLS_DEST/$skill_name"
    ensure_link "$skill_src" "$skill_dest" "Codex skill"
  done

  mkdir -p "$CODEX_PROMPTS_DEST"
  for entry in "${WORKFLOWS[@]}"; do
    phase="${entry%%:*}"
    prompt_name="${entry##*:}"
    src="$FRAMEWORK_PATH/workflows/$phase/workflow.md"
    dest="$CODEX_PROMPTS_DEST/framework.$prompt_name.md"
    if [[ -f "$src" ]]; then
      ensure_link "$src" "$dest" "Codex prompt"
    fi
  done
fi

if [[ "$do_kiro" == "true" ]]; then
  mkdir -p "$KIRO_DEST"
  for f in "$FRAMEWORK_PATH/integrations/kiro/agents"/*.json; do
    [[ -f "$f" ]] || continue
    name="$(basename "$f")"
    dest="$KIRO_DEST/$name"
    ensure_link "$f" "$dest" "Kiro agent"
  done
fi

if [[ "$do_cursor" == "true" ]]; then
  mkdir -p "$CURSOR_DEST"
  CURSOR_PHASES=("1-requirements:requirements" "2-research:research" "3-plan:plan" "4-implement:implementation" "5-validate:validation" "version-control:version-control")
  for entry in "${CURSOR_PHASES[@]}"; do
    cmd_name="${entry%%:*}"
    phase="${entry##*:}"
    src="$FRAMEWORK_PATH/workflows/$phase/workflow.md"
    dest="$CURSOR_DEST/$cmd_name.md"
    if [[ -f "$src" ]]; then
      ensure_link "$src" "$dest" "Cursor command"
    fi
  done
fi

echo ""
echo "Done. Restart Codex/Cursor to pick up prompt changes."
