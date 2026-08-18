> **Audience:** engineers · **Status:** current · **Owner:** agents

# Deployment

How code reaches users.

## The path

{{commit}} → {{...}} → {{...}} → {{production}}

**State plainly whether merging reaches production directly**, and how long it takes. This is the
fact most likely to surprise someone at the worst possible moment.

## Environments

| Environment | Branch or trigger | URL | Data |
|---|---|---|---|
| {{...}} | {{...}} | {{...}} | {{real / seeded / anonymised}} |

## What runs before it ships

| Check | Blocks the deploy | Command |
|---|---|---|
| {{...}} | {{yes / no}} | `{{...}}` |

A check that does not block is a check that will eventually be ignored. Where one is advisory on
purpose, say why.

## Migrations

{{When schema changes are applied relative to the new code going live, and what that ordering means
for a change that is not backwards compatible.}}

The ordering matters more than it looks: a migration that runs before the new code deploys must be
readable by the old code, and one that runs after must be tolerated by the new code. Anything that
cannot satisfy both is a two-deploy change, and finding that out during the deploy is expensive.

## Rolling back

- **Code:** {{how, and how long it takes}}
- **Database:** {{the policy — forward-only, restore from backup, or something else}}
- **Who can do it:** {{...}}

Rehearse this once before needing it. A rollback path nobody has run is a plan, not a capability.

## Secrets and configuration

- **Where production values live:** {{...}}
- **How to add a new one:** {{the full path, including anything that must be redeployed}}
- **Who can read them:** {{...}}

## After a deploy

{{What to check, and where. Name the dashboard or log destination.}}
