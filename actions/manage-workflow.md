# manage-workflow

Update workflow command definitions. Lists available workflows and helps you edit their title, description, or command block.

Command:
```bash
./tools/manage-workflow.sh [list|open <number|name>]
```

Examples:
- `./tools/manage-workflow.sh list` – list all workflow files
- `./tools/manage-workflow.sh open 1` – get path for requirements workflow
- `./tools/manage-workflow.sh open plan` – get path for plan workflow
