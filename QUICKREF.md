# SpecLite Quick Reference

## What it is

SpecLite is an artifact-first AI development workflow for spec-driven software work across Codex, Cursor, and Kiro.

## Front-door workflows

```text
/orchestrate  Route a request into the right SpecLite path
/brainstorm   Explore options before planning
/enhance      Improve an existing feature or codebase
/debug        Diagnose an issue and shape a fix plan
/status       Summarize a run and recommend next actions
```

## Canonical phase overview

```text
0. Discovery (optional)  -> External research
1. Requirements          -> Gather requirements
2. Research              -> Analyze codebase
3. Plan                  -> Break into tasks with dependencies
4. Implementation        -> Execute plan
5. Validation            -> Test and verify
6. Version Control       -> Git operations and commit prep
```

Phases are flexible: you can run any phase directly. Use `--strict` when you want fail-fast behavior.

## Commands

```bash
# Setup
./tools/setup.sh
RUN_DIR=$(./tools/new-run.sh "Project Name")

# Canonical phases
./tools/run-phase.sh discovery "$RUN_DIR" --topics "topic1,topic2"
./tools/run-phase.sh requirements "$RUN_DIR"
./tools/run-phase.sh research "$RUN_DIR" [--roots path1,path2]
./tools/run-phase.sh plan "$RUN_DIR"
./tools/run-phase.sh implementation "$RUN_DIR"
./tools/run-phase.sh validation "$RUN_DIR" [--test-cmd "npm test"]
./tools/run-phase.sh version-control "$RUN_DIR" [--status] [--commit "msg"]
```

## Cursor slash commands

```text
/brainstorm
/debug
/0-discovery
/enhance
/orchestrate
/1-requirements
/2-research
/3-plan
/4-implement
/status
/5-validate
/version-control
```

## Kiro CLI agents

```bash
kiro chat --agent framework-brainstorm
kiro chat --agent framework-debug
kiro chat --agent framework-discovery
kiro chat --agent framework-enhance
kiro chat --agent framework-orchestrate
kiro chat --agent framework-research
kiro chat --agent framework-plan
kiro chat --agent framework-status
```

## Codex skills

```text
@framework-brainstorm
@framework-debug
@framework-discovery
@framework-enhance
@framework-orchestrate
@framework-requirements
@framework-research
@framework-plan
@framework-implement
@framework-status
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
