---
description: Brainstorm workflow — shape ideas before planning or implementation.
argument-hint: [problem statement]
---

# brainstorm

Use this workflow when the user has an idea, rough feature, product direction, or architecture question and wants to explore options before locking in a plan.

## Goal

Produce a concise decision-ready artifact that turns fuzzy intent into clear next steps while preserving alternatives and trade-offs.

## Behavior

1. Resolve the active run context from `runs/` or create one if the user is clearly starting a new initiative.
2. Read any existing `discovery.md`, `requirements.md`, or `research.md` that already exists for the run.
3. Reframe the problem in plain language.
4. Generate 3-5 viable approaches.
5. For each approach, evaluate:
   - strengths
   - weaknesses
   - implementation complexity
   - delivery risk
   - when it is the best fit
6. Recommend one default direction and explain why.
7. Identify what is still unknown.
8. Write or update `run_dir/discovery/discovery.md` with findings and place external links/citations in `run_dir/discovery/sources.md`.
9. If the direction is clear, suggest moving to `/1-requirements` or `/3-plan`.

## Output shape

Use sections like:
- Problem framing
- Constraints and assumptions
- Options considered
- Recommended direction
- Open questions
- Next step

## Command

```bash
./tools/run-phase.sh discovery [run_dir] [--topics "topic1,topic2"]
```
