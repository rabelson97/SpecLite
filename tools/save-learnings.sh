#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
RUN_DIR="$1"

[[ -n "$RUN_DIR" ]] || { echo "run dir required" >&2; exit 1; }
[[ -d "$RUN_DIR" ]] || { echo "run dir not found: $RUN_DIR" >&2; exit 1; }

OUT_FILE="$RUN_DIR/learnings.md"
RUN_ID="$(basename "$RUN_DIR")"

cat > "$OUT_FILE" <<HDR
# Learnings Summary

- run_id: $RUN_ID
- created_at: $(date -u "+%Y-%m-%dT%H:%M:%SZ")

HDR

summarize_file() {
  local label="$1"
  local file="$2"
  if [[ -f "$file" ]]; then
    printf "## %s\n\n" "$label" >> "$OUT_FILE"
    awk 'NF{print "- " $0; c++} c==6{exit}' "$file" >> "$OUT_FILE"
    printf "\nSource: %s\n\n" "$file" >> "$OUT_FILE"
  fi
}

summarize_file "Requirements" "$RUN_DIR/requirements/requirements.md"
summarize_file "Research" "$RUN_DIR/research/research.md"
summarize_file "Plan" "$RUN_DIR/plan/plan.md"
summarize_file "Implementation" "$RUN_DIR/implementation/implementation.md"
summarize_file "Validation" "$RUN_DIR/validation/validation.md"
summarize_file "Version Control" "$RUN_DIR/version-control/version-control.md"

echo "$OUT_FILE"
