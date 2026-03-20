# SpecLite Examples

## Example 1: Brainstorm -> Plan a new feature

```bash
RUN_DIR=$(./tools/new-run.sh "Add OAuth Authentication")
./tools/run-phase.sh discovery "$RUN_DIR" --topics "oauth2,jwt,passport.js"
./tools/run-phase.sh requirements "$RUN_DIR"
./tools/run-phase.sh research "$RUN_DIR" --roots "src,lib"
./tools/run-phase.sh plan "$RUN_DIR"
./tools/run-phase.sh implementation "$RUN_DIR"
./tools/run-phase.sh validation "$RUN_DIR" --test-cmd "npm test"
```

**What happens:**
- discovery captures external patterns and sources
- requirements clarifies scope and success criteria
- research maps the codebase and risks
- plan breaks work into independently completable phases
- implementation records completed changes
- validation proves the change works

## Example 2: Enhance an existing feature

```bash
RUN_DIR=$(./tools/new-run.sh "Improve Dashboard Filters")
./tools/run-phase.sh requirements "$RUN_DIR"
./tools/run-phase.sh research "$RUN_DIR" --roots "src/dashboard,src/components"
./tools/run-phase.sh plan "$RUN_DIR"
./tools/run-phase.sh implementation "$RUN_DIR"
./tools/run-phase.sh validation "$RUN_DIR" --test-cmd "npm run test:dashboard"
```

**Best paired workflow:** `/enhance`

## Example 3: Debug a regression

```bash
RUN_DIR=$(./tools/new-run.sh "Fix Login Regression")
./tools/run-phase.sh requirements "$RUN_DIR"
./tools/run-phase.sh research "$RUN_DIR" --roots "src/auth,src/api"
./tools/run-phase.sh plan "$RUN_DIR"
./tools/run-phase.sh implementation "$RUN_DIR"
./tools/run-phase.sh validation "$RUN_DIR" --test-cmd "npm test -- login"
```

**Best paired workflow:** `/debug`

## Example 4: Use orchestrate as the front door

User says:

```text
Improve the checkout flow and make errors easier to recover from.
```

SpecLite should:
- classify this as an enhancement
- choose the smallest viable path
- create or reuse a run
- route into requirements/research/plan/implementation/validation as needed

**Best paired workflow:** `/orchestrate`

## Example 5: Return to a project after a break

Use `/status` to summarize:
- what the run is about
- which artifacts are complete
- what risks remain
- what the next action should be

## Example output structure

```text
runs/<run_id>/
├── discovery/
├── requirements/
├── research/
├── plan/
├── implementation/
├── validation/
└── version-control/
```

## Practical guidance

1. Start with **brainstorm** or **orchestrate** when the request is fuzzy.
2. Use **discovery** for unfamiliar domains or external best-practice research.
3. Keep **plan** phases small and independently executable.
4. Treat **validation** as part of delivery, not an afterthought.
5. Use **status** whenever you need a clean handoff or re-entry point.
