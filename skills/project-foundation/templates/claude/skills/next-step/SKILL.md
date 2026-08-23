---
name: next-step
description: Work the current roadmap step end to end, verify it, and record what it answered. Planning the next step is a separate skill.
disable-model-invocation: true
---

# Next step

One step of the roadmap, worked to completion and recorded honestly. Planning the next one is
`/plan-step`, deliberately not this.

## 1 — Orient

Read, in this order:

- [`docs/01-project/roadmap.md`](../../../docs/01-project/roadmap.md) — the current step, and what
  it is deliberately **not** building
- [`docs/00-meta/deferred-ledger.md`](../../../docs/00-meta/deferred-ledger.md) — did the last step
  fire any trigger? Decide each fire before starting new work
- [`docs/00-meta/personas.md`](../../../docs/00-meta/personas.md) — who you are reporting to, and at
  what register

State the step's **question** back before writing code. A step whose question you cannot state in
one sentence is not ready to start — go and settle it with the operator instead.

## 2 — Prototype what is uncertain

If the step's question is genuinely open, answer it with throwaway code before building anything
real — `/prototype`. Get a verdict from a human **on the prototype itself**, not on a description of
it.

Skip this only when the step's question has an obvious answer. Then say so, so the skip is a
decision on the record rather than an omission.

## 3 — Build

Only the validated part, only what this step's **Build** line names.

Anything the step's **Not building** line excludes stays unbuilt. Coming across a reason it should
be built is a conversation with the operator, not a decision to make mid-flow — that quiet expansion
is the main way step-gating fails.

Put new work behind the seam that owns it — [`docs/02-architecture/modularity.md`](../../../docs/02-architecture/modularity.md).

## 4 — Verify

{{VERIFY_COMMANDS}} must pass. Then check the step's **Done when** line, which is observable from
outside: demonstrate it rather than asserting it.

## 5 — Update the docs

Run `/doc-check`. The step is not finished while a page it invalidated is still wrong.

## 6 — Record what was learned

In the roadmap, move the step to **Shipped** with:

- **Answered** — what the step's question turned out to be, including the surprises
- **Changed the plan how** — what this reorders, drops, or adds

The surprises are the valuable part. A step that answered exactly as predicted has told you the
question was not worth asking, and that is worth knowing when planning the next one.

Log anything skipped along the way with `/defer`.

## 7 — Stop at the planning boundary

Do **not** plan step N+1 here. Planning runs under `/plan-step`, on the strong model, as its own
invocation.

The reason is the model. Execution is often run on something cheap and fast, which is the right
call for building a thing already decided and the wrong call for deciding what to build. A plan made
in the tail of an execution session inherits whatever model that session happened to be using, and
nobody notices, because a weak plan reads exactly like a strong one until a week has been spent on
it.

So finish here, leave step N+1 as its name and its question, and put `/plan-step` in the **Your
turn** block below.

## 8 — Report, then collect the asks

The question, the answer, what shipped, what was deferred, what changed in the plan, and what the
next step will ask. In the operator's register.

Then, **last and together**, a numbered **Your turn** block with everything you need back — the
verdict you are waiting on, the placeholder only they can fill, the fired trigger they must rule on,
and **run `/plan-step` when ready** as its own item, naming the model it wants. Repeat each one even
if it appeared inline above; a step report is long and the middle of it gets skimmed.

Mark what blocks. "Step N+1 cannot start until you confirm the scope" and "answer whenever" deserve
different urgency, and only you know which is which.
