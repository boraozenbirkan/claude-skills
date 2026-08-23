# Phase 5 — Scaffold the docs

Phases 3 and 4 already wrote the load-bearing pages — `technical-map.md`, `pipelines.md`,
`modularity.md`, `roadmap.md`, and any ADRs. This phase writes **everything else**, indexes all of
it two ways, and proves both indexes resolve.

Read what phases 3 and 4 left on disk before writing anything. Re-deriving a page that already
exists is how a run quietly contradicts itself.

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

## Page headers and contents

Every page opens with one line:

```md
> **Audience:** engineers · **Status:** current · **Owner:** agents
```

- **Audience** — `engineers`, `operators`, `everyone`. Sets the register for whoever edits it next.
- **Status** — `current` for what exists, `pending` for behaviour that is designed and not yet
  built. `pending` is what lets you write down a design without lying about the code.
- **Owner** — `agents` everywhere except `docs/05-public/`, which is `humans`.

### Every page with four or more sections opens with its contents

Directly above the first `##` heading, after whatever short intro the page opens with:

```md
## On this page

- [Roles](#roles)
- [What is enforced today](#what-is-enforced-today)
- [What is deferred](#what-is-deferred)
- [Secrets](#secrets)
```

One link per `##` heading, in document order, not counting `On this page` itself. Anchors are the
GitHub form: lowercase, every character that is not a letter, digit, space, hyphen, or underscore
**deleted**, then each remaining space turned into a hyphen. Deletion happens before the spaces are converted, so
`## Step 1 — {{name}}` becomes `#step-1--name` with two hyphens where the dash was. Getting that
wrong produces a page of links that all look right and none of which jump anywhere.

This is a reading aid with a second job. A human skims it to decide whether the page is the one they
want. An agent reads it to see **what the page claims to cover**, which is precisely the question
behind *"does my change belong on this page, or does this page need a new section?"* — and a page
whose contents list has no row for the thing you just changed is telling you something.

Under four sections, skip it — a contents block listing two links is furniture. Skip `adr/`
entirely: every decision record has the same five sections, and a contents block repeating them on
each one is noise.

Keep it in step with the headings. A new `##` means a new row, in the same edit — the check at the
bottom of this phase catches the ones that drift.

## Flat until a section outgrows flat

Start every section as flat files in one directory. That is not a limitation to work around; it is
the right shape for a project with eight pages, and nesting it early buys navigation cost for
content that does not exist.

**Split a section into subdirectories when it has more than about six pages, or when a page passes
roughly 300 lines.** Both are countable, which is what makes them triggers rather than opinions.

When one fires:

1. Create the subdirectory — `02-architecture/billing/`, say.
2. Give it a `README.md` with the section's own Find index for its pages.
3. Link that `README.md` from `docs/README.md` in place of the individual rows it absorbed, or
   alongside them if a page is important enough to stay top-level.
4. Update the routing rows for the moved pages to their new paths.

The verification commands below already handle nesting: the orphan check searches every `README.md`
at any depth, so a page indexed only by its section README still counts as reachable.

Write this rule into `docs/00-meta/how-to-use-these-docs.md` so it survives the run, **and open a
ledger entry for it** — this is exactly what the ledger is for, and a growth rule nobody is watching
is a growth rule nobody applies:

    ### DL-00N — Split a docs section that has outgrown flat

    **Trigger:** any `docs/` section passes six pages, or any page passes 300 lines
    **Why deferred:** every section is under six pages today; nesting three pages costs navigation and buys nothing
    **What is needed:** the subdirectory, a section `README.md` holding its own Find index, and the routing rows repointed at the moved pages
    **Raised:** foundation · **Area:** docs

Note the current counts in the handoff if any section is already close.

## The section that gets skipped

**`docs/03-internal/`** — the handbook for admins and staff. Nobody writes this unprompted, and it
was an explicit ask. Written for someone who runs the product and may never read code: screens and
outcomes, not functions; no jargon; and no ambiguity that can only be resolved by reading the
source. Start with a one-page index of *"how do I…"* answers and add pages as real workflows appear.

Check `docs/02-architecture/pipelines.md` while you are here. Phase 3 wrote it; confirm it survived
as ordered stages with what enters and leaves each, because it is the page an agent reads to answer
*"where does my change go?"* and it is the first one to get thinned out under time pressure.

## The public docs

`docs/05-public/` is **human-owned**. Create the directory and its guard README from the template,
and leave it otherwise empty unless the operator asks for content in this conversation. Phase 6
installs the permission rule that enforces it.

State the rule positively in every place it appears: *public docs change when a human asks for that
change; agents propose the diff in chat and wait for a yes.*

## Verify before you call it done

Three checks, all mechanical, all run from the project root. Every one prints nothing when the docs
are sound.

**Orphan pages** — a page no index mentions is invisible to every agent that starts at the index.
Searches every `README.md` at any depth, so a page indexed by its section README counts:

```bash
cd docs && for f in $(find . -name '*.md' ! -name 'README.md' ! -path './adr/*' | sed 's|^\./||'); do grep -rqF "$(basename "$f")" --include='README.md' . || echo "ORPHAN: $f"; done
```

**Dead rows** — a row pointing at nothing is a confident lookup returning a broken link. Resolves
each link relative to the index that holds it, so nested section indexes are checked too:

```bash
cd docs && find . -name 'README.md' | while read -r idx; do d=$(dirname "$idx"); grep -oE '\]\([^)]+\.md[^)]*\)' "$idx" | sed 's/^](//;s/)$//;s/#.*$//' | while read -r l; do case "$l" in http*|*'{{'*) continue;; esac; [ -e "$d/$l" ] || echo "DEAD ROW: $idx -> $l"; done; done
```

**Stale contents** — a page whose `On this page` block no longer matches its headings is worse than
one with no block, because it is read as a claim about what the page covers:

```bash
python - <<'EOF'
import re, pathlib
def slug(t):
    t = re.sub(r'[^\w\s-]', '', t.strip().lower())
    return t.replace(' ', '-')
for f in sorted(pathlib.Path('docs').rglob('*.md')):
    if 'adr' in f.parts:
        continue
    text = f.read_text(encoding='utf-8')
    h2 = [l[3:].strip() for l in text.splitlines() if l.startswith('## ')]
    body = [h for h in h2 if h != 'On this page']
    if len(body) < 4:
        continue
    if 'On this page' not in h2:
        print('NO CONTENTS:', f); continue
    missing = [h for h in body if '(#%s)' % slug(h) not in text]
    if missing:
        print('CONTENTS STALE:', f, missing)
EOF
```

`adr/` is excluded from the first because decision records are indexed by number in their own
directory.

Put all three into the project's `docs/README.md` so they survive this run.

A stale routing table is worse than no routing table, because it is trusted.

## Done when

Every created page appears in both indexes; every index row resolves to a file that exists; every
page has its header line, and its contents block if it has four or more sections; the pipelines page
and the internal handbook exist; the split rule is written into `how-to-use-these-docs.md`;
`05-public/` holds its guard README and nothing unrequested; and all three checks above print
nothing.

Append to `docs/00-meta/foundation-session.md`.
