---
name: docs-structure
description: Use this skill whenever creating, updating, or reasoning about documentation in this repo. Covers the folder layout under docs/, naming conventions, templates per doc type, and the boundaries between ADRs, design docs, reference, and business context. Trigger this skill for any command that writes to docs/, draft/, README.md, or AGENTS.md.
---

# Docs Structure Skill

This skill describes how documentation is organized in this repo, and the rules every doc-producing command must follow.

## Folder layout

```
.
├── README.md           # entry point: docs index + brief onboarding
├── onboarding.md       # only exists if onboarding outgrows README
├── draft/              # gitignored. Personal scratch for brainstorming.
└── docs/
    ├── adrs/           # Architecture Decision Records
    ├── design/         # Design write-ups (alternatives, tradeoffs, open questions)
    ├── context/        # Business context: customers, SLAs, domain, seasonality
    ├── runbooks/       # Operational procedures
    ├── postmortems/    # Blameless incident reviews (lightweight add-on; serious tracking lives elsewhere)
    └── reference/      # Technical reference: APIs, schemas, third-party docs
```

## When in doubt: which folder?

- **ADR vs design**: Is the decision made? → ADR. Still exploring? → design. A design doc may spawn one or more ADRs.
- **Reference vs context**: Is this a technical fact about a system we built or use? → reference. Is this a business fact about who we serve, when, or under what constraints? → context.
- **Postmortem vs runbook**: Did something break? → postmortem (so the next person recognizes it). Is this a repeatable procedure that should work? → runbook.
- **Anywhere vs draft/**: If the engineer is still thinking, → `draft/`. Only graduate to `docs/` when the content is something the team should be able to find.

## Naming conventions

- **ADRs**: `NNNN-kebab-case-title.md`, zero-padded 4-digit sequential number. Example: `0017-use-postgres-as-event-store.md`. Never renumber.
- **Postmortems**: `YYYY-MM-DD-incident-name.md`. Example: `2026-05-22-payment-gateway-timeout.md`.
- **Design docs**: `kebab-case-title.md`. No numbering required.
- **Runbooks**: `kebab-case-action.md`. Example: `rotate-database-credentials.md`.
- **Reference**: `kebab-case-subject.md`. For third-party API docs, prefix with vendor: `stripe-webhooks.md`.
- **Context**: stable names; `customers.md`, `slas.md`, `seasonality.md`, `glossary.md`. Add new files only when an existing one would grow unwieldy.
- **Drafts**: `YYYY-MM-DD-kebab-case-topic.md`. Date prefix makes staleness obvious.

## Frontmatter

Only two doc types carry frontmatter:

**Runbooks** (required):
```yaml
---
owner: <name or team>
last-verified: YYYY-MM-DD
---
```

**ADRs** (required):
```yaml
---
status: proposed | accepted | superseded | deprecated
date: YYYY-MM-DD
supersedes: NNNN  # optional
superseded-by: NNNN  # optional
---
```

Everything else: no frontmatter. Keep it minimal.

## Templates

### ADR template

```markdown
---
status: accepted
date: YYYY-MM-DD
---

# NNNN. <Title>

## Context
<What is the situation that demands a decision? What constraints exist?>

## Decision
<What did we decide? Stated in active voice.>

## Status
<accepted | proposed | superseded by ADR-NNNN | deprecated>

## Consequences
<What follows from this decision? Both good and bad. What becomes easier? What becomes harder?>
```

### Design doc template

```markdown
# <Title>

## Goals
<What are we trying to achieve? Non-goals too if useful.>

## Background
<What context does a reader need?>

## Approach
<The proposed approach in enough detail to evaluate.>

## Alternatives considered
<What else did we look at? Why not them?>

## Open questions
<What's still unresolved? Who's deciding?>
```

### Postmortem template

```markdown
# YYYY-MM-DD: <Incident name>

> Lightweight write-up. Serious incident tracking lives in <other system>.
> Purpose: help the next person who sees similar symptoms.

## Symptoms
<What did the engineer see? What looked wrong?>

## Timeline
<Best-effort timeline. Mark uncertain entries with "approx" or "user reported:".>

## What happened
<Root cause as best understood.>

## Contributing factors
<What made this possible or worse?>

## What we learned
<Things future-you should know. Not action items — those live elsewhere.>

## Related
<Links to related runbooks, ADRs, or other postmortems.>
```

### Runbook template

```markdown
---
owner: <name or team>
last-verified: YYYY-MM-DD
---

# <Action name>

## When to use this
<What triggers this procedure? What symptoms? What requests?>

## Prerequisites
<Access, tools, context needed before starting.>

## Steps
1. ...
2. ...
3. ...

## Verification
<How to confirm it worked.>

## Rollback
<If applicable.>

## Notes
<Gotchas, edge cases, history.>
```

## Cross-cutting rules for all commands

1. **Never auto-commit.** All output is a working-tree change for the engineer to review.
2. **Default to drafts.** If unsure whether a doc should exist, write to `draft/` and ask.
3. **Never modify files outside `docs/`, `draft/`, `README.md`, or `AGENTS.md` without explicit user confirmation.**
4. **Stamp drafts.** Every file in `draft/` starts with a one-line header: `<!-- draft: <topic> | created: YYYY-MM-DD | source-command: <name> -->`
5. **Distinguish session knowledge from prior knowledge.** Things observed in the current session can be stated directly. Things the user reported about the past should be marked: `user reported:`, `per <name>:`, etc.
6. **Time matters.** When a doc requires a date, run `date +%Y-%m-%d` in a shell. If that fails, ask the user for the date — never guess.
7. **Conflict with existing docs**: if new content contradicts an existing ADR or reference doc, surface the conflict to the user before writing. If the user confirms the existing doc is wrong, **add a dated note to the existing doc**, do not edit the original content. ADRs are immutable; corrections are appended, not overwritten. If the contradiction is critical to the current decision, challenge the user with a question before proceeding.
8. **Cross-link.** When writing a postmortem, ask whether to link from related runbooks. When superseding an ADR, update both the new and old ADR's `supersedes` / `superseded-by` fields.
9. **Raw sources go in `reference/` verbatim.** When the user pastes third-party API docs, spec excerpts, or other source material, offer to store the raw source (preferred) plus optionally a summary file that cites it.

## Non-goals of the skill

- The skill does not generate docs without human substance. Commands ask questions; the engineer supplies the content.
- The skill does not auto-detect when a doc is needed (except for mechanical sync). The engineer decides what's worth documenting.
- The skill does not enforce policy beyond this file. Team conventions evolve here.
