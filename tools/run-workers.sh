#!/usr/bin/env bash
set -euo pipefail

# Usage: run-workers.sh <input_list> <workers> <out_dir> [command]
# command can include {chunk} placeholder; if not provided, only chunk files are created

INPUT_LIST="$1"
WORKERS="$2"
OUT_DIR="$3"
COMMAND_TEMPLATE="${4:-}"

[[ -f "$INPUT_LIST" ]] || { echo "input list not found: $INPUT_LIST" >&2; exit 1; }
[[ "$WORKERS" =~ ^[0-9]+$ ]] || { echo "workers must be a number" >&2; exit 1; }
mkdir -p "$OUT_DIR"

# Create empty chunk files
for i in $(seq 1 "$WORKERS"); do
  : > "$OUT_DIR/chunk_$i.txt"
done

# Round-robin distribution
idx=1
while IFS= read -r line; do
  echo "$line" >> "$OUT_DIR/chunk_$idx.txt"
  idx=$((idx+1))
  if [[ "$idx" -gt "$WORKERS" ]]; then
    idx=1
  fi
done < "$INPUT_LIST"

if [[ -n "$COMMAND_TEMPLATE" ]]; then
  for i in $(seq 1 "$WORKERS"); do
    chunk="$OUT_DIR/chunk_$i.txt"
    cmd="${COMMAND_TEMPLATE//\{chunk\}/$chunk}"
    bash -lc "$cmd" &
  done
  wait
fi

printf "chunks created in %s\n" "$OUT_DIR"
