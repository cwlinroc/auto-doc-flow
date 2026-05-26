# Split universal content from Claude-Code packaging behind a build step

**Status:** Accepted
**Date:** 20260526-1007

## Context

`src/universal/` was the single working Claude Code plugin: it bundled the portable
instruction prose (command/skill bodies) together with Claude-Code-only packaging — YAML
frontmatter on every `.md` and plugin metadata in `.claude-plugin/`. This coupling blocked
reuse of the body content for other agents (Gemini, GitHub Copilot, etc.) without duplicating
and maintaining diverging copies.

`src/claude-code/` existed as scaffolding holding one empty JSON file per command and per
skill, with no build mechanism.

## Decision

Split into two concerns:

- **`src/universal/`** holds agent-agnostic **body only**: the prose of each command and
  skill, no frontmatter. Helper files (ADR-FORMAT.md, etc.) remain here unchanged.
- **`src/claude-code/`** holds Claude Code–specific **settings** (per-file JSON with the
  frontmatter fields for each command and skill), plugin metadata (`plugin/plugin.json`,
  `plugin/marketplace.json`), and `build.sh`.

`build.sh` is the single generator: it reads each `commands/<name>.json` and
`skills/<name>.json`, combines the settings with the matching body from `src/universal/`, and
writes the fully assembled `.md` files into `src/claude-code/dist/`. `dist/` is the only
artifact Claude Code loads; it is gitignored.

Per-file JSON (not one central file) keeps the existing scaffold and localises each item's
metadata alongside its own natural edit unit.

## Consequences

**Positive:**
- Universal content is now reusable per agent without coupling to Claude Code's packaging.
- Build is reproducible and lossless: `build.sh` run twice yields identical output.
- `claude plugin validate dist` remains the correct diagnostic (per incident
  `20260526-0940-plugin-install-unsupported-source-type`).
- The `dist/` convention matches common web-project practice; contributors recognise it.

**Negative / trade-offs:**
- Editing a command now touches two files: the universal body and the settings JSON.
  Contributors must remember to run `build.sh` before install or test.
- `dist/` must never be hand-edited; changes there are silently overwritten on the next build.
- A future agent-specific directory (e.g. `src/gemini/`) will need its own settings JSON and
  build/render step — but the universal body is already ready.

## Alternatives considered

- **Single central settings JSON** — one file listing all commands and skills. Rejected:
  discards the existing per-file scaffold; one large file to merge; harder to diff per item.
- **Keep frontmatter in universal** — JSON adds only Claude-Code-specific extras on top.
  Rejected: metadata duplicated in two places creates drift; "universal" body would still
  contain agent-specific syntax.
- **Generate into `claude-code/` root** — no `dist/` subfolder. Rejected: mixes generated
  files with JSON source; no clean boundary for gitignore; tooling confusion.
