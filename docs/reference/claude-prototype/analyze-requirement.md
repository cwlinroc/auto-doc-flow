---
description: Brainstorm a new requirement with the engineer. Produces an RFC-lite draft (no code changes). Captures third-party source material into reference/ on request.
---

# analyze-requirement

Read `.claude/skills/docs-structure/SKILL.md` first.

This command **does not make code changes**. It helps the engineer think through a new requirement and produces a draft for them to refine.

The output lives in `draft/` by default. Graduating to `docs/` is the engineer's call after the dust settles.

## Steps

1. **Ask for the source.** Where does this requirement come from? Customer email, spec, Slack thread, meeting note, internal idea?
   - If the user has external source material (third-party API docs, vendor spec, contract excerpt), ask whether to store it in `docs/reference/` verbatim. **Default to raw storage**, optionally with a separate summary file that cites it.
   - File third-party reference docs with a vendor prefix: `stripe-webhooks.md`.

2. **Interrogate to clarify the problem.** Ask questions like:
   - What problem does this solve, in the user's own words?
   - Who is affected? Which customers, services, teams?
   - What's the constraint — deadline, regulatory, business?
   - What's already been tried or considered?
   - What would "done" look like?

   One topic at a time. The agent's job here is to surface what the engineer hasn't articulated yet, not to propose solutions.

3. **Check for related context.** Search `docs/context/`, `docs/adrs/`, and `docs/design/` for related material. If a related ADR exists, surface it: *"ADR-0019 covers a related decision. Does this requirement build on it or push against it?"*

4. **Check whether business context changes.** If the requirement implies new information about customers, SLAs, seasonality, or domain — *"This sounds like Customer X's quarterly batch run. Should I note that in `context/customers.md`?"* — offer to update context, but don't write to it without confirmation.

5. **Surface possibilities, don't prescribe.** When the engineer has articulated the problem, summarize what *might* be possible — a few sketched approaches with tradeoffs. Mark these clearly as the agent's framing, not decisions:
   > **Possible directions** (for the engineer to evaluate, not recommendations):
   > - A: ...
   > - B: ...

6. **Get the date.** Run `date +%Y-%m-%d`. If that fails, ask.

7. **Write the draft** to `draft/YYYY-MM-DD-<kebab-topic>.md` with this structure, and the draft header stamp at the top:

   ```markdown
   <!-- draft: <topic> | created: YYYY-MM-DD | source-command: analyze-requirement -->

   # <Requirement title>

   ## Source
   <Where this came from. Link to reference/ file if applicable.>

   ## Problem
   <In the engineer's words, captured.>

   ## Affected
   <Customers, services, teams.>

   ## Constraints
   <Deadlines, regulatory, business.>

   ## Possible directions
   <Sketched, not prescribed.>

   ## Open questions
   <What needs to be answered before this can progress.>

   ## Related
   <Links to relevant ADRs, design docs, context.>
   ```

8. **Suggest next steps.** Typically: *"When you're ready to commit to an approach, run `grill-with-doc` to produce an ADR. When you're ready to flesh out the design, graduate this draft to `docs/design/`."*

## Non-goals

- Writing code or proposing implementation details.
- Auto-creating ADRs (that's `grill-with-doc`).
- Writing to `docs/` directly — drafts only, unless the user is just adding a reference source.
