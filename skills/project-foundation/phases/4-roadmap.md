# Phase 4 — Build the roadmap

A roadmap is not a list of features in the order someone thought of them. It is an **order of
learning**: each step buys the answer to a question, and the steps are sequenced so the answers that
could invalidate the most work arrive first.

## Check the model before you start

Planning is the expensive thing to get wrong. Everything downstream — what gets built, in what
order, on what stack — inherits the quality of this phase, and a weak plan reads exactly like a
strong one right up until a week has been spent on it.

Before the first step is drafted, say so and pause:

> Next I plan the roadmap. This is the part where a weaker model costs the most, so it is worth
> checking your status line before I start — are the model and effort level shown there what you
> want for planning? Say go, or change them and say go.

One line, one pause. The same checkpoint is installed into the project as `/plan-step` in phase 6,
so every re-plan after this run gets it too.

**In refactor mode** the steps are moves rather than features, and the ordering rule sharpens:
seams before moves, strangle rather than rewrite, every step ships, and deletion of the old path is
its own step with its own **Done when**. See
[`../reference/existing-projects.md`](../reference/existing-projects.md).

## Order by riskiest assumption

Every plan rests on assumptions. Rank them by *what it costs to be wrong* × *how likely wrong is*,
and put the worst one first.

The instinct to build the easy, certain parts first feels productive and is expensive: it spends
weeks of work that a later answer can void. If the whole thing depends on whether the matching
algorithm produces results anyone wants, that gets tested in step 1 with fake data and no accounts —
not in step 6 behind a finished sign-up flow.

Test each step against: **if this step's assumption turns out wrong, how much of the earlier work
survives?** A step whose failure invalidates three earlier steps is in the wrong place.

## Step 1 is a walking skeleton

The first step goes end to end through the **thinnest possible version of the main pipeline** —
every stage present, each one doing the least it can. Real subsystems come later, one at a time,
each replacing a fake at a seam.

This is what "general before specific" buys: the shape is provable in days, integration risk is paid
down at the start rather than discovered at the end, and every later step has somewhere to plug in.

## The step format

Every step, no exceptions. Two blocks: **what it is for**, and **how it is built**.

```md
### Step N — {{name}}

**Question it answers:** {{the one thing we do not know yet}}
**Build:** {{the smallest thing that answers it}}
**Not building:** {{what a reasonable person would expect here, and why it waits}}
**Done when:** {{observable — a demo someone can drive, a number, a working path}}
**Unlocks:** {{which steps this makes possible}}
**Deferred here:** {{ledger entries this step creates}}

**Direction**

- **Shape:** {{where the code goes in this project's layout, and which seam owns it}}
- **Stack it introduces:** {{the specific libraries, services, or infra this step adds — or `nothing new`}}
- **Pipeline stages touched:** {{named stages from `docs/02-architecture/pipelines.md`}}
- **Docs it will update:** {{the routing-table rows this step will fire}}
```

**Not building** is the line that does the work. Without it, scope arrives silently: someone builds
the admin panel during the matching-algorithm step because it seemed necessary, and nobody notices
until it needs maintaining. Naming the omission makes adding it a decision instead of a drift.

**Done when** must be observable from outside. *"Auth is implemented"* is not a criterion —
*"a new user can sign up, log out, and log back in"* is.

### Why the Direction block exists

A plan that says only *what* to build is a plan that gets **re-planned at execution time**, by
whoever happens to be running, on whatever model happens to be loaded. That is the failure this
block prevents: the four lines carry the structural decisions forward in writing, so the agent
executing the step is following a decision rather than making one.

They are also the honest test of whether phase 3 produced anything. If you cannot name the shape,
the stack delta, and the stages a step touches, the architecture was discussed and not decided — go
back rather than writing a step that only sounds specific.

Keep them short. **Shape** is a sentence or two naming real directories and one seam, not a design
document. `nothing new` is a perfectly good answer for **Stack it introduces**, and a step that
introduces three things at once is usually two steps.

## Plan two steps deep

Write step 1 and step 2 at full detail, Direction block included. Everything after that is a **named
step with its question and nothing else** — because the answers from steps 1 and 2 will rewrite them.

Detailing step 6 today is writing fiction that later reads as commitment. The roadmap is re-planned
one step at a time, from what was actually learned, by `/plan-step`.

## Write it to disk in this phase

Create `docs/01-project/roadmap.md` now, from
[the template](../templates/project/docs/01-project/roadmap.md), with steps 1 and 2 in full and the
rest named. Do not leave it for phase 5.

A plan that exists only in the conversation is gone at the next `/clear`, cannot be reviewed by
anyone who was not in the room, and gets silently re-invented by the next agent. The session file is
a log of what was decided; the roadmap is the artefact that gets worked from. Both, now.

## Detect the future needs now — and write them down, not build them

This is where a project type earns its keep. Walk
[`../reference/project-types.md`](../reference/project-types.md) for this project's type and pull
out every need that is real for it but not yet due. Each one becomes a **ledger entry with a
trigger**, never a step.

The point is the pairing. Building an SEO strategy for a product with no pages is waste. *Reaching
launch without one because nobody wrote it down* is a bigger waste — the structural parts of SEO
(canonical origin, URL shape, render strategy) are painful to retrofit once a site is indexed, and
that is exactly the kind of thing that gets discovered a month late.

Same shape for everything else deferred: the security controls skipped for the demo, the rate
limits, the audit trail, the backup and restore path, the accessibility pass, the observability. The
trigger is the whole mechanism — see [`../reference/deferred-ledger.md`](../reference/deferred-ledger.md).

## How a step is worked

Record this in the roadmap page, because it is the rhythm every later agent inherits:

1. **Prototype** the uncertain part as **throwaway** code that answers the step's question and
   nothing more. Method: [`../reference/prototype.md`](../reference/prototype.md).
2. **Get a verdict** from the operator on the prototype, not on a description of it.
3. **Build the real thing** — only the validated part, behind its seam.
4. **Update the docs the change routed to**, in the same change.
5. **Sweep the ledger** for triggers this step has fired.
6. **Re-plan** the next step from what was learned — a separate invocation, `/plan-step`, so that
   planning does not silently inherit the model an execution session was running on.

## Guard against the expensive kinds of waste

- **Building behind a seam that has not been validated.** The seam is there so the thing behind it
  can be thrown away. Use that.
- **Generalising for a second case that does not exist.** Two real cases justify an abstraction. One
  real and one imagined justifies nothing.
- **Polishing a prototype.** If it is answering a question, it is throwaway. Tests, error handling,
  and abstraction on throwaway code are pure loss.
- **Infrastructure for load you do not have.** Queues, caches, and read replicas are step-N items
  with triggers, and the trigger is a measurement, not a feeling.
- **Re-litigating settled decisions.** They are in the ADRs with their reasoning. Reopen on new
  evidence, not on a new opinion.

## Done when

`docs/01-project/roadmap.md` exists on disk; steps 1 and 2 carry every field including the Direction
block; step 1 is unambiguous enough that an agent could start it without asking a question; steps
beyond 2 are named with their questions only; every future need surfaced by the project type is a
ledger entry with a trigger; and the operator has agreed that step 1 is the right first thing to
learn.

Append to `docs/00-meta/foundation-session.md`.
