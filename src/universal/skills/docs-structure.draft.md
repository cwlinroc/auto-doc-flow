---
name: docs-structure
description: Use this skill when a command needs lightweight guidance on how to organize documentation. Keep it generic, then defer to project-docs-structure when a repo defines its own layout.
---

# Docs Structure

This is a user-scope draft skill. It gives commands a simple default way to think about documentation, but it is not the final authority for any specific repository.

If a project provides a `project-docs-structure` skill, read that too and treat it as the local source of truth.

## Recommended baseline

Start with a small set of documentation buckets:

- `README.md` for the entry point and quick onboarding.
- `docs/adr/` for important decisions worth preserving.
- `docs/design/` for designs that are still being explored.
- `docs/reference/` for technical facts, copied sources, and external material.
- `docs/context/` or an equivalent project context file for glossary and business context.
- `docs/draft/` or another scratch area for work that is not ready to become team-facing documentation.

Projects may rename or reshape these folders. Commands should not assume the baseline layout is exact.

## When to use which doc

- Use an ADR when the team has made a decision that is hard to reverse or hard to understand later without context.
- Use a design doc when the shape of the solution is still being discussed.
- Use reference docs for raw facts, APIs, schemas, vendor notes, or source material worth keeping.
- Use context docs for stable background such as terminology, domain constraints, or business rules.
- Use drafts for incomplete thinking, planning, or notes that still need confirmation.

## Rules for commands

1. Prefer existing project guidance over this draft when the repository defines it.
2. Check whether `project-docs-structure` exists before choosing folders or naming rules.
3. If `project-docs-structure` is missing, continue with this baseline and recommend adding the project-specific skill.
4. Keep human intent ahead of automation. Ask when the target doc type is unclear.
5. Keep this skill broad. Detailed templates and naming rules belong in the project-specific skill.
