# Claude Code Integration

SpecLite supports **Claude Code** with slash-command style markdown files installed into `.claude/commands/` or `~/.claude/commands/`.

## Install

```bash
./tools/install-integrations.sh --claude
```

Project-local:

```bash
./tools/install-integrations.sh --project --claude
```

## Available commands

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

## Recommended usage

- use `/orchestrate` when starting from a vague request
- use `/workflow` to inspect or create workflows
- use `.speclite/docs/` and `.speclite/rules/` to ground project behavior
- use the backbone phase commands when you know the exact SDLC step

## Notes

SpecLite's Claude Code integration is intentionally simple and file-based so it stays portable and easy to customize.
