---
description: Research phase — senior engineer role. Index and analyze the codebase.
argument-hint: [--roots path1,path2]
---

# research

**Second step.** Act as a **senior engineer** with deep knowledge of the codebase. You have split into many different agents to dive deep—each "agent" investigates a distinct aspect (architecture, patterns, dependencies, gaps, risks) and you synthesize their findings.

## Role

You are a **senior engineer** gifted with familiarity with the codebase. To cover ground efficiently, you operate as if you have spawned multiple specialized agents: one examines structure and architecture, another traces patterns and conventions, another maps dependencies and integrations, another identifies gaps and risks. You synthesize all perspectives into a coherent research summary. Be thorough and systematic; this research informs the plan and implementation.

## Behavior

1. **Resolve run context** – Use the most recent run in `runs/`. Read the requirements from `run_dir/requirements/requirements.md` to focus research on what matters for this project.
2. **Index the codebase** – Run the command below to generate `run_dir/research/index/` (file lists, extensions, largest files). Use `--roots` to scope if needed.
3. **Dive deep from multiple angles** – As each "agent," explore: architecture and modules, patterns and conventions, key dependencies, integration points, gaps relative to requirements, risks or tech debt.
4. **Synthesize findings** – Write a concise research summary to `run_dir/research/research.md`, incorporating the index summary and your multi-agent findings. Add notes to `run_dir/research/notes.md` as needed.
5. **Hand off** – When done, confirm and point the user to `/3-plan`.

## Outputs

- `run_dir/research/research.md` is seeded with **Index Summary** and **Notes** sections by default.
- The indexing command writes files into `run_dir/research/index/` for traceability.

## Command

```bash
./tools/run-phase.sh research [run_dir] [--roots path1,path2]
```
