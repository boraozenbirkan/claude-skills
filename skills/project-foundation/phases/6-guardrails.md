# Phase 6 — Install the guardrails

Three layers, weakest to strongest: rules an agent reads, permissions the harness enforces, and
skills that make the right move the easy one.

Prose alone loses. Not because agents are careless, but because a rule read once at the top of a
long session competes with everything since. Put the mechanism where the action happens.

## 6.1 — Agent rules

Write [`../templates/project/CLAUDE.md`](../templates/project/CLAUDE.md) to wherever this project's
agents actually read from:

- `CLAUDE.md` is the default.
- If `AGENTS.md` exists, write there — it is the cross-tool convention — and leave `CLAUDE.md`
  containing `@AGENTS.md`.
- If a framework generates part of `AGENTS.md`, append below its delimited block, never inside it.

The doc-maintenance contract in that template is the point of this whole skill. Keep it intact.

**Phrase every rule as the behaviour you want.** A prohibition drags the forbidden thing into
context and makes it more available, not less — *"never edit the public docs"* leaves the reader
thinking about editing the public docs. *"Public docs change when a human asks; propose the diff and
wait"* names the action to take. Where a hard ban is unavoidable, pair it with the positive.

## 6.2 — Permissions

Add to `.claude/settings.json` in the target project:

```json
{
  "permissions": {
    "ask": [
      "Edit(/docs/05-public/**)"
    ]
  }
}
```

Four facts this depends on, all worth knowing before you edit it:

- **Only `Edit(path)` and `Read(path)` rules gate file access.** A `Write(...)`, `NotebookEdit(...)`,
  or `MultiEdit(...)` path rule is accepted and then never consulted — it looks like a guard and is
  not one. `Edit(/docs/05-public/**)` covers every file-modification tool.
- **The leading `/` anchors to the settings file's project root**, so this matches
  `<project>/docs/05-public/` and nothing else. Without it, a deny-or-ask rule would match a
  `docs` directory at any depth.
- **Precedence is deny → ask → allow**, first match wins. An `ask` rule prompts even when a more
  specific `allow` rule also matches, and even when a `PreToolUse` hook returned `allow`.
- **`ask` and `deny` rules apply without the workspace-trust dialog**, because they only restrict.

The effect: an agent can read the public docs freely and can still *propose* changes, but writing
one puts a permission prompt in front of a human. That is the enforcement — a human in the loop,
every time, with no way for the agent to approve on its own.

**Known gap, worth telling the operator about:** path rules gate the file tools, not the shell. An
agent that writes through `Bash` — `sed -i`, a redirect, a heredoc — is not caught by this rule.
Bash permission patterns match command prefixes, not file paths, so there is no clean rule for it.
The CLAUDE.md rule and the guard header inside each public file cover that path. Teams that want it
closed hard can add `"deny": ["Bash"]`-scoped rules for their editors of choice, at the cost of
false positives.

## 6.3 — Hooks

`PostToolUse` hooks fire at the moment of the change — the moment the routing question is actually
answerable — which beats a reminder at the end of the session, after attention has moved on.

Use `"type": "prompt"` handlers. They send the hook's input JSON to a fast model and need no script
file, no `jq`, and no shell, so the same `settings.json` works on Windows, macOS, and Linux with
nothing installed.

**Install the closing-ask reminder first.** A `UserPromptSubmit` command hook running a plain `echo`
injects its output into the context on every turn — that event is one of the few whose stdout Claude
actually sees. It costs no model call and about 45 tokens, and it holds invariant 1 in front of the
model as the session grows long, which is exactly when a buried question starts getting missed. The
`CLAUDE.md` rule is the mechanism; this is what stops it decaying.

Generate one entry per **high-value, low-frequency** routing trigger — the paths where a missed doc
update is expensive and the edit is rare. Migrations, auth and permissions, integration and env
config, public routes. Deriving the `if` patterns from the routing table you just wrote keeps the
two in step.

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "prompt",
            "if": "Edit(supabase/migrations/**)",
            "prompt": "A migration was just written. Reply with exactly this JSON and nothing else: {\"systemMessage\": \"Routing: migrations map to docs/02-architecture/data-model.md. Update it in this change.\"}\n\nHook input: $ARGUMENTS",
            "timeout": 30
          }
        ]
      }
    ]
  }
}
```

Keep the list short. A hook on every source edit spends a model call per keystroke-sized change and
trains everyone to ignore the output. Four to six entries is a healthy ceiling; the routing table
carries the rest.

Template: [`../templates/claude/settings.json`](../templates/claude/settings.json). Merge into an
existing `settings.json` rather than replacing it, and tell the operator what you added.

## 6.4 — Project skills

Copy from [`../templates/claude/skills/`](../templates/claude/skills/) into the project's
`.claude/skills/`, filling in this project's real paths:

| Skill | What it is for |
|---|---|
| `/next-step` | Work the current roadmap step, then re-plan the next one from what was learned |
| `/doc-check` | Hold the current diff against the routing table and update what it hit |
| `/defer` | Add a ledger entry with a trigger, in one line, at the moment of the decision |
| `/prototype` | Build throwaway code that answers one question |

These live in the project rather than in a personal skills directory on purpose: they are wired to
this project's paths, they travel with the repo to teammates and CI, and cloud sessions load them
from the checkout.

**Watch for a name collision.** A personal skill in `~/.claude/skills/` takes precedence over a
project skill of the same name, so an operator who already has their own `/prototype` or
`/doc-check` will keep getting theirs and never see this project's. Check `~/.claude/skills/` before
copying, and prefix the project's copy if a name is taken.

`/defer` matters more than its size suggests. The ledger only works if adding to it is cheaper than
the thought *"I'll note that later."*

## Done when

Agent rules are written where this project's agents read; the `Edit(/docs/05-public/**)` ask rule is
in `.claude/settings.json`; the closing-ask reminder fires on `UserPromptSubmit`; the routing hooks
are generated from the routing table; the four project skills exist with this project's real paths; and you have told the operator what the permission
prompt on public docs will look like when it fires.

Append to `docs/00-meta/foundation-session.md`.
