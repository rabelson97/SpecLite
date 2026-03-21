# Integrations

SpecLite works with **Codex**, **Kiro**, **Cursor**, and **Claude Code** via symlinks. The framework stays in one place; integrations point to it.

## Install

From the framework directory:

```bash
./tools/install-integrations.sh --codex --kiro --cursor --claude
```

This creates symlinks in `~/.codex/`, `~/.kiro/`, `~/.cursor/`, and `~/.claude/`. **No files are copied.**
Use `--project` to install into project-local `.codex/`, `.kiro/`, `.cursor/`, and `.claude/` folders from that project root.

## Why symlinks

- one canonical framework copy
- easy upgrades
- shareable across many repos
- no prompt drift caused by copied files

## Codex

Codex uses two locations:
- **Skills** (`~/.codex/skills/`)
- **Prompts** (`~/.codex/prompts/`)

## Cursor

Cursor commands are symlinked to `~/.cursor/commands/`.

## Claude Code

Claude Code commands are symlinked to `~/.claude/commands/`.

Available command names for both Cursor and Claude Code:
- `/brainstorm`
- `/orchestrate`
- `/enhance`
- `/debug`
- `/status`
- `/workflow`
- `/discovery`
- `/requirements`
- `/research`
- `/plan`
- `/implement`
- `/validate`
- `/version-control`

## Kiro

Agents are symlinked to `~/.kiro/agents/`.

## Project-local SpecLite

For project-specific behavior, keep local files in:

```text
.speclite/
  project.md
  workflows/
  docs/
  rules/
  skills/
  agents/
```

This lets the repo define its own local workflows, docs, and rules without forking the framework.
