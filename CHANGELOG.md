# SpecLite Changelog

## Version 2.2 - Orchestration, Specialist Overlays, and Shareable Integrations

### Highlights

- Added a new **front-door workflow layer** on top of the canonical phases.
- Introduced lightweight **agents/** and **skills/** directories to make the framework more reusable and shareable.
- Expanded Codex, Cursor, and Kiro integrations with new commands and entry points.
- Reworked documentation and README positioning for clearer discoverability around AI workflow, spec-driven development, and multi-editor usage.

### New workflows

- `brainstorm` - explore options before planning
- `debug` - diagnose issues systematically
- `enhance` - improve an existing system with the smallest viable phase chain
- `orchestrate` - classify intent and route into the right SpecLite path
- `status` - summarize run completeness, blockers, and next steps

### New framework structure

#### Added directories
- `agents/`
- `skills/`

#### Added reference agents
- product manager
- research lead
- technical lead
- implementation engineer
- validator
- release assistant

#### Added reference skills
- requirements elicitation
- repo research
- task decomposition
- validation strategy
- release hygiene

### Integration updates

#### Codex
Added new skills:
- `@framework-brainstorm`
- `@framework-debug`
- `@framework-enhance`
- `@framework-orchestrate`
- `@framework-status`

#### Cursor
Added new slash commands:
- `/brainstorm`
- `/debug`
- `/enhance`
- `/orchestrate`
- `/status`

#### Kiro
Added new agents:
- `framework-brainstorm`
- `framework-debug`
- `framework-enhance`
- `framework-orchestrate`
- `framework-status`

### Documentation improvements

- Rewrote `README.md` to better explain:
  - what SpecLite is
  - who it is for
  - how it differs from large agent kits
  - how intent-based workflows map to artifact-based execution
- Updated `QUICKREF.md`, `EXAMPLES.md`, `integrations/README.md`, and `workflows/README.md`
- Improved language for discoverability around:
  - AI coding workflow
  - spec-driven development
  - Cursor slash commands
  - Codex skills
  - Kiro agents
  - artifact-first AI development

### Compatibility

✅ Backward compatible:
- canonical phases unchanged
- `tools/run-phase.sh` contract unchanged
- existing runs still valid
- new workflows improve ergonomics without replacing the original SDLC backbone

---

## Version 2.1 - Consistency + Flexible Phase Gates

### Highlights

- Fixed run scaffolding to include `discovery/` by default.
- Removed layout mismatch in `new-run.sh` (no more conflicting `notes.md` placeholders).
- Hardened phase runners to create parent directories before writing artifacts.
- Added flexible, input-availability gates (no forced phase order).
- Added `--strict` fail-fast mode and context selection flags (`--use-*` / `--no-*`).
- Updated docs/rules to reflect flexible execution model.

### Behavioral changes

- You can run phases independently (for example: research-only, plan-only, validation-only).
- In permissive mode (default), missing optional upstream artifacts generate warnings.
- In strict mode, selected missing inputs fail fast.
- Validation now fails in strict mode when the test command fails (or when `--test-cmd` is omitted).

## Version 2.0 - SpecLite Release

Major upgrade transforming ai-assisted-framework into **SpecLite** with discovery, parallel research, and dependency-aware planning.

## Version 1.0 - ai-assisted-framework

Initial release with the core phase-based workflow.
