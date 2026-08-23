# claude-skills

My personal Claude Code skills.

## Install

```bash
./install.sh
```

```powershell
./install.ps1
```

Links each skill under `skills/` into `~/.claude/skills/`, so edits in this repo take effect without
reinstalling. Anything already at the destination is backed up first. Pass a skill name to install
just one; pass `-Copy` on Windows to copy instead of linking.

## Skills

### `project-foundation`

Plans a project from zero and installs the documentation system, agent rules, and working rhythm
that keep it coherent as it grows. Runs in three modes — **greenfield**, **retrofit** onto working
code, or **refactor** where the reshaping is the job.

Seven phases, read one at a time: frame the project and profile whoever is deciding · grill the
product until the design tree is exhausted · design the architecture around the pivots you actually
expect · build a step-gated roadmap ordered by riskiest assumption · scaffold the docs · install the
guardrails · hand off.

What it leaves behind in the target project:

| | |
|---|---|
| `docs/README.md` | Two indexes — one to **find** an answer, one to **route** a change to the pages it invalidates |
| `docs/` | Project, architecture, internal handbook, development, and human-owned public docs |
| `CONTEXT.md` | The project's ubiquitous language |
| `docs/00-meta/deferred-ledger.md` | Everything deliberately skipped, each with a **trigger** that fires it back |
| `CLAUDE.md` | The standing contract every agent reads |
| `.claude/settings.json` | A permission rule making public-doc edits require a human, plus routing and closing-ask hooks |
| `.claude/skills/` | `/plan-step`, `/next-step`, `/doc-check`, `/defer`, `/prototype` |

Everything it installs is **project-local** — `<project>/CLAUDE.md` and `<project>/.claude/`,
committed with the repo. Nothing is written to `~/.claude/`.

Six ideas do most of the work:

- **Collect the asks at the end.** Every response that needs something from a person ends with a
  numbered `Your turn` block repeating every question and action — even the ones already asked
  inline. Long responses get skimmed; the end is the only place guaranteed to be read. Enforced in
  `CLAUDE.md` and reinforced every turn by a `UserPromptSubmit` hook.

- **Routing over discipline.** Docs rot because nobody can tell, at the moment of a change, which
  page it invalidated. A routing table of matchable triggers turns that from a judgement call into a
  grep.

- **Defer with a trigger, never silently.** Skipping rate limiting for a demo is fine; forgetting is
  how it ships. Every omission gets an observable condition that brings it back.

- **Plan only what is load-bearing.** Settle what is hard to reverse, constrains other decisions, or
  is forced from outside. Everything else is decided at the step that needs it, with real
  information.

- **Three tiers of plan, written at three times.** The **arc** of every milestone — what each one
  proves, and which technologies and pipeline stages arrive with it — is written up front, once
  scope and architecture are settled. The current milestone's next two steps are written in full.
  Nothing below that is written until its milestone boundary, because the milestones above it will
  change what it should say.

- **Planning is a separate job from building.** A weak plan costs a week; weak building costs an
  afternoon. So `/plan-step` and `/next-step` are two skills. The planning one opens by recommending
  a strong model and waiting for a yes — recommending, never switching — and writes each step down
  with its shape, its stack delta, and the pipeline stages it touches, so the agent executing it
  follows a decision rather than re-making one on whatever model it happens to be running.

## Credits

`project-foundation` adapts techniques from [Matt Pocock's skills](https://github.com/mattpocock/skills)
— the frontier model for interviewing from `grilling`, the glossary and ADR discipline from
`domain-modeling`, the two-branch throwaway method from `prototype`, and the deep-module vocabulary
from `codebase-design`. Written to stand alone; his skills do not need to be installed.

## Licence

MIT — see [LICENSE](LICENSE).
