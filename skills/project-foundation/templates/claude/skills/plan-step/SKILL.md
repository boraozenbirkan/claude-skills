---
name: plan-step
description: Plan the next roadmap step in writing — its question, its shape, its stack, and the docs it will touch — on a model strong enough to be worth trusting.
disable-model-invocation: true
model: opus
effort: high
---

# Plan step

Planning and building are different jobs with different failure modes. A weak plan costs a week of
building the wrong thing; weak building costs an afternoon. So they run separately, and this one
runs on the strong model.

`model: opus` and `effort: high` in the frontmatter above apply **for the rest of this turn only**;
the session returns to its own model on the next prompt. Change those two lines if this project
should plan on something else.

## 1 — Confirm the model before planning

The override can be refused. An organisation allowlist that excludes the requested model leaves the
session on whatever it was already using, silently.

So **say what you are about to do and let the operator look at their status line**:

> I am about to plan {{step N}}. Planning is the expensive thing to get wrong here, so this skill
> asks for Opus at high effort — check your status line shows that. If it does not, set it and
> re-run me.

Then wait. This is one line and one pause, and it is the whole point of this skill existing
separately from `/next-step`.

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
