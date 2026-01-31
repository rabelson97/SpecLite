---
name: manage-workflow
description: Update or edit AI-Assisted Development Framework workflow prompts (requirements, research, plan, implementation, validation, version-control). Use when the user wants to modify workflow definitions, adjust phase guidance, or change workflow command metadata.
---

# Manage Workflow

Use this skill to update workflow prompt files under `workflows/<phase>/workflow.md`.

## Workflow

1. Identify the target phase(s) the user wants to edit (e.g., plan, research, implementation).
2. Use the workflow tool to locate the file:
   - `./tools/manage-workflow.sh list`
   - `./tools/manage-workflow.sh open <number|name>`
3. Open the returned path and edit only the sections requested.
4. Preserve frontmatter keys (`description`, `argument-hint`) and the overall structure unless the user asks to change them.
5. Keep instructions concise, role-focused, and consistent with the rest of the framework.

## Notes

- Workflow files live at `workflows/<phase>/workflow.md`.
- Valid phases: `requirements`, `research`, `plan`, `implementation`, `validation`, `version-control`.
- Avoid adding extra files; update the workflow markdown directly.
