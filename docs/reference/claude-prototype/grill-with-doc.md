---
description: Interrogate the engineer to produce an ADR or design doc. Human supplies substance; agent supplies structure.
---

# grill-with-doc

Read `.claude/skills/docs-structure/SKILL.md` first.

This is the canonical pattern other doc-producing commands follow: **the human supplies the substance, the agent supplies the structure.** Do not invent technical content. Ask, capture, organize.

## Steps

1. **Determine output type.** Ask the user up front:
   - "Is this a decision to record (ADR), or a design to explore (design doc)?"
   - If unsure, default to design doc — it can spawn an ADR later.

2. **Check for related existing docs.** Search `docs/adrs/` and `docs/design/` for related topics. If you find anything that looks related, surface it before asking further questions: *"There's already ADR-0012 on X — is this related, superseding it, or unrelated?"*

3. **Interrogate.** Ask focused questions matching the template (see skill file). One topic at a time. Examples:
   - For ADR context: "What's forcing the decision? Why now?"
   - For ADR consequences: "What becomes harder once we commit to this?"
   - For design alternatives: "What else did you consider? Why not them?"

   If the user gives a thin answer, ask one follow-up. Don't pile on — the goal is capture, not interrogation theater.

4. **Handle conflicts.** If anything the user says contradicts an existing ADR or reference doc:
   - Surface it: *"This seems to conflict with ADR-0023, which says X. Has that changed?"*
   - If critical to the current decision, ask a clarifying question before proceeding.
   - If the user confirms the older doc is wrong: **append a dated note to the older doc**, do not edit its content. ADRs are immutable.

5. **Get the date.** Run `date +%Y-%m-%d`. If that fails, ask the user.

6. **Pick the number/filename** per naming convention in the skill:
   - ADR: next zero-padded number in `docs/adrs/` (list existing files, find max, +1).
   - Design: kebab-case from the title.

7. **Write the file** using the template from the skill. If this ADR supersedes another, update both ADRs' frontmatter.

8. **Summarize what changed** — list the files written/modified. Do not commit.

## Notes

- If the user wants to brainstorm rather than record, write to `draft/` instead with the draft header stamp.
- If the topic clearly spans both decision and design, write the design doc first and offer to spawn an ADR from it.
