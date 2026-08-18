> **Audience:** everyone · **Status:** current · **Owner:** agents

# How these docs work

Three rules. They are the whole system.

## 1 — The index is the entry point

[`../README.md`](../README.md) carries a **Find index** (where is X?) and a **Routing table** (I
changed X, what does that invalidate?). Start every question there rather than browsing the tree.

Adding a page means adding its rows to both. A page nobody can reach from the index does not exist.

## 2 — Docs change in the same change as the code

Not afterwards, not in a cleanup pass. The moment a change is made is the only moment anyone knows
what it affected; a week later that knowledge is gone and the page silently becomes wrong.

Grep the routing table for the paths you touched, or run `/doc-check`.

## 3 — Public docs belong to humans

`05-public/` changes when a person asks for that change. Everything else is maintained by whoever —
human or agent — makes the change that affects it.

## Page headers

Every page opens with one line:

    > **Audience:** engineers · **Status:** current · **Owner:** agents

- **Audience** — `engineers`, `operators`, or `everyone`. Sets the register for the next editor.
- **Status** — `current` for what exists; `pending` for what is designed but not built. `pending` is
  what lets a design be written down without the page lying about the code.
- **Owner** — `agents`, except under `05-public/` where it is `humans`.

## Writing for the two audiences

**Engineers** (`02-architecture/`, `04-development/`) — assume the code is readable. Explain the
*why*: the constraint, the rejected alternative, the ordering that matters.

**Operators** (`03-internal/`) — assume the code will never be read. Describe screens, fields, and
outcomes. No function names, no jargon, and no sentence whose ambiguity can only be resolved by
opening the source.

## What does not belong here

- **A chronological build log.** It answers *what happened*, never *how does this work now*. Both
  are useful; neither substitutes for the other.
- **Anything the environment already states.** Scripts in the package manifest, the directory
  listing, a `--help` output. Copying them creates a second version that goes stale. Document what
  cannot be looked up: the unwritten convention, the reason behind a choice, the trap nothing else
  confesses.
- **Duplicated rules.** One rule, one home, linked from anywhere else that needs it. Two copies
  disagree within a month.
