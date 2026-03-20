# SpecLite

[![Artifact-first workflow](https://img.shields.io/badge/workflow-artifact--first-4f46e5)](#how-it-works)
[![Spec-driven development](https://img.shields.io/badge/method-spec--driven-0f766e)](#how-it-works)
[![Works with Codex](https://img.shields.io/badge/Codex-supported-black)](#works-with-your-tools)
[![Works with Cursor](https://img.shields.io/badge/Cursor-supported-2563eb)](#works-with-your-tools)
[![Works with Kiro](https://img.shields.io/badge/Kiro-supported-7c3aed)](#works-with-your-tools)

**SpecLite** is an **artifact-first AI workflow for shipping software**.

It gives you the speed of modern agent workflows, but with a cleaner spine:
**brainstorm -> spec -> research -> plan -> implement -> validate -> ship**.

Instead of letting important decisions disappear into chat history, SpecLite writes the work down in structured run artifacts your team can review, diff, reuse, and trust.

## Why people use it

Because most AI coding workflows feel like this:
- lots of momentum
- lots of prompts
- not much traceability
- hard handoffs
- fuzzy validation

SpecLite fixes that without turning your process into a ceremony factory.

You get:
- **fast front-door commands** like `brainstorm`, `debug`, `enhance`, and `orchestrate`
- **spec-driven execution** when the work gets real
- **run directories** that preserve decisions, findings, and outcomes
- **portable integrations** for **Codex**, **Cursor**, and **Kiro**
- **cleaner handoffs** between idea, implementation, and verification

## The pitch

If agent kits feel exciting but messy, and heavyweight spec systems feel rigorous but slow, **SpecLite sits in the sweet spot**.

It is built for people who want:
- the speed of AI-assisted development
- the clarity of spec-driven work
- the portability of reusable workflows
- the confidence that comes from explicit validation

## What it feels like to use

Start from intent:
- “brainstorm this feature”
- “debug this regression”
- “enhance this flow”
- “what’s the status of this run?”

Then let SpecLite route you into the right artifact-producing path.

When you need rigor, the underlying SDLC phases are still there.
When you need speed, the front door stays conversational.

## Quickstart

```bash
./tools/setup.sh
RUN_DIR=$(./tools/new-run.sh "My Project")
./tools/run-phase.sh discovery "$RUN_DIR" --topics "auth,testing"   # optional
./tools/run-phase.sh requirements "$RUN_DIR"
./tools/run-phase.sh research "$RUN_DIR"
./tools/run-phase.sh plan "$RUN_DIR"
./tools/run-phase.sh implementation "$RUN_DIR"
./tools/run-phase.sh validation "$RUN_DIR" --test-cmd "npm test"
./tools/run-phase.sh version-control "$RUN_DIR" --status --commit "Implement feature"
```

`runs/` is gitignored and created on demand; the repo ships with no run history.

## What you can do with it

### Explore before coding
Use **`brainstorm`** when the idea is still fuzzy and you want options, trade-offs, and a recommended direction.

### Turn vague requests into real work
Use **`orchestrate`** as the front door when someone says what they want, but not how to structure it.

### Improve existing systems without chaos
Use **`enhance`** to route improvements through the smallest useful set of phases.

### Debug like an adult
Use **`debug`** to turn “it’s broken” into reproduction notes, root-cause hypotheses, and a clean fix path.

### Return after a break without rereading everything
Use **`status`** to summarize a run, blockers, and next steps.

## Core workflows

### Front-door workflows
These are the commands you reach for first:

- **`brainstorm`** — shape ideas before committing to a path
- **`orchestrate`** — classify intent and route to the right workflow
- **`enhance`** — improve an existing feature or codebase
- **`debug`** — isolate, explain, and fix regressions
- **`status`** — summarize what’s done, what’s missing, and what’s next

### Backbone phases
These are the durable SDLC artifacts underneath:

- **discovery** — external research and best practices
- **requirements** — scope, users, constraints, success criteria
- **research** — local codebase analysis and risk mapping
- **plan** — implementation phases and dependencies
- **implementation** — completed changes and notes
- **validation** — tests, checks, and outcome verification
- **version-control** — git status, diffs, and commit trail

## How it works

SpecLite combines two useful ideas:

1. **intent-driven workflows** for usability
2. **artifact-driven phases** for reliability

That means:
- you can start from plain language
- the framework routes you toward the right path
- the actual work still lands in inspectable files under `runs/<run_id>/`

## Example paths

### New feature in an unfamiliar domain
```text
brainstorm -> discovery -> requirements -> research -> plan -> implementation -> validation -> version-control
```

### Existing feature improvement
```text
enhance -> research -> plan -> implementation -> validation
```

### Bug or regression
```text
debug -> research -> plan -> implementation -> validation
```

### Re-entry after time away
```text
status
```

## Works with your tools

SpecLite is designed to be reusable across projects and editors.

### Cursor commands
- `/brainstorm`
- `/orchestrate`
- `/enhance`
- `/debug`
- `/status`
- `/discovery`
- `/requirements`
- `/research`
- `/plan`
- `/implement`
- `/validate`
- `/version-control`

### Codex skills
- `@framework-brainstorm`
- `@framework-orchestrate`
- `@framework-enhance`
- `@framework-debug`
- `@framework-status`
- `@framework-discovery`
- `@framework-requirements`
- `@framework-research`
- `@framework-plan`
- `@framework-implement`
- `@framework-validate`
- `@framework-version-control`

### Kiro agents
- `framework-brainstorm`
- `framework-orchestrate`
- `framework-enhance`
- `framework-debug`
- `framework-status`
- `framework-discovery`
- `framework-requirements`
- `framework-research`
- `framework-plan`
- `framework-implement`
- `framework-validate`
- `framework-version-control`

## Why this is better than a pile of prompts

A prompt folder can get you started.
SpecLite helps you keep going without losing the thread.

You get:
- a repeatable workflow
- explicit research and planning artifacts
- structured validation
- reusable integrations
- a clean record of what happened and why

## Why this is lighter than heavyweight spec systems

SpecLite is not trying to make every task feel like enterprise architecture review.

It aims to be:
- **structured enough** to keep quality high
- **light enough** to actually use every day
- **flexible enough** to run only the phases you need

## Who it is for

SpecLite works especially well for:
- solo builders who want less chaos in AI-assisted work
- engineering teams standardizing AI workflows
- people using Cursor, Codex, or Kiro heavily
- feature work that needs real requirements and validation
- debugging and enhancement work that benefits from written artifacts

## Why it is shareable

SpecLite is designed to travel well:
- symlink-based installs instead of duplicated prompt bundles
- reusable workflows and skills
- no run history committed to git
- editor-agnostic structure
- artifacts that are easy to review and hand off

## Artifact contract

Each run stores its work in a predictable structure:

- `discovery/`
  - `discovery.md`
  - `sources.md`
- `requirements/`
  - `requirements.md`
- `research/`
  - `research.md`
  - `index/`
- `plan/`
  - `plan.md`
- `implementation/`
  - `implementation.md`
- `validation/`
  - `validation.md`
  - `test-output.txt`
- `version-control/`
  - `version-control.md`
  - `git-status.txt`
  - `git-diff-stat.txt`
  - `git-diff.txt`
  - `git-commit.txt`

## FAQ

### Do I have to use every phase?
No. Run the full pipeline when it helps, or just the parts you need.

### Is this only for one editor or one model?
No. The structure is editor-agnostic and currently integrates with Codex, Cursor, and Kiro.

### Is this a Spec Kit replacement?
Not exactly. It lives in a similar neighborhood, but it is optimized for lighter day-to-day use, cleaner workflow routing, and artifact-first execution.

### Can teams use this?
Yes. The run-directory model makes handoffs, review, and repeatability much easier.

## More docs

- `QUICKREF.md` — fast command reference
- `EXAMPLES.md` — example usage patterns
- `integrations/README.md` — editor integration details
- `workflows/README.md` — workflow catalog
- `CHANGELOG.md` — notable changes
- `MIGRATION.md` — upgrade notes
