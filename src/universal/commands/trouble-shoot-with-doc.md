# trouble-shoot-with-doc

Read the `docs-structure` skill to understand general conventions and check for the local 
`docs/project-docs-structure.md` file, which is the absolute authority on repository rules.

This command has two phases. Phase 1 is debugging. Phase 2 — **only when the engineer asks**
— is recording the confirmed conclusion as an immutable incident entry.

## Phase 1: Debug

1. **Open a scratch file.** Create `docs/draft/Problem-<topic>.md` at the start of the
   session. Keep observations (what you can see) and conclusions (what you infer) visibly
   separate. Anything the engineer describes from before the session must be marked
   `user reported:` or `per <name>:`.

2. **Ask what's wrong.** What symptoms? What was expected? When did it start? What changed
   recently? What environment — dev, test, or production?

3. **Check for prior art.** Search `docs/incident/` for similar symptoms. If found: *"There's
   a prior incident with similar symptoms — worth reading before we dig in?"*

4. **Help debug.** Ask focused diagnostic questions, suggest checks, read logs or configs the
   engineer shares. The goal here is to be a useful pair, not to write docs.

5. **If useful external source material appears** (a vendor error-code reference, an API doc),
   offer to store it verbatim in `docs/reference/`. Ask before writing.

6. **If a code fix is needed:** do not write code here. Export the findings to
   `docs/draft/PLAN-<topic>.md` and suggest: *"This needs a code change. Start a new
   `grill-with-doc` session with this plan to implement it."*

## Phase 2: Record (engineer decides)

After the issue is resolved or the session wraps, **ask explicitly:**

> "Is this worth recording for the next person who hits similar symptoms?"

If yes:

1. **Get the current timestamp.** Run the date-getting shell command yourself first (e.g., `Get-Date -Format "yyyyMMdd-HHmm"` in PowerShell or `date +%Y%m%d-%H%M` in bash). Only ask the user if command execution is unavailable or fails.

2. **Handle recurring issues.** Always write a new incident file `docs/incident/YYYYMMDD-hhmm-<slug>.md` for the occurrence (even if the root cause or issue is the same as a prior incident), so it is easily discoverable by its timestamp.

3. **Link to prior incidents (if same root cause).** If the issue has the same root cause as a prior incident, reference that original root-cause incident in the `Related` section of the new file (e.g. `[Original Incident](../incident/YYYYMMDD-hhmm-slug.md)`). This keeps individual occurrences traceable while pointing to the central explanation.

4. **Write the incident file.** Write `docs/incident/YYYYMMDD-hhmm-<slug>.md` using the Incident Format template embedded in `docs/project-docs-structure.md`. Tag the occurrence level: **while-dev**, **while-test**, or **while-production**.

5. **Keep it immutable.** Do not edit original entries after writing. Later corrections or follow-ups are always appended as a dated **Follow-up** section at the bottom of the file.

6. **Summarize.** List files written or modified. Do not commit.

## Notes

- If the session was inconclusive, still offer to record it. Be explicit in the "Conclusion"
  section that root cause is unknown and list what was ruled out. An honest "unknown" entry is
  more useful than a confident wrong one.
- Phase 2 is opt-in. If the engineer says no, move on.
