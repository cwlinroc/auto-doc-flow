# review-with-doc

**Purpose:** Review code changes to ensure documentation alignment, proactively hunt for code issues (bugs, unhandled edge cases, unclear terminology), point out problems with clear definitions, and propose concrete fixes.

Read the `docs-structure` and `project-docs-structure` skills if available. Defer to
`project-docs-structure` when present.

Review is grounded in the actual diff — no guessing at intent. The same standard applies
whether the change was written by AI, a human, or an unknown author.

"Docs" in this command means everything under `docs/`, plus `README.md` and `AGENTS.md`.

## Steps

1. **Get the diff.** Run `git diff` and `git diff --cached` for unstaged and staged changes.
   Run `git status` to catch untracked files. Default to this unless the engineer says
   otherwise.

2. **Check for related docs.** Search `docs/adr/` and `docs/design/` for any decision or
   design that overlaps the changed area. **Crucially, also check for any newly proposed or
   uncommitted ADRs/designs in the workspace changes.** If found, surface them before reviewing code:
   *"There's an ADR on X — does this change align with it, extend it, or push against it?"*

3. **Code review.** Rigorously hunt for existing code issues: logic bugs, unhandled edge cases,
   performance bottlenecks, security flaws, and unclear terminology. Point out specific lines
   or patterns that could be problematic, and define anything that seems ambiguous or confusing.
   **Also, verify that the code changes align with and do not violate terminology defined in
   the `docs/CONTEXT.md` glossary.** Keep findings grounded in what is visible in the diff,
   not inferred from what you think the code should do.

4. **On finding an issue:** Clearly point it out to the user, explain why it's a problem, and
   provide a concrete fix. Ask before applying the fix. *"I noticed [issue] here which could cause [problem]. Here is a proposed fix. Want me to apply it?"*
   After an approved fix: ask again before touching docs. *"This fix changes the contract for Y.
   Should I update the docs?"*

5. **Check for missing ADRs.** After the code review, assess whether the change crossed a
   threshold that warrants an ADR that does not yet exist. If yes, flag it: *"This looks
   like it might be worth an ADR. Want to run `grill-with-doc` to capture it?"*

6. **Summarize.** List issues found, fixes applied (if any), and doc updates made or
   recommended. Do not commit.

## Notes

- If the review requires context that the diff alone cannot supply (an existing ADR, a
  design doc, a referenced spec), read those docs before forming a judgment.
- For mechanical doc updates (stale paths, renamed symbols), prefer handing off to
  `sync-with-doc` rather than doing it inline here.
- Do not update docs speculatively. Only update when the engineer has confirmed the change
  materially alters something documented.
