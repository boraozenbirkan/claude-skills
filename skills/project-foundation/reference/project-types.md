# Project types: pages and future needs

Two jobs. Decide **which doc pages are real** for this project, and surface **the needs that are
real but not yet due** so phase 4 can put them in the ledger with triggers.

Most projects are a blend — a SaaS product usually carries a marketing site too. Take the union, and
keep the type in mind when triggers are written.

## Universal

Real for every project: overview, roadmap, technical map, pipelines, conventions, local setup,
modularity, deferred ledger, personas, `CONTEXT.md`.

Deferred by default, for every project:

| Need | Typical trigger |
|---|---|
| Backup, and a **restored** backup | before any data you would be sorry to lose |
| Error tracking and structured logs | before anyone outside the team uses it |
| Secret rotation path | before the first non-founder has access |
| Dependency and vulnerability scanning | before public launch |
| Onboarding doc for a second developer | when hiring or contracting is planned |

The backup entry says *restored* deliberately. An untested backup is a belief, not a backup.

## Public website or marketing site

**Pages:** SEO, deployment, brand and audience, analytics. No database page unless there is one.

| Need | Typical trigger |
|---|---|
| **Canonical origin** — apex or `www`, permanent redirect on the other | before the first inbound link exists |
| **URL and slug shape** | before any page is indexed |
| **Render strategy per route** — static, revalidated, dynamic | at the first dynamic page |
| Per-route title and meta description | before launch |
| `sitemap.xml`, `robots.txt`, canonical tags | before submitting to Search Console |
| `noindex` on private, transactional, and auth-callback routes | at the first such route |
| Open Graph and card images | before anyone shares a link |
| Structured data for the content type | when organic traffic becomes a goal |
| Core Web Vitals budget | before launch |
| Analytics with a consent path | before the first campaign |

The top three are ordered by retrofit cost, and they cost the most. Changing canonical origin or URL
shape after indexing means redirect chains, split ranking signals, and months of recovery. Decide
them in phase 3 even though nothing is built.

## SaaS or web application

**Pages:** data model, security, integrations, database, deployment, internal handbook, SEO if there
is a public surface.

| Need | Typical trigger |
|---|---|
| **Tenancy model** | load-bearing — settle in phase 3, never defer |
| Row-level or query-level access enforcement | before any user sees another user's data path |
| Audit trail on privileged actions | before staff can act on user accounts |
| Rate limiting on public endpoints | before unauthenticated access |
| Session, token expiry, and revocation | before real accounts |
| Data export and deletion | before personal data, or at first request — whichever is sooner |
| Email deliverability — SPF, DKIM, DMARC | before transactional email |
| Subscription proration, dunning, tax | at the first paid subscription |
| SSO | at the first enterprise customer asking |
| Background job queue | when a request path waits on a third party |
| Read replica or cache | when a measured query crosses its budget |

## API or backend service

**Pages:** data model, security, integrations, deployment, and a consumer-facing contract page.

| Need | Typical trigger |
|---|---|
| **Versioning scheme** | before the first external consumer |
| Auth scheme and key rotation | before the first external consumer |
| Idempotency on writes | before any client can retry |
| Pagination on every collection | at the first unbounded list |
| Consistent error shape | before the first external consumer |
| Published schema — OpenAPI or equivalent | before the first external consumer |
| Deprecation policy | at the first breaking change |

Five of these trigger on the same event. The first external consumer is a stage line: sweep the
whole cluster at once.

## CLI or developer tool

**Pages:** conventions, deployment or release, usage guide. No SEO page.

| Need | Typical trigger |
|---|---|
| Argument and flag conventions | at the third command |
| Exit-code contract | before use in anyone's CI |
| Config file resolution order | at the first config file |
| Cross-platform path and shell handling | before a user on another OS |
| Install and upgrade path | before distribution |
| Machine-readable output mode | when anyone pipes it |

## Mobile app

**Pages:** data model, security, integrations, release, internal handbook.

| Need | Typical trigger |
|---|---|
| **Offline and sync behaviour** | load-bearing if the app is usable offline — settle in phase 3 |
| Forced-upgrade path | before the first release to real users |
| Store review requirements | before submission |
| Push notification permission flow | at the first notification |
| Crash reporting | before the first release |
| Local data encryption | before storing anything personal on device |

Forced upgrade earns its place: without it, a broken client version is permanent.

## Data pipeline or ML

**Pages:** data model, pipelines, integrations, deployment, plus lineage and evaluation.

| Need | Typical trigger |
|---|---|
| **Idempotent and replayable runs** | load-bearing — settle in phase 3 |
| Schema-change handling at the source | before depending on a source you do not own |
| Data quality gates | before anyone acts on the output |
| Lineage from output back to source | when a number is questioned |
| Evaluation set and baseline | before the first model change |
| Cost per run monitoring | before scheduled runs |
| PII handling and retention | before ingesting anything personal |

## Library, SDK, or package

**Pages:** conventions, release, public API reference.

| Need | Typical trigger |
|---|---|
| **Public surface — what is exported and therefore promised** | load-bearing — settle in phase 3 |
| Semantic versioning commitment | before the first published version |
| Changelog | before the first published version |
| Runtime and version support matrix | before publishing |
| Bundle size or dependency budget | before publishing |
| Deprecation policy | at the first breaking change |

The public surface is the whole design. Everything exported is a promise, and every promise is
expensive to withdraw.

## Internal tool

**Pages:** internal handbook, data model, security, setup. Skip SEO and public docs entirely.

| Need | Typical trigger |
|---|---|
| Auth against the company identity provider | before more than a handful of users |
| Permission model for who can act on whom | before it touches anything sensitive |
| Audit trail | before it can change customer-facing data |
| Handover doc | before the person who built it takes leave |

The last one is the failure mode specific to internal tools: they run unmaintained for years and
then break in the one week their author is unreachable.
