---
name: project-docs-structure
description: Use this skill when documentation commands need the project-specific docs layout for this repository. This draft narrows the generic docs-structure skill.
---

# Project Docs Structure

This is a project-scope draft skill for this repository. Use it together with `docs-structure`, then follow the rules here when they are more specific.

## Target layout

```text
.
├── README.md
└── docs/
	├── CONTEXT.md
	├── adr/
	├── design/
	├── domain/
	├── incident/
	├── reference/
	└── draft/
```

## What goes where

- `README.md` is the entry point and quick orientation for the project.
- `docs/CONTEXT.md` is a glossary and shared terminology file, not a general notes dump.
- `docs/adr/` stores architecture or process decisions that should remain discoverable later.
- `docs/design/` stores designs, tradeoffs, and open questions that are still being worked through.
- `docs/domain/` stores business context such as customers, SLAs, and domain-specific constraints.
- `docs/incident/` stores incident records and troubleshooting conclusions worth preserving.
- `docs/reference/` stores technical reference material and source documents worth keeping near the project.
- `docs/draft/` stores early thoughts, rough plans, and temporary documentation that is not ready to finalize.

## Naming guidance

- ADR files and incident files should use `YYYYMMDD-hhmm-xxxxxxxx.md`.
- Draft files can use a topic-first shape such as `Thoughts-xxxx.md`, `Problem-xxxx.md`, or `PLAN-xxxx.md` until a stronger convention is needed.
- Keep names stable and searchable. Prefer lowercase kebab-case when a command is not following one of the special draft prefixes above.

## Rules for commands

1. Commands in this project should read both `docs-structure` and `project-docs-structure` before writing docs.
2. When the two skills differ, follow this file for folder choice and naming.
3. Keep this draft simple for now. Templates, export behavior, and deeper policy can be added later.
