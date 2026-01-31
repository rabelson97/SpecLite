#!/usr/bin/env bash
# List workflow files and optionally open one for editing.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
WORKFLOWS_DIR="$ROOT_DIR/workflows"

list_workflows() {
  local i=1
  for dir in requirements research plan implementation validation version-control; do
    local wf="$WORKFLOWS_DIR/$dir/workflow.md"
    if [[ -f "$wf" ]]; then
      printf "  %d) %-16s %s\n" "$i" "$dir" "$wf"
      i=$((i + 1))
    fi
  done
}

open_workflow() {
  local target="$1"
  local path=""
  if [[ "$target" =~ ^[0-9]+$ ]]; then
    local dirs=(requirements research plan implementation validation version-control)
    local idx=$((target - 1))
    if [[ $idx -ge 0 && $idx -lt ${#dirs[@]} ]]; then
      path="$WORKFLOWS_DIR/${dirs[$idx]}/workflow.md"
    fi
  else
    path="$WORKFLOWS_DIR/$target/workflow.md"
  fi
  if [[ -n "$path" && -f "$path" ]]; then
    echo "$path"
    return 0
  fi
  return 1
}

case "${1:-list}" in
  list)
    echo "Workflow commands:"
    list_workflows
    echo ""
    echo "To edit: $0 open <number|name>"
    ;;
  open)
    if [[ -z "${2:-}" ]]; then
      echo "Usage: $0 open <number|name>" >&2
      exit 1
    fi
    if open_workflow "$2"; then
      : # path already printed
    else
      echo "Workflow not found: $2" >&2
      exit 1
    fi
    ;;
  *)
    echo "Usage: $0 [list|open <number|name>]" >&2
    exit 1
    ;;
esac
