# Phase 2 — Grill the product

Interview the operator until you and they picture the same thing. Not a questionnaire: a **design
tree**, worked in rounds, where each answer reshapes what is worth asking next.

This phase settles *what the project is*. Phase 3 settles how it is built. Keep them apart —
architecture questions asked before the product is pinned down get answered twice.

**In retrofit or refactor mode**, most of this frontier is already answered by the code and by
whoever has been running the thing. The job becomes separating what was **decided** from what merely
**happened** — see [`../reference/existing-projects.md`](../reference/existing-projects.md). Do not
re-ask what a repository already states; invariant 5 costs the most patience here.

## The frontier

The **frontier** is every decision whose prerequisites are already settled: the questions you can
ask *now* without guessing at an answer you have not heard yet. Ask the whole frontier in one round.
Then wait.

A question whose answer depends on another question still open in this round belongs to a **later
round**. Asking it now produces a guess dressed as a decision.

Each answer settles a node and pushes the frontier outward, unblocking what depended on it.
Recompute and ask the next round. Three or four rounds is typical; the tree, not a target count,
decides.

## Question format

```
❓ **Q1** — **{{short title}}**: {{the question, in the operator's register. Multiple choice where
the options are genuinely enumerable, open where they are not}}

➡️ {{your recommendation, and the one-clause reason}}
```

Number them per round. Every question carries a recommendation — see the register table in phase 1.

For rounds that are cleanly multiple-choice, `AskUserQuestion` (max 4 per call) renders better than
prose. Fall back to numbered prose when the frontier is wider than four or the answers are open.

## Every round ends with its questions

Whatever else a round's message contains — findings from a lookup, a reflected-back summary, the
reasoning behind a recommendation — **the questions go last, together, as one numbered block.**

A round that scatters questions through paragraphs of context gets partially answered, and the
missed ones look settled when they are merely unread. Put the context above, the asks at the bottom,
and say which section each one comes from so the operator can scroll up when they want the detail.

If a question already appeared inline earlier in the message, repeat it in the block anyway. The
duplication costs three lines and buys an answer.

## Ask only what is load-bearing

The tree could branch forever. It should not. Before adding a question to the frontier, apply the
test in [`../reference/load-bearing.md`](../reference/load-bearing.md): a decision is load-bearing
if it is **hard to reverse**, **constrains other decisions**, or is **forced from outside**.

Everything else goes to the ledger as *decide at step N* with a trigger, and you move on. Deciding
the password-reset email's copy in week one is waste; deciding whether accounts exist at all is not.

The failure this guards against runs both ways, and the second way is worse. An over-detailed plan
wastes a few hours. A plan that skipped one load-bearing question — single- or multi-tenant, who
owns the customer relationship, whether money moves through your account or theirs — gets rewritten
from the foundations six weeks later.

## What the product frontier covers

Roughly the order the tree tends to unfold. Skip what does not apply; branch where it does.

- **Audience and job.** Who exactly, and what they are doing instead today.
- **The core loop.** The one sequence a user repeats. Everything else is support.
- **Scope edges.** What this is explicitly *not*, and what is version two. The no-s constrain more
  than the yes-s.
- **Who else is inside.** Admins, internal staff, reviewers, support — every non-end-user role. This
  drives `docs/03-internal/`, and it is the part most often discovered late.
- **Money.** Whether it charges, how, and whether funds move through your account. Payments and
  payouts reach into schema, compliance, and hosting; retrofitting is expensive.
- **Data sensitivity.** Personal data, payment data, health data, minors, or none. This one is
  forced from outside and cannot be deferred.
- **Brand, voice, and audience-facing tone.** Enough to write copy consistently.
- **Success.** What has to be true in three months for this to have been worth it.

## While you grill, build the language

Every project develops words that mean something specific inside it. When operator and agent hold
different definitions of *order*, *account*, or *listing*, the mismatch surfaces as a bug months
later.

So, as you go:

- **Sharpen fuzzy terms on the spot.** "You said *account* — do you mean the paying organisation or
  the individual who logs in? Those behave differently."
- **Challenge conflicts immediately.** When a term is used against an earlier definition, say so and
  make them pick.
- **Stress-test with a concrete scenario.** "A customer orders three items, cancels one, and the
  other two ship separately — is that one order or three?" Edge cases expose boundaries that
  abstract discussion hides.
- **Write the term down the moment it is resolved**, into `CONTEXT.md` — not batched at the end.
  Use [the template](../templates/project/CONTEXT.md): one canonical word per concept, the rejected
  synonyms listed under `_Avoid_`, definitions of one or two sentences. Keep implementation out of
  it; `CONTEXT.md` is a glossary, not a spec.

## Find facts yourself

When a frontier question needs a fact from the environment — what the existing schema does, what a
dependency supports, what a competitor's API allows — go and find it. Dispatch a subagent for the
wide searches. Never hand the operator homework you could do yourself.

Do not block on it: an unfinished lookup is an unsettled prerequisite, so only the questions
downstream of it wait. Ask the rest of the round now.

## Done when

The frontier is empty: every load-bearing product decision is either **settled** or **in the ledger
with a trigger**, `CONTEXT.md` holds every term that came up, and the operator has confirmed — in
their own words, not by agreeing with yours — that you are describing the same product.

Append the settled decisions to `docs/00-meta/foundation-session.md` before moving on.
