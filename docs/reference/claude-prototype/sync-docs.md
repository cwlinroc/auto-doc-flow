---
description: Mechanically sync docs with uncommitted code changes. Updates file paths, renamed symbols, broken links. Flags prose for human review without rewriting it.
---

# sync-docs

Read `.claude/skills/docs-structure/SKILL.md` first.

This command does **mechanical sync only**. It updates references that are factually wrong because of code changes. It does **not** rewrite prose, even if the prose is now misleading — that judgment is the engineer's.

## Scope

**Safe to update automatically:**
- File paths that have moved or been renamed
- Symbol references (function/class/module names) that have been renamed
- Links inside the repo that now 404
- Code blocks in docs that quote code which has since changed (only if the quote can be re-extracted unambiguously)

**Flag for human review, do NOT change:**
- Prose paragraphs that *describe* behavior which may have changed
- Examples that may now be misleading
- Anything where intent matters more than literal accuracy

## Steps

1. **Get the diff.** Run `git diff` and `git diff --cached` to see uncommitted changes. Also run `git status` to see untracked files.

2. **Build a rename/move map.** From the diff, identify:
   - Files renamed or moved (look for matching deletions and additions, or git's rename detection)
   - Symbols renamed (function/class names changed in declarations)
   - New public APIs added
   - Public APIs removed

3. **Scan docs for affected references.** For each item in the map, grep `docs/`, `README.md`, and `AGENTS.md`.

4. **Apply mechanical updates.** For each match that is a path or symbol reference (not prose):
   - Update the reference.
   - Record the change.

5. **Flag prose for review.** For each doc that contains prose mentioning changed code (but where the prose itself isn't a direct symbol/path reference), add it to a "review needed" list. Do not edit the prose.

6. **Check runbook freshness.** If any runbook references changed files, surface those runbooks with their `last-verified` date and prompt: *"This runbook references changed code. Consider re-verifying."*

7. **Summarize.** Output:
   - Files mechanically updated (with a one-line description each)
   - Files flagged for human review (with the reason)
   - Runbooks that may need re-verification

   Do not commit.

## Non-goals

- Detecting whether changes are decision-worthy (ADR territory). That's for `grill-with-doc`, invoked by the engineer.
- "Improving" doc prose. Mechanical sync only.
- Cross-repo or external link checking.
