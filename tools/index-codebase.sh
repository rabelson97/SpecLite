#!/usr/bin/env bash
set -euo pipefail

# Usage: index-codebase.sh <output_dir> [roots]
# roots: comma-separated list of paths; default: current working directory

OUT_DIR="$1"
ROOTS_RAW="${2:-}"

[[ -n "$OUT_DIR" ]] || { echo "output dir required" >&2; exit 1; }
mkdir -p "$OUT_DIR"

IFS=',' read -r -a ROOTS <<< "$ROOTS_RAW"
if [[ -z "$ROOTS_RAW" ]]; then
  ROOTS=("$(pwd)")
fi

FILES_TMP="$OUT_DIR/files.tmp"
> "$FILES_TMP"

for root in "${ROOTS[@]}"; do
  if [[ -d "$root" ]]; then
    rg --files "$root" >> "$FILES_TMP" || true
  elif [[ -f "$root" ]]; then
    echo "$root" >> "$FILES_TMP"
  fi
done

sort -u "$FILES_TMP" > "$OUT_DIR/files.txt"
rm -f "$FILES_TMP"

# Extension counts
awk -F. 'NF==1{ext="(none)"} NF>1{ext=$NF} {count[ext]++} END{for (e in count) printf "%s %d\n", e, count[e]}' "$OUT_DIR/files.txt" \
  | sort -k2,2nr > "$OUT_DIR/extensions.txt"

# Largest files
while IFS= read -r f; do
  if [[ -f "$f" ]]; then
    if stat -f%z "$f" >/dev/null 2>&1; then
      size=$(stat -f%z "$f")
    else
      size=$(stat -c%s "$f")
    fi
    printf "%s %s\n" "$size" "$f"
  fi
done < "$OUT_DIR/files.txt" | sort -k1,1nr | head -n 50 > "$OUT_DIR/largest_files.txt"

# Directory summary
awk -F/ '{dir=$1; for(i=2;i<NF;i++) dir=dir"/"$i; count[dir]++} END{for (d in count) printf "%s %d\n", d, count[d]}' "$OUT_DIR/files.txt" \
  | sort -k2,2nr > "$OUT_DIR/directories.txt"

