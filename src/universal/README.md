# Doc-Flow Skills & Commands — universal source

This directory holds the **agent-agnostic body** of every command and skill. There is no
frontmatter here — metadata and packaging live in `src/claude-code/` (or the equivalent
agent-specific directory). See [`src/claude-code/build.sh`](../claude-code/build.sh) for how
the Claude Code plugin is assembled from this source.

## Skills

| Skill | Scope | Purpose |
|---|---|---|
| [`skills/docs-structure`](skills/docs-structure/SKILL.md) | User | Generic baseline: which doc type goes where. Routes to `docs/project-docs-structure.md` when present in the repo. |

Skills are referenced by **name** in all commands (`docs-structure`)
so they stay portable toward the future cross-agent goal.

## Commands

| Command | What it does |
|---|---|
| [`grill-with-doc`](commands/grill-with-doc.md) | Interrogate relentlessly until a design or decision is understood. Captures results in CONTEXT.md, an ADR, or a design doc. |
| [`review-with-doc`](commands/review-with-doc.md) | Review uncommitted changes for code quality and alignment with docs. Same bar for AI-, human-, or unknown-authored changes. |
| [`sync-with-doc`](commands/sync-with-doc.md) | Mechanical doc sync against uncommitted changes. Updates paths and symbols; flags prose for human review. |
| [`trouble-shoot-with-doc`](commands/trouble-shoot-with-doc.md) | Debugging assistant. Separates observations from conclusions. Optionally records a confirmed finding as an immutable incident. |
| [`brain-storm-with-doc`](commands/brain-storm-with-doc.md) | Explore ideas without code changes. Keeps options and decisions visibly separate. Exports a plan when a direction is confirmed. |

## Intended flow

```
brain-storm-with-doc  ─┐
                       ├──► docs/draft/YYYYMMDD-hhmm-PLAN-<topic>.md ──► grill-with-doc ──► implement
trouble-shoot-with-doc ─┘                                                         │
                                                                                  ▼
                                                               review-with-doc / sync-with-doc
```

## Docs layout this workflow targets

```
.
├── README.md
└── docs/
    ├── CONTEXT.md      # glossary only
    ├── adr/            # YYYYMMDD-hhmm-<slug>.md, immutable
    ├── design/         # alternatives, tradeoffs, open questions
    ├── domain/         # business context: customers, SLAs, seasonality
    ├── incident/       # YYYYMMDD-hhmm-<slug>.md, immutable
    ├── reference/      # raw source material + technical reference
    └── draft/          # gitignored scratch
```
