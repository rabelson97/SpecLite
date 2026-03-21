# Workflows

Workflow commands are markdown files designed for AI runners such as Cursor, Codex, Claude Code, and Kiro.

SpecLite now has two workflow layers:

## 1) Front-door workflows

These improve ergonomics and route requests into the right artifact-producing path.

- `brainstorm/workflow.md`
- `debug/workflow.md`
- `enhance/workflow.md`
- `orchestrate/workflow.md`
- `status/workflow.md`
- `workflow/workflow.md`

## 2) Canonical phase workflows

These are the durable SDLC backbone of the framework.

- `discovery/workflow.md`
- `requirements/workflow.md`
- `research/workflow.md`
- `plan/workflow.md`
- `implementation/workflow.md`
- `validation/workflow.md`
- `version-control/workflow.md`

## Project-local workflows

Projects can also define local workflows in:

```text
.speclite/workflows/
```

Recommended resolution order:
1. project-local `.speclite/workflows/`
2. user-level `~/.speclite/workflows/`
3. built-in `workflows/`

## Principle

Front-door workflows should improve usability, but they must still preserve SpecLite's artifact-first contract.
The run directory, not the chat transcript, remains the source of truth.
