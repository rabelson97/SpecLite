# SpecLite

[![Artifact-first workflow](https://img.shields.io/badge/workflow-artifact--first-4f46e5)](#artifact-contract)
[![Spec-driven development](https://img.shields.io/badge/method-spec--driven-0f766e)](#canonical-phases)
[![Works with Codex](https://img.shields.io/badge/Codex-supported-black)](#multi-editor-setup)
[![Works with Cursor](https://img.shields.io/badge/Cursor-supported-2563eb)](#multi-editor-setup)
[![Works with Kiro](https://img.shields.io/badge/Kiro-supported-7c3aed)](#multi-editor-setup)

**SpecLite** is an **artifact-first AI development workflow framework** for **spec-driven development**, **AI coding assistants**, and **multi-editor agent workflows**.

It helps you run software work through a clean SDLC pipeline — **discovery, requirements, research, plan, implementation, validation, and version control** — while storing every phase artifact in a dedicated run directory.

If you like the ergonomics of agent kits but want something more rigorous, inspectable, and shareable, SpecLite is built for that.

## TL;DR

SpecLite gives you:

- **spec-driven AI development** without heavyweight process overhead
- **artifact-first workflows** instead of chat-history-only execution
- **intent-based entry points** like `brainstorm`, `debug`, and `enhance`
- **portable integrations** for **Codex**, **Cursor**, and **Kiro**
- **run directories** you can review, diff, archive, and hand off

## Why SpecLite

Most AI coding workflows are good at momentum but weak at traceability. SpecLite keeps the speed while adding structure:

- **Artifact-first**: every phase writes output to `runs/<run_id>/`
- **Spec-driven**: requirements, research, and planning come before implementation
- **Intent-routed**: use workflows like `brainstorm`, `enhance`, `debug`, and `orchestrate`
- **Tool-portable**: works with **Codex**, **Cursor**, and **Kiro**
- **Shareable**: symlink-based integrations, no copy-paste template sprawl
- **Inspectable**: each run can be reviewed, diffed, archived, or handed off

## Best fit

SpecLite works especially well for:

- AI-assisted feature development
- spec-driven engineering teams
- solo builders who want cleaner AI workflow discipline
- Cursor / Codex / Kiro slash-command setups
- product-to-code workflows where requirements and plans matter
- debugging and enhancement work that benefits from explicit artifacts

## Who this is for

Use SpecLite if you want:

- a **spec-driven development framework for AI coding tools**
- a **Cursor slash-command workflow** that is not just loose prompts
- a **Codex workflow framework** with reusable skills and prompts
- a **Kiro-compatible AI workflow** with cleaner artifacts
- a way to make AI-assisted development more legible to yourself or your team

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

## New front-door workflows

SpecLite now includes higher-level workflows inspired by specialist agent kits, without giving up the core run artifact model.

- **`/orchestrate`** - classify the request and choose the smallest correct path
- **`/brainstorm`** - explore options before locking into a plan
- **`/enhance`** - improve an existing feature or codebase with the right phase chain
- **`/debug`** - diagnose issues systematically and route to fix + validation
- **`/status`** - summarize run completeness, blockers, and next steps

These sit on top of the canonical phases rather than replacing them.

## Canonical phases

1. **Discovery** (optional): external research on libraries, patterns, best practices, and trade-offs
2. **Requirements**: clarify problem, scope, constraints, users, and success criteria
3. **Research**: analyze the local codebase with structured context gathering
4. **Plan**: create bite-sized implementation phases and dependencies
5. **Implementation**: execute planned changes with traceable notes
6. **Validation**: test and verify outcomes against requirements and plan
7. **Version Control**: summarize changes, inspect git state, and optionally commit

> Phases are flexible. You can run any phase directly when needed.
> Use `--strict` when you want missing context or test failures to fail fast.

## Example workflow paths

### New feature in an unfamiliar domain

```text
brainstorm -> discovery -> requirements -> research -> plan -> implementation -> validation -> version-control
```

### Existing feature enhancement

```text
enhance -> research -> plan -> implementation -> validation
```

### Bug or regression

```text
debug -> research -> plan -> implementation -> validation
```

### Status review

```text
status
```

## Project structure

- `workflows/` - canonical workflow markdown commands
- `tools/` - shell scripts used by workflows
- `integrations/` - Codex / Kiro / Cursor integration configs
- `agents/` - small specialist role overlays
- `skills/` - reusable framework knowledge modules
- `rules/` - framework rules
- `runs/` - generated run directories and phase artifacts (gitignored)

## Workflow philosophy

SpecLite combines two ideas:

1. **Phase discipline** from spec-driven development
2. **Specialist ergonomics** from modern agent kits

In practice, that means:

- you can start from intent (`debug this`, `enhance that`, `brainstorm options`)
- SpecLite routes you into the right artifact-producing path
- your run directory remains the single source of truth

## Lightweight specialist system

SpecLite intentionally keeps the specialist model small and practical.

Included agent roles:

- Product manager
- Research lead
- Technical lead
- Implementation engineer
- Validator
- Release assistant

Included framework skills:

- Requirements elicitation
- Repo research
- Task decomposition
- Validation strategy
- Release hygiene

This gives you the benefits of agent specialization without turning the framework into a giant prompt warehouse.

## Multi-editor setup

This framework uses **symlinks only** — nothing is copied.

```bash
./tools/install-integrations.sh --codex --kiro --cursor   # global symlinks
./tools/install-integrations.sh --project                 # project-scoped (run from project root)
```

After installing, restart Codex or reload Cursor for slash commands to appear.

## Available commands

### Cursor slash commands

- `/brainstorm`
- `/debug`
- `/0-discovery`
- `/enhance`
- `/orchestrate`
- `/1-requirements`
- `/2-research`
- `/3-plan`
- `/4-implement`
- `/status`
- `/5-validate`
- `/version-control`

### Codex skills

- `@framework-brainstorm`
- `@framework-debug`
- `@framework-discovery`
- `@framework-enhance`
- `@framework-orchestrate`
- `@framework-requirements`
- `@framework-research`
- `@framework-plan`
- `@framework-implement`
- `@framework-status`
- `@framework-validate`
- `@framework-version-control`

### Kiro agents

- `framework-brainstorm`
- `framework-debug`
- `framework-discovery`
- `framework-enhance`
- `framework-orchestrate`
- `framework-requirements`
- `framework-research`
- `framework-plan`
- `framework-implement`
- `framework-status`
- `framework-validate`
- `framework-version-control`

## Why this is shareable

SpecLite is designed to be reused across projects and teams:

- no run history committed to git
- symlink-based integration install
- reusable workflows instead of per-project prompt copies
- small framework skills and agent overlays
- inspectable outputs that make collaboration and review easier

## How SpecLite compares

### SpecLite vs generic prompt folders

SpecLite adds:
- a defined SDLC flow
- durable run artifacts
- explicit validation and version-control stages
- reusable integrations across editors

Generic prompt folders are easier to start with, but they usually lack durable execution structure.

### SpecLite vs large agent kits

Large agent kits often optimize for breadth: many agents, many skills, many commands.

SpecLite optimizes for:
- **traceability** over sheer catalog size
- **artifact quality** over prompt sprawl
- **portability** over tool lock-in
- **disciplined execution** over purely conversational flow

### SpecLite vs rigid spec systems

Some spec systems are extremely thorough but heavy.

SpecLite aims for a middle ground:
- structured enough to be reliable
- light enough to actually use
- flexible enough to run one phase at a time when needed

## Use cases

- planning a feature before handing it to an AI coding assistant
- improving an existing codebase with better documentation and validation
- debugging with reproducible artifacts instead of chat-only memory
- standardizing AI workflows across multiple editors
- creating a reusable AI engineering operating system for a team

## Artifact contract

Each phase writes its primary artifact into a dedicated directory under a run. This makes runs easy to browse, diff, and archive.

- `discovery/`
  - `discovery.md` (primary)
  - `sources.md`
- `requirements/`
  - `requirements.md` (primary)
- `research/`
  - `research.md` (primary)
  - `index/` (generated)
    - `files.txt`, `extensions.txt`, `largest_files.txt`, `directories.txt`
- `plan/`
  - `plan.md` (primary)
- `implementation/`
  - `implementation.md` (primary)
- `validation/`
  - `validation.md` (primary)
  - `test-output.txt` (captured when `--test-cmd` is provided)
- `version-control/`
  - `version-control.md` (primary)
  - `git-status.txt`, `git-diff-stat.txt` (captured when `--status` is provided)
  - `git-diff.txt` (captured when `--diff` is provided)
  - `git-commit.txt` (captured when `--commit` is provided)

## SEO / discoverability keywords

People looking for this project may search for:

- spec-driven development
- AI development workflow
- artifact-first AI workflow
- Cursor slash commands
- Codex workflow
- Kiro agent workflow
- AI engineering workflow framework
- prompt engineering for software delivery
- reusable AI coding assistant workflows

## FAQ

### Is this a replacement for GitHub Spec Kit?

Not exactly. SpecLite lives in a similar neighborhood, but it emphasizes lighter-weight adoption, editor portability, and artifact-first execution with a smoother day-to-day workflow surface.

### Does this require a specific editor or model?

No. The framework is designed to work across Codex, Cursor, and Kiro, and the core structure is editor-agnostic.

### Do I have to use every phase?

No. You can run the full flow or only the phases you need.

### Can teams use this?

Yes. The run-directory model makes it easier to review work, hand off context, and standardize how AI-assisted development is done.

## Notes

- `runs/` is gitignored; the repo ships with no run history.
- Discovery phase stores external references in `sources.md`.
- High-level workflows improve ergonomics, but the canonical phases remain the core contract.

## More docs

- `QUICKREF.md` - fast command reference
- `EXAMPLES.md` - example usage patterns
- `integrations/README.md` - editor integration details
- `workflows/README.md` - workflow catalog
- `CHANGELOG.md` - notable changes
- `MIGRATION.md` - upgrade notes
