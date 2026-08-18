# Phase 3 — Design the architecture

Same frontier method as phase 2, now on how the thing is built. Same load-bearing filter: settle
what is expensive to change, leave the rest to the step that needs it.

The register still applies. A non-technical operator gets architecture questions framed as cost,
speed, and lock-in — *"this choice means changing payment providers later takes a week instead of a
day"* — not as a technology comparison.

## The architecture frontier

- **Runtime and deployment target.** Where it runs decides more than which framework writes it.
- **Data store, and its shape.** Relational, document, or none yet. Which entities are real.
- **Identity.** Who logs in, how, and what roles exist. Retrofitting auth touches every route.
- **Tenancy.** One customer per install, or many in one database. The single most expensive decision
  to reverse in most products, and the one most often left implicit.
- **The pipeline.** End to end, what happens between a user acting and the result landing.
- **External services.** Everything you will depend on and cannot control.
- **Security posture for *this stage*.** What is enforced now, and what is deferred with a trigger.
- **Seams.** Where the pivots are expected. See below — this is the part that decides how it feels
  to change this codebase in six months.

## Draw the pipeline, then the sub-pipelines

Every project has one **main pipeline**: the path from a user's action to a persisted, visible
result. Write it as an ordered list of stages, naming what enters and leaves each. Then, for each
stage complex enough to have its own internal steps, write its **sub-pipeline** the same way.

This is the single most useful page in the architecture docs, because it is the page an agent reads
to answer *"where does my change go?"* — and it is the one nobody writes without being asked.
Sketch it in this phase; phase 5 writes it to `docs/02-architecture/pipelines.md`.

Keep it at the level of stages and data, not functions. Function names go stale in a week; stages
survive a rewrite.

## Place the seams where the pivots are

**Modular** does not mean many small files. It means the change you expect to make is confined to
one place. So the design question is not "how do we split this up?" but **"what are we most likely
to change, and does that change stay in one place?"**

Work it explicitly:

1. **List the likely pivots.** From phase 2 — the parts the operator was least certain about, the
   competitive guesses, the things one customer conversation could overturn. Payment provider,
   pricing model, the ranking rule, the notification channel, the whole UI.
2. **For each, name what would have to change.** If the answer names more than two or three places,
   there is a **seam** missing there.
3. **Put a seam only where a pivot is genuinely likely.** One adapter is a hypothetical seam; two
   adapters is a real one. A seam invented for a change that never comes is indirection you pay for
   on every read, forever.

Then design each module **deep**: a lot of behaviour behind a small interface. The vocabulary and
the tests for this are in [`../reference/modularity.md`](../reference/modularity.md) — use those
words exactly, in the docs and in conversation, so the whole project argues about the same things.

## Keep it prototypable

The plan has to permit building one slice at a time, widest first. Check the shape you have designed
against this:

- Can the **general system** be built and demonstrated before any subsystem is real? If a walking
  skeleton needs four subsystems finished first, the boundaries are wrong.
- Can each subsystem be **faked** at its seam — a hardcoded adapter, an in-memory store — so the
  slice above it runs? If not, that seam is in the wrong place or does not exist.
- Would a pivot at step 4 **invalidate** work done at step 2? If so, either move the seam or move
  the step.

An architecture that only works once every part exists cannot be prototyped, and it will be
discovered late.

## Scale decisions worth making now

Only these. Everything else about scale is a step-N problem with a trigger, and guessing at it now
is the waste this whole skill exists to prevent.

- **Identifier types.** Guessable sequential IDs on user-facing resources are an access-control bug
  waiting for someone to increment a URL. Decide now; changing later means a data migration.
- **Money representation.** Integer minor units. Float money bugs are quiet and compound.
- **Timestamps and time zones.** Store UTC, decide where it renders local. Retrofitting is grim.
- **What grows without bound**, and therefore needs pagination in its first version rather than its
  third — because adding it later changes the API shape, the client, and every caller at once.

## Record the decisions worth explaining

Write an ADR when **all three** are true: the decision is hard to reverse, a future reader would
otherwise wonder why on earth you did it that way, and there were genuine alternatives you rejected
for specific reasons. Miss any one and skip it — an easily reversed decision will just be reversed,
and an obvious one puzzles nobody.

Format and numbering: [`../templates/project/docs/adr/0000-template.md`](../templates/project/docs/adr/0000-template.md).

The rejected alternatives matter as much as the choice. Unrecorded, someone re-proposes GraphQL
every six months and nobody remembers why the answer was no.

## Done when

The architecture frontier is empty; the main pipeline and its sub-pipelines are written down; every
seam traces to a named likely pivot; every deferred technical concern is in the ledger with a
trigger; and the ADRs that pass all three tests exist.

Append to `docs/00-meta/foundation-session.md`.
