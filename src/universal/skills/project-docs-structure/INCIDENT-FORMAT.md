# Incident Format

Incident records live in `docs/incident/`. Filename: `YYYYMMDD-hhmm-<slug>.md`.

Example: `20260525-0910-payment-timeout-prod.md`.

Create the `docs/incident/` directory lazily — only when the first incident is recorded.

This folder is not the source of truth for serious incident tracking (that lives elsewhere).
It exists so the next engineer who sees similar symptoms can find prior art quickly.

## Occurrence level

Tag every incident with one of:

- **while-dev** — observed during local development or in a dev environment.
- **while-test** — observed in a test, staging, or CI environment.
- **while-production** — observed in a production environment.

## Template

```md
# {Short title of the incident}

**Occurred:** YYYYMMDD-hhmm
**Level:** while-dev | while-test | while-production

{1–2 sentence summary of what happened.}

## Symptoms

{What the engineer observed. What looked wrong. What errors or alerts fired.}

## Timeline

{Best-effort sequence of events. Mark uncertain entries with "approx:" and anything the
engineer described from memory with "user reported:".}

## Observations

{Facts confirmed during the investigation — things you can point to in logs, code, or output.
Keep this separate from conclusions.}

## Conclusion

{Root cause as best understood. If unknown, say so explicitly and list what was ruled out.
An honest "root cause unknown — ruled out X and Y" is more useful than a confident wrong
answer.}

## Contributing factors

{What made this possible or worse? Only include when non-obvious.}

## What we learned

{Things a future engineer should know when they see similar symptoms. Not action items —
those live elsewhere.}

## Related

{Links to related ADRs, design docs, or other incidents. Optional.}
```

## Immutability

Incident records are immutable. Do not edit the original content after it is written.

Later corrections or follow-up findings are **appended** at the bottom as a dated section:

```md
## Follow-up (YYYYMMDD-hhmm)

{What was learned, corrected, or resolved after the original entry was written.}
```

Multiple follow-ups are allowed; append each in chronological order.
