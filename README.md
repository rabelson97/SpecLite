# AI-Assisted Development Framework

A phase-based workflow system that stores each phase artifact in a dedicated run directory to avoid context rot.

## Quickstart

```bash
./tools/setup.sh
RUN_DIR=$(./tools/new-run.sh "My Project")
./tools/run-phase.sh requirements "$RUN_DIR"
./tools/run-phase.sh research "$RUN_DIR"
./tools/run-phase.sh plan "$RUN_DIR"
./tools/run-phase.sh implementation "$RUN_DIR"
./tools/run-phase.sh validation "$RUN_DIR" --test-cmd "npm test"
./tools/run-phase.sh version-control "$RUN_DIR" --status --commit "Implement feature"
```

`runs/` is gitignored and created on demand; this repo ships with no run history.

## Structure

- `workflows/`: phase workflow markdown commands
- `tools/`: shell scripts used by workflows
- `integrations/`: Codex/Kiro/Cursor integration configs
- `rules/`: framework rules
- `runs/`: generated run directories and phase artifacts (gitignored)

## Multi-Editor Setup (Codex, Kiro, Cursor)

This framework uses symlinks only — nothing is copied.

```bash
./tools/install-integrations.sh --codex --kiro --cursor   # global symlinks
./tools/install-integrations.sh --project                 # project-scoped (run from project root)
```

After installing, restart Codex or reload Cursor for slash commands to appear. Codex skills include the umbrella `ai-assisted-framework` plus per-phase skills like `framework-requirements`, `framework-research`, and `framework-plan`.

## Cursor Slash Commands

Cursor commands are symlinked to the workflow markdown files:

- `/1-requirements`
- `/2-research`
- `/3-plan`
- `/4-implement`
- `/5-validate`
- `/version-control`

## Notes

- Research indexing outputs: `files.txt`, `extensions.txt`, `largest_files.txt`, `directories.txt`.
- Validation captures test output to `runs/<run_id>/validation/test-output.txt`.
