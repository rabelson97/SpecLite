---
description: Enhance workflow — improve an existing system using SpecLite phases without losing traceability.
argument-hint: [feature or improvement]
---

# enhance

Use this workflow for improving an existing codebase, adding a feature, refactoring safely, or modernizing part of the system.

## Goal

Route an enhancement request through the smallest complete set of phases necessary while preserving artifact quality.

## Behavior

1. Resolve the active run context from `runs/` or create one if needed.
2. Decide which path fits best:
   - small scoped change → research → plan → implementation → validation
   - medium feature → requirements → research → plan → implementation → validation
   - unfamiliar domain → discovery → requirements → research → plan → implementation → validation
3. Explain the chosen path briefly.
4. Ensure each selected phase artifact exists and reflects the current enhancement request.
5. Keep the plan bite-sized and validation-focused.
6. Preserve links between requirements, research, plan, implementation, and validation artifacts.
7. Recommend `version-control` once validation is complete.

## Output shape

Summarize:
- requested enhancement
- chosen workflow path
- current status by phase
- next recommended command

## Commands

```bash
./tools/run-phase.sh requirements [run_dir]
./tools/run-phase.sh research [run_dir]
./tools/run-phase.sh plan [run_dir]
./tools/run-phase.sh implementation [run_dir]
./tools/run-phase.sh validation [run_dir] [--test-cmd "npm test"]
```
