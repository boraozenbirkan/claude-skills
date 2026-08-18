# {{Short title of the decision}}

{{One to three sentences: the context, what was decided, and why. That is a complete ADR. The value
is in recording that a decision was made and the reasoning behind it, not in filling out sections.}}

<!--
## Numbering

`docs/adr/NNNN-slug.md`. Scan the directory for the highest number and add one. Never renumber.

## Write one only when all three are true

1. **Hard to reverse** — changing your mind later has a real cost.
2. **Surprising without context** — a future reader will look at the code and wonder why on earth it
   was done this way.
3. **A real trade-off** — there were genuine alternatives, and one was chosen for specific reasons.

Miss any one and skip it. An easily reversed decision will simply be reversed. An unsurprising one
puzzles nobody. Where there was no alternative, there is nothing to record beyond "we did the
obvious thing".

## What qualifies

- **Architectural shape** — "the write model is event-sourced, the read model is projected".
- **How parts communicate** — "these two talk over events, never synchronous calls".
- **Technology with lock-in** — database, message bus, auth provider, deployment target. Not every
  library; the ones that would take a quarter to swap.
- **Boundary and ownership** — "this context owns customer data; others reference it by id".
- **Deliberate deviations from the obvious path** — "manual SQL instead of an ORM, because X". These
  stop the next engineer from helpfully fixing something that was intentional.
- **Constraints invisible in the code** — a compliance requirement, a partner's response-time
  contract.
- **Rejected alternatives, where the rejection is non-obvious.** Without this, the same option is
  proposed again every six months and nobody remembers the answer.

## Optional sections

Add only when they earn their place; most ADRs need none.

- **Status** frontmatter — `proposed | accepted | deprecated | superseded by ADR-NNNN`. Useful once
  decisions start being revisited.
- **Considered options** — when the rejected alternatives are worth remembering.
- **Consequences** — when there are non-obvious downstream effects.

## Superseding

Never edit a decided ADR to say something else. Write a new one and mark the old one superseded. The
record of having changed your mind is often more useful than either decision alone.
-->
