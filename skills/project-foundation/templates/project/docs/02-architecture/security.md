> **Audience:** engineers · **Status:** current · **Owner:** agents

# Security

Who can do what, and where that is enforced.

**Current stage:** {{prototype | demo | private beta | public | production with paying customers}}

Security at an early stage is a deliberate subset, not an oversight. What is skipped is skipped on
purpose and written into [the ledger](../00-meta/deferred-ledger.md) with a trigger. The section at
the bottom of this page lists what is currently deferred and when it comes due — read it before
assuming a control exists.

## On this page

- [Identity](#identity)
- [Roles](#roles)
- [Where enforcement lives](#where-enforcement-lives)
- [Data we hold](#data-we-hold)
- [Secrets](#secrets)
- [Verifying access rules](#verifying-access-rules)
- [Deferred, with triggers](#deferred-with-triggers)

## Identity

- **Who can log in:** {{end users, staff, both, service clients}}
- **How:** {{mechanism}}
- **Sessions:** {{lifetime, refresh, and how a session is revoked}}
- **Account recovery:** {{path, and what it proves before granting access}}

## Roles

| Role | Can | Cannot | Granted by |
|---|---|---|---|
| {{role}} | {{...}} | {{...}} | {{who or what assigns it}} |

The "cannot" column is the one that gets checked in an incident. Fill it in.

## Where enforcement lives

{{The single most important statement on this page. Name the layer that is authoritative —
database policies, a server-side middleware, a gateway — and say plainly that anything in a client
the user controls is a convenience, never a control.}}

| Resource | Rule | Enforced at |
|---|---|---|
| {{...}} | {{who may read, who may write}} | `{{where}}` |

## Data we hold

| Data | Sensitivity | Where it lives | Retention | Deletion path |
|---|---|---|---|---|
| {{...}} | {{personal / payment / health / none}} | {{...}} | {{...}} | {{how a user's copy is removed}} |

Personal data is forced from outside: the deletion path has to exist before the data does, or the
first request for it becomes an engineering project.

## Secrets

- **Where they live:** {{...}}
- **Who can read them:** {{...}}
- **Rotation:** {{the procedure, or the ledger entry that will create it}}

Keep privileged keys out of any code path a client can reach.

## Verifying access rules

{{The procedure for proving a rule works — impersonation, a test suite, a manual matrix.}}

Test as an anonymous visitor, an ordinary user, **a second ordinary user**, a limited staff role,
and an administrator. The second ordinary user is the one that catches rules checking "is logged in"
without checking "is *this* user" — the most common access-control mistake, and invisible when
testing with a single account.

## Deferred, with triggers

Pulled from [the ledger](../00-meta/deferred-ledger.md), area `security`. Keep this list in sync; it
is where someone looks to find out whether a control exists yet.

| Control | Trigger | Ledger |
|---|---|---|
| {{...}} | {{...}} | {{DL-00N}} |
