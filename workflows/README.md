# Workflows

Workflow commands are markdown files designed for AI runners such as Cursor, Codex, and Kiro.

SpecLite now has two workflow layers:

## 1) Front-door workflows

These improve ergonomics and route requests into the right artifact-producing path.

- `brainstorm/workflow.md`
- `debug/workflow.md`
- `enhance/workflow.md`
- `orchestrate/workflow.md`
- `status/workflow.md`

## 2) Canonical phase workflows

These are the durable SDLC backbone of the framework.

- `discovery/workflow.md`
- `requirements/workflow.md`
- `research/workflow.md`
- `plan/workflow.md`
- `implementation/workflow.md`
- `validation/workflow.md`
- `version-control/workflow.md`

## Usage pattern

Typical path for new work:

```bash
./tools/new-run.sh "Project Name"
./tools/run-phase.sh requirements [run_dir]
./tools/run-phase.sh research [run_dir]
./tools/run-phase.sh plan [run_dir]
./tools/run-phase.sh implementation [run_dir]
./tools/run-phase.sh validation [run_dir]
./tools/run-phase.sh version-control [run_dir]
```

## Recommended routing

- vague idea or solution exploration -> `brainstorm`
- bug or regression -> `debug`
- existing system improvement -> `enhance`
- unclear request -> `orchestrate`
- re-entry / summary -> `status`
- known explicit SDLC step -> phase workflow directly

## Principle

Front-door workflows should improve usability, but they must still preserve SpecLite's artifact-first contract.
The run directory, not the chat transcript, remains the source of truth.
