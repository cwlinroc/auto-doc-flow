# Auto Doc Flow — Agent Instructions

This project builds VS Code agent skills and custom commands that generate structured documentation.

## Project goal

Produce reusable agent customizations (skills, commands) for documentation workflows. The
source lives in `src/universal/`; the eventual packaging targets are agent-specific directories
under `src/` (Claude Code, Antigravity, OpenAI Codex CLI, and GitHub Copilot).

## Key reference

- [`src/universal/`](src/universal/README.md) — **body source**: agent-agnostic command and
  skill prose (no frontmatter)
- [`src/claude-code/`](src/claude-code/README.md) — Claude Code settings JSON + `build.sh`;
  run `bash src/claude-code/build.sh` to regenerate the plugin
- [`src/antigravity/`](src/antigravity/README.md) — Antigravity settings JSON + `build.sh` +
  installer; run `bash src/antigravity/build.sh` to build, or
  `bash scripts/install-antigravity-plugin.sh` to build and install
- [`src/codex/`](src/codex/README.md) — Codex CLI settings JSON + `build.sh`;
  run `bash src/codex/build.sh` to build, or
  `bash scripts/install-codex-plugin.sh` to build and install
- [`src/copilot/`](src/copilot/README.md) — Copilot settings JSON + `build.sh`;
  run `bash src/copilot/build.sh` to build, or
  `bash scripts/install-copilot-plugin.sh` to build and install
- [Claude prototype](docs/reference/claude-prototype/README.md) — historical prototype;
  useful for command style and structure patterns
- [Gemini prototype](docs/reference/gemini-prototype/) — plain-text equivalents for
  cross-model comparison
- [original-ones](docs/reference/original-ones/) — source of the original grill-me skills

## Docs conventions

Follow the layout defined in
[`docs/project-docs-structure.md`](docs/project-docs-structure.md):

| Path              | Purpose                                                                         |
| ----------------- | ------------------------------------------------------------------------------- |
| `docs/CONTEXT.md` | Glossary only — shared terminology, no implementation detail                    |
| `docs/adr/`       | Architecture Decision Records (`YYYYMMDD-hhmm-<slug>.md`, immutable)           |
| `docs/design/`    | Design write-ups still under exploration                                        |
| `docs/domain/`    | Business context: customers, SLAs, seasonality, domain rules                   |
| `docs/incident/`  | Blameless incident records (`YYYYMMDD-hhmm-<slug>.md`, immutable)              |
| `docs/reference/` | Technical reference and third-party source material (stored verbatim)          |
| `docs/draft/`     | Gitignored personal scratch; graduate to `docs/` when team-ready               |

Draft file naming: `Thoughts-<topic>.md`, `Problem-<topic>.md`, `PLAN-<topic>.md`.

## Where to put new customization files

**Universal body (agent-agnostic prose, no frontmatter):**

| Type     | Location                                       |
| -------- | ---------------------------------------------- |
| Skills   | `src/universal/skills/<name>/SKILL.md`         |
| Commands | `src/universal/commands/<name>.md`             |

**Claude Code settings (metadata + plugin packaging):**

| Type              | Location                                       |
| ----------------- | ---------------------------------------------- |
| Command settings  | `src/claude-code/commands/<name>.json`         |
| Skill settings    | `src/claude-code/skills/<name>.json`           |
| Plugin metadata   | `src/claude-code/plugin/{plugin,marketplace}.json` |

After editing either the universal body or the settings JSON, run:
`bash src/claude-code/build.sh` to regenerate `src/claude-code/dist/`.

**Antigravity settings (metadata + plugin packaging):**

| Type              | Location                                       |
| ----------------- | ---------------------------------------------- |
| Command settings  | `src/antigravity/commands/<name>.json`         |
| Skill settings    | `src/antigravity/skills/<name>.json`           |
| Plugin metadata   | `src/antigravity/plugin.json`                  |

After editing either the universal body or the settings JSON, run:
`bash src/antigravity/build.sh` to regenerate `src/antigravity/dist/`, or
`bash scripts/install-antigravity-plugin.sh` to build and install in one step.

**Codex settings (metadata + plugin packaging):**

| Type              | Location                                       |
| ----------------- | ---------------------------------------------- |
| Command settings  | `src/codex/commands/<name>.json`               |
| Skill settings    | `src/codex/skills/<name>.json`                 |
| Plugin metadata   | `src/codex/plugin.json`                        |

After editing either the universal body or the settings JSON, run:
`bash src/codex/build.sh` to regenerate `src/codex/dist/`, or
`bash scripts/install-codex-plugin.sh` to build and install.

**Copilot settings (metadata + plugin packaging):**

| Type              | Location                                       |
| ----------------- | ---------------------------------------------- |
| Command settings  | `src/copilot/commands/<name>.json`             |
| Skill settings    | `src/copilot/skills/<name>.json`               |
| Plugin metadata   | `src/copilot/plugin.json`                      |

After editing either the universal body or the settings JSON, run:
`bash src/copilot/build.sh` to regenerate `src/copilot/dist/`, or
`bash scripts/install-copilot-plugin.sh` to build and install.

## Packaging and installation rules

- If there is no need to check the generated outputs under `dist/` directly, do not run the build/installation commands yourself. Instead, ask the user to run the update script at the end of the task.

## Git operations

- **Do not perform `git add` or `git commit` operations unless explicitly requested by the user.** The user will review all working-tree changes and stage/commit them manually.
