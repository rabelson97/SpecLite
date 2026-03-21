---
name: speclite
description: SpecLite - Artifact-first AI development workflow and project-local spec framework. Use when you want structured discovery, requirements, research, planning, implementation, validation, version control, workflow creation, project docs, project rules, or higher-level routing via brainstorm, debug, enhance, orchestrate, status, and workflow. Supports Codex, Cursor, Claude Code, and Kiro.
---

# SpecLite

SpecLite is an artifact-first AI development workflow and project-local framework.

## Core model

Front-door workflows:
- brainstorm
- debug
- enhance
- orchestrate
- status
- workflow

Backbone phases:
- discovery
- requirements
- research
- plan
- implementation
- validation
- version-control

Project-local framework:
- `.speclite/project.md`
- `.speclite/workflows/`
- `.speclite/docs/`
- `.speclite/rules/`
- `.speclite/skills/`
- `.speclite/agents/`

## Resolution order

1. project-local `.speclite/...`
2. user-level `~/.speclite/...`
3. built-in framework defaults

## Setup

```bash
./tools/setup.sh
./tools/new-run.sh "Project Name"
cp -R templates/project/.speclite /path/to/your-repo/.speclite
```

## Integration commands

```bash
./tools/install-integrations.sh --codex --kiro --cursor --claude
./tools/install-integrations.sh --project
```

## Reference docs

- `README.md`
- `QUICKREF.md`
- `integrations/README.md`
- `integrations/claude/README.md`
- `workflows/README.md`
