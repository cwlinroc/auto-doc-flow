---
name: docs-structure
description: Use this skill when a command needs lightweight guidance on how to organize documentation. Generic baseline — defers to project-docs-structure when a repo defines its own layout.
---

# Docs Structure

This is a user-scope skill. It gives doc-producing commands a minimal, sensible default for
how to think about documentation. It is **not** the final authority for any specific
repository.

When a project provides a `project-docs-structure` skill, read that too and treat it as the
local source of truth. When the two differ, follow `project-docs-structure`.

## Recommended baseline

A project's documentation typically lives across a small set of buckets:

- `README.md` — entry point and quick orientation.
- `docs/adr/` — Architecture Decision Records: decisions that are hard to reverse or hard to
  understand later without context.
- `docs/design/` — designs still under exploration: alternatives, tradeoffs, open questions.
- `docs/reference/` — technical facts, copied sources, and external material worth keeping
  near the project.
- `docs/CONTEXT.md` or equivalent — shared terminology and business context. Glossary only.
- `docs/draft/` — personal scratch for work not yet ready to become team-facing documentation.

Projects rename, merge, or split these folders. Commands should not assume this baseline is
exact.

## When to use which doc

- **Confirmed, hard-to-reverse decision** → ADR. Still exploring? → design doc. A design doc
  may spawn one or more ADRs.
- **Technical fact about a system we built or use** → reference doc.
- **Shared terminology or business context** → CONTEXT.md or equivalent.
- **Still thinking** → draft. Graduate to `docs/` only when the content is something the team
  should be able to find.

## Rules for commands

1. Prefer existing project guidance over this skill when the repository defines it.
2. Always check whether `project-docs-structure` exists before choosing folders or naming
   rules.
3. If `project-docs-structure` is missing, continue with this baseline and recommend the
   engineer add it.
4. Never auto-commit. All output is a working-tree change for the engineer to review.
5. The engineer decides what is worth documenting. Commands ask; the engineer supplies
   substance. Do not invent content.
