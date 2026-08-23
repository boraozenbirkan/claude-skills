# Running this on a project that already exists

Three modes. Read the ground first, then pick one and say which you picked — the operator should
never have to guess how much you are about to change.

| Mode | The repo | What phases 2–4 are doing |
|---|---|---|
| **Greenfield** | Empty, or a framework starter and nothing else | Making decisions |
| **Retrofit** | Real code, working, staying as it is | **Recovering** decisions already made, and writing them down |
| **Refactor** | Real code that is being reshaped — and that is the job | Recovering, then deciding what changes and in what order |

Retrofit and refactor share the same first half. They differ only in what phase 4 produces: a
roadmap of new work, or a roadmap of migration.

## Read the ground before asking anything

Cheap, and it changes every question you would otherwise ask:

- Manifests — `package.json`, `pyproject.toml`, `go.mod`, `Cargo.toml`, lockfiles
- `README.md`, `CLAUDE.md`, `AGENTS.md`, `docs/`, `CONTRIBUTING.md`
- Top-level layout, and how deep it goes
- Migrations, schema files, infrastructure and deploy config
- `git log --oneline | head -50` — what this team has actually been doing lately
- Test setup, or its absence

Invariant 5 is at its most valuable here. Every question you ask that the repo already answers
spends the operator's patience on something you could have read.

## Recovering decisions instead of making them

Phases 2 and 3 change shape. Instead of *"what should the data store be?"*, it is:

> The code reads as Postgres via Prisma, single-tenant, with auth in application middleware rather
> than in the database. Multi-tenancy would touch every query. Is that a decision you would defend,
> or one that happened?

That distinction — **decided** versus **happened** — is the whole interview in retrofit mode, and it
is one only the operator can settle. Where the answer is "it happened", you have found either an ADR
worth writing or a refactor step worth planning.

Three findings to look for specifically, because each one becomes a ledger entry or an ADR:

- **Decisions the code contradicts.** Two places doing the same thing differently. Say which one
  you believe and ask.
- **Load-bearing accidents.** Something everything now depends on that nobody chose. These are the
  most expensive things in the codebase and almost never written down.
- **Documented behaviour the code no longer has.** Pre-existing docs that are simply wrong.

## Never index a page you have not verified

The worst outcome of a retrofit is a stale page inside a freshly built index. The index makes it
look authoritative, and the whole mechanism this skill installs then works to keep pointing agents
at something false.

Every pre-existing page gets one of three verdicts before it earns a row:

- **Current** — checked against the code. Index it.
- **Wrong** — say so, page by page, in the handoff. Either fix it in this run or index it with
  `> **Status:** stale — do not trust` and a ledger entry with a trigger.
- **Historical** — a build log, an old RFC. Move it out of the reference tree rather than indexing
  it as reference.

## Refactor mode: phase 4 plans the migration

Everything above, plus a roadmap whose steps are moves rather than features. The shape holds — each
step still answers a question, still names what it is not building, still has an observable **Done
when** — but the ordering rule sharpens:

1. **Seams before moves.** Put the interface in place while the old implementation still sits behind
   it. Nothing else can be incremental until this exists.
2. **Strangle, do not rewrite.** New behind the seam, old still serving, traffic moved over
   deliberately. A rewrite branch that runs for two months is the failure mode this ordering exists
   to avoid.
3. **Each step ships.** If a step leaves the main branch unshippable, it is two steps.
4. **Deletion is a step with its own line.** The old path removed, on purpose, with a **Done when**.
   A refactor that never deletes has added a second way to do everything.

Every step's **Direction** block matters more here than in greenfield, because the shape is
constrained by what already exists rather than chosen freely. Name the real files.

Two things to settle with the operator before writing any of it:

- **What is not moving.** The parts staying exactly as they are. Without this line, a refactor
  expands until it is a rewrite.
- **How long both paths coexist**, and what closes that window. That is a ledger entry with a
  trigger, and it is the one that gets forgotten.

## Adapt, never clobber

A hand-written `CLAUDE.md` or `README.md` is a set of decisions someone made on purpose. Read it,
keep what is accurate, add what is missing, and tell the operator what you changed. Where an
existing rule contradicts one of this skill's, raise it rather than overwriting — theirs may be
right for reasons not visible in the repo.
