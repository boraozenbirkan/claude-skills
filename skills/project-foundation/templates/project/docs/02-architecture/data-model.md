> **Audience:** engineers · **Status:** current · **Owner:** agents

# Data model

Every table, what it means, and how it relates. Updated in the same change as any migration.

## Entities

    {{parent}} ──< {{child}} ──< {{grandchild}}
              └──< {{other child}}

{{A quick relationship sketch, so the shape is graspable before the detail.}}

## {{table_name}}

{{One sentence: what a row represents in the language of `CONTEXT.md`.}}

| Column | Type | Null | Meaning |
|---|---|---|---|
| `id` | {{...}} | no | |
| `{{col}}` | {{...}} | {{...}} | {{what it means, not what its name repeats}} |
| `created_at` | timestamptz | no | |
| `updated_at` | timestamptz | no | |

- **Keys and constraints:** {{unique constraints, checks, and what each one is preventing}}
- **Foreign keys:** `{{col}}` → `{{table}}` — `{{restrict / cascade}}`, {{why}}
- **Indexes:** {{index}} — {{the query it serves}}
- **Access:** {{who can read, who can write, and where that is enforced}}
- **Snapshotted values:** {{fields copied from elsewhere at write time, and why history must not
  move when the source changes}}

<!--
Notes worth keeping in mind while editing this page:

- The "Meaning" column earns its place only when it says something the column name does not.
  `created_at — when the row was created` is noise; `expires_at — when the invite stops working,
  not when the account lapses` is the reason someone reads this page.
- Record what a constraint prevents, not just that it exists. "unique (tenant_id, slug)" tells the
  reader nothing; "slugs are unique per tenant, so two tenants can both have /pricing" tells them
  the model.
- A snapshotted column always needs its reason written down, or someone will helpfully "normalise"
  it and quietly rewrite history.
-->

## Not yet built

Tables designed and not created. Mark `Status: pending` and name the step that will create them.

- **{{table}}** — {{what it will hold}} · planned for {{step N}}
