# The load-bearing test

Plan a decision now if **any one** of these holds:

1. **Hard to reverse.** Changing your mind later costs a migration, a rewrite, or a renegotiation.
2. **Constrains other decisions.** Other choices are made differently depending on this answer, so
   leaving it open leaves them open too.
3. **Forced from outside.** Regulation, a platform rule, a partner's API, a contract. You do not get
   to defer these; you only get to discover them late.

Everything else is **decide at step N**: into the ledger with a trigger, out of the interview.

## Why the filter cuts both ways

Over-planning wastes hours. Under-planning on a load-bearing question wastes months — and the two
failures do not feel different at the time. Both feel like sensible pragmatism.

The asymmetry is the point. Spending twenty minutes on a question that turns out not to matter costs
twenty minutes. Skipping *"is this one organisation per account, or many?"* costs a schema, an
auth model, and every query that touched either.

## Worked examples

| Question | Load-bearing? | Why |
|---|---|---|
| Single-tenant or multi-tenant | **Yes** — all three | Schema-deep, constrains auth and every query, near-impossible to retrofit |
| Do we handle payments, or does a marketplace | **Yes** — reversible only at high cost, and forced from outside | Drags in compliance, KYC, payout schedules, hosting jurisdiction |
| Do we store personal data, and whose | **Yes** — forced from outside | Decides deletion paths, retention, hosting region, and consent surfaces |
| Who logs in — end users, staff, both | **Yes** — constrains | Auth model and route structure follow from it |
| Which payment provider | **No** | Put a seam there; swap in an afternoon |
| Which CSS framework | **No** | Reversible per component |
| The password-reset email copy | **No** | Reversible in a text editor |
| Free tier limits | **No** | Configuration, not architecture — unless it changes what you must meter, which is |
| Which cloud host | **Usually no** | Yes if a compliance requirement or a managed service you build against pins you to it |
| Money as integer minor units | **Yes** — hard to reverse | Every stored amount and every calculation. Cheap now, a data migration later |
| Sequential vs opaque public IDs | **Yes** — hard to reverse | Exposed in URLs; changing them breaks links and search indexing |

## The move that resolves most arguments

When it is genuinely unclear whether something is load-bearing, ask: **"if we get this wrong, what
does it cost to change in three months?"**

- *An afternoon* → not load-bearing. Move on; you will decide it better later with real information.
- *A migration, a rewrite, or a conversation with a regulator* → load-bearing. Settle it now, and
  write an ADR.

## The pivot corollary

A decision that is genuinely uncertain **and** expensive to reverse is not a decision to agonise
over — it is a **seam**. Put the interface where the uncertainty is, pick the cheapest option behind
it, and buy the right to change your mind. That converts an expensive decision into a cheap one,
which is the only real escape from this test.
