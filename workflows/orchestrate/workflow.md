---
description: Orchestrate workflow — choose the right SpecLite path automatically from user intent.
argument-hint: [request]
---

# orchestrate

Use this workflow as the universal front door to SpecLite.

## Goal

Interpret user intent, choose the minimal correct workflow path, apply the right specialist mindset, and preserve SpecLite's artifact-first discipline.

## Routing rules

- Idea exploration, product direction, architecture comparison → `brainstorm`
- New feature with unclear scope → `requirements` then `research` then `plan`
- Existing feature enhancement → `enhance`
- Bug, regression, flaky behavior → `debug`
- "What changed?" / "where are we?" → `status`
- Explicit phase requests → run that phase directly

## Specialist overlays

Apply the most relevant perspective for the task:
- Product manager → requirements shaping
- Research lead → discovery and codebase analysis
- Technical lead → planning and decomposition
- Implementation engineer → execution details
- QA / validator → verification and non-regression
- Release assistant → commit and delivery readiness

## Behavior

1. Classify the request.
2. Choose the smallest viable workflow path.
3. Name the path and why it was chosen.
4. Create or reuse a run directory.
5. Ensure each touched phase artifact is updated.
6. Keep all outputs inspectable and stored in `runs/<run_id>/`.
7. End with the next best command or action.

## Output shape

Summarize:
- classified intent
- chosen path
- specialist overlays
- artifact locations
- next step
