---
name: ai-assisted-framework
description: Phase-based SDLC workflow (requirements → research → plan → implementation → validation → version-control). Use when starting a new feature, gathering requirements as a product manager, researching a codebase as a senior engineer, creating an implementation plan, implementing in bite-sized phases, validating, or version-controlling. Supports Cursor, Codex CLI, and Kiro CLI.
---

# AI-Assisted Development Framework

Phase-based workflow that stores each phase artifact in `runs/<run_id>/`. Work through phases sequentially.

## Quick reference

| Phase | Role | Command |
|-------|------|---------|
| 1. Requirements | Product manager | `./tools/run-phase.sh requirements [run_dir] [--project "Name"]` |
| 2. Research | Senior engineer | `./tools/run-phase.sh research [run_dir] [--roots path1,path2]` |
| 3. Plan | Technical lead | `./tools/run-phase.sh plan [run_dir]` |
| 4. Implementation | Implementing engineer | `./tools/run-phase.sh implementation [run_dir]` |
| 5. Validation | — | `./tools/run-phase.sh validation [run_dir] [--test-cmd "cmd"]` |
| 6. Version control | — | `./tools/run-phase.sh version-control [run_dir] [--status] [--commit "msg"]` |

## Setup and new run

```bash
./tools/setup.sh
./tools/new-run.sh "Project Name"
```

The framework root is the directory containing `tools/`. When copied into a project (e.g. `ai-framework/`), run commands from the project root with the framework path: `./ai-framework/tools/run-phase.sh requirements "$RUN_DIR"`.

## Phase details

- **requirements** – workflows/requirements/workflow.md
- **research** – workflows/research/workflow.md
- **plan** – workflows/plan/workflow.md
- **implementation** – workflows/implementation/workflow.md
- **validation** – workflows/validation/workflow.md
- **version-control** – workflows/version-control/workflow.md

Read the relevant workflow file for role, behavior, and phase-specific commands.
