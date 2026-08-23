---
name: plan-step
description: Plan the next roadmap step in writing — its question, its shape, its stack, and the docs it will touch — after recommending a model worth trusting for it.
disable-model-invocation: true
---

# Plan step

Planning and building are different jobs with different failure modes. A weak plan costs a week of
building the wrong thing; weak building costs an afternoon. So they run separately, and this one
opens by recommending the model it deserves.

## 1 — Recommend the model, then wait

**This skill does not change the model. It asks.**

A skill cannot read the session's model or effort level reliably. The status line can, and the
operator is looking at it. So the first thing this skill does, before reading anything else, is put
the recommendation in front of them and stop:

> Before I plan {{step N}}: planning is where model quality shows up most, so the recommendation is
> **Opus at high effort or better**. Your status line shows what you are on. Say go if that is what
> you want, or change it and say go.

Then wait for the go. Not a rhetorical pause — an actual stop, before any file is read, so that
switching costs them nothing they have to redo.

If they say go on something weaker, that is a legitimate call. Proceed without arguing, and record
what was in use in the roadmap entry you write, so a plan made cheaply is identifiable later as one
made cheaply.

An automatic `model:` override in the frontmatter was the obvious alternative and is deliberately
not here. It would move the operator's model without them seeing it move, it can be refused by an
organisation allowlist without saying so, and it takes a decision about their own spend out of their
hands.

## 2 — Read the state

- [`docs/01-project/roadmap.md`](../../../docs/01-project/roadmap.md) — what shipped, what was
  learned, what is named but not planned
- [`docs/02-architecture/technical-map.md`](../../../docs/02-architecture/technical-map.md) — the
  stack and where code lives
- [`docs/02-architecture/pipelines.md`](../../../docs/02-architecture/pipelines.md) — the stages a
  step can touch
- [`docs/02-architecture/modularity.md`](../../../docs/02-architecture/modularity.md) — the seams
- [`docs/00-meta/deferred-ledger.md`](../../../docs/00-meta/deferred-ledger.md) — anything the last
  step fired
- [`docs/README.md`](../../../docs/README.md) — the routing table, for the last field of the step

If the last step's **Answered** line is empty, the previous step is not finished. Say so and stop —
planning on top of an unanswered question is how a roadmap becomes fiction.

## 3 — Pick the next question

- What is the **riskiest assumption** remaining — highest cost of being wrong, times likelihood?
- Does what the last step answered **reorder** anything?
- What is the **smallest** thing that answers the next question?
- What will that step **deliberately not build**?

Plan **one step**. Everything after it stays a name and a question, because this step's answer will
rewrite it.

## 4 — Write it down, in full

A plan that exists only in the conversation is gone at the next `/clear` and was never reviewable.
Write it into the roadmap in the project's step format — all ten fields, including the four that
give direction:

- **Shape** — where the code goes in this project's actual layout, and which seam owns it
- **Stack it introduces** — the specific libraries, services, or infrastructure this step adds, or
  `nothing new`
- **Pipeline stages touched** — by name, from `pipelines.md`
- **Docs it will update** — the routing-table rows this step is going to fire

These four are what let the *next* agent — possibly a cheaper one, possibly next month — execute
without re-deciding anything. Vague here means re-planned there, by whoever happens to be running.

Anything that turns out to be hard to reverse gets an ADR. Anything skipped gets `/defer`.

## 5 — Report, then collect the asks

Show the step as written, and say what you rejected and why — the alternative ordering is the part
worth arguing with.

Then, **last and together**, a numbered **Your turn** block: confirm the step, fill anything you
could not infer, rule on any fired trigger. Repeat each one even if it appeared inline above. Mark
what blocks starting the step and what does not.
