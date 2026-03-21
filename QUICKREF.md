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

## Shell commands

```bash
# Setup
./tools/setup.sh
RUN_DIR=$(./tools/new-run.sh "Project Name")

# Backbone phases
./tools/run-phase.sh discovery "$RUN_DIR" --topics "topic1,topic2"
./tools/run-phase.sh requirements "$RUN_DIR"
./tools/run-phase.sh research "$RUN_DIR" [--roots path1,path2]
./tools/run-phase.sh plan "$RUN_DIR"
./tools/run-phase.sh implementation "$RUN_DIR"
./tools/run-phase.sh validation "$RUN_DIR" [--test-cmd "npm test"]
./tools/run-phase.sh version-control "$RUN_DIR" [--status] [--commit "msg"]

# Scaffold project-local framework files
./tools/init-project.sh /path/to/your-repo

# Workflow studio
./tools/workflow-studio.sh list
./tools/workflow-studio.sh explain plan
./tools/workflow-studio.sh new release-readiness
./tools/workflow-studio.sh doctor
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
