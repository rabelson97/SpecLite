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

warn() {
  echo "warn: $*" >&2
}

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

ensure_parent_dir() {
  local file="$1"
  ensure_dir "$(dirname "$file")"
}

# Returns 0 when context should be used, 1 when skipped.
# mode: auto|yes|no
should_use_context() {
  local label="$1"
  local path="$2"
  local mode="$3"
  local strict="$4"

  if [[ "$mode" == "no" ]]; then
    return 1
  fi

  if [[ -s "$path" ]]; then
    return 0
  fi

  if [[ "$mode" == "yes" ]]; then
    if [[ "$strict" == "true" ]]; then
      fail "$label requested but missing/empty: $path"
    fi
    warn "$label requested but missing/empty: $path"
    return 1
  fi

  # auto mode
  if [[ "$strict" == "true" ]]; then
    fail "$label not found in strict mode: $path"
  fi
  warn "$label not found; continuing without it: $path"
  return 1
}

case "$phase" in
  discovery)
    topics=""
    strict="false"
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --topics) topics="$2"; shift 2;;
        --strict) strict="true"; shift;;
        *) fail "unknown argument: $1";;
      esac
    done
    run_dir="$(resolve_run_dir "$run_dir")"
    require_run_dir "$run_dir"
    out="$run_dir/discovery/discovery.md"
    ensure_parent_dir "$out"
    write_header "$out" "Discovery" "$(basename "$run_dir")"
    append_section "$out" "Research Topics"
    if [[ -n "$topics" ]]; then
      IFS=',' read -ra topic_arr <<< "$topics"
      for topic in "${topic_arr[@]}"; do
        printf -- "- %s\n" "$topic" >> "$out"
      done
    else
      printf "(add research topics here)\n" >> "$out"
    fi
    append_section "$out" "Findings"
    printf "(add research findings organized by topic)\n" >> "$out"
    append_section "$out" "Recommendations"
    printf "(add high-level approach recommendations)\n" >> "$out"

    sources="$run_dir/discovery/sources.md"
    ensure_parent_dir "$sources"
    write_header "$sources" "Sources" "$(basename "$run_dir")"
    printf "(add all referenced URLs and citations here)\n" >> "$sources"
    [[ "$strict" == "true" ]] && warn "strict mode enabled: discovery has no required upstream inputs"
    echo "$out"
    ;;

  requirements)
    input_file=""
    project_name=""
    strict="false"
    use_discovery="auto"
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --input) input_file="$2"; shift 2;;
        --project) project_name="$2"; shift 2;;
        --strict) strict="true"; shift;;
        --use-discovery) use_discovery="yes"; shift;;
        --no-discovery) use_discovery="no"; shift;;
        *) fail "unknown argument: $1";;
      esac
    done

    if [[ -z "$run_dir" ]]; then
      run_dir="$(ensure_run_for_requirements "$project_name")"
    fi
    require_run_dir "$run_dir"

    out="$run_dir/requirements/requirements.md"
    ensure_parent_dir "$out"
    write_header "$out" "Requirements" "$(basename "$run_dir")"

    discovery_file="$run_dir/discovery/discovery.md"
    include_discovery="false"
    if should_use_context "discovery context" "$discovery_file" "$use_discovery" "$strict"; then
      include_discovery="true"
    fi

    append_section "$out" "Inputs"
    if [[ "$include_discovery" == "true" ]]; then
      printf -- "- discovery: %s\n" "$discovery_file" >> "$out"
    else
      printf -- "- discovery: (not used)\n" >> "$out"
    fi

    append_section "$out" "Problem Statement"
    if [[ -n "$input_file" ]]; then
      [[ -f "$input_file" ]] || fail "input file not found: $input_file"
      cat "$input_file" >> "$out"
    elif [[ "$include_discovery" == "true" ]]; then
      printf "(seed from discovery findings as needed)\n" >> "$out"
    else
      printf "(add problem statement here)\n" >> "$out"
    fi

    append_section "$out" "Clarifications"
    printf "(add clarifying questions and answers here)\n" >> "$out"
    echo "$out"
    ;;

  research)
    roots=""
    strict="false"
    use_requirements="auto"
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --roots) roots="$2"; shift 2;;
        --strict) strict="true"; shift;;
        --use-requirements) use_requirements="yes"; shift;;
        --no-requirements) use_requirements="no"; shift;;
        *) fail "unknown argument: $1";;
      esac
    done
    run_dir="$(resolve_run_dir "$run_dir")"
    require_run_dir "$run_dir"

    if [[ -z "$roots" ]]; then
      roots="$ROOT_DIR"
    fi

    req_file="$run_dir/requirements/requirements.md"
    include_requirements="false"
    if should_use_context "requirements context" "$req_file" "$use_requirements" "$strict"; then
      include_requirements="true"
    fi

    out="$run_dir/research/research.md"
    ensure_parent_dir "$out"
    write_header "$out" "Research" "$(basename "$run_dir")"

    append_section "$out" "Inputs"
    if [[ "$include_requirements" == "true" ]]; then
      printf -- "- requirements: %s\n" "$req_file" >> "$out"
    else
      printf -- "- requirements: (not used)\n" >> "$out"
    fi
    printf -- "- roots: %s\n" "$roots" >> "$out"

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
    strict="false"
    use_requirements="auto"
    use_research="auto"
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --input) input_file="$2"; shift 2;;
        --strict) strict="true"; shift;;
        --use-requirements) use_requirements="yes"; shift;;
        --no-requirements) use_requirements="no"; shift;;
        --use-research) use_research="yes"; shift;;
        --no-research) use_research="no"; shift;;
        *) fail "unknown argument: $1";;
      esac
    done
    run_dir="$(resolve_run_dir "$run_dir")"
    require_run_dir "$run_dir"

    req_file="$run_dir/requirements/requirements.md"
    research_file="$run_dir/research/research.md"
    include_requirements="false"
    include_research="false"
    if should_use_context "requirements context" "$req_file" "$use_requirements" "$strict"; then
      include_requirements="true"
    fi
    if should_use_context "research context" "$research_file" "$use_research" "$strict"; then
      include_research="true"
    fi

    out="$run_dir/plan/plan.md"
    ensure_parent_dir "$out"
    write_header "$out" "Plan" "$(basename "$run_dir")"

    append_section "$out" "Inputs"
    if [[ "$include_requirements" == "true" ]]; then
      printf -- "- requirements: %s\n" "$req_file" >> "$out"
    else
      printf -- "- requirements: (not used)\n" >> "$out"
    fi
    if [[ "$include_research" == "true" ]]; then
      printf -- "- research: %s\n" "$research_file" >> "$out"
    else
      printf -- "- research: (not used)\n" >> "$out"
    fi

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
    strict="false"
    use_plan="auto"
    use_research="auto"
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --input) input_file="$2"; shift 2;;
        --strict) strict="true"; shift;;
        --use-plan) use_plan="yes"; shift;;
        --no-plan) use_plan="no"; shift;;
        --use-research) use_research="yes"; shift;;
        --no-research) use_research="no"; shift;;
        *) fail "unknown argument: $1";;
      esac
    done
    run_dir="$(resolve_run_dir "$run_dir")"
    require_run_dir "$run_dir"

    plan_file="$run_dir/plan/plan.md"
    research_file="$run_dir/research/research.md"
    include_plan="false"
    include_research="false"
    if should_use_context "plan context" "$plan_file" "$use_plan" "$strict"; then
      include_plan="true"
    fi
    if should_use_context "research context" "$research_file" "$use_research" "$strict"; then
      include_research="true"
    fi

    out="$run_dir/implementation/implementation.md"
    ensure_parent_dir "$out"
    write_header "$out" "Implementation" "$(basename "$run_dir")"

    append_section "$out" "Inputs"
    if [[ "$include_plan" == "true" ]]; then
      printf -- "- plan: %s\n" "$plan_file" >> "$out"
    else
      printf -- "- plan: (not used)\n" >> "$out"
    fi
    if [[ "$include_research" == "true" ]]; then
      printf -- "- research: %s\n" "$research_file" >> "$out"
    else
      printf -- "- research: (not used)\n" >> "$out"
    fi

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
    strict="false"
    use_implementation="auto"
    use_plan="auto"
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --test-cmd) test_cmd="$2"; shift 2;;
        --input) input_file="$2"; shift 2;;
        --strict) strict="true"; shift;;
        --use-implementation) use_implementation="yes"; shift;;
        --no-implementation) use_implementation="no"; shift;;
        --use-plan) use_plan="yes"; shift;;
        --no-plan) use_plan="no"; shift;;
        *) fail "unknown argument: $1";;
      esac
    done
    run_dir="$(resolve_run_dir "$run_dir")"
    require_run_dir "$run_dir"

    implementation_file="$run_dir/implementation/implementation.md"
    plan_file="$run_dir/plan/plan.md"
    include_implementation="false"
    include_plan="false"
    if should_use_context "implementation context" "$implementation_file" "$use_implementation" "$strict"; then
      include_implementation="true"
    fi
    if should_use_context "plan context" "$plan_file" "$use_plan" "$strict"; then
      include_plan="true"
    fi

    out="$run_dir/validation/validation.md"
    ensure_parent_dir "$out"
    write_header "$out" "Validation" "$(basename "$run_dir")"

    append_section "$out" "Inputs"
    if [[ "$include_implementation" == "true" ]]; then
      printf -- "- implementation: %s\n" "$implementation_file" >> "$out"
    else
      printf -- "- implementation: (not used)\n" >> "$out"
    fi
    if [[ "$include_plan" == "true" ]]; then
      printf -- "- plan: %s\n" "$plan_file" >> "$out"
    else
      printf -- "- plan: (not used)\n" >> "$out"
    fi

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

      test_output="$run_dir/validation/test-output.txt"
      ensure_parent_dir "$test_output"
      test_exit=0
      (cd "$ROOT_DIR" && bash -lc "$test_cmd") > "$test_output" 2>&1 || test_exit=$?
      printf "See %s\n" "$test_output" >> "$out"

      if [[ $test_exit -ne 0 ]]; then
        if [[ "$strict" == "true" ]]; then
          fail "validation test command failed with exit code $test_exit (see $test_output)"
        fi
        warn "validation test command failed with exit code $test_exit (see $test_output)"
      fi
    else
      append_section "$out" "Test Command"
      printf "(add test command or note not run)\n" >> "$out"
      append_section "$out" "Test Output"
      printf "(add test output or link)\n" >> "$out"
      if [[ "$strict" == "true" ]]; then
        fail "strict mode requires --test-cmd for validation"
      fi
    fi

    echo "$out"
    ;;

  version-control)
    do_status="false"
    do_diff="false"
    commit_msg=""
    strict="false"
    use_validation="auto"
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --status) do_status="true"; shift;;
        --diff) do_diff="true"; shift;;
        --commit) commit_msg="$2"; shift 2;;
        --strict) strict="true"; shift;;
        --use-validation) use_validation="yes"; shift;;
        --no-validation) use_validation="no"; shift;;
        *) fail "unknown argument: $1";;
      esac
    done
    run_dir="$(resolve_run_dir "$run_dir")"
    require_run_dir "$run_dir"

    validation_file="$run_dir/validation/validation.md"
    include_validation="false"
    if should_use_context "validation context" "$validation_file" "$use_validation" "$strict"; then
      include_validation="true"
    fi

    out="$run_dir/version-control/version-control.md"
    ensure_parent_dir "$out"
    write_header "$out" "Version Control" "$(basename "$run_dir")"

    append_section "$out" "Inputs"
    if [[ "$include_validation" == "true" ]]; then
      printf -- "- validation: %s\n" "$validation_file" >> "$out"
    else
      printf -- "- validation: (not used)\n" >> "$out"
    fi

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

        commit_output="$run_dir/version-control/git-commit.txt"
        ensure_parent_dir "$commit_output"
        commit_exit=0
        (
          cd "$ROOT_DIR"
          git add -A
          git commit -m "$commit_msg"
        ) > "$commit_output" 2>&1 || commit_exit=$?

        printf "See %s\n" "$commit_output" >> "$out"

        if [[ $commit_exit -ne 0 ]]; then
          if [[ "$strict" == "true" ]]; then
            fail "git commit failed with exit code $commit_exit (see $commit_output)"
          fi
          warn "git commit failed with exit code $commit_exit (see $commit_output)"
        fi
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
