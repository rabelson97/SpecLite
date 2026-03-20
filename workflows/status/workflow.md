---
description: Status workflow — summarize run state, artifact completeness, blockers, and next steps.
argument-hint: [run_dir optional]
---

# status

Use this workflow to understand where a SpecLite run stands without rereading everything manually.

## Goal

Produce an actionable status summary across all artifacts in a run.

## Behavior

1. Resolve the target run from the provided run directory or the most recent run.
2. Read `meta.json` and every available phase artifact.
3. Report which phases are complete, partial, or missing.
4. Extract the current goal, top risks, latest implementation notes, and validation state.
5. Highlight blockers, unanswered questions, and recommended next action.
6. Keep the summary concise but decision-ready.

## Output shape

Use sections like:
- Run overview
- Artifact status
- Current objective
- Risks / blockers
- Recommended next step

## Helpful command

```bash
ls -R runs/<run_id>
```
