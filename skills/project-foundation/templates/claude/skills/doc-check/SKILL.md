---
name: doc-check
description: Check the current changes against the documentation routing table and update every page they invalidated. Use before reporting work complete, before committing, when asked whether the docs are current, or after any change to schema, auth, routes, integrations, conventions, or the roadmap.
---

# Doc check

Hold what changed next to the routing table, and update what it hit.

## 1 — Find what changed

    git status --porcelain
    git diff --name-only HEAD

Uncommitted and committed-but-unpushed both count. If the work happened without git, use the files
touched in this session.

## 2 — Match against the routing table

Read the routing table in [`docs/README.md`](../../../docs/README.md) and grep it for each changed
path. Every row has a trigger; a trigger either matched or it did not.

Also match the change-type triggers — the rows without globs. These need reading rather than
grepping: *"any auth rule, permission check, role, or access policy"* fires on a change that no
glob would catch.

## 3 — Update every page that matched

Update the page to describe **how the system works now**, not what changed. A page that reads like a
changelog has stopped being reference documentation.

Where a match is genuinely a no-op — the page already covers the new state — say so explicitly
rather than silently skipping it. That is the difference between checked and not checked.

## 4 — Handle what no row covers

A new concept, screen, table, integration, or rule that no page describes means either the nearest
page needs a section or a new page is needed. Either way, **add its rows to both indexes** — the
Find index and the routing table — or the next agent will not know it exists.

## 5 — Sweep the ledger

Read [`docs/00-meta/deferred-ledger.md`](../../../docs/00-meta/deferred-ledger.md). Did this change
fire any trigger? Working in an area with an open entry is the cheapest moment to clear it.

Report fired triggers even when the answer is to re-defer. A fire is a decision point, not a task.

## 6 — Report, then collect the asks

- Pages updated, and what changed in each
- Rows that matched but needed nothing, and why
- Ledger triggers fired, and what was decided

Then end with a numbered **Your turn** block holding everything that needs a person: the ambiguities
you could not resolve, the public-doc corrections awaiting approval, the fired triggers you are
re-deferring and want confirmed. Restate each in full, even where it appeared above, and mark what
blocks.

Nothing outstanding is worth one line saying so — "nothing needed from you" reads very differently
from a report that simply ends.

## Public docs

`docs/05-public/` is human-owned. If a change makes a public page inaccurate, **write the proposed
correction into chat and wait for a yes**. Editing one raises a permission prompt; that prompt is
the human's decision, not an obstacle to route around.
