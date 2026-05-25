---
description: Explore ideas without making code changes. Keeps options and decisions visibly separate. Exports a confirmed direction to a PLAN draft for grill-with-doc.
---

# brain-storm-with-doc

Read the `docs-structure` and `project-docs-structure` skills if available. Defer to
`project-docs-structure` when present.

This command **makes no code changes**. It explores ideas, keeps options and tradeoffs
visible, and produces a draft the engineer can hand to `grill-with-doc` when ready to
execute.

## Steps

1. **Ask clarifying questions before proposing structure.** What is the engineer trying to
   figure out? What constraints matter? What has already been ruled out? One question at a
   time.

2. **Open a scratch file.** Create `docs/draft/Thoughts-<topic>.md` and explore ideas there.
   Keep the file organized but not formalized — this is space for messy thinking.

3. **Separate clearly in the draft:**
   - **Options** — things that could be done, each with tradeoffs. Not recommendations.
   - **Open questions** — things that need answering before deciding.
   - **Decisions** — only once the engineer explicitly confirms something.

4. **Store durable sources.** If the engineer cites external material (a spec, an API doc, an
   article), offer to store it verbatim in `docs/reference/`. Ask before writing. Default to
   raw storage; a summary that cites it is optional.

5. **If an existing doc is relevant**, surface it before going further: *"There's already a
   design doc on X — does what we're exploring build on it or go against it?"*

6. **When a direction is clear and confirmed**, export to `docs/draft/PLAN-<topic>.md` with a
   structured summary: what was decided, constraints, options considered, and open questions
   resolved.

7. **Suggest next steps.** Once a plan is exported: *"When you're ready to implement, start a
   new `grill-with-doc` session with this plan. It will capture the decisions as ADRs or
   design docs as the work unfolds."*

## Notes

- Output stays in `docs/draft/` unless the engineer explicitly asks to graduate it. Drafts
  are personal scratch; `docs/` is team-facing.
- Keep this a thinking space, not a decision-making engine. The engineer decides; the command
  helps surface what hasn't been articulated yet.
