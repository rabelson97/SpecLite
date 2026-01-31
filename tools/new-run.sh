#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
# shellcheck source=./tools/lib.sh
. "$ROOT_DIR/tools/lib.sh"

name="${1:-}"
[[ -n "$name" ]] || fail "project name required"

slug="$(slugify "$name")"
run_id="$(now_slug)_$slug"
run_dir="$ROOT_DIR/runs/$run_id"

ensure_dir "$run_dir"
cat > "$run_dir/meta.json" <<META
{"run_id":"$run_id","project_name":"$name","created_at":"$(now_iso)"}
META

for phase in requirements research plan implementation validation version-control; do
  ensure_dir "$run_dir/$phase/artifacts"
  write_header "$run_dir/$phase/notes.md" "$(capitalize "$phase") Notes" "$run_id"
  printf "Created phase folder: %s\n" "$phase" >> "$run_dir/$phase/notes.md"
done

echo "$run_dir"
