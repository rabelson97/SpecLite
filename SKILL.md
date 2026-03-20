---
name: speclite
description: SpecLite - Artifact-first AI development workflow for spec-driven software delivery. Use when you want structured discovery, requirements, research, planning, implementation, validation, version control, or higher-level routing via brainstorm, debug, enhance, orchestrate, and status. Supports Codex, Cursor, and Kiro integrations.
---

# SpecLite

SpecLite is an artifact-first AI development workflow that stores phase outputs in `runs/<run_id>/`.

## Core model

Canonical phases:
- discovery
- requirements
- research
- plan
- implementation
- validation
- version-control

Higher-level workflows:
- brainstorm
- debug
- enhance
- orchestrate
- status

## Key ideas

- Preserve traceable run artifacts instead of relying on chat history.
- Route user intent into the smallest correct workflow path.
- Apply small specialist overlays where useful.
- Keep the canonical phase outputs as the durable contract.

## Setup

```bash
./tools/setup.sh
./tools/new-run.sh "Project Name"
```

## Integration commands

```bash
./tools/install-integrations.sh --codex --kiro --cursor
./tools/install-integrations.sh --project
```

## Canonical phase commands

```bash
./tools/run-phase.sh discovery [run_dir] [--topics "topic1,topic2"]
./tools/run-phase.sh requirements [run_dir] [--project "Name"]
./tools/run-phase.sh research [run_dir] [--roots path1,path2]
./tools/run-phase.sh plan [run_dir]
./tools/run-phase.sh implementation [run_dir]
./tools/run-phase.sh validation [run_dir] [--test-cmd "cmd"]
./tools/run-phase.sh version-control [run_dir] [--status] [--commit "msg"]
```

## Reference docs

- `README.md`
- `QUICKREF.md`
- `EXAMPLES.md`
- `integrations/README.md`
- `workflows/README.md`
