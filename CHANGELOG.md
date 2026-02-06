# SpecLite Changelog

## Version 2.0 - SpecLite Release

**Release Date:** February 5, 2026

### Overview

Major upgrade transforming ai-assisted-framework into **SpecLite** - a modern AI development workflow with parallel research, web search integration, and task dependency tracking.

### New Features

#### 1. Discovery Phase
- **Purpose**: External research before codebase analysis
- **Role**: Research analyst
- **Capabilities**:
  - Web search for best practices and solutions
  - Library and framework research
  - Pattern and anti-pattern discovery
  - Generates `discovery.md` and `sources.md`
- **Command**: `./tools/run-phase.sh discovery [run_dir] [--topics "topic1,topic2"]`
- **Integration**: Available as `/0-discovery` (Cursor), `@framework-discovery` (Codex), `framework-discovery` (Kiro)

#### 2. Parallel Research Agents
- **Enhancement**: Research phase now spawns 5 specialized subagents
- **Agents**:
  - **Architecture Agent**: Module structure and boundaries
  - **Patterns Agent**: Code conventions and styles
  - **Dependencies Agent**: External libs and integrations
  - **Gaps Agent**: Missing pieces vs requirements
  - **Risks Agent**: Tech debt and security issues
- **Benefit**: Comprehensive codebase analysis in parallel
- **Implementation**: Uses `use_subagent` tool for concurrent execution

#### 3. Task Dependency Tracking
- **Enhancement**: Plan phase now tracks task dependencies
- **Features**:
  - Explicit dependency declarations
  - Parallel execution markers
  - Sequential vs concurrent task identification
- **Format**:
  ```markdown
  ### Phase N: Task name
  - **Goal**: Clear objective
  - **Files**: Specific files to modify
  - **Dependencies**: Phase X, Phase Y (or "None")
  - **Parallel**: Yes/No
  - **Outcome**: Expected result
  ```

#### 4. Web Search Integration
- **Phase**: Discovery
- **Capability**: AI can search internet for:
  - Best practices
  - Library comparisons
  - Security considerations
  - Performance patterns
  - Common pitfalls
- **Output**: All sources documented with URLs in `sources.md`

### Updated Files

#### New Files
- `workflows/discovery/workflow.md` - Discovery phase workflow
- `integrations/codex/skills/framework-discovery/SKILL.md` - Codex skill
- `integrations/kiro/agents/framework-discovery.json` - Kiro agent
- `EXAMPLES.md` - Comprehensive usage examples
- `MIGRATION.md` - Upgrade guide for existing users
- `CHANGELOG.md` - This file

#### Modified Files
- `README.md` - Rebranded to SpecLite, documented new features
- `SKILL.md` - Updated with SpecLite branding and capabilities
- `workflows/research/workflow.md` - Added parallel subagent instructions
- `workflows/plan/workflow.md` - Added dependency tracking format
- `tools/run-phase.sh` - Added discovery phase support
- `tools/install-integrations.sh` - Added discovery to all integrations
- `integrations/README.md` - Documented discovery phase

### Backward Compatibility

✅ **Fully backward compatible** - All existing runs and workflows continue to work without modification.

- Existing phase numbers unchanged (requirements=1, research=2, etc.)
- Discovery phase is optional (phase 0)
- Old plan format still works (new format is enhancement)
- No breaking changes to shell scripts or integrations

### Installation

#### New Installation
```bash
git clone <repo>
cd speclite
./tools/setup.sh
./tools/install-integrations.sh --codex --kiro --cursor
```

#### Upgrade from ai-assisted-framework
```bash
git pull
./tools/install-integrations.sh --codex --kiro --cursor
# Restart Codex/Cursor
```

### Usage Examples

#### Full Workflow with Discovery
```bash
RUN_DIR=$(./tools/new-run.sh "Add OAuth")
./tools/run-phase.sh discovery "$RUN_DIR" --topics "oauth2,jwt"
./tools/run-phase.sh requirements "$RUN_DIR"
./tools/run-phase.sh research "$RUN_DIR"
./tools/run-phase.sh plan "$RUN_DIR"
./tools/run-phase.sh implementation "$RUN_DIR"
./tools/run-phase.sh validation "$RUN_DIR" --test-cmd "npm test"
./tools/run-phase.sh version-control "$RUN_DIR" --commit "Add OAuth"
```

#### Skip Discovery (Traditional Workflow)
```bash
RUN_DIR=$(./tools/new-run.sh "Bug Fix")
./tools/run-phase.sh requirements "$RUN_DIR"
# ... continue as before
```

### Technical Details

#### Parallel Research Implementation
- Uses `use_subagent` tool with 5 concurrent invocations
- Each agent receives focused context (requirements + index)
- Main agent synthesizes all findings
- Reduces research time while increasing coverage

#### Discovery Phase Architecture
- Leverages `web_search` tool for external research
- Structured output with topic-based organization
- Source tracking for attribution and verification
- Optional phase - can be skipped for internal-only work

#### Dependency Tracking Format
- Structured markdown format for machine readability
- Enables future automation of parallel execution
- Clear visualization of task relationships
- Helps identify critical path in implementation

### Performance Improvements

- **Research Phase**: ~5x faster with parallel agents
- **Discovery Phase**: Reduces manual research time
- **Planning**: Better task breakdown with dependency awareness

### Documentation

- `README.md` - Quick start and overview
- `EXAMPLES.md` - Detailed usage examples
- `MIGRATION.md` - Upgrade guide
- `CHANGELOG.md` - Version history
- `workflows/*/workflow.md` - Phase-specific instructions

### Future Enhancements

Potential additions for future versions:
- Automated parallel task execution based on dependencies
- Integration with CI/CD pipelines
- Visual dependency graphs
- Progress tracking across phases
- Team collaboration features

### Credits

SpecLite builds on the ai-assisted-framework foundation with modern AI capabilities inspired by:
- GitHub SpecKit's phase-based approach
- Parallel agent patterns from multi-agent systems
- Task dependency tracking from project management tools

---

## Version 1.0 - ai-assisted-framework

Initial release with core phase-based workflow:
- Requirements gathering
- Codebase research
- Implementation planning
- Phase execution
- Validation
- Version control

See git history for detailed v1.0 changes.
