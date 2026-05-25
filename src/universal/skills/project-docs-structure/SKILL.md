---
name: project-docs-structure
description: Use this skill when doc-producing commands need the project-specific docs layout for this repository. More authoritative than docs-structure — follow this when the two differ.
---

# Project Docs Structure

This skill is the local authority on how docs are organized in this repository. Use it
together with `docs-structure`; when the two conflict, follow this file.

## Target layout

```text
.
├── README.md
└── docs/
    ├── CONTEXT.md      # glossary ONLY — shared terminology, no implementation detail
    ├── adr/            # Architecture Decision Records
    ├── design/         # designs under exploration
    ├── domain/         # business context: customers, SLAs, seasonality, domain rules
    ├── incident/       # blameless incident records
    ├── reference/      # technical reference + raw source material
    └── draft/          # gitignored scratch
```

## What goes where

- `README.md` — entry point and quick orientation.
- `docs/CONTEXT.md` — glossary and shared terminology, nothing else. No implementation
  detail, no specs, no scratch notes. See [CONTEXT-FORMAT.md](./CONTEXT-FORMAT.md).
- `docs/adr/` — decisions that are hard to reverse or hard to understand without context.
  See [ADR-FORMAT.md](./ADR-FORMAT.md).
- `docs/design/` — designs and tradeoffs still being worked through.
- `docs/domain/` — business context: who uses this system, under what constraints, seasonal
  patterns, SLAs.
- `docs/incident/` — blameless incident records. See [INCIDENT-FORMAT.md](./INCIDENT-FORMAT.md).
- `docs/reference/` — technical reference material and raw source documents worth keeping
  near the project. Store verbatim; optionally add a separate summary that cites it.
- `docs/draft/` — early thoughts, rough plans, personal scratch. Gitignored. Not team-facing.

## Naming conventions

| Doc type | Pattern | Example |
|---|---|---|
| ADR | `YYYYMMDD-hhmm-<slug>.md` | `20260525-1430-use-postgres-for-write-model.md` |
| Incident | `YYYYMMDD-hhmm-<slug>.md` | `20260525-0910-payment-timeout-prod.md` |
| Draft | `Thoughts-<topic>.md` / `Problem-<topic>.md` / `PLAN-<topic>.md` | `PLAN-auth-rework.md` |
| Everything else | lowercase kebab-case | `checkout-flow.md` |

**Getting the timestamp:** Run the date-getting shell command yourself first (e.g., `Get-Date -Format "yyyyMMdd-HHmm"` in PowerShell or `date +%Y%m%d-%H%M` in bash). Only ask the engineer if command execution is unavailable or fails.


## Cross-cutting rules for all commands

1. **Never auto-commit.** All output is a working-tree change for the engineer to review.
2. **Lazy folder creation.** Only create `docs/adr/`, `docs/incident/`, etc. when the first
   file in that folder is needed.
3. **ADRs and incidents are immutable.** Never edit original content. Corrections and
   follow-ups are appended as dated notes at the bottom of the file.
4. **Raw sources go in `reference/` verbatim.** When the engineer provides third-party API
   docs, spec excerpts, or other source material, offer to store the raw source (preferred)
   plus optionally a summary that cites it.
5. **Conflict with existing docs.** If new content contradicts an existing ADR, surface the
   conflict before writing. If confirmed outdated, append a dated correction note — do not
   rewrite the original.
6. **Default to `docs/draft/`.** When unsure whether a doc should exist, write to
   `docs/draft/` first and ask before graduating to `docs/`.
7. **Human intent before automation.** Ask when the target doc type is unclear.
