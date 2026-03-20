# SpecLite Migration Guide

## What's new in 2.2

SpecLite now has a smoother front door while keeping the same artifact-first backbone.

### New capabilities

1. **Intent-based workflows**
   - `brainstorm`
   - `debug`
   - `enhance`
   - `orchestrate`
   - `status`

2. **Lightweight specialist overlays**
   - reusable agent roles in `agents/`
   - reusable framework skills in `skills/`

3. **Expanded integrations**
   - more Codex skills
   - more Cursor slash commands
   - more Kiro agents

## Breaking changes

**None.** Existing runs and canonical phase workflows continue to work.

## Upgrade steps

### 1. Pull the latest version

```bash
git pull
```

### 2. Reinstall integrations

```bash
./tools/install-integrations.sh --codex --kiro --cursor
```

Or for project-scoped installation:

```bash
cd /path/to/your/project
/path/to/speclite/tools/install-integrations.sh --project
```

### 3. Restart or reload your editor

- **Codex**: restart
- **Cursor**: reload window
- **Kiro**: re-open if needed

## Verify new commands

### Cursor

```text
/brainstorm
/debug
/enhance
/orchestrate
/status
```

### Codex

```text
@framework-brainstorm
@framework-debug
@framework-enhance
@framework-orchestrate
@framework-status
```

### Kiro

```bash
kiro chat --agent framework-brainstorm
kiro chat --agent framework-debug
kiro chat --agent framework-enhance
kiro chat --agent framework-orchestrate
kiro chat --agent framework-status
```

## Recommended adoption path

- Keep using the canonical phases if you already have a disciplined workflow.
- Start using **orchestrate** as the default front door for natural-language requests.
- Use **status** for handoffs and returning to a run after time away.
- Use **enhance** and **debug** to reduce manual routing overhead.

## Compatibility note

SpecLite 2.2 adds ergonomics and shareability, not a new storage model.
The run directory is still the contract.
