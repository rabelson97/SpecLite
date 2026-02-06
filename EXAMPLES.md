# SpecLite Examples

## Full Workflow Example

### 1. Discovery Phase (Optional)

Research external solutions before diving into code:

```bash
RUN_DIR=$(./tools/new-run.sh "Add OAuth Authentication")
./tools/run-phase.sh discovery "$RUN_DIR" --topics "oauth2,jwt,passport.js"
```

**AI Actions:**
- Uses `web_search` to find OAuth2 best practices
- Researches JWT token management patterns
- Compares authentication libraries (Passport, Auth0, etc.)
- Documents findings in `runs/<run_id>/discovery/discovery.md`
- Creates `sources.md` with all referenced URLs

### 2. Requirements Phase

Gather requirements with PM mindset:

```bash
./tools/run-phase.sh requirements "$RUN_DIR"
```

**AI Actions:**
- Acts as product manager
- Asks clarifying questions about scope, users, constraints
- Updates `runs/<run_id>/requirements/requirements.md` with Q&A
- Confirms readiness before moving to research

### 3. Research Phase

Parallel codebase analysis with specialized agents:

```bash
./tools/run-phase.sh research "$RUN_DIR" --roots "src,lib"
```

**AI Actions:**
- Spawns 5 parallel subagents using `use_subagent`:
  - **Architecture Agent**: Maps module structure and boundaries
  - **Patterns Agent**: Identifies code conventions and styles
  - **Dependencies Agent**: Analyzes external libs and integrations
  - **Gaps Agent**: Finds missing pieces vs requirements
  - **Risks Agent**: Spots tech debt and security issues
- Indexes codebase (files, extensions, largest files)
- Synthesizes all findings into unified research summary
- Outputs to `runs/<run_id>/research/research.md`

### 4. Plan Phase

Create implementation plan with task dependencies:

```bash
./tools/run-phase.sh plan "$RUN_DIR"
```

**AI Actions:**
- Acts as technical lead
- Breaks work into bite-sized, independent phases
- Tracks dependencies between phases
- Marks which phases can run in parallel
- Example output:

```markdown
### Phase 1: Add authentication middleware
- **Goal**: Create JWT validation middleware
- **Files**: `src/middleware/auth.ts`
- **Dependencies**: None
- **Parallel**: Can run independently
- **Outcome**: Middleware validates tokens on protected routes

### Phase 2: Add user authentication routes
- **Goal**: Implement login/logout endpoints
- **Files**: `src/routes/auth.ts`
- **Dependencies**: Phase 1
- **Parallel**: No (requires Phase 1)
- **Outcome**: Users can authenticate and receive tokens

### Phase 3: Add OAuth provider integration
- **Goal**: Integrate Google OAuth
- **Files**: `src/services/oauth.ts`
- **Dependencies**: Phase 1
- **Parallel**: Yes (with Phase 2)
- **Outcome**: Users can sign in with Google
```

### 5. Implementation Phase

Execute phases from plan:

```bash
./tools/run-phase.sh implementation "$RUN_DIR"
```

**AI Actions:**
- Implements one phase at a time
- References plan for scope and dependencies
- Documents changes and decisions
- Notes any blockers or follow-ups

### 6. Validation Phase

Run tests and verify outcomes:

```bash
./tools/run-phase.sh validation "$RUN_DIR" --test-cmd "npm test"
```

**AI Actions:**
- Executes test command
- Captures output to `runs/<run_id>/validation/test-output.txt`
- Verifies outcomes match plan expectations
- Documents pass/fail status

### 7. Version Control Phase

Review and commit changes:

```bash
./tools/run-phase.sh version-control "$RUN_DIR" --status --commit "Add OAuth authentication"
```

**AI Actions:**
- Runs `git status` and `git diff --stat`
- Reviews changes for completeness
- Commits with provided message
- Documents commit rationale

## Key Features in Action

### Parallel Research

The research phase spawns multiple specialized agents simultaneously:

```
Research Agent (main)
├─> Architecture Agent: analyzing module structure...
├─> Patterns Agent: identifying conventions...
├─> Dependencies Agent: mapping integrations...
├─> Gaps Agent: finding missing pieces...
└─> Risks Agent: spotting tech debt...

[All agents complete in parallel]

Research Agent: synthesizing findings...
```

### Web Search Integration

Discovery phase leverages internet research:

```
Discovery: researching "oauth2 best practices"
- Found: OWASP OAuth 2.0 Security Best Practices
- Found: RFC 6749 - The OAuth 2.0 Authorization Framework
- Found: Auth0 OAuth 2.0 Implementation Guide

Discovery: researching "jwt token management"
- Found: JWT.io - Introduction to JSON Web Tokens
- Found: OWASP JWT Cheat Sheet
- Found: Common JWT security pitfalls

[All sources documented in sources.md]
```

### Task Dependency Tracking

Plan phase explicitly tracks what can run in parallel:

```
Phase 1 (no deps) ──┐
                    ├──> Phase 2 (depends on 1)
Phase 3 (no deps) ──┘

Phases 1 and 3 can run in parallel
Phase 2 must wait for Phase 1
```

## Advanced Usage

### Scoped Research

Research specific directories:

```bash
./tools/run-phase.sh research "$RUN_DIR" --roots "src/auth,src/middleware"
```

### Multiple Discovery Topics

Research multiple areas:

```bash
./tools/run-phase.sh discovery "$RUN_DIR" --topics "authentication,authorization,session-management,csrf-protection"
```

### Custom Test Commands

Run specific test suites:

```bash
./tools/run-phase.sh validation "$RUN_DIR" --test-cmd "npm run test:auth"
```

## Integration with AI Tools

### Cursor Slash Commands

```
/0-discovery    → Start external research
/1-requirements → Gather requirements
/2-research     → Parallel codebase analysis
/3-plan         → Create implementation plan
/4-implement    → Execute plan phases
/5-validate     → Run tests
/version-control → Git operations
```

### Kiro CLI Agents

```bash
kiro chat --agent framework-discovery
kiro chat --agent framework-research
kiro chat --agent framework-plan
```

### Codex Skills

```
@framework-discovery
@framework-research
@framework-plan
```

## Tips

1. **Always start with discovery** for unfamiliar problem domains
2. **Let research agents run in parallel** - don't interrupt the process
3. **Review plan dependencies** before implementation to optimize parallel work
4. **Keep phases small** - each should be completable in one session
5. **Use validation frequently** - catch issues early
6. **Commit after each phase** - maintain clean history
