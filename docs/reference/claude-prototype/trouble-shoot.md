---
description: Debugging assistant. Helps figure out what's going wrong. After resolution, optionally drafts a lightweight postmortem if the engineer wants the next person to recognize this.
---

# trouble-shoot

Read `.claude/skills/docs-structure/SKILL.md` first.

This command has two phases. The first is debugging help. The second — **only if the engineer wants it** — is a lightweight postmortem.

The `postmortems/` folder here is not the source of truth for incidents (serious tracking lives elsewhere). It exists so the next engineer who sees similar symptoms can find prior art.

## Phase 1: Debug

1. **Ask what's wrong.** What symptoms? What was expected? When did it start? What changed recently?

2. **Check for prior art.** Search `docs/postmortems/` for similar symptoms. If you find anything that looks related, surface it: *"Postmortem from 2026-03-12 had similar symptoms — payment timeouts after a deploy. Worth checking?"*

3. **Check for a runbook.** Search `docs/runbooks/` for procedures matching the situation. If one applies, surface it — and note its `last-verified` date so the engineer knows if it's stale.

4. **Help debug.** Ask focused diagnostic questions, suggest checks, look at logs/configs the user shares. The agent's job here is to be a useful pair, not to write docs.

## Phase 2: Postmortem (optional)

After the issue is resolved or the user wraps up the session, **ask explicitly**:

> "Is this worth writing down for the next person? If similar symptoms hit again, would a brief postmortem help?"

If yes:

1. **Get the date.** Run `date +%Y-%m-%d`. If that fails, ask the user — and warn that the timeline section needs careful review.

2. **Get the filename.** `docs/postmortems/YYYY-MM-DD-<kebab-incident-name>.md`.

3. **Distinguish session knowledge from pre-session knowledge.**
   - Things observed during this troubleshooting session can be stated directly.
   - Things the user described from before the session must be marked: `user reported:`, `per the on-call engineer:`, etc.
   - **Always ask the user to verify the timeline** — even if `date` succeeded, the *sequence of events* before the session started is reconstructed from the user's memory.

4. **Write the postmortem** using the template from the skill.

5. **Check the runbook that should have helped.** If the user followed a runbook during the incident, ask:
   - Was it accurate?
   - If not, what was wrong? Offer to file a fix or update the `last-verified` date.

6. **Cross-link.** Ask: *"This incident touched <service X>. Should I link this postmortem from `docs/runbooks/<related-runbook>.md`?"* If yes, add a "Related" line at the bottom of the runbook.

7. **Summarize what was written** — files created or modified. Do not commit.

## Notes

- If the user says "no" to writing a postmortem, that's fine. Don't push. The folder is opt-in.
- If the debugging session was inconclusive (issue not understood), and the user still wants a record: write it, but be explicit in "What happened" that root cause is **unknown**, and list what was ruled out. An honest "we don't know yet" entry is more useful than a confident wrong one.
