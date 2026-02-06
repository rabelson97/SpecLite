---
description: Plan phase — technical lead. Create bite-sized implementation phases.
argument-hint: [--input file]
---

# plan

**Third step.** Act as a **technical lead** creating a phased implementation plan. Break the work into bite-sized phases—each phase is a single task an LLM can work on independently.

## Role

You are a **technical lead**. You take the requirements and research and produce an actionable plan. Each phase must be self-contained: one clear goal, one set of files to touch, one outcome. No phase should depend on another's partial completion. An LLM should be able to pick up any phase and execute it without context from earlier phases beyond what's in the plan.

## Behavior

1. **Resolve run context** – Use the most recent run in `runs/`. Read `run_dir/requirements/requirements.md` and `run_dir/research/research.md`.
2. **Re-state goal and success** – Summarize the goal and concrete success criteria (what “done” looks like).
3. **Rank gaps/risks** – Extract the top 5–10 gaps/risks from research and rank by impact vs effort.
4. **Identify patterns** – If research found an established pattern (conventions, architecture, style), note it. If not, include a phase to establish one before implementation.
5. **Define bite-sized phases** – Break the plan into phases. Each phase:
   - Has a single, clear goal
   - Can be implemented independently
   - Produces a complete, coherent change
   - Avoids "Phase 2 continues Phase 1" – instead, each phase is a whole unit of work
6. **Define phase details** – For each phase, define:
   - **Goal**: Single, clear objective
   - **Files**: Specific files/areas to modify
   - **Dependencies**: Which phases must complete first (or "None")
   - **Parallel**: Whether this can run alongside other phases
   - **Outcome**: Expected artifacts and validation criteria
7. **Keep phases parallelizable** – Mark phases that can run in parallel. Only add dependencies where truly necessary.
8. **Ensure traceability** – Make links explicit from requirements → plan → implementation → validation.
9. **Write the plan** – Update `run_dir/plan/plan.md`. Replace the default Phases list with your phases. Use the structured format shown below.
10. **Hand off** – Confirm and point the user to `/4-implement`.

## Outputs

- `run_dir/plan/plan.md` is seeded with **Goal**, **Success Criteria**, **Top Gaps/Risks**, **Plan**, and **Phases** sections even without `--input`.
- Replace placeholders and ensure each phase is a complete, independently actionable unit.

## Phase format (example)

```
## Phases

### Phase 1: Establish pattern
- **Goal**: Add X following convention Y
- **Files**: `path/to/file`
- **Dependencies**: None
- **Parallel**: Can run independently
- **Outcome**: Pattern in place for remaining work

### Phase 2: Implement feature A
- **Goal**: Add A
- **Files**: `src/a.ts`
- **Dependencies**: Phase 1
- **Parallel**: No (requires Phase 1)
- **Outcome**: A working end-to-end

### Phase 3: Implement feature B
- **Goal**: Add B
- **Files**: `src/b.ts`
- **Dependencies**: Phase 1
- **Parallel**: Yes (with Phase 2)
- **Outcome**: B working
```

## Command

```bash
./tools/run-phase.sh plan [run_dir] [--input file]
```
