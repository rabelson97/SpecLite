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

Initialize that structure with:

```bash
./tools/init-project.sh /path/to/your-repo
```

## Workflow studio

Use the workflow tooling to manage project-local workflows:

```bash
./tools/workflow-studio.sh list
./tools/workflow-studio.sh explain brainstorm
./tools/workflow-studio.sh new release-readiness
./tools/workflow-studio.sh doctor
```

## Command surface

Available command names for Cursor and Claude Code:
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
