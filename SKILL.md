---
name: speclite
description: SpecLite - Phase-based AI development workflow with parallel research, web search, and task dependencies (discovery → requirements → research → plan → implementation → validation → version-control). Use when starting a new feature, researching external solutions, gathering requirements as a product manager, analyzing codebase with parallel agents, creating implementation plans with dependencies, implementing in phases, validating, or version-controlling. Supports Cursor, Codex CLI, and Kiro CLI.
---

# SpecLite

Phase-based AI development workflow that stores each phase artifact in `runs/<run_id>/`. Includes parallel research agents, web search integration, and task dependency tracking.

## Quick reference

| Phase | Role | Command |
|-------|------|---------|
| 0. Discovery (optional) | Research analyst | `./tools/run-phase.sh discovery [run_dir] [--topics "topic1,topic2"]` |
| 1. Requirements | Product manager | `./tools/run-phase.sh requirements [run_dir] [--project "Name"]` |
| 2. Research | Senior engineer | `./tools/run-phase.sh research [run_dir] [--roots path1,path2]` |
| 3. Plan | Technical lead | `./tools/run-phase.sh plan [run_dir]` |
| 4. Implementation | Implementing engineer | `./tools/run-phase.sh implementation [run_dir]` |
| 5. Validation | — | `./tools/run-phase.sh validation [run_dir] [--test-cmd "cmd"]` |
| 6. Version control | — | `./tools/run-phase.sh version-control [run_dir] [--status] [--commit "msg"]` |

## Key Features

- **Parallel Research**: Spawns specialized subagents (architecture, patterns, dependencies, gaps, risks)
- **Web Search**: Discovery phase searches external sources for best practices and solutions
- **Task Dependencies**: Plan phase tracks which tasks can run in parallel vs sequentially
- **Isolated Context**: Each run directory prevents context rot across projects

## Setup and new run

```bash
./tools/setup.sh
./tools/new-run.sh "Project Name"
```

The framework root is the directory containing `tools/`. When copied into a project (e.g. `ai-framework/`), run commands from the project root with the framework path: `./ai-framework/tools/run-phase.sh requirements "$RUN_DIR"`.

## Phase details

- **discovery** – workflows/discovery/workflow.md
- **requirements** – workflows/requirements/workflow.md
- **research** – workflows/research/workflow.md
- **plan** – workflows/plan/workflow.md
- **implementation** – workflows/implementation/workflow.md
- **validation** – workflows/validation/workflow.md
- **version-control** – workflows/version-control/workflow.md

Read the relevant workflow file for role, behavior, and phase-specific commands.
