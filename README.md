# AI-Assisted Development Framework

A phase-based workflow system that stores each phase artifact in a dedicated run directory to avoid context rot.

## Quickstart

```bash
./tools/setup.sh
./tools/new-run.sh "My Project"
```

The new-run command prints the run directory path. Use it in subsequent commands:

```bash
RUN_DIR=$(./tools/new-run.sh "My Project")
./tools/run-phase.sh requirements "$RUN_DIR" --input /path/to/problem.md
./tools/run-phase.sh research "$RUN_DIR"
./tools/run-phase.sh plan "$RUN_DIR" --input /path/to/plan.md
./tools/run-phase.sh implementation "$RUN_DIR" --input /path/to/implementation-notes.md
./tools/run-phase.sh validation "$RUN_DIR" --test-cmd "npm test"
./tools/run-phase.sh version-control "$RUN_DIR" --status --commit "Implement feature"
./tools/save-learnings.sh "$RUN_DIR"
```

## Structure

- `workflows/`: phase workflow markdown commands
- `actions/`: action markdown commands
- `scripts/`: script markdown commands
- `tools/`: shell scripts used by workflows/actions/scripts
- `rules/`: codebase-specific rules
- `runs/`: generated run directories and phase artifacts

## Tool Commands

- `./tools/new-run.sh "Project Name"`
- `./tools/run-phase.sh requirements [run_dir] [--input file] [--project "Project Name"]`
- `./tools/run-phase.sh research [run_dir] [--roots path1,path2]`
- `./tools/run-phase.sh plan [run_dir] [--input file]`
- `./tools/run-phase.sh implementation [run_dir] [--input file]`
- `./tools/run-phase.sh validation [run_dir] [--test-cmd "cmd"] [--input file]`
- `./tools/run-phase.sh version-control [run_dir] [--status] [--commit "message"]`
- `./tools/cleanup-cache.sh`
- `./tools/save-learnings.sh <run_dir>`

## Cursor Slash Commands

Cursor commands are symlinked to the workflow markdown files:

- `/0-new-run`
- `/1-requirements`
- `/2-research`
- `/3-plan`
- `/4-implement`
- `/5-validate`
- `/version-control`
- `/0-setup`
- `/0-cleanup-cache`
- `/manage-workflow`
- `/save-learnings`
- `/8-index-codebase`
- `/9-run-workers`

## Codex, Kiro & Cursor

The framework works with Codex (CLI + Cursor plugin), Kiro, and Cursor. **Uses symlinks only**—framework stays in one place. See `integrations/README.md` for details.

```bash
./tools/install-integrations.sh --codex --kiro --cursor   # global symlinks
./tools/install-integrations.sh --project                 # project-scoped (run from project root)
```

After installing, restart Codex or reload Cursor for slash command prompts to appear. Codex skills include the umbrella `ai-assisted-framework` plus per-phase skills like `framework-requirements`, `framework-research`, and `framework-plan`.

## Notes

- Research indexing outputs: `files.txt`, `extensions.txt`, `largest_files.txt`, `directories.txt`.
- Validation captures test output to `runs/<run_id>/validation/test-output.txt`.
