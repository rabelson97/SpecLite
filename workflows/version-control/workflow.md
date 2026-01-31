---
description: Version control — capture git status and optionally commit.
argument-hint: [--status] [--commit "message"]
---

# version-control

Capture git status and optionally create a commit.

## Outputs

- `run_dir/version-control/version-control.md` is seeded with **Summary** and **Notes** sections by default.
- When `--status` is used, git status and diff stats are written to `run_dir/version-control/`.

Command:
```bash
./tools/run-phase.sh version-control [run_dir] [--status] [--commit "message"]
```
