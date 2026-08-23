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

**Install the closing-ask reminder first.** A `UserPromptSubmit` command hook running a plain `echo`
injects its output into the context on every turn — that event is one of the few whose stdout Claude
actually sees. It costs no model call and about 45 tokens, and it holds invariant 1 in front of the
model as the session grows long, which is exactly when a buried question starts getting missed. The
`CLAUDE.md` rule is the mechanism; this is what stops it decaying.

Give that entry **no `if` field.** On any event that is not a tool event, a hook with `if` set never
runs at all.

### A routing reminder is a constant — emit it as a constant

Every routing hook is a `command` handler that echoes one fixed JSON object. `PostToolUse` honours
`systemMessage` and delivers it to Claude, and the `if` matcher has already decided the hook
applies.

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "if": "Edit(supabase/migrations/**)",
            "command": "echo '{\"systemMessage\": \"Routing: migrations map to docs/02-architecture/data-model.md. Update it in this change.\"}'",
            "statusMessage": "Doc routing"
          }
        ]
      }
    ]
  }
}
```

**Do not reach for `"type": "prompt"` here.** It sends the hook input to a fast model and asks for a
fixed JSON reply — and a prompt that opens *"A migration was just written…"* reads to that model as
a claim to check rather than an instruction to obey. It checks, decides the claim does not hold, and
writes prose about it. Prose is not the JSON the event expects, so **the routing message never
arrives** — and the judgement it just made had already been made, correctly, by the `if` matcher.
The model call bought nothing and lost the reminder, on every matching edit.

A `command` hook cannot do this: same bytes every time, no model, no latency.

`echo '{"systemMessage": "..."}'` prints identically in `bash` and `powershell`, which are the two
shells Claude Code uses by default. That holds only while the message contains **no apostrophe** —
one closes the string and breaks the JSON. Write *"the operators handbook"*, not *"the operator's
handbook"*, and prefer a hyphen to an em dash.

Generate one entry per **high-value, low-frequency** routing trigger — the paths where a missed doc
update is expensive and the edit is rare. Migrations, auth and permissions, integration and env
config, public routes, admin screens. Deriving the `if` patterns from the routing table you just
wrote keeps the two in step.

Where one path needs two different messages — a public route versus an admin route — write **two
entries with two globs**, never one entry that asks the hook to work out which it is looking at.
That is the judgement call this whole section removes.

Keep the list short. A hook on every source edit trains everyone to ignore hook output, at which
point the mechanism is worse than nothing. Four to six entries is a healthy ceiling; the routing
table carries the rest.

Template: [`../templates/claude/settings.json`](../templates/claude/settings.json). Merge into an
existing `settings.json` rather than replacing it, and tell the operator what you added.

**Verify every message parses** before moving on — the check is at the bottom of
[`../templates/claude/SETTINGS-NOTES.md`](../templates/claude/SETTINGS-NOTES.md). A hook whose JSON
is malformed fails silently; nothing tells you the reminder stopped arriving.

## 6.4 — Project skills

Copy from [`../templates/claude/skills/`](../templates/claude/skills/) into the project's
`.claude/skills/`, filling in this project's real paths:

| Skill | What it is for |
|---|---|
| `/plan-step` | Recommend a planning model, then plan the next roadmap step in writing |
| `/next-step` | Work the current roadmap step, verify it, and record what it answered |
| `/doc-check` | Hold the current diff against the routing table and update what it hit |
| `/defer` | Add a ledger entry with a trigger, in one line, at the moment of the decision |
| `/prototype` | Build throwaway code that answers one question |

**`/plan-step` and `/next-step` are two skills on purpose.** Planning and building fail differently:
a weak plan costs a week of building the wrong thing, weak building costs an afternoon. Sessions get
run on cheap models for good reasons, and a re-plan tacked onto the end of one silently inherits
that model — which nobody notices, because a weak plan reads exactly like a strong one until the
week is gone.

**`/plan-step` recommends; it does not switch.** A `model:` line in its frontmatter would work —
it overrides for the rest of the turn — and it is deliberately absent. Moving an operator's model
without them seeing it move takes a decision about their own spend out of their hands, the override
can be refused by an organisation allowlist without saying so, and a skill cannot read the session
model to check whether it landed. So the skill stops before reading anything, names the
recommendation, and waits for a go. Set the recommended model in its opening prompt to whatever this
operator's strong model actually is.

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
are `command` handlers generated from the routing table, and every one of their JSON messages
parses; the five project skills exist with this project's real paths; and you have told the operator
what the permission prompt on public docs will look like when it fires.

Append to `docs/00-meta/foundation-session.md`.
