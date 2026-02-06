# SpecLite Migration Guide

## What's New

SpecLite is the evolution of the ai-assisted-framework with modern AI capabilities:

### New Features

1. **Discovery Phase** - Optional web research before codebase analysis
2. **Parallel Research** - Specialized subagents analyze codebase simultaneously
3. **Task Dependencies** - Plan phase tracks parallel vs sequential execution
4. **Enhanced Workflows** - Updated to leverage latest AI tooling

### Breaking Changes

**None.** SpecLite is fully backward compatible. Existing runs and workflows continue to work.

## Upgrading

### 1. Update Integrations

Re-run the install script to add discovery phase:

```bash
./tools/install-integrations.sh --codex --kiro --cursor
```

Or for project-scoped:

```bash
cd /path/to/your/project
/path/to/speclite/tools/install-integrations.sh --project
```

### 2. Restart Editors

- **Codex**: Restart the CLI
- **Cursor**: Reload window (Cmd/Ctrl + Shift + P → "Reload Window")
- **Kiro**: No restart needed

### 3. Verify New Commands

Check that discovery phase is available:

**Cursor:**
```
/0-discovery
```

**Kiro:**
```bash
kiro chat --agent framework-discovery
```

**Codex:**
```
@framework-discovery
```

## Using New Features

### Discovery Phase (Optional)

Add before requirements phase for external research:

```bash
RUN_DIR=$(./tools/new-run.sh "My Project")
./tools/run-phase.sh discovery "$RUN_DIR" --topics "auth,testing"
./tools/run-phase.sh requirements "$RUN_DIR"
# ... continue with other phases
```

### Parallel Research

No changes needed - research phase automatically uses parallel subagents:

```bash
./tools/run-phase.sh research "$RUN_DIR"
```

The AI will spawn 5 specialized agents in parallel:
- Architecture Agent
- Patterns Agent
- Dependencies Agent
- Gaps Agent
- Risks Agent

### Task Dependencies in Plans

When creating plans, the AI now tracks dependencies:

```markdown
### Phase 1: Setup infrastructure
- **Dependencies**: None
- **Parallel**: Can run independently

### Phase 2: Add feature A
- **Dependencies**: Phase 1
- **Parallel**: No (requires Phase 1)

### Phase 3: Add feature B
- **Dependencies**: Phase 1
- **Parallel**: Yes (with Phase 2)
```

## Existing Runs

All existing runs continue to work without modification. The new discovery phase is optional and doesn't affect existing workflows.

## Rollback

If you need to revert to the old behavior:

1. Remove discovery workflow:
   ```bash
   rm workflows/discovery/workflow.md
   ```

2. Remove discovery integrations:
   ```bash
   rm ~/.codex/skills/framework-discovery
   rm ~/.codex/prompts/framework.discovery.md
   rm ~/.kiro/agents/framework-discovery.json
   rm ~/.cursor/commands/0-discovery.md
   ```

3. Use old workflows as before

## Questions?

See [EXAMPLES.md](EXAMPLES.md) for detailed usage examples of new features.
