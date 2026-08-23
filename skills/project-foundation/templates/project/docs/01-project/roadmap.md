> **Audience:** everyone · **Status:** current · **Owner:** agents

# Roadmap

An order of learning, not a list of features. Each step buys an answer, and the steps are ordered so
the answers that could invalidate the most work arrive first.

**Current milestone:** {{N — name}}
**Current step:** {{N — name}}
**Riskiest open assumption:** {{the thing that would hurt most to be wrong about}}

Three tiers of depth. **The arc** covers every milestone and is written once, up front. **The
current milestone's steps** are written in full. **Everything below** waits for its milestone
boundary, because the milestones before it will change what it should say.

## On this page

- [The arc](#the-arc)
- [How a step is worked](#how-a-step-is-worked)
- [Steps in the current milestone](#steps-in-the-current-milestone)
- [Later](#later)
- [Shipped](#shipped)

## The arc

Every milestone, start to finish. Revised at every milestone boundary — reordering this is the plan
working, not failing.

### Milestone 1 — {{name}}

**Proves:** {{what is true once this lands that was not true before}}
**Brings in:** {{technologies, services, infrastructure arriving here — or `nothing new`}}
**Pipeline:** {{stages built or changed, named from ../02-architecture/pipelines.md}}
**Not in this milestone:** {{what a reasonable person expects here, and which milestone has it}}
**Done when:** {{observable from outside}}

### Milestone 2 — {{name}}

**Proves:** {{...}}
**Brings in:** {{...}}
**Pipeline:** {{...}}
**Not in this milestone:** {{...}}
**Done when:** {{...}}

<!-- Four to seven milestones is the usual shape. Fewer and they are phases of one long push; more
     and the later ones are guesses dressed as plan. Keep "Brings in" honest: an arc that names
     outcomes and no technology constrains nothing, which is the whole reason to write one. -->

## How a step is worked

1. **Prototype** the uncertain part as throwaway code that answers the step's question and nothing
   more — `/prototype`.
2. **Get a verdict** from {{DECIDER}} on the prototype itself, not on a description of it.
3. **Build the real thing** — only the validated part, behind its seam.
4. **Update the docs the change routed to**, in the same change — `/doc-check`.
5. **Sweep the ledger** for triggers this step fired.
6. **Re-plan** the next step from what was actually learned — `/plan-step`, as its own invocation,
   deliberately not in the tail of the execution session.

## Steps in the current milestone

Full detail here, and only for the milestone now in progress.

### Step 1 — {{name}}

**Question it answers:** {{the one thing we do not know yet}}
**Build:** {{the smallest thing that answers it}}
**Not building:** {{what a reasonable person would expect here, and why it waits}}
**Done when:** {{observable from outside — a demo someone can drive, a number, a working path}}
**Unlocks:** {{which steps this makes possible}}
**Deferred here:** {{ledger ids created}}

**Direction**

- **Shape:** {{where the code goes in this layout, and which seam owns it}}
- **Stack it introduces:** {{the libraries, services, or infra this step adds — or `nothing new`}}
- **Pipeline stages touched:** {{named stages from `../02-architecture/pipelines.md`}}
- **Docs it will update:** {{the routing-table rows this step will fire}}

### Step 2 — {{name}}

**Question it answers:** {{...}}
**Build:** {{...}}
**Not building:** {{...}}
**Done when:** {{...}}
**Unlocks:** {{...}}
**Deferred here:** {{...}}

**Direction**

- **Shape:** {{...}}
- **Stack it introduces:** {{...}}
- **Pipeline stages touched:** {{...}}
- **Docs it will update:** {{...}}

## Later

Nothing here but the arc above. Steps inside a later milestone are written at that milestone's
boundary, by `/plan-step`, from what the milestones before it actually taught us — writing them now
means guessing at information the next milestone hands over for free.

## Shipped

### Step 0 — {{name}} · {{date}}

**Answered:** {{what we learned, including the answers that were surprising}}
**Changed the plan how:** {{what this made us reorder, drop, or add}}
**Planned on:** {{model and effort in use when this step was planned}}

<!--
Rules for this page:

- Step 1 is a walking skeleton: end to end through the thinnest possible version of the main
  pipeline, every stage present and doing the least it can. Real subsystems replace fakes at their
  seams, one step at a time.
- "Not building" is the line that does the work. Without it, scope arrives silently.
- "Done when" must be observable from outside. "Auth is implemented" is not a criterion; "a new user
  can sign up, log out, and log back in" is.
- The arc is written once, up front, and revised at every milestone boundary.
- Two steps deep at full detail inside the current milestone, no more. Nothing below that.
- A step whose failure would invalidate three earlier steps is in the wrong place. Move it earlier.
- The Direction block is what stops the step being re-planned at execution time by whoever happens
  to be running. If it cannot be filled in, the architecture has not been decided yet - go and
  decide it rather than writing a step that only sounds specific.
- Planning happens in `/plan-step`, which recommends a model and waits before it starts. Execution
  happens in `/next-step`. Keeping them apart is the point; a plan is cheap to make and expensive to
  get wrong.
-->
