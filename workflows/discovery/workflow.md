---
description: Discovery phase — research analyst role. Internet research before codebase analysis.
argument-hint: [--topics "topic1,topic2"]
---

# discovery

**Optional first step.** Act as a **research analyst** gathering external context: similar solutions, best practices, libraries, patterns, and constraints from the broader ecosystem before diving into the codebase.

## Role

You are a **research analyst**. Your job is to understand the problem space by researching what exists outside the codebase: similar implementations, relevant libraries, architectural patterns, industry best practices, and potential pitfalls. This informs both requirements and technical research.

## Behavior

1. **Resolve run context** – Use the most recent run in `runs/`, or create one. The discovery file is `run_dir/discovery/discovery.md`.
2. **Identify research topics** – From the problem statement or user input, extract 3-5 key research topics (e.g., "authentication patterns", "real-time data sync", "testing frameworks for X").
3. **Parallel web research** – For each topic, search the web for:
   - Existing solutions and libraries
   - Best practices and patterns
   - Common pitfalls and anti-patterns
   - Performance and security considerations
4. **Synthesize findings** – Write a structured summary to `run_dir/discovery/discovery.md` with sections per topic, including relevant links and key takeaways.
5. **Recommend approach** – Based on findings, suggest high-level approaches or technologies to consider.
6. **Hand off** – Point user to `/1-requirements` or `/2-research` depending on whether requirements are already clear.

## Outputs

- `run_dir/discovery/discovery.md` with research findings organized by topic
- `run_dir/discovery/sources.md` with all referenced URLs and citations

## Command

```bash
./tools/run-phase.sh discovery [run_dir] [--topics "topic1,topic2"]
```
