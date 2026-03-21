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
  echo "Usage: $0 [--codex] [--kiro] [--cursor] [--claude] [--project]"
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
do_claude=false
project_scope=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --codex) do_codex=true; shift ;;
    --kiro) do_kiro=true; shift ;;
    --cursor) do_cursor=true; shift ;;
    --claude) do_claude=true; shift ;;
    --project) project_scope=true; shift ;;
    -h|--help) usage ;;
    *) echo "Unknown: $1"; usage ;;
  esac
done

if [[ "$do_codex" != "true" && "$do_kiro" != "true" && "$do_cursor" != "true" && "$do_claude" != "true" ]]; then
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
  CLAUDE_DEST=".claude/commands"
else
  CODEX_SKILLS_DEST="$HOME/.codex/skills"
  CODEX_PROMPTS_DEST="$HOME/.codex/prompts"
  KIRO_DEST="$HOME/.kiro/agents"
  CURSOR_DEST="$HOME/.cursor/commands"
  CLAUDE_DEST="$HOME/.claude/commands"
fi

WORKFLOWS=(
  "brainstorm:brainstorm"
  "debug:debug"
  "discovery:discovery"
  "enhance:enhance"
  "orchestrate:orchestrate"
  "requirements:requirements"
  "research:research"
  "plan:plan"
  "implementation:implement"
  "status:status"
  "validation:validate"
  "version-control:version-control"
  "workflow:workflow"
)
CODEX_SKILLS=(
  "ai-assisted-framework:$FRAMEWORK_PATH"
  "framework-brainstorm:$FRAMEWORK_PATH/integrations/codex/skills/framework-brainstorm"
  "framework-debug:$FRAMEWORK_PATH/integrations/codex/skills/framework-debug"
  "framework-discovery:$FRAMEWORK_PATH/integrations/codex/skills/framework-discovery"
  "framework-enhance:$FRAMEWORK_PATH/integrations/codex/skills/framework-enhance"
  "framework-orchestrate:$FRAMEWORK_PATH/integrations/codex/skills/framework-orchestrate"
  "framework-requirements:$FRAMEWORK_PATH/integrations/codex/skills/framework-requirements"
  "framework-research:$FRAMEWORK_PATH/integrations/codex/skills/framework-research"
  "framework-plan:$FRAMEWORK_PATH/integrations/codex/skills/framework-plan"
  "framework-implement:$FRAMEWORK_PATH/integrations/codex/skills/framework-implement"
  "framework-status:$FRAMEWORK_PATH/integrations/codex/skills/framework-status"
  "framework-validate:$FRAMEWORK_PATH/integrations/codex/skills/framework-validate"
  "framework-version-control:$FRAMEWORK_PATH/integrations/codex/skills/framework-version-control"
  "framework-workflow:$FRAMEWORK_PATH/integrations/codex/skills/framework-workflow"
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
  CURSOR_PHASES=(
    "brainstorm:brainstorm"
    "debug:debug"
    "discovery:discovery"
    "enhance:enhance"
    "orchestrate:orchestrate"
    "requirements:requirements"
    "research:research"
    "plan:plan"
    "implement:implementation"
    "status:status"
    "validate:validation"
    "version-control:version-control"
    "workflow:workflow"
  )
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


if [[ "$do_claude" == "true" ]]; then
  mkdir -p "$CLAUDE_DEST"
  CLAUDE_COMMANDS=(brainstorm debug discovery enhance orchestrate requirements research plan implement status validate version-control workflow)
  for name in "${CLAUDE_COMMANDS[@]}"; do
    src="$FRAMEWORK_PATH/integrations/claude/commands/$name.md"
    dest="$CLAUDE_DEST/$name.md"
    if [[ -f "$src" ]]; then
      ensure_link "$src" "$dest" "Claude command"
    fi
  done
fi
