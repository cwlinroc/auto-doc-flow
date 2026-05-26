# sync-with-doc

Read the `docs-structure` and `project-docs-structure` skills if available. Defer to
`project-docs-structure` when present.

This command makes **no code changes**. It corrects doc references that are factually wrong
because of code changes, and flags prose that may now be misleading. It does not rewrite
prose — even if that prose is now inaccurate, that judgment belongs to the engineer.

## Scope

**Safe to update automatically:**
- File paths that have moved or been renamed
- Symbol names (functions, classes, modules) that have been renamed in declarations
- In-repo links that now 404
- Quoted code blocks where the source can be re-extracted unambiguously

**Flag for human review — do NOT change:**
- Prose paragraphs that describe behavior which may have changed
- Examples that may now be misleading
- Anything where intent matters more than literal accuracy

## Steps

1. **Get the diff.** Run `git diff`, `git diff --cached`, and `git status`. Default to
   current uncommitted changes unless told otherwise.

2. **Build a change map.** From the diff, identify:
   - Files renamed or moved
   - Symbols renamed in declarations
   - New public interfaces added
   - Public interfaces removed

3. **Scan docs for affected references.** For each item in the change map, search `docs/`,
   `README.md`, and `AGENTS.md`.

4. **Apply mechanical updates.** For each match that is a path or symbol reference (not
   prose): update it, record the change.

5. **Flag prose.** For docs that mention changed code in prose (not as a direct path or
   symbol reference): add the file and the reason to a "flag for human review" list. Do not
   edit the prose.

6. **Check scope before widening.** If the change looks like it might need a new ADR or
   context update, ask before acting: *"This change might warrant a new glossary entry.
   Handle it here, or run `grill-with-doc`?"*

7. **Summarize.** Output:
   - Files mechanically updated (one-line reason each)
   - Files flagged for human review (with the reason)

   Do not commit.

## Non-goals

- Detecting whether a change is ADR-worthy — that is `grill-with-doc`'s job.
- Rewriting prose, even if it is now misleading.
- External link checking.
