# Rules for This Codebase

## Purpose
This repository hosts an AI-assisted development framework intended to be reused across projects. The rules below keep workflows consistent, minimize context loss, and ensure each phase produces durable artifacts.

## Workflow Rules
- Every workflow run must have a dedicated `runs/<run_id>` directory with `meta.json`.
- Each phase stores artifacts inside its phase folder and references any external files by path.
- Phases must be executed in order: requirements → research → plan → implementation → validation → version-control.
- Every phase should write at least one markdown artifact summarizing outcomes and decisions.

## Action Rules
- Actions are defined as markdown files that call a tool in `tools/`.
- `save-learnings` must summarize the latest phase artifacts without deleting originals.
- Cache cleanup must never delete `runs/` contents.

## Script Rules
- Scripts are defined as markdown files that call a tool in `tools/`.
- Tool scripts must be bash, POSIX-friendly where practical, and log errors to stderr.
- No tool script should mutate the repository without an explicit command flag (e.g., `--commit`).

## Extension Rules
- New workflows live under `workflows/<name>/workflow.md` and must be documented in `README.md`.
- Any new action must be documented in `README.md`.
