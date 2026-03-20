# SpecLite Quick Reference

## What it is

SpecLite is an artifact-first AI development workflow for spec-driven software delivery across Codex, Cursor, and Kiro.

## Front-door workflows

```text
/orchestrate  Route a request into the right SpecLite path
/brainstorm   Explore options before planning
/enhance      Improve an existing feature or codebase
/debug        Diagnose an issue and shape a fix plan
/status       Summarize a run and recommend next actions
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

Use only the workflows you need. The front door is conversational; the backbone stays artifact-first.

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
```

## Cursor commands

```text
/brainstorm
/orchestrate
/enhance
/debug
/status
/discovery
/requirements
/research
/plan
/implement
/validate
/version-control
```

## Kiro CLI agents

```bash
kiro chat --agent framework-brainstorm
kiro chat --agent framework-orchestrate
kiro chat --agent framework-enhance
kiro chat --agent framework-debug
kiro chat --agent framework-status
kiro chat --agent framework-discovery
kiro chat --agent framework-research
kiro chat --agent framework-plan
```

## Codex skills

```text
@framework-brainstorm
@framework-orchestrate
@framework-enhance
@framework-debug
@framework-status
@framework-discovery
@framework-requirements
@framework-research
@framework-plan
@framework-implement
@framework-validate
@framework-version-control
```

## Suggested paths

### New feature
```text
brainstorm -> requirements -> research -> plan -> implementation -> validation
```

### Large unknown feature
```text
brainstorm -> discovery -> requirements -> research -> plan -> implementation -> validation
```

### Bug fix
```text
debug -> research -> plan -> implementation -> validation
```

### Existing feature improvement
```text
enhance -> research -> plan -> implementation -> validation
```

## Output locations

```text
runs/<run_id>/
├── discovery/
│   ├── discovery.md
│   └── sources.md
├── requirements/
│   └── requirements.md
├── research/
│   ├── research.md
│   └── index/
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
    ├── git-diff-stat.txt
    ├── git-diff.txt
    └── git-commit.txt
```

## Core ideas

- artifact-first, not chat-history-first
- spec-driven, not pure improvisation
- small specialist system, not agent sprawl
- portable integrations, not copy-heavy templates
- inspectable outputs, not hidden reasoning
