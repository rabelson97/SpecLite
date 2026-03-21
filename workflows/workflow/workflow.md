---
description: Workflow studio — create, inspect, and extend workflows for a project.
argument-hint: [new|list|doctor|explain]
---

# workflow

Use this command when the user wants to add, customize, inspect, or reason about workflows.

## Goal

Make workflows first-class and explain where they come from.

## Source precedence

When looking for a workflow, resolve in this order:
1. `.speclite/workflows/` in the current project
2. `~/.speclite/workflows/`
3. built-in `workflows/` in SpecLite

## Behavior

### `workflow new <name>`
Scaffold a new project workflow in `.speclite/workflows/<name>.md`.

### `workflow list`
List built-in and project-local workflows.

### `workflow doctor`
Check for missing files, inconsistent links, and integration drift.

### `workflow explain <name>`
Show where a workflow resolves from and what it is for.

## Related project structure

```text
.speclite/
  project.md
  workflows/
  docs/
  rules/
  skills/
  agents/
```
