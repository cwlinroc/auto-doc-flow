# Auto docs flow

This is a project meant to build skills and custom commands, that can generate documentation that fits the agent tool workflow.

## Current state

5 commands and 2 skills, working as a Claude Code plugin. Source is split into a two-layer
build pipeline: universal body prose in `src/universal/`, Claude Code packaging in
`src/claude-code/`. Run `bash src/claude-code/build.sh` to regenerate the plugin.

| What | Where |
|---|---|
| Command & skill bodies (agent-agnostic) | [`src/universal/`](src/universal/README.md) |
| Claude Code settings, build script & plugin | [`src/claude-code/`](src/claude-code/README.md) |
| Format examples (CONTEXT, ADR, incident) | [`src/universal/skills/project-docs-structure/`](src/universal/skills/project-docs-structure/SKILL.md) |
| Historical prototypes & references | [`docs/reference/`](docs/reference/) |
