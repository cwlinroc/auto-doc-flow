# ADR Format

ADRs live in `docs/adr/`. Filename: `YYYYMMDD-hhmm-<slug>.md`.

Example: `20260525-1430-use-postgres-for-write-model.md`.

Create the `docs/adr/` directory lazily — only when the first ADR is needed.

## Template

```md
# {Short title of the decision}

{1–3 sentences: what's the context, what was decided, and why.}
```

That's it. An ADR can be a single paragraph. The value is in recording *that* a decision was
made and *why* — not in filling out every section.

## Optional sections

Only include these when they add genuine value. Most ADRs won't need them.

- **Status** — `proposed | accepted | deprecated | superseded by YYYYMMDD-hhmm-<slug>` —
  useful when decisions are revisited.
- **Considered options** — only when the rejected alternatives are worth preserving.
- **Consequences** — only when non-obvious downstream effects need to be called out.

## When to offer an ADR

All three must be true:

1. **Hard to reverse** — the cost of changing your mind later is meaningful.
2. **Surprising without context** — a future reader will look at the code and wonder "why on
   earth did they do it this way?"
3. **The result of a real trade-off** — there were genuine alternatives and you picked one for
   specific reasons.

If any of the three is missing, skip the ADR.

### What qualifies

- **Architectural shape.** "We're using a monorepo." "The write model is event-sourced."
- **Integration patterns between components.** "These two services communicate via domain
  events, not HTTP."
- **Technology choices that carry lock-in.** Database, message bus, auth provider, deployment
  target. Not every library — just the ones that would take a quarter to swap out.
- **Boundary and scope decisions.** "Customer data is owned by the Customer context; other
  contexts reference it by ID only."
- **Deliberate deviations from the obvious path.** "We're using manual SQL instead of an ORM
  because X." Anything where a reasonable reader would assume the opposite.
- **Constraints not visible in the code.** "We can't use AWS because of compliance
  requirements." "Response times must be under 200ms because of a partner API contract."
- **Rejected alternatives when the rejection is non-obvious.** If you considered GraphQL and
  picked REST for subtle reasons, record it — otherwise someone will suggest GraphQL again in
  six months.

## Immutability

ADRs are immutable. Do not edit an ADR's original content after it is written. If a decision
is revisited:

- Append a dated note to the existing ADR acknowledging the change.
- Write a new ADR for the new decision.
- Update the existing ADR's **Status** to `superseded by YYYYMMDD-hhmm-<new-slug>`.
