# Auto Doc Flow — Agent Instructions

This project builds VS Code agent skills and custom commands that generate structured documentation.

## Project goal

Produce reusable agent customizations (skills, commands) for documentation workflows. The
source lives in `src/universal/`; the eventual export target is `.github/` (or
agent-specific directories under `src/`). Cross-agent packaging comes after the Claude Code
version is stable.

## Key reference

- [`src/universal/`](src/universal/README.md) — **primary source**: the working commands and
  skills, targeting Claude Code first
- [`draft-note.md`](draft-note.md) — latest design thinking; takes precedence over older
  references when they conflict
- [Claude prototype](docs/reference/claude-prototype/README.md) — historical prototype;
  useful for command style and structure patterns
- [Gemini prototype](docs/reference/gemini-prototype/) — plain-text equivalents for
  cross-model comparison
- [original-ones](docs/reference/original-ones/) — source of the original grill-me skills

## Docs conventions

Follow the layout defined in
[`src/universal/skills/project-docs-structure/SKILL.md`](src/universal/skills/project-docs-structure/SKILL.md):

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

**Current source (iterate here first):**

| Type     | Location                                       |
| -------- | ---------------------------------------------- |
| Skills   | `src/universal/skills/<name>/SKILL.md`         |
| Commands | `src/universal/commands/<name>.md`             |

**Eventual export target (after packaging):**

| Type         | Location                                      |
| ------------ | --------------------------------------------- |
| Skills       | `.github/skills/<name>/SKILL.md`              |
| Prompts      | `.github/prompts/<name>.prompt.md`            |
| Agents       | `.github/agents/<name>.agent.md`              |
| Instructions | `.github/instructions/<name>.instructions.md` |

## Git operations

- **Do not perform `git add` or `git commit` operations unless explicitly requested by the user.** The user will review all working-tree changes and stage/commit them manually.

