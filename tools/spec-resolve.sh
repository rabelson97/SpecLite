#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TARGET_ROOT="${1:-$PWD}"
KIND="${2:-workflow}"
NAME="${3:-}"
[[ -n "$NAME" ]] || { echo "error: name required" >&2; exit 1; }

case "$KIND" in
  workflow) ext=".md"; built_in_dir="$ROOT_DIR/workflows" ;;
  doc) ext=".md"; built_in_dir="$ROOT_DIR/docs" ;;
  rule) ext=".md"; built_in_dir="$ROOT_DIR/rules" ;;
  skill) ext=".md"; built_in_dir="$ROOT_DIR/skills" ;;
  agent) ext=".md"; built_in_dir="$ROOT_DIR/agents" ;;
  *) echo "error: unknown kind: $KIND" >&2; exit 1 ;;
esac

project_path="$TARGET_ROOT/.speclite/${KIND}s/$NAME$ext"
user_path="$HOME/.speclite/${KIND}s/$NAME$ext"
builtin_path="$built_in_dir/$NAME"
[[ -f "$builtin_path" ]] || builtin_path="$built_in_dir/$NAME/workflow.md"

if [[ -f "$project_path" ]]; then
  printf 'source=project
path=%s
' "$project_path"
elif [[ -f "$user_path" ]]; then
  printf 'source=user
path=%s
' "$user_path"
elif [[ -f "$builtin_path" ]]; then
  printf 'source=builtin
path=%s
' "$builtin_path"
else
  printf 'source=missing
path=
'
  exit 2
fi
