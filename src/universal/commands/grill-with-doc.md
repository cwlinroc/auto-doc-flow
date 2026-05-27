# grill-with-doc

Read the `docs-structure` skill to understand general conventions and check for the local 
`docs/project-docs-structure.md` file, which is the absolute authority on repository rules.

The user has requested that you interview them about every aspect of their task until you've reach a shared understanding. Walk down each branch of the design tree, resolving dependencies between decisions one-by-one. For each question, provide your recommended answer.

Conduct an intensive grilling session that challenges the proposed plan against the project's existing domain model and documentation.

## Guidelines

- If a question can be answered by exploring the codebase, explore the codebase instead.

## Steps

1. **Read existing context.** Search `docs/adr/`, `docs/design/`, and `docs/CONTEXT.md` for
   anything related to the current topic. Surface it before asking: *"There's already an ADR
   on X — is this related, superseding it, or separate?"*

2. **Interrogate.** Ask focused questions one at a time. For each question, offer your
   recommended answer so the engineer can confirm or redirect. Cover:
   - What is the problem or decision that prompted this session?
   - What constraints exist (time, compliance, technical, team)?
   - What alternatives were considered and why were they set aside?
   - What are the non-obvious consequences of the chosen direction?

   If a question can be answered by reading the codebase, explore it instead of asking.

3. **Challenge terminology.** When a new term appears, check `docs/CONTEXT.md`. If it
   conflicts with the glossary, call it out: *"Your glossary defines 'X' differently — which
   is right?"* If it is genuinely new and team-facing, propose a definition and ask whether
   to add it.

4. **Choose the right doc target.** Ask once if unclear:
   - Confirmed, hard-to-reverse decision → ADR in `docs/adr/`.
   - Still exploring alternatives → design doc in `docs/design/`.
   - New term worth preserving → entry in `docs/CONTEXT.md`.
   - Not sure yet → start in `docs/draft/PLAN-<topic>.md`.

5. **Handle conflicts with existing ADRs.** If anything the engineer says contradicts an
   existing ADR, surface it: *"This seems to conflict with the ADR on X. Has that decision
   changed?"* If confirmed outdated: **append a dated correction note to the existing ADR**,
   never rewrite its original content.

6. **Get the current timestamp.** Run the date-getting shell command yourself first (e.g., `Get-Date -Format "yyyyMMdd-HHmm"` in PowerShell or `date +%Y%m%d-%H%M` in bash). Only ask the user if command execution is unavailable or fails.

7. **Write the doc.** Use the templates embedded in `docs/project-docs-structure.md`. ADR filename:
   `YYYYMMDD-hhmm-<slug>.md` in `docs/adr/`. Design doc: `kebab-case.md` in `docs/design/`.
   CONTEXT.md: extend the `## Language` section. Create folders lazily — only when the first
   file in that folder is needed.

8. **If in plan mode**, include the planned doc writes as explicit steps in the plan so the
   engineer can review them before approval.

9. **Summarize.** List the files written or modified. Do not commit.

10. **Suggest a next step.** After implementation: *"Run `review-with-doc` to review the
    change against the docs, or `sync-with-doc` for a mechanical check."*

## Notes

- Work with or without an explicit plan. If the engineer says "just thinking out loud," write
  to `docs/draft/` and ask before graduating to `docs/`.
- If the topic spans both a confirmed decision and ongoing exploration, write the design doc
  first and offer to spawn an ADR from it later.
- If the engineer cites durable external source material (API docs, spec, contract), offer to
  store it verbatim in `docs/reference/`. Default to raw storage; a separate summary that
  cites it is optional.
- Do not invent technical content. Ask, capture, organize.
