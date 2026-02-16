# Workflows

Workflow commands are markdown files designed for AI runners (Cursor/Codex). Each workflow exposes a single command representing a phase in the SDLC.

- `requirements/workflow.md`
- `research/workflow.md`
- `plan/workflow.md`
- `implementation/workflow.md`
- `validation/workflow.md`
- `version-control/workflow.md`

Usage pattern (common path, but phases can run independently):

```bash
./tools/new-run.sh "Project Name"
./tools/run-phase.sh requirements [run_dir]
./tools/run-phase.sh research [run_dir]
./tools/run-phase.sh plan [run_dir]
./tools/run-phase.sh implementation [run_dir]
./tools/run-phase.sh validation [run_dir]
./tools/run-phase.sh version-control [run_dir]
```

Flexible execution:
- Run any phase directly if that's all you need.
- Use `--strict` to fail when selected context is missing or validation tests fail.

Cursor slash commands:
- `/1-requirements`
- `/2-research`
- `/3-plan`
- `/4-implement`
- `/5-validate`
- `/version-control`
