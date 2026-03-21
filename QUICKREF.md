# SpecLite Quick Reference

## What it is

SpecLite is an artifact-first AI development workflow for spec-driven software delivery across Codex, Cursor, Claude Code, and Kiro.

## Project-local framework

```text
.speclite/
  project.md
  workflows/
  docs/
  rules/
  skills/
  agents/
```

Use this to define project-specific workflow behavior, docs, and operating rules.

## Front-door workflows

```text
/orchestrate  Route a request into the right SpecLite path
/brainstorm   Explore options before planning
/enhance      Improve an existing feature or codebase
/debug        Diagnose an issue and shape a fix plan
/status       Summarize a run and recommend next actions
/workflow     Create, inspect, and extend workflows
```

## Backbone phase workflows

```text
/discovery       External research
/requirements    Gather requirements
/research        Analyze codebase
/plan            Break work into phases with dependencies
/implement       Execute the plan
/validate        Test and verify
/version-control Review changes and prepare commit history
```

## Resolution order

```text
1. .speclite/...      project-local overrides
2. ~/.speclite/...    user-level shared defaults
3. built-ins          SpecLite shipped defaults
```

Commit `.speclite/` when it contains real project knowledge.
Usually keep `.cursor/`, `.claude/`, `.codex/`, and `.kiro/` out of git unless shared intentionally.

## CLI commands

```bash
# Setup
./tools/setup.sh
./bin/speclite init /path/to/your-repo
RUN_DIR=$(./bin/speclite new-run "Project Name")

# Backbone phases
./bin/speclite run-phase discovery "$RUN_DIR" --topics "topic1,topic2"
./bin/speclite run-phase requirements "$RUN_DIR"
./bin/speclite run-phase research "$RUN_DIR" [--roots path1,path2]
./bin/speclite run-phase plan "$RUN_DIR"
./bin/speclite run-phase implementation "$RUN_DIR"
./bin/speclite run-phase validation "$RUN_DIR" [--test-cmd "npm test"]
./bin/speclite run-phase version-control "$RUN_DIR" [--status] [--commit "msg"]

# Workflow studio
./bin/speclite workflow list
./bin/speclite workflow explain plan
./bin/speclite workflow new release-readiness
./bin/speclite workflow doctor
```

## Editor commands

### Cursor / Claude Code

```text
/brainstorm
/orchestrate
/enhance
/debug
/status
/workflow
/discovery
/requirements
/research
/plan
/implement
/validate
/version-control
```

### Kiro CLI agents

```bash
kiro chat --agent framework-brainstorm
kiro chat --agent framework-orchestrate
kiro chat --agent framework-enhance
kiro chat --agent framework-debug
kiro chat --agent framework-status
kiro chat --agent framework-workflow
```

### Codex skills

```text
@framework-brainstorm
@framework-orchestrate
@framework-enhance
@framework-debug
@framework-status
@framework-workflow
@framework-discovery
@framework-requirements
@framework-research
@framework-plan
@framework-implement
@framework-validate
@framework-version-control
```
