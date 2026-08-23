# {{PROJECT_NAME}} — Documentation

{{ONE_SENTENCE_DESCRIPTION}}

Two indexes below, for the two questions people actually arrive with. **Find** answers *"where is
X?"*. **Routing** answers *"I changed X — what does that invalidate?"*

---

## On this page

- [Find index](#find-index)
- [Routing table](#routing-table)
- [The sections](#the-sections)
- [Keeping this honest](#keeping-this-honest)

## Find index

Questions in the words someone would actually ask them.

| If you want to know… | Read |
|---|---|
| How these docs work, and what I must update | [How these docs work](00-meta/how-to-use-these-docs.md) |
| What is this, and who is it for | [Overview](01-project/overview.md) |
| What we are building next, and what we are deliberately not building | [Roadmap](01-project/roadmap.md) |
| What a word means here | [`CONTEXT.md`](../CONTEXT.md) |
| Who I am talking to, and how much to explain | [Personas](00-meta/personas.md) |
| How we talk about the product, and to whom | [Brand and audience](01-project/brand-and-audience.md) |
| What we decided to skip for now, and when it comes back | [Deferred ledger](00-meta/deferred-ledger.md) |
| Why we did it *that* way | [Decision records](adr/) |
| What the stack is and where the code lives | [Technical map](02-architecture/technical-map.md) |
| What happens between a user acting and the result landing | [Pipelines](02-architecture/pipelines.md) |
| Where my change goes | [Pipelines](02-architecture/pipelines.md), then [Modularity](02-architecture/modularity.md) |
| What tables exist and how they relate | [Data model](02-architecture/data-model.md) |
| Who can do what, and how that is enforced | [Security](02-architecture/security.md) |
| What third parties we depend on, and which env vars they need | [Integrations](02-architecture/integrations.md) |
| How to {{COMMON_ADMIN_TASK}} | [Internal handbook](03-internal/) |
| How to get it running locally | [Local setup](04-development/local-setup.md) |
| How we name things, handle money, structure code | [Conventions](04-development/conventions.md) |
| How to change the database safely | [Database](04-development/database.md) |
| How code reaches production | [Deployment](04-development/deployment.md) |
| What goes on the website | [Public docs](05-public/) — human-owned |
| How this project was planned, and what is still open | [Foundation session](00-meta/foundation-session.md) |

<!-- Add a row whenever someone has to ask. A question asked twice is a missing row. -->

---

## Routing table

**Before finishing any change, grep this table for the paths you touched and update what matches.**

| Update when you touch | Page |
|---|---|
| `{{MIGRATIONS_GLOB}}` | [Data model](02-architecture/data-model.md) |
| a new top-level directory, external service, or runtime dependency | [Technical map](02-architecture/technical-map.md) |
| a stage in the request path — new step, changed order, new queue or job | [Pipelines](02-architecture/pipelines.md) |
| any auth rule, permission check, role, or access policy | [Security](02-architecture/security.md) |
| adding or removing a third-party service, or any new env var | [Integrations](02-architecture/integrations.md) |
| a new module seam, or a change to what sits behind one | [Modularity](02-architecture/modularity.md) |
| any admin or staff screen's fields, statuses, or workflow | [Internal handbook](03-internal/) |
| a new setup step, required tool, or env var | [Local setup](04-development/local-setup.md) |
| a rule you had to explain in review, or a pattern others should follow | [Conventions](04-development/conventions.md) |
| the migration workflow itself | [Database](04-development/database.md) |
| routes, metadata, redirects, canonical URLs, or the sitemap | [SEO](04-development/seo.md) |
| the pipeline, hosting config, or release process | [Deployment](04-development/deployment.md) |
| a term whose meaning shifted, or a new domain concept | [`CONTEXT.md`](../CONTEXT.md) |
| user-facing copy, product naming, or tone | [Brand and audience](01-project/brand-and-audience.md) |
| finishing, deferring, or re-scoping a step | [Roadmap](01-project/roadmap.md) |
| skipping something on purpose | [Deferred ledger](00-meta/deferred-ledger.md) |
| a hard-to-reverse decision a future reader would question | [a new ADR](adr/) |

{{BUILD_LOG_ROW}}

### What makes a trigger real

An agent must be able to hold its own diff next to a trigger and get a yes or no. Use file globs
verbatim wherever one exists, so the lookup is a grep rather than a judgement call. Where no glob
exists, name a change type concrete enough to be observed — *"any admin screen's fields, statuses,
or workflow"*, not *"when the admin area changes"*.

*"When the architecture changes"* never fires. Nobody can tell at a glance whether it applies, and
its row makes the table look complete while doing nothing.

---

## The sections

- **`00-meta/`** — how these docs work, who reads them, what is deferred.
- **`01-project/`** — what we are building and why. Start here if you are new.
- **`02-architecture/`** — how it is put together. For engineers.
- **`03-internal/`** — how to run it day to day. For operators; no jargon, no code.
- **`04-development/`** — how to work on it. For engineers.
- **`05-public/`** — what we publish. **Human-owned:** agents propose changes in chat and wait.
- **`adr/`** — why we decided the things that would otherwise look strange.

Every page opens with `Audience · Status · Owner`. **`Status: pending`** means the behaviour is
designed and not yet built — a design written down honestly, not a promise the code has broken.

---

## Keeping this honest

Three checks. All three print nothing when the docs are sound. Run them before calling any change
complete.

**Every page is reachable from an index.** Searches every `README.md` at any depth, so a page listed
only in its section index still counts:

```bash
cd docs && for f in $(find . -name '*.md' ! -name 'README.md' ! -path './adr/*' | sed 's|^\./||'); do grep -rqF "$(basename "$f")" --include='README.md' . || echo "ORPHAN: $f"; done
```

**Every index row resolves.** Links are resolved relative to the index that holds them:

```bash
cd docs && find . -name 'README.md' | while read -r idx; do d=$(dirname "$idx"); grep -oE '\]\([^)]+\.md[^)]*\)' "$idx" | sed 's/^](//;s/)$//;s/#.*$//' | while read -r l; do case "$l" in http*|*'{{'*) continue;; esac; [ -e "$d/$l" ] || echo "DEAD ROW: $idx -> $l"; done; done
```

**Every contents block matches its headings.** A page with four or more `##` sections carries an
`On this page` list, and that list is a claim about what the page covers:

```bash
python - <<'EOF'
import re, pathlib
def slug(t):
    t = re.sub(r'[^\w\s-]', '', t.strip().lower())
    return t.replace(' ', '-')
for f in sorted(pathlib.Path('docs').rglob('*.md')):
    if 'adr' in f.parts:
        continue
    text = f.read_text(encoding='utf-8')
    h2 = [l[3:].strip() for l in text.splitlines() if l.startswith('## ')]
    body = [h for h in h2 if h != 'On this page']
    if len(body) < 4:
        continue
    if 'On this page' not in h2:
        print('NO CONTENTS:', f); continue
    missing = [h for h in body if '(#%s)' % slug(h) not in text]
    if missing:
        print('CONTENTS STALE:', f, missing)
EOF
```

`adr/` is skipped in the first and third: decision records are indexed by number in their own
directory, and they all share one five-section shape.

When a page's content and its trigger drift apart, fix the trigger. A stale routing table is worse
than none, because it returns confident answers that are wrong.
