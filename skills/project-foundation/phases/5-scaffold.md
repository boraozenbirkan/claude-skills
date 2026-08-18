# Phase 5 — Scaffold the docs

Everything settled in phases 1–4 gets written down here, indexed two ways.

Templates live in [`../templates/project/`](../templates/project/). Copy, then **cut every line that
does not apply and fill in this project's real values**. A shipped template placeholder is worse
than a missing page: it teaches every future reader that these docs are decoration.

## The tree

```
CONTEXT.md                    ubiquitous language — one word per concept
docs/
  README.md                   the two indexes            ← load-bearing
  00-meta/                    how to use these docs, personas, deferred ledger, session log
  01-project/                 overview, roadmap, brand and audience
  02-architecture/            technical map, pipelines, data model, security, integrations, modularity
  03-internal/                admin and staff handbook — how to run the thing
  04-development/             setup, conventions, database, SEO, deployment
  05-public/                  human-owned; what goes on the website
  adr/                        numbered decision records
```

Numbered so reading order is obvious and new pages have an unambiguous home. Rename sections to fit
the project; keep the numbering. Which pages actually get created is decided by
[`../reference/project-types.md`](../reference/project-types.md) and by invariant 7 — **a page
exists when it has something real to say.**

## `docs/README.md` — two indexes, two jobs

Agents arrive at documentation with one of exactly two questions, and one table cannot serve both.

**"Where is the answer to X?"** → the **Find index**: a question in the words someone would actually
use, mapped to a page. Write the questions the way a person asks them, not the way the docs are
organised. *"How does a refund work?"* beats *"Payments subsystem."*

**"I changed X — what does that invalidate?"** → the **Routing table**: a trigger mapped to the
pages that go stale when it fires. This is the table that keeps the docs alive.

### Triggers have to be matchable

A trigger is only real if an agent can hold its own diff next to it and get a yes or no. Write file
globs wherever a glob exists; where one does not, name an unambiguous change type.

| Real trigger | Why it fires |
|---|---|
| `supabase/migrations/**`, `prisma/schema.prisma` | A glob. Matches or does not |
| a new top-level directory, external service, or runtime dependency | Enumerable and checkable |
| any admin screen's fields, statuses, or workflow | Concrete and observable |
| a rule you had to explain in code review | An event that visibly happened |

*"When the architecture changes"* is not a trigger. Nobody can tell at a glance whether it applies,
so it never fires, and its row makes the table look complete while doing nothing.

### Make the lookup mechanical

Put the globs in the trigger column verbatim, so an agent can grep this one file with the path it
just touched instead of reading and judging. That is the difference between a lookup and a memory
test, and it is why the routing table works when good intentions do not.

Keep the triggers in **one place** — this table. Repeating them in page headers gives you two copies
that disagree within a month.

## Page headers

Every page opens with one line:

```md
> **Audience:** engineers · **Status:** current · **Owner:** agents
```

- **Audience** — `engineers`, `operators`, `everyone`. Sets the register for whoever edits it next.
- **Status** — `current` for what exists, `pending` for behaviour that is designed and not yet
  built. `pending` is what lets you write down a design without lying about the code.
- **Owner** — `agents` everywhere except `docs/05-public/`, which is `humans`.

## The sections that get skipped

Two of these are the ones nobody writes unprompted, and both were explicit asks. Write them.

**`docs/02-architecture/pipelines.md`** — the main pipeline and every sub-pipeline from phase 3, as
ordered stages with what enters and leaves each. This is the page an agent reads to answer *"where
does my change go?"*

**`docs/03-internal/`** — the handbook for admins and staff. Written for someone who runs the
product and may never read code: screens and outcomes, not functions; no jargon; and no ambiguity
that can only be resolved by reading the source. Start with a one-page index of *"how do I…"*
answers and add pages as real workflows appear.

## The public docs

`docs/05-public/` is **human-owned**. Create the directory and its guard README from the template,
and leave it otherwise empty unless the operator asks for content in this conversation. Phase 6
installs the permission rule that enforces it.

State the rule positively in every place it appears: *public docs change when a human asks for that
change; agents propose the diff in chat and wait for a yes.*

## Verify before you call it done

Two directions, both mechanical, both run from the project root.

**Orphan pages** — a page no index mentions is invisible to every agent that starts at the index:

```bash
cd docs && for f in $(find . -name '*.md' ! -name 'README.md' ! -path './adr/*' | sed 's|^\./||'); do grep -rqF "$(basename "$f")" --include='README.md' . || echo "ORPHAN: $f"; done
```

**Dead rows** — a row pointing at nothing is a confident lookup returning a broken link:

```bash
grep -oE '\]\([^)]+\.md\)' docs/README.md | sed 's/^](//;s/)$//' | while read -r l; do [ -e "docs/$l" ] || echo "DEAD ROW: $l"; done
```

Both print nothing when the indexes are complete. `adr/` is excluded from the first because decision
records are indexed by number in their own directory.

Put both commands into the project's `docs/README.md` so they survive this run.

A stale routing table is worse than no routing table, because it is trusted.

## Done when

Every created page appears in both indexes; every index row resolves to a file that exists; every
page has its header line; the pipelines page and the internal handbook exist; `05-public/` holds its
guard README and nothing unrequested; and the command above prints nothing on either side.

Append to `docs/00-meta/foundation-session.md`.
