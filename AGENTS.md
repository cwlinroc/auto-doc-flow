# Auto Doc Flow — Agent Instructions

This project builds VS Code agent skills and custom commands that generate structured documentation.

## Project goal

Produce reusable `.github/` customizations (skills, prompts, agents) for documentation workflows — using the prototypes in `docs/reference/` as the source of truth.

## Key reference

- [Claude prototype](docs/reference/claude-prototype/README.md) — the primary reference; includes a docs-structure skill and command examples
- [Gemini prototype](docs/reference/gemini-prototype/) — plain-text equivalents for cross-model comparison
- [original-ones](docs/reference/original-ones/) - source like original grill-me skills and what the user is currently using

## Docs conventions

Follow the layout defined in [docs/reference/claude-prototype/SKILL.md](docs/reference/claude-prototype/SKILL.md):

| Folder            | Purpose                                                          |
| ----------------- | ---------------------------------------------------------------- |
| `docs/adr/`       | Architecture Decision Records (`NNNN-kebab-title.md`)            |
| `docs/design/`    | Design write-ups still under exploration                         |
| `docs/runbooks/`  | Repeatable operational procedures                                |
| `docs/incident/`  | Blameless incident reviews                                       |
| `docs/reference/` | Technical reference and third-party docs                         |
| `docs/context/`   | Business context (customers, SLAs, domain)                       |
| `docs/draft/`     | Gitignored personal scratch; graduate to `docs/` when team-ready |

## Where to put new customization files

| Type         | Location                                      |
| ------------ | --------------------------------------------- |
| Skills       | `.github/skills/<name>/SKILL.md`              |
| Prompts      | `.github/prompts/<name>.prompt.md`            |
| Agents       | `.github/agents/<name>.agent.md`              |
| Instructions | `.github/instructions/<name>.instructions.md` |
