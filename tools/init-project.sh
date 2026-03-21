#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TARGET_DIR="${1:-$PWD}"
TEMPLATE_DIR="$ROOT_DIR/templates/project/.speclite"
DEST_DIR="$TARGET_DIR/.speclite"

[[ -d "$TEMPLATE_DIR" ]] || { echo "error: template not found: $TEMPLATE_DIR" >&2; exit 1; }
mkdir -p "$TARGET_DIR"
if [[ -e "$DEST_DIR" ]]; then
  echo "SpecLite project files already exist at: $DEST_DIR"
  exit 0
fi
cp -R "$TEMPLATE_DIR" "$DEST_DIR"
echo "Initialized SpecLite project files at: $DEST_DIR"
