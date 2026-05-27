# Auto Doc Flow

This project builds reusable agent skills and custom commands for structured documentation
workflows.

## Current state

The repository currently ships 5 commands and 1 skill from one shared source of truth in
`src/universal/`, then packages that content for four targets:

- Claude Code
- Google Antigravity
- OpenAI Codex CLI
- GitHub Copilot

Each agent keeps its own packaging metadata and `build.sh` under `src/<agent>/`, while the
portable command and skill prose stays in `src/universal/`.

## Repository layout

| What | Where |
|---|---|
| Command and skill bodies (agent-agnostic) | [`src/universal/`](src/universal/README.md) |
| Claude Code settings, build script, and plugin metadata | [`src/claude-code/`](src/claude-code/README.md) |
| Antigravity settings, build script, and plugin metadata | [`src/antigravity/`](src/antigravity/README.md) |
| Codex CLI settings, build script, and plugin metadata | [`src/codex/`](src/codex/README.md) |
| GitHub Copilot settings, build script, and plugin metadata | [`src/copilot/`](src/copilot/README.md) |
| Format templates (CONTEXT, ADR, incident) | [`docs/project-docs-structure.md`](docs/project-docs-structure.md) |
| Historical prototypes and references | [`docs/reference/`](docs/reference/) |

## Build and install

| Target | Build | Install |
|---|---|---|
| Claude Code | `bash src/claude-code/build.sh` | Load from `src/claude-code/dist` |
| Antigravity | `bash src/antigravity/build.sh` | `bash scripts/install-antigravity-plugin.sh` |
| Codex CLI | `bash src/codex/build.sh` | `bash scripts/install-codex-plugin.sh` |
| GitHub Copilot | `bash src/copilot/build.sh` | `bash scripts/install-copilot-plugin.sh` |

Generated output always goes to the target-specific `src/<agent>/dist/` directory and is not
checked into git.
