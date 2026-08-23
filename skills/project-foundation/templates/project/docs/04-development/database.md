> **Audience:** engineers · **Status:** current · **Owner:** agents

# Database & migrations

## On this page

- [Migration files are the source of truth](#migration-files-are-the-source-of-truth)
- [Every new table needs](#every-new-table-needs)
- [Verifying before it reaches production](#verifying-before-it-reaches-production)
- [Functions](#functions)
- [Enums](#enums)
- [Seed and reference data](#seed-and-reference-data)
- [Rolling back](#rolling-back)
- [Checklist](#checklist)

## Migration files are the source of truth

```
write SQL → {{MIGRATIONS_DIR}} → verify → commit → deploy applies it
```

A change made through a dashboard table editor exists in production and nowhere else, and the next
person reading the migrations will have an incorrect picture of the schema. The dashboard is for
looking, not for changing.

**Migrations are immutable once applied.** Timestamps order them, so never renumber or edit one that
has already run — write a new one that corrects it.

**Keep local filenames identical to what the server reports.** After applying, list the applied
migrations and confirm the local file's timestamp matches exactly. A mismatch means the next
environment replays a migration it thinks is new, or skips one it thinks it already has.

## Every new table needs

```sql
create table {{SCHEMA}}.example (
  id         {{ID_TYPE}} primary key,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table {{SCHEMA}}.example enable row level security;

create trigger set_updated_at before update on {{SCHEMA}}.example
  for each row execute function {{SCHEMA}}.handle_updated_at();

-- At least one policy. See the warning below.
create policy "..." on {{SCHEMA}}.example ...;
```

**Row-level security enabled with no policies denies everything — silently.** It surfaces as "no
rows returned", not as an error, which is a genuinely confusing hour to lose. Enable RLS and write
the policy in the same migration, every time, including on lookup tables.

## Verifying before it reaches production

{{VERIFICATION_PREAMBLE}}

In order:

1. **Apply it** and confirm it runs clean.
2. **Check the shape** — tables, columns, constraints are what you intended.
3. **Impersonate every caller.** The step that actually matters:

```sql
begin;
  set local request.jwt.claims = '{"sub":"<uuid>","role":"authenticated"}';
  select count(*) from {{SCHEMA}}.example;
rollback;
```

Run as an anonymous visitor, a normal user, a **second** normal user, a limited staff role, and an
administrator. The second user is the one that catches policies checking "is logged in" but not "is
*this* user" — the most common access-control mistake, and completely invisible when testing with a
single account.

4. **Test behaviour in a rolled-back transaction.** For anything with logic in it — a function, a
   trigger, a constraint — assert the behaviour rather than eyeballing the definition:

```sql
begin;
  create temp table test_results (name text, passed boolean) on commit drop;
  -- ... exercise the behaviour, insert pass/fail rows ...
  select * from test_results;
rollback;
```

Two traps worth knowing: some clients return only the **last** statement's result set, which is why
the assertions accumulate into a table queried once at the end; and `now()` is frozen for the whole
transaction, so ordering by a timestamp column cannot distinguish rows written moments apart — order
by a sequential id instead.

5. **Regenerate types**, then build.

## Functions

Always `create or replace`, and always repeat the **full** modifier list — it is not preserved
across a replace. Silently dropping a security modifier can break every policy that depends on it,
or reopen a privilege-escalation path, with no error at replace time.

## Enums

A newly added enum value cannot be used in the same transaction that adds it, so it needs its own
migration ahead of any that references it. Values cannot be removed or reordered. **If a set is
likely to churn, use a lookup table instead** — enums are for sets that are genuinely fixed.

## Seed and reference data

Belongs in migrations too, written to be re-runnable:

```sql
insert into {{SCHEMA}}.example (slug, name) values ('a', 'A')
on conflict (slug) do nothing;
```

## Rolling back

{{ROLLBACK_POLICY}}

For anything destructive — dropping a column, changing a type — take a backup first, and consider
whether adding a new column and migrating the data across is safer than altering in place.

## Checklist

- [ ] RLS enabled on every new table, with at least one policy in the same migration
- [ ] Write policies check the payload, not just the row being replaced
- [ ] `updated_at` trigger
- [ ] Money as integer minor units
- [ ] Foreign keys on historical references are `restrict`, not `cascade`
- [ ] Indexes on every foreign key and every column filtered or sorted on
- [ ] Verified by impersonation, including as a second ordinary user
- [ ] Behaviour asserted in a rolled-back transaction
- [ ] Local migration filename matches the applied version exactly
- [ ] Types regenerated, build passes
