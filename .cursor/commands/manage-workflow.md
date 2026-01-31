# manage-workflow

Update workflow command definitions. Lists available workflows and helps you edit their title, description, or command block.

**Workflow files** live in `workflows/<phase>/workflow.md`:
- `requirements` – Capture problem statement and clarifications
- `research` – Index and summarize the codebase
- `plan` – Create a phased implementation plan
- `implementation` – Capture implementation notes and decisions
- `validation` – Run validation and store results
- `version-control` – Capture git status and optionally create a commit

**Each workflow has:**
1. A title (phase name)
2. A brief description
3. A Command block with the bash command to run (e.g. `./tools/run-phase.sh <phase> [run_dir] [options]`)

Run the script to list workflows, then specify which workflow(s) to update. Assist the user in editing the selected workflow file(s).

Command:
```bash
./tools/manage-workflow.sh list
```
