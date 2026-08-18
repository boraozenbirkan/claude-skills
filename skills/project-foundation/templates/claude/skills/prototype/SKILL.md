---
name: prototype
description: Build throwaway code that answers one design question. Use when a state model, business rule, or data shape needs sanity-checking before it is built, or when a screen's layout needs to be seen in several forms before one is chosen.
---

# Prototype

Throwaway code that answers **one question**. The question decides the shape.

Copy the question in verbatim from the current step's **Question it answers** line in
[`docs/01-project/roadmap.md`](../../../docs/01-project/roadmap.md), and put it at the top of the
prototype. Drifting onto a different question is easy once code starts flowing, and it wastes the
whole exercise.

## Pick the branch

- **"Does this logic hold up?"** — state models, business rules, data shape. One self-contained HTML
  file anyone can double-click.
- **"What should this look like?"** — layout, hierarchy, affordances. Several structurally different
  variants on one route, switchable by a URL parameter.

Wrong branch wastes the prototype. Ambiguous and nobody to ask: follow the surrounding code — a
backend module means logic, a page means visual — and state the assumption at the top.

## Rules for both

1. **Throwaway from the first line, and labelled so.** Next to the code it prototypes for, named so
   nobody mistakes it for production.
2. **One action to run it** — a double-click, or one command in the project's existing task runner.
3. **In-memory state.** Persistence is what the prototype is checking, not what it should lean on.
4. **No tests, no abstraction, no error handling** past what makes it run.
5. **Show the whole state after every action.** You cannot notice a state that is not on screen.
6. **Domain language throughout** — the words in [`CONTEXT.md`](../../../CONTEXT.md), so a
   non-developer can drive it.

## Logic branch

Keep the logic in **one pure module** with no DOM access — a reducer, a state machine, or pure
functions over a plain data type, whichever the question needs. The page calls in; nothing flows
back. That purity is what lets the validated logic lift straight into the real codebase while the
page around it is discarded.

The page, top to bottom: **the question** in plain words; **current state** as labelled fields
re-rendered after every action; **free-play buttons**, one per action, always enabled, because
letting an illegal action be attempted is often where the model breaks; and **guided walkthroughs** —
a few named scenarios, each resetting to a known start, each a short description plus an ordered set
of buttons. Choose the awkward cases: the edge case, the thing that should be refused, the sequence
nobody can reason about on paper.

Plain HTML, CSS, and JS in one file — it has to survive being emailed.

## Visual branch

**Prototype inside a real page** wherever one plausibly exists. Variants in an empty route all look
fine; variants against the real header, real density, and real data show their problems at once.
Only create a throwaway route when there is genuinely no host page, and then follow this project's
routing convention with `prototype` in the path.

- **Three variants.** Past five they stop being alternatives.
- **Structurally different** — different layout, different information hierarchy, different primary
  action. Three versions of one card grid in different colours is wallpaper.
- **Switch via a URL parameter** plus a small floating bar that cycles and names the current
  variant. Update the URL through the project's router so a variant is shareable and survives
  reload. Gate the bar out of production builds.
- **Read-only.** Point anything that would mutate at a stub.

The most useful feedback is *"the header from B with the sidebar from C"* — that recombination is
the real design, and it only becomes sayable once all three exist side by side.

## Get a verdict

Hand over the file or the URL and let a human drive it. The moments worth having are *"wait, that
should not be possible"* — bugs in the idea, found for the price of an afternoon.

A description of a prototype is not a prototype. Do not accept a verdict on one.

## Capture, then throw away

1. **Write the answer into the roadmap step** — question, verdict, reasoning. If the decision is
   hard to reverse, surprising, and a real trade-off, write an ADR too.
2. **Rewrite the validated part properly** in the real code. Promoting prototype code imports every
   shortcut it was allowed to take.
3. **Keep the prototype off the main branch.** Commit it to a throwaway branch and link that branch
   from the step. It is the primary source showing why the decision was made; left in main it rots
   and misleads.
4. **Log what it skipped** with `/defer`, for anything that would matter in the real version.
