# Auto docs flow

This is a project meant to build skills and custom commands, that can generate documentation that fits the agent tool workflow.

## Current state

First working version in `src/universal/` — 5 commands and 2 skills targeting Claude Code,
ready to start iterating. Cross-agent packaging (`src/claude/`, `update-all.sh`) comes next.

| What | Where |
|---|---|
| Commands & skills source | [`src/universal/`](src/universal/README.md) |
| Format examples (CONTEXT, ADR, incident) | [`src/universal/skills/project-docs-structure/`](src/universal/skills/project-docs-structure/SKILL.md) |
| Historical prototypes & references | [`docs/reference/`](docs/reference/) |
