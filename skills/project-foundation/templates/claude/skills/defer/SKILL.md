---
name: defer
description: Record something deliberately skipped in the deferred ledger, with the trigger that makes it due. Use the moment a shortcut is taken — a skipped security control, missing validation, absent pagination, a hardcoded value, an unhandled edge case — or when asked to note something for later.
argument-hint: [what is being skipped]
---

# Defer

Turn a shortcut into a ledger entry. Takes under a minute, and it is the difference between a
deliberate omission and a forgotten one.

## Write the entry

Append to the **Open** section of
[`docs/00-meta/deferred-ledger.md`](../../../docs/00-meta/deferred-ledger.md), newest first, taking
the next sequential id:

    ### DL-0NN — {title}

    **Trigger:** {the observable condition that makes this due}
    **Why deferred:** {what makes it safe right now}
    **What is needed:** {enough that whoever picks it up does not re-derive the problem}
    **Raised:** {step N} · **Area:** {security | scale | seo | accessibility | data | ops | legal | product}

## Get the trigger right

The trigger is the whole mechanism. Everything else is context.

**Test:** reading only the project's current state, could an agent answer yes or no?

| Good | Why |
|---|---|
| before any real user data is stored | Observable state change |
| before the first external user has an account | Observable state change |
| when the orders table passes ~10k rows | Measurable |
| when p95 on this route passes 800ms | Measurable |
| when a second payment provider is added | Architectural event |

"Q3" fires whether or not it is relevant, so it gets ignored — and once one entry is ignored, the
whole ledger is. "Before it matters" cannot be evaluated at all. Sharpen a fuzzy trigger before
writing the entry; an entry with a bad trigger is worse than none, because it looks handled.

## Write the reasoning, not just the omission

**Why deferred** is what a future reader checks. *"Closed alpha, every caller is known and reachable
by name"* can be tested against reality later. *"Not needed yet"* cannot, so nobody can tell whether
it is still true.

## Then

- Mention it in the current step's **Deferred here** line in
  [`docs/01-project/roadmap.md`](../../../docs/01-project/roadmap.md).
- If the area has a page with a deferred table — `security.md` does — add the row there too.
- Tell the operator in one line: what was skipped, and what will bring it back.

## When something is too big to defer

An entry that would take a week, or that other work will be built on top of, is not a deferral — it
is a roadmap step. Say so, and let the operator decide where it goes.
