# Rules for This Codebase

## Purpose
This repository hosts an AI-assisted development framework intended to be reused across projects. The rules below keep workflows consistent, minimize context loss, and ensure each phase produces durable artifacts.

## Workflow Rules
- Every workflow run must have a dedicated `runs/<run_id>` directory with `meta.json`.
- Each phase stores artifacts inside its phase folder and references any external files by path.
- Phases are flexible and may be executed independently; when strict ordering is desired, run phases with `--strict` and explicit `--use-*` context flags.
- Every phase should write at least one markdown artifact summarizing outcomes and decisions.

## Extension Rules
- New workflows live under `workflows/<name>/workflow.md` and must be documented in `README.md`.
- New tools should be documented in `tools/README.md`.
