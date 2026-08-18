# Templates

Files copied into the **target project**, not read as instructions for this skill.

    project/    → the project root: CLAUDE.md, CONTEXT.md, and the docs/ tree
    claude/     → the project's .claude/: settings.json and the four project skills

## Copy, then cut

Every template is a maximum, not a minimum. Copy it, delete every line that does not apply to this
project, and replace every `{{PLACEHOLDER}}` with a real value.

A shipped placeholder is worse than a missing page: it teaches the next reader that these docs are
decoration, and after that they stop reading all of them.

## Relative links in `claude/skills/`

The four project skills link with `../../../docs/...`, which resolves from where they are
**installed** — `<project>/.claude/skills/<name>/SKILL.md` — back to the project root. Inside this
templates tree those paths point nowhere, which is expected. Leave them alone.

The paths under `project/` mirror the project root exactly, so links there resolve both here and
after copying.

## Which pages to create

Decided by [`../reference/project-types.md`](../reference/project-types.md) and by the skill's seventh
invariant: **a page exists when it has something real to say.** A CLI tool gets no SEO page; a static
site gets no database page.

Every page that is created needs rows in both indexes of `docs/README.md`, and the two verification
commands at the bottom of that file should print nothing before the run is called done.
