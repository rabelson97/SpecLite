# Integrations

SpecLite works with **Codex**, **Kiro**, and **Cursor** via symlinks only. The framework stays in one place; integrations point to it.

## Install

From the framework directory:

```bash
./tools/install-integrations.sh --codex --kiro --cursor
```

This creates symlinks in `~/.codex/`, `~/.kiro/`, and `~/.cursor/`. **No files are copied.**
Use `--project` to install into project-local `.codex/`, `.kiro/`, and `.cursor/` folders from that project root.

## Why symlinks

- one canonical framework copy
- easy upgrades
- shareable across many repos
- no prompt drift caused by copied files

## Codex

Codex uses two locations:

- **Skills** (`~/.codex/skills/`) — reusable skill entry points
- **Prompts** (`~/.codex/prompts/`) — slash-command style prompts

Installed Codex skills:

- `ai-assisted-framework`
- `framework-brainstorm`
- `framework-debug`
- `framework-discovery`
- `framework-enhance`
- `framework-orchestrate`
- `framework-requirements`
- `framework-research`
- `framework-plan`
- `framework-implement`
- `framework-status`
- `framework-validate`
- `framework-version-control`

Restart Codex after installation so prompts and skills are re-indexed.

## Kiro

Agents are symlinked to `~/.kiro/agents/`.

### Available agents

| Agent | Purpose |
|-------|---------|
| `framework-brainstorm` | Explore options before planning |
| `framework-debug` | Diagnose issues systematically |
| `framework-discovery` | External discovery and web research |
| `framework-enhance` | Improve an existing system |
| `framework-orchestrate` | Route requests to the right path |
| `framework-requirements` | Requirements and scope shaping |
| `framework-research` | Codebase analysis |
| `framework-plan` | Technical planning |
| `framework-implement` | Implementation |
| `framework-status` | Run summarization |
| `framework-validate` | Validation and verification |
| `framework-version-control` | Git and release hygiene |

## Cursor

Cursor commands are symlinked directly to workflow markdown files.

Available commands:

- `/brainstorm`
- `/orchestrate`
- `/enhance`
- `/debug`
- `/status`
- `/discovery`
- `/requirements`
- `/research`
- `/plan`
- `/implement`
- `/validate`
- `/version-control`

## Recommended mental model

- use **`orchestrate`** when the user just describes intent
- use **front-door workflows** for exploration, debugging, and improvement work
- use **phase commands** when you already know the exact SDLC step
- use **status** when returning to a run after a break

This gives SpecLite a smoother front door while preserving the original artifact contract.
