#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

chmod +x "$ROOT_DIR/bin/speclite" \
  "$ROOT_DIR/tools/index-codebase.sh" \
  "$ROOT_DIR/tools/init-project.sh" \
  "$ROOT_DIR/tools/install-integrations.sh" \
  "$ROOT_DIR/tools/setup.sh" \
  "$ROOT_DIR/tools/new-run.sh" \
  "$ROOT_DIR/tools/run-phase.sh" \
  "$ROOT_DIR/tools/spec-resolve.sh" \
  "$ROOT_DIR/tools/workflow-studio.sh" \
  "$ROOT_DIR/tests/test_speclite.sh"

echo "setup complete"
