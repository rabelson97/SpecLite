#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

chmod +x "$ROOT_DIR/tools/index-codebase.sh" \
  "$ROOT_DIR/tools/install-integrations.sh" \
  "$ROOT_DIR/tools/manage-workflow.sh" \
  "$ROOT_DIR/tools/run-workers.sh" \
  "$ROOT_DIR/tools/setup.sh" \
  "$ROOT_DIR/tools/cleanup-cache.sh" \
  "$ROOT_DIR/tools/save-learnings.sh" \
  "$ROOT_DIR/tools/new-run.sh" \
  "$ROOT_DIR/tools/run-phase.sh"

echo "setup complete"
