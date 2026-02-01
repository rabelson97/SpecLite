# Integrations

This framework works with **Codex** (CLI + Cursor plugin), **Kiro CLI**, and **Cursor** via symlinks only. The framework stays in one place; symlinks point to it.

## Install (recommended)

From the framework directory:

```bash
./tools/install-integrations.sh --codex --kiro --cursor
```

This creates symlinks in `~/.codex/`, `~/.kiro/`, and `~/.cursor/`. **No files are copied.**
Use `--project` to install into a project-local `.codex/`, `.kiro/`, and `.cursor/` from that project root.

## Codex (CLI + Cursor plugin)

Codex uses two locations:
- **Skills** (`~/.codex/skills/`) — for skill-based invocation in the Codex plugin
- **Prompts** (`~/.codex/prompts/`) — for slash commands in Codex/Cursor (e.g. `/prompts:framework.requirements`)

Installed skills (all symlinks to canonical workflows):
- `ai-assisted-framework` (umbrella skill)
- `framework-requirements`
- `framework-research`
- `framework-plan`
- `framework-implement`
- `framework-validate`
- `framework-version-control`

The install script symlinks both. Restart Codex or reload the Cursor window for prompts to appear in the slash menu.

---

## Kiro CLI

Agents are symlinked to `~/.kiro/agents/`. The `file://` paths in each config are relative to the config file; symlinks preserve correct resolution.

### Available agents

| Agent | Phase |
|-------|-------|
| `framework-requirements` | Requirements (product manager) |
| `framework-research` | Research (senior engineer) |
| `framework-plan` | Plan (technical lead) |
| `framework-implement` | Implementation |
| `framework-validate` | Validation |
| `framework-version-control` | Version control |

Switch to an agent in Kiro to run that phase. Each agent loads the corresponding workflow as its prompt.

---

## Cursor

Cursor commands are symlinked directly to the phase workflows:

- `/1-requirements`
- `/2-research`
- `/3-plan`
- `/4-implement`
- `/5-validate`
- `/version-control`
