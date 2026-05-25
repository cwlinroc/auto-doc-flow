# CONTEXT.md Format

`docs/CONTEXT.md` is a glossary and nothing else. It stores the precise shared terminology
for this project. Do not use it as a spec, a scratch pad, or a home for implementation
decisions or notes.

## Structure

```md
# Context

{One or two sentences: what domain or system this context describes and why the terminology
matters here.}

## Language

**Order**:
A confirmed intent to purchase placed by a Customer.
_Avoid_: Purchase, transaction

**Invoice**:
A request for payment sent to a Customer after delivery.
_Avoid_: Bill, payment request

**Customer**:
A person or organization that places Orders.
_Avoid_: Client, buyer, account
```

## Rules

- **Be opinionated.** When multiple words exist for the same concept, pick one and list the
  others as aliases to avoid.
- **Flag conflicts explicitly.** If a term is used ambiguously across the codebase, call it
  out under a "Flagged ambiguities" subheading with a clear resolution.
- **Keep definitions tight.** One or two sentences maximum. Define what it *is*, not what it
  does.
- **Only include terms specific to this domain.** General programming concepts (timeouts,
  error types, retry logic) do not belong even if the project uses them heavily. Before adding
  a term, ask: is this concept unique to this domain, or general? Only the former belongs.
- **Show relationships.** Express cardinality or ownership where obvious (e.g., "An Order
  contains one or more LineItems.").
- **Group by subheadings** when natural clusters emerge. A single flat `## Language` section
  is fine for a cohesive domain.

## Example dialogue

Include a short example conversation between a developer and a domain expert demonstrating
how the terms interact naturally. This makes the glossary concrete and clarifies where the
boundaries are between related concepts.

```md
## Example

Dev: "So when a user clicks 'buy', we create an Order?"
Expert: "Yes — an Order is confirmed intent to purchase. The Cart becomes an Order at checkout."
Dev: "And the line items... are those OrderItems?"
Expert: "LineItems. Items is too vague — it could mean anything."
Dev: "What about the person buying? User or Customer?"
Expert: "Customer once they've placed an Order. Before that we don't have a word for them."
```

## Single vs multi-context repos

**Single context (most repos):** One `docs/CONTEXT.md` at the project root.

**Multiple contexts:** A `CONTEXT-MAP.md` at the root lists the contexts, where they live,
and how they relate:

```md
# Context Map

## Contexts

- [Ordering](./src/ordering/CONTEXT.md) — receives and tracks customer orders
- [Billing](./src/billing/CONTEXT.md) — generates invoices and processes payments
- [Fulfillment](./src/fulfillment/CONTEXT.md) — manages warehouse picking and shipping

## Relationships

- **Ordering → Fulfillment**: Ordering emits `OrderPlaced` events; Fulfillment consumes them
- **Fulfillment → Billing**: Fulfillment emits `ShipmentDispatched`; Billing generates invoices
- **Ordering ↔ Billing**: Shared types for `CustomerId` and `Money`
```

When `CONTEXT-MAP.md` exists, read it to find which context the current topic belongs to.
If unclear, ask.
