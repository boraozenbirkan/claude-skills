# The deferred ledger

A record of everything deliberately not done yet, each with the condition that makes it due.

Skipping rate limiting for a demo is good engineering. Skipping it *and forgetting* is how it
reaches production. The ledger is the difference, and it costs one line at the moment of the
decision.

## Entry format

```md
### DL-007 — Rate limiting on the public API

**Trigger:** before the API is reachable without an invite code
**Why deferred:** closed alpha, every caller is known and reachable by name
**What is needed:** per-key limits on write endpoints; 429 with Retry-After; a bypass for internal callers
**Raised:** step 2 · **Area:** security
```

- **Trigger** — the observable condition. The whole mechanism.
- **Why deferred** — the reasoning that made it safe *at the time*, so a future reader can check
  whether it still holds instead of guessing at intent.
- **What is needed** — enough that whoever picks it up does not re-derive the problem.
- **Area** — `security`, `scale`, `seo`, `accessibility`, `data`, `ops`, `legal`, `product`. Lets
  a sweep filter to what is relevant.

## Triggers are observable, never dates

A date is a guess about the calendar. A trigger is a fact about the project, and the project is what
actually decides when something is due.

| Trigger | Kind |
|---|---|
| `before any real user data is stored` | State change |
| `before the first external user has an account` | State change |
| `before public launch` | Milestone |
| `when the orders table passes ~10k rows` | Measurement |
| `when p95 on the search route passes 800ms` | Measurement |
| `when a second payment provider is added` | Architectural event |
| `when the first customer asks for SSO` | Demand signal |
| ~~`Q3`~~ | Not a trigger. Fires whether or not it is relevant, so it gets ignored, and then all of them do |
| ~~`before it matters`~~ | Not a trigger. Never evaluable |

**Test:** could an agent, reading only the project's current state, answer *yes* or *no*? If not,
sharpen it before writing the entry.

## Sweeping

The ledger fires at four moments. All four belong in `CLAUDE.md`, because an unswept ledger is
indistinguishable from no ledger.

1. **Starting a roadmap step** — which triggers has the last step fired?
2. **Finishing a step** — what did this step defer? Write it down before the context is gone.
3. **Crossing a stage line** — demo → beta → public → paying customers. The largest sweeps, because
   stage transitions fire whole clusters at once.
4. **Touching an area with open entries** — working on auth is the cheapest moment to clear a
   deferred auth item.

## When a trigger fires

Fires are not an instruction to build. They are an instruction to **decide, and record the
decision**:

- **Do it now** — it is due, and this is the cheapest it will ever be.
- **Re-defer with a new trigger** — the reasoning changed; write down what changed. An entry
  re-deferred three times is telling you the trigger was wrong, not that the work is unimportant.
- **Close it** — no longer applicable. Say why. A closed entry with its reasoning stops the same
  question arriving again next quarter.

Never let a fired trigger pass in silence. That is the failure mode the ledger exists to prevent,
and it looks exactly like everything being fine.
