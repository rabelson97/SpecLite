---
description: Debug workflow — isolate failures systematically and route into research, implementation, and validation.
argument-hint: [bug or symptom]
---

# debug

Use this workflow when something is broken, flaky, regressed, or unclear.

## Goal

Convert a vague symptom into a reproducible diagnosis, a likely root cause, and a concrete repair plan.

## Behavior

1. Resolve the active run context from `runs/`.
2. Read available requirements, research, implementation, and validation artifacts for the run.
3. Restate the observed symptom, expected behavior, and actual behavior.
4. Identify the narrowest reproducible surface area.
5. Generate a short hypothesis list ranked by likelihood.
6. Inspect relevant code paths, dependencies, logs, and recent changes.
7. Record the most likely root cause and the evidence supporting it.
8. Propose the smallest safe fix.
9. Define validation steps that would prove the issue is resolved and non-regressive.
10. Write findings into:
   - `run_dir/research/research.md` for diagnosis and evidence
   - `run_dir/plan/plan.md` for the repair plan if implementation work is needed
11. Hand off to `/4-implement` if code changes are required.

## Output shape

Use sections like:
- Symptom
- Expected vs actual
- Reproduction notes
- Hypotheses
- Root cause
- Proposed fix
- Validation plan

## Commands

```bash
./tools/run-phase.sh research [run_dir] [--roots path1,path2]
./tools/run-phase.sh plan [run_dir]
./tools/run-phase.sh validation [run_dir] [--test-cmd "npm test"]
```
