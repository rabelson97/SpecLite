# SpecLite

A phase-based AI development workflow that stores each phase artifact in a dedicated run directory. Includes parallel research, web search, and task dependency tracking.

## Quickstart

```bash
./tools/setup.sh
RUN_DIR=$(./tools/new-run.sh "My Project")
./tools/run-phase.sh discovery "$RUN_DIR" --topics "auth,testing"  # optional
./tools/run-phase.sh requirements "$RUN_DIR"
./tools/run-phase.sh research "$RUN_DIR"
./tools/run-phase.sh plan "$RUN_DIR"
./tools/run-phase.sh implementation "$RUN_DIR"
./tools/run-phase.sh validation "$RUN_DIR" --test-cmd "npm test"
./tools/run-phase.sh version-control "$RUN_DIR" --status --commit "Implement feature"
```

`runs/` is gitignored and created on demand; this repo ships with no run history.

## Phases

1. **Discovery** (optional): External research using web search for best practices, libraries, patterns
2. **Requirements**: Product manager role gathering requirements and clarifications
3. **Research**: Codebase analysis with optional requirements context
4. **Plan**: Technical lead creating phases with dependency tracking
5. **Implementation**: Execute planned changes
6. **Validation**: Run tests and verify outcomes
7. **Version Control**: Git operations and status

> Phases are **flexible**. You can run any phase directly when needed (for example, research-only or plan-only).
> Use `--strict` when you want missing context/test failures to fail fast.

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

After installing, restart Codex or reload Cursor for slash commands to appear.

## Cursor Slash Commands

- `/0-discovery` - External research phase
- `/1-requirements` - Requirements gathering
- `/2-research` - Parallel codebase research
- `/3-plan` - Task breakdown with dependencies
- `/4-implement` - Implementation
- `/5-validate` - Validation
- `/version-control` - Git operations

## Key Features

- **Parallel Research**: Spawns specialized subagents for architecture, patterns, dependencies, gaps, and risks
- **Web Search**: Discovery phase searches external sources for best practices and solutions
- **Task Dependencies**: Plan phase tracks which tasks can run in parallel vs sequentially
- **Isolated Context**: Each run directory prevents context rot across projects

## Artifact Contract (Expected Outputs)

Each phase writes its primary artifact into a dedicated directory under a run. This makes runs easy to browse, diff, and archive.

- `discovery/`
  - `discovery.md` (primary)
  - `sources.md`
- `requirements/`
  - `requirements.md` (primary)
- `research/`
  - `research.md` (primary)
  - `index/` (generated)
    - `files.txt`, `extensions.txt`, `largest_files.txt`, `directories.txt`
- `plan/`
  - `plan.md` (primary)
- `implementation/`
  - `implementation.md` (primary)
- `validation/`
  - `validation.md` (primary)
  - `test-output.txt` (captured when `--test-cmd` is provided)
- `version-control/`
  - `version-control.md` (primary)
  - `git-status.txt`, `git-diff-stat.txt` (captured when `--status` is provided)
  - `git-diff.txt` (captured when `--diff` is provided)
  - `git-commit.txt` (captured when `--commit` is provided)

## Notes

- `runs/` is gitignored; the repo ships with no run history.
- Discovery phase stores all external references in `sources.md`.
