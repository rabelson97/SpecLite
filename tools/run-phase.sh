#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
# shellcheck source=./tools/lib.sh
. "$ROOT_DIR/tools/lib.sh"

phase="${1:-}"
shift || true
[[ -n "$phase" ]] || fail "phase required"

run_dir="${1:-}"
if [[ -n "$run_dir" && "$run_dir" != --* ]]; then
  shift
else
  run_dir=""
fi

resolve_run_dir() {
  local input="${1:-}"
  if [[ -n "$input" ]]; then
    echo "$input"
    return 0
  fi

  local runs_dir="$ROOT_DIR/runs"
  [[ -d "$runs_dir" ]] || fail "no runs directory found; create one with tools/new-run.sh"

  local runs=()
  while IFS= read -r line; do
    [[ -n "$line" ]] && runs+=("$line")
  done < <(ls -1t "$runs_dir" 2>/dev/null || true)
  [[ ${#runs[@]} -gt 0 ]] || fail "no runs found; create one with tools/new-run.sh"

  echo "Available runs:" >&2
  for i in "${!runs[@]}"; do
    printf "  %d) %s\n" "$((i+1))" "${runs[i]}" >&2
  done

  printf "Select run (1-%d, default 1) or enter path: " "${#runs[@]}" >&2
  local choice=""
  read -r choice
  if [[ -z "$choice" ]]; then
    choice="1"
  fi

  if [[ "$choice" =~ ^[0-9]+$ ]]; then
    local idx=$((choice-1))
    [[ $idx -ge 0 && $idx -lt ${#runs[@]} ]] || fail "invalid selection: $choice"
    input="$runs_dir/${runs[$idx]}"
  else
    input="$choice"
  fi

  echo "$input"
}

ensure_run_for_requirements() {
  local name="${1:-}"
  if [[ -z "$name" ]]; then
    printf "Project name for new run: " >&2
    read -r name
  fi
  [[ -n "$name" ]] || fail "project name required"
  "$ROOT_DIR/tools/new-run.sh" "$name"
}

case "$phase" in
  discovery)
    topics=""
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --topics) topics="$2"; shift 2;;
        *) fail "unknown argument: $1";;
      esac
    done
    run_dir="$(resolve_run_dir "$run_dir")"
    require_run_dir "$run_dir"
    out="$run_dir/discovery/discovery.md"
    write_header "$out" "Discovery" "$(basename "$run_dir")"
    append_section "$out" "Research Topics"
    if [[ -n "$topics" ]]; then
      IFS=',' read -ra topic_arr <<< "$topics"
      for topic in "${topic_arr[@]}"; do
        printf "- %s\n" "$topic" >> "$out"
      done
    else
      printf "(add research topics here)\n" >> "$out"
    fi
    append_section "$out" "Findings"
    printf "(add research findings organized by topic)\n" >> "$out"
    append_section "$out" "Recommendations"
    printf "(add high-level approach recommendations)\n" >> "$out"
    sources="$run_dir/discovery/sources.md"
    write_header "$sources" "Sources" "$(basename "$run_dir")"
    printf "(add all referenced URLs and citations here)\n" >> "$sources"
    echo "$out"
    ;;
  requirements)
    input_file=""
    project_name=""
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --input) input_file="$2"; shift 2;;
        --project) project_name="$2"; shift 2;;
        *) fail "unknown argument: $1";;
      esac
    done

    if [[ -z "$run_dir" ]]; then
      run_dir="$(ensure_run_for_requirements "$project_name")"
    fi
    require_run_dir "$run_dir"

    out="$run_dir/requirements/requirements.md"
    write_header "$out" "Requirements" "$(basename "$run_dir")"
    append_section "$out" "Problem Statement"
    if [[ -n "$input_file" ]]; then
      [[ -f "$input_file" ]] || fail "input file not found: $input_file"
      cat "$input_file" >> "$out"
    else
      printf "(add problem statement here)\n" >> "$out"
    fi
    append_section "$out" "Clarifications"
    printf "(add clarifying questions and answers here)\n" >> "$out"
    echo "$out"
    ;;
  research)
    roots=""
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --roots) roots="$2"; shift 2;;
        *) fail "unknown argument: $1";;
      esac
    done
    run_dir="$(resolve_run_dir "$run_dir")"
    require_run_dir "$run_dir"
    if [[ -z "$roots" ]]; then
      roots="$ROOT_DIR"
    fi
    out="$run_dir/research/research.md"
    write_header "$out" "Research" "$(basename "$run_dir")"
    append_section "$out" "Index Summary"
    idx_dir="$run_dir/research/index"
    ensure_dir "$idx_dir"
    "$ROOT_DIR/tools/index-codebase.sh" "$idx_dir" "$roots"
    printf '%s\n' "- file_list: ${idx_dir}/files.txt" >> "$out"
    printf '%s\n' "- extension_counts: ${idx_dir}/extensions.txt" >> "$out"
    printf '%s\n' "- largest_files: ${idx_dir}/largest_files.txt" >> "$out"
    append_section "$out" "Notes"
    printf "(add research notes here)\n" >> "$out"
    echo "$out"
    ;;
  plan)
    input_file=""
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --input) input_file="$2"; shift 2;;
        *) fail "unknown argument: $1";;
      esac
    done
    run_dir="$(resolve_run_dir "$run_dir")"
    require_run_dir "$run_dir"
    out="$run_dir/plan/plan.md"
    write_header "$out" "Plan" "$(basename "$run_dir")"
    append_section "$out" "Goal"
    printf "(add goal statement)\n" >> "$out"
    append_section "$out" "Success Criteria"
    printf "(add success criteria)\n" >> "$out"
    append_section "$out" "Top Gaps/Risks"
    printf "(add ranked gaps/risks)\n" >> "$out"
    append_section "$out" "Plan"
    if [[ -n "$input_file" ]]; then
      [[ -f "$input_file" ]] || fail "input file not found: $input_file"
      cat "$input_file" >> "$out"
    else
      printf "(add plan overview)\n" >> "$out"
    fi
    append_section "$out" "Phases"
    printf '%s\n' "- 1. (phase goal) — Scope: (files/areas). Outcome: (expected result)" >> "$out"
    echo "$out"
    ;;
  implementation)
    input_file=""
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --input) input_file="$2"; shift 2;;
        *) fail "unknown argument: $1";;
      esac
    done
    run_dir="$(resolve_run_dir "$run_dir")"
    require_run_dir "$run_dir"
    out="$run_dir/implementation/implementation.md"
    write_header "$out" "Implementation" "$(basename "$run_dir")"
    append_section "$out" "Phase"
    printf "(identify the phase being implemented)\n" >> "$out"
    append_section "$out" "Changes"
    if [[ -n "$input_file" ]]; then
      [[ -f "$input_file" ]] || fail "input file not found: $input_file"
      cat "$input_file" >> "$out"
    else
      printf "(summarize completed changes)\n" >> "$out"
    fi
    append_section "$out" "Notes"
    printf "(add decisions, follow-ups, or blockers)\n" >> "$out"
    echo "$out"
    ;;
  validation)
    test_cmd=""
    input_file=""
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --test-cmd) test_cmd="$2"; shift 2;;
        --input) input_file="$2"; shift 2;;
        *) fail "unknown argument: $1";;
      esac
    done
    run_dir="$(resolve_run_dir "$run_dir")"
    require_run_dir "$run_dir"
    out="$run_dir/validation/validation.md"
    write_header "$out" "Validation" "$(basename "$run_dir")"
    append_section "$out" "Summary"
    printf "(record pass/fail status and high-level findings)\n" >> "$out"
    append_section "$out" "Notes"
    if [[ -n "$input_file" ]]; then
      [[ -f "$input_file" ]] || fail "input file not found: $input_file"
      cat "$input_file" >> "$out"
    else
      printf "(add validation notes)\n" >> "$out"
    fi
    if [[ -n "$test_cmd" ]]; then
      append_section "$out" "Test Command"
      printf "\`\`\`\n%s\n\`\`\`\n" "$test_cmd" >> "$out"
      append_section "$out" "Test Output"
      (cd "$ROOT_DIR" && bash -lc "$test_cmd") > "$run_dir/validation/test-output.txt" 2>&1 || true
      printf "See %s\n" "$run_dir/validation/test-output.txt" >> "$out"
    else
      append_section "$out" "Test Command"
      printf "(add test command or note not run)\n" >> "$out"
      append_section "$out" "Test Output"
      printf "(add test output or link)\n" >> "$out"
    fi
    echo "$out"
    ;;
  version-control)
    do_status="false"
    do_diff="false"
    commit_msg=""
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --status) do_status="true"; shift;;
        --diff) do_diff="true"; shift;;
        --commit) commit_msg="$2"; shift 2;;
        *) fail "unknown argument: $1";;
      esac
    done
    run_dir="$(resolve_run_dir "$run_dir")"
    require_run_dir "$run_dir"
    out="$run_dir/version-control/version-control.md"
    write_header "$out" "Version Control" "$(basename "$run_dir")"
    append_section "$out" "Summary"
    printf "(summarize status, diffs, and commit decisions)\n" >> "$out"

    if [[ -d "$ROOT_DIR/.git" ]]; then
      if [[ "$do_status" == "true" ]]; then
        append_section "$out" "Git Status"
        (cd "$ROOT_DIR" && git status -sb) > "$run_dir/version-control/git-status.txt" 2>&1 || true
        printf "See %s\n" "$run_dir/version-control/git-status.txt" >> "$out"

        append_section "$out" "Git Diff Stat"
        (cd "$ROOT_DIR" && git diff --stat) > "$run_dir/version-control/git-diff-stat.txt" 2>&1 || true
        printf "See %s\n" "$run_dir/version-control/git-diff-stat.txt" >> "$out"
      fi

      if [[ "$do_diff" == "true" ]]; then
        append_section "$out" "Git Diff"
        (cd "$ROOT_DIR" && git diff) > "$run_dir/version-control/git-diff.txt" 2>&1 || true
        printf "See %s\n" "$run_dir/version-control/git-diff.txt" >> "$out"
      fi

      if [[ -n "$commit_msg" ]]; then
        append_section "$out" "Commit"
        printf "Attempted commit with message: %s\n" "$commit_msg" >> "$out"
        printf "(Commit runs only when --commit is provided; no push is performed.)\n" >> "$out"

        # Capture commit output for auditability.
        (
          cd "$ROOT_DIR"
          git add -A
          git commit -m "$commit_msg"
        ) > "$run_dir/version-control/git-commit.txt" 2>&1 || true

        printf "See %s\n" "$run_dir/version-control/git-commit.txt" >> "$out"
      else
        append_section "$out" "Notes"
        printf "(add commit rationale or note if no commit)\n" >> "$out"
      fi
    else
      append_section "$out" "Notes"
      printf "No git repository detected at %s\n" "$ROOT_DIR" >> "$out"
    fi

    echo "$out"
    ;;
  *)
    fail "unknown phase: $phase"
    ;;
esac
