# SpecLite Quick Reference

## Phase Overview

```
0. Discovery (optional)  → External research
1. Requirements          → Gather requirements
2. Research             → Analyze codebase (parallel agents)
3. Plan                 → Break into tasks (with dependencies)
4. Implementation       → Execute plan
5. Validation          → Test and verify
6. Version Control     → Git operations
```

## Commands

```bash
# Setup
./tools/setup.sh
RUN_DIR=$(./tools/new-run.sh "Project Name")

# Phases
./tools/run-phase.sh discovery "$RUN_DIR" --topics "topic1,topic2"
./tools/run-phase.sh requirements "$RUN_DIR"
./tools/run-phase.sh research "$RUN_DIR" [--roots path1,path2]
./tools/run-phase.sh plan "$RUN_DIR"
./tools/run-phase.sh implementation "$RUN_DIR"
./tools/run-phase.sh validation "$RUN_DIR" [--test-cmd "npm test"]
./tools/run-phase.sh version-control "$RUN_DIR" [--status] [--commit "msg"]
```

## Cursor Slash Commands

```
/0-discovery
/1-requirements
/2-research
/3-plan
/4-implement
/5-validate
/version-control
```

## Kiro CLI Agents

```bash
kiro chat --agent framework-discovery
kiro chat --agent framework-requirements
kiro chat --agent framework-research
kiro chat --agent framework-plan
kiro chat --agent framework-implement
kiro chat --agent framework-validate
kiro chat --agent framework-version-control
```

## Codex Skills

```
@framework-discovery
@framework-requirements
@framework-research
@framework-plan
@framework-implement
@framework-validate
@framework-version-control
```

## Key Features

### Parallel Research
Research phase spawns 5 agents:
- Architecture Agent
- Patterns Agent
- Dependencies Agent
- Gaps Agent
- Risks Agent

### Web Search
Discovery phase searches:
- Best practices
- Libraries/frameworks
- Patterns/anti-patterns
- Security considerations

### Task Dependencies
Plan phase tracks:
- Which tasks depend on others
- Which can run in parallel
- Critical path identification

## Output Locations

```
runs/<run_id>/
├── discovery/
│   ├── discovery.md
│   └── sources.md
├── requirements/
│   └── requirements.md
├── research/
│   ├── research.md
│   └── index/
│       ├── files.txt
│       ├── extensions.txt
│       └── largest_files.txt
├── plan/
│   └── plan.md
├── implementation/
│   └── implementation.md
├── validation/
│   ├── validation.md
│   └── test-output.txt
└── version-control/
    ├── version-control.md
    ├── git-status.txt
    └── git-diff-stat.txt
```

## Typical Workflows

### Full Workflow (New Feature)
```bash
RUN_DIR=$(./tools/new-run.sh "Feature Name")
./tools/run-phase.sh discovery "$RUN_DIR" --topics "relevant,topics"
./tools/run-phase.sh requirements "$RUN_DIR"
./tools/run-phase.sh research "$RUN_DIR"
./tools/run-phase.sh plan "$RUN_DIR"
./tools/run-phase.sh implementation "$RUN_DIR"
./tools/run-phase.sh validation "$RUN_DIR" --test-cmd "npm test"
./tools/run-phase.sh version-control "$RUN_DIR" --commit "Add feature"
```

### Quick Workflow (Bug Fix)
```bash
RUN_DIR=$(./tools/new-run.sh "Bug Fix")
./tools/run-phase.sh requirements "$RUN_DIR"
./tools/run-phase.sh research "$RUN_DIR" --roots "src/buggy-module"
./tools/run-phase.sh implementation "$RUN_DIR"
./tools/run-phase.sh validation "$RUN_DIR" --test-cmd "npm test"
./tools/run-phase.sh version-control "$RUN_DIR" --commit "Fix bug"
```

### Research Only
```bash
RUN_DIR=$(./tools/new-run.sh "Codebase Analysis")
./tools/run-phase.sh research "$RUN_DIR"
# Review runs/<run_id>/research/research.md
```

## Tips

1. **Use discovery** for unfamiliar domains
2. **Let research run** - don't interrupt parallel agents
3. **Review dependencies** in plan before implementing
4. **Keep phases small** - one clear goal per phase
5. **Validate frequently** - catch issues early
6. **Commit per phase** - maintain clean history

## Integration Setup

### Global (All Projects)
```bash
./tools/install-integrations.sh --codex --kiro --cursor
```

### Project-Scoped
```bash
cd /path/to/project
/path/to/speclite/tools/install-integrations.sh --project
```

## Troubleshooting

### Commands not showing in Cursor
```bash
# Reinstall
./tools/install-integrations.sh --cursor
# Reload Cursor window
Cmd/Ctrl + Shift + P → "Reload Window"
```

### Kiro agent not found
```bash
# Reinstall
./tools/install-integrations.sh --kiro
# Verify
ls ~/.kiro/agents/framework-*
```

### Run directory not found
```bash
# List runs
ls -lt runs/
# Or let script prompt you
./tools/run-phase.sh research
```

## More Info

- Full docs: `README.md`
- Examples: `EXAMPLES.md`
- Migration: `MIGRATION.md`
- Changes: `CHANGELOG.md`
