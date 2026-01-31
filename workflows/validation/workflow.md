---
description: Validation phase — run tests and store results.
argument-hint: [--test-cmd "cmd"] [--input file]
---

# validation

Run validation and store results.

## Outputs

- `run_dir/validation/validation.md` is seeded with **Summary**, **Notes**, **Test Command**, and **Test Output** sections even without `--test-cmd`.
- When tests run, output is captured in `run_dir/validation/test-output.txt`.

Command:
```bash
./tools/run-phase.sh validation [run_dir] [--test-cmd "cmd"] [--input file]
```
