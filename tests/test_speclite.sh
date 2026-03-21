#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TMP_BASE="$(mktemp -d)"
trap 'rm -rf "$TMP_BASE"' EXIT

PROJECT="$TMP_BASE/project"
mkdir -p "$PROJECT"
cd "$PROJECT"
git init -q
printf '# Demo
' > README.md

"$ROOT_DIR/bin/speclite" init "$PROJECT" >/dev/null
[[ -f "$PROJECT/.speclite/project.md" ]]

LIST_OUT="$($ROOT_DIR/bin/speclite workflow list)"
printf '%s
' "$LIST_OUT" | grep -q 'brainstorm'
if printf '%s
' "$LIST_OUT" | grep -q 'README'; then
  echo 'README leaked into workflow list' >&2
  exit 1
fi

RUN_DIR="$($ROOT_DIR/bin/speclite new-run "Demo Project")"
[[ -f "$RUN_DIR/meta.json" ]]
printf '%s
' "$RUN_DIR" | grep -q '/.speclite/runs/'

"$ROOT_DIR/bin/speclite" run-phase requirements "$RUN_DIR" --project "Demo Project" >/dev/null
"$ROOT_DIR/bin/speclite" run-phase research "$RUN_DIR" --roots "." >/dev/null
"$ROOT_DIR/bin/speclite" run-phase plan "$RUN_DIR" >/dev/null

grep -q 'Project Rules to Respect' "$RUN_DIR/requirements/requirements.md"
grep -q 'Project Docs Reviewed' "$RUN_DIR/research/research.md"
grep -q 'Success Criteria' "$RUN_DIR/plan/plan.md"

echo 'ok'
