> **Audience:** engineers · **Status:** current · **Owner:** agents

# Conventions

Decisions made once so they do not get re-litigated per file. Each has a reason; if a reason stops
holding, change the rule here rather than quietly deviating in one place.

## Money

**Integer minor units** (pence, cents), in columns named `*_pence` / `*_cents`. Never floats, never
`numeric` for amounts.

`0.1 + 0.2 !== 0.3` in JavaScript, and money bugs from float arithmetic are quiet — a unit off a
total that nobody notices until the figures fail to reconcile.

Format at the edge, never in storage or in transit:

```ts
new Intl.NumberFormat("{{LOCALE}}", { style: "currency", currency: "{{CURRENCY}}" })
  .format(amount_pence / 100)
```

Keep exactly one formatting helper. Dividing by 100 anywhere else is how inconsistent rounding
enters the system.

Percentage **rates** stored as exact decimals (`numeric(5,4)` — `0.1500` = 15%), not floats.

## Identifiers

| Kind | Type | Why |
|---|---|---|
| Internal / catalog data | auto-increment integer | Small, readable in admin tooling |
| Anything user-facing or enumerable | UUID | Must not be guessable by incrementing |

If a URL exposes an ID and incrementing it reaches someone else's data, it must be a UUID **and**
an access-control check — never one or the other.

Public URLs use **slugs**, not IDs.

## Snapshotting

Records that describe a past event copy the values they depended on, rather than referencing live
rows.

This is correctness, not caching. Without it, renaming a product or correcting a price retroactively
rewrites history — what a customer ordered, what they were quoted, what they were told. Where the
data has legal or safety weight, the record must show what was true **at the time**, not what is
true now.

## Foreign keys

- `on delete restrict` for anything a historical record depends on. History must never be silently
  erased by a delete elsewhere.
- `on delete cascade` only for rows that are meaningless without their parent.
- Prefer an `is_active` flag over deleting anything with history attached.

## Naming

| Thing | Style |
|---|---|
| Tables | `snake_case`, plural |
| Join tables | Both names, singular each |
| Columns | `snake_case`; booleans `is_*` / `has_*` / `can_*`; timestamps `*_at` |
| Enums | Singular |
| Components | `PascalCase` |
| Modules / functions | `camelCase` |
| Env vars | `SCREAMING_SNAKE_CASE`; public ones explicitly prefixed |

## Where logic lives

**One rule, one home.** Pricing, eligibility, permissions, and anything that decides money or access
live in exactly one place — and that place is as close to the data as possible ({{LOGIC_LAYER}}),
never in a client the user controls.

A rule implemented in two places is a rule that will disagree with itself. When you find yourself
copying a calculation, extract it instead.

## Comments

Explain **why**, not what. A comment restating the code is noise that rots; a comment explaining a
non-obvious constraint, a rejected alternative, or a subtle ordering dependency is often the most
valuable line in the file.

## Accessibility

- Semantic HTML: real `<table>` for tabular data, real `<button>` for actions, one `<h1>` per page
- Every image has meaningful `alt`, or `alt=""` if purely decorative
- Never convey critical information by colour or icon alone — screen readers get nothing from either
- Respect `prefers-reduced-motion` for any animation
- Keyboard reachable: every interactive element, in a sensible tab order, with a visible focus state

{{PROJECT_SPECIFIC_CONVENTIONS}}
