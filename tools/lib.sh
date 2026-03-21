#!/usr/bin/env bash
set -euo pipefail

now_iso() { date -u "+%Y-%m-%dT%H:%M:%SZ"; }
now_slug() { date -u "+%Y%m%d_%H%M%S"; }

speclite_project_root() {
  if [[ -n "${SPECLITE_PROJECT_ROOT:-}" ]]; then
    printf "%s\n" "$SPECLITE_PROJECT_ROOT"
    return 0
  fi

  local dir="${PWD}"
  while [[ "$dir" != "/" ]]; do
    if [[ -d "$dir/.speclite" ]]; then
      printf "%s\n" "$dir"
      return 0
    fi
    dir="$(dirname "$dir")"
  done

  printf "%s\n" "$PWD"
}

speclite_runs_dir() {
  local project_root
  project_root="$(speclite_project_root)"
  printf "%s/.speclite/runs\n" "$project_root"
}

slugify() {
  local s="$1"
  s="$(printf \"%s\" \"$s\" | tr '[:upper:]' '[:lower:]')"
  s="${s// /-}"
  s="${s//[^a-z0-9._-]/}"
  echo "$s"
}

ensure_dir() {
  local d="$1"
  mkdir -p "$d"
}

fail() {
  echo "error: $*" >&2
  exit 1
}

require_run_dir() {
  local run_dir="$1"
  [[ -n "$run_dir" ]] || fail "run directory is required"
  [[ -d "$run_dir" ]] || fail "run directory not found: $run_dir"
  [[ -f "$run_dir/meta.json" ]] || fail "not a run directory (missing meta.json): $run_dir"
}

write_header() {
  local file="$1"
  local title="$2"
  local run_id="$3"
  local created_at
  created_at="$(now_iso)"
  cat > "$file" <<HDR
# $title

- run_id: $run_id
- created_at: $created_at

HDR
}

append_section() {
  local file="$1"
  local heading="$2"
  printf "\n## %s\n\n" "$heading" >> "$file"
}

maybe_cat_input() {
  local file="$1"
  local input_file="${2:-}"
  if [[ -n "$input_file" ]]; then
    [[ -f "$input_file" ]] || fail "input file not found: $input_file"
    cat "$input_file" >> "$file"
  else
    printf "(no input provided)\n" >> "$file"
  fi
}

stat_size() {
  local file="$1"
  if stat -f%z "$file" >/dev/null 2>&1; then
    stat -f%z "$file"
  else
    stat -c%s "$file"
  fi
}

capitalize() {
  printf "%s" "$1" | awk '{print toupper(substr($0,1,1)) substr($0,2)}'
}
