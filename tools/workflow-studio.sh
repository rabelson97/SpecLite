#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TARGET_ROOT="${SPECLITE_TARGET_ROOT:-$PWD}"
ACTION="${1:-}"
NAME="${2:-}"

usage() {
  cat <<EOF
Usage:
  $0 list
  $0 explain <name>
  $0 new <name>
  $0 doctor
EOF
}

list_workflows() {
  echo "Built-in workflows:"
  find "$ROOT_DIR/workflows" -mindepth 1 -maxdepth 2 -name workflow.md | sed "s|$ROOT_DIR/workflows/||" | sed 's|/workflow.md$||' | sort | sed 's/^/  - /'
  echo
  echo "Project workflows ($TARGET_ROOT/.speclite/workflows):"
  if [[ -d "$TARGET_ROOT/.speclite/workflows" ]]; then
    find "$TARGET_ROOT/.speclite/workflows" -maxdepth 1 -type f -name '*.md' | xargs -r -n1 basename | sed 's/\.md$//' | sort | sed 's/^/  - /'
  else
    echo "  (none)"
  fi
}

explain_workflow() {
  [[ -n "$NAME" ]] || { echo "error: name required" >&2; exit 1; }
  "$ROOT_DIR/tools/spec-resolve.sh" "$TARGET_ROOT" workflow "$NAME"
}

new_workflow() {
  [[ -n "$NAME" ]] || { echo "error: name required" >&2; exit 1; }
  mkdir -p "$TARGET_ROOT/.speclite/workflows"
  dest="$TARGET_ROOT/.speclite/workflows/$NAME.md"
  [[ ! -e "$dest" ]] || { echo "error: already exists: $dest" >&2; exit 1; }
  cat > "$dest" <<EOF
---
description: Project workflow: $NAME
argument-hint: [task]
---

# $NAME

## Goal

Describe what this workflow is for.

## Inputs

- project docs in \.speclite/docs/
- project rules in \.speclite/rules/
- relevant runs in runs/

## Behavior

1. Restate the task.
2. Gather relevant docs and rules.
3. Choose the smallest correct path.
4. Update the appropriate run artifacts.
5. Summarize next steps.
EOF
  echo "Created: $dest"
}

doctor_workflows() {
  echo "Checking project structure..."
  for d in .speclite .speclite/workflows .speclite/docs .speclite/rules; do
    if [[ -e "$TARGET_ROOT/$d" ]]; then
      echo "  ok: $d"
    else
      echo "  missing: $d"
    fi
  done
  echo "Checking integration files..."
  for p in "$ROOT_DIR/integrations/claude" "$ROOT_DIR/integrations/codex" "$ROOT_DIR/integrations/kiro"; do
    [[ -d "$p" ]] && echo "  ok: ${p#$ROOT_DIR/}" || echo "  missing: ${p#$ROOT_DIR/}"
  done
}

case "$ACTION" in
  list) list_workflows ;;
  explain) explain_workflow ;;
  new) new_workflow ;;
  doctor) doctor_workflows ;;
  *) usage; exit 1 ;;
esac
