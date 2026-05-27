# Expand packaging to OpenAI Codex CLI and GitHub Copilot

**Status:** Accepted
**Date:** 20260526-2201

## Context

Following [20260526-1007](./20260526-1007-split-universal-vs-claude-code-build.md) (split universal
content from agent-specific packaging) and
[20260526-1035](./20260526-1035-antigravity-plugin-packaging.md) (Antigravity plugin packaging),
the universal body prose in `src/universal/` is ready to be consumed by additional agents.

Two new targets are now needed:

- **OpenAI Codex CLI** — a terminal-based coding agent. Discovers skills from
  `~/.codex/skills/<name>/SKILL.md` (user scope) or `.codex/skills/` (project scope). Uses
  YAML frontmatter (`name`, `description`) on `SKILL.md`. Has no separate commands concept
  (custom prompts were deprecated in favour of skills).
- **GitHub Copilot** (VS Code integrated agent) — discovers three file types:
  prompt files (`.prompt.md`), instruction files (`.instructions.md`), and agent files
  (`.agent.md`). At user scope, prompts are auto-discovered from
  `{VSCODE_USER_DIR}/prompts/` and skills from `~/.copilot/skills/<name>/SKILL.md`.

## Decision

### 1. Codex CLI — `src/codex/`

Introduce `src/codex/` following the same pattern as `src/antigravity/`:

- **Commands-as-skills mapping.** Codex has no commands concept; both universal commands and
  universal skills are packaged as `skills/<name>/SKILL.md` in `dist/`.
- **Settings JSON.** Per-file JSON (`commands/<name>.json`, `skills/<name>.json`) with `name`
  and `description` fields, compiled into YAML frontmatter by `build.sh`.
- **Build output.** `src/codex/dist/` (gitignored), containing only `skills/` directories.
- **Install target.** User scope: `~/.codex/skills/`. The install script builds then copies
  each skill directory.

### 2. GitHub Copilot — `src/copilot/`

Introduce `src/copilot/` with a split output format:

- **Commands → `.prompt.md` files.** Universal commands are packaged as prompt files with
  YAML frontmatter (`description`). These are invokable on-demand via `/name` in Copilot
  chat.
- **Skills → `skills/<name>/SKILL.md`.** Universal skills are packaged as skill directories
  with YAML frontmatter (`name`, `description`), identical to the Codex/Antigravity format.
- **No `.agent.md` files.** Agent files define specialised personas — nothing in the current
  universal content maps to this concept. Skipped for now.
- **Settings JSON.** Per-file JSON under `commands/` and `skills/`, with fields appropriate
  to each output type (prompts get `description`; skills get `name` + `description`).
- **Build output.** `src/copilot/dist/` (gitignored), containing `prompts/` and `skills/`.
- **Install target.** Dual user-scope install:
  - Prompts → `{VSCODE_USER_DIR}/prompts/` (platform-dependent; the install script detects
    OS to resolve the path, following the existing pattern from the user's copilot-prompts
    installer).
  - Skills → `~/.copilot/skills/`.

### 3. AGENTS.md update

The "eventual export target" table in `AGENTS.md` referencing `.github/` is outdated —
Copilot packaging follows the same `src/<agent>/dist/` pattern as the other agents, with
user-scope install. The `.github/` table will be removed.

### 4. No shared build script

Each agent keeps its own `build.sh` under `src/<agent>/`. This is consistent with the
existing pattern and was explicitly evaluated in ADR 20260526-1035 (alternative: "shared
`build.sh` at root" — rejected).

## Consequences

**Positive:**
- Four agents now consume the exact same universal body prose — zero prose duplication.
- Codex packaging is nearly identical to Antigravity (commands-as-skills), minimising new
  concepts.
- Copilot's split output (prompts + skills) preserves the semantic distinction between
  on-demand workflows and always-available project conventions.
- User-scope install for all agents: contributors get the workflows without polluting
  any specific repo.

**Negative / trade-offs:**
- Copilot requires two install destinations (VS Code user dir for prompts, `~/.copilot/` for
  skills), making its install script slightly more complex.
- Developers now maintain settings JSON in four agent-specific directories. The settings are
  small (2–4 fields each), but the count of files grows linearly.
- The `~/.copilot/skills/` discovery path is not yet widely documented; user will validate
  experimentally.
- Helper files (ADR-FORMAT.md, etc.) are included in Codex and Copilot skill directories but
  cannot be bundled with Copilot prompt files (flat `.prompt.md` format). The prompts
  reference skills that carry the helpers, so this is acceptable.

## Alternatives considered

- **Copilot: everything as `.prompt.md`** — map skills to prompts too, single install
  destination. Rejected: loses the always-available semantics of skills; `docs-structure` as
  an on-demand prompt would need explicit invocation for something that should be ambient.
- **Copilot: check files into `.github/`** — repo-scoped, no install script needed.
  Rejected: user wants consistent user-scope install across all agents; `.github/` is
  checked-in and repo-specific, not portable.
- **Shared build script** — one builder for all agents. Rejected per ADR 20260526-1035:
  keeps agent concerns encapsulated; each build script is small (~70 lines).

---

**Correction note — 2026-05-27:** The global `project-docs-structure` skill was deprecated and removed from both Codex CLI and GitHub Copilot packaging. Instead, the agents will dynamically discover project-level rules in `docs/project-docs-structure.md` using the updated, global `docs-structure` skill as a router. See [20260527-1559-transition-project-docs-structure-to-repository-file.md](./20260527-1559-transition-project-docs-structure-to-repository-file.md).
