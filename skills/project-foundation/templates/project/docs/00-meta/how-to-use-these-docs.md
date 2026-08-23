> **Audience:** everyone · **Status:** current · **Owner:** agents

# How these docs work

Three rules. They are the whole system.

## On this page

- [1 — The index is the entry point](#1--the-index-is-the-entry-point)
- [2 — Docs change in the same change as the code](#2--docs-change-in-the-same-change-as-the-code)
- [3 — Public docs belong to humans](#3--public-docs-belong-to-humans)
- [Page headers](#page-headers)
- [Contents blocks](#contents-blocks)
- [When a section grows into folders](#when-a-section-grows-into-folders)
- [Writing for the two audiences](#writing-for-the-two-audiences)
- [What does not belong here](#what-does-not-belong-here)

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

## Contents blocks

Any page with four or more `##` sections carries an `On this page` list directly above its first
`##`, one link per section, in order:

    ## On this page

    - [Roles](#roles)
    - [What is enforced today](#what-is-enforced-today)
    - [What is deferred](#what-is-deferred)
    - [Secrets](#secrets)

Anchors are the GitHub form: lowercase, delete every character that is not a letter, digit, space,
hyphen, or underscore, then turn each remaining space into a hyphen. Deletion happens first, so
`## Step 1 — {{name}}` anchors as `#step-1--name` — two hyphens, because the dash left a gap.

A human skims the list to decide whether this is the right page. An agent reads it as **the page's
claim about what it covers**, which is the question behind *"does my change belong here, or does
this page need a new section?"* — so a new `##` means a new row, in the same edit.

Pages under four sections skip it, and so does `adr/`, where every record has the same five
sections.

## When a section grows into folders

Sections start flat, and stay flat while flat is honest. **Split one into subdirectories when it
holds more than about six pages, or when a single page passes roughly 300 lines** — both countable,
which is what makes them triggers rather than opinions.

Splitting means: create the subdirectory, give it a `README.md` holding that section's own Find
index, link that README from [`../README.md`](../README.md) in place of the rows it absorbs, and
repoint the routing rows for every page that moved.

The orphan check searches every `README.md` at any depth, so a page indexed only by its section
README still counts as reachable. Nesting is free once it is earned; what costs is nesting a section
that has three pages in it.

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
