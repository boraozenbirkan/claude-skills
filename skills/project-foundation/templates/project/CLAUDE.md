# {{PROJECT_NAME}}

{{ONE_SENTENCE_DESCRIPTION}}

**Stack:** {{STACK}}
**Docs:** [`docs/README.md`](docs/README.md) — start there. It carries two indexes: one to find an
answer, one to route a change to the pages it invalidates.
**Language:** [`CONTEXT.md`](CONTEXT.md) — the project's vocabulary. Use these words exactly; when
you need a term it does not define, define it there.
**Who you are talking to:** [`docs/00-meta/personas.md`](docs/00-meta/personas.md) — read it before
explaining anything.

## Documentation is part of the change

A change to behaviour, structure, or a documented rule **is not done until the docs covering it are
updated in the same change.**

Before reporting work complete:

1. Grep the routing table in [`docs/README.md`](docs/README.md) for the paths you touched.
2. Update every page that matched.
3. If you introduced a concept, screen, table, or integration that no page covers, add it to the
   nearest page or create one — then add its rows to **both** indexes.

Run `/doc-check` to do this against the current diff.

Docs have two audiences and two registers. `02-architecture/` and `04-development/` are for
engineers. `03-internal/` is for whoever runs the product day to day and may never read code:
screens and outcomes, no jargon, and nothing whose meaning depends on reading the source.

**A build log is not reference documentation.** {{BUILD_LOG_PATH}} records what happened and when;
the reference pages record how the system works right now. Keeping the log current while the
reference pages drift is the most common way this system fails, and it looks like diligence the
whole time it is happening. Update both.

## Public docs are human-owned

`docs/05-public/` changes when a human asks for that change in the current conversation. Working
near it, **write the proposed diff into chat and wait for a yes.**

Editing those files raises a permission prompt, by design. The prompt is the human's decision point,
so treat one appearing as a signal you skipped this step, not as an obstacle.

Every other doc is the opposite: yours to keep current, without being asked.

## The deferred ledger

[`docs/00-meta/deferred-ledger.md`](docs/00-meta/deferred-ledger.md) holds everything deliberately
skipped, each with a **trigger** — the observable condition that makes it due.

Read it and act on any fired trigger when you:

- **start a roadmap step** — did the last step fire anything?
- **finish a step** — what did this step defer? Record it with `/defer` before the context is gone.
- **cross a stage line** — demo → beta → public → paying customers.
- **touch an area with open entries** — the cheapest moment to clear one.

A fired trigger means *decide*: do it, re-defer it with a new trigger and a reason, or close it with
a reason. Passing one in silence defeats the mechanism, and looks exactly like everything being fine.

## Working here

- **Follow the roadmap.** [`docs/01-project/roadmap.md`](docs/01-project/roadmap.md) says which step
  is current, and what it is deliberately not building. Work outside the current step is a decision
  for {{DECIDER}}, not a matter of momentum.
- **Prototype before building anything uncertain.** Throwaway code that answers one question, then a
  verdict from a human, then the real thing. `/prototype`.
- **Verify before claiming done.** {{VERIFY_COMMANDS}} must pass. If something fails, say so with
  the output rather than describing the change as complete.
- **Read the conventions before writing code** — [`docs/04-development/conventions.md`](docs/04-development/conventions.md).
  They encode decisions with reasoning behind them; deviating silently creates inconsistency that is
  expensive to unwind.
- **Match the surrounding code.** Naming, file layout, comment density, and idiom should be
  indistinguishable from what is already there.
- **Comments explain why, not what.** A comment restating the code is noise; one explaining a
  non-obvious constraint is often the most valuable line in the file.
- **Put a seam where a pivot is expected**, and only there — see
  [`docs/02-architecture/modularity.md`](docs/02-architecture/modularity.md). Two real cases justify
  an abstraction; one real and one imagined justifies nothing.
- **Commit when asked.** {{COMMIT_POLICY}}

## Guardrails

{{PROJECT_SPECIFIC_GUARDRAILS}}

<!--
Replace the block above with the rules that would cause real damage if broken. Write each as the
behaviour you want, so the reader's attention lands on the action to take. Examples of the shape —
delete these and write this project's actual ones:

- Migrations are forward-only and immutable once applied. Correct a mistake with a new migration.
- Merging to the main branch reaches production immediately; there is no staging environment.
- Privileged work goes through SECURITY DEFINER functions, so the rules live in the database rather
  than in application code that has to remember to be careful. Keep the service-role key out of
  application code.
- Money is integer minor units everywhere.
-->
