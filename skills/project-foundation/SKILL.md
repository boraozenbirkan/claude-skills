---
name: project-foundation
description: Plan a project from zero and install the documentation system, agent rules, and working rhythm that keep it coherent as it grows. Use when starting a new project, bootstrapping an empty repo, planning an MVP or roadmap, planning a refactor of an existing codebase, or retrofitting docs and agent guardrails onto a project that lacks them.
---

# Project Foundation

Interview the people who decide, turn that into a **just-in-time** plan, and install the machinery
that keeps the plan and the code telling the same story a year later.

Most project docs die the same way: nobody can tell, at the moment of a change, *which* page the
change invalidated. That is not a discipline problem, it is a **routing** problem — and routing is
something you can build.

## What a finished run leaves behind

| Artifact | Job |
|---|---|
| `docs/README.md` | Two indexes: one to **find** an answer, one to **route** a change to the pages it invalidates |
| `docs/` tree | Project, architecture, internal handbook, development, and human-owned public docs |
| `CONTEXT.md` | The ubiquitous language — one word per concept, so humans and agents picture the same thing |
| `docs/01-project/roadmap.md` | Step-gated plan where each step earns its cost |
| `docs/00-meta/deferred-ledger.md` | Everything deliberately skipped, each with a **trigger** that fires it back |
| `CLAUDE.md` | The standing contract every agent reads |
| `.claude/settings.json` | Permission rules and hooks that enforce what prose alone cannot |
| `.claude/skills/` | `/plan-step`, `/next-step`, `/doc-check`, `/defer`, `/prototype` — the working rhythm, installed |

## Invariants

These hold in every phase. They are the skill.

**1 — Collect the asks at the end of every response.** Any response needing something from the
operator ends with a **Your turn** section repeating every question, decision, and action — all of
them, together, restated in full **even when they already appeared inline above**. A long response
gets skimmed, and anything asked in the middle of one is missed; the end is the only place
guaranteed to be read. Number them, make each answerable without scrolling back, point to the
section holding the full context, and mark which ones block. When nothing is needed, say so in one
line rather than omitting the section.

This one binds the whole run. Every phase below asks the operator for something.

**2 — Load-bearing decisions only.** A decision belongs in the plan now if it is hard to reverse,
constrains other decisions, or is forced from outside (compliance, platform, a partner's API).
Everything else is noise at this stage and will change anyway. See
[`reference/load-bearing.md`](reference/load-bearing.md).

**3 — Defer with a trigger, never silently.** Skipping rate limiting for a demo is fine. Skipping it
*and forgetting* is how it ships. Every skipped thing goes in the ledger with a **trigger** — the
observable condition that makes it due (`before any real user data`, `before public launch`,
`when this table passes ~10k rows`). A ledger entry without a trigger never fires, so it is not an
entry. See [`reference/deferred-ledger.md`](reference/deferred-ledger.md).

**4 — Public docs are human-owned.** `docs/05-public/` changes when a human asks for that change in
the current conversation. Agents working anywhere near it **propose the diff in chat and wait**.
Every other doc is the opposite: agents own it and must keep it current.

**5 — Find the facts; ask for the decisions.** Anything the environment can answer — the stack, the
scripts, the existing layout — you look up yourself. Only genuine decisions go to the operator, and
each one carries your recommendation.

**6 — Speak the operator's register.** Phase 1 establishes who is deciding and what they know. A
non-technical founder and a staff engineer need different words for the same question. Get this
wrong and every later answer is worth less.

**7 — Create lazily.** A page exists when it has something real to say. Eight pages of live content
beat sixteen where half are placeholders — placeholders teach agents that these docs are decoration.

**8 — General before specific.** Prototype the widest slice first, then subsystems as they are
needed. A subsystem built before the system it serves is a guess.

**9 — Decisions are written down in the phase that makes them.** The architecture goes to disk in
phase 3, the roadmap in phase 4 — not later, in phase 5. A decision that lives only in the
conversation is gone at the next `/clear`, cannot be reviewed by anyone who was not in the room, and
gets silently re-invented by the next agent. Writing it is also the test of whether it was decided:
a stack you cannot list and a pipeline you cannot stage were discussed, not settled.

**10 — Plan on the strong model, and say so before you start.** Planning is the expensive thing to
get wrong; execution is cheap to redo. Before phase 3 and again before phase 4, name what you are
about to do and give the operator one pause to check the model and effort in their status line. The
same checkpoint ships into the project as `/plan-step`, kept separate from `/next-step` so a plan
never quietly inherits whatever model an execution session happened to be running.

## Phases

Read **one phase file at a time**, work it to its completion criterion, then read the next. Reading
ahead pulls the later phases into view and makes it tempting to rush the one in front of you — the
interview phases are exactly where that costs the most.

| # | Phase | Ends when |
|---|---|---|
| 1 | [Frame and operator](phases/1-frame-and-operator.md) | You know what is being built in one sentence, and who decides |
| 2 | [Grill the product](phases/2-grill.md) | The product frontier is empty |
| 3 | [Design the architecture](phases/3-architecture.md) | The frontier is empty, every seam is justified, and the architecture pages are on disk |
| 4 | [Build the roadmap](phases/4-roadmap.md) | `roadmap.md` is on disk, step 1 is unambiguous, and every deferral has a trigger |
| 5 | [Scaffold the docs](phases/5-scaffold.md) | The remaining pages exist and all three index checks pass |
| 6 | [Install the guardrails](phases/6-guardrails.md) | Rules, permissions, hooks, and project skills are in place |
| 7 | [Hand off](phases/7-handoff.md) | The operator knows what exists and what happens next |

## Before phase 1

**Read the ground first.** Manifests (`package.json`, `pyproject.toml`, `go.mod`, `Cargo.toml`),
existing `README.md` / `CLAUDE.md` / `AGENTS.md` / `docs/`, the top-level layout, any migrations or
infrastructure config, and the last fifty commits. What you find picks the mode:

| Mode | The repo | What phases 2–4 do |
|---|---|---|
| **Greenfield** | Empty, or a starter and nothing else | Make the decisions |
| **Retrofit** | Working code that is staying as it is | Recover the decisions already made, then plan forward |
| **Refactor** | Code that is being reshaped, and that reshaping is the job | Recover, then plan the migration |

All three run all seven phases. Retrofit and refactor change what phases 2, 3, and 4 are *for* —
read [`reference/existing-projects.md`](reference/existing-projects.md) before starting either, and
say which mode you picked so the operator is not guessing at how much you are about to change.

**Check for an interrupted run.** If `docs/00-meta/foundation-session.md` exists, this is a resume:
read it, tell the operator which phase it stopped at and what was settled, and continue from there
rather than re-asking answered questions.

## Adapt, never clobber

Where a file already exists, read it, keep what is accurate, add what is missing, and say what you
changed. A hand-written `CLAUDE.md` or `README.md` represents decisions someone made on purpose.

Trim any template section this project will not use. A CLI tool has no SEO page; a static site has
no database conventions. A checklist item nobody will ever act on trains the reader to skim.
