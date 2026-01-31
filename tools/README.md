# Tools

Shell tools used by workflows, actions, and scripts. These are invoked by markdown commands in `workflows/`, `actions/`, and `scripts/`.

## Conventions
- Tools are bash scripts; keep them POSIX‑friendly where practical.
- Log errors to stderr and return non‑zero on failure.
- Do not mutate the repo without explicit flags (e.g., `--commit`).

## Available tools
- `index-codebase.sh`: index files, extensions, and largest files under roots.
- `new-run.sh`: create a run directory with phase folders.
- `run-phase.sh`: execute a phase and write its artifacts.
- `run-workers.sh`: split input list into chunks, optionally run a command per chunk.
- `setup.sh`: prepare script permissions.
- `cleanup-cache.sh`: no-op (cache removed).
- `save-learnings.sh`: summarize run artifacts into `learnings.md`.
