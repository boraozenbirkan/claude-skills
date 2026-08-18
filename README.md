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
that keep it coherent as it grows. Also retrofits onto an existing project.

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
| `.claude/settings.json` | A permission rule making public-doc edits require a human, plus routing hooks |
| `.claude/skills/` | `/next-step`, `/doc-check`, `/defer`, `/prototype` |

Three ideas do most of the work:

- **Routing over discipline.** Docs rot because nobody can tell, at the moment of a change, which
  page it invalidated. A routing table of matchable triggers turns that from a judgement call into a
  grep.
- **Defer with a trigger, never silently.** Skipping rate limiting for a demo is fine; forgetting is
  how it ships. Every omission gets an observable condition that brings it back.
- **Plan only what is load-bearing.** Settle what is hard to reverse, constrains other decisions, or
  is forced from outside. Everything else is decided at the step that needs it, with real
  information.

## Credits

`project-foundation` adapts techniques from [Matt Pocock's skills](https://github.com/mattpocock/skills)
— the frontier model for interviewing from `grilling`, the glossary and ADR discipline from
`domain-modeling`, the two-branch throwaway method from `prototype`, and the deep-module vocabulary
from `codebase-design`. Written to stand alone; his skills do not need to be installed.

## Licence

MIT — see [LICENSE](LICENSE).
