# {{PROJECT_NAME}} — Documentation

{{ONE_SENTENCE_DESCRIPTION}}

Two indexes below, for the two questions people actually arrive with. **Find** answers *"where is
X?"*. **Routing** answers *"I changed X — what does that invalidate?"*

---

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

Both directions have to hold: every page is reachable from an index, and every index row resolves
to a page that exists.

```bash
cd docs && for f in $(find . -name '*.md' ! -name 'README.md' ! -path './adr/*' | sed 's|^\./||'); do grep -rqF "$(basename "$f")" --include='README.md' . || echo "ORPHAN: $f"; done
```

```bash
grep -oE '\]\([^)]+\.md\)' docs/README.md | sed 's/^](//;s/)$//' | while read -r l; do [ -e "docs/$l" ] || echo "DEAD ROW: $l"; done
```

The first finds pages no index mentions — invisible to anyone who starts here. The second finds rows
pointing at nothing. `adr/` is skipped in the first: decision records are indexed by number in their
own directory, and a Find-index row per ADR would be noise.

Both should print nothing. When a page's content and its trigger drift apart, fix the trigger. A
stale routing table is worse than none, because it returns confident answers that are wrong.
