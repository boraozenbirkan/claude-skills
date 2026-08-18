> **Audience:** engineers · **Status:** current · **Owner:** agents

# Deferred ledger

Everything deliberately not done yet, each with the observable condition that makes it due.

Skipping something for a demo is good engineering. Skipping it *and forgetting* is how it ships. Add
an entry with `/defer` at the moment of the decision — the ledger only works while writing to it is
cheaper than the thought "I will note that later".

## Open

### DL-001 — {{title}}

**Trigger:** {{observable condition — see below}}
**Why deferred:** {{the reasoning that made it safe at the time, so a future reader can check whether it still holds}}
**What is needed:** {{enough that whoever picks this up does not have to re-derive the problem}}
**Raised:** {{step N}} · **Area:** {{security | scale | seo | accessibility | data | ops | legal | product}}

<!-- Newest at the top. Number sequentially; never reuse a number. -->

## Closed

### DL-000 — {{title}}

**Closed:** {{when}} — {{done, or no longer applicable and why}}

<!-- Keep closed entries. They stop the same question arriving again next quarter. -->

## Triggers are observable, never dates

A date is a guess about the calendar. A trigger is a fact about the project, and the project is what
decides when something is due.

| Real trigger | Kind |
|---|---|
| before any real user data is stored | State change |
| before the first external user has an account | State change |
| before public launch | Milestone |
| when the orders table passes ~10k rows | Measurement |
| when p95 on the search route passes 800ms | Measurement |
| when a second payment provider is added | Architectural event |
| when the first customer asks for SSO | Demand signal |

"Q3" is not a trigger: it fires whether or not it is relevant, so it gets ignored, and then all of
them do. "Before it matters" is not a trigger either — nobody can evaluate it.

**Test:** reading only the project's current state, could an agent answer yes or no? If not, sharpen
it before writing the entry.

## When a trigger fires

A fire means **decide, and record the decision** — not automatically build:

- **Do it now.** It is due, and this is the cheapest it will ever be.
- **Re-defer** with a new trigger and what changed. An entry re-deferred three times is telling you
  the trigger was wrong, not that the work is unimportant.
- **Close it** with the reason.

Letting a fired trigger pass in silence is the one failure this file exists to prevent, and it looks
exactly like everything being fine.
