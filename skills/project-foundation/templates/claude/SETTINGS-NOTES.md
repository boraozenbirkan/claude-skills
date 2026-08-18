# Notes on `settings.json`

Merge this into the target project's `.claude/settings.json` rather than replacing the file, and
tell the operator what was added. JSON has no comments, so the reasoning lives here.

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

`echo` is a builtin in bash, PowerShell, and cmd, and the text deliberately avoids apostrophes,
`$`, `!`, and shell metacharacters so the same line is safe in all three. On cmd the quotes are
echoed literally, which is cosmetically imperfect and functionally fine.

Remove this entry if the operator finds it noisy. The `CLAUDE.md` rule stands on its own; this is
reinforcement, not the mechanism.

## The routing hooks

`PostToolUse` fires at the moment of the change — when the routing question is answerable and the
context is still loaded — which beats a reminder at the end of a session.

`"type": "prompt"` sends the hook input to a fast model and returns its JSON. No script file, no
`jq`, no shell, so the same config works on Windows, macOS, and Linux with nothing installed.

**Replace every `REPLACE_WITH_*_GLOB`** with this project's real paths, taken from the routing table
in `docs/README.md`, and **delete any entry that has no real glob.** A hook whose `if` never matches
is dead weight; a hook pointing at a page that does not exist is worse.

Glob syntax for `if` follows the permission-rule form: `Edit(src/**)` matches `src` at the top level,
`Edit(**/migrations/**)` matches at any depth, `Edit(**.py)` matches by extension.

**Keep the list short.** Four to six entries is a healthy ceiling. Each one costs a fast-model call
when it fires, and a hook on every source edit trains everyone to ignore hook output — at which
point the mechanism is worse than nothing. High-value, low-frequency paths only; the routing table
carries the rest.

## What was considered and left out

A `Stop` hook checking the whole diff against the routing table before a session ends. It needs the
diff, and `prompt` hooks have no tools while command hooks need a shell and a JSON parser on every
developer's machine. `PostToolUse` catches the same thing earlier and more reliably. Projects that
want the end-of-session sweep have `/doc-check`, which does it on demand with full tool access.
