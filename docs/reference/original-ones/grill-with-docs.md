---
allowed-tools: Read, Write, Edit, Glob, Grep, Bash(ls), Bash(cat)
description: Grilling session that challenges your plan against the existing domain model, sharpens terminology, and updates documentation (CONTEXT.md, ADRs) inline as decisions crystallise.
---

# Grill With Docs

Conduct an intensive grilling session that challenges the proposed plan against the project's existing domain model and documentation. Resolve questions one-by-one, updating the glossary (`CONTEXT.md`) and Architectural Decision Records (ADRs) inline as decisions crystallize.

## Step 1: Initialize and locate documentation

Begin by explaining the goal of the session. Check the codebase for existing domain documentation using search and read tools:
- Look for `CONTEXT.md` or a `CONTEXT-MAP.md` at the repository root.
- If `CONTEXT-MAP.md` exists, find context-specific `CONTEXT.md` files (e.g. `src/<context>/CONTEXT.md`).
- Scan for existing ADRs in `docs/adr/` or `src/<context>/docs/adr/`.
- Understand the existing glossary terms and rules before asking questions.

## Step 2: Formulate and ask questions

Ask challenging questions about the plan, one at a time:
- Propose a recommended answer based on your analysis of the codebase and requirements.
- Walk down each branch of the design tree systematically.
- **Ask the questions one at a time**, waiting for the user's feedback before proceeding to the next question.
- If a question can be answered by exploring the codebase, explore the codebase instead of asking the user.

## Step 3: Apply domain discipline during the session

During the interview, actively enforce domain model discipline:
- **Explore codebase & cross-reference**: When the user states how something works, check if the code agrees. Call out any contradictions immediately.
- **Challenge against the glossary**: When the user uses a term that conflicts with existing definitions in `CONTEXT.md`, call it out: *"Your glossary defines 'cancellation' as X, but you seem to mean Y — which is it?"*
- **Sharpen fuzzy language**: Propose precise canonical terms for vague or overloaded words (e.g. *"You're saying 'account' — do you mean the Customer or the User? Those are different things."*).
- **Discuss concrete scenarios**: Invent specific edge-case scenarios to test boundaries between concepts and force precise relationships.

## Step 4: Update CONTEXT.md inline

As domain terms are resolved and clarified, update `CONTEXT.md` immediately (or create it if it doesn't exist).
- Keep `CONTEXT.md` strictly as a glossary, totally devoid of implementation details.
- Update files inline as decisions happen rather than batching them at the end.
- If no `CONTEXT.md` exists, create one when the first term is resolved.

**If you are unable to write project files** (e.g., plan mode, read-only session, or restricted tool access), embed resolved glossary terms in a structured section within your plan output instead:

```
## Glossary (Pending → CONTEXT.md)
- **Term**: Definition
```

## Step 5: Document decisions in ADRs sparingly

Create ADRs in `docs/adr/` (or context-specific ADR folders) *only* when all of the following are true:
1. **Hard to reverse** — the cost of changing the decision later is meaningful.
2. **Surprising without context** — future readers will wonder why it was done this way.
3. **Result of a real trade-off** — there were genuine alternatives and one was chosen for specific reasons.

Otherwise, skip the ADR. If created, update them inline as decisions crystallize.

**If you are unable to write project files**, embed ADR-worthy decisions in a structured section within your plan output instead:

```
## Decisions (Pending → docs/adr/)
### ADR-NNN: Title
- **Status**: Proposed
- **Context**: ...
- **Decision**: ...
- **Consequences**: ...
```

## Step 6: Extract deferred documentation on execution start

If glossary terms or ADR decisions were deferred into the plan output (Steps 4–5), extract them into proper files as your **first action** when execution begins:
1. Write or update `CONTEXT.md` with the pending glossary terms.
2. Write ADR files to `docs/adr/` (or the appropriate context-specific folder).
3. Remove or mark the pending sections in the plan as completed.
