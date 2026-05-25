# Docs workflow prototype

Drop the `.claude/` directory into the root of a repo. Add `draft/` to `.gitignore`.

## What's here

- `skills/docs-structure/SKILL.md` — describes folder layout, naming, templates, and the rules every command follows.
- `commands/grill-with-doc.md` — interrogate to produce an ADR or design doc.
- `commands/sync-docs.md` — mechanical sync of doc references against uncommitted code changes.
- `commands/analyze-requirement.md` — brainstorm a new requirement; produces an RFC-lite draft.
- `commands/trouble-shoot.md` — debugging assistant; optional postmortem at the end.

## Starting points

The skill recommends starting with `grill-with-doc` (already works for you) plus one new command — `sync-docs` is the safest bet since it's the most mechanical. Get those solid before adding the others.

## .gitignore

Add:
```
draft/
```

The `draft/` folder is personal scratch. If two engineers need to collaborate on something, the draft graduates to `docs/` (even as a rough file).

