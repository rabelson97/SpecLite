# Tools

Shell tools used by workflows. These are invoked by markdown commands in `workflows/`.

## Conventions
- Tools are bash scripts; keep them POSIX‑friendly where practical.
- Log errors to stderr and return non‑zero on failure.
- Do not mutate the repo without explicit flags (e.g., `--commit`).

## Available tools
- `index-codebase.sh`: index files, extensions, and largest files under roots.
- `new-run.sh`: create a run directory with phase folders.
- `run-phase.sh`: execute a phase and write its artifacts.
- `setup.sh`: prepare script permissions.
- `install-integrations.sh`: install Codex/Kiro/Cursor symlinks for workflows.
