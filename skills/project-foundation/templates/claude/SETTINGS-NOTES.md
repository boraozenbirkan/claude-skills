# Notes on `settings.json`

Merge this into the target project's `.claude/settings.json` rather than replacing the file, and
tell the operator what was added. JSON has no comments, so the reasoning lives here.

**Everything here is project-local.** This file is `<project>/.claude/settings.json`, committed with
the repo, in effect only for sessions in this project. Nothing in this skill writes to
`~/.claude/settings.json` or `~/.claude/CLAUDE.md`. An operator who wants a rule everywhere can copy
it into their personal config themselves; that is their choice to make, not the skill's.

## The public-docs guard

```json
"permissions": { "ask": ["Edit(/docs/05-public/**)"] }
```

Four facts it depends on:

- **Only `Edit(path)` and `Read(path)` rules gate file access.** A `Write(...)`, `NotebookEdit(...)`,
  or `MultiEdit(...)` path rule is accepted by the settings parser and then never consulted — it
  looks like a guard and is not one. `Edit(...)` covers every file-modification tool.
- **The leading `/` anchors to the project root** of whichever settings file declares it, so this
  matches `<project>/docs/05-public/` exactly. Without it, an ask rule would match a `docs`
  directory at any depth.
- **Precedence is deny → ask → allow**, first match wins. An `ask` rule prompts even when a more
  specific `allow` rule matches, and even when a `PreToolUse` hook returned `allow`.
- **`ask` and `deny` rules apply without the workspace-trust dialog**, because they only restrict.

Net effect: agents read public docs freely and can propose changes, but every write puts a
permission prompt in front of a human, with no way for the agent to approve it.

**The gap, worth telling the operator about:** path rules gate the file tools, not the shell. A
write performed through `Bash` — `sed -i`, a redirect, a heredoc — is not caught, because Bash
permission patterns match command prefixes rather than file paths. The `CLAUDE.md` rule and the
guard README inside `docs/05-public/` cover that path. Closing it hard means denying the shell
editors by name, which costs false positives; offer it, do not impose it.

## The per-turn closing-ask reminder

```json
"UserPromptSubmit": [{ "hooks": [{ "type": "command", "command": "echo \"Reminder: ...\"" }] }]
```

`UserPromptSubmit` is one of the few events whose stdout on exit 0 is **added to the context Claude
can see** (alongside `UserPromptExpansion` and `SessionStart`); on every other event, stdout goes to
the debug log and nowhere else. So a plain `echo` injects the reminder on every single turn, for no
model call and no script file.

That per-turn repetition is the point. The `CLAUDE.md` rule is read once at session start, and a
response-formatting rule is exactly the kind that decays as a session grows — which is precisely
when responses get long enough for a buried question to be missed. This puts it back in front of the
model at every prompt, for roughly 45 tokens.

Note the missing `if`. On non-tool events a hook with `if` set **never runs**, so this entry must
have none.

Remove this entry if the operator finds it noisy. The `CLAUDE.md` rule stands on its own; this is
reinforcement, not the mechanism.

## The routing hooks

`PostToolUse` fires at the moment of the change — when the routing question is answerable and the
context is still loaded — which beats a reminder at the end of a session.

`PostToolUse` honours `systemMessage` in a hook's JSON output and delivers it to Claude. The `if`
field filters by path using permission-rule syntax, and is evaluated on tool events only.

### Why these are `command` hooks and not `prompt` hooks

**A routing reminder is a constant. Emit it as a constant.**

The earlier version of this file used `"type": "prompt"` handlers — the hook input goes to a fast
model, which is asked to reply with a fixed JSON object. In practice the sub-model read the prompt's
opening sentence (*"A migration was just written…"*) as a **claim to verify**, checked it against
the hook input, decided the claim did not hold, and wrote prose explaining itself:

> The hook input shows an edit to `zod-probe.ts` (a throwaway utility), not an edit to the content
> schema itself. The condition is not met.

Prose is not the JSON the event expects, so the routing message never arrived — and the judgement
being made had already been made, correctly, by the `if` matcher a moment earlier. The model call
bought nothing and lost the reminder. It also fired on every matching edit, so the loss was
systematic rather than occasional.

A `command` hook echoing a fixed string cannot do this. No model, no judgement, no latency, and the
same bytes every time.

**Portability.** `echo '{"systemMessage": "..."}'` produces byte-identical output in `bash` and in
`powershell` — the two shells Claude Code uses by default (bash, or powershell on Windows when Git
Bash is not installed). Single quotes are a literal string in both. Two rules keep it that way:

- **No apostrophe anywhere in the message.** It closes the string. Write *"the operators handbook"*
  or rephrase; do not write *"the operator's handbook"*.
- **No `"` inside the message text.** The JSON already uses them.

Prefer a hyphen to an em dash for the same reason of not tempting anyone into fancier quoting.

### Filling them in

**Replace every `REPLACE_WITH_*_GLOB`** with this project's real paths, taken from the routing table
in `docs/README.md`, and **delete any entry that has no real glob.** A hook whose `if` never matches
is dead weight; a hook pointing at a page that does not exist is worse.

Glob syntax for `if` follows the permission-rule form: `Edit(src/**)` matches `src` at the top level,
`Edit(**/migrations/**)` matches at any depth, `Edit(**.py)` matches by extension.

Public routes and admin routes are two separate entries on purpose. One entry that asked the hook to
work out which kind of route it was looking at would be re-introducing the judgement call this whole
section exists to remove. If the two cannot be told apart by glob, keep the public one and drop the
other.

**Keep the list short.** Four to six entries is a healthy ceiling. A hook on every source edit trains
everyone to ignore hook output — at which point the mechanism is worse than nothing. High-value,
low-frequency paths only; the routing table carries the rest.

### Verify before handing off

Each command must print its JSON and nothing else. From the project root:

```bash
python - <<'EOF'
import json
s = json.load(open('.claude/settings.json'))
bad = 0
for group in s.get('hooks', {}).get('PostToolUse', []):
    for h in group.get('hooks', []):
        c = h.get('command', '')
        if not (c.startswith("echo '") and c.endswith("'")):
            continue
        try:
            json.loads(c[6:-1])
        except Exception as e:
            bad += 1
            print('BROKEN', h.get('if'), e)
print('checked; broken =', bad)
EOF
```

An apostrophe smuggled into a message shows up here as broken JSON, rather than as a routing
reminder that silently stopped arriving three weeks ago. Run it again after any edit to a message.

## What was considered and left out

A `Stop` hook checking the whole diff against the routing table before a session ends. It needs the
diff, and `prompt` hooks have no tools while command hooks need a shell and a JSON parser on every
developer's machine. `PostToolUse` catches the same thing earlier and more reliably. Projects that
want the end-of-session sweep have `/doc-check`, which does it on demand with full tool access.
